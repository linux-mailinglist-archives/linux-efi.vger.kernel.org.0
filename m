Return-Path: <linux-efi+bounces-3461-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E590A9BE55
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 08:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7498B3AD91D
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54222B8A8;
	Fri, 25 Apr 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNoIwbbQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9022B8A4;
	Fri, 25 Apr 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560994; cv=none; b=bf9qWG1GNrRx6tsInudpMpylDEu82aM/44Sd5mMbKYAzRTVWNsPMLmxFOXwTFo0ad9QgeIO/vgtIoYM6W9UViLbVVbF8tk3tbRN+p1P/wkGkiZL0a+xVpRrPCdT3GQT2oB+Z7Q6UA6WRSwyaC/vIY52HJLR/pmhhkHSAVB9KVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560994; c=relaxed/simple;
	bh=r2J3cA0pT063PLl5H5eka1gbLIoeNfJZ+/mYvUer88c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkB8/duGlX/Saqdq9pLy/8Me1hpVOJDrgPbhmWK/IRDKmYEmKpS42rukavqCZk8p2PXvYkVcpsnz1AD/dq+OcwUmk9eXKtTN3XmK9xGEdZ2r7UvG0oTpLj6KZxZQ0PTTfv7n4ZJuRhO6iRyr8HTSWX9zK+DmSstAaOy6/pgSskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNoIwbbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC265C4CEEF;
	Fri, 25 Apr 2025 06:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745560993;
	bh=r2J3cA0pT063PLl5H5eka1gbLIoeNfJZ+/mYvUer88c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eNoIwbbQXtmKJZKSBEyK6bgiV6kR7LcWkB1XhOyFeZPA6VArt9oUv/yudm2ll4BXI
	 G59n4vPjK0oHtKUwxJ8J9CCrol0zYupCvQvsJBQx9XE4bwl6Y+uI4/bYiTVSIIIeOD
	 5d/tUIOAGpmoSySuBr4HrGWOWdKKHwn00MvMIqqg+HLhnfJYufBiDZPfaw4Xy+xowZ
	 5AcFJVJj/Cap+tshCzyzIbYEzZVkqMmGUtrxdLH98SCyM6GO19HhbIw0+xTR9DI0jn
	 m6k+vzPLEqCP/rDqRE0EsNES71ITXaHeKsrEoQOeAcB/o/4DhS3VCHGQjg3UisDyQm
	 EAP9NgohDBWMA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54addb5a139so1991800e87.0;
        Thu, 24 Apr 2025 23:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkpehMdvVWJp4FHSCGEj3DvX/Lkf5/vcheqSqq0jL+iGsbLfHz6tsJdJHWOBOjtRZ5fklxKFOaez/IqUnq@vger.kernel.org, AJvYcCXcWp+hsUsQe/+I5iVqFhWpFYOzGEBOKTYINwtr/+xCFfHXzoPY8aiXazD36AY2K5QkcrVlrDBWlms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6ADGemnfwqK+5bVCumV97+3KSL+9tVzezr2/5Sl9/ETIa7h9
	DSSgYKqgM+Y0TRv8c7KtKMx9mfbcbBPqj9Jf6+zq87Q2sFW5nGieCjI/A961E8T92IIheB9FENa
	zTWNVZFbwLHb+aDuQc/nieidc9uQ=
X-Google-Smtp-Source: AGHT+IHfS7m8/8+x2yqbY6VlV+NeRy4z8bEaciZ5/rwX/b/fR5bSbHp5zQJge7TAdo8tls7a26m5C652OdNNo2aXZXg=
X-Received: by 2002:a05:6512:3e0d:b0:545:532:fd2f with SMTP id
 2adb3069b0e04-54e8cbc3a5amr275937e87.12.1745560991943; Thu, 24 Apr 2025
 23:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-3-vkuznets@redhat.com>
In-Reply-To: <20250424080950.289864-3-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 25 Apr 2025 08:03:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
X-Gm-Features: ATxdqUGmOMQ0p_VMa0ytPtH193rO9yNiX2zUnIcrUmTzChL3SqzbuU3Y3IXs0TY
Message-ID: <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Similar to zboot architectures, implement support for embedding SBAT data
> for x86. Put '.sbat' section to the very end of the binary.
>
> Note, the obsolete CRC-32 checksum (see commit 9c54baab4401 ("x86/boot:
> Drop CRC-32 checksum and the build tool that generates it")) is gone and
> while it would've been possible to reserve the last 4 bytes in '.sbat'
> section too (like it's done today in '.data'), it seems to be a pointless
> exercise: SBAT makes zero sense without a signature on the EFI binary so
> '.sbat' won't be at the very end of the file anyway. Any tool which uses
> the last 4 bytes of the file as a checksum is broken with signed EFI
> binaries already.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/boot/Makefile                 |  2 +-
>  arch/x86/boot/compressed/Makefile      |  2 ++
>  arch/x86/boot/compressed/vmlinux.lds.S | 13 +++++++++++++
>  arch/x86/boot/header.S                 | 13 +++++++++++++
>  drivers/firmware/efi/Kconfig           |  2 +-
>  5 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 81f55da81967..5f7b52f0e7f5 100644
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
> index fdbce022db55..b9b80eccdc02 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
> +

Please drop this, and put the .incbin directly into header.S

>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>         $(call if_changed,ld)
>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 3b2bc61c9408..d0a27905de90 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -49,9 +49,22 @@ SECTIONS
>                 *(.data.*)
>
>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
> +#ifndef CONFIG_EFI_SBAT
>                 . = ALIGN(. + 4, 0x200);
> +#else
> +               /* Avoid gap between '.data' and '.sbat' */
> +               . = ALIGN(. + 4, 0x1000);
> +#endif
>                 _edata = . ;
>         }
> +#ifdef CONFIG_EFI_SBAT
> +       .sbat : ALIGN(0x1000) {
> +               _sbat = . ;
> +               *(.sbat)
> +               _esbat = ALIGN(0x200);
> +               . = _esbat;
> +       }
> +#endif
>         . = ALIGN(L1_CACHE_BYTES);
>         .bss : {
>                 _bss = . ;

This looks a bit odd - see below

> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index b5c79f43359b..ab851490ef74 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -207,6 +207,19 @@ pecompat_fstart:
>                 IMAGE_SCN_MEM_READ              | \
>                 IMAGE_SCN_MEM_WRITE             # Characteristics
>
> +#ifdef CONFIG_EFI_SBAT
> +       .ascii ".sbat\0\0\0"
> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
> +       .long   setup_size + ZO__sbat           # VirtualAddress
> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> +       .long   setup_size + ZO__sbat           # PointerToRawData
> +
> +       .long   0, 0, 0
> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> +               IMAGE_SCN_MEM_READ              | \
> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
> +#endif
> +

This puts the .sbat section at the very end of the file. However, the
virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
ZO__data', and so the .sbat section will overlap with .bss in the
memory view of the image.


>         .set    section_count, (. - section_table) / 40
>  #endif /* CONFIG_EFI_STUB */
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2edb0167ba49..5022a378fec1 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -283,7 +283,7 @@ config EFI_EMBEDDED_FIRMWARE
>
>  config EFI_SBAT
>         bool "Embed SBAT section in the kernel"
> -       depends on EFI_ZBOOT
> +       depends on EFI_ZBOOT || (EFI_STUB && X86)
>         help
>           SBAT section provides a way to improve SecureBoot revocations of UEFI
>           binaries by introducing a generation-based mechanism. With SBAT, older
> --
> 2.49.0
>
>

