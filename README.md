Système pour le robot de Šikula Robotik
=======================================

Qu'est-ce ?
-----------

Buildroot est un ensemble de scripts pour générer un système complet à partir des sources.
Šikula Robotik a ajusté les sources du projet pour ses propres besoins.

Ainsi, en compilant ce projet, on obtient le système complet, prêt à recevoir les applications du robot.

Compilation
-----------

make sikula_bbb_defconfig
make

Flashage
--------

Créer la carte SD :

    # Create partition table
    sfdisk /dev/mmcblk0 << EOF
    label: dos
    label-id: 0xa7c5be67
    device: /dev/mmcblk0
    unit: sectors
    
    /dev/mmcblk0p1 : start=        2048, size=       20480, type=4, bootable
    /dev/mmcblk0p2 : start=       22528, size=     3840000, type=83
    /dev/mmcblk0p3 : start=     3862528, size=     3840000, type=83
    EOF
    
    # Create DOS partition
    sudo mkfs.vfat /dev/mmcblk0p1 -n BOOT

    # Create EXT4 partition
    sudo mkfs.ext4 -L LOGS /dev/mmcblk0p3

    sync

Monter et flasher :

    sudo cp output/images/{MLO,u-boot.img,zImage,*.dtb} /media/BOOT
    
    dd if=output/images/rootfs.ext4 of=/dev/mmcblk0p2 bs=128k

    sync
