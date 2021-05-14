Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910663809B6
	for <lists+linux-efi@lfdr.de>; Fri, 14 May 2021 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhENMi3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 May 2021 08:38:29 -0400
Received: from foss.arm.com ([217.140.110.172]:48980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhENMi2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 May 2021 08:38:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B38175D;
        Fri, 14 May 2021 05:37:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85EBF3F73B;
        Fri, 14 May 2021 05:37:14 -0700 (PDT)
Date:   Fri, 14 May 2021 13:37:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v10 3/7] arm64: hyperv: Add Hyper-V
 clocksource/clockevent support
Message-ID: <20210514123711.GB30645@C02TD0UTHF1T.local>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
 <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620841067-46606-4-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Michael,

On Wed, May 12, 2021 at 10:37:43AM -0700, Michael Kelley wrote:
> Add architecture specific definitions and functions needed
> by the architecture independent Hyper-V clocksource driver.
> Update the Hyper-V clocksource driver to be initialized
> on ARM64.

Previously we've said that for a clocksource we must use the architected
counter, since that's necessary for things like the VDSO to work
correctly and efficiently.

Given that, I'm a bit confused that we're registering a per-cpu
clocksource that is in part based on the architected counter. Likewise,
I don't entirely follow why it's necessary to PV the clock_event_device.

Are the architected counter and timer reliable without this PV
infrastructure? Why do we need to PV either of those?

Thanks,
Mark.

> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
>  drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index c448704..b17299c 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/arm-smccc.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <clocksource/arm_arch_timer.h>
>  
>  /*
>   * Declare calls to get and set Hyper-V VP register values on ARM64, which
> @@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int reg)
>  	return hv_get_vpreg(reg);
>  }
>  
> +/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. This
> + * value can't come from ACPI tables because it is needed before the
> + * Linux ACPI subsystem is initialized.
> + */
> +#define HYPERV_STIMER0_VECTOR	31
> +
> +static inline u64 hv_get_raw_timer(void)
> +{
> +	return arch_timer_read_counter();
> +}
> +
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 977fd05..270ad9c 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -569,3 +569,17 @@ void __init hv_init_clocksource(void)
>  	hv_setup_sched_clock(read_hv_sched_clock_msr);
>  }
>  EXPORT_SYMBOL_GPL(hv_init_clocksource);
> +
> +/* Initialize everything on ARM64 */
> +static int __init hyperv_timer_init(struct acpi_table_header *table)
> +{
> +	if (!hv_is_hyperv_initialized())
> +		return -EINVAL;
> +
> +	hv_init_clocksource();
> +	if (hv_stimer_alloc(true))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
> -- 
> 1.8.3.1
> 
