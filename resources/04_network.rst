.. _network:

#############################
 Server Network Setup
#############################

Network interfaces are assigned to either internal LAN or external WAN gateway 
roles, and they are configured either by DHCP or through static settings. The 
AAltsys Server uses either one or two network interfaces, with assigned roles 
and configuration settings based on interface connections. The first, or primary 
network interface on a system is assigned to device ``eth0``, and an additional, 
or secondary interface will be ``eth1``.

Servers with two interfaces may act as gateway computers, routing traffic
between an external WAN or the Internet and a local network or LAN. Servers with 
only one network interface can only act as peers on a LAN. WAN connections are 
preferrably configured using DHCP, while LAN connections need to be statically 
set. By convention, gateway connections use the primary interface and local 
connections use the secondary interface on gateway computers.

This set of conventions allows us to describe how network interfaces should be 
configured in general, as shown in the following table:

+--------------------------------------+-+--------------------------------------+
| Gateway Server                       | | Local Peer Server                    |
+======================================+=+======================================+
| **Primary Interface** device *eth0*  | | **Primary Interface** device *eth0*  | 
+--------------------------------------+-+--------------------------------------+
+--------------------------------------+-+--------------------------------------+
| **Connection** External *WAN*        | | **Connection** Internal *LAN*        |
+--------------------------------------+-+--------------------------------------+
| **Configuration** set using *DHCP*   | | **Configuration** set using *Static* |
+--------------------------------------+-+--------------------------------------+
|                                      | | IP address --> *nnn.nnn.nnn.nnn*     |
+--------------------------------------+-+--------------------------------------+
|                                      | | Netmask --> *255.nnn.nnn.0*          |
+--------------------------------------+-+--------------------------------------+
|                                      | | Gateway --> *nnn.nnn.nnn.nnn*        |
+--------------------------------------+-+--------------------------------------+
|                                      | | DNS server1 --> *8.8.8.8*            |
+--------------------------------------+-+--------------------------------------+
|                                      | | DNS server2 --> *8.8.4.4*            |
+--------------------------------------+-+--------------------------------------+
+--------------------------------------+-+--------------------------------------+
| **Secondary Interface** device *eth1*| | (Missing or unconfigured)            |
+--------------------------------------+-+--------------------------------------+
+--------------------------------------+-+--------------------------------------+
| **Connection** Internal *LAN*        | |                                      |
+--------------------------------------+-+--------------------------------------+
| **Configuration** set *Static*       | |                                      |
+--------------------------------------+-+--------------------------------------+
| IP address --> *192.168.2.241*       | |                                      |
+--------------------------------------+-+--------------------------------------+
| Netmask --> *255.255.255.0*          | |                                      |
+--------------------------------------+-+--------------------------------------+
| Gateway --> *(assigned eth0)*        | |                                      |
+--------------------------------------+-+--------------------------------------+
| DNS servers --> *(assigned eth0)*    | |                                      |
+--------------------------------------+-+--------------------------------------+

Connecting Interfaces
=============================

If two Ethernet adapters are used: connect the primary interface to an Internet 
gateway such as a cable or DSL modem, and connect the secondary interface to a 
local area network (LAN) switch which connects workstations and printers. 

If one Ethernet adapter is used: connect the primary interface to a local area 
network (LAN) switch which connects workstations and printers. Connect a router 
between the LAN switch and an Internet gateway.

The AAltsys Server
=============================

The AAltSys Server is configured to operate as an Internet gateway by default, 
as this allows the server to provide gateway and security functions. Where the 
server creates a new network behind a cable modem or DSL line which includes a 
DHCP service, the server can be installed with no configuration changes.

Installing an AAltSys server within an existing network requires changing the 
configuration of both of the server network interfaces. The primary interface 
must be changed from *External* to *Internal* and from set via *DHCP* to set 
*Static*. The secondary interface must be disabled.

.. warning:: 
   Changes to network configuration in a server should be performed only when 
   no users are active. User network connections will be interrupted when the 
   configuration is saved.

Zentyal Module Configuration
=============================

The Zentyal installer asks about network interface configuration in two steps. 
First check the :guilabel:`Configure interface types` radio buttons according to 
your server type, and then click :guilabel:`Next`:

+--------------------------------------+-+--------------------------------------+
| NETWORK GATEWAY SERVER               | | LAN PEER SERVER                      |
+======================================+=+======================================+
| **Configure Interface Types:**       | | **Configure Interface types:**       |
+--------------------------------------+-+--------------------------------------+
| eth0 --> ``External``                | | eth0 --> ``Internal``                |
+--------------------------------------+-+--------------------------------------+
| eth1 --> ``Internal``                | |                                      |
+--------------------------------------+-+--------------------------------------+

Next configure the network internal and external interfaces according to the 
server function. During initial setup, use DHCP to configure network interfaces 
for a LAN peer server.

+--------------------------------------+-+--------------------------------------+
| NETWORK GATEWAY SERVER               | | LAN PEER SERVER                      |
+======================================+=+======================================+
| **Configure network for external...**| |                                      |
+--------------------------------------+-+--------------------------------------+
| eth0 --> ``DHCP``                    | |                                      |
+--------------------------------------+-+--------------------------------------+
+--------------------------------------+-+--------------------------------------+
| **Configure network for internal...**| | **Configure network for internal...**|
+--------------------------------------+-+--------------------------------------+
| eth0 --> ``Static``                  | | eth0 --> ``DHCP``                    |
+--------------------------------------+-+--------------------------------------+
| IP address --> ``192.1658.2.241``    | |                                      |
+--------------------------------------+-+--------------------------------------+
| Netmask --> ``255.255.255.0``        | |                                      |
+--------------------------------------+-+--------------------------------------+

.. note::
   Existing LANs may use differing internal IP ranges and settings. When 
   integrating a server into an existing LAN, the IP settings for the server 
   must be changed on site. Initial ethernet settings for LAN peer servers, set 
   by *DHCP*, must be changed to *Static* during module configuration and then 
   reset to match local LAN requirements.

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
