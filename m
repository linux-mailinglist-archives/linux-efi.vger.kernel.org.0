Return-Path: <linux-efi+bounces-5915-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA9CD5D3E
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 12:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A765830281BA
	for <lists+linux-efi@lfdr.de>; Mon, 22 Dec 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12931A564;
	Mon, 22 Dec 2025 11:38:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B130E839;
	Mon, 22 Dec 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403539; cv=none; b=GAb9MYGBWhW8Tgt5DWzd2VEr+rJDJgC+eR99C2SS3nI7aA/P8Pp1+65sHacTkGjqvhlHsdf8Czr+I40qf49W/8M5/70XNRwFT1pF+Z+lBrOQ878l+/5YOwIlsKwGWHgZVpB/xX/IgofarOUJZnvUvDsK815o+lM8MI87qHhWHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403539; c=relaxed/simple;
	bh=+p/H8YqORJwfhJyHmXE2poLGOl51QeKmPyQnfIMj+u4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FP9JaosmNba+D6eTq+OFgU6KmzkQgR1B2kGW81HiXCbt9EV0ml8srh5S38YCXC8Zp+cr5j/X/BbroG2PdPnD8mU8EcFcYWxXda4M5en4Jsxxqld1YCC1uXBK8ALuprdT1k+6LtLwlT47dAvFkMfaV1A+Z8nxo59CKH3gy380eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dZbk25fNQzHnGkR;
	Mon, 22 Dec 2025 19:38:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B5AEA40539;
	Mon, 22 Dec 2025 19:38:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 11:38:52 +0000
Date: Mon, 22 Dec 2025 11:38:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ankit Agrawal
	<ankita@nvidia.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao
	<leitao@debian.org>, Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar
	<mingo@kernel.org>, Jason Tian <jason@os.amperecomputing.com>, "Len Brown"
	<lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
	<linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] apei/ghes: ARM processor Error: don't go past
 allocated memory
Message-ID: <20251222113851.000048f6@huawei.com>
In-Reply-To: <e80bc4eba43d0211713fe66958ec0c582d9bfda7.1766140788.git.mchehab+huawei@kernel.org>
References: <cover.1766140788.git.mchehab+huawei@kernel.org>
	<e80bc4eba43d0211713fe66958ec0c582d9bfda7.1766140788.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 11:49:59 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> If the BIOS generates a very small ARM Processor Error, or
> an incomplete one, the current logic will fail to deferrence
> 
> 	err->section_length
> and
> 	ctx_info->size
> 
> Add checks to avoid that. With such changes, such GHESv2
> records won't cause OOPSes like this:
> 
> [    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    1.495449] Modules linked in:
> [    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
> [    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> [    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
> [    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    1.497199] pc : log_arm_hw_error+0x5c/0x200
> [    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220
> 
> 0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
> 70		err_info = (struct cper_arm_err_info *)(err + 1);
> 71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> 72		ctx_err = (u8 *)ctx_info;
> 73
> 74		for (n = 0; n < err->context_info_num; n++) {
> 75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> 76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> 77			ctx_len += sz;
> 78		}
> 79
> 
> and similar ones while trying to access section_length on an
> error dump with too small size.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Hi Mauro,

This is fiddly stuff to read in the spec but I think you have a double
counting of the "ARM Processors Error Information Structure" size as
the length in that this time is the length of the structure itself,
not a following body.

Jonathan


> ---
>  drivers/acpi/apei/ghes.c | 33 +++++++++++++++++++++++++++++----
>  drivers/ras/ras.c        |  6 +++++-
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..9bf4ec84f160 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -552,21 +552,46 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  {
>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  	int flags = sync ? MF_ACTION_REQUIRED : 0;
> +	int length = gdata->error_data_length;
>  	char error_type[120];
>  	bool queued = false;
>  	int sec_sev, i;
>  	char *p;
>  
>  	sec_sev = ghes_severity(gdata->error_severity);
> -	log_arm_hw_error(err, sec_sev);
> +	if (length >= sizeof(*err)) {
> +		log_arm_hw_error(err, sec_sev);
> +	} else {
> +		pr_warn(FW_BUG "arm error length: %d\n", length);
> +		pr_warn(FW_BUG "length is too small\n");
> +		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> +		return false;
> +	}
> +
>  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>  		return false;
>  
>  	p = (char *)(err + 1);
> +	length -= sizeof(err);
Hacks off the bit of the section that is fixed size.
> +
>  	for (i = 0; i < err->err_info_num; i++) {
> -		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
> -		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> -		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> +		struct cper_arm_err_info *err_info;
> +		bool is_cache, has_pa;
> +
> +		/* Ensure we have enough data for the error info header */
> +		length -= sizeof(*err_info);
hacks of length of one processor error information structure (fixed 32 bytes)

> +		if (length < 0)
> +			break;
> +
> +		err_info = (struct cper_arm_err_info *)p;
> +
> +		/* Validate the claimed length before using it */
> +		length -= err_info->length;

This one confuses me.  err_info->length is the same 32 bytes you removed above.

So I think this check is wrong.

 
> +		if (length < 0)
> +			break;
> +
> +		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
> +		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
>  
>  		/*
>  		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 2a5b5a9fdcb3..03df3db62334 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -72,7 +72,11 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  	ctx_err = (u8 *)ctx_info;
>  
>  	for (n = 0; n < err->context_info_num; n++) {
> -		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> +		sz = sizeof(struct cper_arm_ctx_info);
> +
> +		if (sz + (long)ctx_info - (long)err >= err->section_length)
> +			sz += ctx_info->size;
> +
>  		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
>  		ctx_len += sz;
>  	}


