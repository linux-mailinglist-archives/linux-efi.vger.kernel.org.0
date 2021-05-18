Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524AC387E18
	for <lists+linux-efi@lfdr.de>; Tue, 18 May 2021 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbhERRBj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 May 2021 13:01:39 -0400
Received: from foss.arm.com ([217.140.110.172]:57134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhERRBj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 May 2021 13:01:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09AB66D;
        Tue, 18 May 2021 10:00:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68D03F73B;
        Tue, 18 May 2021 10:00:18 -0700 (PDT)
Date:   Tue, 18 May 2021 18:00:16 +0100
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
Subject: Re: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V
 clocksource/clockevent support
Message-ID: <20210518170016.GP82842@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210517130815.GC62656@C02TD0UTHF1T.local>
 <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15930A4EE785984292B1D72BD72D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 17, 2021 at 05:27:49PM +0000, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, May 17, 2021 6:08 AM
> > 
> > On Fri, May 14, 2021 at 03:35:15PM +0000, Michael Kelley wrote:
> > > From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:37 AM
> > > > On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> > > > > Add architecture specific definitions and functions needed
> > > > > by the architecture independent Hyper-V clocksource driver.
> > > > > Update the Hyper-V clocksource driver to be initialized
> > > > > on ARM64.
> > > >
> > > > Previously we've said that for a clocksource we must use the architected
> > > > counter, since that's necessary for things like the VDSO to work
> > > > correctly and efficiently.
> > > >
> > > > Given that, I'm a bit confused that we're registering a per-cpu
> > > > clocksource that is in part based on the architected counter. Likewise,
> > > > I don't entirely follow why it's necessary to PV the clock_event_device.
> > > >
> > > > Are the architected counter and timer reliable without this PV
> > > > infrastructure? Why do we need to PV either of those?
> > > >
> > > > Thanks,
> > > > Mark.
> > >
> > > For the clocksource, we have a requirement to live migrate VMs
> > > between Hyper-V hosts running on hardware that may have different
> > > arch counter frequencies (it's not conformant to the ARM v8.6 1 GHz
> > > requirement).  The Hyper-V virtualization does scaling to handle the
> > > frequency difference.  And yes, there's a tradeoff with vDSO not
> > > working, though we have an out-of-tree vDSO implementation that
> > > we can use when necessary.
> > 
> > Just to be clear, the vDSO is *one example* of something that won't
> > function correctly. More generally, because this undermines core
> > architectural guarantees, it requires more invasive changes (e.g. we'd
> > have to weaken the sanity checks, and not use the counter in things like
> > kexec paths), impacts any architectural features tied to the generic
> > timer/counter (e.g. the event stream, SPE and tracing, future features),
> > and means that other SW (e.g. bootloaders and other EFI applications)
> > are unlikley to function correctly in this environment.
> > 
> > I am very much not keen on trying to PV this.
> > 
> > What does the guest see when it reads CNTFRQ_EL0? Does this match the
> > real HW value (and can this change over time)? Or is this entirely
> > synthetic?
> > 
> > What do the ACPI tables look like in the guest? Is there a GTDT table at
> > all?
> > 
> > How does the counter event stream behave?
> > 
> > Are there other architectural features which Hyper-V does not implement
> > for a guest?
> > 
> > Is there anything else that may change across a migration? e.g. MIDR?
> > MPIDR? Any of the ID registers?
> 
> The ARMv8 architectural system counter and associated registers are visible
> and functional in a VM on Hyper-V.   The "arch_sys_counter" clocksource is
> instantiated by the arm_arch_timer.c driver based on the GTDT in the guest,
> and a Linux guest on Hyper-V runs fine with this clocksource.  Low level code
> like bootloaders and EFI applications work normally.

That's good to hear!

One potential issue worth noting is that as those pieces of software are
unlikely to handle counter frequency changes reliably, and so may not
behave correctly if live-migrated.

> The Hyper-V virtualization provides another Linux clocksource that is an
> overlay on the arch counter and that provides time consistency across a live
> migration. Live migration of ARM64 VMs on Hyper-V is not functional today,
> but the Hyper-V team believes they can make it functional.  I have not
> explored with them the live migration implications of things beyond time
> consistency, like event streams, CNTFRQ_EL0, MIDR/MPIDR, etc.
> 
> Would a summary of your point be that live migration across hardware
> with different arch counter frequencies is likely to not be possible with
> 100% fidelity because of these other dependencies on the arch counter
> frequency?  (hence the fixed 1 GHz frequency in ARM v8.6)

Yes.

In addition, there are a larger set of things necessarily exposed to VMs
that mean that live migration isn't all that practical except betweenm
identical machines (where the counter frequency should be identical),
and the timer frequency might just be the canary in the coalmine. For
example, the cache properties enumerated in CTR_EL0 cannot necessarily
be emulated on another machine.

> > > For clockevents, the only timer interrupt that Hyper-V provides
> > > in a guest VM is its virtualized "STIMER" interrupt.  There's no
> > > virtualization of the ARM arch timer in the guest.
> > 
> > I think that is rather unfortunate, given it's a core architectural
> > feature. Is it just the interrupt that's missing? i.e. does all the
> > PE-local functionality behave as the architecture requires?
> 
> Right off the bat, I don't know about timer-related PE-local
> functionality as it's not exercised in a Linux VM on Hyper-V that is
> using STIMER-based clockevents.  I'll explore with the Hyper-V
> team.  My impression is that enabling the ARM arch timer in a
> guest VM is more work for Hyper-V than just wiring up an
> interrupt.

Thanks for chasing this up!

Mark.
