# My Linux Config
**Config files for polybar and Openbox litght linux. **

**Zentile is used for tiling. **

https://github.com/blrsn/zentile


Openbox is installed by script from https://github.com/leomarcov/debian-openbox.**

**Polywins script is used for taskbar part of polybar.** https://github.com/uniquepointer/polywins

**Font setup for polybar icons:**

mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

unzip JetBrainsMono.zip -d JetBrainsMono

fc-cache -fv

fc-list | grep -i "nerd”


**Openbox themes**
https://github.com/archcraft-os/archcraft-openbox-themes
