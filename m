Return-Path: <linux-efi+bounces-5677-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81796C82E53
	for <lists+linux-efi@lfdr.de>; Tue, 25 Nov 2025 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 684BF4E17EA
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6A2F6176;
	Mon, 24 Nov 2025 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s07pCpBi"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9128272E42;
	Mon, 24 Nov 2025 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028602; cv=none; b=lQGUL6Au2BaaAIGaNLi7Jq6mkk5bez5rgPyz6XOA737Y2wm4IFcFSy0uZZ/r2RURCa23XVlmCNajygJSxD8QTjF1cQ1IHBOCnIHq8unDak8qysFIj8mSG5WHsw3+xHSF5a0fhyE3NCnf6AdMqZ1xsnFPcbjXd9xOV9lngJO69P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028602; c=relaxed/simple;
	bh=9OI9BzMb+379+qU/6B8MhkXYTc+//SCm5y10SzP6500=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JQtbzjzW6KNxg/r/FO1Ye8Q3lfL7N+mbkshyMw/A/5cZK27Hcw9ftEAQpjyF4hHqpQO4+zXvJPYePEazwcP8bJvTITno66j55Z5T/Dxg1SwHbiULUyiQecweyEy5WLu9u6Nk7OeK+jSAR/l5Qd6NOi3nWxpvtRSujz9PF0cKjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s07pCpBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1609FC4CEF1;
	Mon, 24 Nov 2025 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764028602;
	bh=9OI9BzMb+379+qU/6B8MhkXYTc+//SCm5y10SzP6500=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s07pCpBiCEtwBouTffBc5x2CMXd3A7kQKzgCyytInIBGCTewEyBdbpfqoIJqHjOir
	 tIw5jbIe0uAYv9afxwVFS4xyU0nkkk4tQZ9nPHCNRtziDkuRT7mxbS/jxRBTIJHF2E
	 pKPHfvz6GXQgaNF38uHmT3VIpEybzGOYURa0xIBoDf2p/4l/HM83/mQk2+TD7vpXDG
	 /Ywvo4f5r6Ajf1ri05Q3FA1Ax2QFs6nLlHureHOAfMSFIaUIP4zwbVlHj7jxRKbL2Z
	 W7U1rvp/cEr1gVM7MCPs5aMc7wq888lyLA/Lmi1jyp3la2b/Ux10YeRr58P/nEGPfc
	 IJXXhh7llwRNQ==
Date: Mon, 24 Nov 2025 17:56:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: ardb@kernel.org, javierm@redhat.com, arnd@arndb.de,
	richard.lyu@suse.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 04/10] sysfb: Replace screen_info with
 sysfb_primary_display
Message-ID: <20251124235640.GA2726595@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124165116.502813-5-tzimmermann@suse.de>

On Mon, Nov 24, 2025 at 05:40:16PM +0100, Thomas Zimmermann wrote:
> Replace the global screen_info with sysfb_primary_display of type
> struct sysfb_display_info. Adapt all users of screen_info.
> 
> Instances of screen_info are defined for x86, loongarch and EFI,
> with only one instance compiled into a specific build. Replace all
> of them with sysfb_primary_display.
> 
> All existing users of screen_info are updated by pointing them to
> sysfb_primary_display.screen instead. This introduces some churn to
> the code, but has no impact on functionality.
> 
> Boot parameters and EFI config tables are unchanged. They transfer
> screen_info as before. The logic in EFI's alloc_screen_info() changes
> slightly, as it now returns the screen field of sysfb_primary_display.
> 
> v2:
> - update comment
> - rename init_screen_info() to init_primary_display()
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # drivers/pci/

> ---
>  arch/arm64/kernel/image-vars.h                |  2 +-
>  arch/loongarch/kernel/efi.c                   | 15 +++++++------
>  arch/loongarch/kernel/image-vars.h            |  2 +-
>  arch/riscv/kernel/image-vars.h                |  2 +-
>  arch/x86/kernel/kexec-bzimage64.c             |  4 +++-
>  arch/x86/kernel/setup.c                       | 10 +++++----
>  arch/x86/video/video-common.c                 |  4 ++--
>  drivers/firmware/efi/earlycon.c               |  8 +++----
>  drivers/firmware/efi/efi-init.c               | 22 +++++++++----------
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 18 ++++++++++-----
>  drivers/firmware/efi/sysfb_efi.c              |  4 ++--
>  drivers/firmware/sysfb.c                      |  6 ++---
>  drivers/hv/vmbus_drv.c                        |  6 ++---
>  drivers/pci/vgaarb.c                          |  4 ++--
>  drivers/video/screen_info_pci.c               |  5 +++--
>  include/linux/screen_info.h                   |  2 --
>  include/linux/sysfb.h                         |  5 +++--
>  17 files changed, 66 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 85bc629270bd..d7b0d12b1015 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -38,7 +38,7 @@ PROVIDE(__efistub__end			= _end);
>  PROVIDE(__efistub___inittext_end       	= __inittext_end);
>  PROVIDE(__efistub__edata		= _edata);
>  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
> -PROVIDE(__efistub_screen_info		= screen_info);
> +PROVIDE(__efistub_sysfb_primary_display	= sysfb_primary_display);
>  #endif
>  PROVIDE(__efistub__ctype		= _ctype);
>  
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index 860a3bc030e0..638a392d2cd2 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -18,7 +18,7 @@
>  #include <linux/kobject.h>
>  #include <linux/memblock.h>
>  #include <linux/reboot.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/uaccess.h>
>  
>  #include <asm/early_ioremap.h>
> @@ -75,11 +75,11 @@ bool efi_poweroff_required(void)
>  unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
>  
>  #if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
> -struct screen_info screen_info __section(".data");
> -EXPORT_SYMBOL_GPL(screen_info);
> +struct sysfb_display_info sysfb_primary_display __section(".data");
> +EXPORT_SYMBOL_GPL(sysfb_primary_display);
>  #endif
>  
> -static void __init init_screen_info(void)
> +static void __init init_primary_display(void)
>  {
>  	struct screen_info *si;
>  
> @@ -91,11 +91,12 @@ static void __init init_screen_info(void)
>  		pr_err("Could not map screen_info config table\n");
>  		return;
>  	}
> -	screen_info = *si;
> +	sysfb_primary_display.screen = *si;
>  	memset(si, 0, sizeof(*si));
>  	early_memunmap(si, sizeof(*si));
>  
> -	memblock_reserve(__screen_info_lfb_base(&screen_info), screen_info.lfb_size);
> +	memblock_reserve(__screen_info_lfb_base(&sysfb_primary_display.screen),
> +			 sysfb_primary_display.screen.lfb_size);
>  }
>  
>  void __init efi_init(void)
> @@ -127,7 +128,7 @@ void __init efi_init(void)
>  	set_bit(EFI_CONFIG_TABLES, &efi.flags);
>  
>  	if (IS_ENABLED(CONFIG_EFI_EARLYCON) || IS_ENABLED(CONFIG_SYSFB))
> -		init_screen_info();
> +		init_primary_display();
>  
>  	if (boot_memmap == EFI_INVALID_TABLE_ADDR)
>  		return;
> diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> index 41ddcf56d21c..e557ebd46c2b 100644
> --- a/arch/loongarch/kernel/image-vars.h
> +++ b/arch/loongarch/kernel/image-vars.h
> @@ -12,7 +12,7 @@ __efistub_kernel_entry		= kernel_entry;
>  __efistub_kernel_asize		= kernel_asize;
>  __efistub_kernel_fsize		= kernel_fsize;
>  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
> -__efistub_screen_info		= screen_info;
> +__efistub_sysfb_primary_display	= sysfb_primary_display;
>  #endif
>  
>  #endif
> diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
> index 3df30dd1c458..3bd9d06a8b8f 100644
> --- a/arch/riscv/kernel/image-vars.h
> +++ b/arch/riscv/kernel/image-vars.h
> @@ -29,7 +29,7 @@ __efistub__end			= _end;
>  __efistub__edata		= _edata;
>  __efistub___init_text_end	= __init_text_end;
>  #if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
> -__efistub_screen_info		= screen_info;
> +__efistub_sysfb_primary_display	= sysfb_primary_display;
>  #endif
>  
>  #endif
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index c3244ac680d1..7508d0ccc740 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
> +#include <linux/sysfb.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -303,7 +304,8 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
>  
>  	/* Copying screen_info will do? */
> -	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
> +	memcpy(&params->screen_info, &sysfb_primary_display.screen,
> +	       sizeof(sysfb_primary_display.screen));
>  
>  	/* Fill in memsize later */
>  	params->screen_info.ext_mem_k = 0;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1b2edd07a3e1..675e4b9deb1f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/random.h>
>  #include <linux/root_dev.h>
>  #include <linux/static_call.h>
> +#include <linux/sysfb.h>
>  #include <linux/swiotlb.h>
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
> @@ -211,8 +212,9 @@ arch_initcall(init_x86_sysctl);
>  /*
>   * Setup options
>   */
> -struct screen_info screen_info;
> -EXPORT_SYMBOL(screen_info);
> +
> +struct sysfb_display_info sysfb_primary_display;
> +EXPORT_SYMBOL(sysfb_primary_display);
>  #if defined(CONFIG_FIRMWARE_EDID)
>  struct edid_info edid_info;
>  EXPORT_SYMBOL_GPL(edid_info);
> @@ -526,7 +528,7 @@ static void __init parse_setup_data(void)
>  static void __init parse_boot_params(void)
>  {
>  	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
> -	screen_info = boot_params.screen_info;
> +	sysfb_primary_display.screen = boot_params.screen_info;
>  #if defined(CONFIG_FIRMWARE_EDID)
>  	edid_info = boot_params.edid_info;
>  #endif
> @@ -1254,7 +1256,7 @@ void __init setup_arch(char **cmdline_p)
>  #ifdef CONFIG_VT
>  #if defined(CONFIG_VGA_CONSOLE)
>  	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
> -		vgacon_register_screen(&screen_info);
> +		vgacon_register_screen(&sysfb_primary_display.screen);
>  #endif
>  #endif
>  	x86_init.oem.banner();
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index e0aeee99bc99..152789f00fcd 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -9,7 +9,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/pci.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/vgaarb.h>
>  
>  #include <asm/video.h>
> @@ -29,7 +29,7 @@ EXPORT_SYMBOL(pgprot_framebuffer);
>  bool video_is_primary_device(struct device *dev)
>  {
>  #ifdef CONFIG_SCREEN_INFO
> -	struct screen_info *si = &screen_info;
> +	struct screen_info *si = &sysfb_primary_display.screen;
>  	struct resource res[SCREEN_INFO_MAX_RESOURCES];
>  	ssize_t i, numres;
>  #endif
> diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
> index 42e3a173dac1..3d060d59968c 100644
> --- a/drivers/firmware/efi/earlycon.c
> +++ b/drivers/firmware/efi/earlycon.c
> @@ -9,7 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/serial_core.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/string.h>
>  
>  #include <asm/early_ioremap.h>
> @@ -32,7 +32,7 @@ static void *efi_fb;
>   */
>  static int __init efi_earlycon_remap_fb(void)
>  {
> -	const struct screen_info *si = &screen_info;
> +	const struct screen_info *si = &sysfb_primary_display.screen;
>  
>  	/* bail if there is no bootconsole or it was unregistered already */
>  	if (!earlycon_console || !console_is_registered(earlycon_console))
> @@ -147,7 +147,7 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h,
>  static void
>  efi_earlycon_write(struct console *con, const char *str, unsigned int num)
>  {
> -	const struct screen_info *si = &screen_info;
> +	const struct screen_info *si = &sysfb_primary_display.screen;
>  	u32 cur_efi_x = efi_x;
>  	unsigned int len;
>  	const char *s;
> @@ -227,7 +227,7 @@ void __init efi_earlycon_reprobe(void)
>  static int __init efi_earlycon_setup(struct earlycon_device *device,
>  				     const char *opt)
>  {
> -	const struct screen_info *si = &screen_info;
> +	const struct screen_info *si = &sysfb_primary_display.screen;
>  	u16 xres, yres;
>  	u32 i;
>  
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a65c2d5b9e7b..d1d418a34407 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -19,7 +19,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/platform_device.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  
>  #include <asm/efi.h>
>  
> @@ -57,15 +57,15 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
>  extern __weak const efi_config_table_type_t efi_arch_tables[];
>  
>  /*
> - * x86 defines its own screen_info and uses it even without EFI,
> - * everything else can get it from here.
> + * x86 defines its own instance of sysfb_primary_display and uses
> + * it even without EFI, everything else can get them from here.
>   */
>  #if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
> -struct screen_info screen_info __section(".data");
> -EXPORT_SYMBOL_GPL(screen_info);
> +struct sysfb_display_info sysfb_primary_display __section(".data");
> +EXPORT_SYMBOL_GPL(sysfb_primary_display);
>  #endif
>  
> -static void __init init_screen_info(void)
> +static void __init init_primary_display(void)
>  {
>  	struct screen_info *si;
>  
> @@ -75,13 +75,13 @@ static void __init init_screen_info(void)
>  			pr_err("Could not map screen_info config table\n");
>  			return;
>  		}
> -		screen_info = *si;
> +		sysfb_primary_display.screen = *si;
>  		memset(si, 0, sizeof(*si));
>  		early_memunmap(si, sizeof(*si));
>  
> -		if (memblock_is_map_memory(screen_info.lfb_base))
> -			memblock_mark_nomap(screen_info.lfb_base,
> -					    screen_info.lfb_size);
> +		if (memblock_is_map_memory(sysfb_primary_display.screen.lfb_base))
> +			memblock_mark_nomap(sysfb_primary_display.screen.lfb_base,
> +					    sysfb_primary_display.screen.lfb_size);
>  
>  		if (IS_ENABLED(CONFIG_EFI_EARLYCON))
>  			efi_earlycon_reprobe();
> @@ -274,5 +274,5 @@ void __init efi_init(void)
>  	if (IS_ENABLED(CONFIG_X86) ||
>  	    IS_ENABLED(CONFIG_SYSFB) ||
>  	    IS_ENABLED(CONFIG_EFI_EARLYCON))
> -		init_screen_info();
> +		init_primary_display();
>  }
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index a6c049835190..401ecbbdf331 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -1,13 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/efi.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  
>  #include <asm/efi.h>
>  
>  #include "efistub.h"
>  
> -static unsigned long screen_info_offset;
> +static unsigned long kernel_image_offset;
> +
> +static void *kernel_image_addr(void *addr)
> +{
> +	return addr + kernel_image_offset;
> +}
>  
>  struct screen_info *alloc_screen_info(void)
>  {
> @@ -16,8 +21,11 @@ struct screen_info *alloc_screen_info(void)
>  
>  	if (IS_ENABLED(CONFIG_X86) ||
>  	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
> -	    IS_ENABLED(CONFIG_SYSFB))
> -		return (void *)&screen_info + screen_info_offset;
> +	    IS_ENABLED(CONFIG_SYSFB)) {
> +		struct sysfb_display_info *dpy = kernel_image_addr(&sysfb_primary_display);
> +
> +		return &dpy->screen;
> +	}
>  
>  	return NULL;
>  }
> @@ -73,7 +81,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  		return status;
>  	}
>  
> -	screen_info_offset = image_addr - (unsigned long)image->image_base;
> +	kernel_image_offset = image_addr - (unsigned long)image->image_base;
>  
>  	status = efi_stub_common(handle, image, image_addr, cmdline_ptr);
>  
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 8e0f9d08397f..46ad95084b50 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -176,7 +176,7 @@ static int __init efifb_set_system(struct screen_info *si, const struct dmi_syst
>  
>  static int __init efifb_set_system_callback(const struct dmi_system_id *id)
>  {
> -	return efifb_set_system(&screen_info, id);
> +	return efifb_set_system(&sysfb_primary_display.screen, id);
>  }
>  
>  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
> @@ -316,7 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
>  		}
>  
>  		for_each_of_pci_range(&parser, &range)
> -			if (efifb_overlaps_pci_range(&screen_info, &range))
> +			if (efifb_overlaps_pci_range(&sysfb_primary_display.screen, &range))
>  				return np;
>  	}
>  	return NULL;
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 916b28538a29..1f671f9219b0 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -66,7 +66,7 @@ static bool sysfb_unregister(void)
>   */
>  void sysfb_disable(struct device *dev)
>  {
> -	struct screen_info *si = &screen_info;
> +	struct screen_info *si = &sysfb_primary_display.screen;
>  	struct device *parent;
>  
>  	mutex_lock(&disable_lock);
> @@ -92,7 +92,7 @@ EXPORT_SYMBOL_GPL(sysfb_disable);
>   */
>  bool sysfb_handles_screen_info(void)
>  {
> -	const struct screen_info *si = &screen_info;
> +	const struct screen_info *si = &sysfb_primary_display.screen;
>  
>  	return !!screen_info_video_type(si);
>  }
> @@ -141,7 +141,7 @@ static struct device *sysfb_parent_dev(const struct screen_info *si)
>  
>  static __init int sysfb_init(void)
>  {
> -	struct screen_info *si = &screen_info;
> +	struct screen_info *si = &sysfb_primary_display.screen;
>  	struct device *parent;
>  	unsigned int type;
>  	struct simplefb_platform_data mode;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index a53af6fe81a6..9c937190be81 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -29,7 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
>  #include <linux/kernel.h>
> @@ -2340,8 +2340,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  	if (efi_enabled(EFI_BOOT)) {
>  		/* Gen2 VM: get FB base from EFI framebuffer */
>  		if (IS_ENABLED(CONFIG_SYSFB)) {
> -			start = screen_info.lfb_base;
> -			size = max_t(__u32, screen_info.lfb_size, 0x800000);
> +			start = sysfb_primary_display.screen.lfb_base;
> +			size = max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000);
>  		}
>  	} else {
>  		/* Gen1 VM: get FB base from PCI */
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 436fa7f4c387..805be9ea4a34 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -26,7 +26,7 @@
>  #include <linux/poll.h>
>  #include <linux/miscdevice.h>
>  #include <linux/slab.h>
> -#include <linux/screen_info.h>
> +#include <linux/sysfb.h>
>  #include <linux/vt.h>
>  #include <linux/console.h>
>  #include <linux/acpi.h>
> @@ -557,7 +557,7 @@ EXPORT_SYMBOL(vga_put);
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
>  #if defined CONFIG_X86
> -	return pdev == screen_info_pci_dev(&screen_info);
> +	return pdev == screen_info_pci_dev(&sysfb_primary_display.screen);
>  #else
>  	return false;
>  #endif
> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
> index 66bfc1d0a6dc..8f34d8a74f09 100644
> --- a/drivers/video/screen_info_pci.c
> +++ b/drivers/video/screen_info_pci.c
> @@ -4,6 +4,7 @@
>  #include <linux/printk.h>
>  #include <linux/screen_info.h>
>  #include <linux/string.h>
> +#include <linux/sysfb.h>
>  
>  static struct pci_dev *screen_info_lfb_pdev;
>  static size_t screen_info_lfb_bar;
> @@ -26,7 +27,7 @@ static bool __screen_info_relocation_is_valid(const struct screen_info *si, stru
>  
>  void screen_info_apply_fixups(void)
>  {
> -	struct screen_info *si = &screen_info;
> +	struct screen_info *si = &sysfb_primary_display.screen;
>  
>  	if (screen_info_lfb_pdev) {
>  		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
> @@ -75,7 +76,7 @@ static void screen_info_fixup_lfb(struct pci_dev *pdev)
>  		.flags = IORESOURCE_MEM,
>  	};
>  	const struct resource *pr;
> -	const struct screen_info *si = &screen_info;
> +	const struct screen_info *si = &sysfb_primary_display.screen;
>  
>  	if (screen_info_lfb_pdev)
>  		return; // already found
> diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
> index 1690706206e8..c022403c599a 100644
> --- a/include/linux/screen_info.h
> +++ b/include/linux/screen_info.h
> @@ -151,6 +151,4 @@ static inline struct pci_dev *screen_info_pci_dev(const struct screen_info *si)
>  }
>  #endif
>  
> -extern struct screen_info screen_info;
> -
>  #endif /* _SCREEN_INFO_H */
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 8b37247528bf..e8bde392c690 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -8,11 +8,10 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/platform_data/simplefb.h>
>  #include <linux/screen_info.h>
>  #include <linux/types.h>
>  
> -#include <linux/platform_data/simplefb.h>
> -
>  struct device;
>  struct platform_device;
>  struct screen_info;
> @@ -65,6 +64,8 @@ struct sysfb_display_info {
>  	struct screen_info screen;
>  };
>  
> +extern struct sysfb_display_info sysfb_primary_display;
> +
>  #ifdef CONFIG_SYSFB
>  
>  void sysfb_disable(struct device *dev);
> -- 
> 2.51.1
> 

