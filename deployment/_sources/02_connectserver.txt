.. _connectserver:

#############################
Mac mini Server Connections
#############################

.. image:: _images/macmini_MD389LLA.png

The connector side of the Mac mini Server is illustrated above. Plug up cable 
connectors as follows:

+------------------+--------------------+--------------------------------------+
| Connector        | Cable              | Provided                             |
+==================+====================+======================================+
| Power supply     | white power cable  | Special power cable included         |
+------------------+--------------------+--------------------------------------+
| Gigabit Ethernet | Ethernet to LAN    |                                      |
+------------------+--------------------+--------------------------------------+
| Firewire         | (unconnected)      |                                      |
+------------------+--------------------+--------------------------------------+
| HDMI             | HDMI to monitor    | HDMI-to-DVI converter included       |
+------------------+--------------------+--------------------------------------+
| Thunderbolt      | Ethernet to WAN    | Thunderbolt-to-Ethernet adapter      |
+------------------+--------------------+--------------------------------------+
| USB 3.0          | USB backup device  | MyPassport 1 Tb external drive       |
+------------------+--------------------+--------------------------------------+
| USB 3.0          | USB Keyboard       |                                      |
+------------------+--------------------+--------------------------------------+ 
| USB 3.0          | USB Mouse          |                                      |
+------------------+--------------------+--------------------------------------+ 

AALtsys Technology servers which use the Zentyal operating system on Apple 
server hardware may be installed and managed "headless," meaning that the 
monitor, keyboard, and mouse are not required. If compatible console devices are
not available at a site, then a computer on the LAN can manage the server from 
the browser once the server is connected and powered up.

Manage the server from a LAN workstation as follows:

#. Connect the network as described above, then power up the server.
#. Restart a LAN computer, obtaining IP and DNS automatically through DHCP.
#. Launch either Chrome or Firefox browser. Internet Explorer will not work.
#. Enter address https://192.168.2.241 in the browser. Accept the server's 
   self-signed certificate.
#. Login to the server management program using the provided credentials.
