Return-Path: <linux-efi+bounces-3993-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56DAE85D7
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD318890E1
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C070264A9C;
	Wed, 25 Jun 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HExtZW+T"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F2188715;
	Wed, 25 Jun 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860718; cv=none; b=cNh2AVqLHYHGcXLy3bZFyM6NXv/fRvi1SlDf/wPLd+IGpa9vTIdb62b9ZeP0qZRDXdmqzUoj0VIusvYXn6LwZYDnmmij+wKLHcRLY2GV0HvSAZhGaNZz6bwPo0THXQKf72EKVgjaLBoVH7hTF6J5jCfH2nl4EHGajP2YI9rOe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860718; c=relaxed/simple;
	bh=ydo2ZEycKIerkKDbl9l9TAKEUvkjjljuXIhPvWsDuF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL/9cKURI629/VlUPVRJbyeAWm4W7n8Uuyw/RhYSA92Q8Vb5sl3tq/O+9hHgQJixkBgs3U+95Lvmco7OctElmlw+WUiKsm2BXwK3IQuE2n6KjjKXWJd7BSgcS5xkbgNArDSmEcb/rjcNepuXWrR+R9WVIS3cKgodgcN337SZV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HExtZW+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C09BC4CEEB;
	Wed, 25 Jun 2025 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860718;
	bh=ydo2ZEycKIerkKDbl9l9TAKEUvkjjljuXIhPvWsDuF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HExtZW+T85Lle2Z7nUb8pQQ5hb76Fnn1c5nwck0n07oOKF+i08w8CNq1m8lEcRc2X
	 P4WF33RIRQ8camLQvrsUr3TT8BmdYZtabuZT/by+LNzQdVoSegSEJSMy1LGGdqiFlQ
	 RpcH9d27tTx+F9GzdGnO+pofEXOWK5YE3I3n/VEaU8egvO95QJebasDB5Kg1Yg/U9/
	 pTx8KEdM5xYqNXIgFvZ8gvvD1VQfwLKttsgTdywRoMXrT6XJrRh0sN6YrNOUq7usVA
	 qV9Pz2ou97o3kIRgis7HqVPV45653KjokaV1GAeLTxcp7JlAEmGfq/zTYQQMJjSGCo
	 8FQHM0pjc+Wcw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-555024588b0so114058e87.3;
        Wed, 25 Jun 2025 07:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUahgFjJ8/6bLxjW7Qvgnv4yxSnS8QB0+jLgQFoEbTMdAX5kdZp290baSJWjEh2j8X6LFy5ou6L1Wo=@vger.kernel.org, AJvYcCVw8bFmGE9tkB+7oeZTFL7nTeXqOD+KEyFyWhT97bssBoiF5GcilbAVQQKHQ2rIz1FC29TdLPrTWTT4AKEP@vger.kernel.org, AJvYcCX8a3iiVkRx3Xx6hm+JGfmg2sqajaTcGDFe4NuqUasjqwysw1cHXvVnGibYN8awQ53h07KN8JK9eApexqf/@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVI4rCinn7zrIjkY3dq1QMyfYk5rzL51Oyx6FvhXT9cnJ+LFJ
	6dyvJP8+6krD4t46hR47K69TRAjDwmA/x+fVKV9ypAW0sipQur7nf59AO/+KELljwzgYMGCng6p
	wZq220keSiWgS0N2iOp68TccfiimktgQ=
X-Google-Smtp-Source: AGHT+IFNJVqQORy+745pCk5ps8bt7Hvz1Ly+xQOtAVtlxVCDnsn2OzbFr24T/jaUutdSCtTFY7dBgOD1BX7yACDHGkY=
X-Received: by 2002:a05:6512:3f0b:b0:554:f74e:9f10 with SMTP id
 2adb3069b0e04-554fde57615mr1297929e87.28.1750860716386; Wed, 25 Jun 2025
 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625125555.2504734-1-masahiroy@kernel.org>
In-Reply-To: <20250625125555.2504734-1-masahiroy@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Jun 2025 16:11:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUcQ2QpFMB8dfm=0q6yzUSBrxs_Xuo4q7HWPrp-f-+DQ@mail.gmail.com>
X-Gm-Features: Ac12FXygtnelNOU0Vpn-lYagNY9g6kFU_cK7b4VwWiynjWBXKArEkjipyRdIz3o
Message-ID: <CAMj1kXGUcQ2QpFMB8dfm=0q6yzUSBrxs_Xuo4q7HWPrp-f-+DQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unnecessary rebuilding when CONFIG_DEBUG_EFI=y
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 14:56, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When CONFIG_DEBUG_EFI is enabled, some objects are needlessly rebuilt.
>
> [Steps to reproduce]
>
>   Enable CONFIG_DEBUG_EFI and run 'make' twice in a clean source tree.
>   On the second run, arch/arm64/kernel/head.o is rebuilt even though
>   no files have changed.
>
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- clean
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>      [ snip ]
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>     CALL    scripts/checksyscalls.sh
>     AS      arch/arm64/kernel/head.o
>     AR      arch/arm64/kernel/built-in.a
>     AR      arch/arm64/built-in.a
>     AR      built-in.a
>      [ snip ]
>
> The issue is caused by the use of the $(realpath ...) function.
>
> At the time arch/arm64/kernel/Makefile is parsed on the first run,
> $(objtree)/vmlinux does not exist. As a result,
> $(realpath $(objtree)/vmlinux) expands to an empty string.
>
> On the second run of Make, $(objtree)/vmlinux already exists, so
> $(realpath $(objtree)/vmlinux) expands to the absolute path of vmlinux.
> However, this change in the command line causes arch/arm64/kernel/head.o
> to be rebuilt.
>
> To address this issue, use $(abspath ...) instead, which does not require
> the file to exist. While $(abspath ...) does not resolve symlinks, this
> should be fine from a debugging perspective.
>
> The GNU Make manual [1] clearly explains the difference between the two:
>
>   $(realpath names...)
>     For each file name in names return the canonical absolute name.
>     A canonical name does not contain any . or .. components, nor any
>     repeated path separators (/) or symlinks. In case of a failure the
>     empty string is returned. Consult the realpath(3) documentation for
>     a list of possible failure causes.
>
>   $(abspath namees...)
>     For each file name in names return an absolute name that does not
>     contain any . or .. components, nor any repeated path separators (/).
>     Note that, in contrast to realpath function, abspath does not resolve
>     symlinks and does not require the file names to refer to an existing
>     file or directory. Use the wildcard function to test for existence.
>
> The same problem exists in drivers/firmware/efi/libstub/Makefile.zboot.
> On the first run of Make, $(obj)/vmlinuz.efi.elf does not exist when the
> Makefile is parsed, so -DZBOOT_EFI_PATH is set to an empty string.
> Replace $(realpath ...) with $(abspath ...) there as well.
>
> [1]: https://www.gnu.org/software/make/manual/make.html#File-Name-Functions
>
> Fixes: 757b435aaabe ("efi: arm64: Add vmlinux debug link to the Image binary")
> Fixes: a050910972bb ("efi/libstub: implement generic EFI zboot")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/arm64/kernel/Makefile                  | 2 +-
>  drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 2920b0a51403..a2604c33f35c 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -81,7 +81,7 @@ obj-y                                 += head.o
>  always-$(KBUILD_BUILTIN)               += vmlinux.lds
>
>  ifeq ($(CONFIG_DEBUG_EFI),y)
> -AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
> +AFLAGS_head.o += -DVMLINUX_PATH="\"$(abspath vmlinux)\""
>  endif
>
>  # for cleaning
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> index 92e3c73502ba..832deee36e48 100644
> --- a/drivers/firmware/efi/libstub/Makefile.zboot
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -36,7 +36,7 @@ aflags-zboot-header-$(EFI_ZBOOT_FORWARD_CFI) := \
>                 -DPE_DLL_CHAR_EX=IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT
>
>  AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
> -                        -DZBOOT_EFI_PATH="\"$(realpath $(obj)/vmlinuz.efi.elf)\"" \
> +                        -DZBOOT_EFI_PATH="\"$(abspath $(obj)/vmlinuz.efi.elf)\"" \
>                          -DZBOOT_SIZE_LEN=$(zboot-size-len-y) \
>                          -DCOMP_TYPE="\"$(comp-type-y)\"" \
>                          $(aflags-zboot-header-y)
> --
> 2.43.0
>

