GPIOMOD_INSTALL_TARGET:=YES
GPIOMOD_SOURCE:=gpiomod.tar.gz

$(eval $(kernel-module))
$(eval $(generic-package))
