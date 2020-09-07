A docker container for the Windows version of FXServer (FiveM/RedM).

It will always fetch the latest recommended artifact from the FiveM artifacts server.

You MUST mount a volume containing a server.cfg file and a resources folder with resources in it.

Example usage: ```docker run -it -v "C:\path\to\host\server-data:C:\server-data" chasegrn/fxserver-windows```
