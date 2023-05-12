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

Utiliser le script (ouvrir pour voir les dépendances) :
sudo ./flash.sh /dev/sdc
