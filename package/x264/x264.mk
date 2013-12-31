###############################################################
#
# x264
#
###############################################################

X264_VERSION = 20140111-2245-stable
X264_SOURCE = x264-snapshot-$(X264_VERSION).tar.bz2
X264_SITE= ftp://ftp.videolan.org/pub/videolan/x264/snapshots
X264_INSTALL_STAGING = YES
X264_INSTALL_TARGET = YES
X264_DEPENDENCIES = host-pkgconf

define X264_CONFIGURE_CMDS
	(cd $(@D);./configure \
		--prefix=/usr \
		--host="$(GNU_TARGET_NAME)" \
		--cross-prefix="$(TARGET_CROSS)" \
		--enable-static \
		--enable-strip \
		--enable-pic \
		--enable-shared \
		--disable-ffms \
		--disable-cli \
		--disable-opencl \
	)
endef

define X264_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" -C $(@D)
endef

define X264_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/x264.pc $(STAGING_DIR)/usr/lib/pkgconfig/x264.pc
	$(INSTALL) -D -m 0644 $(@D)/x264.h $(STAGING_DIR)/usr/include
	$(INSTALL) -D -m 0644 $(@D)/x264_config.h $(STAGING_DIR)/usr/include
	$(INSTALL) -D -m 0755 $(@D)/libx264.so.138 $(STAGING_DIR)/usr/lib/libx264.so.138
	$(INSTALL) -D -m 0755 $(@D)/libx264.a $(STAGING_DIR)/usr/lib/libx264.a 
#	$(INSTALL) -D -m 0755 $(@D)/x264 $(STAGING_DIR)/usr/bin/x264
endef

define X264_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/x264.pc $(TARGET_DIR)/usr/lib/pkgconfig/x264.pc
	$(INSTALL) -D -m 0755 $(@D)/libx264.so.138 $(TARGET_DIR)/usr/lib/libx264.so.138
	$(INSTALL) -D -m 0755 $(@D)/libx264.a $(TARGET_DIR)/usr/lib/libx264.a 
endef


$(eval $(generic-package))
