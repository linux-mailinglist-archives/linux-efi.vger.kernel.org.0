Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8733B44CE
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jun 2021 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYNwb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Jun 2021 09:52:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYNwb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Jun 2021 09:52:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4CC1FEB1;
        Fri, 25 Jun 2021 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624629009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfnlS15RrNFfHyhCpr++dUI4/ws9IVuoU7lK6wuUydg=;
        b=OFPKS7EeYghIBLJqYNPJRYsf+/C04229ZPkzfO9T+fbk/hEMWvul2818MkxwHt4yYLn9Xn
        r1agVm0UrWqCuyhzJn4W+4K8l1BUC8M0zCoMJEZGKkwpK34myFH1mvaoxHlr23vo818Fre
        EHOxpF6ahnUU6drVfNRXnGDfLNbzWg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624629009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfnlS15RrNFfHyhCpr++dUI4/ws9IVuoU7lK6wuUydg=;
        b=97y6sI4HVncejCehMX6ZeZoUHEZpht2FRk5LOIXJ6HfBvWFGHL/kI699OSj43d8lEMqbTd
        zqjTHap9Ut+CaPBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EA0E411A97;
        Fri, 25 Jun 2021 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624629009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfnlS15RrNFfHyhCpr++dUI4/ws9IVuoU7lK6wuUydg=;
        b=OFPKS7EeYghIBLJqYNPJRYsf+/C04229ZPkzfO9T+fbk/hEMWvul2818MkxwHt4yYLn9Xn
        r1agVm0UrWqCuyhzJn4W+4K8l1BUC8M0zCoMJEZGKkwpK34myFH1mvaoxHlr23vo818Fre
        EHOxpF6ahnUU6drVfNRXnGDfLNbzWg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624629009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfnlS15RrNFfHyhCpr++dUI4/ws9IVuoU7lK6wuUydg=;
        b=97y6sI4HVncejCehMX6ZeZoUHEZpht2FRk5LOIXJ6HfBvWFGHL/kI699OSj43d8lEMqbTd
        zqjTHap9Ut+CaPBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uYzaNhDf1WBfAwAALh3uQQ
        (envelope-from <tzimmermann@suse.de>); Fri, 25 Jun 2021 13:50:08 +0000
Subject: Re: [PATCH v3 2/2] drivers/firmware: consolidate EFI framebuffer
 setup for all arches
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel@lists.freedesktop.org, Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210625131359.1804394-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <7f3e5dc0-a076-8a82-3d91-5207fa885783@suse.de>
Date:   Fri, 25 Jun 2021 15:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625131359.1804394-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p9FuICdsovVBpDO5ytPbJc5V2A2thUmSx"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p9FuICdsovVBpDO5ytPbJc5V2A2thUmSx
Content-Type: multipart/mixed; boundary="njjy5VVNfF2pYGnPItAENVLWRZaLZL7Cj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Peter Robinson <pbrobinson@gmail.com>,
 Borislav Petkov <bp@suse.de>, Albert Ou <aou@eecs.berkeley.edu>,
 Hans de Goede <hdegoede@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <7f3e5dc0-a076-8a82-3d91-5207fa885783@suse.de>
Subject: Re: [PATCH v3 2/2] drivers/firmware: consolidate EFI framebuffer
 setup for all arches
References: <20210625131359.1804394-1-javierm@redhat.com>
In-Reply-To: <20210625131359.1804394-1-javierm@redhat.com>

--njjy5VVNfF2pYGnPItAENVLWRZaLZL7Cj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 25.06.21 um 15:13 schrieb Javier Martinez Canillas:
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
> Acked-by: Borislav Petkov <bp@suse.de>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>=20
> Changes in v3:
> - Also update the SYSFB_SIMPLEFB symbol name in drivers/gpu/drm/tiny/Kc=
onfig.
> - We have a a max 100 char limit now, use it to avoid multi-line statem=
ents.
> - Figure out the platform device name before allocating the platform de=
vice.
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
>   drivers/firmware/efi/sysfb_efi.c  | 76 +++++++++++++++++++++++++-
>   drivers/firmware/sysfb.c          | 35 ++++++++----
>   drivers/firmware/sysfb_simplefb.c | 31 +++++++----
>   drivers/gpu/drm/tiny/Kconfig      |  4 +-
>   include/linux/sysfb.h             | 26 ++++-----
>   11 files changed, 143 insertions(+), 144 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 9de7ab2ce05d..a6f3b179e8a9 100644
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
> index 1bed37eb013a..d3e1825337be 100644
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
> index 6d98cd999680..7a8f0d45b13a 100644
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
> index 5991071e9d7f..6822727a5e98 100644
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
> index 946dda07443d..705fabe88156 100644
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
> index a552a08a1741..b19ce1a83f91 100644
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
> index 9f035b15501c..f51865e1b876 100644
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
> @@ -281,4 +348,9 @@ __init void sysfb_apply_efi_quirks(void)
>   		screen_info.lfb_height =3D temp;
>   		screen_info.lfb_linelength =3D 4 * screen_info.lfb_width;
>   	}
> +
> +	if (screen_info.orig_video_isVGA =3D=3D VIDEO_TYPE_EFI && IS_ENABLED(=
CONFIG_PCI)) {
> +		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
> +		pd->dev.fwnode =3D &efifb_fwnode;
> +	}
>   }
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 1337515963d5..2bfbb05f7d89 100644
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
> @@ -43,12 +43,10 @@ static __init int sysfb_init(void)
>   	bool compatible;
>   	int ret;
>  =20
> -	sysfb_apply_efi_quirks();
> -
>   	/* try to create a simple-framebuffer device */
> -	compatible =3D parse_mode(si, &mode);
> +	compatible =3D sysfb_parse_mode(si, &mode);
>   	if (compatible) {
> -		ret =3D create_simplefb(si, &mode);
> +		ret =3D sysfb_create_simplefb(si, &mode);
>   		if (!ret)
>   			return 0;
>   	}
> @@ -61,9 +59,24 @@ static __init int sysfb_init(void)
>   	else
>   		name =3D "platform-framebuffer";
>  =20
> -	pd =3D platform_device_register_resndata(NULL, name, 0,
> -					       NULL, 0, si, sizeof(*si));
> -	return PTR_ERR_OR_ZERO(pd);
> +	pd =3D platform_device_alloc(name, 0);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	sysfb_apply_efi_quirks(pd);
> +
> +	ret =3D platform_device_add_data(pd, si, sizeof(*si));
> +	if (ret)
> +		goto err;
> +
> +	ret =3D platform_device_add(pd);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	platform_device_put(pd);
> +	return ret;
>   }
>  =20
>   /* must execute after PCI subsystem for EFI quirks */
> diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb=
_simplefb.c
> index df892444ea17..b86761904949 100644
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
> +				 const struct simplefb_platform_data *mode)
>   {
>   	struct platform_device *pd;
>   	struct resource res;
>   	u64 base, size;
>   	u32 length;
> +	int ret;
>  =20
>   	/*
>   	 * If the 64BIT_BASE capability is set, ext_lfb_base will contain th=
e
> @@ -105,7 +106,19 @@ __init int create_simplefb(const struct screen_inf=
o *si,
>   	if (res.end <=3D res.start)
>   		return -EINVAL;
>  =20
> -	pd =3D platform_device_register_resndata(NULL, "simple-framebuffer", =
0,
> -					       &res, 1, mode, sizeof(*mode));
> -	return PTR_ERR_OR_ZERO(pd);
> +	pd =3D platform_device_alloc("simple-framebuffer", 0);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	sysfb_apply_efi_quirks(pd);
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
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfi=
g
> index d46f95d9196d..3583ae598b57 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -51,8 +51,8 @@ config DRM_SIMPLEDRM
>   	  buffer, size, and display format must be provided via device tree,=

>   	  UEFI, VESA, etc.
>  =20
> -	  On x86 and compatible, you should also select CONFIG_X86_SYSFB to
> -	  use UEFI and VESA framebuffers.
> +	  On x86 BIOS or UEFI systems, you should also select SYSFB_SIMPLEFB
> +	  to use UEFI and VESA framebuffers.
>  =20
>   config TINYDRM_HX8357D
>   	tristate "DRM support for HX8357D display panels"
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 3e5355769dc3..b0dcfa26d07b 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -58,37 +58,37 @@ struct efifb_dmi_info {
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
> +			  const struct simplefb_platform_data *mode);
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
> +					 const struct simplefb_platform_data *mode)
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


--njjy5VVNfF2pYGnPItAENVLWRZaLZL7Cj--

--p9FuICdsovVBpDO5ytPbJc5V2A2thUmSx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDV3xAFAwAAAAAACgkQlh/E3EQov+A9
uw//Wqc5OjYJeOLAURaW71DAU1nE4FrpL8H8Y97jzMNJZsDc2RltpMgF6Af4arWKm9OHbUJmQxYj
pOis00wcw/DWL33jvKviCiXl5oGJY00vInulczGObu0zQq6KS0KHVHHKcHV6PEpczq0o4agqmFC7
oEGU3GhD4sQxNAN8PxQoWebqSpxfXNKvLoU+hGcXsxdzSZYXY9uGWgGamFLR6KEremP8833detHN
SlTPNSyif8EoLKgDRFtYQ0N1oluUT3pRQA2tsQBf7WnTnhicvxIiHsuhZf6RPKMkWCHtNKI+J3qS
WDUGWPyDLpLP10x1ebHYhZrBav5visU8PJ8zh1bsO8b1xgWZncpjQhC60ivu1MaQyA7jQHdw/N1q
tlF2iNGcPlKl4TaZVhSTByNKRWwkBNohAMYi8Ddjh0vq6yQxAPztw5IK8MDZlMvzn3GyKDQUkILG
DDfb4801mTMJXknI6ahXi5abwh3oEpjaAT9bZ9L/pO8RH9otIsBPFEpvQburM2Sime9hJxu9zSIS
ihJWBTH/1jxRb06CNhJDPPbwHtajDvZEyYuB52B9Wl9EYtndJYHdmcz3UQ8IR4RUaJl5ejZTXAOU
KQg+n9OZtvm+oWABIU/gJFzQzCWmyfYaqRcUTkgF5OgVOoAmKxYPSopbYjoIAJT6bk50keQojele
7SE=
=WTNY
-----END PGP SIGNATURE-----

--p9FuICdsovVBpDO5ytPbJc5V2A2thUmSx--
