Return-Path: <linux-efi+bounces-1271-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F859122ED
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB4F282971
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD916C841;
	Fri, 21 Jun 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvDLOWjg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6129A5;
	Fri, 21 Jun 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967662; cv=none; b=OHivMqP1v03fIhzLkcci8ceLJdsFoVFfO6ghoV8TmisQ+Hka9syDHLnjSPnD1+Q1VTPym2gNR4DUS7PLo+rrlyA7sfzl2hCDMBgPwGmY+WGq5GJr5oNuXgRxHwGjzTYgsW9OGrnSlMN4Zqvfq4UXCbcu2eplY9KbQu5AGqhrRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967662; c=relaxed/simple;
	bh=t58yRq9dzeb6Nu3F05b01twALhP774WtGGQeaGEiX94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j22RTGfn85uCywdBT8RNUellpfOTTH2bSscKbGzcsrZR3/jmBFrW6BDroAHRRFmLiWxqpi1mqqjJBjKzDnUbVQj7TF4ncyNOSmAWKZI/I2x5b9g7CEHejUsSR/zCpJFSC2197+obgAuNbhuz2e5Cotmn9fGARY1et9vE8lgInfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvDLOWjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E95C4AF11;
	Fri, 21 Jun 2024 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718967661;
	bh=t58yRq9dzeb6Nu3F05b01twALhP774WtGGQeaGEiX94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LvDLOWjgcMr+X2yvvodUTSBHE1N1YezyLhZWQ9GydahvvxDdGPftDYZclZV7bupTD
	 EXlxwVybdyEWT5RR1FdFKEloiFoRyqg2IKAJAnUulM32h0atikOSi5M7Rc4xxzoPAn
	 P8ZEjcbz3nu/tYAUEWcKQbNnPClkILjtRRdrS6OYmATlMabzw+ITOe3UAl4vdbGtQy
	 2WbLR5ry2PlNhVGy4dH1Hwet5lxhnmtQCJcJHln9jooPaevmMZRXho7guaZU2dXm1W
	 C/COiqU8IdBsAfQJ/58x38IHK/ZgkCl5+bdVzJ1Z3ckX+wKxlvJO6nhw20c60azxaT
	 zxrDayRrqXyPQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso18168701fa.1;
        Fri, 21 Jun 2024 04:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKgcSpUgefmAoXAZzvX7UATDhYev0D0ivMjyWNYkSRLPauj3Iv0Vje4J24xzm7pYmzsdLdeaPFHNG9y0wrwe2jI65Ex6Np1iilJ2mcwRU38FEnLnLVccKksy1eWm0ou3/ioHwBStop
X-Gm-Message-State: AOJu0Ywpn4exg3Aw3xh7iOv3k1NlUMLC/+aPNQHep0I8IjBcSBj24ZMv
	EjFKptjyNGcoAz4ycP0eyaaWteXsRiSwbXqQm6w/8rdq0c764SytRqZsmNJKdxKO3h5FlFFYqS9
	b6GL2weirA7LWHYEejLiHdI4eqiI=
X-Google-Smtp-Source: AGHT+IG1Y7HIXBDX8G5JP4YhV2mwXH5q57GexSHNMagkk3tJPcrRcUjo9mm/MX4Y/0X2i7V8dQT+ADERsz4gYk8KR98=
X-Received: by 2002:a2e:7205:0:b0:2ec:1ee0:be7e with SMTP id
 38308e7fff4ca-2ec3cff8e8emr44018631fa.46.1718967659971; Fri, 21 Jun 2024
 04:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620131649.886995-1-ruanjinjie@huawei.com>
In-Reply-To: <20240620131649.886995-1-ruanjinjie@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Jun 2024 13:00:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+EadkfHJZxCKQC9Ry5TwgkqExVH=r8bTxEnkAkJjoJg@mail.gmail.com>
Message-ID: <CAMj1kXE+EadkfHJZxCKQC9Ry5TwgkqExVH=r8bTxEnkAkJjoJg@mail.gmail.com>
Subject: Re: [PATCH] ARM: Add support for STACKLEAK gcc plugin
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, arnd@arndb.de, afd@ti.com, 
	akpm@linux-foundation.org, rmk+kernel@armlinux.org.uk, 
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org, 
	kees@kernel.org, masahiroy@kernel.org, palmer@rivosinc.com, 
	samitolvanen@google.com, xiao.w.wang@intel.com, alexghiti@rivosinc.com, 
	nathan@kernel.org, jan.kiszka@siemens.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 15:14, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add the STACKLEAK gcc plugin to arm32 by adding the helper used by
> stackleak common code: on_thread_stack(). It initialize the stack with the
> poison value before returning from system calls which improves the kernel
> security. Additionally, this disables the plugin in EFI stub code and
> decompress code, which are out of scope for the protection.
>
> Before the test on Qemu versatilepb board:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)
>
> After:
>         # echo STACKLEAK_ERASING  > /sys/kernel/debug/provoke-crash/DIRECT
>         lkdtm: Performing direct entry STACKLEAK_ERASING
>         lkdtm: stackleak stack usage:
>           high offset: 80 bytes
>           current:     280 bytes
>           lowest:      696 bytes
>           tracked:     696 bytes
>           untracked:   192 bytes
>           poisoned:    7220 bytes
>           low offset:  4 bytes
>         lkdtm: OK: the rest of the thread stack is properly erased
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm/Kconfig                      | 1 +
>  arch/arm/boot/compressed/Makefile     | 1 +
>  arch/arm/include/asm/stacktrace.h     | 5 +++++
>  arch/arm/kernel/entry-common.S        | 3 +++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  5 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 036381c5d42f..b211b7f5a138 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -86,6 +86,7 @@ config ARM
>         select HAVE_ARCH_PFN_VALID
>         select HAVE_ARCH_SECCOMP
>         select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
> +       select HAVE_ARCH_STACKLEAK
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 6bca03c0c7f0..945b5975fce2 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -9,6 +9,7 @@ OBJS            =
>
>  HEAD   = head.o
>  OBJS   += misc.o decompress.o
> +CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
>  ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
>  OBJS   += debug.o
>  AFLAGS_head.o += -DDEBUG
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 360f0d2406bf..a9b4b72ed241 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -26,6 +26,11 @@ struct stackframe {
>  #endif
>  };
>
> +static inline bool on_thread_stack(void)
> +{
> +       return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));

Can we make this a bit more legible, without the redundant parens?
Perhaps something like the below?


unsigned long delta = current_stack_pointer ^ (unsigned long)current->stack;

return delta < THREAD_SIZE;


Other than that, this looks fine to me

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> +}
> +
>  static __always_inline
>  void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  {
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 5c31e9de7a60..f379c852dcb7 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -119,6 +119,9 @@ no_work_pending:
>
>         ct_user_enter save = 0
>
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +       bl      stackleak_erase_on_task_stack
> +#endif
>         restore_user_regs fast = 0, offset = 0
>  ENDPROC(ret_to_user_from_irq)
>  ENDPROC(ret_to_user)
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 06f0428a723c..20d8a491f25f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -27,7 +27,8 @@ cflags-$(CONFIG_ARM64)                += -fpie $(DISABLE_STACKLEAK_PLUGIN) \
>  cflags-$(CONFIG_ARM)           += -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> -                                  $(call cc-option,-mno-single-pic-base)
> +                                  $(call cc-option,-mno-single-pic-base) \
> +                                  $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>  cflags-$(CONFIG_LOONGARCH)     += -fpie
>
> --
> 2.34.1
>
>

