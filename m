Return-Path: <linux-efi+bounces-1268-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F92D91209B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169B41F24B8F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5252216E892;
	Fri, 21 Jun 2024 09:30:58 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D51422D5;
	Fri, 21 Jun 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962258; cv=none; b=W/Y1U1BcxT9VTkNj/S5AoVtGd6IQFvVLt3jsvK7bikD0b0VXSdzSl15KCubFnpnqCL10Ht8zPs0JmltQ3dHk00rdGO52rWd2SqPDiSAVrKeFiQhIvl82IEhrrjctRG7skwPCO2ei0a/5+DO0naU84f+wuaecaqP5NFYixecxWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962258; c=relaxed/simple;
	bh=knU0U978+YFGwVxRaxVg7IzrQTXS7X/L6fDq3g53y7E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlKUXlHi3VZZA+YH3SNEH+JQfGGg4XTi13Fa+YVPseCX+E9uOhLmzeAKfAkZmYYjjydzEQcFemFf1P53bKWqRuDJ049aVN4+boEya1HVnM3fhD2v78/WAmRT7pM7f6O60nBH9OoCWJh136FItqnQSY2LONSg3e8vq/e/h2SOpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5BrY6bzFz6K8wb;
	Fri, 21 Jun 2024 17:29:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66279140C72;
	Fri, 21 Jun 2024 17:30:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 10:30:51 +0100
Date: Fri, 21 Jun 2024 10:30:50 +0100
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
Subject: Re: [PATCH v4 3/3] efi/cper: align ARM CPER type with UEFI
 2.9A/2.10 specs
Message-ID: <20240621103050.00004ec0@Huawei.com>
In-Reply-To: <d808b8b76c58054ccd4a8c49dcc2d23fee5ed397.1718906288.git.mchehab+huawei@kernel.org>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<d808b8b76c58054ccd4a8c49dcc2d23fee5ed397.1718906288.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 20 Jun 2024 20:01:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Up to UEFI spec, the type byte of CPER struct for ARM processor was
> defined simply as:
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
> Spec 2.9A errata corrected it by defining:
> 
> 	- Bit 1 - Cache Error
> 	- Bit 2 - TLB Error
> 	- Bit 3 - Bus Error
> 	- Bit 4 - Micro-architectural Error
> 	All other values are reserved
> 
> That actually aligns with the values already defined on older
> versions at N.2.4.1. Generic Processor Error Section.
> 
> Spec 2.10 also preserve the same encoding as 2.9A
> 
> See: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
> 
> Adjust CPER and GHES handling code for both generic and ARM
> processors to properly handle UEFI 2.9A and 2.10 encoding.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I think you can avoid complexity of your masking solution.
Cost is we don't have that function print that there were reserved bits
set, but that could be easily handled at the caller including notifying
on bits above the defined range which might be helpful.

> diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
> index d9bbcea0adf4..4c101a09fd80 100644
> --- a/drivers/firmware/efi/cper-arm.c
> +++ b/drivers/firmware/efi/cper-arm.c
...

>  	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
> @@ -241,6 +232,7 @@ void cper_print_proc_arm(const char *pfx,
>  	struct cper_arm_err_info *err_info;
>  	struct cper_arm_ctx_info *ctx_info;
>  	char newpfx[64], infopfx[65];
> +	char error_type[120];
>  
>  	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
>  
> @@ -289,9 +281,11 @@ void cper_print_proc_arm(const char *pfx,
>  				       newpfx);
>  		}
>  
> -		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
> -			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> -			cper_proc_error_type_strs[err_info->type] : "unknown");
> +		cper_bits_to_str(error_type, sizeof(error_type), err_info->type,
> +				 cper_proc_error_type_strs,
> +				 ARRAY_SIZE(cper_proc_error_type_strs),
> +				 CPER_ARM_ERR_TYPE_MASK);

Maybe drop this mask complexity and just use
FIELD_GET() to extract the relevant field with no shift from 0.


> +		printk("%serror_type: %s\n", newpfx, error_type);
>  		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
>  			printk("%serror_info: 0x%016llx\n", newpfx,
>  			       err_info->error_info);



