Return-Path: <linux-efi+bounces-550-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE0855BE2
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 08:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3031F232A1
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260311184;
	Thu, 15 Feb 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv+0mG+C"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73011DDAE;
	Thu, 15 Feb 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983799; cv=none; b=Wky1av8WlTdRI3xlBK0XJKSDAKlCtC8/whXTRxDz7+omxkQ6tKyxxyjBbyTIOnjulNkHchKvFlQygbzSCqJIlYkpHu8lz9m99ZwBMHrC0KTI6TpLYdUBErdk9BMdOFQf3wslczkjqgwthwgnweBFjf8u+o5NzictGZDzUiFYz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983799; c=relaxed/simple;
	bh=xfCSlQh3j9vziRPtoUADhlf5DGySWnxhTzmYirfEjQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/v7kMpDtLXykGRurrEA+YgFrFo8eOwEHGYK/xTqgU2TSw/Y50eqG0VpJ97mYfqb2CZMPyduG7fq34xcI4/nlyOGe4LZysZqm13c4appGrqHm2Vn+nbtgVYfsrQX/FZ9kXpQqYjs915ngAbZM18UawNYWDZ+tiGexo3K6CsmJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv+0mG+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81B0C43141;
	Thu, 15 Feb 2024 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707983798;
	bh=xfCSlQh3j9vziRPtoUADhlf5DGySWnxhTzmYirfEjQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dv+0mG+Cl9GeB0FTjPzOM3gI5demZy+pHuklwpTeWX9PHyM5hxNMa39Viqa7xglJX
	 AlkrOoDtYApixFgEZnN3tVpM6dzkB1H4gQOZVP2Wq7psPyHnhbQth19w9KXyluENcn
	 jgiSJDDuVgyR54gj6VEhj4niffZDsywBBSerIIbnpLdSzZzcpURfVe4URlvBdNCIdz
	 4YaTcJyzMNaoRyAs+8jU24i2ZrEdyal4CGLKbfnEA+5Qzu++ixaE2Fa0WinwWlMuTG
	 wQnec8rXuPUCepgbz6k8nwm1SLUm9EmF3XMa3UPB4i+kZtMU0JIHulStOI/zhqPZP5
	 z9rZrYs9tgSQA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511531f03f6so639974e87.0;
        Wed, 14 Feb 2024 23:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNMh/+roFBG3ssnL0lMR3HnbL2takR3P6GjdEhYak/WpqZ0ptrwpWiXOBAjOsS+lCnw3kWG7pvGh1qZwHCnt1jDUdv4coQvcZdFvOvkBxhTp8QqTuKXoKGIFbGM7UUBjkPD+7Yl0aV8uD7aukW3opdBYAQEyD0qmX+4AHnZAmxu1rgtZsRooYUTGgyULTYZh/tZJjmbxeyRXCXZQEwY7e+9LEo
X-Gm-Message-State: AOJu0YwB1caySH3ncamAwBq8rnKzbhZMeromuLBbdi7Z0L05kGccana9
	GYVaj7Dhx4W3R3EWQwNsuiwpupnA/3c+tPwR/kh+klE/zklw1p4Y1Y4y82gcCNVIFX5dZgwwbvg
	Llsw+QN+fKf8MYkW+t8MuMmyM0JA=
X-Google-Smtp-Source: AGHT+IFA6RWY4UG2hD5HrcveuMn0XzIXulhltm/OPlLpFX1tCGIskA3QzenmIrMy2g42ftRPvNAHNHzec8Ze0zvC/P8=
X-Received: by 2002:ac2:43cd:0:b0:512:87a2:adf6 with SMTP id
 u13-20020ac243cd000000b0051287a2adf6mr528637lfl.22.1707983796842; Wed, 14 Feb
 2024 23:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-2-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-2-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 08:56:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Message-ID: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.
>

Why? Is this information consumed by the bootloader?

I'd like to get away from x86 specific hacks for boot code and boot
images, so I would like to explore if we can avoid kernel_info, or at
least expose it in a generic way. We might just add a 32-bit offset
somewhere in the first 64 bytes of the bootable image: this could
co-exist with EFI bootable images, and can be implemented on arm64,
RISC-V and LoongArch as well.

> Since commit (note: commit ID from tip/master)
>
> commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")
>
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
>
>         .long   symbol
>
> will cause a linker error because this is not position-independent.
>
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
>
> To enable such use cases, put kernel_info into its own section which is
> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
>
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
>  arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/kernel_info.h
>
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..c18f07181dd5 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,23 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
> +#include "kernel_info.h"
>
> -       .section ".rodata.kernel_info", "a"
> +/*
> + * If a field needs to hold the offset of a symbol from the start
> + * of the image, use the macro below, eg
> + *     .long   rva(symbol)
> + * This will avoid creating run-time relocations, which are not
> + * allowed in the compressed kernel.
> + */
> +
> +#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
>
> -       .global kernel_info
> +       .section ".rodata.kernel_info", "a"
>
> -kernel_info:
> +       .balign 16
> +SYM_DATA_START(kernel_info)
>         /* Header, Linux top (structure). */
>         .ascii  "LToP"
>         /* Size. */
> @@ -19,4 +30,4 @@ kernel_info:
>
>  kernel_info_var_len_data:
>         /* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
> new file mode 100644
> index 000000000000..c127f84aec63
> --- /dev/null
> +++ b/arch/x86/boot/compressed/kernel_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
> +#define BOOT_COMPRESSED_KERNEL_INFO_H
> +
> +#ifdef CONFIG_X86_64
> +#define KERNEL_INFO_OFFSET 0x500
> +#else /* 32-bit */
> +#define KERNEL_INFO_OFFSET 0x100
> +#endif
> +
> +#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 083ec6d7722a..718c52f3f1e6 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>
>  #include <asm/cache.h>
>  #include <asm/page_types.h>
> +#include "kernel_info.h"
>
>  #ifdef CONFIG_X86_64
>  OUTPUT_ARCH(i386:x86-64)
> @@ -27,6 +28,11 @@ SECTIONS
>                 HEAD_TEXT
>                 _ehead = . ;
>         }
> +       .rodata.kernel_info KERNEL_INFO_OFFSET : {
> +               *(.rodata.kernel_info)
> +       }
> +       ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> +
>         .rodata..compressed : {
>                 *(.rodata..compressed)
>         }
> --
> 2.39.3
>

