
CDIR=/var/wwwtest/
mkdir -p $CDIR
cd $CDIR

[ -f installer ] && rm installer
mkdir -p bin
[ -f bin/composer ] && rm bin/composer
wget https://getcomposer.org/installer
php ./installer --install-dir=bin --filename=composer
rm installer

cd $CDIR/html
# Run composer twice because upgrade of wordpress deletes plugins and themes
$CDIR/bin/composer update
$CDIR/bin/composer update
$CDIR/bin/composer install
$CDIR/bin/composer install

# Wordpress specifics
cd $CDIR/html/public/wp
[ -L wp-config.php ] && rm wp-config.php
ln -s ../../../wp/wp-config.php wp-config.php

cd $CDIR/html/public/wp/wp-content
[ -L uploads ] && rm uploads
ln -s ../../../../wp/uploads/ uploads

# Piwik specifics
# cd $CDIR/html/public
# [ -f piwik.zip ] && rm piwik.zip
# wget http://builds.piwik.org/piwik.zip
# unzip -o piwik.zip
# rm piwik.zip

# cd $CDIR/html/public/piwik
# [ -L tmp ] && rm tmp
# [ -d $CDIR/html/public/piwik/tmp ] && rm -r $CDIR/html/public/piwik/tmp
# ln -s ../../../piwik/tmp/ tmp

# cd $CDIR/html/public/piwik/config
# [ -L config.ini.php ] && rm config.ini.php
# ln -s ../../../../piwik/config.ini.php config.ini.php

# cd $CDIR/html/public/piwik
# php console core:update

