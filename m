Return-Path: <linux-efi+bounces-4608-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B2B3477E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBEB2A0EEB
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFDD3002A9;
	Mon, 25 Aug 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5JkDkFD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2F16D4EF;
	Mon, 25 Aug 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139662; cv=none; b=MmzKE4QBZtp70pH/qretmznpwkY8YlbHnbhMiXcERgzeqVipD31Yih5aoepjSWE2BH5LboiOtJDAhb4zaywb1PcnRGTGM2fYwWChrnMTHvIdINR6ehPbl/ytQTARYWmktrz16r4tD7IO2d0uF6iHPbrNIUhSpoQa3sq/kplt9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139662; c=relaxed/simple;
	bh=94U6ajIYxrklW2x0PmIw/x2SBZ7JQKzGevtXNk/jnCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8CLRGbvaPazSugm4ZM7aKLqTG244me00Imkh2oFe4RhDarLYMJbqnhnWTFCNPk5ewbpCjoU76rmCdv4Uk3KDI6m8p/KjKl8lh4yFAfNnJDUUgiFtFa7c9BJtg+oWxHqVSFoppwWYY+o17QFFF+J2mdeqoWQvX+bD1eQTsm1Cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5JkDkFD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f3edab4c7so1894557e87.3;
        Mon, 25 Aug 2025 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756139657; x=1756744457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vgbgUGMnNsk0dEGtBJ3LPaIzcn2B6WaEImwizoF5Qo=;
        b=O5JkDkFDrDQlMnB9nh4EqMaTC5lhvMzPs2FbQLYQmZvo4Imz2sWdHTOn7ha/kfXYoQ
         Z52L89NOq2nV7xC0rY8Yp0pSPl//hSxxG36i5zzdTeP2sxNdBvhGpd+FxdKhvANOS9lV
         lRk83C5seuCVsEyEyQFIQ+pmimeDzrjiAHWUervjE6S+vYWbQZdVpeiq7QVtgTvN0slc
         D92ckLesEbbz50CVHEpg0dPLXnrtsYymPIE+Ppju0ElMe4n2ibJ+pY+8/W7ERUOier2R
         6HtUEdO/0qTsqypeH8s58ASQ22zV5MEGluBc173X5/ZeUmfSduVsk+zfhaoG/aS8WNTQ
         LYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139657; x=1756744457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vgbgUGMnNsk0dEGtBJ3LPaIzcn2B6WaEImwizoF5Qo=;
        b=UAp1yjajA5TFfG3lNXRfIoUFSvLLJNqUnr5mmR/+0Hxs8PB5j9avXmTdh7lQsXiPRT
         A6EIBn1HUaH3pQBgiglWcJZi3G9WSd4mZ91cMat5/AAaRYACf+kMX4slO1H9f2tNELJk
         0LGl1PftFiO54QF/tEY6+ey+/T9vyQV2SkGIWcCeoUVrSr0bt4KhGWDgUdedR8VBfUlN
         sDzsF4ER+ppcKpuS7FIvm55H66yEqHJEDqJP/XBH5uM19UtNWexR3jXHtmIvNwxopTH3
         odz8DvF66CUPIB3nmR3i+1xGbPom9W6Oq05qJUeMew54pgF001JBAvSN2IlYwYjS85nZ
         Xp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8jiQiwSE9hcTUnNfNWXVFCl36p2SDB5MIBpiOnOFbsflJry5yvqc9BsTPbadYU9PcOBrPt/MIV7o6MxO2@vger.kernel.org, AJvYcCWp8pUK1ib0X8bw6aEajbgi3wv1R44pc4JV0ZWYVKdUypnGac6vk7PHRLGY93JEmuyq9+CmzIRl/8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VC7ougl2UEnftyXUitNbjOObX0A3+QWkkePLRrxRUWE7n4GA
	cbib40ER3zpNrDd1i1HZHHNTrdbtm+3I6OvYHbOJ8b3daBGxPw6T9jWD0xESsjEikM2H4ncnKtK
	FSiTl7NhLALjZGgi9puiTJmg2kvkanwQ=
X-Gm-Gg: ASbGnctzIAaPAuiSFTErfUEk7hCRNXM9qFdADXLKRqq8MmPbp9+KfLFPJ8GuWngtqGW
	afePvN+EbdfqI+WzK4j2hgUCERSxfXA2kAN8K7++jsf+OqKubNcrUizctntNjikCz5xdcTIN7l+
	4y/NG/WwUtqDrqnB4pkdsTpFCkBOPmgVFOvsI7CVBXd8PCIhxrTIeEeOuqDm5jsCIJV4ic8BayO
	8Gvzio=
X-Google-Smtp-Source: AGHT+IEFXnyRhsBx9+alG1ybJuBC4q08yIJ03vy5AyC8reSa97lD75BzANWN7yvFYstk16O+nxu4CD4wnxCdtW6fbyM=
X-Received: by 2002:a05:6512:448b:b0:55c:d751:fc77 with SMTP id
 2adb3069b0e04-55f0d3bee4bmr3343531e87.44.1756139657233; Mon, 25 Aug 2025
 09:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
 <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
 <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
 <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com> <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
 <09cb03e4-21f3-418c-98f2-66004cc3080f@siemens.com> <CAMj1kXHyw3Oi=c3p+7q75vD4iJ+x642JzL7zHM4jpF4k937Uxg@mail.gmail.com>
In-Reply-To: <CAMj1kXHyw3Oi=c3p+7q75vD4iJ+x642JzL7zHM4jpF4k937Uxg@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 25 Aug 2025 11:34:05 -0500
X-Gm-Features: Ac12FXzqclaOeIA1gceJYpCLDylX9r92xxuvyQuzQVS_-jIZVp2R0ytA_JmHOz0
Message-ID: <CALHNRZ8YUVvQ--Y-EfXW04WYXiKNsj6KSs-OaLMcEnG3_xDMSg@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 24.08.25 02:31, Ard Biesheuvel wrote:
> > > On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> wro=
te:
> > >>
> > >> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > >>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wr=
ote:
> > >>>>
> > >>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> > >>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >>>>>
> > >>>>> From: Aaron Kling <webgeek1234@gmail.com>
> > >>>>>
> > >>>>> Some uefi implementations will write the efistub logs to the disp=
lay
> > >>>>> over a splash image. This is not desirable for debug and info log=
s, so
> > >>>>> lower the default efi log level to exclude them.
> > >>>>>
> > >>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > >>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > >>>>> ---
> > >>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firm=
ware/efi/libstub/printk.c
> > >>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a=
9c54abbbe61a4bf70f1a8c4 100644
> > >>>>> --- a/drivers/firmware/efi/libstub/printk.c
> > >>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> > >>>>> @@ -5,13 +5,13 @@
> > >>>>>  #include <linux/ctype.h>
> > >>>>>  #include <linux/efi.h>
> > >>>>>  #include <linux/kernel.h>
> > >>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > >>>>> +#include <linux/kern_levels.h>
> > >>>>>  #include <asm/efi.h>
> > >>>>>  #include <asm/setup.h>
> > >>>>>
> > >>>>>  #include "efistub.h"
> > >>>>>
> > >>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > >>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> > >>>>>
> > >>>>>  /**
> > >>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the conso=
le
> > >>>>>
> > >>>>> ---
> > >>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > >>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> > >>>>>
> > >>>>> Best regards,
> > >>>>> --
> > >>>>> Aaron Kling <webgeek1234@gmail.com>
> > >>>>
> > >>>> This patch was originally suggested a few months ago [0], but as f=
ar
> > >>>> as I can tell was never queued for merge. Since I'm also hitting a
> > >>>> case where this is relevant, I'm sending this in to bring attentio=
n
> > >>>> back to it.
> > >>>>
> > >>>
> > >>> I've queued this up now - thanks.
> > >>>
> > >>
> > >> And how can I get back the loglevel info? It seems I can only choose
> > >> between notice, silent and debug now. And the latter two only by als=
o
> > >> touching the kernel's loglevel.
> > >>
> > >> I'm particularly missing [1] in my UART logs now which is helpful in
> > >> understanding this essential system state.
> > >>
> > >
> > > Hi Jan,
> > >
> > > Is efi=3Ddebug too noisy for you?
> >
> > Yes, also because it affects the kernel even more. I'm looking for
> > "efi=3Dinfo".
> >
> > I don't get the reason behind this change anymore as well. If you have =
a
> > splash screen shown, weren't you booting with "quiet" before already,
> > thus also without any stub messages?
> >
>
> Yeah, good point. IIRC that came up in the discussion but I can't
> remember the motivation so it can't have been very convincing.
>
> So should we just revert this change?

I'd prefer not to have to set quiet to get a clean splash screen. That
doesn't seem like an unreasonable expectation, getting default
non-debug logs and not having stuff written on top of the splash
image. But if this needs to be reverted, It would be nice to have an
option like the original patch which allowed setting the efi loglevel
separately. Or perhaps leave this as is and add the option to turn up
the efi loglevel independently.

Aaron

