Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAB648477
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 16:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLIPBI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 10:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiLIPAe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 10:00:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B04C4813B6
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 07:00:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41C2323A;
        Fri,  9 Dec 2022 07:00:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9003F73D;
        Fri,  9 Dec 2022 07:00:14 -0800 (PST)
Date:   Fri, 9 Dec 2022 15:00:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH] arm64: efi: Account for the EFI runtime stack in stack
 unwinder
Message-ID: <Y5NNe2gpGL8DmfDm@FVFF77S0Q05N>
References: <20221209133414.3330761-1-ardb@kernel.org>
 <Y5NINaentm954uix@FVFF77S0Q05N>
 <CAMj1kXEyvBr16tWUqhTJv7JiaxYWaDa8RSByVzu6RJDASr1AMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEyvBr16tWUqhTJv7JiaxYWaDa8RSByVzu6RJDASr1AMw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 09, 2022 at 03:46:48PM +0100, Ard Biesheuvel wrote:
> On Fri, 9 Dec 2022 at 15:37, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Dec 09, 2022 at 02:34:14PM +0100, Ard Biesheuvel wrote:
> > > The EFI runtime services run from a dedicated stack now, and so the
> > > stack unwinder needs to be informed about this.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >
> > > I realised while looking into this that comparing current_work() against
> > > efi_rts_work.work is not sufficient to decide whether current is running
> > > EFI code, given that the ACPI subsystem will call efi_call_virt_pointer()
> > > directly.
> > >
> > > So instead, we can check whether the stashed thread stack pointer value
> > > matches current's thread stack if the EFI runtime stack is currently in
> > > use:
> > >
> > > #define current_in_efi()                                               \
> > >        (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> > >         on_task_stack(current, efi_rt_stack_top[-1], 1))
> >
> > Unless you're overwriting task_struct::stack (which seems scary to me), that
> > doesn't look right; on_task_stack() checks whether a given base + size is on
> > the stack allocated for the task (i.e. task_struct::stack + THREAD_SIZE), not
> > the stack the task is currently using.
> >
> 
> Note the [-1].
> 
> efi_rt_stack_top[-1] contains the value the stack pointer had before
> switching to the EFI runtime stack. If that value is an address
> covered by current's thread stack, current must be the task that has a
> live call frame inside the EFI code at the time the call stack is
> captured.

Ah, I had missed that subtlety.

Would you mind if we add that first sentence as a comment for that code, i.e.

| /*
|  * efi_rt_stack_top[-1] contains the value the stack pointer had before
|  * switching to the EFI runtime stack.
|  */
|  #define current_in_efi()                                               \
|         (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
|          on_task_stack(current, efi_rt_stack_top[-1], 1))

... that way when I look at this in 3 to 6 months time I won't fall into the
same trap. :)

I assume that the EFI trampoline code clobbers the value on the way out so it
doesn't spruriously match later.

> > I would expect this to be something like:
> >
> > #define current_in_efi()                                                \
> >         (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> >          stackinfo_on_stack(stackinfo_get_efi(), current_stack_pointer, 1))
> >
> > ... or an inline function given this is sufficiently painful as a macro.
> 
> current_stack_pointer is the actual value of SP at the time this code
> is called. So if we are unwinding from a sync exception taken while
> handling an IRQ that arrived while running the EFI code, that SP value
> has nothing to do with the EFI stack.

Yes, good point.

> > ... unless I've confused myself?
> >
> 
> I think you might have ... :-)

:)

Mark.
