: example \\stationname\sharename combinations follow:

: server queues: net use lpt1 \\aaltsysserver\laserjet ...
:              : net use lpt1 \\192.168.2.241\laserjet ...
: printeservers: net use lpt1 \\waresprinter\lpt1 ...
: workstations : net use lpt1 \\127.0.0.1\laserjet ...

@ECHO OFF
net use lpt1 /delete
@ECHO ON
net use lpt1 \\{stationname}\{sharename}
if not %errorlevel%==0 pause

@ECHO OFF
net use lpt2 /delete
@ECHO ON
net use lpt2 \\{stationname}\{sharename}
if not %errorlevel%==0 pause

@ECHO OFF
