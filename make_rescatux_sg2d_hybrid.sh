#!/bin/bash

# SG2 STUFF
SG2D_SOURCE_DIRECTORY="../../sgd/git/supergrub/"
RESCATUX_SOURCE_PWD=`pwd`
BOOT_ISOS_DIRECTORY="boot-isos"
ORIGINAL_GRUB_CFG_BACKUP="original_grub_cfg_backup.cfg"
# RESCATUX STUFF
# Fetch version from folder directory name
VERSION=`head -1 VERSION`
ARCH="i386"
RESCATUX_STR="rescatux"
MEDIA_STR="cdrom_usb_hybrid"
LINUX_FLAVOURS="486 amd64"
RESCATUX_MEDIA_STR="${RESCATUX_STR}_${MEDIA_STR}"
FILE_EXTENSION="iso"
BASE_FILENAME="${RESCATUX_MEDIA_STR}_${ARCH}_`echo ${LINUX_FLAVOURS} | sed s/' '/'-'/g`_`head -n 1 VERSION`"

ORIGINAL_RESCATUX_ISO="${BASE_FILENAME}.${FILE_EXTENSION}"
SG2D_RESCATUX_ISO=${BASE_FILENAME}_sg2d.${FILE_EXTENSION}

cd ${SG2D_SOURCE_DIRECTORY}
if [ -e ${BOOT_ISOS_DIRECTORY}/${ORIGINAL_RESCATUX_ISO} ] ; then
  rm ${BOOT_ISOS_DIRECTORY}/${ORIGINAL_RESCATUX_ISO}
fi

if [ ! -d ${BOOT_ISOS_DIRECTORY} ] ; then
  mkdir ${BOOT_ISOS_DIRECTORY}
fi
cd ${BOOT_ISOS_DIRECTORY}
cp ${RESCATUX_SOURCE_PWD}/${ORIGINAL_RESCATUX_ISO} \
${ORIGINAL_RESCATUX_ISO}
cd ..
cp menus/grub.cfg ${ORIGINAL_GRUB_CFG_BACKUP}
sed -e "s/RESCATUX_ISO_TO_REPLACE/${ORIGINAL_RESCATUX_ISO}/g" ${RESCATUX_SOURCE_PWD}/rescatux_grub.cfg > menus/grub.cfg
./supergrub-mkrescue -o=${RESCATUX_SOURCE_PWD}/${SG2D_RESCATUX_ISO}
cp ${ORIGINAL_GRUB_CFG_BACKUP} menus/grub.cfg
rm ${BOOT_ISOS_DIRECTORY}/${ORIGINAL_RESCATUX_ISO}
