Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0268D3E0589
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhHDQM7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhHDQK6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 12:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECB0560F35;
        Wed,  4 Aug 2021 16:10:43 +0000 (UTC)
Date:   Wed, 4 Aug 2021 17:10:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v12 5/5] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Message-ID: <20210804161040.GC4857@arm.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <1628092359-61351-6-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628092359-61351-6-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 08:52:39AM -0700, Michael Kelley wrote:
> Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> ARM64, causing the Hyper-V specific code to be built. Exclude the
> Hyper-V enlightened clocks/timers code from being built for ARM64.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> ---
>  drivers/hv/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d..e509d5d 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
>  
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> +	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +		|| (ARM64 && !CPU_BIG_ENDIAN))
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR

Does this need to be:

	select X86_HV_CALLBACK_VECTOR if X86

I haven't checked whether it gives a warning on arm64 but that symbol
doesn't exist.

Anyway, I can fix it up locally.

As an additional patch (it can be done later, once this goes upstream) I
think we should replace the depends on with a single ARCH_HAS_HYPERV.

-- 
Catalin
