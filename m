Return-Path: <linux-efi+bounces-1746-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1439786E9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D721F23CDB
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8F8289E;
	Fri, 13 Sep 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mbocISez"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313E823AF
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249034; cv=none; b=Gzpsa0b62ot6Z57UxI1Kvk+xTG5PRXZkgUL88pqEoNHYYd945Hqmzcs4npOvnSMGtxcAm49Fmh6eYpGjnaioQRqraH1j/YRftzvsZqt7nWYl9dJ6MQ66hznOUnzD7fyueA47ll15hXkfOAwpiRPxALcRUpeuRXHFU1DLtBSc2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249034; c=relaxed/simple;
	bh=dUCpUCzCTQzlHOUafZp+vbPiQRMStQj0JXyNOKtJPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDbEHYiQuyJcw9tVzpKaOh5bzIvp6Yhg1OyRummv6QrfQG2XiQ6Y5YnktWAS4aD5pBh7zp2kdwuQb5Sq0IADhxhackBLg2T7ZyslOrM+00/EDyytutqAwWmV8PF6DfzwcYR67MO7jXY6lwYzP9xHiaolN6GvZ8B+nmpJSNhz56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mbocISez; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4585721f6edso9380601cf.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726249031; x=1726853831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9dJXzMGlJLqrAQ9o+Vc2RqzvgiZJjLx1kqE3WmHF9c=;
        b=mbocISezNMCygpFXaduluIokl2C1cKJFdBGU4WBAoTi/NWIp+D7TvKug0/4bN5kBKz
         PrFiBG8nffWVS+KTvkcIa7LWHwPxakmnoKiDPmmx8i5CpGWvB03Oa0ePHAz68JiyLiRh
         gTiMHg3ffKFXkMNxX7kg5N4kdOuFQRY6qkXY+kjQodaR+jQ6mHs9yjP6aKXLYP4OmdnH
         IGvK0q1OgGmP+29dN0JsZLh8CcOpkx6t2Lo41rHm4QcK8A8kzFeiJIcSJlDRHfpG62qA
         9PKxmlxwNEziLEyRRPQKW7UUq9lUQ5GIjcM2DiKHDHMOUSX8TsHhFbebhaFMRfaf/+iS
         3vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249031; x=1726853831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9dJXzMGlJLqrAQ9o+Vc2RqzvgiZJjLx1kqE3WmHF9c=;
        b=XiAVRUFUr+Y+7h+zPUwOZytPZPymfpDOF7yWXjxyBOkMxomH/dbXxqXb+6cULGieCw
         Z3k00nfReDov8+zF5pW/k1fsf4bLMwyTbrzTUSWC8TKiKg5px8b0hNMjjLsa4xXgdTIc
         tmFkAAIZoiDLz/w8lzm1mctBVgul0zz53Ih9Mv/WgaG9K7Ha65g2SCBcm6yifqHXQgD0
         bHQTCjP/OMqqJrxSABoeYlBuHmEffZRzqANwKQn8nwPYn3Rdzfr2kzhSxU4rZpw/THDW
         PYOfaGq4cnlB2LzBlKUr97/ZLXJCQi+FcR7B2KsuTljZ22iuaMW0zwYgW5QDqxaVS7+5
         ExpQ==
X-Gm-Message-State: AOJu0YyTzk8BVn4BgRZPH2uPIdwMgM0vWN04kK+a1eQ5rA6QHwdkaKFa
	YCCRfRtcHD+dAJB+RQmnQf5g3p2RyBtGNfQhEV+pMKIn2p6Dex0NLhBi5bas0yk+Fg9r6sBcAQv
	0
X-Google-Smtp-Source: AGHT+IF99vSVYAPg5qiz9PS9VXQEetrF1jAxdpVZcbXfZvWNP4xT8rH9ih22k1ewCgvXurstnbJd4g==
X-Received: by 2002:a05:622a:547:b0:458:4e9e:634e with SMTP id d75a77b69052e-4599d224953mr52447361cf.11.1726249031507;
        Fri, 13 Sep 2024 10:37:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e98a1dsm67754741cf.40.2024.09.13.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:37:11 -0700 (PDT)
Date: Fri, 13 Sep 2024 13:36:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: Re: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading
 final event log
Message-ID: <ZuR4GsERfsyJnG06@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-7-gourry@gourry.net>
 <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com>
 <ZuRaT75h0wcopILx@PC2K9PVX.TheFacebook.com>
 <CAMj1kXHEH5PE=7swKMJUP-gTAuyoJH5E8NL+RuFnMceF=MpoWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHEH5PE=7swKMJUP-gTAuyoJH5E8NL+RuFnMceF=MpoWQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 05:59:17PM +0200, Ard Biesheuvel wrote:
> On Fri, 13 Sept 2024 at 17:30, Gregory Price <gourry@gourry.net> wrote:
> >
> > On Fri, Sep 13, 2024 at 05:25:27PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 6 Sept 2024 at 22:28, Gregory Price <gourry@gourry.net> wrote:
> > > >
> > > > Current code fails to check for an error case when reading events from
> > > > final event log to calculate offsets.  Check the error case, report the
> > > > error, and break early because all subsequent calls will also fail.
> > > >
> > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >  drivers/firmware/efi/libstub/tpm.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > > > index 4f9f0e049a7a..c71b0d3e66d2 100644
> > > > --- a/drivers/firmware/efi/libstub/tpm.c
> > > > +++ b/drivers/firmware/efi/libstub/tpm.c
> > > > @@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
> > > >                         event_size = __calc_tpm2_event_size(header,
> > > >                                                    (void *)(long)log_location,
> > > >                                                    false);
> > > > +                       if (!event_size) {
> > > > +                               efi_err("Invalid TPM Final Event Log Entry\n");
> > > > +                               break;
> > > > +                       }
> > >
> > > I don't object to this in principle, the only problem is that these
> > > log prints are not recorded anywhere: they are printed to the EFI boot
> > > console by the EFI stub, which may not even be visible, and is
> > > definitely not captured by the kernel logging routines.
> >
> > Could simply drop the err and break if you think it's just going to get
> > lost anyway.  Not sure there's a good way to generate a signal at this point.
> >
> 
> Yeah. For the record, I absolutely detest the kludgy code there, how
> we parse the map, parse and unmap the event header for every entry in
> the log.
> 
> So while I highly appreciate the effort you are putting in to polish
> this code, I wonder if it wouldn't be better to code this up properly
> instead.

Mostly I was both amused and triggered by a patch trying to fix a
signed/unsigned bug introducing another signed/unsigned bug lol.

Then I found more and felt this injustice cannot stand x_x

I'll at least push another version of these fixed up and i'll just
drop this print. Probably improving this code isn't worth it unless
it's fundamentally broken (which it does not *appear* to be, i spent
a day auditing it against the spec, and to my eye it looks largely ok).

~Gregory

