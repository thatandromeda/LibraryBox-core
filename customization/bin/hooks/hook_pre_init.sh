#!/bin/sh

# Setting up a few things during BootUp.
#    - Enable content folder on /opt/piratebox/share/content
#    - Swap WWW folder with LibraryBox ones
#    

# Hook for modifcation stuff before 
#          piratebox/bin/install  ... part2 
# is run.

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 255
fi

#Load config
. $1

# You can uncommend this line to see when hook is starting:
 echo "------------------ Running $0 ------------------"


## Exchange WWWW
echo "Doing www folder exchange..."
mv    $WWW_FOLDER $PIRATEBOX_FOLDER/www_old
mv    $PIRATEBOX_FOLDER/www_librarybox $WWW_FOLDER
cp -rv  $PIRATEBOX_FOLDER/www_old/cgi-bin $WWW_FOLDER/cgi-bin

# Prepare content folder
echo "Creating 'content' folder on USB stick and move over stuff"
mkdir -p $WWW_CONTENT
cp -r     $PIRATEBOX_FOLDER/www_content/*   $WWW_CONTENT
# Link to the USB-Stick
ln -s $WWW_CONTENT  $WWW_FOLDER/content

$PIRATEBOX_FOLDER/bin/ftp_enable.sh generate

