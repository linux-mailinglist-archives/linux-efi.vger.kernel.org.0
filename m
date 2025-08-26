Return-Path: <linux-efi+bounces-4617-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B84B37079
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A18E0700
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354E30FC2B;
	Tue, 26 Aug 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPiUh1RD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B834F47D;
	Tue, 26 Aug 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226079; cv=none; b=MqQBC6TrHpUNIURpgrbimw2EsvsyJgG6Dau01KjyyNuwWvC8StjINcGpyiU7Af9lr9ahj7688w0VNWB1XnROD2/Aq+vA8nIKZ19Qieajz9PYd06vtGqgwpR4lNMiRA1eI/juiPmgn4o7RmnOUu2mbm9CVAHom+cuBy8JqAC+lKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226079; c=relaxed/simple;
	bh=xMVI5V3rKT3fGVSefU1LuwSlQitadfboKFyT1slF4wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXOLrqGWLU9mxCUOsd9ko8b0oFMZvRWRl05wIDcMe0d1VMsyzJdP48pRcTewhvIboVgcgJEDaLQtShIFRaud072vDuHXDwGLx/sw8OGZDt9Ionx/e1CG7bCBuQ6ohS0vqTdJpQCxYF+Ns/AkcBUqI21yErjAlDo3x3JTBRT70KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPiUh1RD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f39fc7967so2997925e87.1;
        Tue, 26 Aug 2025 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226074; x=1756830874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1hBrtIW3hGCbr4UlSnjeGexnWAsPob/PvCTNZpOgzw=;
        b=TPiUh1RDc99lAaVh0G25u1QJYd4eBOy2Zu7CwWrAnE9890Myh68wngSfaUtqWLbie3
         fe3XbwBeJOAdODbu31SFc117/MhuuuvonmNii5bh5HEVedqND1a6S/qwQINLYBWHEDtm
         OBzy1IPMWjiAgOwTHmjl4P4/QKplQvxnAcLla1fppMZYx3zO9oIwk/pzM1Vh8aMh10/r
         U/jHjQxiCW+E1/tiAIiA68kD8yr7/2JHrMoFvfUJUOFjF46OLTkhRBx7Rf0Flh6AKUeU
         ngyLAIRV3RNqej7QX9Q2F/Z5YJt3J0nUHMUTqJim1+2ajjpTpVNv+NYVJLpAYiIzyA8q
         ++dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226074; x=1756830874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1hBrtIW3hGCbr4UlSnjeGexnWAsPob/PvCTNZpOgzw=;
        b=hFRkh1HpP/JqM3G51W9mkZFzy0TDRkEJjp3X5i8+s0AiH4fSITjfIWZxF1GhsX0TR5
         EZaPskNQsXVe6HQg92OkD1QlGsUO3H2uxlWsYpUJBJz/2H2FbOtSwtHfGai9QsIZUisG
         QYNiLT70ChvrhbTvsTPt1NpZlThKoPhPsepiCqUXxKT0unQnJOv7d0dPFYJ44ew1SpjO
         Ejas0y0Qt9g9ZhLcBsPpP/u9arL4TQrx0XohS3zVYtrZd330ex5iq7257+p5K7Wa/B5y
         fVef+iscKk+JYqKj03evIAOnst1xSmbBA4Rfz2OgP8F5IJfYeJJheEd3fx4AcpvFcvsb
         MLUg==
X-Forwarded-Encrypted: i=1; AJvYcCVGjEibQ4UaPFXB/vrBcE29PFAy/BNtPYCbgMfawOigdc3HPfTiLnFW9Q3ESRDloXrP4TNJbdF4LZA=@vger.kernel.org, AJvYcCWfJKvHnlfmSfkh2S+subRPKGpp5gWcQfjVhR+r0fYqaDxOhfXGzhVjOjISJO0sK6jfs1ZqPyywUHKwCSdi@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbgYDp71ZopVveGDdEWVDFkbMhvWoYJ17b37qfLySDzKUUheG
	S611b//+KqhwjMKL38nxzyMAYZnuxygMQBWoGYbvfwVL89kYJXgQuTUGSW2zAn6GRrXKmH0syIy
	Swe4CQPhPVEXGT1mjWg+IU1RTODl0f7g=
X-Gm-Gg: ASbGnctfgE2BcP9erK+aF4If726RMXUrRKbi7HSvMTJMY0SP35juGSFrmzuA24XIKAt
	66tUu1zyuxQSYrlU/WPYRp7CRtH5ahxbGS3e8D5tWzJYlZ8EBZtk6ZFL1GnsPMy2LqDZ+gWwJzN
	jP7qswGf39X3FwWszRGqdz+r/+v0i+dmWJnx97s+JJNPLMpPe1cE/I2R09UhGiKTLEproyLc93v
	x+L1t4ZU7bojHYCqQ==
X-Google-Smtp-Source: AGHT+IGFg/aVxYAOM3AMKrAHLdQD2NtRNEqtHC495VKYnCKu7sznix/1p8WoGb54DuECWhIuS/YMTUp8uKNGbvQ2wCQ=
X-Received: by 2002:a05:6512:ac1:b0:55c:c937:1115 with SMTP id
 2adb3069b0e04-55f0cd6f1afmr5967202e87.19.1756226073912; Tue, 26 Aug 2025
 09:34:33 -0700 (PDT)
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
 <CALHNRZ8YUVvQ--Y-EfXW04WYXiKNsj6KSs-OaLMcEnG3_xDMSg@mail.gmail.com>
 <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
 <CALHNRZ_Q9XwJenTVDBdk4NQ79m2wWKRyxNS_sV1TLuqunE_NGQ@mail.gmail.com>
 <2b7e98a3-dc77-4eb3-beba-3bea7febb715@siemens.com> <CAMj1kXGeGG6hCCNKhSxPJppkTzBeZg9jO0py1P8xfi2N3S=vyQ@mail.gmail.com>
 <CAMj1kXF53U8DUmt8tN75ZYkkQc8wLOcns1eEzNFo=a7F02h3Kg@mail.gmail.com>
In-Reply-To: <CAMj1kXF53U8DUmt8tN75ZYkkQc8wLOcns1eEzNFo=a7F02h3Kg@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 26 Aug 2025 11:34:22 -0500
X-Gm-Features: Ac12FXz6PH3eUrbsR4BsciSdybGnmImGmqU4VO8fZd3QVPL6RaFjsoyibR7mhds
Message-ID: <CALHNRZ8DJNAd=TrehuoydCad=iDKwUZ3xgEZC1f0+yLHWi3HAQ@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:43=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 26 Aug 2025 at 10:16, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 26 Aug 2025 at 09:23, Jan Kiszka <jan.kiszka@siemens.com> wrote=
:
> > >
> > > On 26.08.25 00:09, Aaron Kling wrote:
> > > > On Mon, Aug 25, 2025 at 4:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > >>
> > > >> On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> =
wrote:
> > > >>>
> > > >>> On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kern=
el.org> wrote:
> > > >>>>
> > > >>>> On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> > > >>>>>
> > > >>>>> On 24.08.25 02:31, Ard Biesheuvel wrote:
> > > >>>>>> On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.c=
om> wrote:
> > > >>>>>>>
> > > >>>>>>> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > > >>>>>>>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.=
com> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 R=
elay
> > > >>>>>>>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > >>>>>>>>>>
> > > >>>>>>>>>> From: Aaron Kling <webgeek1234@gmail.com>
> > > >>>>>>>>>>
> > > >>>>>>>>>> Some uefi implementations will write the efistub logs to t=
he display
> > > >>>>>>>>>> over a splash image. This is not desirable for debug and i=
nfo logs, so
> > > >>>>>>>>>> lower the default efi log level to exclude them.
> > > >>>>>>>>>>
> > > >>>>>>>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > >>>>>>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > >>>>>>>>>> ---
> > > >>>>>>>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> > > >>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>>>>>>>>>
> > > >>>>>>>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drive=
rs/firmware/efi/libstub/printk.c
> > > >>>>>>>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c0=
5dd746a9c54abbbe61a4bf70f1a8c4 100644
> > > >>>>>>>>>> --- a/drivers/firmware/efi/libstub/printk.c
> > > >>>>>>>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> > > >>>>>>>>>> @@ -5,13 +5,13 @@
> > > >>>>>>>>>>  #include <linux/ctype.h>
> > > >>>>>>>>>>  #include <linux/efi.h>
> > > >>>>>>>>>>  #include <linux/kernel.h>
> > > >>>>>>>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > > >>>>>>>>>> +#include <linux/kern_levels.h>
> > > >>>>>>>>>>  #include <asm/efi.h>
> > > >>>>>>>>>>  #include <asm/setup.h>
> > > >>>>>>>>>>
> > > >>>>>>>>>>  #include "efistub.h"
> > > >>>>>>>>>>
> > > >>>>>>>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > > >>>>>>>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> > > >>>>>>>>>>
> > > >>>>>>>>>>  /**
> > > >>>>>>>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to th=
e console
> > > >>>>>>>>>>
> > > >>>>>>>>>> ---
> > > >>>>>>>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > > >>>>>>>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> > > >>>>>>>>>>
> > > >>>>>>>>>> Best regards,
> > > >>>>>>>>>> --
> > > >>>>>>>>>> Aaron Kling <webgeek1234@gmail.com>
> > > >>>>>>>>>
> > > >>>>>>>>> This patch was originally suggested a few months ago [0], b=
ut as far
> > > >>>>>>>>> as I can tell was never queued for merge. Since I'm also hi=
tting a
> > > >>>>>>>>> case where this is relevant, I'm sending this in to bring a=
ttention
> > > >>>>>>>>> back to it.
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> I've queued this up now - thanks.
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>> And how can I get back the loglevel info? It seems I can only=
 choose
> > > >>>>>>> between notice, silent and debug now. And the latter two only=
 by also
> > > >>>>>>> touching the kernel's loglevel.
> > > >>>>>>>
> > > >>>>>>> I'm particularly missing [1] in my UART logs now which is hel=
pful in
> > > >>>>>>> understanding this essential system state.
> > > >>>>>>>
> > > >>>>>>
> > > >>>>>> Hi Jan,
> > > >>>>>>
> > > >>>>>> Is efi=3Ddebug too noisy for you?
> > > >>>>>
> > > >>>>> Yes, also because it affects the kernel even more. I'm looking =
for
> > > >>>>> "efi=3Dinfo".
> > > >>>>>
> > > >>>>> I don't get the reason behind this change anymore as well. If y=
ou have a
> > > >>>>> splash screen shown, weren't you booting with "quiet" before al=
ready,
> > > >>>>> thus also without any stub messages?
> > > >>>>>
> > > >>>>
> > > >>>> Yeah, good point. IIRC that came up in the discussion but I can'=
t
> > > >>>> remember the motivation so it can't have been very convincing.
> > > >>>>
> > > >>>> So should we just revert this change?
> > > >>>
> > > >>> I'd prefer not to have to set quiet to get a clean splash screen.=
 That
> > > >>> doesn't seem like an unreasonable expectation, getting default
> > > >>> non-debug logs and not having stuff written on top of the splash
> > > >>> image.
> > > >>
> > > >> Perhaps you could remind us why this only applies to the efistub
> > > >> output, and having the output of the kernel itself corrupting the
> > > >> splash screen is fine?
> > > >
> > > > I'm not greatly knowledgeable about the efi standard and what's
> > > > happening under the hood, so I will just speak to what I saw in my =
use
> > > > case. I'm working on Nvidia Tegra devices, newer generations of whi=
ch
> > > > use EDK2 as the last stage bootloader. The target os is Android, wh=
ich
> > > > has a pretty strictly controlled defconfig. Prior to this change, t=
he
> > > > kernel efistub logs were getting passed to the efi impl, which was
> > > > then printing those lines to the display. The kernel logs were not
> > > > being printed to the screen, as none of the console drivers were
> > > > enabled to do so. So after this change, regardless of the kernel lo=
g
> > > > level, the boot splash will remain untouched until the kernel displ=
ay
> > > > driver takes over the display and the os renders to it. Because no
> > > > efistub log lines are being printed.
> > > >
> > >
> > > That makes sense now, and surely don't mind having some build-time or
> > > runtime configuration switch that allow to tune the system into such
> > > settings. It's just not so nice to take away the freedom of full-scal=
e
> > > loglevel control from the efistub.
> > >
> >
> > Yeah, that would be my fault, I guess. I suggested simplifying this to
> > the current approach.
> >
> > Would it be sufficient to make the EFI stub loglevel a separate
> > compile time Kconfig option? I'd prefer that over adding more runtime
> > logic.
>
> Would the below work for you Aaron?
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index eb1bff6968a5..f7552f36ab51 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -72,6 +72,11 @@ config EFI_RUNTIME_WRAPPERS
>  config EFI_GENERIC_STUB
>         bool
>
> +config EFI_STUB_LOGLEVEL
> +       int "Loglevel for the EFI stub console"
> +       range 1 15
> +       default CONSOLE_LOGLEVEL_DEFAULT
> +
>  config EFI_ZBOOT
>         bool "Enable the generic EFI decompressor"
>         depends on EFI_GENERIC_STUB && !ARM
> diff --git a/drivers/firmware/efi/libstub/printk.c
> b/drivers/firmware/efi/libstub/printk.c
> index bc599212c05d..782d1330c1cc 100644
> --- a/drivers/firmware/efi/libstub/printk.c
> +++ b/drivers/firmware/efi/libstub/printk.c
> @@ -5,13 +5,12 @@
>  #include <linux/ctype.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> -#include <linux/kern_levels.h>
>  #include <asm/efi.h>
>  #include <asm/setup.h>
>
>  #include "efistub.h"
>
> -int efi_loglevel =3D LOGLEVEL_NOTICE;
> +int efi_loglevel =3D CONFIG_EFI_STUB_LOGLEVEL;
>
>  /**
>   * efi_char16_puts() - Write a UCS-2 encoded string to the console

The only issue for me is that the Android defconfig is set by Google.
Specific devices build kernel modules in a device specific manner, but
the core kernel is fixed. And since efistub is =3Dy, that means vendors
and third party projects like me cannot change this as a build time
config. This works for me only if I can convince Google to set the log
level lower in their defconfig. If this is what you wish to do, I can
suggest such a change to aosp once they fork the next lts.

Aaron

