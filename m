Return-Path: <linux-efi+bounces-3752-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC6ABA923
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826E31B64B60
	for <lists+linux-efi@lfdr.de>; Sat, 17 May 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6E1DFDB8;
	Sat, 17 May 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tacmf2ug"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F11DF97F;
	Sat, 17 May 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747474409; cv=none; b=Av/0XQUKPdLF9qVaX358EI8fird8j0F7vLaKWs9ZGn3A7g9VdesAJA9f82NEtBJ6mKQ/Gc8cnfy7R6LQNaQT1pMbUVsPyGr8o0zd77n1KIlBPodIepGewcdmM57NyRz5o2CznlnHNpoCOb/31CbVCu/sdAORR1bLkm/IItR6vIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747474409; c=relaxed/simple;
	bh=XCM4sNjd8G3kLdZs8GWwcD5be9JJ5ZQoAzjcdwuJ2rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deJ4eGr8solnlqkzuMbf3nV0ZTJEpn5gNbDJZgTxe0QruIgDkRLcGNmDQ8y1epooncmq3CUvhOewcvulG2hx1ndL+0WabQV9U1jXjpolN7SLcmc3v8pCbp/brOWNXR6kbWIl7sJRtgmzVm1nB7s7COgSDi3wXiOP4DEmpM3Nksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tacmf2ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B491DC4CEE3;
	Sat, 17 May 2025 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747474408;
	bh=XCM4sNjd8G3kLdZs8GWwcD5be9JJ5ZQoAzjcdwuJ2rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tacmf2ug/JaH8+gG9EwjSrn+w7RtvPQePPreK0Elh/zFjyMgpDrWg7SYaj+hMjufV
	 rtJr6nbcsUhZD7yXltAuUwPVMDkMQVAManPPJ5cfQ8EaDsCQeLnfFPjCwTEGFgntyM
	 149v5M0+7Pr7caf+U69/rjVNJGM6climyNoQFN3LkAcYS9Te7lxxx9+iDSbRSj4dhd
	 UusNvuXelmM9HYyuW8yJNFP6vj1J87VfReFt7OX9GFpBgA6rd983UxNGrCkVEZi1KJ
	 GacblGOgl7G8DZFM+zbMTmZJNpKeI3rPSGsmTvPZepZuocQny0EiHu+Eahk7Qm6nnX
	 4CiZp6Fpc8Pdw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so430374966b.1;
        Sat, 17 May 2025 02:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURBzwBzY0W/KnJy/9eMcNM0uIeatdNY2Y/NzjWKl3L6D9mQCuIYdzDiTQAYIKa1JHVh0oC6JrAt4O3SJr4@vger.kernel.org, AJvYcCXicGO5ysVpnQz8q3/M8s24LaDTt+9L7vU+HjofaT47wzpm9LVAiFWF4TSucy7PxLPzNsh9AyHiZDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMc+9GA2vokTPHRsBGDdpGbSGLmfBdcGMOnSeE/kZt6IAJB8vJ
	M0FVvjcJycncI5VlnY8lDRUqsIftNmRsXcMltuV8q+pSb/O7T7G0pp3Y/UcsmKcF+sZYPWY1VgG
	tzunm+l5VR+OJIr5Fi9AveFbGd79+4tk=
X-Google-Smtp-Source: AGHT+IHTvFI6zZRv0wNKYaTlHEu0ikHrWHUB6ZLVryypaxujB2+O1jj1f3607aJS94Nj/nQDMF5ZYt5OXJP/gQE3ZgM=
X-Received: by 2002:a17:907:7205:b0:ad5:10d9:9061 with SMTP id
 a640c23a62f3a-ad536ffbae7mr610013866b.54.1747474407333; Sat, 17 May 2025
 02:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424073251.81693-1-youling.tang@linux.dev>
In-Reply-To: <20250424073251.81693-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 17 May 2025 17:33:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5E3Gjw9WfR_vuWJt-k9GaV25G8LxHmhNhZ-Hnmn3iNiQ@mail.gmail.com>
X-Gm-Features: AX0GCFsuNX5NxxXsf4WDPqP416sllgHwynrLliakmWphUwCko2KPCdLWioNW23M
Message-ID: <CAAhV-H5E3Gjw9WfR_vuWJt-k9GaV25G8LxHmhNhZ-Hnmn3iNiQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Enable HAVE_ARCH_STACKLEAK
To: Youling Tang <youling.tang@linux.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Thu, Apr 24, 2025 at 3:33=E2=80=AFPM Youling Tang <youling.tang@linux.de=
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
> v2:
>  * Make on_thread_stack() __always_inline.
>  * Move the STACKLEAK_ERASE macro to the stackframe.h file.
>
>  arch/loongarch/Kconfig                    | 1 +
>  arch/loongarch/include/asm/entry-common.h | 8 +-------
>  arch/loongarch/include/asm/stackframe.h   | 6 ++++++
>  arch/loongarch/include/asm/stacktrace.h   | 5 +++++
>  arch/loongarch/kernel/entry.S             | 3 +++
>  drivers/firmware/efi/libstub/Makefile     | 2 +-
>  6 files changed, 17 insertions(+), 8 deletions(-)
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
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/inc=
lude/asm/stackframe.h
> index 66736837085b..c37455bca29b 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -243,4 +243,10 @@
>         RESTORE_SP_AND_RET \docfi
>         .endm
>
> +       .macro STACKLEAK_ERASE
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +       bl              stackleak_erase_on_task_stack
> +#endif
> +       .endm
> +
>  #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/inc=
lude/asm/stacktrace.h
> index fc8b64773794..5c8be156567c 100644
> --- a/arch/loongarch/include/asm/stacktrace.h
> +++ b/arch/loongarch/include/asm/stacktrace.h
> @@ -31,6 +31,11 @@ bool in_irq_stack(unsigned long stack, struct stack_in=
fo *info);
>  bool in_task_stack(unsigned long stack, struct task_struct *task, struct=
 stack_info *info);
>  int get_stack_info(unsigned long stack, struct task_struct *task, struct=
 stack_info *info);
>
> +static __always_inline bool on_thread_stack(void)
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
> index 48e7e34e355e..77f6fb9146a2 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -73,6 +73,7 @@ SYM_CODE_START(handle_syscall)
>         move            a0, sp
>         bl              do_syscall
>
> +       STACKLEAK_ERASE
>         RESTORE_ALL_AND_RET
>  SYM_CODE_END(handle_syscall)
>  _ASM_NOKPROBE(handle_syscall)
> @@ -82,6 +83,7 @@ SYM_CODE_START(ret_from_fork)
>         bl              schedule_tail           # a0 =3D struct task_stru=
ct *prev
>         move            a0, sp
>         bl              syscall_exit_to_user_mode
> +       STACKLEAK_ERASE
>         RESTORE_STATIC
>         RESTORE_SOME
>         RESTORE_SP_AND_RET
> @@ -94,6 +96,7 @@ SYM_CODE_START(ret_from_kernel_thread)
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

