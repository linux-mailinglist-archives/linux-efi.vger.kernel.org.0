Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711653D11BC
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGUOQx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhGUOQw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 10:16:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BFC061575;
        Wed, 21 Jul 2021 07:57:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id w22so2673264ioc.6;
        Wed, 21 Jul 2021 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGL6cWHq51FiScDcSYkGH4avVX70JRryTBj7/1xvqK8=;
        b=uT8XJIRgV+DNJ/YDqVYb3KW8HuNPZLRIZSOIkvOXgqkfOcmS/KKauTDTCrIwWfyTCD
         4IZvkPz5VSdnKkI+y/2Xc/YzPl8L1VIW/YHcIDJTm6DLkeYwKfRK4lACR4NSSVZVFqJv
         f5K6mvZR5lPLVRfz5m1smOU10KySORlwNKMuv0ZJMz1dJwfxf7or6iBa3YIBGejpOdEC
         1WYEtU0NOZzs7toh9CksYQC2bjPR6d08yZKyZ7wUTXHUAZmAbwSXmi0wjbyhFBCttiu+
         mMuqzoymX3Utz0NtUYhxSbEyfL6N5n4LXkspNKN3gQib+Dk5PIA81HulmBFKdNB/Rwz0
         YzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGL6cWHq51FiScDcSYkGH4avVX70JRryTBj7/1xvqK8=;
        b=BHLXt+b/q/GHEwlZj3YMk/dIe0ALDrZfRpK7aFlk4UBc4N31Yu40JfF1OeokmUv6GK
         vWEEqT7rr5RUwie6Jil/usQvurHkMbLB1R4yApu3VHuziuGKUY0rfHCT+j1ryFb1jx5k
         1+Zb2UaFTOxxd93k3Nvfsn/hwcyTm/05HGo8Fmc6lK9GkusefGANWw8fZwxXWlhynoam
         IjBgu9+OEMPUhdLTzBddyXoRbkRsiOTdxg2b/vl3KrSzxFo2buTQz/or23GLBgS1jZuj
         9eIPvYCRtisvOC5NmVEkSsfPLcH9F0sR3EGwQQiPNDNDB6yeXWVWo0X5JYDqXO0ikbG+
         YJbw==
X-Gm-Message-State: AOAM532Le33zk0GPxpGiUnfg0WrG8Z0Fag/daDwvW6P5i6um+suwWgkT
        uQ5ar44Y0F55S55C61ZRH94=
X-Google-Smtp-Source: ABdhPJy3iI5z2jZU+R+IUwQ8MXX2Yyh9aWjVqFg5fH7Quv+42AunDfSCRX2JeXxk2M57Ggbtyme3Pw==
X-Received: by 2002:a05:6638:418f:: with SMTP id az15mr29944456jab.8.1626879447157;
        Wed, 21 Jul 2021 07:57:27 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y14sm9827269ilq.6.2021.07.21.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:57:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AD71227C005A;
        Wed, 21 Jul 2021 10:57:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Jul 2021 10:57:25 -0400
X-ME-Sender: <xms:1TX4YEs069eCIso98qQXysmsLOabfj6ybw585ji8DPE-ne_oN-9vuQ>
    <xme:1TX4YBfCOse49wpTkGlRD-4awL-vyD4FRMxYOMy2lFU26SdLBQHMq8Cw7ohmyZ9JL
    HjhOcZFaA17K7hwfg>
X-ME-Received: <xmr:1TX4YPyl-XScsXzU05Rf0BAnbdG0yE8QX6immxFf3_Old2WlzoGMhSmXeds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedugfegjeduieekfeettddufeehfeefgffhtefflefgtdefkedtjefhgfdvleek
    ieenucffohhmrghinheprghsfedvrdgsmhhspdgrshefvddrtggunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1TX4YHOAn-pde021cwPOPHVU5raeECssw3gdDS07wNQqVahgstz3Mw>
    <xmx:1TX4YE_HmJOQUgk_jMkzFeu15Yh94fbPtUWUG_VtvHsW36HnbREKcg>
    <xmx:1TX4YPVy2NrP-vtb203qKn62MTg0fEkYy9Y05WNYDUHwUG81CkB7gA>
    <xmx:1TX4YPUsdXcmQ0HB0bZMPagOT5r0VKq3XU_YSt8ciN3FHnc1uOPNTLFU1Cs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:57:25 -0400 (EDT)
Date:   Wed, 21 Jul 2021 22:55:26 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v11 3/5] arm64: hyperv: Initialize hypervisor on boot
Message-ID: <YPg1XpdHt5kNSEJX@boqun-archlinux>
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

FWIW,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

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
> +
> +	/*
> +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> +	 * have the string "MsHyperV".
> +	 */
> +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +		return -EINVAL;
> +
> +	/* Setup the guest ID */
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
