Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979F0382B65
	for <lists+linux-efi@lfdr.de>; Mon, 17 May 2021 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhEQLqM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 May 2021 07:46:12 -0400
Received: from foss.arm.com ([217.140.110.172]:49076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhEQLqM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 May 2021 07:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD3B1042;
        Mon, 17 May 2021 04:44:55 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845F73F73D;
        Mon, 17 May 2021 04:44:52 -0700 (PDT)
Date:   Mon, 17 May 2021 12:44:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v10 2/7] arm64: hyperv: Add Hyper-V hypercall and
 register access utilities
Message-ID: <20210517114449.GB62656@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-3-git-send-email-mikelley@microsoft.com>
 <20210514125243.GC30645@C02TD0UTHF1T.local>
 <MWHPR21MB1593A7625285A3E3F376B352D7509@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593A7625285A3E3F376B352D7509@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 14, 2021 at 03:14:41PM +0000, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:53 AM
> > 
> > On Wed, May 12, 2021 at 10:37:42AM -0700, Michael Kelley wrote:
> > > hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> > > Functional Spec (TLFS), and #includes the architecture-independent
> > > part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
> > > is distinctly oriented to x86/x64, so the ARM64-specific
> > > hyperv-tlfs.h includes information for ARM64 that is not yet formally
> > > published. The TLFS is available here:
> > >
> > >   docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > >
> > > mshyperv.h defines Linux-specific structures and routines for
> > > interacting with Hyper-V on ARM64, and #includes the architecture-
> > > independent part of mshyperv.h in include/asm-generic.
> > >
> > > Use these definitions to provide utility functions to make
> > > Hyper-V hypercalls and to get and set Hyper-V provided
> > > registers associated with a virtual processor.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > ---
> > >  MAINTAINERS                          |   3 +
> > >  arch/arm64/Kbuild                    |   1 +
> > >  arch/arm64/hyperv/Makefile           |   2 +
> > >  arch/arm64/hyperv/hv_core.c          | 130 +++++++++++++++++++++++++++++++++++
> > >  arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++++++++
> > >  arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++++++
> > >  6 files changed, 259 insertions(+)
> > >  create mode 100644 arch/arm64/hyperv/Makefile
> > >  create mode 100644 arch/arm64/hyperv/hv_core.c
> > >  create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
> > >  create mode 100644 arch/arm64/include/asm/mshyperv.h
> > 
> > > +/*
> > > + * hv_do_hypercall- Invoke the specified hypercall
> > > + */
> > > +u64 hv_do_hypercall(u64 control, void *input, void *output)
> > > +{
> > > +	struct arm_smccc_res	res;
> > > +	u64			input_address;
> > > +	u64			output_address;
> > > +
> > > +	input_address = input ? virt_to_phys(input) : 0;
> > > +	output_address = output ? virt_to_phys(output) : 0;
> > 
> > I may have asked this before, but are `input` and `output` always linear
> > map pointers, or can they ever be vmalloc pointers?
> > 
> > Otherwise, this looks fine to me.
> 
> The caller must ensure that hypercall arguments are aligned to
> 4 Kbytes, and no larger than 4 Kbytes, since that's the page size
> used by Hyper-V regardless of the guest page size.  A per-CPU
> 4 Kbyte memory area (hyperv_pcpu_input_arg) meeting these
> requirements is pre-allocated that callers can use for this purpose.

What I was trying to find out was how that was allocated, as vmalloc()'d
pointers aren't legitimate to pass to virt_to_phys().

From scanning ahead to patch 5, I see that memory comes from kmalloc(),
and so it is legitimate to use virt_to_phys().


I see; and from patch 5 I see that memory come from kmalloc(), and will
therefore be part of the linear map, and so virt_to_phys() is
legitimate.

What I was asking here was how that memory was allocated. So long as
those are the only buffers used, this looks fine to me.

Thanks,
Mark.
