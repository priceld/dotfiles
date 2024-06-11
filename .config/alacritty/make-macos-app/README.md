This is a simple script to transform the alacritty binary into a standalone
MacOS application bundle.

I followed this SO answer to know how to create the bundle:
https://stackoverflow.com/a/49682784/23693302

## Why?

For some reason, when I tried to install the latest version of Alacritty by
downloading the package from the official website, when I launched the app,
MacOS refused to start it because it could not check it for malicious software.
I'm pretty sure this is something my organization's IT department has set up,
so instead, I just installed the app via cargo and then created the bundle
so I can have it in my dock.

This would also be useful if you built Alacritty from source.
