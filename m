Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7137382CDC
	for <lists+linux-efi@lfdr.de>; Mon, 17 May 2021 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhEQNJi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 May 2021 09:09:38 -0400
Received: from foss.arm.com ([217.140.110.172]:50876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237232AbhEQNJh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 May 2021 09:09:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6E1113E;
        Mon, 17 May 2021 06:08:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.3.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6DB3F73B;
        Mon, 17 May 2021 06:08:18 -0700 (PDT)
Date:   Mon, 17 May 2021 14:08:15 +0100
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
Message-ID: <20210517130815.GC62656@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
 <20210514123711.GB30645@C02TD0UTHF1T.local>
 <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15932B44EC1E55614B219F5ED7509@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 14, 2021 at 03:35:15PM +0000, Michael Kelley wrote:
> From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 14, 2021 5:37 AM
> > On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> > > Add architecture specific definitions and functions needed
> > > by the architecture independent Hyper-V clocksource driver.
> > > Update the Hyper-V clocksource driver to be initialized
> > > on ARM64.
> > 
> > Previously we've said that for a clocksource we must use the architected
> > counter, since that's necessary for things like the VDSO to work
> > correctly and efficiently.
> > 
> > Given that, I'm a bit confused that we're registering a per-cpu
> > clocksource that is in part based on the architected counter. Likewise,
> > I don't entirely follow why it's necessary to PV the clock_event_device.
> > 
> > Are the architected counter and timer reliable without this PV
> > infrastructure? Why do we need to PV either of those?
> > 
> > Thanks,
> > Mark.
> 
> For the clocksource, we have a requirement to live migrate VMs
> between Hyper-V hosts running on hardware that may have different
> arch counter frequencies (it's not conformant to the ARM v8.6 1 GHz
> requirement).  The Hyper-V virtualization does scaling to handle the
> frequency difference.  And yes, there's a tradeoff with vDSO not
> working, though we have an out-of-tree vDSO implementation that
> we can use when necessary.

Just to be clear, the vDSO is *one example* of something that won't
function correctly. More generally, because this undermines core
architectural guarantees, it requires more invasive changes (e.g. we'd
have to weaken the sanity checks, and not use the counter in things like
kexec paths), impacts any architectural features tied to the generic
timer/counter (e.g. the event stream, SPE and tracing, future features),
and means that other SW (e.g. bootloaders and other EFI applications)
are unlikley to function correctly in this environment.

I am very much not keen on trying to PV this.

What does the guest see when it reads CNTFRQ_EL0? Does this match the
real HW value (and can this change over time)? Or is this entirely
synthetic?

What do the ACPI tables look like in the guest? Is there a GTDT table at
all?

How does the counter event stream behave?

Are there other architectural features which Hyper-V does not implement
for a guest?

Is there anything else that may change across a migration? e.g. MIDR?
MPIDR? Any of the ID registers?

> For clockevents, the only timer interrupt that Hyper-V provides
> in a guest VM is its virtualized "STIMER" interrupt.  There's no
> virtualization of the ARM arch timer in the guest.

I think that is rather unfortunate, given it's a core architectural
feature. Is it just the interrupt that's missing? i.e. does all the
PE-local functionality behave as the architecture requires?

Thanks,
Mark.

> 
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > ---
> > >  arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
> > >  drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> > > index c448704..b17299c 100644
> > > --- a/arch/arm64/include/asm/mshyperv.h
> > > +++ b/arch/arm64/include/asm/mshyperv.h
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/arm-smccc.h>
> > >  #include <asm/hyperv-tlfs.h>
> > > +#include <clocksource/arm_arch_timer.h>
> > >
> > >  /*
> > >   * Declare calls to get and set Hyper-V VP register values on ARM64, which
> > > @@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int reg)
> > >  	return hv_get_vpreg(reg);
> > >  }
> > >
> > > +/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. This
> > > + * value can't come from ACPI tables because it is needed before the
> > > + * Linux ACPI subsystem is initialized.
> > > + */
> > > +#define HYPERV_STIMER0_VECTOR	31
> > > +
> > > +static inline u64 hv_get_raw_timer(void)
> > > +{
> > > +	return arch_timer_read_counter();
> > > +}
> > > +
> > >  /* SMCCC hypercall parameters */
> > >  #define HV_SMCCC_FUNC_NUMBER	1
> > >  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> > > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > > index 977fd05..270ad9c 100644
> > > --- a/drivers/clocksource/hyperv_timer.c
> > > +++ b/drivers/clocksource/hyperv_timer.c
> > > @@ -569,3 +569,17 @@ void __init hv_init_clocksource(void)
> > >  	hv_setup_sched_clock(read_hv_sched_clock_msr);
> > >  }
> > >  EXPORT_SYMBOL_GPL(hv_init_clocksource);
> > > +
> > > +/* Initialize everything on ARM64 */
> > > +static int __init hyperv_timer_init(struct acpi_table_header *table)
> > > +{
> > > +	if (!hv_is_hyperv_initialized())
> > > +		return -EINVAL;
> > > +
> > > +	hv_init_clocksource();
> > > +	if (hv_stimer_alloc(true))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
> > > --
> > > 1.8.3.1
> > >
