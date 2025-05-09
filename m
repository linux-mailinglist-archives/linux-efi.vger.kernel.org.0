Return-Path: <linux-efi+bounces-3649-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EAFAB0ECD
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D1752085A
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61548274669;
	Fri,  9 May 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKRvGgZO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06B20E01B
	for <linux-efi@vger.kernel.org>; Fri,  9 May 2025 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782444; cv=none; b=TTZ+6grejOw8ZMOb/3In0Vv9bzQPmRwM+ZUo16kw2pBhLOqup7ebmse1KTFfO2JdtA1qQzh7lZ/pe0cN/pa+2tc1HtYCF5PO1uRFLagr/WzDRqdIvmQyJTKROa5DzyrDx5BF+ng7zotZH4AShv7dsIS7GA+jAaHiA9jIO2lUUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782444; c=relaxed/simple;
	bh=o/xV/KUTiFXf9sjWhjzd1caZJR+ciQzzsjxfl6TIL5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4dDzpa0RXUGuCe5cMDaVB3KO0lkPPXFUG/L+iDtgLQUMf0TbigZzej4HLF9igwUSnA0yI3kDSK2wH4WW9n+hadQ2JPZSL0TASaKXMRI2C+ZfjdWqZvkANDOQjZNmTY8pxOBdlF42cRuQISPKs179DAtw6ISEUpZtLLDZRGPjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKRvGgZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4996C4CEEE
	for <linux-efi@vger.kernel.org>; Fri,  9 May 2025 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746782443;
	bh=o/xV/KUTiFXf9sjWhjzd1caZJR+ciQzzsjxfl6TIL5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKRvGgZOZjGVbDrX4XvU9FUifxCG6/waMEvs/qry32QlS/jblQxwAbmn1Gkgg7Knu
	 9ru97/XQgjrQnIMbondSMUSfyqd6hsWzYc7NKU3CfQDJxAyWiY4r7yilz2/9hSFHl+
	 IWWsJP8A6swJHFKjgu8eQo3k5TM+hE6XJRd3zcwxuMAbBeS4iwqcNou+4Zftd7fj4M
	 1GiOY8Rhn91crmZTeyvGNLAtRDthJNBvJl3Ax6y2K0+yTgjkwYIshrBY5ha313nmj1
	 tuENB20SC7mxeasWgpSiwEWPwH7S18WjCdE3NUlRoI5nHKjn//1whJ0ax9/0PCc/04
	 AGm0IgIREXRaw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bef9b04adso16862971fa.1
        for <linux-efi@vger.kernel.org>; Fri, 09 May 2025 02:20:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8P5sg5nnES3rRXvCEKIUw4YuucoR3aDRzPbqH3JvjHcpCsT7f/RAs+bSRdWP0YrMpofHihqxhzpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyKKtcoWNvR7I33I58Zw0hdIKBAole3SPU8XPKCIMoWWchZL3
	2BTrV3HTmvzN/Kr28k42NTByBXYWxYJ2pY1dnINkmDfpOTPORxv8RVqlFAOrPgBG0mZcC72H1s2
	2gpeeCr81O97RcTEpHp/fUx9gpzM=
X-Google-Smtp-Source: AGHT+IG6Q6Mznhot7eLUEPUo3vkORJmLTxMMzNO0d5xPh8TwQXYrp1y7zEIEUjG5uj3LgWIaPgcWOl0pP2GU3pgX3yU=
X-Received: by 2002:a05:651c:198d:b0:30b:b28d:f0a6 with SMTP id
 38308e7fff4ca-326c45541camr11233831fa.8.1746782441928; Fri, 09 May 2025
 02:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505154523.231233-1-vkuznets@redhat.com> <20250505154523.231233-3-vkuznets@redhat.com>
In-Reply-To: <20250505154523.231233-3-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 May 2025 11:20:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE5iVsKSEcEPqJs4bZpB03FYR9OcstDVUKNax=2y8nsAg@mail.gmail.com>
X-Gm-Features: ATxdqUGsnMNpuEiTzvklBFSkar0sr0_oiIhxm7aJrfWyHfW2ZO9J80QoadW74sI
Message-ID: <CAMj1kXE5iVsKSEcEPqJs4bZpB03FYR9OcstDVUKNax=2y8nsAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Luca Boccassi <bluca@debian.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 17:46, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Similar to zboot architectures, implement support for embedding SBAT data
> for x86. Put '.sbat' section in between '.data' and '.text' as the former
> also covers '.bss' and '.pgtable' and thus must be the last one in the
> file.
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

Is this last paragraph still relevant? If not, please drop it.

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/boot/Makefile                 |  2 +-
>  arch/x86/boot/compressed/Makefile      |  5 ++++
>  arch/x86/boot/compressed/sbat.S        |  7 ++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  8 +++++++
>  arch/x86/boot/header.S                 | 33 +++++++++++++++++++-------
>  drivers/firmware/efi/Kconfig           |  2 +-
>  6 files changed, 46 insertions(+), 11 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/sbat.S
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
> index fdbce022db55..1441435869cc 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -106,6 +106,11 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
> +
> +ifdef CONFIG_EFI_SBAT
> +$(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
> +endif
>
>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>         $(call if_changed,ld)
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
> +       .pushsection ".sbat", "a", @progbits
> +       .incbin CONFIG_EFI_SBAT_FILE
> +       .popsection
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 3b2bc61c9408..587ce3e7c504 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -43,6 +43,14 @@ SECTIONS
>                 *(.rodata.*)
>                 _erodata = . ;
>         }
> +#ifdef CONFIG_EFI_SBAT
> +       .sbat : ALIGN(0x1000) {
> +               _sbat = . ;
> +               *(.sbat)
> +               _esbat = ALIGN(0x1000);
> +               . = _esbat;
> +       }
> +#endif
>         .data : ALIGN(0x1000) {
>                 _data = . ;
>                 *(.data)
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index b5c79f43359b..91964818bf50 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -179,15 +179,17 @@ pecompat_fstart:
>  #else
>         .set    pecompat_fstart, setup_size
>  #endif
> -       .ascii  ".text"
> -       .byte   0
> -       .byte   0
> -       .byte   0
> -       .long   ZO__data
> -       .long   setup_size
> -       .long   ZO__data                        # Size of initialized data
> -                                               # on disk
> -       .long   setup_size
> +       .ascii  ".text\0\0\0"
> +#ifdef CONFIG_EFI_SBAT
> +       .long   ZO__sbat                        # VirtualSize
> +       .long   setup_size                      # VirtualAddress
> +       .long   ZO__sbat                        # SizeOfRawData
> +#else
> +       .long   ZO__data                        # VirtualSize
> +       .long   setup_size                      # VirtualAddress
> +       .long   ZO__data                        # SizeOfRawData
> +#endif
> +       .long   setup_size                      # PointerToRawData

Would it work if we do the following here

#ifdef CONFIG_EFI_SBAT
  .set .Ltextsize, ZO__sbat
#else
  .set .Ltextsize, ZO__data
#endif

and keep a single section definition for .text

  .ascii  ".text\0\0\0"
  .long   .Ltextsize                  # VirtualSize
  .long   setup_size                  # VirtualAddress
  .long   .Ltextsize                  # SizeOfRawData
  .long   setup_size                  # PointerToRawData


>         .long   0                               # PointerToRelocations
>         .long   0                               # PointerToLineNumbers
>         .word   0                               # NumberOfRelocations
> @@ -196,6 +198,19 @@ pecompat_fstart:
>                 IMAGE_SCN_MEM_READ              | \
>                 IMAGE_SCN_MEM_EXECUTE           # Characteristics
>
> +#ifdef CONFIG_EFI_SBAT
> +       .ascii ".sbat\0\0\0"

Inconsistent indentation? ^^^

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
>         .ascii  ".data\0\0\0"
>         .long   ZO__end - ZO__data              # VirtualSize
>         .long   setup_size + ZO__data           # VirtualAddress
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index db8c5c03d3a2..16baa038d412 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -286,7 +286,7 @@ config EFI_SBAT
>
>  config EFI_SBAT_FILE
>         string "Embedded SBAT section file path"
> -       depends on EFI_ZBOOT
> +       depends on EFI_ZBOOT || (EFI_STUB && X86)
>         help
>           SBAT section provides a way to improve SecureBoot revocations of UEFI
>           binaries by introducing a generation-based mechanism. With SBAT, older
> --
> 2.49.0
>

Modulo the nits, I think this patch looks fine, but it will need to go
through the -tip tree.

So with the changes,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Ingo, Boris, given that this depends on the previous patch, mind
taking both via the -tip tree? I can take them too, but it doesn't
make sense splitting them up.

