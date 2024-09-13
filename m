Return-Path: <linux-efi+bounces-1738-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E4978177
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA791C2213B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0441DC072;
	Fri, 13 Sep 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fefwtt5c"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DC1DC06E;
	Fri, 13 Sep 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235236; cv=none; b=p5hhi02nM4BvIO/4HRpsYrsA8tleeNhceU7HXpO86F3jjXHdZ+c8cCwHwT62ideY70YLFUA/FX8q/z5cZKQLKSYKdsjKCT+SpS+wocPY/YkUTS5rQe9nlJErA1ojZupKBQyTrDqC829Gq8qzGGmc+p7y5Eovs/p7Tob+jeLpNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235236; c=relaxed/simple;
	bh=Qx2wKRO005WJPfohhNN56W659aDK+rFiujL2cLPoGuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeS/fDVzMqqq9oCIlh22WnvSGy0wtBKKDL/E530NPJi1hqlq7vaSYNlCN+jrwnM8gIYfLRl4w28BtdH52wgqD0bUcchRo1fy0DvQ8MVCD9xSO41tJbhrCVV0TaZVplM1IxwsleE7wQOGx6F/dEds2JGA5UMVhspmY+6SKQ52csA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fefwtt5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06850C4CECF;
	Fri, 13 Sep 2024 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235236;
	bh=Qx2wKRO005WJPfohhNN56W659aDK+rFiujL2cLPoGuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fefwtt5cjMtVvCeAwWZf6DQ980qoLRs4VJi6c+mjFszRKTN8Yy9sFeHL4/XbR/rT+
	 eLrfPCZJwEi2KywNWnxWrwsbf6EcudEoKeqCE5kOPyxh3Rk5X4LhU4Z2KL9TEue8UK
	 UMC5WRVieK4i0A/SlG/xZuHZab18uiobrZsphQohyLlkL8jRHx8tawbuXLO+6vN9Iq
	 CDzl1TOclQs64XyraVWnHaNwqhDcpW4fCmRwtLO0kqP8w/4zCw0F/4L57eNyWQbw5U
	 UkoYLke9k63sgol5vD1XB/K2NMoCQO7BQqApbA126KJ7YOF/XRytzXydDdUZk+FAFf
	 Y/OekZLQOhclw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so10924801fa.0;
        Fri, 13 Sep 2024 06:47:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEqji4/VhgRVWggCyIsZO0dHP64iWw+/mLkjAggKLtbqwwpkve2wOt57Kt7TTFk7Gpi8x/OjYDhao=@vger.kernel.org, AJvYcCUSIW+SRVsluUzvXCZ8dMfS9UAmmDki7yhfbGmUlh9SAr9gD8jJIJpDamy0qSf67y+NxL0x8zqHFyurFSJL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw27dbe+VE5bfedGJIxwAKTSEJsJfUX0Fs2FzRXNaQ8VRlxZ8v
	D11UQrJdEuYt/u6yVjGCHcuHM9Q+s8LeeJlC7g+w4hDewrm5+BqIe5PPU4u9gKOV4z5MMbRCnge
	ZUtp1FazNiNSlhARdOktV7ByaVI0=
X-Google-Smtp-Source: AGHT+IEEwoet004htwpS+qvqkRimB6EKHWyh8OdAQW7sf8+CVdnHpMFZHHBIx4aZh7qOdM6AB6T4DlIHAHCIKf38eXo=
X-Received: by 2002:a2e:b8d5:0:b0:2f7:90b9:7534 with SMTP id
 38308e7fff4ca-2f7919076aemr19343621fa.11.1726235234294; Fri, 13 Sep 2024
 06:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
 <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com> <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
 <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
In-Reply-To: <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 15:47:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>
Message-ID: <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Gregory Price <gourry@gourry.net>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 15:44, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Sept 2024 at 15:39, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 13 Sept 2024 at 15:57, Gregory Price <gourry@gourry.net> wrote:
> > >
> > > On Fri, Sep 13, 2024 at 09:40:30AM +0300, Ilias Apalodimas wrote:
> > > > Hi Gregory,
> > > >
> > > > On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
> > > > >
> > > > > If the log version is not sane (0 or >2), don't attempt to use
> > > > > the rest of the log values for anything to avoid potential corruption.
> > > > >
> > > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > > ---
> > > > >  drivers/firmware/efi/tpm.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > > > > index 6e03eed0dc6f..9a080887a3e0 100644
> > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > @@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
> > > > >                 return -ENOMEM;
> > > > >         }
> > > > >
> > > > > +       if (!log_tbl->version ||
> > > > > +           log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> > > > > +               pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
> > > > > +                      log_tbl->version);
> > > > > +               early_memunmap(log_tbl, sizeof(*log_tbl));
> > > > > +               efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > > > > +               return -EINVAL;
> > > >
> > > > I don't think we need this check at all. Did you actually see this happening?
> > > > efi_retrieve_eventlog() that runs during the efistub tries to retrieve
> > > > the log and the EFI protocol itself explicitly says that the firmware
> > > > *must* return EFI_INVALID_PARAMETER if the event log is not in 1.2 or
> > > > 2.0 format. If the firmware does something wrong, we should report the
> > > > FW BUG in that function, instead of installing the config tables Linux
> > > > uses internally to handover the log and catching it late.
> > > >
> > > > Thanks
> > > > /Ilias
> > > >
> > >
> > > We saw this happen and discovered it was a disagreement between EFI/OS/kexec
> > > causing the table to be overwritten during kexec.  We've since found a fix for
> > > that.  So the result was that it appeared the firmware was doing something
> > > wrong. The sanity check at least allowed us to boot without immediately
> > > crashing - because the tables don't get reinstalled, they get re-used
> > > (at least that's by best understanding of the whole interaction).
> > >
> > > If the check seems superfluous, i can drop it.
> >
> > Ok, that explains why it wasn't caught earlier at least. I would
> > prefer dropping it tbh, but I am going to defer to Ard for that.
> >
> > If we agree that this needs to go in btw, I think you should refactor
> > it a bit. That function already defines an out: label, which unmaps
> > memory. So you can rewrite the above as
> >
> > If(....) {
> >     ret = -EINVAL;
> >     efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> >    goto out;
> > }
> >
>
> Validating a table that was created by the EFI stub seems redundant.
> If the version check needs to be tightened, please do so in
> efi_retrieve_tcg2_eventlog() (in the stub).

... and actually, this version is set by the EFI stub based on which
flavor of the TCG protocols it found.

So i don't think we need this check to begin with.

If we need to detect corruption of these tables, I'd prefer to add a
checksum or something like that. But I don't think we should bother.

