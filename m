Return-Path: <linux-efi+bounces-1358-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BD91E3C3
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8942B27621
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167716CD07;
	Mon,  1 Jul 2024 15:07:16 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A916C6B7;
	Mon,  1 Jul 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846436; cv=none; b=adpPGB/S+ax0dvvFFnbPDDSWZTJKV3joPOhFrA97TgfPTt6F3+TxRe6JNWij39KnBkcb+8xjT7g7Qz+HvA1jfxI5ObEzReTdatdOUWRZ0nN6MBqoxbhKH0whFY1tMUNKv/mMZnLhqrwnDfNKyP+6z0fEyv7D3RI4Q7zl9Yxt+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846436; c=relaxed/simple;
	bh=Tk9C5QJZciDa+QpIRAZ2Jlm95KdWTV5gwV0Zmuu14CE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0VHLpA8D1hLSsidqqvZ1jCGfohk+HE67CR8GDNctuTvSWX3ivQ8W523J2HvsCuuS7uHK9EDChnY2U4WZIz0C1hsJXlQ+vFzklCQFO8IRzrnfv/cwGv6P/0KPNcvyvSffvQvxcKJxZgr0bfF1rytYHk0pxzWsZAeDHAhyIl6EOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCTs92LbNz6JBqj;
	Mon,  1 Jul 2024 23:06:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 710DF1400D1;
	Mon,  1 Jul 2024 23:07:10 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 16:07:10 +0100
Date: Mon, 1 Jul 2024 16:07:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Shiju
 Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240701160709.000064c6@Huawei.com>
In-Reply-To: <b5a425bd61f211a17a2b296a3c9ac251b3c3a20b.1719219886.git.mchehab+huawei@kernel.org>
References: <cover.1719219886.git.mchehab+huawei@kernel.org>
	<b5a425bd61f211a17a2b296a3c9ac251b3c3a20b.1719219886.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 11:19:19 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Sometimes it is desired to produce a single log line for errors.

This description is a bit cryptic.  Maybe an example would make
it easier for anyone coming across this in the future?

> Add a new helper function for such purpose.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Minor comment inline.

> ---
>  drivers/firmware/efi/cper.c | 41 +++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 7d2cdd9e2227..4cf56657afde 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -106,6 +106,47 @@ void cper_print_bits(const char *pfx, unsigned int bits,
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
> + */
> +char *cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		       const char * const strs[], unsigned int strs_size)
> +{
> +	int len = buf_size;
> +	char *str = buf;
> +	int i, size;
> +
> +	for_each_set_bit(i, &bits, strs_size) {
> +		if (!(bits & (1U << (i))))
> +			continue;
> +
> +		if (*buf && len > 0) {

That first check on *buf is a bit esoteric.
It's more than possible we get a non clear
buffer passed in.  I'd just use a
	bool first = true;
...
		if (!first && len > 0) {
			*str = '|';
			len--;
			str++;
		}
		first = false;


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

Why return buf?  You never use it and it's not entirely obvious
that is the right thing to return (as opposed to length written for example).

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


