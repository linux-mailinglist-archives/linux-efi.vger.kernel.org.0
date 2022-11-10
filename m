Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C6624478
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKJOhK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiKJOhI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 09:37:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB003CD9
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 06:37:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955301FB;
        Thu, 10 Nov 2022 06:37:12 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16C13F703;
        Thu, 10 Nov 2022 06:37:05 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:37:03 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] efi: Override runtime supported mask from a EFI variable
 if present
Message-ID: <Y20MjzkbX+yM/A0G@monolith.localdoman>
References: <20221109172750.2823891-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109172750.2823891-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Wed, Nov 09, 2022 at 06:27:50PM +0100, Ard Biesheuvel wrote:
> For debugging purposes, allow the runtime override mask to be set from a
> EFI variable if one exists. For instance, the RT supported mask can be
> set to 0xfffd to disable the SetTime() runtime service, and enable all
> others:
> 
>   echo -ne "\x7\0\0\0\xfd\xff" \
>     > /sys/firmware/efi/efivars/LinuxRtMaskOverride-eb66918a-7eef-402a-842e-931d21c38ae9

I'm really sorry, I applied this patch, but I couldn't find the file
(LinuxRtMaskOverride*) under efivars, and couldn't find another way of
setting the variable.

Thanks,
Alex

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index a46df5d1d0942751..faed1ef78c044924 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -367,7 +367,17 @@ static int __init efisubsys_init(void)
>  		}
>  	}
>  
> -	if (efi_rt_services_supported(EFI_RT_SUPPORTED_TIME_SERVICES))
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
> +		unsigned long size = sizeof(efi.runtime_supported_mask);
> +
> +		if (efi.get_variable(L"LinuxRtMaskOverride",
> +				     &EFI_RT_PROPERTIES_TABLE_GUID, NULL, &size,
> +				     &efi.runtime_supported_mask) == EFI_SUCCESS)
> +			pr_info("Overriding runtime_supported_mask to 0x%x\n",
> +				efi.runtime_supported_mask);
> +	}
> +
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_TIME))
>  		platform_device_register_simple("rtc-efi", 0, NULL, 0);
>  
>  	/* We register the efi directory at /sys/firmware/efi */
> -- 
> 2.35.1
> 
