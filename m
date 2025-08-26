Return-Path: <linux-efi+bounces-4612-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFAB35686
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EB03B44A1
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812C2D3A85;
	Tue, 26 Aug 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHK/PL9G"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11377285404;
	Tue, 26 Aug 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196218; cv=none; b=LEMoT8pwcItFAzATgqYWieKd5irjQSPbLZ4mZf5gLzcgSTS6Yz41sZrUkZqobnUIkXwJA2ck3GL75wmbAowHud7MEeUZxgiaCQQ8uRH9JIYHYL0n6XZne+ymJ81w1y5Y1lultM/vlgzMb+PXDqRnJo1M8K/xs11WGj2/Xaz5wY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196218; c=relaxed/simple;
	bh=7FUxW9fktk2/qvaM7hLvRUyvceCRBBXHQaXJTD5jfKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGObR2EDKj2hB0AO1LmME1kEJr55lvhRZGqwK6k/DgxVAsTuLwFpfO4uompQDCymq4JjQ6N/kD2lc0D23xsZqSXpd2Zks3ndEpXLvLWnTvVC4ZOxj69UHbAsfYQ1avTAFh1CrU4r4PgSXinSir2zbdW67M1TWgSr0RzbRm91tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHK/PL9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A705EC116C6;
	Tue, 26 Aug 2025 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196217;
	bh=7FUxW9fktk2/qvaM7hLvRUyvceCRBBXHQaXJTD5jfKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vHK/PL9Gq2ruAdRZVjMnbe5aLAn3ofWFx/TvtxjRqeOIqntD3MxCL5UD9MBcuneuo
	 m2ahuHEIivRVieNB5wUdCL3AdQlIvN0J+hhJ5meF/2XlrSn/P1r2Q5q885gNJd6xHr
	 N84Hoo3Hu1HKCyXQdG9K3iZOE8GsXVlZk6QRY8rXFrwhwRzCDkh9lZPIntRTzM2QzT
	 SkMOIJVT/9AXmRHU/xuQ5PgaNFi6l6aTfeMxfce2wmYieYiywZHmMiWKR5o76Mwgy2
	 fA1VP+ZDDszk8pqi5lWIbUx3iZamaLiTKu/yYoyNDsV+H7xOwn+VCFg4g/gK6oLnXk
	 iKepgxdA/IxNQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f4969c95aso1440664e87.0;
        Tue, 26 Aug 2025 01:16:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeMSoqBSRCzA51uO80G/Ja3UdfsnxaRvtSz+Q8MCkNYq0N7Tr/S3DLwocLed1JQyM0uihV4+GQUbJDJmcp@vger.kernel.org, AJvYcCUwBb8ymF97GeK6+b+dtImj0a0y3v4zolNdCq5mH3MqK+JhkCst+xgV/NnUE1qw4c0QK6tGYO8HvQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lvSsymleaY0qXRSLA3Qj07/FofZtKwX/2gnIE1icAQE974Lr
	bAhhzPfaJYkf9hqCPh2tvJIeIUyf5m1rG+AztJCCDR8uVXPXpmMdhWJi7Ug7bpbS4JizBU0YyhH
	jV3pc0ebHfsNfK5fuVheFnw/dbDqhn0E=
X-Google-Smtp-Source: AGHT+IHZcsziz2OQi7iE6xi8xnVcdTBZ2Bp5pRG8eXRhAligKMbh9E1wd7s+Swbme+0i9FSC434NVV0EJiPi/hJTLqk=
X-Received: by 2002:a05:6512:2903:b0:55f:48d6:1cfc with SMTP id
 2adb3069b0e04-55f48d61ee3mr1471517e87.3.1756196216010; Tue, 26 Aug 2025
 01:16:56 -0700 (PDT)
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
 <CALHNRZ_Q9XwJenTVDBdk4NQ79m2wWKRyxNS_sV1TLuqunE_NGQ@mail.gmail.com> <2b7e98a3-dc77-4eb3-beba-3bea7febb715@siemens.com>
In-Reply-To: <2b7e98a3-dc77-4eb3-beba-3bea7febb715@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 10:16:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGeGG6hCCNKhSxPJppkTzBeZg9jO0py1P8xfi2N3S=vyQ@mail.gmail.com>
X-Gm-Features: Ac12FXyv4oRRFM3i-z0i698E2Ax6uhVoSMeXM0ttfTXxekyUYvy5X36a_xTj33Y
Message-ID: <CAMj1kXGeGG6hCCNKhSxPJppkTzBeZg9jO0py1P8xfi2N3S=vyQ@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Aaron Kling <webgeek1234@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 09:23, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 26.08.25 00:09, Aaron Kling wrote:
> > On Mon, Aug 25, 2025 at 4:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>
> >> On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> wrot=
e:
> >>>
> >>> On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> >>>>
> >>>> On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wr=
ote:
> >>>>>
> >>>>> On 24.08.25 02:31, Ard Biesheuvel wrote:
> >>>>>> On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> >>>>>>>
> >>>>>>> On 15.07.25 03:35, Ard Biesheuvel wrote:
> >>>>>>>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com>=
 wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> >>>>>>>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>>>>>>>>
> >>>>>>>>>> Some uefi implementations will write the efistub logs to the d=
isplay
> >>>>>>>>>> over a splash image. This is not desirable for debug and info =
logs, so
> >>>>>>>>>> lower the default efi log level to exclude them.
> >>>>>>>>>>
> >>>>>>>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>>>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> >>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/f=
irmware/efi/libstub/printk.c
> >>>>>>>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd7=
46a9c54abbbe61a4bf70f1a8c4 100644
> >>>>>>>>>> --- a/drivers/firmware/efi/libstub/printk.c
> >>>>>>>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> >>>>>>>>>> @@ -5,13 +5,13 @@
> >>>>>>>>>>  #include <linux/ctype.h>
> >>>>>>>>>>  #include <linux/efi.h>
> >>>>>>>>>>  #include <linux/kernel.h>
> >>>>>>>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> >>>>>>>>>> +#include <linux/kern_levels.h>
> >>>>>>>>>>  #include <asm/efi.h>
> >>>>>>>>>>  #include <asm/setup.h>
> >>>>>>>>>>
> >>>>>>>>>>  #include "efistub.h"
> >>>>>>>>>>
> >>>>>>>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> >>>>>>>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> >>>>>>>>>>
> >>>>>>>>>>  /**
> >>>>>>>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the co=
nsole
> >>>>>>>>>>
> >>>>>>>>>> ---
> >>>>>>>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> >>>>>>>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> >>>>>>>>>>
> >>>>>>>>>> Best regards,
> >>>>>>>>>> --
> >>>>>>>>>> Aaron Kling <webgeek1234@gmail.com>
> >>>>>>>>>
> >>>>>>>>> This patch was originally suggested a few months ago [0], but a=
s far
> >>>>>>>>> as I can tell was never queued for merge. Since I'm also hittin=
g a
> >>>>>>>>> case where this is relevant, I'm sending this in to bring atten=
tion
> >>>>>>>>> back to it.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I've queued this up now - thanks.
> >>>>>>>>
> >>>>>>>
> >>>>>>> And how can I get back the loglevel info? It seems I can only cho=
ose
> >>>>>>> between notice, silent and debug now. And the latter two only by =
also
> >>>>>>> touching the kernel's loglevel.
> >>>>>>>
> >>>>>>> I'm particularly missing [1] in my UART logs now which is helpful=
 in
> >>>>>>> understanding this essential system state.
> >>>>>>>
> >>>>>>
> >>>>>> Hi Jan,
> >>>>>>
> >>>>>> Is efi=3Ddebug too noisy for you?
> >>>>>
> >>>>> Yes, also because it affects the kernel even more. I'm looking for
> >>>>> "efi=3Dinfo".
> >>>>>
> >>>>> I don't get the reason behind this change anymore as well. If you h=
ave a
> >>>>> splash screen shown, weren't you booting with "quiet" before alread=
y,
> >>>>> thus also without any stub messages?
> >>>>>
> >>>>
> >>>> Yeah, good point. IIRC that came up in the discussion but I can't
> >>>> remember the motivation so it can't have been very convincing.
> >>>>
> >>>> So should we just revert this change?
> >>>
> >>> I'd prefer not to have to set quiet to get a clean splash screen. Tha=
t
> >>> doesn't seem like an unreasonable expectation, getting default
> >>> non-debug logs and not having stuff written on top of the splash
> >>> image.
> >>
> >> Perhaps you could remind us why this only applies to the efistub
> >> output, and having the output of the kernel itself corrupting the
> >> splash screen is fine?
> >
> > I'm not greatly knowledgeable about the efi standard and what's
> > happening under the hood, so I will just speak to what I saw in my use
> > case. I'm working on Nvidia Tegra devices, newer generations of which
> > use EDK2 as the last stage bootloader. The target os is Android, which
> > has a pretty strictly controlled defconfig. Prior to this change, the
> > kernel efistub logs were getting passed to the efi impl, which was
> > then printing those lines to the display. The kernel logs were not
> > being printed to the screen, as none of the console drivers were
> > enabled to do so. So after this change, regardless of the kernel log
> > level, the boot splash will remain untouched until the kernel display
> > driver takes over the display and the os renders to it. Because no
> > efistub log lines are being printed.
> >
>
> That makes sense now, and surely don't mind having some build-time or
> runtime configuration switch that allow to tune the system into such
> settings. It's just not so nice to take away the freedom of full-scale
> loglevel control from the efistub.
>

Yeah, that would be my fault, I guess. I suggested simplifying this to
the current approach.

Would it be sufficient to make the EFI stub loglevel a separate
compile time Kconfig option? I'd prefer that over adding more runtime
logic.

