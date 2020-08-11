# Variables

TEMPWORKDIR=whitesur
GITKDETHEMEREPO=https://github.com/vinceliuice/WhiteSur-kde.git
GITKDEPACKAGE=WhiteSur-kde
BASEDIR=~/$TEMPWORKDIR
GITGTKTHEMEREPO=https://github.com/vinceliuice/WhiteSur-gtk-theme.git
THEME=com.github.vinceliuice.WhiteSur-dark
GITGTKPACKAGE=WhiteSur-gtk-theme
FONTSREPO=https://github.com/AppleDesignResources/SanFranciscoFont.git
GITFONTSPACKAGE=SanFranciscoFont
LOCALFONTDIR=~/.local/share/fonts

# Update system

yes | LC_ALL=en_US.UTF-8 pacman -Syyu

# Install newest non-experimental kernel

yes | LC_ALL=en_US.UTF-8 sudo mhwd-kernel -i linux57

# Enable AUR 

sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Enable AUR package updates

sudo sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"

# Install latte-dock-git

LC_ALL=en_US.UTF-8 pamac build latte-dock-git --no-confirm

# Create and enter temporary working directory

mkdir $TEMPWORKDIR
cd $TEMPWORKDIR

# Fetch files from GitHub

git clone $GITKDETHEMEREPO

# Enter the downloaded folder

cd $GITKDEPACKAGE

# Make install script executable

chmod +x install.sh

# Run install script

./install.sh

# Change theme

lookandfeeltool -a $THEME

# Install GTK theme dependencies

sudo pacman -S gtk-engine-murrine gtk-engines
sudo pacman -S sassc optipng inkscape

# Go back to base dir 

cd $BASEDIR

# Fetch files from GitHub

git clone $GITGTKTHEMEREPO

# Enter downloaded directory

cd $GITGTKPACKAGE

# Make install script executable

chmod +x install.sh

# Run install script

./install.sh

# Backup GTK settings

cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini-bck

# Change GTK3 theme

sed -i "s/gtk-theme-name=Breath/gtk-theme-name=WhiteSur-dark/g" ~/.config/gtk-3.0/settings.ini

# Change GTK2 theme

sed -i 's/gtk-theme-name="Breath"/gtk-theme-name="WhiteSur-dark"/' ~/.gtkrc-2.0

# Return to base directory

cd $BASEDIR

# Get fonts

git clone $FONTSREPO

# Create local font directory

mkdir $LOCALFONTDIR

# Install fonts locally

cp -r $GITFONTSPACKAGE $LOCALFONTDIR

# Call Python script to easily handle KDE settings and end run of bash script
# See file for details

chmod +x configure.py
python3 configure.py