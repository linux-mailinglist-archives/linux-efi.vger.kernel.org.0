Return-Path: <linux-efi+bounces-3088-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97EFA7077C
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A0C168A0E
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052F25F987;
	Tue, 25 Mar 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqsclyKD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903325F7B1;
	Tue, 25 Mar 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921932; cv=none; b=e98aRCix0eWU5Iscxe/EPfiwz00ykQ1BlH+8kjpBXiB1t7iogp+EGndHAwdrzb6F3CL4Uo3LOfA2gkNrlPmrX2D2tXITvAR47UspBaaKYnQS3Xanh8SI88+HIZGYR0HzO2OX/b26pLBsnMu/9AMxFYrF1RltDh7wU9NXvSh5XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921932; c=relaxed/simple;
	bh=LPofMuuttV3w8fSyhzvBZjiWPt2mSRRJZP1UyVB1mQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvzr2d3Ov/cbejisnbYGD3rdZhuJdy0OMXKaEuCqmOWtlHOLCqGAAz6uF0CwBe1JR/Ri5iCyij+X7y+ojpSza2nC3QCkcWTp0YydqCp0zLq5+/9ivYrN1y0z07um5JBufpVG4sT2+qMTUXO+12WEYg0XvAmgXiumrHIs4PIQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqsclyKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A1C4CEE4;
	Tue, 25 Mar 2025 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742921932;
	bh=LPofMuuttV3w8fSyhzvBZjiWPt2mSRRJZP1UyVB1mQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqsclyKDG4YmXPljULwH214kke4c5OH6EZBy4S8E7h5tvqb3JqFclk5OIifAIJrmY
	 XISN4Xt9rjJETtSGJJ7YE0WdgIyMIop4+2OaN/fTLAUypt8EtWrfKS4MP4BgjCKae3
	 pOxdF3IogLIWwEvP2Kc+2jIIu6E7lzDh89ArDP8VoPQHq2Icq24vkGAIpCz8KqRuEg
	 MKVHBEiCJmpxn4ZFVdvg8bW954NzHA8YewUImCAS0Fx0DQC5HEmVvMrNH7ApgjHzVm
	 U54UVdN04mrHCJnSBZFA3pgVv/mXsbfhz8nwX+JLswHufPMhYQyfRgJ9AOY5NXKLj3
	 Y0BdxdY7PN5dw==
Date: Tue, 25 Mar 2025 09:58:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] wcslen() prototype in string.h
Message-ID: <20250325165847.GA2603000@ax162>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-LXHssrcpdtFqqn@smile.fi.intel.com>

On Tue, Mar 25, 2025 at 06:17:34PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 25, 2025 at 08:45:19AM -0700, Nathan Chancellor wrote:
> > If this is desired, it should be squashed into the previous change. I
> > wrote it separately because it is slightly more invasive.
> > 
> > In order to export wcslen() to the rest of the kernel (should it ever be
> > necessary elsewhere), it needs to be added to string.h, along with nls.h
> > for the typedef of wchar_t. However, dragging in nls.h into string.h
> > causes an error in the efistub due to a conflicting function name:
> > 
> >   drivers/firmware/efi/libstub/printk.c:27:5: error: static declaration of 'utf8_to_utf32' follows non-static declaration
> >      27 | u32 utf8_to_utf32(const u8 **s8)
> >         |     ^
> >   include/linux/nls.h:55:12: note: previous declaration is here
> >      55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
> >         |            ^
> >   drivers/firmware/efi/libstub/printk.c:85:26: error: too few arguments to function call, expected 3, have 1
> >      85 |                 c32 = utf8_to_utf32(&s8);
> >         |                       ~~~~~~~~~~~~~    ^
> >   include/linux/nls.h:55:12: note: 'utf8_to_utf32' declared here
> >      55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
> >         |            ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   2 errors generated.
> > 
> > Rename the efi function to avoid the conflict.
> 
> Hmm... Why not split this to two, rename patch as a standalone makes sense to
> me even outside of this series.

How so? If nls.h is not included in printk.c via string.h, which does
not happen without this series, what value does the rename have? I do
not mind splitting it up that way to keep things cleaner, I am just
wondering what would be the justification in the changelog (I guess just
that nls.h may get included in the future for some reason)?

Cheers,
Nathan

