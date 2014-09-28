#!/bin/sh

if [ `hostname` != robot ]
then
	echo This script is supposed to be executed on robot !
	echo Please change system hostname to execute this script
	exit 1
fi

if [ _$USER != _root ]
then
	echo Should be root !
	exit 1
fi

if [ 1$SIKULA_INSTALL_SCRIPT -lt 11 ]
then
	for i in `ls ./sikula_install_*`
	do
		if [ -x $i ]
		then
			$i
		fi
	done
fi
