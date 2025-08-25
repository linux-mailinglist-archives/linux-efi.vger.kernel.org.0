Return-Path: <linux-efi+bounces-4610-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7171B34EC9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C721B21115
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 22:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC427CB0A;
	Mon, 25 Aug 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyJjvZE6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C872BF3F4;
	Mon, 25 Aug 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159808; cv=none; b=XY8tAvI30OyOv+lBqocaWSkoeRY1nTU+Qe2FI+Fo22FW01O9DHelKOfO1LqeZXJqq6qAzzs3ypP/o0bvygqPEaQhdn33BbQVfG/mHIBTYgZKcYQoVSbVp9wNv8Cf9UOBK4gBoo6p4I9gnYjY9oBqSD0StuChr2s/UmHD2gJqD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159808; c=relaxed/simple;
	bh=EQPWAIR5scF1GloM4IebSw0mBJJJtcPToxHN5QzmsEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gn5PpAcxjALc3szZfN1Hc3DaCzPO8Q1bKGGKgxnf6inoMG+IEiIFq1brB2GABWRXDnHdVe8ppaY7xUCsIVQTR5euR5DE7xc495yrUynG20gJ97NiSPSa4ZLXeCVbqjI8cJJDdxVxlA+GWitMp1DGAkZIabLoOX3rJYiU9IGY81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyJjvZE6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336674f95e7so16977511fa.1;
        Mon, 25 Aug 2025 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756159803; x=1756764603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpHdHMoNqCjumRhUdx1Yp81epQoiSAXfa/6NExGgR38=;
        b=kyJjvZE6Zm3xADihiZswz2O/V4/YvgvDGoC06tAyOy6JSwlsIybJDwtnnuBKXPeY+z
         jp38DA2bGR8Er8vyFi7rOEJ8Lp0Jrv3UNDwvib3tvN+vX8UGMS/AZleYrcpMsvqcoru2
         7sxwsfosPM9LpjbVCBwFR6nQrrTrteMUrfqrqdpr5sEAPbzHKYIaKKSlLFKQaLA/4LLp
         UTSTYqwrGeERpe9gcr43syW5qkH1Hm0DhT9wDC63VfzKDTB0qkuonwjSpoQ7lpJban4z
         2UA97RJ0ULV/glQRYpfveo1AeI4yQkuCHFOaX98KiTWn4pCNnvb7wFld9+gzhb726MHP
         WrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756159803; x=1756764603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpHdHMoNqCjumRhUdx1Yp81epQoiSAXfa/6NExGgR38=;
        b=TYeFrC66kY1/OvRk0QHS4BLTifODMNNlaYQzr6cAKqjAxl7FtC87TcEPou2oIAlldq
         JPB1v0EvfFmqSlLShz6ImJSOTSua5vY7otBU4HpuUH6kMTbr+BO2z0uQ0GKayDiwhBix
         vURtdIMP6SA9n+eaWVanlnhXorB0wctHZxu6QrsvNDlw7vJH+soyiOnZ6K5HI9G9/bAA
         KrTstnL2pgNb9bFlB+QbCtzhHrwju59vi0veJGfFTkeeLnaCwA9DyVknMWBt0gOXWc6h
         5tvpk5AbnUr2bLI/3wCCDH+SgsmvRSUPfFPjh3hWfuJXa21IqXzsnH+MhoYJP5pP6+l6
         4qDA==
X-Forwarded-Encrypted: i=1; AJvYcCWP/IVJvfLtZsXn39SenKheOpFflDV/Qy+9z2tBGgXjbKxVPfx7Ct5mNDA4Ecqyy1BsmnuM61s0LaszkAy2@vger.kernel.org, AJvYcCX3lNjfnlto05NUGNhnYhEwQgLKmb10KqFJww0i1utal6h6DZ+Ly/PNCnv6GziFRKK3M+e8VsyNi3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDc+Ixrq0ZBWpFb8LSztZ4zSEUj/6UlkxGjEaR26UaxrngbHB
	9xzrRJtOiYC8iRdnrTQc/7is5RmDV6ngFqMTRM6y/r91ikqAiR2yM7DsF7n9xXNl8/xDMbiXIfX
	suFGX04n1qiyV2ceEFV9sFlnfCTKVfpCpJuXEAL9+0w==
X-Gm-Gg: ASbGncutwZ6pS4ktIQVj5ScLkxNiuRzih633e1jLtais1iT5OIGcQPElaJBpiZHaPTj
	WCyTk3Zf0AI3hOXjHqBYtNDTAHFrSmOxCUz3XufjJHpi1UinD4nyhv3O23A9NCJzU8qhqhFQ93b
	ztukTSqhG5NPW+/UJop7jt1c9GLV9iNh2s/xbOjQ8SnBdn3+IR49kqLFAGRwZUmMX0p/cCnmmaT
	2EdF/k=
X-Google-Smtp-Source: AGHT+IEVcIiPxVsqer02YksSA1mIMt0pA9rKJK825JdLlej7OOypQ5zbpNwEBEhYwBXmeNyzQG4Z85jnCSZKQlnGP0o=
X-Received: by 2002:a05:651c:2119:b0:336:6132:7002 with SMTP id
 38308e7fff4ca-336613274e1mr23731171fa.39.1756159802852; Mon, 25 Aug 2025
 15:10:02 -0700 (PDT)
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
 <CALHNRZ8YUVvQ--Y-EfXW04WYXiKNsj6KSs-OaLMcEnG3_xDMSg@mail.gmail.com> <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
In-Reply-To: <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 25 Aug 2025 17:09:51 -0500
X-Gm-Features: Ac12FXwdqKxI82qAULONWFI4vYLpLU-HIdDPATxpf9EP_1V9fUZqZ0fagwG46xw
Message-ID: <CALHNRZ_Q9XwJenTVDBdk4NQ79m2wWKRyxNS_sV1TLuqunE_NGQ@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 4:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wro=
te:
> > > >
> > > > On 24.08.25 02:31, Ard Biesheuvel wrote:
> > > > > On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
> > > > >>
> > > > >> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > > > >>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com=
> wrote:
> > > > >>>>
> > > > >>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Rela=
y
> > > > >>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > > >>>>>
> > > > >>>>> From: Aaron Kling <webgeek1234@gmail.com>
> > > > >>>>>
> > > > >>>>> Some uefi implementations will write the efistub logs to the =
display
> > > > >>>>> over a splash image. This is not desirable for debug and info=
 logs, so
> > > > >>>>> lower the default efi log level to exclude them.
> > > > >>>>>
> > > > >>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > >>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > >>>>> ---
> > > > >>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> > > > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >>>>>
> > > > >>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/=
firmware/efi/libstub/printk.c
> > > > >>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd=
746a9c54abbbe61a4bf70f1a8c4 100644
> > > > >>>>> --- a/drivers/firmware/efi/libstub/printk.c
> > > > >>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> > > > >>>>> @@ -5,13 +5,13 @@
> > > > >>>>>  #include <linux/ctype.h>
> > > > >>>>>  #include <linux/efi.h>
> > > > >>>>>  #include <linux/kernel.h>
> > > > >>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > > > >>>>> +#include <linux/kern_levels.h>
> > > > >>>>>  #include <asm/efi.h>
> > > > >>>>>  #include <asm/setup.h>
> > > > >>>>>
> > > > >>>>>  #include "efistub.h"
> > > > >>>>>
> > > > >>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > > > >>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> > > > >>>>>
> > > > >>>>>  /**
> > > > >>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the c=
onsole
> > > > >>>>>
> > > > >>>>> ---
> > > > >>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > > > >>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> > > > >>>>>
> > > > >>>>> Best regards,
> > > > >>>>> --
> > > > >>>>> Aaron Kling <webgeek1234@gmail.com>
> > > > >>>>
> > > > >>>> This patch was originally suggested a few months ago [0], but =
as far
> > > > >>>> as I can tell was never queued for merge. Since I'm also hitti=
ng a
> > > > >>>> case where this is relevant, I'm sending this in to bring atte=
ntion
> > > > >>>> back to it.
> > > > >>>>
> > > > >>>
> > > > >>> I've queued this up now - thanks.
> > > > >>>
> > > > >>
> > > > >> And how can I get back the loglevel info? It seems I can only ch=
oose
> > > > >> between notice, silent and debug now. And the latter two only by=
 also
> > > > >> touching the kernel's loglevel.
> > > > >>
> > > > >> I'm particularly missing [1] in my UART logs now which is helpfu=
l in
> > > > >> understanding this essential system state.
> > > > >>
> > > > >
> > > > > Hi Jan,
> > > > >
> > > > > Is efi=3Ddebug too noisy for you?
> > > >
> > > > Yes, also because it affects the kernel even more. I'm looking for
> > > > "efi=3Dinfo".
> > > >
> > > > I don't get the reason behind this change anymore as well. If you h=
ave a
> > > > splash screen shown, weren't you booting with "quiet" before alread=
y,
> > > > thus also without any stub messages?
> > > >
> > >
> > > Yeah, good point. IIRC that came up in the discussion but I can't
> > > remember the motivation so it can't have been very convincing.
> > >
> > > So should we just revert this change?
> >
> > I'd prefer not to have to set quiet to get a clean splash screen. That
> > doesn't seem like an unreasonable expectation, getting default
> > non-debug logs and not having stuff written on top of the splash
> > image.
>
> Perhaps you could remind us why this only applies to the efistub
> output, and having the output of the kernel itself corrupting the
> splash screen is fine?

I'm not greatly knowledgeable about the efi standard and what's
happening under the hood, so I will just speak to what I saw in my use
case. I'm working on Nvidia Tegra devices, newer generations of which
use EDK2 as the last stage bootloader. The target os is Android, which
has a pretty strictly controlled defconfig. Prior to this change, the
kernel efistub logs were getting passed to the efi impl, which was
then printing those lines to the display. The kernel logs were not
being printed to the screen, as none of the console drivers were
enabled to do so. So after this change, regardless of the kernel log
level, the boot splash will remain untouched until the kernel display
driver takes over the display and the os renders to it. Because no
efistub log lines are being printed.

Aaron

