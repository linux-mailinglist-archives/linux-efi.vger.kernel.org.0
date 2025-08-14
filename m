Return-Path: <linux-efi+bounces-4552-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100EB26C5B
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAAB16C981
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08502264D6;
	Thu, 14 Aug 2025 16:13:48 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293E17D346;
	Thu, 14 Aug 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188028; cv=none; b=ZJ2bBpm7c7Ur6QAB5iuLZeYoQbGC5t4tknjy3BIXC+VarT1WbUObO1ZjzK9M9DT/rX/PesjJ8fRXTcc01G+1+LwwulIMDBsTcJ3j54+5WPqJ6RounGbG38A5V0VcdA2dfBFUYWwLk8raFpTXcQQsQLNNRm8lJrgcC+N54UD+/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188028; c=relaxed/simple;
	bh=FipTccn1zY0e8KcfPWQwq9vsqe8F2fCuI41sg9kkj1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPlxlkevLqZ1/+LZYxhhFH5NossuidxsI9mcnMunnnozZtw5c/3DZw7eNyQjlxth4T6xQ2cU6O3qTiieZqIe3CtRT9VH3hW6w6/5muofJ1VRWsZXMJFHdnVxe6oL6pYfFxb7bqP7eJ8TZZpKWdd620uSjSoQv6zQdASIzxPfaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c2qwX2xNYz6L5PD;
	Fri, 15 Aug 2025 00:10:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE4E714010C;
	Fri, 15 Aug 2025 00:13:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 14 Aug
 2025 18:13:35 +0200
Date: Thu, 14 Aug 2025 17:13:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "James
 Morse" <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-edac@vger.kernel.org>, "Mauro Carvalho
 Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v5 3/5] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20250814171334.00002f29@huawei.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-3-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
	<20250813-mauro_v3-v6-16-rev2-v5-3-954db8ccfbe6@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Aug 2025 14:19:16 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> wrote:

> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Add a helper function to print a string with names associated
> to each bit field.
> 
> A typical example is:
> 
> 	const char * const bits[] = {
> 		"bit 3 name",
> 		"bit 4 name",
> 		"bit 5 name",
> 	};
> 	char str[120];
>         unsigned int bitmask = BIT(3) | BIT(5);
> 
> 	#define MASK  GENMASK(5,3)
> 
> 	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
> 			 bits, ARRAY_SIZE(bits));
> 
> The above code fills string "str" with "bit 3 name|bit 5 name".
> 
> Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
My typo still here :(

So drop that garbage and

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  drivers/firmware/efi/cper.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  2 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 928409199a1a4009b11cf3189fe036ad8861169c..79ba688a64f8da7af2dad097b9331c72afc73864 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -12,6 +12,7 @@
>   * Specification version 2.4.
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/time.h>
> @@ -106,6 +107,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
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
> + * A typical example is::
> + *
> + *	const char * const bits[] = {
> + *		"bit 3 name",
> + *		"bit 4 name",
> + *		"bit 5 name",
> + *	};
> + *	char str[120];
> + *	unsigned int bitmask = BIT(3) | BIT(5);
> + *	#define MASK GENMASK(5,3)
> + *
> + *	cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
> + *			 bits, ARRAY_SIZE(bits));
> + *
> + * The above code fills the string ``str`` with ``bit 3 name|bit 5 name``.
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
> +		if (!(bits & BIT_ULL(i)))
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
> index 0ed60a91eca9d6425c9a41947a927b59f7aa2c71..58f40477c824e61c7f798978947bf1f441ce45ad 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -588,6 +588,8 @@ const char *cper_mem_err_type_str(unsigned int);
>  const char *cper_mem_err_status_str(u64 status);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>  		     const char * const strs[], unsigned int strs_size);
> +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +		     const char * const strs[], unsigned int strs_size);
>  void cper_mem_err_pack(const struct cper_sec_mem_err *,
>  		       struct cper_mem_err_compact *);
>  const char *cper_mem_err_unpack(struct trace_seq *,
> 


