###################################################################################
##                                                                               ##
##                                  AutoSur                                      ##
##                          (c) 2020 Armand Bozsik                               ##
##                                                                               ##
##          A Manjaro Linux post-install script to create the best               ##
##          desktop experience ever!                                             ##
##                                                                               ##
##          The following script is automatized (where it is possible).          ##
##          If necessary - for elevated privileges - you will be asked           ##
##          for your password through the built-in authorization layer           ##
##          of the system!                                                       ##
##                                                                               ##
###################################################################################

###################################################################################
#                                                                                 #
#                          W O R K  I N  P R O G R E S S                          #
#                                                                                 #
###################################################################################

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
GITICONREPO=https://github.com/vinceliuice/WhiteSur-icon-theme.git
GITICONPACKAGE=WhiteSur-icon-theme

################################ 1. ###############################################
# Update system

yes | LC_ALL=en_US.UTF-8 pacman -Syyu
################################ 1. ###############################################


################################ 2. ###############################################
# Install newest non-experimental kernel

yes | LC_ALL=en_US.UTF-8 sudo mhwd-kernel -i linux57
################################ 2. ###############################################


################################ 3. ###############################################
# Enable AUR 

sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"
################################ 3. ###############################################


################################ 4. ###############################################
# Enable AUR package updates

sudo sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"
################################ 4. ###############################################


################################ 5. ###############################################
# Install latte-dock-git

LC_ALL=en_US.UTF-8 pamac build latte-dock-git --no-confirm
################################ 5. ###############################################


################################ 6. ###############################################
# Install the additional language packages

# WIP
################################ 6. ###############################################


################################ 7. ###############################################
# Set user profile icon 

# WIP
################################ 7. ###############################################


################################ 8. ###############################################
# Install KDE theme
#
# Create and enter temporary working directory

mkdir $TEMPWORKDIR
cd $TEMPWORKDIR

# Clone files from GitHub

git clone $GITKDETHEMEREPO

# Enter the downloaded folder

cd $GITKDEPACKAGE

# Make install script executable

chmod +x install.sh

# Run install script

./install.sh

# Change theme

lookandfeeltool -a $THEME

################################ 8. ###############################################


################################ 9. ###############################################
# Install GTK theme
#
# Install GTK theme dependencies

sudo pacman -S gtk-engine-murrine gtk-engines
sudo pacman -S sassc optipng inkscape

# Go back to base dir 

cd $BASEDIR

# Clone files from GitHub

git clone $GITGTKTHEMEREPO

# Enter downloaded directory

cd $GITGTKPACKAGE

# Make install script executable

chmod +x install.sh

# Run install script

./install.sh

# Backup GTK3 settings

cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini-bck

# Change GTK3 theme

sed -i "s/gtk-theme-name=Breath/gtk-theme-name=WhiteSur-dark/g" ~/.config/gtk-3.0/settings.ini

# Backup GTK2 settings

cp ~/.gtkrc-2.0 ~/.gtkrc-2.0-bck

# Change GTK2 theme

sed -i 's/gtk-theme-name="Breath"/gtk-theme-name="WhiteSur-dark"/' ~/.gtkrc-2.0


################################ 9. ###############################################


################################ 10. ##############################################
#
# Install fonts (WIP: apply!)

# Return to base directory

cd $BASEDIR

# Get fonts

git clone $FONTSREPO

# Create local font directory

mkdir $LOCALFONTDIR

# Install fonts locally

cp -r $GITFONTSPACKAGE $LOCALFONTDIR

################################ 10. ##############################################


################################ 11. ##############################################
#
# Install the icons

# Go back to base dir 

cd $BASEDIR

# Get the icons

git clone $GITICONREPO

# Enter downloaded directory

cd $GITICONPACKAGE

# Make install script executable

chmod +x install.sh

# Run install script

./install.sh

################################ 11. ##############################################


################################ 11. ##############################################
#
# Install cursor

# Go back to base dir 

cd $BASEDIR



################################ 11. ##############################################

















# Backup yakuake autostart desktop file

cp ~/.config/autostart/org.kde.yakuake.desktop ~/.config/autostart/org.kde.yakuake.desktop-bck

# Remove yakuake autostart desktop file

rm ~/.config/autostart/org.kde.yakuake.desktop

# Return to base directory

cd $BASEDIR


























