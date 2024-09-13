Return-Path: <linux-efi+bounces-1732-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B15978098
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111281F26E27
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE91DA620;
	Fri, 13 Sep 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JmPrWifi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48461D86DC
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232229; cv=none; b=nZeQXeQW8SAlp7rG6iMxbbH80e+a+R1J+ZfZKrBMpVbO29i/72TS58DUKhfIpbTfZjkFX8olpfByoyJt1B2UXj2vU68vA7UPlMByKs3oIyb9bVG5lBuQe/P4qToCaObb3R7nKJOuyt57BMjQEGYpUmlxHEev0hwfV5ZM7k12Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232229; c=relaxed/simple;
	bh=tH23dET3W+bdUFx3YCiAyQJxC1I7bsxbztXcNDlgBao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC0O/50c7ogrCt8UDdw0S2V9jxKbPijsvAWqgB8Qoners8A6SmVH6kKgulW3dIFmsOqP80UVGDXTy1sSdzXgMk1pzJfD3h3Tw7DH76QlY7orzyoyRIYoHL0jZ+OV3X5fzU8EGa2ow+XhMEzxcS09flowFAyU+uK4dqvZLHEOQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JmPrWifi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6d5893cd721so7243787b3.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726232225; x=1726837025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GW3d9XB2yvL3Rb81kUGiyxRHSm6TQz1BPOKouSAWkE=;
        b=JmPrWifisCMDhsoZtejUU7hgXv+oQ32i6f+0D4dk/5vVGO/G0wrAj+qv0AkGlUyM56
         julHMpo70zUKDYpoVv59+LTYkJz75EQsdXO4ApgcIqBNVsZ1ZfugJC8itjBlpU93UY/B
         Gs3xqp8wJ73gf6B5bl7e1jrOYcuFgTnwaBAvu8s7kb3wylurhR+vbaKVq5cSERVxh2bq
         S7B3rbAz00NzWT4BcFrDZORqUyDZY6YqgaaYH2wQiFQMj3NxjMPvCVo2vXumhaKeJQiQ
         rbwrRBt6wlNwC96KL1tdDXKDb7JEBn7TcDBBllJMEfObGh81BVGpk/e38yDFqeBeguoZ
         UhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232225; x=1726837025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GW3d9XB2yvL3Rb81kUGiyxRHSm6TQz1BPOKouSAWkE=;
        b=oMlU61ZrroNbz+ypCmvHV4Lak6GQhWZoFu8xGzY7qfvym6r7eWF5I5qaDOZoJINug4
         7zyF1jwoVg1Gzeq/i6gSJoFLar1+Wg1v7ukM2m8r9xYDtm1b5L0KTvSSyfnvlhlIHmTx
         oEh7oK7MEzHxy88TbX3flKTNROfVKAt4Kyl9lu7p4ZraFkk1QWwZp39U4ljK0hca7HuL
         VhP+kHf6pg0fSKeIMhruMRc5kVAlWAjKkqYcF3ofJRCASrfjEcfbQQ03iAuyW0giLDwO
         jTNZviAfeVG+uufYA2oJ/fFr19txJB28XYKD+J40PyDnViJQFxOmoLg5S2q1JprX17YP
         W46g==
X-Gm-Message-State: AOJu0Yxyaou4VAmrkNT/AGGMl5U8my7onlm36fryiXOeFWpEnak3t752
	KU0ixkiTBOSHxTBx3w4oMakF0Yrga1KMGDZgpQ/US5YrlpNxuP167S0orXkemVU=
X-Google-Smtp-Source: AGHT+IH2KJfuTonzsyo/Sd1YERlzxE9cGr+D8Ohd+W3CmCb32/3paJvxaNSRxv2evMvRbEczbK1V4Q==
X-Received: by 2002:a05:690c:f91:b0:65f:77c3:63a0 with SMTP id 00721157ae682-6dbcc24eb37mr22834977b3.7.1726232225602;
        Fri, 13 Sep 2024 05:57:05 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ae09sm658425385a.49.2024.09.13.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:57:05 -0700 (PDT)
Date: Fri, 13 Sep 2024 08:56:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org, leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
Message-ID: <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>

On Fri, Sep 13, 2024 at 09:40:30AM +0300, Ilias Apalodimas wrote:
> Hi Gregory,
> 
> On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> >
> > If the log version is not sane (0 or >2), don't attempt to use
> > the rest of the log values for anything to avoid potential corruption.
> >
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/firmware/efi/tpm.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index 6e03eed0dc6f..9a080887a3e0 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
> >                 return -ENOMEM;
> >         }
> >
> > +       if (!log_tbl->version ||
> > +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> > +                      log_tbl->version);
> > +               early_memunmap(log_tbl, sizeof(*log_tbl));
> > +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > +               return -EINVAL;
> 
> I don't think we need this check at all. Did you actually see this happening?
> efi_retrieve_eventlog() that runs during the efistub tries to retrieve
> the log and the EFI protocol itself explicitly says that the firmware
> *must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
> 2.0 format. If the firmware does something wrong, we should report the
> FW BUG in that function, instead of installing the config tables Linux
> uses internally to handover the log and catching it late.
> 
> Thanks
> /Ilias
>

We saw this happen and discovered it was a disagreement between EFI/OS/kexec
causing the table to be overwritten during kexec.  We've since found a fix for
that.  So the result was that it appeared the firmware was doing something
wrong. The sanity check at least allowed us to boot without immediately
crashing - because the tables don't get reinstalled, they get re-used
(at least that's by best understanding of the whole interaction).

If the check seems superfluous, i can drop it.
 
> 
> 
> > +       }
> > +
> >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >         if (memblock_reserve(efi.tpm_log, tbl_size)) {
> >                 pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> > --
> > 2.43.0
> >

