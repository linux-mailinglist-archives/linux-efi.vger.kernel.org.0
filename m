Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295B64840B
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLIOrJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 09:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIOrG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 09:47:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE1419A8
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 06:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98B226226C
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 14:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8CC43392
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670597222;
        bh=MQAM5KrRuiJ7R4gg4tGtvjfH//3xGpKxSILBBLI/l2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I7X2TsgBDSgzW5Cw6T24NdHZJ113ELXetuB2BG+GhWoI8RKgOB/+sp5idsQPhIyqb
         Of7MroIMcuocFVhhXfk6wT3/G2w3D8/wvPipfNo7n2jfogDpP/Cm0ij0udKAHGm9t7
         pXzKwatpptrVRcObhxUfzZWSn8NYvPog2aBIVdqgvV7zZkqNOYqwGSur9bP54tb0JU
         VIhJZLPsYW7TuH/BYb8rUdH/0hIW0CpBEUyp2/etznFzuj6KemRZ/wlvInNVQOSZ/J
         6XaFO8F3fde6hEe8WxHpMzd3YQUb1dWMMW3IR0OENLcz3+lbo/u16cQfIS1PzsNsz8
         /IUxZowxksaZA==
Received: by mail-lj1-f169.google.com with SMTP id g14so1157914ljh.10
        for <linux-efi@vger.kernel.org>; Fri, 09 Dec 2022 06:47:01 -0800 (PST)
X-Gm-Message-State: ANoB5pnnYvICMdGCvtdVCF/Nb3uDOoUbVE1TcwKO/4pA2tgKp+YuweZf
        kwg8c1G4LVSiXpK/2sRbTKc4sIGPxIQXka9rzQU=
X-Google-Smtp-Source: AA0mqf4gHNN6dxAovnOMCBejoB4QdpNB5i37XTYh7fwD42oPz2wEJK5qmewPWpo4pXQOQ1GRmcCGHNxJ77UAWqGWB3M=
X-Received: by 2002:a05:651c:1601:b0:277:3a1:e86d with SMTP id
 f1-20020a05651c160100b0027703a1e86dmr26940340ljq.152.1670597219973; Fri, 09
 Dec 2022 06:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20221209133414.3330761-1-ardb@kernel.org> <Y5NINaentm954uix@FVFF77S0Q05N>
In-Reply-To: <Y5NINaentm954uix@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 15:46:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEyvBr16tWUqhTJv7JiaxYWaDa8RSByVzu6RJDASr1AMw@mail.gmail.com>
Message-ID: <CAMj1kXEyvBr16tWUqhTJv7JiaxYWaDa8RSByVzu6RJDASr1AMw@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Account for the EFI runtime stack in stack unwinder
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 9 Dec 2022 at 15:37, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Dec 09, 2022 at 02:34:14PM +0100, Ard Biesheuvel wrote:
> > The EFI runtime services run from a dedicated stack now, and so the
> > stack unwinder needs to be informed about this.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >
> > I realised while looking into this that comparing current_work() against
> > efi_rts_work.work is not sufficient to decide whether current is running
> > EFI code, given that the ACPI subsystem will call efi_call_virt_pointer()
> > directly.
> >
> > So instead, we can check whether the stashed thread stack pointer value
> > matches current's thread stack if the EFI runtime stack is currently in
> > use:
> >
> > #define current_in_efi()                                               \
> >        (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> >         on_task_stack(current, efi_rt_stack_top[-1], 1))
>
> Unless you're overwriting task_struct::stack (which seems scary to me), that
> doesn't look right; on_task_stack() checks whether a given base + size is on
> the stack allocated for the task (i.e. task_struct::stack + THREAD_SIZE), not
> the stack the task is currently using.
>

Note the [-1].

efi_rt_stack_top[-1] contains the value the stack pointer had before
switching to the EFI runtime stack. If that value is an address
covered by current's thread stack, current must be the task that has a
live call frame inside the EFI code at the time the call stack is
captured.

> I would expect this to be something like:
>
> #define current_in_efi()                                                \
>         (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
>          stackinfo_on_stack(stackinfo_get_efi(), current_stack_pointer, 1))
>
> ... or an inline function given this is sufficiently painful as a macro.
>

current_stack_pointer is the actual value of SP at the time this code
is called. So if we are unwinding from a sync exception taken while
handling an IRQ that arrived while running the EFI code, that SP value
has nothing to do with the EFI stack.


> ... unless I've confused myself?
>

I think you might have ... :-)

> FWIW, the patch belows looks good to me!
>
> Mark.
>

Cheers



> > but this will be folded into the preceding patch, which I am not
> > reproducing here.
> >
> >  arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
> >  arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> > index 5a0edb064ea478bb..327cdcfcb1db0ad5 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -104,4 +104,19 @@ static inline struct stack_info stackinfo_get_sdei_critical(void)
> >  #define stackinfo_get_sdei_critical()        stackinfo_get_unknown()
> >  #endif
> >
> > +#ifdef CONFIG_EFI
> > +extern u64 *efi_rt_stack_top;
> > +
> > +static inline struct stack_info stackinfo_get_efi(void)
> > +{
> > +     unsigned long high = (u64)efi_rt_stack_top;
> > +     unsigned long low = high - THREAD_SIZE;
> > +
> > +     return (struct stack_info) {
> > +             .low = low,
> > +             .high = high,
> > +     };
> > +}
> > +#endif
> > +
> >  #endif       /* __ASM_STACKTRACE_H */
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 634279b3b03d1b07..ee9fd2018cd75ed2 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (C) 2012 ARM Ltd.
> >   */
> >  #include <linux/kernel.h>
> > +#include <linux/efi.h>
> >  #include <linux/export.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/sched.h>
> > @@ -12,6 +13,7 @@
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/stacktrace.h>
> >
> > +#include <asm/efi.h>
> >  #include <asm/irq.h>
> >  #include <asm/stack_pointer.h>
> >  #include <asm/stacktrace.h>
> > @@ -186,6 +188,13 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
> >                       : stackinfo_get_unknown();              \
> >       })
> >
> > +#define STACKINFO_EFI                                                \
> > +     ({                                                      \
> > +             ((task == current) && current_in_efi())         \
> > +                     ? stackinfo_get_efi()                   \
> > +                     : stackinfo_get_unknown();              \
> > +     })
> > +
> >  noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >                             void *cookie, struct task_struct *task,
> >                             struct pt_regs *regs)
> > @@ -199,6 +208,9 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >  #if defined(CONFIG_VMAP_STACK) && defined(CONFIG_ARM_SDE_INTERFACE)
> >               STACKINFO_SDEI(normal),
> >               STACKINFO_SDEI(critical),
> > +#endif
> > +#ifdef CONFIG_EFI
> > +             STACKINFO_EFI,
> >  #endif
> >       };
> >       struct unwind_state state = {
> > --
> > 2.35.1
> >
