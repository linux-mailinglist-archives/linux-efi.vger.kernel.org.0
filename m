Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565BF38E259
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhEXIeU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 04:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhEXIeU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 May 2021 04:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621845172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2440jf5xR5Xu8OmRT8dNrdYNpeIAuaDPlOXqgxmmMQ=;
        b=U4qiwqlwxalft1XDefB9m7EWnDQteoe1ea+YR/LgiVOW4dkjukMqZonM5lpPhvQLleHrwa
        yWKJqa6E3xm55S3uQDVV3HZosthLNwYu3Jc6gEoPGKaVJHe+loZeWdMEqm5klCek8s8fnC
        F/jLLS2AS6IWH0EO0BIHIu8sd5XfaEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-xPt4C06uPRqVjI7bRbTR4w-1; Mon, 24 May 2021 04:32:50 -0400
X-MC-Unique: xPt4C06uPRqVjI7bRbTR4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F76C803622;
        Mon, 24 May 2021 08:32:48 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70D011B49D;
        Mon, 24 May 2021 08:32:42 +0000 (UTC)
Date:   Mon, 24 May 2021 16:32:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lijiang <lijiang@redhat.com>, andy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dvhart@infradead.org, kexec@lists.infradead.org,
        hpa@zytor.com, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
Message-ID: <20210524083239.GA2872@MiWiFi-R3L-srv>
References: <20210412011347.GA4282@MiWiFi-R3L-srv>
 <8FAA2A0E-0A09-4308-B936-CDD2C0568BAE@amacapital.net>
 <20210412095231.GC4282@MiWiFi-R3L-srv>
 <CALCETrV0dgn1=7CoB+BSHdDuzqtfpKGOPvjJg+sNo74VrcJE=A@mail.gmail.com>
 <20210413094515.GD4282@MiWiFi-R3L-srv>
 <CANU+ZydgWTSg+iUix8ggn-cSPpg8qtShaUQ47cOeeMxFmXp_zQ@mail.gmail.com>
 <CANU+ZydyKsctuFjPfBz7PuS=FaUtK0gs5Lq06pL5nuRJKe+J0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANU+ZydyKsctuFjPfBz7PuS=FaUtK0gs5Lq06pL5nuRJKe+J0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Lianbo,

On 05/24/21 at 11:00am, lijiang wrote:
> Also add mail lists and more people in the cc list.
> 
> Thanks.
> Lianbo
> 
> 
> On Fri, May 21, 2021 at 8:36 PM lijiang <lijiang@redhat.com> wrote:
> 
> > Hi, Baoquan, Andy
> > Sorry for the late reply.
> >
> > On Tue, Apr 13, 2021 at 5:45 PM Baoquan He <bhe@redhat.com> wrote:
> >
> >> On 04/12/21 at 08:24am, Andy Lutomirski wrote:
> >> > On Mon, Apr 12, 2021 at 2:52 AM Baoquan He <bhe@redhat.com> wrote:
> >> > >
> >> > > On 04/11/21 at 06:49pm, Andy Lutomirski wrote:
> >> > > >
> >> > > >
> >> > > > > On Apr 11, 2021, at 6:14 PM, Baoquan He <bhe@redhat.com> wrote:
> >> > > > >
> >> > > > > ﻿On 04/09/21 at 07:59pm, H. Peter Anvin wrote:
> >> > > > >> Why don't we do this unconditionally? At the very best we gain
> >> half a megabyte of memory (except the trampoline, which has to live there,
> >> but it is only a few kilobytes.)
> >> > > > >
> >> > > > > This is a great suggestion, thanks. I think we can fix it in this
> >> way to
> >> > > > > make code simpler. Then the specific caring of real mode in
> >> > > > > efi_free_boot_services() can be removed too.
> >> > > > >
> >> > > >
> >> > > > This whole situation makes me think that the code is buggy before
> >> and buggy after.
> >> > > >
> >> > > > The issue here (I think) is that various pieces of code want to
> >> reserve specific pieces of otherwise-available low memory for their own
> >> nefarious uses. I don’t know *why* crash kernel needs this, but that
> >> doesn’t matter too much.
> >> > >
> >> > > Kdump kernel also need go through real mode code path during bootup.
> >> It
> >> > > is not different than normal kernel except that it skips the firmware
> >> > > resetting. So kdump kernel needs low 1M as system RAM just as normal
> >> > > kernel does. Here we reserve the whole low 1M with memblock_reserve()
> >> > > to avoid any later kernel or driver data reside in this area.
> >> Otherwise,
> >> > > we need dump the content of this area to vmcore. As we know, when
> >> crash
> >> > > happened, the old memory of 1st kernel should be untouched until
> >> vmcore
> >> > > dumping read out its content. Meanwhile, kdump kernel need reuse low
> >> 1M.
> >> > > In the past, we used a back up region to copy out the low 1M area, and
> >> > > map the back up region into the low 1M area in vmcore elf file. In
> >> > > 6f599d84231fd27 ("x86/kdump: Always reserve the low 1M when the
> >> crashkernel
> >> > > option is specified"), we changed to lock the whole low 1M to avoid
> >> > > writting any kernel data into, like this we can skip this area when
> >> > > dumping vmcore.
> >> > >
> >> > > Above is why we try to memblock reserve the whole low 1M. We don't
> >> want
> >> > > to use it, just don't want anyone to use it in 1st kernel.
> >> > >
> >> > > >
> >> > > > I propose that the right solution is to give low-memory-reserving
> >> code paths two chances to do what they need: once at the very beginning and
> >> once after EFI boot services are freed.
> >> > > >
> >> > > > Alternatively, just reserve *all* otherwise unused sub 1M memory up
> >> front, then release it right after releasing boot services, and then invoke
> >> the special cases exactly once.
> >> > >
> >> > > I am not sure if I got both suggested ways clearly. They look a little
> >> > > complicated in our case. As I explained at above, we want the whole
> >> low
> >> > > 1M locked up, not one piece or some pieces of it.
> >> >
> >> > My second suggestion is probably the better one.  Here it is,
> >> concretely:
> >> >
> >> > The early (pre-free_efi_boot_services) code just reserves all
> >> > available sub-1M memory unconditionally, but it specially marks it as
> >> > reserved-but-available-later.  We stop allocating the trampoline page
> >> > at this stage.
> >> >
> >> > In free_efi_boot_services, instead of *freeing* the sub-1M memory, we
> >> > stick it in the pile of reserved memory created in the early step.
> >> > This may involve splitting a block, kind of like the current
> >> > trampoline late allocation works.
> >> >
> >> > Then, *after* free_efi_boot_services(), we run a single block of code
> >> > that lets everything that wants sub-1M code claim some.  This means
> >> > that the trampoline gets allocated and, if crashkernel wants to claim
> >> > everything else, it can.  After that, everything still unclaimed gets
> >> > freed.
> >>
> >> void __init setup_arch(char **cmdline_p)
> >> {
> >> ...
> >>         efi_reserve_boot_services();
> >>         e820__memblock_alloc_reserved_mpc_new();
> >> #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
> >>         setup_bios_corruption_check();
> >> #endif
> >>         reserve_real_mode();
> >>
> >>
> >>         trim_platform_memory_ranges();
> >>         trim_low_memory_range();
> >> ...
> >> }
> >>
> >> After efi_reserve_boot_services(), there are several function calling to
> >> require memory reservation under low 1M.
> >>
> >>
> >> asmlinkage __visible void __init __no_sanitize_address
> >> start_kernel(void)
> >>
> >> {
> >> ...
> >>         setup_arch(&command_line);
> >> ...
> >>         mm_init();
> >>                 --> mem_init();
> >>                          -->memblock_free_all();
> >>
> >> ...
> >> #ifdef CONFIG_X86
> >>         if (efi_enabled(EFI_RUNTIME_SERVICES))
> >>                 efi_enter_virtual_mode();
> >>                         -->efi_free_boot_services();
> >>                                 -->memblock_free_late();
> >> #endif
> >> ...
> >> }
> >>
> >> So from the code flow, we can see that buddy allocator is built in
> >> mm_init() which puts all memory from memblock.memory excluding
> >> memblock.reserved into buddy. And much later, we call
> >> efi_free_boot_services() to release those reserved efi boot memory into
> >> buddy too.
> >>
> >> Are you suggesting we should do the memory reservation from low 1M
> >> after efi_free_boot_services()? To require memory pages from buddy for
> >> them? Please help point out my misunderstanding if have any.
> >>
> >> With my understanding, in non-efi case, we have done the memory
> >> reservation with memblock_reserve(), e.g
> >> e820__memblock_alloc_reserved_mpc_new, reserve_real_mode() are calling
> >> to do. Just efi_reserve|free_boot_services() break them when efi is
> >>
> >
> >  Yes. But Andy also suggested to reserve all available sub-1M memory
> > **unconditionally**
> > in the early code.
> >
> > enabled. We can do them again in efi_free_boot_services() just like the
> >> real_mode reservation does.
> >>
> >
> > Do you mean to call the memblock_reserve() in
> > the efi_free_boot_services()? Or anything else?
> > Would you mind sharing more details about this?

Hmm, maybe no. There's no chance to call memblock_reserve() after 
memblock_free_late().

I suggested making change in efi_free_boot_services() because the
similar problem has been encountered by Andy himself and fixed in
efi_free_boot_services(). Please check below commit for reference.
The patch described the phenemenon, while explained why in code
comment.

commit 5bc653b7318217c54244a14f248f1f07abe0a865
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Aug 10 02:29:17 2016 -0700

    x86/efi: Allocate a trampoline if needed in efi_free_boot_services()

So we could handle it in the same place by extending the area to the
whole low-1M unconditionally. This is 1st way of three I can think of.

The other two are:
2) Move efi_reserve_boot_services() down to be above init_mem_mapping().
until init_mem_mapping(), we stop reserving memory from low-1M with
memblock_reserve(). The change is like below:

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 72920af0b3c0..93b2106d2050 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1067,7 +1067,6 @@ void __init setup_arch(char **cmdline_p)
 	 * The EFI specification says that boot service code won't be
 	 * called after ExitBootServices(). This is, in fact, a lie.
 	 */
-	efi_reserve_boot_services();
 
 	/* preallocate 4k for mptable mpc */
 	e820__memblock_alloc_reserved_mpc_new();
@@ -1090,6 +1089,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	trim_snb_memory();
 
+	efi_reserve_boot_services();
+
 	init_mem_mapping();
 
 	idt_setup_early_pf();


3) Do it in efi_reserve_boot_services() as you are doing in this patch.

I prefer the 1st and 2nd way.

And by the way, the original code of commit 5bc653b731821("x86/efi: Allocate
a trampoline if needed in efi_free_boot_services()") could be buggy. I
remember you ever pasted the boot log of system where you reproduced
issue and tested the tested patch, there are three separate pages from
low-1M reserved by boot services. If any of them falls into real mode
area, it will break the fix of commit 5bc653b731821.

Thanks
Baoquan

> >
> > diff --git a/arch/x86/platform/efi/quirks.c
> > b/arch/x86/platform/efi/quirks.c
> > index 7850111008a8..d02f12a60457 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -453,6 +453,8 @@ void __init efi_free_boot_services(void)
> >                 memblock_free_late(start, size);
> >         }
> >
> > +       memblock_reserve(0, 1<<20);
> > +
> >         if (!num_entries)
> >                 return;
> >
> > Thanks.
> > Lianbo
> >
> >
> > Thanks
> >> Baoquan
> >>
> >

