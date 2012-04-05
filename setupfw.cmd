ECHO ---------------------------------------------------------------- >> log.txt 2>> err.txt
ECHO Install firewall rules %date% %time%					>> log.txt 2>> err.txt
ECHO ---------------------------------------------------------------- >> log.txt 2>> err.txt
SET PACKAGE_KEY=FIREWALL

REM ------------------------------------------------------------
REM NOTE: THIS is a Slightly different key so it doesn't conflict with generic package routine
set DONEFLAG=D:\%PACKAGE_KEY%_INSTALL.txt
REM ----------------------------------------------------
REM Check to see if we've already done this so we don't do it again
REM DO IT EVERY TIME AS IT SEEMS THIS GETS UNDO ON REBOOT. DRB 09/02/11
REM ----------------------------------------------------
rem if exist %DONEFLAG% (
rem echo %PACKAGE_KEY% SETUP DONE FLAG ' %DONEFLAG%' SET ! >> log.txt 2>> err.txt
rem  GOTO :END
rem )


REM ------------------------------------------------------
REM Set the done flag so we don't do this again on reboot
REM -----------------------------------------------------
ECHO %PACKAGE_KEY% setup Starting at %date% %time% >> %DONEFLAG%


netsh advfirewall firewall add rule name="RPC" dir=in action=allow service=any enable=yes profile=any localport=rpc protocol=tcp
netsh advfirewall firewall add rule name="RPC-EP" dir=in action=allow service=any enable=yes profile=any localport=rpc-epmap protocol=tcp

netsh advfirewall firewall add rule name="Port 135 TCP" dir=in action=allow service=any enable=yes profile=any localport=135 protocol=tcp
netsh advfirewall firewall add rule name="Port 135 UDP" dir=in action=allow service=any enable=yes profile=any localport=135 protocol=udp
netsh advfirewall firewall add rule name="Port 136 TCP" dir=in action=allow service=any enable=yes profile=any localport=136 protocol=tcp
netsh advfirewall firewall add rule name="Port 136 UDP" dir=in action=allow service=any enable=yes profile=any localport=136 protocol=udp
netsh advfirewall firewall add rule name="Port 137 TCP" dir=in action=allow service=any enable=yes profile=any localport=137 protocol=tcp
netsh advfirewall firewall add rule name="Port 137 UDP" dir=in action=allow service=any enable=yes profile=any localport=137 protocol=udp
netsh advfirewall firewall add rule name="Port 138 TCP" dir=in action=allow service=any enable=yes profile=any localport=138 protocol=tcp
netsh advfirewall firewall add rule name="Port 138 UDP" dir=in action=allow service=any enable=yes profile=any localport=138 protocol=udp
netsh advfirewall firewall add rule name="Port 139 TCP" dir=in action=allow service=any enable=yes profile=any localport=139 protocol=tcp
netsh advfirewall firewall add rule name="Port 139 UDP" dir=in action=allow service=any enable=yes profile=any localport=139 protocol=udp

netsh advfirewall firewall add rule name="Port 445 TCP" dir=in action=allow service=any enable=yes profile=any localport=445 protocol=tcp
netsh advfirewall firewall add rule name="Port 445 UDP" dir=in action=allow service=any enable=yes profile=any localport=445 protocol=udp

netsh advfirewall firewall add rule name="Port 6901 TCP" dir=in action=allow service=any enable=yes profile=any localport=6901 protocol=tcp
netsh advfirewall firewall add rule name="Port 6901 UDP" dir=in action=allow service=any enable=yes profile=any localport=6901 protocol=udp

netsh advfirewall firewall add rule name="Port 6910 TCP" dir=in action=allow service=any enable=yes profile=any localport=6910 protocol=tcp
netsh advfirewall firewall add rule name="Port 6910 UDP" dir=in action=allow service=any enable=yes profile=any localport=6910 protocol=udp

REM =================================================================================
REM Test Agent Download Service
REM =================================================================================

netsh advfirewall firewall add rule name="Port 80 TCP" dir=in action=allow service=any enable=yes profile=any localport=80 protocol=tcp
netsh advfirewall firewall add rule name="Port 80 UDP" dir=in action=allow service=any enable=yes profile=any localport=80 protocol=udp

REM =================================================================================
REM OPEN UP SQL PORTS
REM =================================================================================
netsh advfirewall firewall add rule name="Port 1433 TCP" dir=in action=allow service=any enable=yes profile=any localport=1433 protocol=tcp
netsh advfirewall firewall add rule name="Port 1433 UDP" dir=in action=allow service=any enable=yes profile=any localport=1433 protocol=udp

netsh advfirewall firewall add rule name="Port 1434 TCP" dir=in action=allow service=any enable=yes profile=any localport=1434 protocol=tcp
netsh advfirewall firewall add rule name="Port 1434 UDP" dir=in action=allow service=any enable=yes profile=any localport=1434 protocol=udp

REM =================================================================================
rem allow pings
REM =================================================================================
netsh advfirewall firewall add rule name="ICMPv6" dir=in action=allow enable=yes protocol=icmpv6
rem netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" dir=in action=allow protocol=icmpv4:8,any 
rem netsh advfirewall firewall add rule name="All ICMP V4" protocol=icmpv4:any,any dir=in action=allow

REM =================================================================================
REM FILE and Print
REM =================================================================================
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

REM =================================================================================
REM =================================================================================
REM TURN OFF IE ESC
REM REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f  
REM REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f 

REM =================================================================================
REM =================================================================================

:END
ECHO ---------------------------------------------------------------- >> log.txt 2>> err.txt
ECHO Finished   %PACKAGE_KEY%  %date% %time%			  >> log.txt 2>> err.txt
ECHO ---------------------------------------------------------------- >> log.txt 2>> err.txt
REM *******************************************************
rem without the exit 0, Azure will keep retrying the job
REM *******************************************************
exit 0

