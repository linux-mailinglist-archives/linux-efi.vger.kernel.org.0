Return-Path: <linux-efi+bounces-1383-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8CD92A606
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CEDB219D9
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A961420DD;
	Mon,  8 Jul 2024 15:45:59 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF58138C;
	Mon,  8 Jul 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453559; cv=none; b=JddUs/92zmCtVU0zWlw9No2QQoR1r7WUf7za+zlb+J3rvClVK+mEg0wfyZRFr5xeU4ghegkimLYKEuevk25ODhyNSOkcvX9d4iPaGepEUBbbd+Q8+g5TOKkcrhOIuSP67osQC7AXfD7hLW5PbbH068c6KF66XUch1HVc46tcaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453559; c=relaxed/simple;
	bh=odn6TqpWNsViQNhESbSqPcNxWV/85LEpeh+3989YoO0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGJVKhQGipm0/1W+tOR0f9MKokqSg9hSbaSL4XJmxCR5m0kd0SfL3xOeiiGpQrCXpg7FW1L5qJidxr0BrzFWhhNb+lph3xtluPGK5HNm7sPagqLuO4i779WxPxAsyDSk0P4CFCVeoV2mW2i1POm2lgVbM+tUq2NCcR9AWlmzjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpNC6vz7z6JBcJ;
	Mon,  8 Jul 2024 23:44:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1943C1400F4;
	Mon,  8 Jul 2024 23:45:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 16:45:52 +0100
Date: Mon, 8 Jul 2024 16:45:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, James Morse <james.morse@arm.com>, "Len Brown"
	<lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Shiju Jose"
	<shiju.jose@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240708164551.0000395c@Huawei.com>
In-Reply-To: <b6bb6f96420975e91a5660ede6dc20e351c33286.1720436039.git.mchehab+huawei@kernel.org>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
	<b6bb6f96420975e91a5660ede6dc20e351c33286.1720436039.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  8 Jul 2024 13:18:13 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Sometimes it is desired to produce a single log line for errors.
> Add a new helper function for such purpose.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/firmware/efi/cper.c | 43 +++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  2 ++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 7d2cdd9e2227..f8c8a15cd527 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -106,6 +106,49 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>  		printk("%s\n", buf);
>  }
>  
> +/*
> + * cper_bits_to_str - return a string for set bits
> + * @buf: buffer to store the output string
> + * @buf_size: size of the output string buffer
> + * @bits: bit mask
> + * @strs: string array, indexed by bit position
> + * @strs_size: size of the string array: @strs
> + * @mask: a continuous bitmask used to detect the first valid bit of the
> + *        bitmap.
> + *
> + * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits
> + * mask, add the corresponding string describing the bit in @strs to @buf.

Good to document what the return value is.

Also, I note some fixes for this doc are in patch 6 that should be here.

I wonder if better to return number of bytes filled?
Currently the return value isn't used, but that feels potentially more
useful than returning the buffer and someone having to run strlen()
on it if they want to append something afterwards.

Also allows detection of out of space condition.


> + */
> +char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		       const char * const strs[], unsigned int strs_size)
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

How would that happen? We are only entering the loop
if that condition is true.

> +
> +		if (*buf && len > 0) {
> +			*str = '|';
> +			len--;
> +			str++;
> +		}
> +
> +		size = strscpy(str, strs[i], len);
> +		if (size < 0)
> +			break;
> +
> +		len -= size;
> +		str += size;
> +	}
> +	return buf;
> +}
> +EXPORT_SYMBOL_GPL(cper_bits_to_str);
> +
>  static const char * const proc_type_strs[] = {
>  	"IA32/X64",
>  	"IA64",
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 265b0f8fc0b3..c2f14b916bfb 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -584,6 +584,8 @@ const char *cper_mem_err_type_str(unsigned int);
>  const char *cper_mem_err_status_str(u64 status);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>  		     const char * const strs[], unsigned int strs_size);
> +char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		       const char * const strs[], unsigned int strs_size);
>  void cper_mem_err_pack(const struct cper_sec_mem_err *,
>  		       struct cper_mem_err_compact *);
>  const char *cper_mem_err_unpack(struct trace_seq *,


