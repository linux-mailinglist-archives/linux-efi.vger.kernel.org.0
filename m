Return-Path: <linux-efi+bounces-1246-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB88290EEBC
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2024 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29521C245C7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374621422B8;
	Wed, 19 Jun 2024 13:31:36 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2D81E526;
	Wed, 19 Jun 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803896; cv=none; b=bpl2KqsRoz6ahcGKhi9A0zuthJmYj+49vCJFDYiOaIx8zxhJ1mcxTqHixtmm9/j+5Y3d3Q7yhOnlyvzJpPfSOexy1KfO9IMj8MIY1PmgFpYIMuhoVCOSi1OevUvlc2y3jUHq8NWNKjbQKiNJep+92ObsYctg2XFPQEmdqC7gJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803896; c=relaxed/simple;
	bh=+QbUwWCPAn++iu2c2Vl3hSYdSoxIO8Gi/j1gFVZds8c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxDCCxFMmMDdiKqHH3a+GNdT64DrvufiYi7i/YHDdqpZuqzH66k3YcsHxMvPIfVvKaw9BO1kJwx9jKEXj+uQ50L1/tTEpk/lNFxTUGWxGYOn3dCmO51Hh0nR1Er1Zhpq8K1RU2/h6rpqaD44Uisf4AltulZy+J51mBXCLlppx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W44JS2p9Qz6K6FZ;
	Wed, 19 Jun 2024 21:31:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 943051406AE;
	Wed, 19 Jun 2024 21:31:24 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Jun
 2024 14:31:20 +0100
Date: Wed, 19 Jun 2024 14:31:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Tony
 Luck <tony.luck@intel.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, "Alison Schofield"
	<alison.schofield@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Len Brown <lenb@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Message-ID: <20240619143117.00000c9c@Huawei.com>
In-Reply-To: <60da74c80a0b05ea4a5b4b7f2eda1b58d555edce.1718794335.git.mchehab+huawei@kernel.org>
References: <60da74c80a0b05ea4a5b4b7f2eda1b58d555edce.1718794335.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 19 Jun 2024 12:52:38 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Up to UEFI spec, the type byte of CPER struct was defined simply
> as:
> 
> Type at byte offset 4:
> 
> 	- Cache error
> 	- TLB Error
> 	- Bus Error
> 	- Micro-architectural Error
> 	All other values are reserved
> 
> Yet, there was no information about how this would be encoded.
> 
> Spec 2.9A corrected it by defining:
> 
> 	- Bit 1 - Cache Error
> 	- Bit 2 - TLB Error
> 	- Bit 3 - Bus Error
> 	- Bit 4 - Micro-architectural Error
> 	All other values are reserved
> 
> Spec 2.10 also preserve the same encoding as 2.9A
> 
> See: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
> 
> Adjust CPER handling code for ARM to properly handle UEFI 2.9A and
> 2.10 encoding.

Hi Mauro,

I'd be tempted to use "ARM Processor" throughout this patch description
as could in theory be something else and currently the link
is the only way to tell!

A few comments inline.

Good catch on the spec change btw.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/acpi/apei/ghes.c        | 19 +++++++++++---
>  drivers/firmware/efi/cper-arm.c | 44 ++++++++++++++-------------------
>  include/linux/cper.h            |  9 +++----
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ed32bbecb4a3..365de4115508 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -546,9 +546,12 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  	p = (char *)(err + 1);
>  	for (i = 0; i < err->err_info_num; i++) {
>  		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
> -		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
> +		bool is_cache = (err_info->type & CPER_ARM_CACHE_ERROR);

Matches local style I guess but the () are unnecessary.

>  		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> -		const char *error_type = "unknown error";
> +		char error_type[120] = "";

> +		char *s = error_type;
> +		int len = 0;
> +		int i;

Shadowing i which is bad for readability.

>  
>  		/*
>  		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> @@ -562,8 +565,16 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  			continue;
>  		}
>  
> -		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
> -			error_type = cper_proc_error_type_strs[err_info->type];
> +		for (i = 0; i < ARRAY_SIZE(cper_proc_error_type_strs); i++) {
> +			if (!(err_info->type & (1U << i)))
> +				continue;
> +
> +			len += snprintf(s, sizeof(err_info->type) - len, "%s ", cper_proc_error_type_strs[i]);

Size of the index into the type string array?  I'm confused.
sizeof(error_type) maybe?

Also, maybe break that long line of code before cper_*


> +			s += len;
> +		}
> +
> +		if (!*error_type)
> +			strscpy(error_type, "unknown error", sizeof(error_type));

Perhaps should handle multiple bits where only one is unknown?
So maybe compare with a mask of known bits and print this on the end (perhaps
including which bit)?

>  
>  		pr_warn_ratelimited(FW_WARN GHES_PFX
>  				    "Unhandled processor error type: %s\n",
> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> index fa9c1c3bf168..f57641eb548a 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
> @@ -93,15 +93,11 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
>  	bool proc_context_corrupt, corrected, precise_pc, restartable_pc;
>  	bool time_out, access_mode;
>  
> -	/* If the type is unknown, bail. */
> -	if (type > CPER_ARM_MAX_TYPE)
> -		return;
> -
>  	/*
>  	 * Vendor type errors have error information values that are vendor
>  	 * specific.
>  	 */
> -	if (type == CPER_ARM_VENDOR_ERROR)
> +	if (type & CPER_ARM_VENDOR_ERROR)
>  		return;
>  
>  	if (error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) {
> @@ -116,43 +112,38 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
>  	if (error_info & CPER_ARM_ERR_VALID_OPERATION_TYPE) {
>  		op_type = ((error_info >> CPER_ARM_ERR_OPERATION_SHIFT)
>  			   & CPER_ARM_ERR_OPERATION_MASK);
> -		switch (type) {
> -		case CPER_ARM_CACHE_ERROR:
> +		if (type & CPER_ARM_CACHE_ERROR) {
>  			if (op_type < ARRAY_SIZE(arm_cache_err_op_strs)) {
> -				printk("%soperation type: %s\n", pfx,
> +				printk("%scache error: %s\n", pfx,
>  				       arm_cache_err_op_strs[op_type]);
Can we keep that this is an operation type in print?
"%scache error, operation type: %s\n" perhaps?

>  			}
> -			break;
> -		case CPER_ARM_TLB_ERROR:
> +		}
> +		if (type & CPER_ARM_TLB_ERROR) {
>  			if (op_type < ARRAY_SIZE(arm_tlb_err_op_strs)) {
> -				printk("%soperation type: %s\n", pfx,
> +				printk("%sTLB error: %s\n", pfx,
>  				       arm_tlb_err_op_strs[op_type]);
>  			}
> -			break;
> -		case CPER_ARM_BUS_ERROR:
> +		}
> +		if (type & CPER_ARM_BUS_ERROR) {
>  			if (op_type < ARRAY_SIZE(arm_bus_err_op_strs)) {
> -				printk("%soperation type: %s\n", pfx,
> +				printk("%sbus error: %s\n", pfx,
>  				       arm_bus_err_op_strs[op_type]);
>  			}
> -			break;
>  		}
>  	}
>  
>  	if (error_info & CPER_ARM_ERR_VALID_LEVEL) {
>  		level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
>  			 & CPER_ARM_ERR_LEVEL_MASK);

Not a today thing, but would be lovely to use FIELD_GET()
for all these with appropriately fixed up mask definitions.
Right now it is inconsistent as the valid entries are handled
as shifted values, and we have GENMASK(X,0) plus a shift for these.

> -		switch (type) {
> -		case CPER_ARM_CACHE_ERROR:
> +		if (type & CPER_ARM_CACHE_ERROR)
>  			printk("%scache level: %d\n", pfx, level);
> -			break;
> -		case CPER_ARM_TLB_ERROR:
> +
> +		if (type & CPER_ARM_TLB_ERROR)
>  			printk("%sTLB level: %d\n", pfx, level);
> -			break;
> -		case CPER_ARM_BUS_ERROR:
> +
> +		if (type & CPER_ARM_BUS_ERROR)
>  			printk("%saffinity level at which the bus error occurred: %d\n",
>  			       pfx, level);
> -			break;
> -		}
>  	}



