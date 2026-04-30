include $(TOPDIR)/rules.mk

PKG_NAME:=traefik
PKG_VERSION:=2.10.7
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/traefik/traefik/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=827624405d358c43b8793ae425200b493026b0b6e645b7a682abd3aa6e606213

PKG_MAINTAINER:=icyleaf <icyleaf.cn@gmail.com>
PKG_LICENSE:=MIT

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/traefik/traefik
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=$(GO_PKG)/version.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
	SUBMENU:=Web Servers/Proxies
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Traefik, The Cloud Native Application Proxy
	URL:=https://github.com/traefik/traefik/
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/$(PKG_NAME)/description
	Traefik, The Cloud Native Application Proxy
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/$(PKG_NAME) $(1)/usr/sbin

	# TODO: script is working in processing.
	# $(INSTALL_DIR) $(1)/etc/config $(1)/etc/$(PKG_NAME) $(1)/etc/init.d
	# $(INSTALL_CONF) $(CURDIR)/files/etc/config/$(PKG_NAME) $(1)/etc/config/$(PKG_NAME)
	# $(INSTALL_CONF) $(CURDIR)/files/etc/$(PKG_NAME)/config.yml $(1)/etc/$(PKG_NAME)/config.yml

	# $(INSTALL_BIN) $(CURDIR)/files/etc/init.d/$(PKG_NAME) $(1)/etc/init.d/$(PKG_NAME)
endef

$(eval $(call GoBinPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
