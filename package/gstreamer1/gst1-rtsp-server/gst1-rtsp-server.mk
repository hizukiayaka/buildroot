################################################################################
#
# gst1-libav
#
################################################################################

GST1_RTSP_SERVER_VERSION = 1.6.1
GST1_RTSP_SERVER_SOURCE = gst-rtsp-server-$(GST1_RTSP_SERVER_VERSION).tar.xz
GST1_RTSP_SERVER_SITE =  http://gstreamer.freedesktop.org/src/gst-rtsp-server
GST1_RTSP_SERVER_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPLv2+ LGPLv2.1+

GST1_RTSP_SERVER_DEPENDENCIES = host-pkgconf gstreamer1 gst1-plugins-base gst1-plugins-good

GST1_RTSP_SERVER_CONF_EXTRA_OPT = \
	--cross-prefix=$(TARGET_CROSS) \
	--target-os=linux \
	$(if $(BR2_ENABLE_DEBUG),--enable-debug,--disable-debug)

$(eval $(autotools-package))
