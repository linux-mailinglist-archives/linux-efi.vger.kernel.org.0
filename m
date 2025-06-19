Return-Path: <linux-efi+bounces-3836-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64923AE0A47
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jun 2025 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7E1C21EDB
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jun 2025 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502522686F;
	Thu, 19 Jun 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJj70iE5"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156720AF98
	for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346149; cv=none; b=LfDfGzcWQ+anh3Lk8PW8SYvEl09glRieR4VROfn2Qdgf9vWPQ5VF2Wnt0ppm6Qt7ZqejjqH3aWX1vMrcYLQdwBqVk0iL/j1oxkTQHJwBpR0n6xdvva4rPBpk3z4WBOS5Q4qY12rb/usex6S0VZSiX3LDHuwJyP6aA/SXTk+snog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346149; c=relaxed/simple;
	bh=j36Lv0XwSdPSrL89TG1Za9YH/KmyQpaNDxFLdLJkcmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WfF0/Uigpy8LAXZWUKKpKAHtrdMnyytEpDN0+Dz7yz0UPNinRFbbvWuHimzrvtC15udmH6QxEZVOuenrHOYVOV1UNceIOgpT7MvAr803CEGRZAYFrbfA+gSQS/8R0DUWfhqoQ6ZqUFBLMl3XZtg9y4Aim06e9YAEkGoxNjPEPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJj70iE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750346146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnmNnV7Z/TLBli2AzSqmjfw6jzjBv10gklg2gPq0gb0=;
	b=EJj70iE5dHpES9Zp7FrQYoLpXXgAtewFLVPYCLVeF4BOzH1e7mxR+VPYNQ51xRzLFgk0AK
	iVHnls05cDIZtC4GKU1cSz11ocEKNgvckM/VJumT4Pp3dbnvm07iZ1CqBPHAf3nx/v5FO9
	Nx46W7TtFv1HTz/+/LmX/Qes7wEeoCs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-qKCsshqVOBSQL_EUpOsx-g-1; Thu, 19 Jun 2025 11:15:44 -0400
X-MC-Unique: qKCsshqVOBSQL_EUpOsx-g-1
X-Mimecast-MFC-AGG-ID: qKCsshqVOBSQL_EUpOsx-g_1750346143
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so416055f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 19 Jun 2025 08:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750346143; x=1750950943;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnmNnV7Z/TLBli2AzSqmjfw6jzjBv10gklg2gPq0gb0=;
        b=Nb6nO808H7yMmfFQ88QusjKzS9tmRzvbxEE7ZzNPubag7jeJRUIyMfd6mcWYj9DsLT
         pXh6tNUJUIRKOR/Vyt/T5J6obBAuxzVtg8RW+mBeoWvjzks1kbPYIfB3j5+LsAgLhW+c
         cCQXRU+xHHP2CnHHUxiuR+ezgvqpov6ElUxyOdHsZRQLLZoXCOnAI0gxxRdTI99l2ZjU
         HvAN9FiHCGI4oQQZCDP77Y2oODGe7md21FMP8hM62mJWmZbn8/Vk58nOOgPwEUn8awBu
         eWu5HUIGT3HvMOdCR+S61eKprLlZvIfHPQu4QGsLJK46ZFiHuO3FOgFoZqc74rCYyKX+
         vD4A==
X-Gm-Message-State: AOJu0YwdqCkIA5OYg6U5uraZ6C+kGLQPB3w68tBi6diK8Cb5d//hEo0U
	cVLS2KHx+CWhYdNImHRTA7knCLMbdwcoHu74FZiK4Rrjzm7OsHeuVgPOmgXHukFBMLn0Xyj8tUY
	2BS7bWIpI6EhgqnYI6wLcFal/Kqbkyh4Q8zxnzZte0EZEvL7ytgtqNHA9BtanVQ==
X-Gm-Gg: ASbGncvkfDWRIV/wz5d3NZ1pf/YaWHfc3PW7BUFVaVgwsp6fTTtSyK2tONtpYlu6iwD
	N1GUbgE1wPWquOC7atCesL3O/QQNO2oP0MI+OxY37+c6jw7vffdIrehtZmCCA2DvmWutsFo2HIP
	9mHi6805sNc48IQI6CNPFDsfvvQHZ0x30sj+ITmjeFcPl6pQNAymSH5CbsjJgOiT1pBiAiOmboE
	kv4UYDCFGqJP+UxHRDhNfQRy4gpDFdspamsJPl8aGSZZxM/ZFup5e6amlJD+qcDrXIYxUwDzGok
	cOFS8w8lEDmzrwuCfw==
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a572e58cc9mr17568918f8f.49.1750346142874;
        Thu, 19 Jun 2025 08:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2K4PWQRzuCGry5KAaSLw6cXzGCxwA9qri8LLp3blZHp1BJwjQA2vM0xwmkkHJC9VIuXCw6A==
X-Received: by 2002:a05:6000:144e:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a572e58cc9mr17568863f8f.49.1750346142292;
        Thu, 19 Jun 2025 08:15:42 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm19617640f8f.26.2025.06.19.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:15:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Jones
 <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, Emanuele
 Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi
 <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, Matthew Garrett
 <mjg59@srcf.ucam.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] x86/efi: Implement support for embedding SBAT
 data for x86
In-Reply-To: <20250603091951.57775-1-vkuznets@redhat.com>
References: <20250603091951.57775-1-vkuznets@redhat.com>
Date: Thu, 19 Jun 2025 17:15:40 +0200
Message-ID: <877c17pxsz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Similar to zboot architectures, implement support for embedding SBAT data
> for x86. Put '.sbat' section in between '.data' and '.text' as the former
> also covers '.bss' and '.pgtable' and thus must be the last one in the
> file.
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> The patch was previously sent as part of "[PATCH v3 0/2] efi: Add a
>  mechanism for embedding SBAT section" series. The main patch has
> already made it upstream through Ard's 'efi' tree (see commit 0f9a1739dd0e
> "efi: zboot specific mechanism for embedding SBAT section") but x86 part
> is still pending. Resending so it doesn't get lost.
>

I was going to ping again but while working on a (mostly unrelated)
zboot issue:
https://lore.kernel.org/linux-efi/20250618122008.264294-1-vkuznets@redhat.com/T/#u

I noticed that in x86 SBAT patch I neglected to update optional PE
header and '.sbat' section is accounted as part of 'SizeOfCode' instead
of 'SizeOfInitializedData'. OVMF doesn't seem to care about the optional
header and I don't really know who does but as the patch is not merged
yet, I think it would be better to fix. The differential change is:

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9bea5a1e2c52..f57c45d8584a 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -78,9 +78,9 @@ optional_header:
        .byte   0x02                            # MajorLinkerVersion
        .byte   0x14                            # MinorLinkerVersion
 
-       .long   ZO__data                        # SizeOfCode
+       .long   textsize                        # SizeOfCode
 
-       .long   ZO__end - ZO__data              # SizeOfInitializedData
+       .long   ZO__end - textsize              # SizeOfInitializedData
        .long   0                               # SizeOfUninitializedData
 
        .long   setup_size + ZO_efi_pe_entry    # AddressOfEntryPoint

I'm going to send v4 with this change included.

>  arch/x86/boot/Makefile                 |  2 +-
>  arch/x86/boot/compressed/Makefile      |  5 +++++
>  arch/x86/boot/compressed/sbat.S        |  7 ++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  8 +++++++
>  arch/x86/boot/header.S                 | 31 ++++++++++++++++++--------
>  drivers/firmware/efi/Kconfig           |  2 +-
>  6 files changed, 44 insertions(+), 11 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/sbat.S
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 640fcac3af74..3f9fb3698d66 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>  
>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>  
> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>  
>  quiet_cmd_zoffset = ZOFFSET $@
>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index f4f7b22d8113..3a38fdcdb9bd 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -106,6 +106,11 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  vmlinux-libs-$(CONFIG_X86_64)	+= $(objtree)/arch/x86/boot/startup/lib.a
> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
> +
> +ifdef CONFIG_EFI_SBAT
> +$(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
> +endif
>  
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>  	$(call if_changed,ld)
> diff --git a/arch/x86/boot/compressed/sbat.S b/arch/x86/boot/compressed/sbat.S
> new file mode 100644
> index 000000000000..838f70a997dd
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sbat.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Embed SBAT data in the kernel.
> + */
> +	.pushsection ".sbat", "a", @progbits
> +	.incbin CONFIG_EFI_SBAT_FILE
> +	.popsection
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 3b2bc61c9408..587ce3e7c504 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -43,6 +43,14 @@ SECTIONS
>  		*(.rodata.*)
>  		_erodata = . ;
>  	}
> +#ifdef CONFIG_EFI_SBAT
> +	.sbat : ALIGN(0x1000) {
> +		_sbat = . ;
> +		*(.sbat)
> +		_esbat = ALIGN(0x1000);
> +		. = _esbat;
> +	}
> +#endif
>  	.data :	ALIGN(0x1000) {
>  		_data = . ;
>  		*(.data)
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index e1f4fd5bc8ee..9bea5a1e2c52 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -179,15 +179,11 @@ pecompat_fstart:
>  #else
>  	.set	pecompat_fstart, setup_size
>  #endif
> -	.ascii	".text"
> -	.byte	0
> -	.byte	0
> -	.byte	0
> -	.long	ZO__data
> -	.long	setup_size
> -	.long	ZO__data			# Size of initialized data
> -						# on disk
> -	.long	setup_size
> +	.ascii	".text\0\0\0"
> +	.long	textsize            		# VirtualSize
> +	.long	setup_size			# VirtualAddress
> +	.long	textsize			# SizeOfRawData
> +	.long	setup_size			# PointerToRawData
>  	.long	0				# PointerToRelocations
>  	.long	0				# PointerToLineNumbers
>  	.word	0				# NumberOfRelocations
> @@ -196,6 +192,23 @@ pecompat_fstart:
>  		IMAGE_SCN_MEM_READ		| \
>  		IMAGE_SCN_MEM_EXECUTE		# Characteristics
>  
> +#ifdef CONFIG_EFI_SBAT
> +	.ascii	".sbat\0\0\0"
> +	.long	ZO__esbat - ZO__sbat            # VirtualSize
> +	.long	setup_size + ZO__sbat           # VirtualAddress
> +	.long	ZO__esbat - ZO__sbat            # SizeOfRawData
> +	.long	setup_size + ZO__sbat           # PointerToRawData
> +
> +	.long	0, 0, 0
> +	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
> +
> +	.set	textsize, ZO__sbat
> +#else
> +	.set	textsize, ZO__data
> +#endif
> +
>  	.ascii	".data\0\0\0"
>  	.long	ZO__end - ZO__data		# VirtualSize
>  	.long	setup_size + ZO__data		# VirtualAddress
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index db8c5c03d3a2..16baa038d412 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -286,7 +286,7 @@ config EFI_SBAT
>  
>  config EFI_SBAT_FILE
>  	string "Embedded SBAT section file path"
> -	depends on EFI_ZBOOT
> +	depends on EFI_ZBOOT || (EFI_STUB && X86)
>  	help
>  	  SBAT section provides a way to improve SecureBoot revocations of UEFI
>  	  binaries by introducing a generation-based mechanism. With SBAT, older

-- 
Vitaly


