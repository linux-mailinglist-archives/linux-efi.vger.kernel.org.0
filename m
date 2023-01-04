Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4FC65D85A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjADQNy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 11:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbjADQNb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 11:13:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E397E2C;
        Wed,  4 Jan 2023 08:13:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E07E165C;
        Wed,  4 Jan 2023 08:14:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6AA63F71A;
        Wed,  4 Jan 2023 08:13:28 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:13:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, stable@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] arm64: efi: Execute runtime services from a
 dedicated stack
Message-ID: <Y7WloqaytMnC8ZIC@FVFF77S0Q05N>
References: <20221205201210.463781-1-ardb@kernel.org>
 <20221205201210.463781-2-ardb@kernel.org>
 <Y7VXg5MCRyAJFmus@google.com>
 <CAMj1kXEYDHuRmUPvdMVj1H1fLoOKcr+qG6NDpufxwJa57jsWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEYDHuRmUPvdMVj1H1fLoOKcr+qG6NDpufxwJa57jsWdg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 04, 2023 at 02:56:19PM +0100, Ard Biesheuvel wrote:
> On Wed, 4 Jan 2023 at 11:40, Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 05 Dec 2022, Ard Biesheuvel wrote:
> >
> > > With the introduction of PRMT in the ACPI subsystem, the EFI rts
> > > workqueue is no longer the only caller of efi_call_virt_pointer() in the
> > > kernel. This means the EFI runtime services lock is no longer sufficient
> > > to manage concurrent calls into firmware, but also that firmware calls
> > > may occur that are not marshalled via the workqueue mechanism, but
> > > originate directly from the caller context.
> > >
> > > For added robustness, and to ensure that the runtime services have 8 KiB
> > > of stack space available as per the EFI spec, introduce a spinlock
> > > protected EFI runtime stack of 8 KiB, where the spinlock also ensures
> > > serialization between the EFI rts workqueue (which itself serializes EFI
> > > runtime calls) and other callers of efi_call_virt_pointer().
> > >
> > > While at it, use the stack pivot to avoid reloading the shadow call
> > > stack pointer from the ordinary stack, as doing so could produce a
> > > gadget to defeat it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/efi.h       |  3 +++
> > >  arch/arm64/kernel/efi-rt-wrapper.S | 13 +++++++++-
> > >  arch/arm64/kernel/efi.c            | 25 ++++++++++++++++++++
> > >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > Could we have this in Stable please?
> >
> > Upstream commit: ff7a167961d1b ("arm64: efi: Execute runtime services from a dedicated stack")
> >
> > Ard, do we need Patch 2 as well, or can this be applied on its own?
> >
> 
> Thanks for the reminder.
> 
> Only patch #1 is needed. It should be applied to v5.10 and later.

Hold on, why did this go into mainline when I had an outstanding comment w.r.t.
the stack unwinder?

From your last reply to me there I was expecting a respin with that fixed.

Mark.
