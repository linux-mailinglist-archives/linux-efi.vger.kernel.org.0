Return-Path: <linux-efi+bounces-1737-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7E978166
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321451C2274E
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE611DA62F;
	Fri, 13 Sep 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6WvN70I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503D1C2DAA;
	Fri, 13 Sep 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235060; cv=none; b=VjK8l0wYduZiIha4S0Ll8AXowHDQWNyHrtjHxtwkQzNZrLDUU5GHPd5uPE2ZEVuYatz4sTSTQDZ0u8ScSyEDRZdLpRqz1iiYhgj8ikv61AqNHsalrmCVtC5LalchoE/9WXzMDl2z8YB8tkW6qycGgzvkttWUSET6uYcZvPtH+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235060; c=relaxed/simple;
	bh=So7Ou1bgpq1eBnTCykwLwj9RCYzU3iPoCbU4c8ED3k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3Ubnf5ED+nQ/wHWNNkwwoprXg9oWEM6D+NyoMpF5uB0NwubtnM130qpJ+B8P0Khs1xtRs+k8pc6elYDypvAoaU47xOkkPLUU9ggpFBxDw1U/YojHLi6sWhUWSok2ACABgQpSgm4lmMlI2HPq1/2hXYqfNw8w3ibKLZdcCiaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6WvN70I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D4C4AF09;
	Fri, 13 Sep 2024 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235060;
	bh=So7Ou1bgpq1eBnTCykwLwj9RCYzU3iPoCbU4c8ED3k0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O6WvN70IA3+p08qWgT6zfuUK4NeGIy8NmQSZYx9Wo0EKQETs/BifsLEhbqV4dgWrj
	 ebSNginltT0N/ZQ8jTTmFULzY1rJT3vMhZMNPhOt2lEHm+vPq6ZSn2kCJMwe1wESVh
	 uY0plucjsgl3MTZBd9QKDA1J4MaFOJvGM9U1THEddhdGlKgqIE7HRHi0aTbGKowaOA
	 jYtTe8Fd9+tDgYCF/qTSseCHoGfkEdiKP8Xk1p4T9e2+jernbO8cf/XeqTBP2LO1xF
	 hReP/5Vh5yWKCTEOKVI0AWr6mPntAZwfeG3iACMPgqC8ZkHI0492T9i1/FoAF5A3dy
	 3A5RXKv9+VNHQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f753375394so20960851fa.0;
        Fri, 13 Sep 2024 06:44:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy5xZD+UPrFOWJL4MiuCp0wl9V93QkTnJVR57pYNfCndUm3+FEv+VQDZpXSPVl4h9ogxjeBk1u43NMMRyF@vger.kernel.org, AJvYcCXBQsOHRTlUGUz45x3Uj6/Pp7eiMCpzxex7tYqO4cWhwBfAgAh8lNwJlzpWLPQmQl2tUjyS1sXOOpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg8bXlphotqu27DIjGl531a7Rg5evR5i9/3e9T+RGM6xjaSXz
	13MMWD5YBGze7tPy+Ezdz7sTZwihGxuI2HYl6f9L5e+Olxo5KMLEVR1+0MYsdtdjMcmcjm+cO8+
	P6k9D5BxIuSeb9LPslou3QJxR/G8=
X-Google-Smtp-Source: AGHT+IGO6V1ba24bRdDJblKHTDk0lUPYvYvHmtqb6jPU/DoOBM9uX68J5zaLOeJ0LEwmPhoIIe+7r5UNeEIJuZG+Ssc=
X-Received: by 2002:a05:651c:1988:b0:2ef:1784:a20 with SMTP id
 38308e7fff4ca-2f787f4f5d6mr39490071fa.38.1726235058474; Fri, 13 Sep 2024
 06:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
 <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com> <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
In-Reply-To: <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 15:44:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
Message-ID: <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Gregory Price <gourry@gourry.net>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:39, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 13 Sept 2024 at 15:57, Gregory Price <gourry@gourry.net> wrote:
> >
> > On Fri, Sep 13, 2024 at 09:40:30AM +0300, Ilias Apalodimas wrote:
> > > Hi Gregory,
> > >
> > > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > > >
> > > > If the log version is not sane (0 or >2), don't attempt to use
> > > > the rest of the log values for anything to avoid potential corruption.
> > > >
> > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >  drivers/firmware/efi/tpm.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > > > index 6e03eed0dc6f..9a080887a3e0 100644
> > > > --- a/drivers/firmware/efi/tpm.c
> > > > +++ b/drivers/firmware/efi/tpm.c
> > > > @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
> > > >                 return -ENOMEM;
> > > >         }
> > > >
> > > > +       if (!log_tbl->version ||
> > > > +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > > > +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> > > > +                      log_tbl->version);
> > > > +               early_memunmap(log_tbl, sizeof(*log_tbl));
> > > > +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > > > +               return -EINVAL;
> > >
> > > I don't think we need this check at all. Did you actually see this happening?
> > > efi_retrieve_eventlog() that runs during the efistub tries to retrieve
> > > the log and the EFI protocol itself explicitly says that the firmware
> > > *must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
> > > 2.0 format. If the firmware does something wrong, we should report the
> > > FW BUG in that function, instead of installing the config tables Linux
> > > uses internally to handover the log and catching it late.
> > >
> > > Thanks
> > > /Ilias
> > >
> >
> > We saw this happen and discovered it was a disagreement between EFI/OS/kexec
> > causing the table to be overwritten during kexec.  We've since found a fix for
> > that.  So the result was that it appeared the firmware was doing something
> > wrong. The sanity check at least allowed us to boot without immediately
> > crashing - because the tables don't get reinstalled, they get re-used
> > (at least that's by best understanding of the whole interaction).
> >
> > If the check seems superfluous, i can drop it.
>
> Ok, that explains why it wasn't caught earlier at least. I would
> prefer dropping it tbh, but I am going to defer to Ard for that.
>
> If we agree that this needs to go in btw, I think you should refactor
> it a bit. That function already defines an out: label, which unmaps
> memory. So you can rewrite the above as
>
> If(....) {
>     ret = -EINVAL;
>     efi.tpm_log = EFI_INVALID_TABLE_ADDR;
>    goto out;
> }
>

Validating a table that was created by the EFI stub seems redundant.
If the version check needs to be tightened, please do so in
efi_retrieve_tcg2_eventlog() (in the stub).

