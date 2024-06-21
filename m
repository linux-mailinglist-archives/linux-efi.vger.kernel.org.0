Return-Path: <linux-efi+bounces-1269-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290E59121A3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 12:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EE71F26103
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B5171074;
	Fri, 21 Jun 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jav66XVw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F717106D;
	Fri, 21 Jun 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964402; cv=none; b=jfHps3Fwjc5OiTwXFCQhNKqSrlISzkwnYmIZNM2PSByTTr2HPmmcr9S5UWyKtxHG5ZYgMyu4gFFz378Iic2fI6+asI1C2hZKDA7gJQl637mgxM66HQnLXB9zwyIvWQmeZY6A3u3/7igvJH1OnIhUozzukfnjXZMgeyvIxqoApO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964402; c=relaxed/simple;
	bh=HyR1uomQm1WcNm1+9X8ww3yotmxTUCaK5Z1HriLAFxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZaLaPR19sfsUAgvEPqga2k7d6JUulUu4tQv1gGjizIG+34OpI7+A+BUSkQN5FqoYx2hhxAyac3y3yH/Xh9nvMAzgYNu7g8rBFWFwh2ELtfTUtNjfGKwHlLvdyev4lMzMFcuGWAgYXx165ZAWg3sZz/awu0Db0Z4dlqJgrBESr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jav66XVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907D7C4AF08;
	Fri, 21 Jun 2024 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964402;
	bh=HyR1uomQm1WcNm1+9X8ww3yotmxTUCaK5Z1HriLAFxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jav66XVwtH/oq5SOhz8Sp9vkg1sp4h5Uc604nDJZ916XBxh7SeRJiZSRF+6ZMyRPm
	 Gb4miFWv8/PwQ9oCLvy/NKJBJWp6aafJx+nNAm+Bk2ZIv2E+52OfB4Y2Fq0dWYB156
	 pNIoWYj3A8iJyKA3ZIgZh+aBfXflMU+S+Eefs00aJBBdhjlwXpU97L9v4aUK7VOEkC
	 EHlMkgeKfsRRhYZ80HkVHKX6/1u2tMGqqaCCa1YxhrO+zU3hQFDLfg+cq7+0ls2Nxp
	 F7GraUrut/SzgU6DZhT9KgKzqauq5qazl1qDH3eq8yM6P11UdEEpHSACTkIWyTTavY
	 bLyoqjrNdPGUQ==
Date: Fri, 21 Jun 2024 10:39:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Shiju
 Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Ard
 Biesheuvel <ardb@kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linux-edac@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240621103833.28d937f4@sal.lan>
In-Reply-To: <20240621102036.0000493e@Huawei.com>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
	<fcc8a699c9497b788ac99aa0d57dedd629ac4945.1718906288.git.mchehab+huawei@kernel.org>
	<20240621102036.0000493e@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 21 Jun 2024 10:20:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

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

I tried to preserve the original non-kernel-doc way, as I'm not sure
why other comments on this file are not marked as kernel-doc stuff.

The code there at cper.c also has other coding style issues - for
instance it uses printk() without an error level.

Anyway, I intend to submit later on a separate patch series converting
the existing function documentation stuff to kernel-doc (and adding to
Documentation if not there already), and maybe addressing some other
coding style issues.

Yet, I would prefer to have such changes out of this fix patch series.

> > + * cper_bits_to_str - return a string for set bits
> > + * @buf: buffer to store the output string
> > + * @buf_size: size of the output string buffer
> > + * @bits: bit mask
> > + * @strs: string array, indexed by bit position
> > + * @strs_size: size of the string array: @strs  
> 
> If it had been kernel doc, W=1 would have told you mask is
> missing.

Yeah, I saw that just after hitting send :-) I'll add mask at
v5.

> Passing a 0 for mask seems probably not worth while.
> If all bits of the unsigned int are set then people can pass ~0

Makes sense.

> 
> Or make this cper_bits_to_str_masked() and have
> cper_bits_to_str() that doesn't take a mask.
> 
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

Ok.

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

No need to to that if we use for_each_set_bit().

> 
> Obviously setting bits that aren't in the mask is
> odd though so maybe a warning print if that happens?

The code already warns about that printing:

	"reserved bit(s)"

at the output buffer.

Regards,
Mauro

