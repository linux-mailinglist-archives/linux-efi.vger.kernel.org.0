Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6253FEA9C
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbhIBI2a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 04:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhIBI23 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 04:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DA00610C8
        for <linux-efi@vger.kernel.org>; Thu,  2 Sep 2021 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630571251;
        bh=/cYncdxdC9AIhyqrJRghMoCuRoaIDnfcPgh8XWiUS9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rR4f2KCV0r6cpcYa6ZC6ob5nMHkB06r2yFqRBvxs5hXoHZz8nzPHUfZaq8t+gEYWq
         ti3/PGFy28HGNNN08HJnrhYZgvPWxGXs23tT8rgqNNiZRiRK+/Hjd4OToCKR8wJSqd
         39QHpT8Zu7RWv6aHK9ROxiRtU9uImLnW5uVhYygkOI2yA+aGIBNOkd4s1HXtk+QEoN
         xhgDUA3N2kkIMRnBvLWWUwkP9gUbqlg0PHoUp+X/zhwb46ibFbHpAGr6JEnYxzoZ0d
         Ivb8XKTiZLGsjRLYmnTTe4CcciMijT/1yd1uOQde0ARltiTGqxXXeYy0AZcVImbm7K
         LfHBRMOXkNs2A==
Received: by mail-ot1-f52.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso1527640ott.13
        for <linux-efi@vger.kernel.org>; Thu, 02 Sep 2021 01:27:31 -0700 (PDT)
X-Gm-Message-State: AOAM53119I3TMB9o5HDMNhlr/PdgPo3z/aGxb1ih27CaqeiFzly6NMjc
        JrC9FGswQFatzLiWxOORbNonohvYdDlceuY4rmw=
X-Google-Smtp-Source: ABdhPJzArBNfWD2rqWvHtuNnLQCrKtWM9aLU06ZUjkYT9+VIh2c4TKxRuH5P1PkJ1IL9iaPExmWWlfbd9QHsoigKs3A=
X-Received: by 2002:a05:6830:124b:: with SMTP id s11mr1611993otp.90.1630571250774;
 Thu, 02 Sep 2021 01:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210902080416.5461-1-ilias.apalodimas@linaro.org> <20210902080416.5461-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20210902080416.5461-3-ilias.apalodimas@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Sep 2021 10:27:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuFOKeiSPFzAtd1tmog-sBuUUg3cqAGtHn9KgiinwL1g@mail.gmail.com>
Message-ID: <CAMj1kXEuFOKeiSPFzAtd1tmog-sBuUUg3cqAGtHn9KgiinwL1g@mail.gmail.com>
Subject: Re: [PATCH 2/4 v2] efi/libstub: x86/mixed: increase supported
 argument count
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Peter Jones <pjones@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Sept 2021 at 10:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Increase the number of arguments supported by mixed mode calls, so that
> we will be able to call into the TCG2 protocol to measure the initrd
> and extend the associated PCR. This involves the TCG2 protocol's
> hash_log_extend_event() method, which takes five arguments, three of
> which are u64 and need to be split, producing a total of 8 outgoing
> arguments.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Does this still apply cleanly? There was a last minute fix that went
into v5.14 that looked like it would conflict with this.

> ---
>  arch/x86/boot/compressed/efi_thunk_64.S | 17 ++++++++++++-----
>  arch/x86/include/asm/efi.h              | 10 ++++++----
>  arch/x86/platform/efi/efi_thunk_64.S    | 14 ++++++++++++--
>  3 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
> index 95a223b3e56a..fec6c48d6b30 100644
> --- a/arch/x86/boot/compressed/efi_thunk_64.S
> +++ b/arch/x86/boot/compressed/efi_thunk_64.S
> @@ -27,8 +27,6 @@ SYM_FUNC_START(__efi64_thunk)
>         push    %rbp
>         push    %rbx
>
> -       leaq    1f(%rip), %rbp
> -
>         movl    %ds, %eax
>         push    %rax
>         movl    %es, %eax
> @@ -36,19 +34,28 @@ SYM_FUNC_START(__efi64_thunk)
>         movl    %ss, %eax
>         push    %rax
>
> +       movq    0x30(%rsp), %rbp
> +       movq    0x38(%rsp), %rbx
> +       movq    0x40(%rsp), %rax
> +
>         /*
>          * Convert x86-64 ABI params to i386 ABI
>          */
> -       subq    $32, %rsp
> +       subq    $48, %rsp
>         movl    %esi, 0x0(%rsp)
>         movl    %edx, 0x4(%rsp)
>         movl    %ecx, 0x8(%rsp)
>         movl    %r8d, 0xc(%rsp)
>         movl    %r9d, 0x10(%rsp)
> +       movl    %ebp, 0x14(%rsp)
> +       movl    %ebx, 0x18(%rsp)
> +       movl    %eax, 0x1c(%rsp)
>
> -       leaq    0x14(%rsp), %rbx
> +       leaq    0x20(%rsp), %rbx
>         sgdt    (%rbx)
>
> +       leaq    1f(%rip), %rbp
> +
>         /*
>          * Switch to gdt with 32-bit segments. This is the firmware GDT
>          * that was installed when the kernel started executing. This
> @@ -67,7 +74,7 @@ SYM_FUNC_START(__efi64_thunk)
>         pushq   %rax
>         lretq
>
> -1:     addq    $32, %rsp
> +1:     addq    $48, %rsp
>         movq    %rdi, %rax
>
>         pop     %rbx
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 85f156f8ef81..a323dbac9182 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -46,13 +46,14 @@ extern unsigned long efi_mixed_mode_stack_pa;
>
>  #define __efi_nargs(...) __efi_nargs_(__VA_ARGS__)
>  #define __efi_nargs_(...) __efi_nargs__(0, ##__VA_ARGS__,      \
> +       __efi_arg_sentinel(9), __efi_arg_sentinel(8),           \
>         __efi_arg_sentinel(7), __efi_arg_sentinel(6),           \
>         __efi_arg_sentinel(5), __efi_arg_sentinel(4),           \
>         __efi_arg_sentinel(3), __efi_arg_sentinel(2),           \
>         __efi_arg_sentinel(1), __efi_arg_sentinel(0))
> -#define __efi_nargs__(_0, _1, _2, _3, _4, _5, _6, _7, n, ...)  \
> +#define __efi_nargs__(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, n, ...)  \
>         __take_second_arg(n,                                    \
> -               ({ BUILD_BUG_ON_MSG(1, "__efi_nargs limit exceeded"); 8; }))
> +               ({ BUILD_BUG_ON_MSG(1, "__efi_nargs limit exceeded"); 10; }))
>  #define __efi_arg_sentinel(n) , n
>
>  /*
> @@ -176,8 +177,9 @@ extern u64 efi_setup;
>  extern efi_status_t __efi64_thunk(u32, ...);
>
>  #define efi64_thunk(...) ({                                            \
> -       __efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);                 \
> -       __efi64_thunk(__VA_ARGS__);                                     \
> +       u64 __pad[3]; /* must have space for 3 args on the stack */     \
> +       __efi_nargs_check(efi64_thunk, 9, __VA_ARGS__);                 \
> +       __efi64_thunk(__VA_ARGS__, __pad);                              \
>  })
>
>  static inline bool efi_is_mixed(void)
> diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
> index fd3dd1708eba..5b7c6e09954e 100644
> --- a/arch/x86/platform/efi/efi_thunk_64.S
> +++ b/arch/x86/platform/efi/efi_thunk_64.S
> @@ -36,6 +36,17 @@ SYM_CODE_START(__efi64_thunk)
>         movq    efi_mixed_mode_stack_pa(%rip), %rsp
>         push    %rax
>
> +       /*
> +        * Copy args passed via the stack
> +        */
> +       subq    $0x24, %rsp
> +       movq    0x18(%rax), %rbp
> +       movq    0x20(%rax), %rbx
> +       movq    0x28(%rax), %rax
> +       movl    %ebp, 0x18(%rsp)
> +       movl    %ebx, 0x1c(%rsp)
> +       movl    %eax, 0x20(%rsp)
> +
>         /*
>          * Calculate the physical address of the kernel text.
>          */
> @@ -47,7 +58,6 @@ SYM_CODE_START(__efi64_thunk)
>         subq    %rax, %rbp
>         subq    %rax, %rbx
>
> -       subq    $28, %rsp
>         movl    %ebx, 0x0(%rsp)         /* return address */
>         movl    %esi, 0x4(%rsp)
>         movl    %edx, 0x8(%rsp)
> @@ -60,7 +70,7 @@ SYM_CODE_START(__efi64_thunk)
>         pushq   %rdi                    /* EFI runtime service address */
>         lretq
>
> -1:     movq    24(%rsp), %rsp
> +1:     movq    0x20(%rsp), %rsp
>         pop     %rbx
>         pop     %rbp
>         retq
> --
> 2.32.0.rc0
>
