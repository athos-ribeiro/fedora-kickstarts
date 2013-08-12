# fedora-design-suite.ks
# Based on Live Desktop
# Description:
# - A Spin targeted towards professional designers
# Website: http://fedoraproject.org/wiki/Design_Suite
# Maintainers:
# - Luya Tshimbalanga <sdz AT fedoraproject DOT org>
# - Previous maintainer Sebastian Dziallas

%include fedora-live-desktop.ks

#DVD size partition
part / --size 8192

%packages

# graphics
blender
bluefish 
#cinepaint
cmyktool
darktable
dia
entangle
fontforge
font-manager 
gimp
gimp-*-plugin
gimp-data-extras
gimp-high-pass-filter
gimp-normalmap
gimp-resynthesizer
gpick
GREYCstoration-gimp 
hugin 
mypaint
inkscape
nautilus-image-converter
optipng
scribus
colord-extra-profiles 
synfigstudio
# ufraw # dropped as duplicate of darktable
xournal

# office
pdfshuffler  

# internet
filezilla

# audio & video
audacity
pitivi

# system
# gtk-recordmydesktop # dropped for space (#887991)
# network-manager-applet #part of Gnome Desktop

# fonts
aajohan-comfortaa-fonts
adobe-source-sans-pro-fonts
campivisivi-titillium-fonts
lato-fonts
overpass-fonts

# removal of duplicated and unneeded applications
-gnome-boxes
-eog

# Legacy cmdline things we don't want
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-telnet
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

%end

%post
#Override the favorite desktop application in Dash
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'shotwell.desktop', 'gimp.desktop', 'inkscape.desktop', 'blender.desktop', 'libreoffice-writer.desktop', 'scribus.desktop', 'nautilus.desktop', 'bijiben.desktop', 'anaconda.desktop']
#Enable categories in Gnome Shell
app-folder-categories=['Utilities', 'Others', 'System Settings', 'Sundry', 'Graphics', 'Games', 'Office', 'Multimedia', 'Network', 'Internet']
FOE

# Add link to the Inkscape Course
cat >> /usr/share/applications/inkscape-course.desktop << FOE
[Desktop Entry]
Name=Introduction To Inkscape
GenericName=Inkscape Course
Comment=Materials from Máirín Duffy's Inkscape Class
Exec=xdg-open http://linuxgrrl.com/learn/Introduction_To_Inkscape
Type=Application
Icon=fedora-logo-icon
Categories=Graphics;Documentation;
FOE
chmod a+x /usr/share/applications/inkscape-course.desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

EOF

%end

