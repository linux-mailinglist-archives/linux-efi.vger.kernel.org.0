Return-Path: <linux-efi+bounces-5826-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74823CAEBF5
	for <lists+linux-efi@lfdr.de>; Tue, 09 Dec 2025 03:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84121302D298
	for <lists+linux-efi@lfdr.de>; Tue,  9 Dec 2025 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06730101A;
	Tue,  9 Dec 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a5KvW3WU"
X-Original-To: linux-efi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A51221D9E;
	Tue,  9 Dec 2025 02:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765248158; cv=none; b=c4Z+7pxlVb3XKdW4L5nao7WKGzA0/wEZQEge9wEBxy1Nfp5niMNYbvFWDqt1a8BCoBe7qNpbYvr6QIGzlBs56RFg2Ojet5UeMeaU54pylNngwsaM47lGGcV60Y+nlYfRgDeGxCyNddTfBKiz7/w2HVGP/D3ZwAvbNJGfPPvcHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765248158; c=relaxed/simple;
	bh=sE/pXyvd0Lfywd91kpXrjPl90i9VcZIcgejCyno71SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru6g7tBBBT6JZkVll/t7PKeMnAA9RSZcaKO+pyE6nV/2kteHp/AcUlss9rWfzv3xQptNjH3jCrnahOJR6gtexW5VUFj7ShwbvrfThIK35uOc9fsV7/EYB2FOvqTN6lkIg0m1JOn8zsCM8BGct6Lpr9o1vQgE/3xPn6FyifIWX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a5KvW3WU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765248146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XuMro7XedIbxeUje5xYrBFUsW7QJmGKlAI8KpxyrRWs=;
	b=a5KvW3WU7SAUQ2bf7jKmZu4ZZXC4A/TAYsaqVtJc81ZuCAxZ2xKtNpWuCfSCd5pHLwHPfG2v4R6EzBVc6gjduKc1bs0AIUTbICOYHoOgpOnIPopxHbbElSyrFg0SDB80z8bpsV/WGRbpKGTVD8Q3tkpFrQNj1i6OCEUC9Y+/a8g=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuQmmVh_1765248142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Dec 2025 10:42:23 +0800
Message-ID: <b2d9284b-10fb-4ec9-921e-c73b0f79f01f@linux.alibaba.com>
Date: Tue, 9 Dec 2025 10:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] apei/ghes: don't go past the ARM processor CPER
 record buffer
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Dave Jiang <dave.jiang@intel.com>,
 Fan Ni <fan.ni@samsung.com>, Hanjun Guo <guohanjun@huawei.com>,
 Huang Yiwei <quic_hyiwei@quicinc.com>, Ira Weiny <ira.weiny@intel.com>,
 Jason Tian <jason@os.amperecomputing.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1764326826.git.mchehab+huawei@kernel.org>
 <0f03f383fa76e41747b95713d50350be21867ccb.1764326826.git.mchehab+huawei@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <0f03f383fa76e41747b95713d50350be21867ccb.1764326826.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/28 18:53, Mauro Carvalho Chehab 写道:
> There's a logic inside ghes/cper to detect if the section_length
> is too small, but it doesn't detect if it is too big.
> 
> Currently, if the firmware receives an ARM processor CPER record
> stating that a section length is big, kernel will blindly trust
> section_lentgh, producing a very long dump. For instance, a 67
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
>   drivers/acpi/apei/ghes.c        | 13 +++++++++++++
>   drivers/firmware/efi/cper-arm.c | 14 +++++++++-----
>   drivers/firmware/efi/cper.c     |  3 ++-
>   include/linux/cper.h            |  3 ++-
>   4 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 56107aa00274..8b90b6f3e866 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -557,6 +557,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>   {
>   	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>   	int flags = sync ? MF_ACTION_REQUIRED : 0;
> +	int length = gdata->error_data_length;
>   	char error_type[120];
>   	bool queued = false;
>   	int sec_sev, i;
> @@ -568,7 +569,12 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>   		return false;
>   
>   	p = (char *)(err + 1);
> +	length -= sizeof(err);
> +
>   	for (i = 0; i < err->err_info_num; i++) {
> +		if (length <= 0)
> +			break;
> +

Hi, Mauro,

The bounds checking logic is duplicated - it appears both in the cache
error handling branch and after it. This could be simplified. It would
be better to ensure we have enough data for the error info header in one
check.

		/* Ensure we have enough data for the error info header */
		if (length < sizeof(struct cper_arm_err_info))
			break;

And it would be better to validate the claimed length before using it.

		/* Validate the claimed length before using it */
		if (err_info->length < sizeof(struct cper_arm_err_info) ||
		    err_info->length > length)
			break;

Thanks.
Shuai

