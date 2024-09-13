Return-Path: <linux-efi+bounces-1736-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12971978158
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B927B22B79
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA31D9358;
	Fri, 13 Sep 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r38jofUn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9911D6C7A
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234798; cv=none; b=SRrb2Ggdzg+W9dT5hSVy36A4yY5ZJPV8jgRWt3hxhd80zeA4MET9sV28Vy8NLCi9L7v0PBqkpm2BLgIlSuRC8n9SBWsoptWE1goQbjVosuPQrVf+EseXkdUgdHjgGGfhRj6EQQgghJo2sMLNhP6KUgaE90sIFUzY7FRrOj2qR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234798; c=relaxed/simple;
	bh=Une7f2k/KmpgDey8zFYfeiGwdtTaCeYlY49pG0SshaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4whnenuO3rn5orYRlAU3v5an1/xJAnjCDfN6HMnmfgTepWW7JBoISeJlR22xdauW+z6W0cygnVhX54RLE1toUCVPr4LUSriENiaVH5AaD5c+x6NRA362/M/9srH1Hys3cOoE5HQMmSyf4lTQT2kl5aPJ33CTm+NQTdZab2ae3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r38jofUn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1347440a12.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726234796; x=1726839596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15unwVZm+OPwbYI5yFxIUYjpkqKaKnTXKaJUsxY7urY=;
        b=r38jofUnrThI6s7mtqUHcPcl+fsVc/2iJhwdKIVfTGX0LpRwnQaGjvBhxAiXjopxqU
         b7J+EpIacYXOdgN4yTbGkQrc2tirNE+Dd35sRXy9a0j4mlDyWlOHfaOctyDjffyTpJr/
         CE0Lwkx4j+SSmgko5eFdmDLmPNkBRexU12CPEcc6c80GtPHdnUP0vjfSlG8ME+LKgcKM
         qeu7Ztta3nNMYlg2BFgK+RuOdbiirUK8mnXYI70JYQ0g2xNlHwLiKO/nHkZzF5Vv3Iiq
         qm3pMIUdN6zbmPX8itjLrVcRW3bepyyHCIR+2nH/f7S4T1NbO7muLXS2OCntitiSy7bb
         MoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234796; x=1726839596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15unwVZm+OPwbYI5yFxIUYjpkqKaKnTXKaJUsxY7urY=;
        b=Qqa08MRG0SMpBNd3xKTTSyU8CRSONfiEYoJFzBCLP94AlJyggDqwjY36SVSi5M5ZiW
         zu6Fy6H1xdJhQbn3/11PQSVf34cj8Z9YoV0N7UrtMb/u+i4aw39Vw0kdD0DApeb4BXcp
         +kaWx+6CsT+I6aA4LVREvIg5eNxxVUiTph6vLRRX19cN0/VpKjyOvHHwPO/zVeqYNJjA
         8t5gZUCQRcuNz2gtk9QGvq/X8HRy/ym54P0c4AYS9JS5I5B1oVXXtTXeAtwcQRX02G/l
         nu9vts9mNT6Gz4A3tv+VIoQQTnkPM9zFJCUvTD+TSdz19KOUQjriHyoi0WxgBihIJ4+d
         a9nw==
X-Gm-Message-State: AOJu0YyZ2B7wC7IbDtohgk26xSivG2tvaNNpS70tWRbJY390MZcJ5qt7
	js6K1SK4xYR/NdjsZyeFph7eKzSX9apX7XmSh4DNYEPa971YGcXCz2ESagun4QGXgHKPHOAjtGS
	dADXaKze++k0JKu31Ze7cotm39n4yFh5jLiy/+F2giIVyCYYP6r8=
X-Google-Smtp-Source: AGHT+IF59t17Y/5ech59IOa2/IFQRJFPElHtqzuEuiaN7v3gSFbj/dR4AVugJXpvaSP7ix1aYeDgRQlJmu3t8gEO0M8=
X-Received: by 2002:a17:90a:6809:b0:2d3:d728:6ebb with SMTP id
 98e67ed59e1d1-2db9ffa74b6mr7489220a91.5.1726234796028; Fri, 13 Sep 2024
 06:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com> <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 16:39:19 +0300
Message-ID: <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Gregory Price <gourry@gourry.net>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:57, Gregory Price <gourry@gourry.net> wrote:
>
> On Fri, Sep 13, 2024 at 09:40:30AM +0300, Ilias Apalodimas wrote:
> > Hi Gregory,
> >
> > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > If the log version is not sane (0 or >2), don't attempt to use
> > > the rest of the log values for anything to avoid potential corruption.
> > >
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  drivers/firmware/efi/tpm.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > > index 6e03eed0dc6f..9a080887a3e0 100644
> > > --- a/drivers/firmware/efi/tpm.c
> > > +++ b/drivers/firmware/efi/tpm.c
> > > @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
> > >                 return -ENOMEM;
> > >         }
> > >
> > > +       if (!log_tbl->version ||
> > > +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > > +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> > > +                      log_tbl->version);
> > > +               early_memunmap(log_tbl, sizeof(*log_tbl));
> > > +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > > +               return -EINVAL;
> >
> > I don't think we need this check at all. Did you actually see this happening?
> > efi_retrieve_eventlog() that runs during the efistub tries to retrieve
> > the log and the EFI protocol itself explicitly says that the firmware
> > *must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
> > 2.0 format. If the firmware does something wrong, we should report the
> > FW BUG in that function, instead of installing the config tables Linux
> > uses internally to handover the log and catching it late.
> >
> > Thanks
> > /Ilias
> >
>
> We saw this happen and discovered it was a disagreement between EFI/OS/kexec
> causing the table to be overwritten during kexec.  We've since found a fix for
> that.  So the result was that it appeared the firmware was doing something
> wrong. The sanity check at least allowed us to boot without immediately
> crashing - because the tables don't get reinstalled, they get re-used
> (at least that's by best understanding of the whole interaction).
>
> If the check seems superfluous, i can drop it.

Ok, that explains why it wasn't caught earlier at least. I would
prefer dropping it tbh, but I am going to defer to Ard for that.

If we agree that this needs to go in btw, I think you should refactor
it a bit. That function already defines an out: label, which unmaps
memory. So you can rewrite the above as

If(....) {
    ret = -EINVAL;
    efi.tpm_log = EFI_INVALID_TABLE_ADDR;
   goto out;
}

Cheers
/Ilias

>
> >
> >
> > > +       }
> > > +
> > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > >         if (memblock_reserve(efi.tpm_log, tbl_size)) {
> > >                 pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> > > --
> > > 2.43.0
> > >

