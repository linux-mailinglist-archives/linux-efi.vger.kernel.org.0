Return-Path: <linux-efi+bounces-1743-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78B9784EA
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C2B2679D
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BB2B9C6;
	Fri, 13 Sep 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UVutk4K9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686284D0F
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241408; cv=none; b=BiacIRbFbQ8nxQOy3oM5jammcscjKmNF4OznzWiqFoo9QN84k5OU52g/jAhY4lfrRAuDGZeJA1ZRbZkSmk3k+rI97aIyj7iLlsykhzvU1z4VFP5QstxL8N3RGa6RlA1VjBGVN8kcBWmgIDhLoeIKOGh2Rwa2O0pellDxxAlDfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241408; c=relaxed/simple;
	bh=siFFydEieqEhCnqh02m9ZlmFS6Zr3raAN5wadOP+FgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCRLgFNCQM2a/TYCIHpj/OwgJnD6/8y/namZ7rMIngb7qTar5cPrc1IyKLFVNhDAnTP+9Yvrl0+Qk6HQvqJVd9X+J0tFfLuj0fFlJ5TvALlb98kn5vmeYmQByy5+lYbpxiTgunG+0eOH+NFcTWhhxk7yJZsj7MKFxwjUzyt7qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UVutk4K9; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e0379a8d96so398241b6e.3
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726241405; x=1726846205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y0w45DKqFAHgVBSTZ5RzZdG/gVSrFtEUs5b4HqNZag=;
        b=UVutk4K9dU+zeWVZV5YWG7rRuu8TBaZEBEvcuSR4Ld0xdPmm2xa+WR0GdgXf93JCla
         72fgsNGKgvKKu+PNzyfgUoyKR8ncPpkjzfWv40uwBZ2cCabxvzAZ30CYih5xGmf8eFz1
         +mjZ/Y7Cp+M8NlYuEw03ZKXMQbtgXp9SnqntnwetQgSYiC98QCatsnrPjkVUBXM5Np9b
         6TunPLL7opDpMaLUiQrf5eUd+LywOkb9VfedwNruWZSqRYIuROELl9Sgkk8dZ9KwQZwP
         KRUSSmblE+b1WoVJjTIxHcpoV/6jpSEuwsINk+RJLAaze7Yax9KUEpJ44a0UdUafVlzh
         PyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241405; x=1726846205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y0w45DKqFAHgVBSTZ5RzZdG/gVSrFtEUs5b4HqNZag=;
        b=XgfAoOhx6DRRFB7hIaPv+bqDIfsDt4pJgpniopF6FrJC6VT5az64bCewH64ETYHNil
         ED4hS7FGuKjsUdeuQNMs4zOb3GkMSJiYGHPs7uje4cdyHCuHDfj7UZcpxRddK5vv5JuP
         4rU7+8cNvQ7kyTMP49uDU2u6MMBU/5w0joMNLcgfL+X2+7Y0eZjXaeTVxv6Rutzmu3kf
         W3C4xYJnaHWQnCWQqdGLWW+zyTvfdZV1KEBOGNMJ0C1tAVxOv5XIh+ZWtqq4PAPNq6y0
         LrXJcPLDn5sLbqSLM3pxGfCzvtNgjhbJPleYbsD1t0oRM5nJpXC/QUmCQtJAN/kjkGyS
         5fXA==
X-Gm-Message-State: AOJu0Yzdrxim3qInm3AqVC/aj1jbgNu/0Lh1Zmwk9XXQjTSr7UA2GCmE
	ykFhvMuTENjrNpO9ufdxqs7qK9OHF3VWlNc278zJKiOEKqbhRSR8QA0iMRIDlZ0=
X-Google-Smtp-Source: AGHT+IFl2bbncFJF88xZ/GQPQ/P9+N7NbkCTY6ItwpVTo6SIJtBJf1aZVZ33xUQC1pCIiYdwl/KVbA==
X-Received: by 2002:a05:6808:1920:b0:3d9:dabc:7b79 with SMTP id 5614622812f47-3e07a18e96bmr1671440b6e.47.1726241405209;
        Fri, 13 Sep 2024 08:30:05 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45831673331sm54703501cf.16.2024.09.13.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:30:04 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:29:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: Re: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading
 final event log
Message-ID: <ZuRaT75h0wcopILx@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-7-gourry@gourry.net>
 <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com>

On Fri, Sep 13, 2024 at 05:25:27PM +0200, Ard Biesheuvel wrote:
> On Fri, 6 Sept 2024 at 22:28, Gregory Price <gourry@gourry.net> wrote:
> >
> > Current code fails to check for an error case when reading events from
> > final event log to calculate offsets.  Check the error case, report the
> > error, and break early because all subsequent calls will also fail.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/libstub/tpm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > index 4f9f0e049a7a..c71b0d3e66d2 100644
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
> >                         event_size = __calc_tpm2_event_size(header,
> >                                                    (void *)(long)log_location,
> >                                                    false);
> > +                       if (!event_size) {
> > +                               efi_err("Invalid TPM Final Event Log Entry\n");
> > +                               break;
> > +                       }
> 
> I don't object to this in principle, the only problem is that these
> log prints are not recorded anywhere: they are printed to the EFI boot
> console by the EFI stub, which may not even be visible, and is
> definitely not captured by the kernel logging routines.

Could simply drop the err and break if you think it's just going to get
lost anyway.  Not sure there's a good way to generate a signal at this point.

~Gregory

