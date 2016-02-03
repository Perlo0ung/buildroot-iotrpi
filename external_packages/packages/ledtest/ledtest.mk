LEDTEST_SOURCE:=ledtest.tar.gz
LEDTEST_INSTALL_TARGET:=YES

define LEDTEST_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define LEDTEST_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/ledtest $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
