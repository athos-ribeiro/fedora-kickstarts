# Filename:
#   fedora-livecd-sugar.ks
# Maintainers:
#   Sebastian Dziallas <sdz AT fedoraproject DOT org>

%include fedora-live-base.ks

%packages

# sugar!
@sugar-desktop

# rebranding
-fedora-release
generic-release

# display manager
slim

# language support
@albanian-support
@arabic-support
@assamese-support
@basque-support
@belarusian-support
@bengali-support
@brazilian-support
@british-support
@bulgarian-support
@catalan-support
@chinese-support
@czech-support
@danish-support
@dutch-support
@estonian-support
@finnish-support
@french-support
@galician-support
@georgian-support
@german-support
@greek-support
@gujarati-support
@hebrew-support
@hindi-support
@hungarian-support
@indonesian-support
@italian-support
@japanese-support
@kannada-support
@korean-support
@latvian-support
@lithuanian-support
@macedonian-support
@malayalam-support
@marathi-support
@nepali-support
@norwegian-support
@oriya-support
@persian-support
@polish-support
@portuguese-support
@punjabi-support
@romanian-support
@russian-support
@serbian-support
@slovak-support
@slovenian-support
@spanish-support
@swedish-support
@tamil-support
@telugu-support
@thai-support
@turkish-support
@ukrainian-support
@vietnamese-support
@welsh-support

# The following locales have less than 50% translation coverage for the core
# GNOME stack, as found at http://l10n.gnome.org/languages/

#@afrikaans-support
#@armenian-support
#@bhutanese-support
#@bosnian-support
#@breton-support
#@croatian-support
#@esperanto-support
#@ethiopic-support
#@faeroese-support
#@filipino-support
#@gaelic-support
#@icelandic-support
#@inuktitut-support
#@irish-support
#@khmer-support
#@lao-support
#@low-saxon-support
#@malay-support
#@maori-support
#@mongolian-support
#@northern-sami-support
#@northern-sotho-support
#@samoan-support
#@sinhala-support
#@somali-support
#@southern-ndebele-support
#@southern-sotho-support
#@swati-support
#@tagalog-support
#@tibetan-support
#@tonga-support
#@tsonga-support
#@tswana-support
#@urdu-support
#@venda-support
#@walloon-support
#@xhosa-support
#@zulu-support

# These fonts are only used in the commented-out locales above
-lklug-fonts
-abyssinica-fonts
-jomolhari-fonts

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-scim-tables-*
-wqy-bitmap-fonts
-dejavu-fonts-experimental
-words

# more fun with space saving
-scim-lang-chinese
-scim-python*
scim-chewing
scim-pinyin

# save some space
-yelp
-gnome-user-docs
-gimp-help
-gimp-help-browser
-evolution-help
-gnome-games
-gnome-games-help
-nss_db
-vino
-isdn4k-utils
-dasher
-evince-dvi
-evince-djvu
# not needed for gnome
-acpid

# these pull in excessive dependencies
-ekiga
-tomboy
-f-spot

# hack to deal with conditionals + multiarch blargh
-scim-bridge-gtk.i386
%end

%post
cat > /etc/sysconfig/desktop <<EOF
DISPLAYMANAGER=/usr/bin/slim-dynwm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

chkconfig --level 5 setroubleshoot off 2>/dev/null
chkconfig --level 5 sendmail off 2>/dev/null
chkconfig --level 5 bluetooth off 2>/dev/null
chkconfig --level 5 cupsd off 2>/dev/null

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null

# set up timed auto-login for after 60 seconds
cat >> /etc/slim.conf << FOE
auto_login	yes
default_user	liveuser
FOE

# setup xinitrc
echo "sugar-shell" > /home/liveuser/.xinitrc
chmod a+x /home/liveuser/.xinitrc
chown liveuser:liveuser /home/liveuser/.xinitrc

EOF

%end