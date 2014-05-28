:           !IMPORTANT!
: Replace {aaltsysserver} with your server's hostname
: Replace {shared} with your public sharename (PUBLIC or SHARED)
: Replace {wares} with your program sharename (AREV or WARES)
: Look for @@EXTERNAL@@ in the backup share and your recent dates

@ECHO OFF
net use H: /delete
net use S: /delete
net use W: /delete
@ECHO ON
net use H: \\{aaltsysserver}\%username% /persistent:yes
if not errorlevel==0 pause
net use S: \\{aaltsysserver}\{shared} /persistent:yes
if not errorlevel==0 pause
net use W: \\{aaltsysserver}\{wares} /persistent:yes
if not errorlevel==0 pause
@ECHO OFF
