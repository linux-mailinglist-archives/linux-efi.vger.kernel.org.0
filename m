Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C63B17C6
	for <lists+linux-efi@lfdr.de>; Wed, 23 Jun 2021 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWKJB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Jun 2021 06:09:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56224 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFWKJA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Jun 2021 06:09:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 999121FD67;
        Wed, 23 Jun 2021 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624442802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8uJTOZ4Jb0BLBsZUtO0RxAVns4oXEOyaeJr7uHhW+w=;
        b=1Sqw3k1Vy4R0x6QFZUyEaxDlIuD0wcZtiQdxmRCcZrp0l9D/nyYg7JQi/AiZpmpxvvp3UM
        XKCupfaWqOL4RJwTZfDVivH7h0ziOXEAaeoNSsMzU7fQXVHlS7IsRKJ2pUdrRuidx87qBe
        Thgep5eqvMuuTRhMkXdCmLE+Om/all8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624442802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8uJTOZ4Jb0BLBsZUtO0RxAVns4oXEOyaeJr7uHhW+w=;
        b=so78QIB9vuhQiRtnrym/Q/pxgaBuYK+AOV5uoPsc8EmN9D0QrQ7LShOKVOxknuKuB4J1O0
        t+ybPm8xJ/pt7BCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 47AF111A97;
        Wed, 23 Jun 2021 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624442802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8uJTOZ4Jb0BLBsZUtO0RxAVns4oXEOyaeJr7uHhW+w=;
        b=1Sqw3k1Vy4R0x6QFZUyEaxDlIuD0wcZtiQdxmRCcZrp0l9D/nyYg7JQi/AiZpmpxvvp3UM
        XKCupfaWqOL4RJwTZfDVivH7h0ziOXEAaeoNSsMzU7fQXVHlS7IsRKJ2pUdrRuidx87qBe
        Thgep5eqvMuuTRhMkXdCmLE+Om/all8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624442802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8uJTOZ4Jb0BLBsZUtO0RxAVns4oXEOyaeJr7uHhW+w=;
        b=so78QIB9vuhQiRtnrym/Q/pxgaBuYK+AOV5uoPsc8EmN9D0QrQ7LShOKVOxknuKuB4J1O0
        t+ybPm8xJ/pt7BCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id G0+ZELIH02AIUgAALh3uQQ
        (envelope-from <tzimmermann@suse.de>); Wed, 23 Jun 2021 10:06:42 +0000
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210601150017.774363-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/2] drivers/firmware: consolidate EFI framebuffer
 setup for all arches
Message-ID: <9700697f-747c-fe36-d480-69762e845f30@suse.de>
Date:   Wed, 23 Jun 2021 12:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210601150017.774363-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yF8vVYrv1L4wXM302isskDlSalBbOgIwD"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yF8vVYrv1L4wXM302isskDlSalBbOgIwD
Content-Type: multipart/mixed; boundary="kAg0IUk9gmBrgEX5M4kQXG7wTZ4XO2GA8";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Airlie <airlied@linux.ie>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org,
 Hans de Goede <hdegoede@redhat.com>, linux-efi@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Robinson <pbrobinson@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <9700697f-747c-fe36-d480-69762e845f30@suse.de>
Subject: Re: [PATCH v2 2/2] drivers/firmware: consolidate EFI framebuffer
 setup for all arches
References: <20210601150017.774363-1-javierm@redhat.com>
In-Reply-To: <20210601150017.774363-1-javierm@redhat.com>

--kAg0IUk9gmBrgEX5M4kQXG7wTZ4XO2GA8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 01.06.21 um 17:00 schrieb Javier Martinez Canillas:
> The register_gop_device() function registers an "efi-framebuffer" platf=
orm
> device to match against the efifb driver, to have an early framebuffer =
for
> EFI platforms.
>=20
> But there is already support to do exactly the same by the Generic Syst=
em
> Framebuffers (sysfb) driver. This used to be only for X86 but it has be=
en
> moved to drivers/firmware and could be reused by other architectures.
>=20
> Also, besides supporting registering an "efi-framebuffer", this driver =
can
> register a "simple-framebuffer" allowing to use the siple{fb,drm} drive=
rs
> on non-X86 EFI platforms. For example, on aarch64 these drivers can onl=
y
> be used with DT and doesn't have code to register a "simple-frambuffer"=

> platform device when booting with EFI.
>=20
> For these reasons, let's remove the register_gop_device() duplicated co=
de
> and instead move the platform specific logic that's there to sysfb driv=
er.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v2:
> - Use "depends on" for the supported architectures instead of selecting=
 it.
> - Improve commit message to explain the benefits of reusing sysfb for !=
X86.
>=20
>   arch/arm/include/asm/efi.h        |  5 +-
>   arch/arm64/include/asm/efi.h      |  5 +-
>   arch/riscv/include/asm/efi.h      |  5 +-
>   drivers/firmware/Kconfig          |  8 +--
>   drivers/firmware/Makefile         |  2 +-
>   drivers/firmware/efi/efi-init.c   | 90 ------------------------------=
-
>   drivers/firmware/efi/sysfb_efi.c  | 77 +++++++++++++++++++++++++-
>   drivers/firmware/sysfb.c          | 40 +++++++++-----
>   drivers/firmware/sysfb_simplefb.c | 29 ++++++----
>   include/linux/sysfb.h             | 28 +++++-----
>   10 files changed, 143 insertions(+), 146 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 9de7ab2ce05..a6f3b179e8a 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -17,6 +17,7 @@
>  =20
>   #ifdef CONFIG_EFI
>   void efi_init(void);
> +extern void efifb_setup_from_dmi(struct screen_info *si, const char *o=
pt);
>  =20
>   int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
>   int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc=
_t *md);
> @@ -52,10 +53,6 @@ void efi_virtmap_unload(void);
>   struct screen_info *alloc_screen_info(void);
>   void free_screen_info(struct screen_info *si);
>  =20
> -static inline void efifb_setup_from_dmi(struct screen_info *si, const =
char *opt)
> -{
> -}
> -
>   /*
>    * A reasonable upper bound for the uncompressed kernel size is 32 MB=
ytes,
>    * so we will reserve that amount of memory. We have no easy way to t=
ell what
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.=
h
> index 1bed37eb013..d3e1825337b 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -14,6 +14,7 @@
>  =20
>   #ifdef CONFIG_EFI
>   extern void efi_init(void);
> +extern void efifb_setup_from_dmi(struct screen_info *si, const char *o=
pt);
>   #else
>   #define efi_init()
>   #endif
> @@ -85,10 +86,6 @@ static inline void free_screen_info(struct screen_in=
fo *si)
>   {
>   }
>  =20
> -static inline void efifb_setup_from_dmi(struct screen_info *si, const =
char *opt)
> -{
> -}
> -
>   #define EFI_ALLOC_ALIGN		SZ_64K
>  =20
>   /*
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.=
h
> index 6d98cd99968..7a8f0d45b13 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -13,6 +13,7 @@
>  =20
>   #ifdef CONFIG_EFI
>   extern void efi_init(void);
> +extern void efifb_setup_from_dmi(struct screen_info *si, const char *o=
pt);
>   #else
>   #define efi_init()
>   #endif
> @@ -39,10 +40,6 @@ static inline void free_screen_info(struct screen_in=
fo *si)
>   {
>   }
>  =20
> -static inline void efifb_setup_from_dmi(struct screen_info *si, const =
char *opt)
> -{
> -}
> -
>   void efi_virtmap_load(void);
>   void efi_virtmap_unload(void);
>  =20
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 4392fc57cf3..c704ac441fb 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -254,9 +254,9 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   config SYSFB
>   	bool
>   	default y
> -	depends on X86 || COMPILE_TEST
> +	depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
>  =20
> -config X86_SYSFB
> +config SYSFB_SIMPLEFB

You should also update the help text for simpledrm to reflect this=20
change. See drivers/gpu/drm/tiny/Kconfig.

>   	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
>   	depends on SYSFB
>   	help
> @@ -264,10 +264,10 @@ config X86_SYSFB
>   	  bootloader or kernel can show basic video-output during boot for
>   	  user-guidance and debugging. Historically, x86 used the VESA BIOS
>   	  Extensions and EFI-framebuffers for this, which are mostly limited=

> -	  to x86.
> +	  to x86 BIOS or EFI systems.
>   	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic=

>   	  framebuffers so the new generic system-framebuffer drivers can be
> -	  used on x86. If the framebuffer is not compatible with the generic
> +	  used instead. If the framebuffer is not compatible with the generic=

>   	  modes, it is advertised as fallback platform framebuffer so legacy=

>   	  drivers like efifb, vesafb and uvesafb can pick it up.
>   	  If this option is not selected, all system framebuffers are always=

> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 946dda07443..705fabe8815 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -19,7 +19,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) +=3D raspberrypi.o=

>   obj-$(CONFIG_FW_CFG_SYSFS)	+=3D qemu_fw_cfg.o
>   obj-$(CONFIG_QCOM_SCM)		+=3D qcom_scm.o qcom_scm-smc.o qcom_scm-legac=
y.o
>   obj-$(CONFIG_SYSFB)		+=3D sysfb.o
> -obj-$(CONFIG_X86_SYSFB)		+=3D sysfb_simplefb.o
> +obj-$(CONFIG_SYSFB_SIMPLEFB)	+=3D sysfb_simplefb.o
>   obj-$(CONFIG_TI_SCI_PROTOCOL)	+=3D ti_sci.o
>   obj-$(CONFIG_TRUSTED_FOUNDATIONS) +=3D trusted_foundations.o
>   obj-$(CONFIG_TURRIS_MOX_RWTM)	+=3D turris-mox-rwtm.o
> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi=
-init.c
> index a552a08a174..b19ce1a83f9 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -275,93 +275,3 @@ void __init efi_init(void)
>   	}
>   #endif
>   }
> -
> -static bool efifb_overlaps_pci_range(const struct of_pci_range *range)=

> -{
> -	u64 fb_base =3D screen_info.lfb_base;
> -
> -	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -		fb_base |=3D (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> -
> -	return fb_base >=3D range->cpu_addr &&
> -	       fb_base < (range->cpu_addr + range->size);
> -}
> -
> -static struct device_node *find_pci_overlap_node(void)
> -{
> -	struct device_node *np;
> -
> -	for_each_node_by_type(np, "pci") {
> -		struct of_pci_range_parser parser;
> -		struct of_pci_range range;
> -		int err;
> -
> -		err =3D of_pci_range_parser_init(&parser, np);
> -		if (err) {
> -			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> -			continue;
> -		}
> -
> -		for_each_of_pci_range(&parser, &range)
> -			if (efifb_overlaps_pci_range(&range))
> -				return np;
> -	}
> -	return NULL;
> -}
> -
> -/*
> - * If the efifb framebuffer is backed by a PCI graphics controller, we=
 have
> - * to ensure that this relation is expressed using a device link when
> - * running in DT mode, or the probe order may be reversed, resulting i=
n a
> - * resource reservation conflict on the memory window that the efifb
> - * framebuffer steals from the PCIe host bridge.
> - */
> -static int efifb_add_links(struct fwnode_handle *fwnode)
> -{
> -	struct device_node *sup_np;
> -
> -	sup_np =3D find_pci_overlap_node();
> -
> -	/*
> -	 * If there's no PCI graphics controller backing the efifb, we are
> -	 * done here.
> -	 */
> -	if (!sup_np)
> -		return 0;
> -
> -	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
> -	of_node_put(sup_np);
> -
> -	return 0;
> -}
> -
> -static const struct fwnode_operations efifb_fwnode_ops =3D {
> -	.add_links =3D efifb_add_links,
> -};
> -
> -static struct fwnode_handle efifb_fwnode;
> -
> -static int __init register_gop_device(void)
> -{
> -	struct platform_device *pd;
> -	int err;
> -
> -	if (screen_info.orig_video_isVGA !=3D VIDEO_TYPE_EFI)
> -		return 0;
> -
> -	pd =3D platform_device_alloc("efi-framebuffer", 0);
> -	if (!pd)
> -		return -ENOMEM;
> -
> -	if (IS_ENABLED(CONFIG_PCI)) {
> -		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
> -		pd->dev.fwnode =3D &efifb_fwnode;
> -	}
> -
> -	err =3D platform_device_add_data(pd, &screen_info, sizeof(screen_info=
));
> -	if (err)
> -		return err;
> -
> -	return platform_device_add(pd);
> -}
> -subsys_initcall(register_gop_device);
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sy=
sfb_efi.c
> index 9f035b15501..2814af6baf1 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Generic System Framebuffers on x86
> + * Generic System Framebuffers
>    * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
>    *
>    * EFI Quirks Copyright (c) 2006 Edgar Hucek <gimli@dark-green.com>
> @@ -19,7 +19,9 @@
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/mm.h>
> +#include <linux/of_address.h>
>   #include <linux/pci.h>
> +#include <linux/platform_device.h>
>   #include <linux/screen_info.h>
>   #include <linux/sysfb.h>
>   #include <video/vga.h>
> @@ -267,7 +269,72 @@ static const struct dmi_system_id efifb_dmi_swap_w=
idth_height[] __initconst =3D {
>   	{},
>   };
>  =20
> -__init void sysfb_apply_efi_quirks(void)
> +static bool efifb_overlaps_pci_range(const struct of_pci_range *range)=

> +{
> +	u64 fb_base =3D screen_info.lfb_base;
> +
> +	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +		fb_base |=3D (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> +
> +	return fb_base >=3D range->cpu_addr &&
> +	       fb_base < (range->cpu_addr + range->size);
> +}
> +
> +static struct device_node *find_pci_overlap_node(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_node_by_type(np, "pci") {
> +		struct of_pci_range_parser parser;
> +		struct of_pci_range range;
> +		int err;
> +
> +		err =3D of_pci_range_parser_init(&parser, np);
> +		if (err) {
> +			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
> +			continue;
> +		}
> +
> +		for_each_of_pci_range(&parser, &range)
> +			if (efifb_overlaps_pci_range(&range))
> +				return np;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * If the efifb framebuffer is backed by a PCI graphics controller, we=
 have
> + * to ensure that this relation is expressed using a device link when
> + * running in DT mode, or the probe order may be reversed, resulting i=
n a
> + * resource reservation conflict on the memory window that the efifb
> + * framebuffer steals from the PCIe host bridge.
> + */
> +static int efifb_add_links(struct fwnode_handle *fwnode)
> +{
> +	struct device_node *sup_np;
> +
> +	sup_np =3D find_pci_overlap_node();
> +
> +	/*
> +	 * If there's no PCI graphics controller backing the efifb, we are
> +	 * done here.
> +	 */
> +	if (!sup_np)
> +		return 0;
> +
> +	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
> +	of_node_put(sup_np);
> +
> +	return 0;
> +}
> +
> +static const struct fwnode_operations efifb_fwnode_ops =3D {
> +	.add_links =3D efifb_add_links,
> +};
> +
> +static struct fwnode_handle efifb_fwnode;
> +
> +__init void sysfb_apply_efi_quirks(struct platform_device *pd)
>   {
>   	if (screen_info.orig_video_isVGA !=3D VIDEO_TYPE_EFI ||
>   	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
> @@ -281,4 +348,10 @@ __init void sysfb_apply_efi_quirks(void)
>   		screen_info.lfb_height =3D temp;
>   		screen_info.lfb_linelength =3D 4 * screen_info.lfb_width;
>   	}
> +
> +	if (screen_info.orig_video_isVGA =3D=3D VIDEO_TYPE_EFI &&
> +	    IS_ENABLED(CONFIG_PCI)) {

We have a 100-character limit now. This should (?) fit onto a single line=
=2E


> +		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
> +		pd->dev.fwnode =3D &efifb_fwnode;
> +	}
>   }
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 1337515963d..3ecd60a0215 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -1,11 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Generic System Framebuffers on x86
> + * Generic System Framebuffers
>    * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
>    */
>  =20
>   /*
> - * Simple-Framebuffer support for x86 systems
> + * Simple-Framebuffer support
>    * Create a platform-device for any available boot framebuffer. The
>    * simple-framebuffer platform device is already available on DT syst=
ems, so
>    * this module parses the global "screen_info" object and creates a s=
uitable
> @@ -16,12 +16,12 @@
>    * to pick these devices up without messing with simple-framebuffer d=
rivers.
>    * The global "screen_info" is still valid at all times.
>    *
> - * If CONFIG_X86_SYSFB is not selected, we never register "simple-fram=
ebuffer"
> + * If CONFIG_SYSFB_SIMPLEFB is not selected, never register "simple-fr=
amebuffer"
>    * platform devices, but only use legacy framebuffer devices for
>    * backwards compatibility.
>    *
>    * TODO: We set the dev_id field of all platform-devices to 0. This a=
llows
> - * other x86 OF/DT parsers to create such devices, too. However, they =
must
> + * other OF/DT parsers to create such devices, too. However, they must=

>    * start at offset 1 for this to work.
>    */
>  =20
> @@ -39,31 +39,43 @@ static __init int sysfb_init(void)
>   	struct screen_info *si =3D &screen_info;
>   	struct simplefb_platform_data mode;
>   	struct platform_device *pd;
> -	const char *name;
>   	bool compatible;
>   	int ret;
>  =20
> -	sysfb_apply_efi_quirks();
> +	pd =3D platform_device_alloc("", 0);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	sysfb_apply_efi_quirks(pd);
>  =20
>   	/* try to create a simple-framebuffer device */
> -	compatible =3D parse_mode(si, &mode);
> +	compatible =3D sysfb_parse_mode(si, &mode);
>   	if (compatible) {
> -		ret =3D create_simplefb(si, &mode);
> +		ret =3D sysfb_create_simplefb(si, &mode, pd);
>   		if (!ret)
>   			return 0;
>   	}
>  =20
>   	/* if the FB is incompatible, create a legacy framebuffer device */
>   	if (si->orig_video_isVGA =3D=3D VIDEO_TYPE_EFI)
> -		name =3D "efi-framebuffer";
> +		pd->name =3D "efi-framebuffer";
>   	else if (si->orig_video_isVGA =3D=3D VIDEO_TYPE_VLFB)
> -		name =3D "vesa-framebuffer";
> +		pd->name =3D "vesa-framebuffer";
>   	else
> -		name =3D "platform-framebuffer";
> +		pd->name =3D "platform-framebuffer";

You're allocating the platform device with an empty name string. And=20
here you're overwriting the pointer. Can you rearrange the code to first =

detect a proper name and then allocate the device with that name? It=20
takes a few bytes more memory, but seems in the spirit of the interface.

Best regards
Thomas

> +
> +	ret =3D platform_device_add_data(pd, si, sizeof(*si));
> +	if (ret)
> +		goto err;
> +
> +	ret =3D platform_device_add(pd);
> +	if (ret)
> +		goto err;
>  =20
> -	pd =3D platform_device_register_resndata(NULL, name, 0,
> -					       NULL, 0, si, sizeof(*si));
> -	return PTR_ERR_OR_ZERO(pd);
> +	return 0;
> +err:
> +	platform_device_put(pd);
> +	return ret;
>   }
>  =20
>   /* must execute after PCI subsystem for EFI quirks */
> diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb=
_simplefb.c
> index df892444ea1..cffff4283f3 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Generic System Framebuffers on x86
> + * Generic System Framebuffers
>    * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
>    */
>  =20
> @@ -23,9 +23,9 @@
>   static const char simplefb_resname[] =3D "BOOTFB";
>   static const struct simplefb_format formats[] =3D SIMPLEFB_FORMATS;
>  =20
> -/* try parsing x86 screen_info into a simple-framebuffer mode struct *=
/
> -__init bool parse_mode(const struct screen_info *si,
> -		       struct simplefb_platform_data *mode)
> +/* try parsing screen_info into a simple-framebuffer mode struct */
> +__init bool sysfb_parse_mode(const struct screen_info *si,
> +			     struct simplefb_platform_data *mode)
>   {
>   	const struct simplefb_format *f;
>   	__u8 type;
> @@ -57,13 +57,14 @@ __init bool parse_mode(const struct screen_info *si=
,
>   	return false;
>   }
>  =20
> -__init int create_simplefb(const struct screen_info *si,
> -			   const struct simplefb_platform_data *mode)
> +__init int sysfb_create_simplefb(const struct screen_info *si,
> +				 const struct simplefb_platform_data *mode,
> +				 struct platform_device *pd)
>   {
> -	struct platform_device *pd;
>   	struct resource res;
>   	u64 base, size;
>   	u32 length;
> +	int ret;
>  =20
>   	/*
>   	 * If the 64BIT_BASE capability is set, ext_lfb_base will contain th=
e
> @@ -105,7 +106,15 @@ __init int create_simplefb(const struct screen_inf=
o *si,
>   	if (res.end <=3D res.start)
>   		return -EINVAL;
>  =20
> -	pd =3D platform_device_register_resndata(NULL, "simple-framebuffer", =
0,
> -					       &res, 1, mode, sizeof(*mode));
> -	return PTR_ERR_OR_ZERO(pd);
> +	pd->name =3D "simple-framebuffer";
> +
> +	ret =3D platform_device_add_resources(pd, &res, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D platform_device_add_data(pd, mode, sizeof(*mode));
> +	if (ret)
> +		return ret;
> +
> +	return platform_device_add(pd);
>   }
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 3e5355769dc..d97162f4b97 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -58,37 +58,39 @@ struct efifb_dmi_info {
>   #ifdef CONFIG_EFI
>  =20
>   extern struct efifb_dmi_info efifb_dmi_list[];
> -void sysfb_apply_efi_quirks(void);
> +void sysfb_apply_efi_quirks(struct platform_device *pd);
>  =20
>   #else /* CONFIG_EFI */
>  =20
> -static inline void sysfb_apply_efi_quirks(void)
> +static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
>   {
>   }
>  =20
>   #endif /* CONFIG_EFI */
>  =20
> -#ifdef CONFIG_X86_SYSFB
> +#ifdef CONFIG_SYSFB_SIMPLEFB
>  =20
> -bool parse_mode(const struct screen_info *si,
> -		struct simplefb_platform_data *mode);
> -int create_simplefb(const struct screen_info *si,
> -		    const struct simplefb_platform_data *mode);
> +bool sysfb_parse_mode(const struct screen_info *si,
> +		      struct simplefb_platform_data *mode);
> +int sysfb_create_simplefb(const struct screen_info *si,
> +			  const struct simplefb_platform_data *mode,
> +			  struct platform_device *pd);
>  =20
> -#else /* CONFIG_X86_SYSFB */
> +#else /* CONFIG_SYSFB_SIMPLE */
>  =20
> -static inline bool parse_mode(const struct screen_info *si,
> -			      struct simplefb_platform_data *mode)
> +static inline bool sysfb_parse_mode(const struct screen_info *si,
> +				    struct simplefb_platform_data *mode)
>   {
>   	return false;
>   }
>  =20
> -static inline int create_simplefb(const struct screen_info *si,
> -				  const struct simplefb_platform_data *mode)
> +static inline int sysfb_create_simplefb(const struct screen_info *si,
> +					 const struct simplefb_platform_data *mode,
> +					 struct platform_device *pd)
>   {
>   	return -EINVAL;
>   }
>  =20
> -#endif /* CONFIG_X86_SYSFB */
> +#endif /* CONFIG_SYSFB_SIMPLE */
>  =20
>   #endif /* _LINUX_SYSFB_H */
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--kAg0IUk9gmBrgEX5M4kQXG7wTZ4XO2GA8--

--yF8vVYrv1L4wXM302isskDlSalBbOgIwD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDTB7EFAwAAAAAACgkQlh/E3EQov+CB
TRAAspOLqi0SQ+8lFvXAoT1noJPr+SBEG+Mzb1gje6ed5/gnCz2gDmcmUCT7ocBXkgMlkrK95f4Z
+H/Z62e628ktG5v5wyUct8CkajL09x43qZw87+eADsXLXUZmDgFNTkJVnvSNtFd3vPGjkGM1xU/i
3Uv9flPquTQv/RUe55FofD9OOqdlYn65XIvpUjCUfOdVMp+erNSA47XMX/gywkOE7ss4kpWkxt4+
H7rlSnzIENkagF//115sMKefWXHNpebmZyT53gk9sJxfMrL7ZqW/ZMneHbx7fWfFFD1PWDoloEn4
h2yQKef5lQGggCYap6hcf5bLvmgDsr2gajgGZ5xidQ9ftp1dbfgTqzt9pHxSYVPsb9m3OODgFfMi
eed6gwx+IX3kr/WLeBhtF3SR+wAVn3bHcAbqgSgwC561L8JWoES+mwRxqjbupS+dagMedS42JSxG
ufvB6SvSCB0uwfGxDb86uSKAzS8tWd+/pD07TtI5QdI30dC6sAn1BYydq/upE97BouE5qQWZww9m
THbLoouS303gkVItpGfNQwn/HlfovrNmFCD6AoF43elyFJ2gSafTmSG99PhZE5xiDEf9JkbqDK7p
FYntb347Gr/EMDygWTgDsCD8FrOgLWWLJ/N5Ugr83dYmMtHUguwOxbzw11hKe2td3iXQKbTY0Ppo
7rY=
=uFlW
-----END PGP SIGNATURE-----

--yF8vVYrv1L4wXM302isskDlSalBbOgIwD--
