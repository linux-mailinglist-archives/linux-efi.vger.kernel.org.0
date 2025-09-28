Return-Path: <linux-efi+bounces-4950-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AFBBA711D
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0509F18979DC
	for <lists+linux-efi@lfdr.de>; Sun, 28 Sep 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E22D73BF;
	Sun, 28 Sep 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6lhNJFd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715B24467A
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066927; cv=none; b=qRsxxhXNpEYNELuQEPZRuYycXJki9L2AF9x8FHrQy1E8wKzj6tCDGHZzBlx63wjX8cF2eRGdw4lsdzPtHeeCoTgLL6oq5RCCQ8UCIn4PckRomFczhG8v6n9N8de0RqP7l1To3JB2JJ2wL463G1tzAoEeZwnGqXALO5/Wa+MlHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066927; c=relaxed/simple;
	bh=b7lQZMpm3jaFTG6dtKVKcEubjwdkNUjuclDki/TIr1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch7CDbgMOoiPbtTFqEiYyr38pxE9ZB4Z/3h1ITuZnYQ66LnPCijZBZm5oQbNxavhakLi7b9YE+tKyGkh3Um7tghg1WPuflA/DwN7b2y8NEj366cXhAWCf48ikc12zmXYqI/elsMe53BknmLQ6Pj1CYCDpIvitKCNtca7pQctadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6lhNJFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDAC116B1
	for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759066927;
	bh=b7lQZMpm3jaFTG6dtKVKcEubjwdkNUjuclDki/TIr1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m6lhNJFdEkreSucB/dxMB91UrwJt6hhk8u7yLb3moYbEyO3YNCQDQpZeyjmsvdCA1
	 Toga5ITJofDzKTAiQhErydIP7701BjSfwg3kp6sXPKdL0m4FKAIWlEb4k0K6HA6oQj
	 0+VWp3z+6bod1kBnBzJ5bkEyJusUvXNqljcTimM988HiBmJi6VCN8FIGarZwKCEY17
	 2fMnLseHBVhWU0OvsUSNdzw3UGBQS59MU2Bb2Gyubs4sx/raxgTR21vYeCg9Ily9x/
	 zuP0FbPqRv/UjoEOb3hZUnkiKVF1LmvGr4AOcMAziRkQGBrGxpFbGkowGad8zuT8ui
	 zKfCcC33++BgA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso4823496e87.1
        for <linux-efi@vger.kernel.org>; Sun, 28 Sep 2025 06:42:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy21s+ei3eNnKoBVjn/FhsJRrvIP77/88Jnm547yjbBDfaecZnz/YJ8N5w0u77EirrB59emFpT0Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFlAXK9Xd1SdqeL/ei/99bOGj2/RivtHe1TgpOyZig5PZB/Ja
	NjkDxnTho0jkHbEBB6+e8pw6uqdLUpasVYeiaGiliBoHNvfhX9CbnIj2yrsFENhwtPJiivCVPJi
	rRwqxKENInMiUamOPZKhSRO6gL9CQg9g=
X-Google-Smtp-Source: AGHT+IENjnF+wQFCTm2WX/2LUMrC3xClXeEULM4n0/VRgHOOZVaGDYKViPHE16Jf9kIytcqTJZySM24jjWSQ6nTxM8g=
X-Received: by 2002:a05:6512:12d1:b0:57b:8a82:1dd0 with SMTP id
 2adb3069b0e04-582d0c28621mr4021018e87.15.1759066925407; Sun, 28 Sep 2025
 06:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250928085506.4471-1-yangtiezhu@loongson.cn>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Sep 2025 15:41:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
X-Gm-Features: AS18NWAAyvtoI8B9uL7arznbuV6ccfy2mwG4BGuL--lHKmdvv097Yi3SZbekg3Q
Message-ID: <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> the following objtool warning on LoongArch:
>
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>   falls through to next function __efistub_exit_boot_func()
>
> This is because efi_boot_kernel() doesn't end with a return instruction
> or an unconditional jump, then objtool has determined that the function
> can fall through into the next function.
>
> At the beginning, try to do something to make efi_boot_kernel() ends with
> an unconditional jump instruction, but this modification seems not proper.
>
> Since the efistub functions are useless for stack unwinder, they can be
> ignored by objtool. After many discussions, no need to link libstub to
> the vmlinux.o, only link libstub to the final vmlinux.
>

Please try keeping these changes confined to arch/loongarch. This
problem does not exist on other architectures, and changing the way
vmlinux is constructed might create other issues down the road.

> Do the similar things for arm64 and riscv, otherwise there may be objtool
> warnings when arm64 and riscv support objtool, this is to make consistent
> with the archs that use libstub.
>
> Link: https://lore.kernel.org/lkml/pq4h7jgndnt6p45lj4kgubxjd5gidfetugcuf5rcxzxxanzetd@6rrlpjnjsmuy/
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Makefile                | 1 +
>  arch/arm64/Makefile     | 5 ++++-
>  arch/loongarch/Makefile | 5 ++++-
>  arch/riscv/Makefile     | 5 ++++-

>  scripts/link-vmlinux.sh | 5 ++---
>  5 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 10355ecf32cb..8ba2e28ef3d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1201,6 +1201,7 @@ KBUILD_VMLINUX_OBJS := built-in.a $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)
>  KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
>
>  export KBUILD_VMLINUX_LIBS
> +export KBUILD_VMLINUX_LIBS_PRELINK
>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 73a10f65ce8b..038f37ef2143 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -156,7 +156,10 @@ KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
>  KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
>
>  libs-y         := arch/arm64/lib/ $(libs-y)
> -libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +
> +ifdef CONFIG_EFI_STUB
> +KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +endif
>
>  # Default target when executing plain make
>  boot           := arch/arm64/boot
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae419e32f22e..4eb904c20718 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -169,7 +169,10 @@ CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev
>  endif
>
>  libs-y += arch/loongarch/lib/
> -libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +
> +ifdef CONFIG_EFI_STUB
> +KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +endif
>
>  drivers-y              += arch/loongarch/crypto/
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index df57654a615e..cfd82b2c1bbf 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -173,7 +173,10 @@ boot-image-$(CONFIG_XIP_KERNEL)            := xipImage
>  KBUILD_IMAGE                           := $(boot)/$(boot-image-y)
>
>  libs-y += arch/riscv/lib/
> -libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +
> +ifdef CONFIG_EFI_STUB
> +KBUILD_VMLINUX_LIBS_PRELINK += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +endif
>
>  ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 51367c2bfc21..b3cbff31d8a9 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -61,12 +61,11 @@ vmlinux_link()
>         shift
>
>         if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
> -               # Use vmlinux.o instead of performing the slow LTO link again.
>                 objs=vmlinux.o
> -               libs=
> +               libs="${KBUILD_VMLINUX_LIBS_PRELINK}"
>         else
>                 objs=vmlinux.a
> -               libs="${KBUILD_VMLINUX_LIBS}"
> +               libs="${KBUILD_VMLINUX_LIBS} ${KBUILD_VMLINUX_LIBS_PRELINK}"
>         fi
>
>         if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
> --
> 2.42.0
>

