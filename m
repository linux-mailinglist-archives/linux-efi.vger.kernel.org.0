Return-Path: <linux-efi+bounces-5819-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A45CADB1F
	for <lists+linux-efi@lfdr.de>; Mon, 08 Dec 2025 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB30630C159F
	for <lists+linux-efi@lfdr.de>; Mon,  8 Dec 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854031196A;
	Mon,  8 Dec 2025 15:55:33 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15A30FC30;
	Mon,  8 Dec 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209333; cv=none; b=SK3qcgKrvPiat75zaghICw4Wmq3RCuJXjYgKirfAhmGR2OAJSEvs+af2cLvxMbhH0QtRpB0gz/VIw0o9/w9vta6nBFejUiGA9V27rxRktXm3RC396yBwkh3VKdAsNbJgTKULmKXHfcPxKZ4mB87JxvQNlECFm1i98TMZmhkb1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209333; c=relaxed/simple;
	bh=RYT1iy3FBB6uZoZKycGu/YHF0Dzox5/SlFNTtF6/wMw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsrxDv/RCnoIXes4+4YXXL9TG0FHzWlvXR1/pU3RXfQJgEmzFtrWXIfPJGIwj0uCwq5wHvrGcDHKliyrgVybc6NizEwMSScP+isV8N+B/OJJyjQ/UAjq0OJMEwvdxYDzcSbD6G4f2RYLTSnRB/Kczg0I5ozRDOVuJZz4J30HI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ64t1wCRzJ46XJ;
	Mon,  8 Dec 2025 23:55:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E5224056E;
	Mon,  8 Dec 2025 23:55:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 15:55:24 +0000
Date: Mon, 8 Dec 2025 15:55:22 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Hanjun Guo
	<guohanjun@huawei.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, Ira Weiny
	<ira.weiny@intel.com>, Jason Tian <jason@os.amperecomputing.com>, Len Brown
	<lenb@kernel.org>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] apei/ghes: don't go past the ARM processor CPER
 record buffer
Message-ID: <20251208155522.0000162e@huawei.com>
In-Reply-To: <0f03f383fa76e41747b95713d50350be21867ccb.1764326826.git.mchehab+huawei@kernel.org>
References: <cover.1764326826.git.mchehab+huawei@kernel.org>
	<0f03f383fa76e41747b95713d50350be21867ccb.1764326826.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 28 Nov 2025 11:53:00 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There's a logic inside ghes/cper to detect if the section_length
> is too small, but it doesn't detect if it is too big.
> 
> Currently, if the firmware receives an ARM processor CPER record
> stating that a section length is big, kernel will blindly trust
> section_lentgh, producing a very long dump. For instance, a 67

section_length

> bytes record with ERR_INFO_NUM set 46198 and section length
> set to 854918320 would dump a lot of data going a way past the
> firmware memory-mapped area.
> 
> Fix it by adding a logic to prevent it to go past the buffer
> if ERR_INFO_NUM is too big, making it report instead:
> 
> 	[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> 	[Hardware Error]: event severity: recoverable
> 	[Hardware Error]:  Error 0, type: recoverable
> 	[Hardware Error]:   section_type: ARM processor error
> 	[Hardware Error]:   MIDR: 0xff304b2f8476870a
> 	[Hardware Error]:   section length: 854918320, CPER size: 67
> 	[Hardware Error]:   section length is too big
> 	[Hardware Error]:   firmware-generated error record is incorrect
> 	[Hardware Error]:   ERR_INFO_NUM is 46198
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/acpi/apei/ghes.c        | 13 +++++++++++++
>  drivers/firmware/efi/cper-arm.c | 14 +++++++++-----
>  drivers/firmware/efi/cper.c     |  3 ++-
>  include/linux/cper.h            |  3 ++-
>  4 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 56107aa00274..8b90b6f3e866 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -557,6 +557,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  {
>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  	int flags = sync ? MF_ACTION_REQUIRED : 0;
> +	int length = gdata->error_data_length;
>  	char error_type[120];
>  	bool queued = false;
>  	int sec_sev, i;
> @@ -568,7 +569,12 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  		return false;
>  
>  	p = (char *)(err + 1);
> +	length -= sizeof(err);
> +
>  	for (i = 0; i < err->err_info_num; i++) {
> +		if (length <= 0)
> +			break;
> +
>  		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
>  		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
>  		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> @@ -580,10 +586,17 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  		 * and don't filter out 'corrected' error here.
>  		 */
>  		if (is_cache && has_pa) {
> +			length -= err_info->length;
> +			if (length < 0)
> +				break;
>  			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
>  			p += err_info->length;
> +
>  			continue;
>  		}
> +		length -= err_info->length;
> +			if (length < 0)
Indent odd.

> +				break;
>  
>  		cper_bits_to_str(error_type, sizeof(error_type),
>  				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),



