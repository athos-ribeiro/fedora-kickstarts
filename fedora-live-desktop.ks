# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-base.ks

%packages
@graphical-internet
@sound-and-video
@gnome-desktop
@office

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @base
-smartmontools

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=false
FOE

# Show harddisk install in shell dash
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['mozilla-firefox.desktop', 'evolution.desktop', 'empathy.desktop', 'rhythmbox.desktop', 'shotwell.desktop', 'openoffice.org-writer.desktop', 'nautilus.desktop', 'liveinst.desktop']
FOE
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf

EOF

%end
