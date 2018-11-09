################################################################################
#
# qt5webglplugin
#
################################################################################

QT5WEBGLPLUGIN_VERSION = $(QT5_VERSION)
QT5WEBGLPLUGIN_SITE = $(QT5_SITE)
QT5WEBGLPLUGIN_SOURCE = qtwebglplugin-$(QT5_SOURCE_TARBALL_PREFIX)-$(QT5WEBGLPLUGIN_VERSION).tar.xz
QT5WEBGLPLUGIN_DEPENDENCIES = qt5base qt5websockets
QT5WEBGLPLUGIN_INSTALL_STAGING = YES
QT5WEBGLPLUGIN_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5WEBGLPLUGIN_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL

define QT5WEBGLPLUGIN_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5WEBGLPLUGIN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WEBGLPLUGIN_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

ifeq ($(BR2_STATIC_LIBS),)
define QT5WEBGLPLUGIN_INSTALL_TARGET_LIBS
	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/platforms/libqwebgl.so $(TARGET_DIR)/usr/lib/qt/plugins/platforms/
endef
endif

define QT5WEBGLPLUGIN_INSTALL_TARGET_CMDS
	$(QT5WEBGLPLUGIN_INSTALL_TARGET_LIBS)
endef

$(eval $(generic-package))
