Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE43DDD98
	for <lists+linux-efi@lfdr.de>; Mon,  2 Aug 2021 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhHBQ0i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Aug 2021 12:26:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhHBQ0i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Aug 2021 12:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BBE11D4;
        Mon,  2 Aug 2021 09:26:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607AB3F66F;
        Mon,  2 Aug 2021 09:26:26 -0700 (PDT)
Date:   Mon, 2 Aug 2021 17:26:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Message-ID: <20210802162623.GC59710@C02TD0UTHF1T.local>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626793023-13830-4-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 20, 2021 at 07:57:01AM -0700, Michael Kelley wrote:
> Add ARM64-specific code to initialize the Hyper-V
> hypervisor when booting as a guest VM.
> 
> This code is built only when CONFIG_HYPERV is enabled.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile   |  2 +-
>  arch/arm64/hyperv/mshyperv.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/hyperv/mshyperv.c
> 
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 1697d30..87c31c0 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y		:= hv_core.o
> +obj-y		:= hv_core.o mshyperv.o
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> new file mode 100644
> index 0000000..2811fd0
> --- /dev/null
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Core routines for interacting with Microsoft's Hyper-V hypervisor,
> + * including hypervisor initialization.
> + *
> + * Copyright (C) 2021, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +#include <linux/export.h>
> +#include <linux/errno.h>
> +#include <linux/version.h>
> +#include <linux/cpuhotplug.h>
> +#include <asm/mshyperv.h>
> +
> +static bool hyperv_initialized;
> +
> +static int __init hyperv_init(void)
> +{
> +	struct hv_get_vp_registers_output	result;
> +	u32	a, b, c, d;
> +	u64	guest_id;
> +	int	ret;

As Marc suggests, before looking at the FADT, you need something like:

	/*
	 * Hyper-V VMs always have ACPI.
	 */
	if (acpi_disabled)
		return 0;

... where `acpi_disabled` is defined in <linux/acpi.h> (or via its
includes), so you don't need to include any additional headers.

> +
> +	/*
> +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> +	 * have the string "MsHyperV".
> +	 */
> +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +		return -EINVAL;

As Marc suggests, it's no an error for a platform to not have Hyper-V,
so returning 0 in tihs case would be preferable.

Otherwise this looks fine to me.

Thanks,
Mark.

> +
> +	/* Setup the guest I[D */
> +	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
> +
> +	/* Get the features and hints from Hyper-V */
> +	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
> +	ms_hyperv.features = result.as32.a;
> +	ms_hyperv.priv_high = result.as32.b;
> +	ms_hyperv.misc_features = result.as32.c;
> +
> +	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
> +	ms_hyperv.hints = result.as32.a;
> +
> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
> +
> +	/* Get information about the Hyper-V host version */
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> +	a = result.as32.a;
> +	b = result.as32.b;
> +	c = result.as32.c;
> +	d = result.as32.d;
> +	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> +
> +	ret = hv_common_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
> +				hv_common_cpu_init, hv_common_cpu_die);
> +	if (ret < 0) {
> +		hv_common_free();
> +		return ret;
> +	}
> +
> +	hyperv_initialized = true;
> +	return 0;
> +}
> +
> +early_initcall(hyperv_init);
> +
> +bool hv_is_hyperv_initialized(void)
> +{
> +	return hyperv_initialized;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> -- 
> 1.8.3.1
> 
