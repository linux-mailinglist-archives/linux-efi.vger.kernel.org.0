Return-Path: <linux-efi+bounces-4614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D92B35F5E
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 14:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD401BA2A23
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCB322A1E;
	Tue, 26 Aug 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYXjHRNw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9329D280;
	Tue, 26 Aug 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212209; cv=none; b=K1JCAaI7BPVTwmxah/s774SgfoaJfJVzLFW02RoqfuvXnd38IjDxfHIonCHhtx8H9j9WQ9jcFmhKAFWcS9U9rkc4biDjhiXRdKF+3ATQxYEDqDJIseQmgDf7VpGLyWYxrLyZ/TuTTT8CfPQ7Y0zep+wUO75XS/dFmKeibj5z9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212209; c=relaxed/simple;
	bh=YJJphITcbiKQ3JJ7Mz1oiUVImP7rWbUytgWR8gnOAuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3lwWwSkDtenjDGZ/FGESgVewhvZMEiZRvb/Q02ZVnTdC/za8eIgTFLIZTxfKk3rNblVmQnGcuaoan5hKbqS1enOuP58v3OCg9ZEciu1q0eevTsujqZbrvfeRPMdCFDQS5wv9J77M4NR77XSh2XQlXo3vrG/8PcdhWKUJJSnpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYXjHRNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11F4C4CEF1;
	Tue, 26 Aug 2025 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756212208;
	bh=YJJphITcbiKQ3JJ7Mz1oiUVImP7rWbUytgWR8gnOAuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PYXjHRNw0BaA/bpDXW5j/G2QGgE+fZHYGAiLRSIK7FbUswPmt5yUZ2BPV5oCz8VRz
	 GWiKj0RNe851FxjLoF8q/E5iZrhM0TM5etCL/SdGXW3LQmwHkB38t+hR0hjYIfuucj
	 PO2nl74dQt8Fhx69kxfGJXVPKrUskGScy6TQcs1yaIDgqI+GClMAZp7zS+uZ15rFgO
	 MHMcPh06jYUbVx2YESQM23IQS/4s18J6NQKJYifWbibGKA1BE260DW1fRsq+cSJkBV
	 GDBCe0DL3ogts8jh29S//0ZIR0gJpIO5KJ9XvIjZ5iqHgRffQaTy2LOsmkY50oD2sF
	 WaY9FcfvND6EA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f3ec52a42so3270836e87.1;
        Tue, 26 Aug 2025 05:43:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA7WHEHd63H6TAFsZ5xsBFwhbyE/rHoYv8ojK9iOArbS+gqzjdrzlTgFBxrzXjuZi/urpXf4jZDWOzTLL8@vger.kernel.org, AJvYcCXnuRVjbhJtFBhtexFqS7h+cwx/YfNuRSMGsg3PCIrHvlqQp94iYpl8F5w77I/Jii6j+Tl/D94xoe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOj/tmgKmOUS9tceHVRvmaccz5QEAK0XbZW91A2GeP3/RuJrH
	0D8NyXhtGkbxsBXmt4H1RN/yQ/V3EPQgFWv3aF0cTChcclCAFsWawcS7EITyVfvpndd0KU/Duhf
	4U5STvCLJ5qzowzrmN7JWKNd8WciS6eA=
X-Google-Smtp-Source: AGHT+IHp4EKOU4K1PetvcSc9aeoUmGfw6Q5NJKG0AFsvTHBGPLokBQsYm1LqduA3iICsbQZVLUFVcPfq9O/3VxdwcE8=
X-Received: by 2002:a05:6512:3ca1:b0:55f:4e8a:19b9 with SMTP id
 2adb3069b0e04-55f4e8a1c79mr612884e87.25.1756212207178; Tue, 26 Aug 2025
 05:43:27 -0700 (PDT)
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
In-Reply-To: <CAMj1kXGeGG6hCCNKhSxPJppkTzBeZg9jO0py1P8xfi2N3S=vyQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 14:43:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF53U8DUmt8tN75ZYkkQc8wLOcns1eEzNFo=a7F02h3Kg@mail.gmail.com>
X-Gm-Features: Ac12FXy8NzaqjCfOh0_ex9Gur2O22dfPtZk0GpHqG-td-cD5SuAUEPtlE_8CL78
Message-ID: <CAMj1kXF53U8DUmt8tN75ZYkkQc8wLOcns1eEzNFo=a7F02h3Kg@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Aaron Kling <webgeek1234@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 10:16, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 26 Aug 2025 at 09:23, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 26.08.25 00:09, Aaron Kling wrote:
> > > On Mon, Aug 25, 2025 at 4:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > >>
> > >> On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> wr=
ote:
> > >>>
> > >>> On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > >>>>
> > >>>> On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> > >>>>>
> > >>>>> On 24.08.25 02:31, Ard Biesheuvel wrote:
> > >>>>>> On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
> > >>>>>>>
> > >>>>>>> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > >>>>>>>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.co=
m> wrote:
> > >>>>>>>>>
> > >>>>>>>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Rel=
ay
> > >>>>>>>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> From: Aaron Kling <webgeek1234@gmail.com>
> > >>>>>>>>>>
> > >>>>>>>>>> Some uefi implementations will write the efistub logs to the=
 display
> > >>>>>>>>>> over a splash image. This is not desirable for debug and inf=
o logs, so
> > >>>>>>>>>> lower the default efi log level to exclude them.
> > >>>>>>>>>>
> > >>>>>>>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > >>>>>>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > >>>>>>>>>> ---
> > >>>>>>>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> > >>>>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers=
/firmware/efi/libstub/printk.c
> > >>>>>>>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05d=
d746a9c54abbbe61a4bf70f1a8c4 100644
> > >>>>>>>>>> --- a/drivers/firmware/efi/libstub/printk.c
> > >>>>>>>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> > >>>>>>>>>> @@ -5,13 +5,13 @@
> > >>>>>>>>>>  #include <linux/ctype.h>
> > >>>>>>>>>>  #include <linux/efi.h>
> > >>>>>>>>>>  #include <linux/kernel.h>
> > >>>>>>>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > >>>>>>>>>> +#include <linux/kern_levels.h>
> > >>>>>>>>>>  #include <asm/efi.h>
> > >>>>>>>>>>  #include <asm/setup.h>
> > >>>>>>>>>>
> > >>>>>>>>>>  #include "efistub.h"
> > >>>>>>>>>>
> > >>>>>>>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > >>>>>>>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> > >>>>>>>>>>
> > >>>>>>>>>>  /**
> > >>>>>>>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the =
console
> > >>>>>>>>>>
> > >>>>>>>>>> ---
> > >>>>>>>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > >>>>>>>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> > >>>>>>>>>>
> > >>>>>>>>>> Best regards,
> > >>>>>>>>>> --
> > >>>>>>>>>> Aaron Kling <webgeek1234@gmail.com>
> > >>>>>>>>>
> > >>>>>>>>> This patch was originally suggested a few months ago [0], but=
 as far
> > >>>>>>>>> as I can tell was never queued for merge. Since I'm also hitt=
ing a
> > >>>>>>>>> case where this is relevant, I'm sending this in to bring att=
ention
> > >>>>>>>>> back to it.
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> I've queued this up now - thanks.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> And how can I get back the loglevel info? It seems I can only c=
hoose
> > >>>>>>> between notice, silent and debug now. And the latter two only b=
y also
> > >>>>>>> touching the kernel's loglevel.
> > >>>>>>>
> > >>>>>>> I'm particularly missing [1] in my UART logs now which is helpf=
ul in
> > >>>>>>> understanding this essential system state.
> > >>>>>>>
> > >>>>>>
> > >>>>>> Hi Jan,
> > >>>>>>
> > >>>>>> Is efi=3Ddebug too noisy for you?
> > >>>>>
> > >>>>> Yes, also because it affects the kernel even more. I'm looking fo=
r
> > >>>>> "efi=3Dinfo".
> > >>>>>
> > >>>>> I don't get the reason behind this change anymore as well. If you=
 have a
> > >>>>> splash screen shown, weren't you booting with "quiet" before alre=
ady,
> > >>>>> thus also without any stub messages?
> > >>>>>
> > >>>>
> > >>>> Yeah, good point. IIRC that came up in the discussion but I can't
> > >>>> remember the motivation so it can't have been very convincing.
> > >>>>
> > >>>> So should we just revert this change?
> > >>>
> > >>> I'd prefer not to have to set quiet to get a clean splash screen. T=
hat
> > >>> doesn't seem like an unreasonable expectation, getting default
> > >>> non-debug logs and not having stuff written on top of the splash
> > >>> image.
> > >>
> > >> Perhaps you could remind us why this only applies to the efistub
> > >> output, and having the output of the kernel itself corrupting the
> > >> splash screen is fine?
> > >
> > > I'm not greatly knowledgeable about the efi standard and what's
> > > happening under the hood, so I will just speak to what I saw in my us=
e
> > > case. I'm working on Nvidia Tegra devices, newer generations of which
> > > use EDK2 as the last stage bootloader. The target os is Android, whic=
h
> > > has a pretty strictly controlled defconfig. Prior to this change, the
> > > kernel efistub logs were getting passed to the efi impl, which was
> > > then printing those lines to the display. The kernel logs were not
> > > being printed to the screen, as none of the console drivers were
> > > enabled to do so. So after this change, regardless of the kernel log
> > > level, the boot splash will remain untouched until the kernel display
> > > driver takes over the display and the os renders to it. Because no
> > > efistub log lines are being printed.
> > >
> >
> > That makes sense now, and surely don't mind having some build-time or
> > runtime configuration switch that allow to tune the system into such
> > settings. It's just not so nice to take away the freedom of full-scale
> > loglevel control from the efistub.
> >
>
> Yeah, that would be my fault, I guess. I suggested simplifying this to
> the current approach.
>
> Would it be sufficient to make the EFI stub loglevel a separate
> compile time Kconfig option? I'd prefer that over adding more runtime
> logic.

Would the below work for you Aaron?

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index eb1bff6968a5..f7552f36ab51 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -72,6 +72,11 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_GENERIC_STUB
        bool

+config EFI_STUB_LOGLEVEL
+       int "Loglevel for the EFI stub console"
+       range 1 15
+       default CONSOLE_LOGLEVEL_DEFAULT
+
 config EFI_ZBOOT
        bool "Enable the generic EFI decompressor"
        depends on EFI_GENERIC_STUB && !ARM
diff --git a/drivers/firmware/efi/libstub/printk.c
b/drivers/firmware/efi/libstub/printk.c
index bc599212c05d..782d1330c1cc 100644
--- a/drivers/firmware/efi/libstub/printk.c
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -5,13 +5,12 @@
 #include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
-#include <linux/kern_levels.h>
 #include <asm/efi.h>
 #include <asm/setup.h>

 #include "efistub.h"

-int efi_loglevel =3D LOGLEVEL_NOTICE;
+int efi_loglevel =3D CONFIG_EFI_STUB_LOGLEVEL;

 /**
  * efi_char16_puts() - Write a UCS-2 encoded string to the console

