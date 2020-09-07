FROM mcr.microsoft.com/windows:2004-amd64
SHELL ["powershell.exe", "-Command"]
# Fetch latest FXServer and base resources, and VC 2019 redist.
RUN curl https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/ -o tmp.txt
RUN [regex]$rx = '(?<=\"\.\/)(.*?)(?=\")'; $contents = gc tmp.txt; $latest = $rx.match($contents).groups[0].value;\
curl https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/$latest -o server.zip;
RUN curl https://aka.ms/vs/16/release/VC_redist.x64.exe -o VC_redist.x64.exe;
RUN Expand-Archive .\server.zip -DestinationPath .\server 
#Install VC Redist
SHELL ["cmd", "/S", "/C" ]
RUN VC_redist.x64.exe /install /quiet /norestart
WORKDIR C:\\server-data

EXPOSE 30120/tcp 30120/udp
# For some reason FXServer will exit from cmd.exe, so we switch to powershell.
SHELL ["powershell.exe", "-Command"]
ENTRYPOINT "..\server\FXServer.exe" "+exec" "server.cfg"