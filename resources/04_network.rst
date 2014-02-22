.. _network:

#############################
 Server Network Setup
#############################

By default, the AAltSys Server is configured to operate as an Internet gateway.
This configuration is appropriate whenever the AAltSys Server is the primary or
only server in an office, as it allows the server to provide gateway and 
security functions. Where the AAltSys Server creates a new network behind a 
cable modem or DSL line which includes a DHCP service, the server can be 
installed with no configuration changes.

The AAltSys Server uses two network interfaces, eth0 and eth1. The external 
interface, eth0, connects to a Wide Area Network (WAN) gateway or the Internet
and obtains its external IP address and DNS gateway information from a DHCP
server on the WAN gateway. On the other interface, port eth1 is preset to static
IP address 192.168.2.241, and the server provides DHCP and DNS services to local
network clients.

Installing an AAltSys server within an existing network requires changing the 
configuration of one or both of the server network interfaces.

.. warning:: 
   Changes to network configuration should be performed only when no users are 
   active. User network connections will be interrupted when the configuration 
   is saved.

Static IP
=============================

eth0 IP should be static when
-----------------------------

*  The WAN gateway does not provide DHCP
*  DHCP results from the WAN gateway do not permit the server to access the 
   Internet
*  The server has a public IP for eth0 assigned by the ISP
*  A local subnet is connected to the server on eth0, and eth1 is not used

Change IP from DHCP to static
-----------------------------

*  Connect a network switch to eth1 and plug a workstation into the switch.
*  Set the workstation to obtain its address automatically, i.e., through DHCP.
*  Use commands :command:`ipconfig /release` and :command:`ipconfig /renew`, 
   or else reboot the workstation to obtain an address.
*  Open the workstation web browser, and enter one of the following addresses::

      https://aaltsysserver
      https://192.168.2.241
  
*  Login to Zentyal (eBox) using an administrator name and password.

*  Select :menuselection:`Core --> Network --> Interfaces` from the left side 
   menu.
 
   #. On the :guilabel:`eth0` tab:
   #. Change Method to :kbd:`Static`
   #. Enter your static IP address in :kbd:`IP Address`
   #. Select your subnet mask in :kbd:`Netmask` (255.255.255.0 or similar)
   #. Click :kbd:`Change`
 
*  Navigate to :menuselection:`Core --> Network --> Gateways`.
 
   #. Select :guilabel:`(+) Add New`
   #. Enter a descriptive name
   #. In IP Address, enter the WAN router gateway address
   #. Select eth0 in :guilabel:`Interface`
   #. Check the :kbd:`Default` box
   #. Click :kbd:`Add`
 
*  Click :kbd:`Save Changes` in the Zentyal title bar, and then :kbd:`Save`.
  
Dynamic IP (DHCP)
=============================

Change IP from static to DHCP
-----------------------------

*  Connect a workstation to the server through a switch on eth1.
*  Obtain an IP address for the workstation using DHCP.
*  Open your web browser, and enter one of the following addresses::

      https://aaltsysserver/
      https://192.168.2.241/
  
*  Login to Zentyal using an administrator name and password.
*  Navigate to :menuselection:`Core --> Network --> Gateways`. 

   *  Click :kbd:`Delete` (Trash Can) next to the gateway entry

*  Navigate to :menuselection:`Core --> Network --> Interfaces --> eth0`.

   *  Change :guilabel:`Method` to :kbd:`DHCP`
   *  Click :kbd:`Change`

*  Click :guilabel:`Save Changes` on the Zentyal title bar, and then click 
   :kbd:`Save`.
 
Set Static Gateway with DHCP
-----------------------------

.. sidebar:: Programming fix, Zentyal 1.5--2.0.
   To allow a static gateway setting when eth0 uses DHCP:

      *  Open a console on the server
      *  Login ``__Administrator__``, ``__Password__``.
      *  Enter the command::

            sudo nano -w /usr/share/perl5/EBox/Network/Model/GatewayTable.pm
  
      *  Press :kbd:`Ctrl-w`, search for ``gatewayReachable``.
      *  Comment the line, adding ``#`` in front::

            # $network->gatewayReachable($params{'ip'}, 'LaunchException');
  
      *  Press :kbd:`Ctrl-x` to exit and save.
  
*  Login to Zentyal at a workstation or the server.
*  Fix Zentyal 1.5 through 2.0 as per the sidebar.
*  Navigate to :menuselection:`Core --> Network --> Gateways`.
*  Click :guilabel:`(+) Add` next to the gateway entry:

   *  Enter the gateway IP address
   *  Select Interface :kbd:`eth0`
   *  Check the box for :kbd:`Default`

*  :guilabel:`Save Changes` in the Zentyal title bar, and click :kbd:`Save`.
  
Console Networking Commands
=============================

Use the following commands from a login at the server console or through ssh to 
check the server's network configuration.

ifconfig
-----------------------------

Use the :command:`ifconfig` command to display IP settings for the server's 
devices::

   ifconfig eth0 
   ifconfig eth1 

* **eth0** settings should be either obtained through DHCP or set statically
* **eth1** should be set to 192.168.2.241

ping
-----------------------------

Use this command to test network connectivity::

   ping 192.168.2.241
   ping (IP for eth0)
   ping (IP for Gateway)
   ping (IP for DNS)
   ping www.google.com

ip
-----------------------------

Use :command:`ip` to display network configuration, for instance::

   ip route ls table default

(Should return "default via 123.456.789.012 dev eth0," or other gateway ip)

dhclient
-----------------------------

Use this command to obtain an ip and identify the gateway::

   sudo dhclient eth0

route
-----------------------------

Use this command to set a gateway to the Internet::

   sudo route add default gw 123.456.789.012

dig
-----------------------------

Use :command:`dig` to find DNS name servers::

   dig 192.168.1.254
   dig comcast.net

nslookup
-----------------------------

Use :command:`nslookup` to find results returned from DNS servers::

   nslookup aaltsys.info
   nslookup -query=hinfo fb.com

eBox
-----------------------------

Use this command only when no workstations are logged in::

   sudo invoke-rc.d ebox restart
