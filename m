Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0166039C
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjAFPnK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Jan 2023 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjAFPmp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Jan 2023 10:42:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD57F460
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 07:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433326191A
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 15:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D2CC433D2
        for <linux-efi@vger.kernel.org>; Fri,  6 Jan 2023 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673019763;
        bh=h4JivlVuTXlcXG8nkqFBR54VS7VxEmTyI5eksFjShJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aP+J/mCtuDoYDiVDYoiMkhN1VIKl7TxztUWjaCN5qpo2Y8cvIlZUZt3w2Ur2ljiYy
         NS/a5T1bQ2oODMqlQY/+6JvrRCzB1M8XFvTzFa99ArCMCRFdFjVkexMM58Nww0hj6U
         uTerhSxTaAH6Z9DZsxZNe/I/UEzAw5g0jb/SL47XmgLssZwpSbTmg6UIIa29mSel3q
         pKu6ElWdqOX6mwGAb8KflNvvqxTP4eWCnTNPa3GkGJtTy2PmDgYfcIPNIXvOiohQE9
         P3bO8vxL4f4cDfmOSvGjACr3mNvEtCIZD73bmBC7lE30+JcdCh9P0KGAEvtuXBBmzO
         xdnHi4NWMk5fw==
Received: by mail-lf1-f41.google.com with SMTP id bf43so2464943lfb.6
        for <linux-efi@vger.kernel.org>; Fri, 06 Jan 2023 07:42:43 -0800 (PST)
X-Gm-Message-State: AFqh2krH67xZHqd+QCfy7ENgC+eCHastHnXiZEmPq+bm0umgAVfHWRVU
        EOfZo6uNNP2fu+JN1M8zP1N4dX0QdH5GIJ4ivQM=
X-Google-Smtp-Source: AMrXdXv3VFaMkA7oaIwJ0s9PFXzJF2HmKVf/baPG/lWhKWYZwenwwyYeH1TWvLqtPulucjJW+3ahs/L5y+jeD2ibLM8=
X-Received: by 2002:a19:ad4b:0:b0:4cb:315d:e9b8 with SMTP id
 s11-20020a19ad4b000000b004cb315de9b8mr2111113lfd.110.1673019761681; Fri, 06
 Jan 2023 07:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20230104174433.1259428-1-ardb@kernel.org> <20230104174433.1259428-2-ardb@kernel.org>
 <Y7bGeOZ1+Z2cH9NF@FVFF77S0Q05N>
In-Reply-To: <Y7bGeOZ1+Z2cH9NF@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 Jan 2023 16:42:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGp5Ba5M0OLHJVMbkE4Fc93ANiLPoMyzM7Opjegek1dGw@mail.gmail.com>
Message-ID: <CAMj1kXGp5Ba5M0OLHJVMbkE4Fc93ANiLPoMyzM7Opjegek1dGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: efi: Avoid workqueue to check whether EFI
 runtime is live
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Jan 2023 at 13:46, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Ard,
>
> On Wed, Jan 04, 2023 at 06:44:32PM +0100, Ard Biesheuvel wrote:
> > Comparing current_work() against efi_rts_work.work is sufficient to
> > decide whether current is currently running EFI runtime services code at
> > any level in its call stack.
> >
> > However, there are other potential users of the EFI runtime stack, such
> > as the ACPI subsystem, which may invoke efi_call_virt_pointer()
> > directly, and so any sync exceptions occurring in firmware during those
> > calls are currently misidentified.
> >
> > So instead, let's check whether the spinlock is locked, and whether the
> > stashed value of the thread stack pointer points into current's thread
> > stack. This can only be the case if current was interrupted while
> > running EFI runtime code.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/efi.h | 10 ++++++++++
> >  arch/arm64/kernel/efi.c      |  3 ++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> > index 31d13a6001df49c4..aca6dcaa33efbac4 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -42,14 +42,24 @@ int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
> >
> >  #define arch_efi_call_virt_teardown()                                        \
> >  ({                                                                   \
> > +     efi_rt_stack_top[-1] = 0;                                       \
>
> Is there any reason not to do this in the asm, given all the other setting of
> this occurs there? I know that'd mean duplicating the writ for both the regular
> case and the exception handler, but then it'd be clearly associated with the
> instant we move away from the EFI RT stack.
>
> That would also hide this write from KCSAN; itherwise this'll need to be a
> WRITE_ONCE() to pair with the (not necessariyl) locked read in current_in_efi()
> below.
>

Sure.

> >       spin_unlock(&efi_rt_lock);                                      \
> >       __efi_fpsimd_end();                                             \
> >       efi_virtmap_unload();                                           \
> >  })
> >
> >  extern spinlock_t efi_rt_lock;
> > +extern u64 *efi_rt_stack_top;
> >  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
> >
> > +/*
> > + * efi_rt_stack_top[-1] contains the value the stack pointer had before
> > + * switching to the EFI runtime stack.
> > + */
> > +#define current_in_efi()                                             \
> > +     (!preemptible() && spin_is_locked(&efi_rt_lock) &&              \
> > +      on_task_stack(current, efi_rt_stack_top[-1], 1))
>
> KCSAN is liable to complain about the access to efi_rt_stack_top[-1], since
> that can race with another thread updating the value, and it's not necessarily
> single-copy-atomic.
>
> It's probably worth making this a READ_ONCE(), even if we move all the writes
> to asm, to avoid tearing.
>
> Aside from those points, this looks good to me.
>

ok
