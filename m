Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5276484B7
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLIPLK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiLIPKf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 10:10:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282748D192
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 07:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF84EB82866
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 15:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6651FC433F0
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670598613;
        bh=aLWJFDPtRx/e9IDBnP5Nc44zEQBYWxgrYU6tnfNRMA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljaXnPVr/trynOrVlC3w2J/psNI73aUzF/bOkCb8LFr3n2lFxBgrtLiLJUncM4V/M
         eQndFRpxWNZKR+rzg9OO/fm68dm8l6Cmxhcrj11CLkB9zA5LHD4itgpEMSl0HUSZrL
         dl0hyFzy05wqwQdXSjc7uB2PBoeHqTcoxUod4Qddfx21yF6mC70fako2UCLiWpD3gr
         zUqOfpIt4vEk1DvXcRtQ3Jqk7jzhoQi1unrNoJEklYoo20ZDnnRk7iWe3K9AKhzASz
         qmLS0oyniClXJARJAHCep313+Tnr3p0dwyVNbYWxHxoQJgPKXM2CVVYrqLiDeinUhm
         EYepCQt3xaArA==
Received: by mail-lf1-f53.google.com with SMTP id g7so7487105lfv.5
        for <linux-efi@vger.kernel.org>; Fri, 09 Dec 2022 07:10:13 -0800 (PST)
X-Gm-Message-State: ANoB5pkGm4bBXoswlpjpvg8j+pBnGCCzOaJKHRLOkQQSoIWJjDO9XYuD
        6tqRKprQcOfpps1HBzlNT56Wu3OAQkaSjibeLiM=
X-Google-Smtp-Source: AA0mqf6Gye9EPnJPrjKu28/s0mSl8c7gnMSZX6UbdDRSIbxF/Blfd2CQvJmoDkGzvxzKyKKJYPG5hbAMhMwtTHONqWU=
X-Received: by 2002:a05:6512:3c89:b0:4a2:bfd2:b218 with SMTP id
 h9-20020a0565123c8900b004a2bfd2b218mr31843983lfv.228.1670598611378; Fri, 09
 Dec 2022 07:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20221209133414.3330761-1-ardb@kernel.org> <Y5NINaentm954uix@FVFF77S0Q05N>
 <CAMj1kXEyvBr16tWUqhTJv7JiaxYWaDa8RSByVzu6RJDASr1AMw@mail.gmail.com> <Y5NNe2gpGL8DmfDm@FVFF77S0Q05N>
In-Reply-To: <Y5NNe2gpGL8DmfDm@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 16:10:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEme+DzyvS8kXj6qHicBMbz8==FRi=02hs-pX=AJrNf0g@mail.gmail.com>
Message-ID: <CAMj1kXEme+DzyvS8kXj6qHicBMbz8==FRi=02hs-pX=AJrNf0g@mail.gmail.com>
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

On Fri, 9 Dec 2022 at 16:00, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Dec 09, 2022 at 03:46:48PM +0100, Ard Biesheuvel wrote:
> > On Fri, 9 Dec 2022 at 15:37, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Fri, Dec 09, 2022 at 02:34:14PM +0100, Ard Biesheuvel wrote:
> > > > The EFI runtime services run from a dedicated stack now, and so the
> > > > stack unwinder needs to be informed about this.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >
> > > > I realised while looking into this that comparing current_work() against
> > > > efi_rts_work.work is not sufficient to decide whether current is running
> > > > EFI code, given that the ACPI subsystem will call efi_call_virt_pointer()
> > > > directly.
> > > >
> > > > So instead, we can check whether the stashed thread stack pointer value
> > > > matches current's thread stack if the EFI runtime stack is currently in
> > > > use:
> > > >
> > > > #define current_in_efi()                                               \
> > > >        (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> > > >         on_task_stack(current, efi_rt_stack_top[-1], 1))
> > >
> > > Unless you're overwriting task_struct::stack (which seems scary to me), that
> > > doesn't look right; on_task_stack() checks whether a given base + size is on
> > > the stack allocated for the task (i.e. task_struct::stack + THREAD_SIZE), not
> > > the stack the task is currently using.
> > >
> >
> > Note the [-1].
> >
> > efi_rt_stack_top[-1] contains the value the stack pointer had before
> > switching to the EFI runtime stack. If that value is an address
> > covered by current's thread stack, current must be the task that has a
> > live call frame inside the EFI code at the time the call stack is
> > captured.
>
> Ah, I had missed that subtlety.
>
> Would you mind if we add that first sentence as a comment for that code, i.e.
>
> | /*
> |  * efi_rt_stack_top[-1] contains the value the stack pointer had before
> |  * switching to the EFI runtime stack.
> |  */
> |  #define current_in_efi()                                               \
> |         (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> |          on_task_stack(current, efi_rt_stack_top[-1], 1))
>
> ... that way when I look at this in 3 to 6 months time I won't fall into the
> same trap. :)
>

Will do.

> I assume that the EFI trampoline code clobbers the value on the way out so it
> doesn't spruriously match later.
>

Not currently, no. But that's easily added.


> > > I would expect this to be something like:
> > >
> > > #define current_in_efi()                                                \
> > >         (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> > >          stackinfo_on_stack(stackinfo_get_efi(), current_stack_pointer, 1))
> > >
> > > ... or an inline function given this is sufficiently painful as a macro.
> >
> > current_stack_pointer is the actual value of SP at the time this code
> > is called. So if we are unwinding from a sync exception taken while
> > handling an IRQ that arrived while running the EFI code, that SP value
> > has nothing to do with the EFI stack.
>
> Yes, good point.
>
> > > ... unless I've confused myself?
> > >
> >
> > I think you might have ... :-)
>
> :)
>
> Mark.
