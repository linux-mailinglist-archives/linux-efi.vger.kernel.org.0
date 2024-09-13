Return-Path: <linux-efi+bounces-1733-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C297809D
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35DF1F27133
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE611DA620;
	Fri, 13 Sep 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hUzXSX7r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDD1DA61C
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232311; cv=none; b=KTVRIcGIAvtSpcPVCE+zntAZ0eMZX1k7KpL9ZkkYBs3nYI667UFjg92bePyW4yfawV7rUZft+cKqubN6RK6aNErRnKy+EeYcOEH962d3WdIZYO5UAExaOzjO6+/8I+LoRpso1W7CheF812ud/73PwV6NvDUnaECx5gjAAfB9KTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232311; c=relaxed/simple;
	bh=nS7Duuf+HKwlIgucWCm3bY+03/DzdCTPPHs45h0jo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzh1dN18tLwDP9WOuIuHyIcR+pIyEe01ZIVIASdTAZ0A6tQQli8bdtEZavxVcPjFBuLTNsVcMfE/qPIufQp+NR1OSFD82SIX4hYTKZczoT8qM+5kb/228b210fbXr90QgyiUHxfLI8GzcCLCVkMDM5Yk/vblDfo8AGDEAt+9hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hUzXSX7r; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso7433096d6.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726232308; x=1726837108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9HemonoSff4igOZu0xZNoZpNwJv/dD9FtFww6sphMc=;
        b=hUzXSX7rkp+Dx/VURG4loXUx56adYEYXTnLvYOK8PPU6FncrqI3Nk7LnDudIq4hSYX
         lpJ+7yqkFixOBuUrocYEbUhqVtN+ee8wWSUFoq9rGQxyVAAwn9JVlFDFiJGZY1VIhFd+
         hNSGX+80HZFWj0wXr4XD41/+66siP4yGCWGofsUzY+QDbhP1K9wNBFd3TTLVFQQcAtKo
         XgkgDSPQCkPA3+s2kdkv8/4YR17dgcCfyFO8xn8iL1v4/nggDxtw5MoS3U1x2JOK/QOt
         p+eoC1yP1d4kSragqIA/D0qssQEkENUsr0/kZ1pNVqJUihAfX2FRTDDXsRCtqo3LH4sg
         n7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232308; x=1726837108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9HemonoSff4igOZu0xZNoZpNwJv/dD9FtFww6sphMc=;
        b=Ep5E8rZYvcSUsCgP3gHGJeQ9hc8lr0X50UvS56K6phy8EVA9TxMkMRhpyTSh9Z62Ck
         Axw22jy2VXvU5WVi66IiVodDByo5VYMT+gzBglCTVkO0jEfIIHxS1F3DEClqf3YpatTX
         grHkwSogtIJo6OedUTXRbLqut/hXQ6DCac9sEMm+255y3qcVoYpv0OGU5B+3l45TFLkP
         z4IdqI9+Xb8Ml2LjlKU27ppKdviZURGGl3DUt2BcjMen08GUda+IUa8N2sBGEsOAYqkr
         nanf5nx88O1zBPZ1CvEjDJXXJwie+0aKG0iIyCm7H/0UWY13t2mMr7VZrks9gvs4dhDd
         GUqg==
X-Gm-Message-State: AOJu0YwfkwWow6ork83QzeZLPMsiOWvU4rRQeD71ygOSicFpPanPP0KI
	XwMLhPvGCaejCSRAsqcc3iriS7EGbkeR963dtrnsprHCqjZFOHdtnTVddmngeIM=
X-Google-Smtp-Source: AGHT+IGxnv1AR033O+1dC692fhlVGgQoY71B4fSyjToczXO7FownXlskiz61N3UHzua0YSRM9+CkCQ==
X-Received: by 2002:a05:6214:450b:b0:6c5:5a63:7ee5 with SMTP id 6a1803df08f44-6c57def3025mr47201026d6.9.1726232308381;
        Fri, 13 Sep 2024 05:58:28 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534784f51sm66119896d6.133.2024.09.13.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:58:28 -0700 (PDT)
Date: Fri, 13 Sep 2024 08:57:42 -0400
From: Gregory Price <gourry@gourry.net>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org, leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
Message-ID: <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-4-gourry@gourry.net>
 <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>

On Fri, Sep 13, 2024 at 09:59:03AM +0300, Ilias Apalodimas wrote:
> Hi Gregory,
> 
> On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> >
> > If get_event_log fails, at least provide an indicator of this failure
> > to assist debugging later failures that attempt to interact with it.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/libstub/tpm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> > index df3182f2e63a..192914e04e0f 100644
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
> >                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
> >         }
> >
> > -       if (status != EFI_SUCCESS || !log_location)
> > +       if (status != EFI_SUCCESS || !log_location) {
> > +               efi_err("TPM unable to provide Event Log\n");
> 
> s/provide/retrieve/ and yes the print is going to be useful.  Do you
> know if the EventLog is mandatory. Reading at the spec GetEventlog
> only has 2 return values, which implies you can't return "Not
> supported", but it's not explicitly stated anywhere
> 

I believe it is mandatory from my reading of the spec - but the
"Final Event Log" was only added in 2.0.  We report an error when
2.0 is reported but the final event log is not supported, so i figure
we should probably report when the event log fails as well.

> Thanks
> /Ilias
> >                 return;
> > +       }
> >
> >         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >                                    truncated, final_events_table);
> > --
> > 2.43.0
> >

