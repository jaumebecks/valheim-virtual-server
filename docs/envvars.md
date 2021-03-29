# Environment variables

This project needs some environment variables in order to work properly.

Check each environment variable and modify it under your `.env` file accordingly.

## GATEWAY_IP
> Default value: `192.168.0.1`

This is your router's local IP. You should check which one corresponds in your setup. Some routers use different IP like `192.168.1.1`. It's normally specifyed in a badge, placed under your router

## GUEST_PASSWORD
> Default value: `vagrant`

This is the ssh password that vagrant uses for ssh into the machine.

**Important**: It is not desirable to change it on the first run. If you want to change it, the procedure should be
1. First run with default `GUEST_PASSWORD`
2. Access VM through `vagrant ssh`
3. Change vagrant's user password with `passwd`
4. Now you can change `GUEST_PASSWORD` in your .env
5. Finally, exit VM shell running `exit` and apply changes reloading the VM by running `vagrant reload`


**Do not modify it if you are not entirely sure about what you are doing**

## GUEST_IP
> Default value: `192.168.0.2`

This is the static IP your VM will use inside your LAN. Probably you need to change it to some other value if default value is already used. To do so, enter into your routers configuration and check any free IP address. I'm using `192.168.0.24` for example

**Important**: This envvar is critical to make this project work. Because, its value will be used later in order to open some ports in your router's config, so please in your router's config:
1. Choose a static IP
2. Check you can open some ports in that IP

## VALHEIM_SERVER_NAME
> Default value: `VirtualValheimServerFromJaumebecks`

This is the display name you'll see when searching for servers in Valheim :D

## VALHEIM_SERVER_WORLD
> Default value: `VirtualValheimServerFromJaumebecks`

This is the file name your server will be loaded from. This way you can display the same name in Valheim, but use different worlds. You'll find the world files under `/home/steam/.config/unity3d/IronGate/Valheim/worlds/` in your Virtual Machine.

## VALHEIM_SERVER_PASSWORD
> Default value: `changeMe1234`

This is the password your peeps will use to enter the server.

## VIRTUAL_RAM
> Default value: `8192`

This is the virtual RAM memory your Virtual machine will use. It's highly reccommended to use at least 8GB, as it is right now.

## VIRTUAL_CPUS
> Default value: `2`

This is the virtual CPUs your Virtual machine will use. It's highly reccommended to use at least 2, as it is right now.
