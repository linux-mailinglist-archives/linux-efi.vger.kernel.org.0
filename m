Return-Path: <linux-efi+bounces-1429-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B59192EB98
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AB52857A0
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F0016B747;
	Thu, 11 Jul 2024 15:24:19 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DF166317;
	Thu, 11 Jul 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711459; cv=none; b=DskRsRuzYh+3pUkF8GE30t/sXOWUo8RIt/Y8Ol16yr8Wuk+5dJV5nMf/e+jXrHBbW4Kc5bvLLAWEJEVaXf8XinlTTsMC4SO+jKKENCe3SD/LUNCmosi3w4G0G4tfheBWER52Ujr7gM7/SIS/MhVBkK7LUUQNtIDk35alHTDriXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711459; c=relaxed/simple;
	bh=P6XElzflGdE/upeKRCqdTNgR6yj/DyxIK7hMeVukaBY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdTbm7dxfD5bUZeWd3XY0qlTZAcPI2tKULWO1dnkLv/qZfV758zfC66ZzqyEraWEPBhMkpgwmM1HWu8mRv/qQV/qxuEgVNVuvvqgb25NzI1/V3ZXzK5SqsHRTHLGKXClVySZZftysBNjh6vjDZ8WIXH02/lEtz+DBOH9qGFv+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKdlf53MJz67KPG;
	Thu, 11 Jul 2024 23:23:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 57F301400C9;
	Thu, 11 Jul 2024 23:24:12 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 16:24:11 +0100
Date: Thu, 11 Jul 2024 16:24:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, James Morse <james.morse@arm.com>, "Len Brown"
	<lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Shiju Jose"
	<shiju.jose@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240711162411.00007e5e@Huawei.com>
In-Reply-To: <5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
	<5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 08:28:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Sometimes it is desired to produce a single log line for errors.
> Add a new helper function for such purpose.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
LGTM

Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/firmware/efi/cper.c | 43 +++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  2 ++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 7d2cdd9e2227..462d739e8dd1 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -106,6 +106,49 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>  		printk("%s\n", buf);
>  }
>  
> +/**
> + * cper_bits_to_str - return a string for set bits
> + * @buf: buffer to store the output string
> + * @buf_size: size of the output string buffer
> + * @bits: bit mask
> + * @strs: string array, indexed by bit position
> + * @strs_size: size of the string array: @strs
> + *
> + * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
> + * add the corresponding string describing the bit in @strs to @buf.
> + *
> + * Return: number of bytes stored or an error code if lower than zero.
> + */
> +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		     const char * const strs[], unsigned int strs_size)
> +{
> +	int len = buf_size;
> +	char *str = buf;
> +	int i, size;
> +
> +	*buf = '\0';
> +
> +	for_each_set_bit(i, &bits, strs_size) {
> +		if (!(bits & (1U << (i))))
> +			continue;
> +
> +		if (*buf && len > 0) {
> +			*str = '|';
> +			len--;
> +			str++;
> +		}
> +
> +		size = strscpy(str, strs[i], len);
> +		if (size < 0)
> +			return size;
> +
> +		len -= size;
> +		str += size;
> +	}
> +	return len - buf_size;
> +}
> +EXPORT_SYMBOL_GPL(cper_bits_to_str);
> +
>  static const char * const proc_type_strs[] = {
>  	"IA32/X64",
>  	"IA64",
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 265b0f8fc0b3..25858a7608b7 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -584,6 +584,8 @@ const char *cper_mem_err_type_str(unsigned int);
>  const char *cper_mem_err_status_str(u64 status);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>  		     const char * const strs[], unsigned int strs_size);
> +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		     const char * const strs[], unsigned int strs_size);
>  void cper_mem_err_pack(const struct cper_sec_mem_err *,
>  		       struct cper_mem_err_compact *);
>  const char *cper_mem_err_unpack(struct trace_seq *,


