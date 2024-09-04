Return-Path: <linux-efi+bounces-1647-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B575D96B075
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 07:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D878285F9F
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FD82D83;
	Wed,  4 Sep 2024 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQxh9Xy6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EEB522F;
	Wed,  4 Sep 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427483; cv=none; b=MprRD1/YiiOwo2T5AJuVetF1AQV9XnuJ2+c4iDfK6t9M8H8skjHeq8RqQx1Rz81bUdYGwScKqE9P2ZrqpEQWLfY1OW4QAzGnMEWYdNL1X9F8o16o1OyWMuAHKC3rUJuGn1hkN7bQWdfmaYBdX8BawdG4Z0XL/YIgA2g+j4TjoM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427483; c=relaxed/simple;
	bh=PLczOOovhKela6g7hCR38D9+jRUN17hhMoTicA+UvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCdxzlZTu5I1itNzK04qR6+XXm7lFzBUpjFOXi4Jc6sZB1shBCx84p9Sznrj9PSFHUivgzV+FCETYJGRqeI32Y3xYrPe/SrypN78l0BYEBYVf5HYQ5PKD1R7yir0Mcpt0f0IWhefumUToxGb6cAst72i1KBsWCdXomIDOL2Chmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQxh9Xy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33EBC4CEC2;
	Wed,  4 Sep 2024 05:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725427482;
	bh=PLczOOovhKela6g7hCR38D9+jRUN17hhMoTicA+UvX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQxh9Xy6kx8LzFJJtfRUfhsEGhjAhkuYS8b10FCVvbrDf+UMjws+gu0iyzmEHmVqb
	 jeEcv5tchrl9LEQ3Cy1jhez/6biJABWwRqJcYPOa3ea3GsNncphqfv3jsC8/ySFj6Z
	 9Hmtkm86PCxiXUCjcJd79YX2DjQahWkKctyaLP4FeCnx4NSsPwGQpKG8+yof2ypvbC
	 riaFuAbGrq8Z03oEFoADVx5ezJRFj8ct11Kv0yi+0xoGKIY63OdFbnnWxThRNmyzdW
	 QGuKxHBmLtg9QpNHfJiKzy4D9dmMMFTAURbOTdEIQZrFV+yplTq6xAUV59oq3nsueO
	 Lo+Ny/yZe8rrQ==
Date: Wed, 4 Sep 2024 07:24:36 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, James
 Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Alison
 Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] efi/cper: Add a new helper function to print
 bitmasks
Message-ID: <20240904072436.59ee50e7@foz.lan>
In-Reply-To: <20240902112429.GEZtWgbSo0EVe0EyWE@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
	<5bb5f806a763b295401972fdff17bb455bee2e82.1720679234.git.mchehab+huawei@kernel.org>
	<20240902112429.GEZtWgbSo0EVe0EyWE@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 2 Sep 2024 13:24:29 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jul 11, 2024 at 08:28:54AM +0200, Mauro Carvalho Chehab wrote:
> > Sometimes it is desired to produce a single log line for errors.
> > Add a new helper function for such purpose.  
> 
> How does this have anything to do with the below function?

There is a variant at cper.c that creates a multi-line output
for bitmaps.

> Example?
> 
> Why isn't anything in lib/bitmap-str.c not useful for this?

I took a look there. I wasn't able to find anything remotely
close to convert a bitmap into their correspondent bit names.

See, the intended usage for this function is to convert ACPI
bitmasks into the field names. On ARM Processor Error, this is
used to properly parse the type field, as described at:

	https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information

The definition for this specific bitmask starts on bit 1,
so the logic to parse it uses a FIELD_GET to apply the
proper bitmask. This is how it is used (see patch 4/5):

	const char * const cper_proc_error_type_strs[] = {
		"cache error",
		"TLB error",
		"bus error",
		"micro-architectural error",
	};

	#define CPER_ARM_ERR_TYPE_MASK                     GENMASK(4,1)

	char error_type[120];

	cper_bits_to_str(error_type, sizeof(error_type),
			 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
			 cper_proc_error_type_strs,
			 ARRAY_SIZE(cper_proc_error_type_strs));

I'll add an example similar to it to kernel-doc comment.

> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/firmware/efi/cper.c | 43 +++++++++++++++++++++++++++++++++++++
> >  include/linux/cper.h        |  2 ++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 7d2cdd9e2227..462d739e8dd1 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -106,6 +106,49 @@ void cper_print_bits(const char *pfx, unsigned int bits,
> >  		printk("%s\n", buf);
> >  }
> >  
> > +/**
> > + * cper_bits_to_str - return a string for set bits
> > + * @buf: buffer to store the output string
> > + * @buf_size: size of the output string buffer
> > + * @bits: bit mask
> > + * @strs: string array, indexed by bit position
> > + * @strs_size: size of the string array: @strs
> > + *

> > + * Add to @buf the bitmask in hexadecimal.   
> 
> Where does it do that?

Legacy comment from the past version. Will drop it.

> > Then, for each set bit in @bits,
> > + * add the corresponding string describing the bit in @strs to @buf.
> > + *
> > + * Return: number of bytes stored or an error code if lower than zero.
> > + */
> > +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> > +		     const char * const strs[], unsigned int strs_size)
> > +{
> > +	int len = buf_size;
> > +	char *str = buf;
> > +	int i, size;
> > +
> > +	*buf = '\0';
> > +
> > +	for_each_set_bit(i, &bits, strs_size) {
> > +		if (!(bits & (1U << (i))))  
> 
> BIT_UL()
> 
> > +			continue;
> > +
> > +		if (*buf && len > 0) {  
> 
> Uff, this is testing the first char in buf and it gets copied in below in
> strscpy() through the str pointer.
> 
> So this function converts a set of set bits to their corresponding *names*
> from strs[].

Yes.

> This name doesn't even begin to explain what this function does - it converts
> a bitmap to the corresponding names of the bits in @strs. If anything, the
> above comment needs an example and the function needs to be named properly.

I'll add an example.

Thanks,
Mauro

