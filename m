Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5A615EFC
	for <lists+linux-efi@lfdr.de>; Wed,  2 Nov 2022 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiKBJJM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Nov 2022 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKBJIr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Nov 2022 05:08:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F427DFA
        for <linux-efi@vger.kernel.org>; Wed,  2 Nov 2022 02:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B3FCB8210E
        for <linux-efi@vger.kernel.org>; Wed,  2 Nov 2022 09:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD525C43140
        for <linux-efi@vger.kernel.org>; Wed,  2 Nov 2022 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667380121;
        bh=kyJW6nL+v/PfUt+1TRaD8EkM0qKMaWUV+31OFvNx+tg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQtC6YeQChMUntdFfq803R8Er5qRon05oHfNS+2OmOJK4ChOSqWV+yeo2LLS+FjHI
         q26YdGLDoceDgrtL6OUqydWdRCQ6PrMP7hh/uOlxJ6p5cjouSj0xOmM9+YJQpoHfGN
         tO5QjrHfi6cZdqjz4vfHCn52Xry821jm5CYJhVrt6y2UoBNJGcnOur2GczaMhekSxb
         NlfNgM3nv7xXHNdza7zl1RXJM9pt5EM4B3b3AYwnYAI2lAVN+B3k6idmx2McCTHanz
         5pX8zy1U9/3rlqlvkRVZVTizIjEsBNnoxItmGItib9vEcS55T4thr35lsglPGr34uj
         V7Be1B8XkrDYw==
Received: by mail-lf1-f50.google.com with SMTP id g7so27197975lfv.5
        for <linux-efi@vger.kernel.org>; Wed, 02 Nov 2022 02:08:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf2/bWSKajugoRrLaOSGKooWK4VvteWKdTZF1yD08nJnSHmUeaUB
        +LSHlKLD63rnS+gWtziYjsteOXMplUwFGKF3r1A=
X-Google-Smtp-Source: AMsMyM6av97egrgB68bUU/eSWtA0YENkjZNpgWGw3MH7twMIAn22iJO1YcTX63rWmGCn3V25UKoxY61zQ9aTDWaaZKE=
X-Received: by 2002:ac2:4d05:0:b0:4a7:7e1b:1c81 with SMTP id
 r5-20020ac24d05000000b004a77e1b1c81mr9736632lfi.110.1667380119551; Wed, 02
 Nov 2022 02:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221028150112.2883620-1-ardb@kernel.org>
In-Reply-To: <20221028150112.2883620-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Nov 2022 10:08:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFcAFEKTuaF5RfMrktoT0+w_E80tDiFoDWA-7vezCxPdA@mail.gmail.com>
Message-ID: <CAMj1kXFcAFEKTuaF5RfMrktoT0+w_E80tDiFoDWA-7vezCxPdA@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Recover from synchronous exceptions occurring
 in firmware
To:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org
Cc:     linux-efi@vger.kernel.org, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 17:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Unlike x86, which has machinery to deal with page faults that occur
> during the execution of EFI runtime services, arm64 has nothing like
> that, and a synchronous exception raised by firmware code brings down
> the whole system.
>
> With more EFI based systems appearing that were not built to run Linux
> (such as the Windows-on-ARM laptops based on Qualcomm SOCs), as well as
> the introduction of PRM (platform specific firmware routines that are
> callable just like EFI runtime services), we are more likely to run into
> issues of this sort, and it is much more likely that we can identify and
> work around such issues if they don't bring down the system entirely.
>
> Since we already use a EFI runtime services call wrapper in assembler,
> we can quite easily add some code that captures the execution state at
> the point where the call is made, allowing us to revert to this state
> and proceed execution if the call triggered a synchronous exception.
>
> Given that the kernel and the firmware don't share any data structures
> that could end up in an indeterminate state, we can happily continue
> running, as long as we mark the EFI runtime services as unavailable from
> that point on.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Does anyone mind if I take this via the EFI tree for v6.1?

> ---
>  arch/arm64/include/asm/efi.h       |  8 ++++++++
>  arch/arm64/kernel/efi-rt-wrapper.S | 33 ++++++++++++++++++++++++++++--
>  arch/arm64/kernel/efi.c            | 26 +++++++++++++++++++++++
>  arch/arm64/mm/fault.c              |  4 ++++
>  4 files changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 439e2bc5d5d8..d6cf535d8352 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -14,8 +14,16 @@
>
>  #ifdef CONFIG_EFI
>  extern void efi_init(void);
> +
> +bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg);
>  #else
>  #define efi_init()
> +
> +static inline
> +bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
> +{
> +       return false;
> +}
>  #endif
>
>  int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index 75691a2641c1..67babd5f04c2 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -6,7 +6,7 @@
>  #include <linux/linkage.h>
>
>  SYM_FUNC_START(__efi_rt_asm_wrapper)
> -       stp     x29, x30, [sp, #-32]!
> +       stp     x29, x30, [sp, #-112]!
>         mov     x29, sp
>
>         /*
> @@ -16,6 +16,20 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
>          */
>         stp     x1, x18, [sp, #16]
>
> +       /*
> +        * Preserve all callee saved registers and record the stack pointer
> +        * value in a per-CPU variable so we can recover from synchronous
> +        * exceptions occurring while running the firmware routines.
> +        */
> +       stp     x19, x20, [sp, #32]
> +       stp     x21, x22, [sp, #48]
> +       stp     x23, x24, [sp, #64]
> +       stp     x25, x26, [sp, #80]
> +       stp     x27, x28, [sp, #96]
> +
> +       adr_this_cpu    x8, __efi_rt_asm_recover_sp, x9
> +       str             x29, [x8]
> +
>         /*
>          * We are lucky enough that no EFI runtime services take more than
>          * 5 arguments, so all are passed in registers rather than via the
> @@ -31,7 +45,7 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
>
>         ldp     x1, x2, [sp, #16]
>         cmp     x2, x18
> -       ldp     x29, x30, [sp], #32
> +       ldp     x29, x30, [sp], #112
>         b.ne    0f
>         ret
>  0:
> @@ -45,3 +59,18 @@ SYM_FUNC_START(__efi_rt_asm_wrapper)
>         mov     x18, x2
>         b       efi_handle_corrupted_x18        // tail call
>  SYM_FUNC_END(__efi_rt_asm_wrapper)
> +
> +SYM_FUNC_START(__efi_rt_asm_recover)
> +       ldr_this_cpu    x8, __efi_rt_asm_recover_sp, x9
> +       mov             sp, x8
> +
> +       ldp     x0,  x18, [sp, #16]
> +       ldp     x19, x20, [sp, #32]
> +       ldp     x21, x22, [sp, #48]
> +       ldp     x23, x24, [sp, #64]
> +       ldp     x25, x26, [sp, #80]
> +       ldp     x27, x28, [sp, #96]
> +       ldp     x29, x30, [sp], #112
> +
> +       b       efi_handle_runtime_exception
> +SYM_FUNC_END(__efi_rt_asm_recover)
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index e1be6c429810..7c1e62a20e1e 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/init.h>
> +#include <linux/percpu.h>
>
>  #include <asm/efi.h>
>
> @@ -128,3 +129,28 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
>         pr_err_ratelimited(FW_BUG "register x18 corrupted by EFI %s\n", f);
>         return s;
>  }
> +
> +asmlinkage DEFINE_PER_CPU(u64, __efi_rt_asm_recover_sp);
> +
> +asmlinkage efi_status_t __efi_rt_asm_recover(void);
> +
> +asmlinkage efi_status_t efi_handle_runtime_exception(const char *f)
> +{
> +       pr_err(FW_BUG "Fault occurred in EFI runtime service %s()\n", f);
> +       clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +       return EFI_ABORTED;
> +}
> +
> +bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
> +{
> +        /* Check whether the exception occurred while running the firmware */
> +       if (current_work() != &efi_rts_work.work || regs->pc >= TASK_SIZE_64)
> +               return false;
> +
> +       pr_err(FW_BUG "Unable to handle %s in EFI runtime service\n", msg);
> +       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +       dump_stack();
> +
> +       regs->pc = (u64)__efi_rt_asm_recover;
> +       return true;
> +}
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 5b391490e045..3e9cf9826417 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -30,6 +30,7 @@
>  #include <asm/bug.h>
>  #include <asm/cmpxchg.h>
>  #include <asm/cpufeature.h>
> +#include <asm/efi.h>
>  #include <asm/exception.h>
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
> @@ -391,6 +392,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
>                 msg = "paging request";
>         }
>
> +       if (efi_runtime_fixup_exception(regs, msg))
> +               return;
> +
>         die_kernel_fault(msg, addr, esr, regs);
>  }
>
> --
> 2.35.1
>
