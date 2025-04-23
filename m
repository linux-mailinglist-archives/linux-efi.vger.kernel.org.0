Return-Path: <linux-efi+bounces-3428-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB7A98C39
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94977189D475
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E4279338;
	Wed, 23 Apr 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6OLdmF9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618F279333;
	Wed, 23 Apr 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416977; cv=none; b=khFJn1kQSS3/da+0W7AoknnffCi3BAAuO/hnB+k1JqVzRfiZPs4WweyL+mFW80VHybjiwMY4eBaK/TNy3Itcni1bzcaf1g89uM4GyXwdNF25U3Wu4KYCoKsdbA1A6GF9c3kN4xy6A12OScrwkBCT3B3vBBXz+c0StC8n807MkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416977; c=relaxed/simple;
	bh=xsXsftvEjFwIF6Llyq+jRmJ7wWnCaiWfBjcWxLpv+nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt8r8z6TPMC/AzqkhWXl5p0c9vdI4wG76SrYnzI9sUC8+cm6+MviuhXldM3YfCCnwKbaJdmqOpqczRrI9D4eJNX6tU2wsfeDkD1c3sgABOHHPtj61jlsQPvcoPu53zWaWdFZ1Aev3piA/MTEyuQg/fh4dFGM6cs8N9lyyx4Oq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6OLdmF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3720C4CEE8;
	Wed, 23 Apr 2025 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745416976;
	bh=xsXsftvEjFwIF6Llyq+jRmJ7wWnCaiWfBjcWxLpv+nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C6OLdmF9jtssgRxvSJwA6NEELb3+ccNP46qeazpU/NXuVpjIGQ+/XEhU0w7KXwnV3
	 xqsRWyfN2xX9CWPsZ6BYcGwVoxHpaLCvouIc68k77jXGJBllC9/OE0V7z0chzdJh5i
	 oAmaRQen7oesMSCRQjPT37VxBCei7gqnZi+/S8GBOhdaMkcqeI5eVNJ9yQdjb43pq9
	 x55rk8jtVNtUCR62ck0Q1HVpzJnXHZ2obT5GYg3Q623T01dng1NPR3EDz2U5zsXVfQ
	 G/Vyr1m5PRDwfOCdpVbBJTbXlyvqgXwxpi2WIgpwg1Zb1naLG0UDwdCaiOR9NvC9aZ
	 Crs9zThEp4x9A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so11775775a12.1;
        Wed, 23 Apr 2025 07:02:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7ela0mVGjgq4uzDZSqsYbfDXfGJxYMCRlQ1MIKzAc4QeNSskQF1h9r0EOP2HqrDvecGWDWEPWUjsCh0B6@vger.kernel.org, AJvYcCVwWvWy9lvblguWfPL59UYhqdOa/UqIaDhLn5ztkz7S21MoD1m+WWExs4iYYjjyVD/0/KavfLbNJqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuEOZBCei07IjUL8s5AsNInl6OOs5zV6Bes9uYOcKLFFcnFPB
	RhdFG03i+CwHeH1C2VSkaQnZlR8mmtQvA8HfXyutm+yK4Fm4+lOMqGQpwZLnuQceXcMYnCxJnjp
	s787qfG6Ej/kcVdBCS4TL9XH31nk=
X-Google-Smtp-Source: AGHT+IEf4vxB5F5Yc4j2MBgEUrwmnQdP7Mij5gZYjshORoSA0JXSJzEym2wpfYEQ+jtTmh2NpstSqVyJnkeBXRDEE9U=
X-Received: by 2002:a05:6402:350c:b0:5f3:fbb4:b258 with SMTP id
 4fb4d7f45d1cf-5f628543c7emr18578695a12.14.1745416975350; Wed, 23 Apr 2025
 07:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423063147.69178-1-youling.tang@linux.dev>
In-Reply-To: <20250423063147.69178-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Apr 2025 22:02:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ezCcC=2zvumhbsEu0U8Y4YWbLmG9soYKQB=fr0PohbA@mail.gmail.com>
X-Gm-Features: ATxdqUE0s0zUm5yeDcYb2Ukfr_sdZRptssWi98NfiU5KwUV0eRpWCRCZ8u3MD7g
Message-ID: <CAAhV-H5ezCcC=2zvumhbsEu0U8Y4YWbLmG9soYKQB=fr0PohbA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable HAVE_ARCH_STACKLEAK
To: Youling Tang <youling.tang@linux.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

On Wed, Apr 23, 2025 at 2:32=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> Add support for the stackleak feature. It initialize the stack with the
> poison value before returning from system calls which improves the kernel
> security.
>
> At the same time, disables the plugin in EFI stub code because EFI stub
> is out of scope for the protection.
>
> Tested on 3A5000 (enable CONFIG_GCC_PLUGIN_STACKLEAK and CONFIG_LKDTM):
>  # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
>  # dmesg
>    lkdtm: Performing direct entry STACKLEAK_ERASING
>    lkdtm: stackleak stack usage:
>       high offset: 320 bytes
>       current:     448 bytes
>       lowest:      1264 bytes
>       tracked:     1264 bytes
>       untracked:   208 bytes
>       poisoned:    14528 bytes
>       low offset:  64 bytes
>    lkdtm: OK: the rest of the thread stack is properly erased
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                    | 1 +
>  arch/loongarch/include/asm/entry-common.h | 8 +-------
>  arch/loongarch/include/asm/stacktrace.h   | 5 +++++
>  arch/loongarch/kernel/entry.S             | 9 +++++++++
>  drivers/firmware/efi/libstub/Makefile     | 2 +-
>  5 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 067c0b994648..3a6bfcab2dde 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -122,6 +122,7 @@ config LOONGARCH
>         select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>         select HAVE_ARCH_SECCOMP
>         select HAVE_ARCH_SECCOMP_FILTER
> +       select HAVE_ARCH_STACKLEAK
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>         select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
> diff --git a/arch/loongarch/include/asm/entry-common.h b/arch/loongarch/i=
nclude/asm/entry-common.h
> index 0fe2a098ded9..a7a6af490f86 100644
> --- a/arch/loongarch/include/asm/entry-common.h
> +++ b/arch/loongarch/include/asm/entry-common.h
> @@ -2,12 +2,6 @@
>  #ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
>  #define ARCH_LOONGARCH_ENTRY_COMMON_H
>
> -#include <linux/sched.h>
> -#include <linux/processor.h>
> -
> -static inline bool on_thread_stack(void)
> -{
> -       return !(((unsigned long)(current->stack) ^ current_stack_pointer=
) & ~(THREAD_SIZE - 1));
> -}
> +#include <asm/stacktrace.h>
>
>  #endif
> diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/inc=
lude/asm/stacktrace.h
> index fc8b64773794..3861beb96002 100644
> --- a/arch/loongarch/include/asm/stacktrace.h
> +++ b/arch/loongarch/include/asm/stacktrace.h
> @@ -31,6 +31,11 @@ bool in_irq_stack(unsigned long stack, struct stack_in=
fo *info);
>  bool in_task_stack(unsigned long stack, struct task_struct *task, struct=
 stack_info *info);
>  int get_stack_info(unsigned long stack, struct task_struct *task, struct=
 stack_info *info);
>
> +static inline bool on_thread_stack(void)
Use __always_inline is better for objtool, like x86.

> +{
> +       return !(((unsigned long)(current->stack) ^ current_stack_pointer=
) & ~(THREAD_SIZE - 1));
> +}
> +
>  #define STR_LONG_L    __stringify(LONG_L)
>  #define STR_LONG_S    __stringify(LONG_S)
>  #define STR_LONGSIZE  __stringify(LONGSIZE)
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.=
S
> index 48e7e34e355e..27dcb3a66b2b 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -16,6 +16,12 @@
>  #include <asm/thread_info.h>
>  #include <asm/unwind_hints.h>
>
> +       .macro STACKLEAK_ERASE
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +       bl              stackleak_erase_on_task_stack
> +#endif
> +       .endm
Move this macro to stackframe.h? This makes it can be used by other files.

Huacai

> +
>         .text
>         .cfi_sections   .debug_frame
>         .align  5
> @@ -73,6 +79,7 @@ SYM_CODE_START(handle_syscall)
>         move            a0, sp
>         bl              do_syscall
>
> +       STACKLEAK_ERASE
>         RESTORE_ALL_AND_RET
>  SYM_CODE_END(handle_syscall)
>  _ASM_NOKPROBE(handle_syscall)
> @@ -82,6 +89,7 @@ SYM_CODE_START(ret_from_fork)
>         bl              schedule_tail           # a0 =3D struct task_stru=
ct *prev
>         move            a0, sp
>         bl              syscall_exit_to_user_mode
> +       STACKLEAK_ERASE
>         RESTORE_STATIC
>         RESTORE_SOME
>         RESTORE_SP_AND_RET
> @@ -94,6 +102,7 @@ SYM_CODE_START(ret_from_kernel_thread)
>         jirl            ra, s0, 0
>         move            a0, sp
>         bl              syscall_exit_to_user_mode
> +       STACKLEAK_ERASE
>         RESTORE_STATIC
>         RESTORE_SOME
>         RESTORE_SP_AND_RET
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index d23a1b9fed75..b97981d63d2f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -31,7 +31,7 @@ cflags-$(CONFIG_ARM)          +=3D -DEFI_HAVE_STRLEN -D=
EFI_HAVE_STRNLEN \
>                                    $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno-relax \
>                                    $(DISABLE_STACKLEAK_PLUGIN)
> -cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
> +cflags-$(CONFIG_LOONGARCH)     +=3D -fpie $(DISABLE_STACKLEAK_PLUGIN)
>
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   +=3D -I$(srctree)/scripts/dtc/lib=
fdt
>
> --
> 2.38.1
>

