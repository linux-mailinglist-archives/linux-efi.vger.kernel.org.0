Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8778306A
	for <lists+linux-efi@lfdr.de>; Tue,  6 Aug 2019 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfHFLPH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Tue, 6 Aug 2019 07:15:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730071AbfHFLPH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 6 Aug 2019 07:15:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18099CFF7B89D876E46A;
        Tue,  6 Aug 2019 19:15:05 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 19:14:55 +0800
Date:   Tue, 6 Aug 2019 12:14:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linuxarm@huawei.com>,
        <rjw@rjwysocki.net>, <tony.luck@intel.com>, <bp@alien8.de>,
        <ard.beisheuvel@arm.com>, <nariman.poushin@linaro.org>,
        <jcm@redhat.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
Subject: Re: [RFC PATCH 0/6] CCIX Protocol Error reporting
Message-ID: <20190806121443.00006211@huawei.com>
In-Reply-To: <20190703140849.000018d6@huawei.com>
References: <20190606123654.78973-1-Jonathan.Cameron@huawei.com>
        <728c7959-b5b3-5b59-fe79-e774c3b89465@arm.com>
        <20190703140849.000018d6@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 Jul 2019 14:08:49 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Wed, 3 Jul 2019 10:28:08 +0100
> James Morse <james.morse@arm.com> wrote:
> 
> > Hi Jonathan,
> > 
> > (Beware: this CCIX thing is new to me, some of this will be questions on the scope of CCIX)  
> 
> Sure and welcome to our crazy world.
> 
> > 
> > On 06/06/2019 13:36, Jonathan Cameron wrote:  
> > > UEFI 2.8 defines a new CPER record Appendix N for CCIX Protocol Error Records
> > > (PER). www.uefi.org    
> >   
> > > These include Protocol Error Record logs which are defined in the
> > > CCIX 1.0 Base Specification www.ccixconsortium.com.    
> > 
> > I can't find a public version of this spec, and I don't have an account to look at the
> > private one. (It looks like I could get one but I'm guessing there is an NDA between me
> > and the document text!)
> > 
> > Will it ever be public?  
> 
> +cc A few people who might be able to help.

Evaluation version of the CCIX 1.0a base specification now available,
(though there is a form to complete and license agreement)..

https://www.ccixconsortium.com/ccix-library/download-form/


> 
> > 
> >   
> > > Handling of coherency protocol errors is complex and how Linux does this
> > > will take some time to evolve.  For now, fatal errors are handled via the
> > > usual means and everything else is reported.    
> >   
> > > There are 6 types of error defined, covering:
> > > * Memory errors    
> > 
> > How does this interact with the vanilla Memory-Error CPER records? Do we always get them
> > as a pair? (that struct definition looks familiar...)  
> 
> The snag is that the standard memory error doesn't provide quite enough information to
> actually identify a component once you have buses involved.
> The actual memory specific bit is nearly identical, but the header section isn't
> as it gives the CCIX agent ID (see below given you asked a more specific question
> on that).
> 
> We did discuss this in a lot of detail and currently the answer is that the
> UEFI spec + ccix allows you to report only the ccix error if you want to.
> 
> Note that I believe there is an OSC bit that I'm not currently setting so
> right now no firmware compliant with the CCIX SW Guide (information available
> from your local Charles) should actually be generating these anyway because
> the OS hasn't said it can handle them.  I took the view I wanted to get
> round 2 which actually hooks up handling rather than just reporting before
> setting that bit.
> 
> > Is memory described like this never present in the UEFI memory map? (so we never
> > accidentally use it as host memory, for processes etc)  
> Yes it definitely can.  If you want to you can have all your RAM attached by CCIX.
> (probably not a good idea performance wise :)
> 
> More likely in the short term is SCM using something like the hmem patches
> to hotplug it as if it were RAM.
> https://patchwork.kernel.org/cover/10982677/
> 
> In order to support legacy OS, it wouldn't be unusual to have a bios switch
> to make SCM on CCIX just appear as normal memory in the first place
> (if that was true though it is highly unlikely you'd use the CCIX
> PER messages.)
> 
> > 
> > ~
> > 
> > include/linux/memremap.h has:
> > |  * Device memory that is cache coherent from device and CPU point of view. This
> > |  * is use on platform that have an advance system bus (like CAPI or CCIX). A
> > |  * driver can hotplug the device memory using ZONE_DEVICE and with that memory
> > |  * type. Any page of a process can be migrated to such memory. However no one
> > |  * should be allow to pin such memory so that it can always be evicted.
> > 
> > Is this the same CCIX?  
> 
> Not always, but sometimes.  Typically if it's on an accelerator (GPU etc) then
> one software model is to do that.  There are others though. Until we have
> more devices out there, its not even clear that model with dominate.
> 
> It's a much argued about topic. My personal thoughts are you either have:
> 1. An accelerator that was designed from the ground up assuming that it had
>    tight control of its own memory layout etc - someone bolted on coherency
>    later.  This is the current GPU model and fits with ZONE_DEVICE etc. GPUs
>    can and do require shuffling memory.
> 
> 2. An accelerator designed to run without it's own memory.  We just decided
>    to move some of the host memory to it's end of the bus for size or
>    efficiency reasons.  As it's reasonably happy with fragmentation and
>    the assumption that someone else is doing it's memory management for it
>    (the OS) you can run in an SVM type mode, with a bit of hinting by
>    a userspace app on where it would prefer the accelerator accessed memory
>    comes from.  Those have no more constraints than any other memory.  If
>    you want to pin for RDMA for example, its fine.
> 
> More importantly, it can just be normal DDR on a card with no extra functions.
> In those cases it's just a memory only NUMA node.
> 
> > 
> > If process memory can be migrated onto this stuff we need to kick off memory_failure() in
> > response to memory errors, otherwise we don't mark the pages as poison, signal user-space etc.  
> 
> Agreed.  That was in the follow up patch set (which I haven't written yet)
> that actually does some error handling.  I need to do some work on the
> emulation side to actually be able to generate sensible errors of that type.
> 
> I'll stick some mention of that in the v2 cover letter.
> > 
> >   
> > > * Cache errors
> > > * Address translation unit errors    
> >   
> > > * CCIX port errors 
> > > * CCIX link errors    
> > 
> > It looks like this stuff operates 'over' PCIe[0]. How does this interact with AER?
> > Will we always get a vanilla PCIE-AER CPER in addition to these two?  
> 
> Nope. You'll get an AER for PCIe protocol, transport and data link layers and
> PER error for CCIX protocol layer.  We'll ignore the horrible abuse of
> Internal Error in AER that people do (pointing no fingers but the spec makes
> it clear what this is for and it's not what most people use it for).
> 
> So depends on what went wrong.  Some types of error (ripping out a board perhaps)
> might cause a cascade but in general they are independent systems.  For extra
> fun they aren't even routed over the same physical links in some topologies.
> CCIX per is CCIX ID routed (and we have meshes), AER has to follow the PCIe
> tree.  In theory the CCIX Error Agent doesn't actually to be in the host,
> and it certainly doesn't have to be via the same root port.
> 
> > 
> > (I see 'CHECK THE AER EQUIVALENT' comments in your series, are these TODO:?)  
> Oops.  That was a formatting question that I'd forgotten about.
> 
> Both PCIe AER and CCIX PER have error cases in which part of the TLP
> (at different layers) is captured in the error record.  I just wanted
> to sanity check if I'd used similar formatting.
> 
> In some CCIX errors you get 32 bytes of the message that was in flight
> when the problem occurred.
> 
> I'll actually check the formatting and scrub the comment or adjust it for v2.
> Sorry about that - these were kicking around internally for far too long
> so they have gone in out of my head several times.
> 
> >
> >   
> > > * Agent internal errors.
> > > 
> > > The set includes tracepoints to report the errors to RAS Daemon and a patch
> > > set for RAS Daemon will follow shortly.
> > > 
> > > There are several open questions for this RFC.
> > > 1. Reporting of vendor data.  We have little choice but to do this via a
> > >    dynamic array as these blocks can take arbitrary size. I had hoped
> > >    no one would actually use these given the odd mismatch between a
> > >    standard error structure and non standard element, but there are
> > >    already designs out there that do use it.    
> > 
> > I think its okay to spit these blobs out of the trace points, but could we avoid printing
> > them in the kernel log?  
> 
> Seems like a reasonable compromise.  Leave them in the tp_printk
> and if anyone really wants to fill their kernel logs then they can.
> 
> > 
> >   
> > > 2. The trade off between explicit tracepoint fields, on which we might
> > >    want to filter, and the simplicity of a blob. I have gone for having
> > >    the whole of the block specific to the PER error type in an opaque blob.
> > >    Perhaps this is not the right balance?    
> > 
> > (I suspect I don't understand this).
> > 
> > The filtering can be done by user-space. Isn't that enough?  
> 
> It can, but then you have already logged them.  As I understand it you can
> apply the filters at the logging stage. Will take another look at this.
> Still I'm happy with the current balance, and there it'll be done in
> userspace anyway.
> 
> > 
> > I see the memory-error event format file has 'pa', which is all anyone is likely to care
> > about.
> > Do 'source/component' indicate the device? (what do I pull out of the machine to stop
> > these happening?)  
> 
> The answer to that is a qualified yes.  If you know the source ID and
> the configuration then it gets you to the actual device.
> For the various 'agents' Request Agent, Home Agent and Slave Agent,
> the sourceID is the globally unique (per type of agent) ID assigned during
> the topology configuration bit of firmware enumeration (it ends up as a field
> you can read from PCI config space).  For other things sourceID is the device ID
> which is assigned at an earlier phase of enumeration.  You may then need the
> portID to figure out exactly where it's broken (those are fixed for a given
> device).
> 
> Ultimately you use these to find out what the BDF is and hopefully figure out
> which board to pull and throw out of the window.
> 
> > 
> >   
> > > 3. Whether defining 6 new tracepoints is sensible. I think it is:
> > >    * They are all defined by the CCIX specification as independant error
> > >      classes.
> > >    * Many of them can only be generated by particular types of agent.
> > >    * The handling required will vary widely depending on types.
> > >      In the kernel some map cleanly onto existing handling. Keeping the
> > >      whole flow separate will aide this. They vary by a similar amount
> > >      in scope to the RAS errors found on an existing system which have
> > >      independent tracepoints.
> > >    * Separating them out allows for filtering on the tracepoints by
> > >      elements that are not shared between them.
> > >    * Muxing the lot into one record type can lead to ugly code both in
> > >      kernel and in userspace.    
> > 
> > Sold!
> > 
> >   
> > > This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> > > you and other parties that are paticipating (the "participants") in the
> > > Linux kernel with the understanding that the participants will use CCIX's
> > > name and trademark only when this patch is used in association with the
> > > Linux kernel and associated user space.
> > > 
> > > CCIX is also distributing this patch to these participants with the
> > > understanding that if any portion of the CCIX specification will be
> > > used or referenced in the Linux kernel, the participants will not modify
> > > the cited portion of the CCIX specification and will give CCIX propery
> > > copyright attribution by including the following copyright notice with
> > > the cited part of the CCIX specification:
> > > "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."    
> > 
> > Is this text permission from the CCIX-Consortium to reproduce bits of their spec in the
> > kernel?  
> <standard I'm not a lawyer disclaimer>
> 
> Hmm. The answer to that is 'sort of'.  It technically says anything in this
> patch is fine if it used that statement.  I believe it is kind of a catch all
> that just says quote under fair use terms, but as normal give clear copyright
> acknowledgment.  Some of the answers that others are hopefully going to give
> to earlier questions should clarify why this matters.
> 
> The main point of the whole statement being there at all is to give an explicit
> trademark grant to the kernel so that we can use CCIX(tm) without worrying about it.
> If you want to get scared, google the PCI-SIG(tm) trademark policy and think where
> we might be pushing the limits.
> 
> We asked the CCIX legal advisors to come up with a clear statement
> that meant open source projects could get in trouble for sensible trademark use.
> This grant is apparently the best way to do it.
>  
> > 
> > I'm guessing any one who can hold of the spec is also prevented from publishing it.
> > 
> > (Nits: participating, proper)  
> Yup. I copy typed this from my windows laptop to the linux machine because
> I was too lazy to navigate Huawei security zones and did a really bad job.
> Sorry Frank! (hope Frank never see this)
> 
> > 
> > 
> > Thanks,
> > 
> > James
> > 
> > [0] https://en.wikichip.org/wiki/ccix  
> 
> 


