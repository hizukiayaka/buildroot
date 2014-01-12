################################################################################
#
# gst-ffmpeg
#
################################################################################

GST_LIBAV_VERSION = 1.2.2
GST_LIBAV_SOURCE = gst-libav-$(GST_LIBAV_VERSION).tar.xz
GST_LIBAV_SITE = http://gstreamer.freedesktop.org/src/gst-libav
GST_LIBAV_INSTALL_STAGING = YES
GST_LIBAV_DEPENDENCIES = host-pkgconf gstreamer1 gst1-plugins-base libav
GST_LIBAV_CONF_OPT = --disable-valgrind --with-system-libav

ifeq ($(BR2_PACKAGE_BZIP2),y)
GST_LIBAV_DEPENDENCIES += bzip2
endif

$(eval $(autotools-package))
