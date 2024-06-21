Return-Path: <linux-efi+bounces-1267-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A528912077
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5FAB21B28
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52F16E868;
	Fri, 21 Jun 2024 09:26:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BC12D1EB;
	Fri, 21 Jun 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961981; cv=none; b=EXM7KeszyZtsVNMTqwB8v50Ump4hzK/mM8uoAqXL/sLyIZg6ZA0xHlD/XOroN4jswXVHjeyQPirhpY1ys8ngheRkm/QOV/PXINypj4V/b2ENN7AChoa7ZXuLUqHNoSLDLo4M8GzQNLHxp2mlPLCJkHgJD59GjAn5Bp0ojejmZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961981; c=relaxed/simple;
	bh=iGyxiKTVbLVFE4tjDiXsZQhh4d9kiqe6XaPjBhqKVJo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSRv7/nHGYYpb3BE5gu261cAMK2zmz5W4ZLHd95SbaKpY8mUzV2gUvjn94f5nk+NR4ziHFBTpQOQLllPEA7rq0uyEfgONpAbLt6/SEi4VEaBEG0BuxmO/katxTPPQCUsXEsLuUjGYAqARoSXVKqEhej/gN9qZs0QoHMuMwd2HXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Bn01hZ9z6GDNF;
	Fri, 21 Jun 2024 17:26:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FF9B140B2A;
	Fri, 21 Jun 2024 17:26:16 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 10:26:16 +0100
Date: Fri, 21 Jun 2024 10:26:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Shiju
 Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240621102615.00004ce7@Huawei.com>
In-Reply-To: <20240621102036.0000493e@Huawei.com>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<fcc8a699c9497b788ac99aa0d57dedd629ac4945.1718906288.git.mchehab+huawei@kernel.org>
	<20240621102036.0000493e@Huawei.com>
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

On Fri, 21 Jun 2024 10:20:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 20 Jun 2024 20:01:45 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Sometimes it is desired to produce a single log line for errors.
> > Add a new helper function for such purpose.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/firmware/efi/cper.c | 59 +++++++++++++++++++++++++++++++++++++
> >  include/linux/cper.h        |  3 ++
> >  2 files changed, 62 insertions(+)
> > 
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 7d2cdd9e2227..9bf27af3e870 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -106,6 +106,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
> >  		printk("%s\n", buf);
> >  }
> >  
> > +/*  
> 
> It's exported and in a header used by other code, so why not make
> this kernel-doc? /**
> 
> > + * cper_bits_to_str - return a string for set bits
> > + * @buf: buffer to store the output string
> > + * @buf_size: size of the output string buffer
> > + * @bits: bit mask
> > + * @strs: string array, indexed by bit position
> > + * @strs_size: size of the string array: @strs  
> 
> If it had been kernel doc, W=1 would have told you mask is
> missing.
> 
> Passing a 0 for mask seems probably not worth while.
> If all bits of the unsigned int are set then people can pass ~0
> 
> Or make this cper_bits_to_str_masked() and have
> cper_bits_to_str() that doesn't take a mask.
> 

Mask definitely needs docs as I misunderstood it :(
Also needs to be contiguous I think which is also a bit unusual.

> If you do that, some simplifications can be easily made.
> 
> 
> 
> > + *
> > + * add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
> > + * add the corresponding string in @strs to @buf.
> > + */
> > +char *cper_bits_to_str(char *buf, int buf_size, unsigned int bits,  
> 
> Perhaps make bits an unsigned long as then you can use the
> for_each_set_bit() etc.
> 
> > +		       const char * const strs[], unsigned int strs_size,
> > +		       unsigned int mask)
> > +{
> > +	int i, size, first_bit;
> > +	int len = buf_size;
> > +	const char *start;
> > +	char *str = buf;
> > +
> > +	if (strs_size < 16)
> > +		size = snprintf(str, len, "0x%02x: ", bits);
> > +	if (strs_size < 32)
> > +		size = snprintf(str, len, "0x%04x: ", bits);
> > +
> > +	len -= size;
> > +	str += size;
> > +
> > +	start = str;
> > +
> > +	if (mask) {
> > +		first_bit = ffs(mask) - 1;
> > +		if (bits & ~mask) {
> > +			size = strscpy(str, "reserved bit(s)", len);
> > +			len -= size;
> > +			str += size;
> > +		}
> > +	} else {
> > +		first_bit = 0;
> > +	}  
> Might be worth
> 
> 	bits = bits & mask;
> 
> Obviously setting bits that aren't in the mask is
> odd though so maybe a warning print if that happens?
> > +  
> 
> 
> for_each_bit_set(i, &bits, strs_size) {

Ah. I'd missed the offset and gotten function name wrong.

i = first_bit
for_each_set_bit_from(i, &bits, strs_size + first_bit)

and look up based on i - first_bit


> 	...
> 
> }
> 
> > +	for (i = 0; i < strs_size; i++) {
> > +		if (!(bits & (1U << (i + first_bit))))
> > +			continue;
> > +
> > +		if (*start && len > 0) {
> > +			*str = '|';
> > +			len--;
> > +			str++;
> > +		}
> > +
> > +		size = strscpy(str, strs[i], len);
> > +		len -= size;
> > +		str += size;
> > +	}
> > +	return buf;
> > +}
> > +EXPORT_SYMBOL_GPL(cper_bits_to_str);
> > +
> >  static const char * const proc_type_strs[] = {
> >  	"IA32/X64",
> >  	"IA64",
> > diff --git a/include/linux/cper.h b/include/linux/cper.h
> > index 265b0f8fc0b3..856e8f00a7fb 100644
> > --- a/include/linux/cper.h
> > +++ b/include/linux/cper.h
> > @@ -584,6 +584,9 @@ const char *cper_mem_err_type_str(unsigned int);
> >  const char *cper_mem_err_status_str(u64 status);
> >  void cper_print_bits(const char *prefix, unsigned int bits,
> >  		     const char * const strs[], unsigned int strs_size);
> > +char *cper_bits_to_str(char *buf, int buf_size, unsigned int bits,
> > +		       const char * const strs[], unsigned int strs_size,
> > +		       unsigned int mask);
> >  void cper_mem_err_pack(const struct cper_sec_mem_err *,
> >  		       struct cper_mem_err_compact *);
> >  const char *cper_mem_err_unpack(struct trace_seq *,  
> 


