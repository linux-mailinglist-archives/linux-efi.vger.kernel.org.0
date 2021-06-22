Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035D03B00CE
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jun 2021 11:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFVJ4f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Jun 2021 05:56:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVJ4e (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Jun 2021 05:56:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A91E1FB;
        Tue, 22 Jun 2021 02:54:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807EA3F694;
        Tue, 22 Jun 2021 02:54:15 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:54:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>
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
Subject: Re: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V
 clocksource/clockevent support
Message-ID: <20210622095412.GC67232@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
 <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210518170016.GP82842@C02TD0UTHF1T.local>
 <MWHPR21MB1593800A20B55626ACE6A844D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210610164519.GB63335@C02TD0UTHF1T.local>
 <MWHPR21MB1593095A9B8B61B14D7DF08DD7319@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593095A9B8B61B14D7DF08DD7319@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Michael,

Thanks for all this; comments inline below. I've added Marc Zyngier, who
co-maintains the architected timer code.

On Mon, Jun 14, 2021 at 02:42:23AM +0000, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Thursday, June 10, 2021 9:45 AM
> > On Tue, Jun 08, 2021 at 03:36:06PM +0000, Michael Kelley wrote:
> > > I've had a couple rounds of discussions with the Hyper-V team.   For
> > > the clocksource we've agreed to table the live migration discussion, and
> > > I'll resubmit the code so that arm_arch_timer.c provides the
> > > standard arch_sys_counter clocksource.  As noted previously, this just
> > > works for a Hyper-V guest.  The live migration discussion may come
> > > back later after a deeper investigation by Hyper-V.
> > 
> > Great; thanks for this!
> > 
> > > For clockevents, there's not a near term fix.  It's more than just plumbing
> > > an interrupt for Hyper-V to virtualize the ARM64 arch timer in a guest VM.
> > > From their perspective there's also benefit in having a timer abstraction
> > > that's independent of the architecture, and in the Linux guest, the STIMER
> > > code is common across x86/x64 and ARM64.  It follows the standard Linux
> > > clockevents model, as it should. The code is already in use in out-of-tree
> > > builds in the Linux VMs included in Windows 10 on ARM64 as part of the
> > > so-called "Windows Subsystem for Linux".
> > >
> > > So I'm hoping we can get this core support for ARM64 guests on Hyper-V
> > > into upstream using the existing STIMER support.  At some point, Hyper-V
> > > will do the virtualization of the ARM64 arch timer, but we don't want to
> > > have to stay out-of-tree until after that happens.
> > 
> > My main concern here is making sure that we can rely on architected
> > properties, and don't have to special-case architected bits for hyperv
> > (or any other hypervisor), since that inevitably causes longer-term
> > pain.
> > 
> > While in abstract I'm not as worried about using the timer
> > clock_event_device specifically, that same driver provides the
> > clocksource and the event stream, and I want those to work as usual,
> > without being tied into the hyperv code. IIUC that will require some
> > work, since the driver won't register if the GTDT is missing timer
> > interrupts (or if there is no GTDT).
> > 
> > I think it really depends on what that looks like.
> 
> Mark,
> 
> Here are the details:
> 
> The existing initialization and registration code in arm_arch_timer.c
> works in a Hyper-V guest with no changes.  As previously mentioned,
> the GTDT exists and is correctly populated.  Even though it isn't used,
> there's a PPI INTID specified for the virtual timer, just so
> the "arm_sys_timer" clockevent can be initialized and registered.
> The IRQ shows up in the output of "cat /proc/interrupts" with zero counts
> for all CPUs since no interrupts are ever generated. The EL1 virtual
> timer registers (CNTV_CVAL_EL0, CNTV_TVAL_EL0, and CNTV_CTL_EL0)
> are accessible in the VM.  The "arm_sys_timer" clockevent is left in
> a shutdown state with CNTV_CTL_EL0.ENABLE set to zero when the
> Hyper-V STIMER clockevent is registered with a higher rating.

This concerns me, since we're lying to the kernel, and assuming that it
will never try to use this timer. I appreciate that evidently we don't
happen to rely on that today if you register a higher priority timer,
but that does open us up to future fragility (e.g. if we added sanity
checks when registering timers), and IIRC there are ways for userspace
to change the clockevent device today.

> Event streams are initialized and the __delay() implementation
> for ARM64 inside the kernel works.  However, on the Ampere
> eMAG hardware I'm using for testing, the WFE instruction returns
> more quickly than it should even though the event stream fields in
> CNTKCTL_EL1 are correct.  I have a query in to the Hyper-V team 
> to see if they are trapping WFE and just returning, vs. perhaps the
> eMAG processor takes the easy way out and has WFE just return
> immediately.  I'm not knowledgeable about other uses of timer
> event streams, so let me know if there are other usage scenarios
> I should check.

I saw your reply confirming that this is gnerally working as expected
(and that Hyper-V is not trapping WFE) so this sounds fine to me.

> Finally, the "arch_sys_counter" clocksource gets initialized and
> setup correctly.  If the Hyper-V clocksource is also initialized,
> you can flip between the two clocksources at runtime as expected.
> If the Hyper-V clocksource is not setup, then Linux in the VM runs
> fine with the "arch_sys_counter" clocksource.

Great!

As above, my remaining concern here is fragility around the
clockevent_device; I'm not keen that we're lying (in the GTDT) that
interrupts are wired up when they not functional, and while you can get
away with that today, that relies on kernel implementation details that
could change.

Ideally, Hyper-V would provide the architectural timer (as it's already
claiming to in the GTDT), things would "just work", and the Hyper-V
timer would be an optimization rather than a functional necessity.

You mentioned above that Hyper-V will virtualize the timer "at some
point" -- is that already planned, and when is that likely to be?

Marc, do you have any thoughts on this?

Thanks,
Mark.
