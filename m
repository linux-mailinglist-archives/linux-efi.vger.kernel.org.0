Return-Path: <linux-efi+bounces-1643-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E10968629
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854A92815D8
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E618562A;
	Mon,  2 Sep 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HysFPBmK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373E13B2A8;
	Mon,  2 Sep 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276302; cv=none; b=iVc6/7nGbjI9dBDqyTneu8PCT1cH7bxaj1HlxZa+o8j3AOIrWL5sLKVm65VrR3Ek1S7arSoEaSef5jRMgHPW+mkHvEwriDx1MEC55+EMwYvs+XH9iRwRev93aMw63YPvZ1M2fliGDMA9eHNSk4XNqGQwGbjcg/98zCUAOVfc5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276302; c=relaxed/simple;
	bh=43N3eERPpZSiAWFa7ZHGO+ZY8fm7EsglftDcQeTsfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ9/c6pIi+a8icaptMyJQebPVhceh9r7GEnc513gxQ5RGBonoTEgNDWCU0RAcoBY7Exf2RePo+IugtioRw5YwkCyNWqBLbOVGxE+qhJ9OSrwLKkvC5mqyu6dVba4kM0p4Ex6sng10Ra3JbJp5FeTC8rm3a5FaYuiYMyW3YNLZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HysFPBmK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5C7E40E0191;
	Mon,  2 Sep 2024 11:24:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MoBoLPHXyDDP; Mon,  2 Sep 2024 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725276291; bh=sZg3hbW3j7qspX2oVQJRU4r10UvGMmdPEa/Jk2S1BgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HysFPBmK+n8s+O2jLtwRbrVJh+wGaJCaP7cwJ7rpbErkx24ttZW81lVQWcnN/dJyx
	 kSJwNZQ8s+p3LEwCMoa16nNmxN1vOEMj62x5I46Ro6LpRHz7h5vgYn17IJti1OmXBo
	 mKH6K1K7qupfMd3Mxq24T8CoRDgh1e6ZwxsPWW53pvR513fwAuMTZ0N/hxowiCBgx8
	 BPxxDN2/EnquHzmt9Jp3BE9pnqrG/BOogMrRkQpQz1+emOow3hdkV0eDKmrX/+QnXX
	 sMdWQteJgZ/yfVeSYfLNr5E0SwdHEoy+fZkdskL0UkRdZWdbQ0wwqaApdbbVmlTSPF
	 70l0sME0H5PtSy7VuGSzqh8eDqW3sS/LeM6KTs4BaVr8tXvJN3J2doSQwjjHQw2lZP
	 /hLK5nZ/qRcRBuDojGABw8SGh5O8vXpY76qlB9sNtvsQdx3wEHiCa0YNm9PFlLGXBY
	 9GoTlNZWqkaeWOc2nh1Mj1msTupcTEMhOUWcNgdMjeBCJ/7ueg2pkAAGaZ0df4xr27
	 AIZLpr2tmXqAaqoaqKorSeD2mVVFMpwsm2kp1A93mNh4v1GQWrnfTf8N+IPlS4d8ho
	 GyxgWfPlfOEnipZA87CxwCNWo5BqzblZrF+g72KvLYjGOiaRTcOsv5cL94Twca/S5K
	 mo/uEQ4YGwzDzgu7NUFX0Ne0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B596440E0198;
	Mon,  2 Sep 2024 11:24:35 +0000 (UTC)
Date: Mon, 2 Sep 2024 13:24:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240902112429.GEZtWgbSo0EVe0EyWE@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
 <5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>

On Thu, Jul 11, 2024 at 08:28:54AM +0200, Mauro Carvalho Chehab wrote:
> Sometimes it is desired to produce a single log line for errors.
> Add a new helper function for such purpose.

How does this have anything to do with the below function?

Example?

Why isn't anything in lib/bitmap-str.c not useful for this?

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
> + * Add to @buf the bitmask in hexadecimal. 

Where does it do that?

> Then, for each set bit in @bits,
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

BIT_UL()

> +			continue;
> +
> +		if (*buf && len > 0) {

Uff, this is testing the first char in buf and it gets copied in below in
strscpy() through the str pointer.

So this function converts a set of set bits to their corresponding *names*
from strs[].

This name doesn't even begin to explain what this function does - it converts
a bitmap to the corresponding names of the bits in @strs. If anything, the
above comment needs an example and the function needs to be named properly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

