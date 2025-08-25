Return-Path: <linux-efi+bounces-4609-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827DB34E0E
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 23:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A88173B60
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05B2882BD;
	Mon, 25 Aug 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCHzpFMQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A25277C8D;
	Mon, 25 Aug 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157331; cv=none; b=WIK+8zu1+gFit/7ZPbd2nohwAZbdyqr/J3xGIXDT6zbxRqQPFeSRBcGPHPg4n9bNmr2S66KEI9qAB9OvinKgwQn6piHn7Xz2ch2nVHR7PDntrjjk/QmVRPub+01E3y0aRExUfl8PicQpAT+mp6QsuwrMJmhAez9plxpRGZpLDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157331; c=relaxed/simple;
	bh=khSoT/xEBCJvR5sbKOl0l9Ig4C7JXIiQbjQKawYtrlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1M75tLGEb8yglhIUuOXG4feZmmwKdE/tKNGaJCwzB1Q0jB761n/XUhYyqlZdsNaJ7NW6nTin4WIK0ltmonZhi/jZdSHhem7NPy/cBw8htxPTmEMgRxFre36vexaKHQ8R7INpWP1LvDuUdf3wJyhafYKf3CwLo2wFa2Xe9ZcvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCHzpFMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268A2C116C6;
	Mon, 25 Aug 2025 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756157331;
	bh=khSoT/xEBCJvR5sbKOl0l9Ig4C7JXIiQbjQKawYtrlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SCHzpFMQA00UNp9JXeCMtvVwjWjnIzptgTJ0+MWuLZrh0UvMBGmCbMXZrnKnwSpG2
	 7acCH9FFzopLfuCb1PF7BGDzqjxKrF80YcZnHQqBFRm1sxmhmaMa/uFP8GvnRwDz50
	 iVd8CHOzf8bMdOZ6B/6/vSXyS8aNTf0ICz5joqkJh5t3C0mMkpYyZ9F4ZXo9821HMs
	 6c/FtykDPbYpdqFJ1P4WAeO27Mt3wkTuai5TndJZaEVYaBb1H9wpvtJQHk8sju2PyZ
	 lS/Y1ZmNqkWLte8NBM6EO5VltPeB+E+xravcJk8N33NLqPm0iWwUzAYr2AZvaFWbxv
	 W5EdQgWr1iGKg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f48d61ea2so1393070e87.1;
        Mon, 25 Aug 2025 14:28:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvotIlqUjZNp7h2J+D4GqFGtjaqo3K5TNmrjoQEXuCtkXNOc1ttU8sE3khoCn09GKFSMlw26wAunfX8TDi@vger.kernel.org, AJvYcCXQ92M0oI2KeeVBfzUNzzw0BDghhSNKqlKz7HUw7jL5ZS34ZMNXbhlbcr6v29/vtvXi0c3OI9Og+oA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3waVMPDkadTABvb4Hk7/+M08A5O8RSySNh0yecUlUEiz1H63n
	T65OYg6xQn5lKohw6YM3YfHnzER++DLJ5odtTDp/kFjI2+hX9yYCRKv6AmuZ0Kkop3OkSsQhMNE
	MNavFSjmM12oaKvKgLJjjzGOJL/qWlHs=
X-Google-Smtp-Source: AGHT+IEz+jOUV3ShcVhrnJRhPgRS4g/o27rdF0Xo2TGHWvUhpuM8Ya7a/7xKYNsJkwNPh1ojlNtnAeDU3heKlYaQLtY=
X-Received: by 2002:a05:6512:1408:b0:55f:4bf6:eff1 with SMTP id
 2adb3069b0e04-55f4bf6f56emr360497e87.39.1756157329463; Mon, 25 Aug 2025
 14:28:49 -0700 (PDT)
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
In-Reply-To: <CALHNRZ8YUVvQ--Y-EfXW04WYXiKNsj6KSs-OaLMcEnG3_xDMSg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 07:28:33 +1000
X-Gmail-Original-Message-ID: <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
X-Gm-Features: Ac12FXxklvaJZpEgICemd-GaDZHOiDmg1eqU5usuu_k9OR2ghL6W_rj1tDlF-6w
Message-ID: <CAMj1kXE9tNa5R22M9NTmLY8qtnpxbvqMG-Cw0vFpVtr_KoM9bA@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025 at 02:34, Aaron Kling <webgeek1234@gmail.com> wrote:
>
> On Mon, Aug 25, 2025 at 5:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wrote=
:
> > >
> > > On 24.08.25 02:31, Ard Biesheuvel wrote:
> > > > On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
> > > >>
> > > >> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > > >>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> =
wrote:
> > > >>>>
> > > >>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> > > >>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > >>>>>
> > > >>>>> From: Aaron Kling <webgeek1234@gmail.com>
> > > >>>>>
> > > >>>>> Some uefi implementations will write the efistub logs to the di=
splay
> > > >>>>> over a splash image. This is not desirable for debug and info l=
ogs, so
> > > >>>>> lower the default efi log level to exclude them.
> > > >>>>>
> > > >>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > >>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > >>>>> ---
> > > >>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> > > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/fi=
rmware/efi/libstub/printk.c
> > > >>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd74=
6a9c54abbbe61a4bf70f1a8c4 100644
> > > >>>>> --- a/drivers/firmware/efi/libstub/printk.c
> > > >>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> > > >>>>> @@ -5,13 +5,13 @@
> > > >>>>>  #include <linux/ctype.h>
> > > >>>>>  #include <linux/efi.h>
> > > >>>>>  #include <linux/kernel.h>
> > > >>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > > >>>>> +#include <linux/kern_levels.h>
> > > >>>>>  #include <asm/efi.h>
> > > >>>>>  #include <asm/setup.h>
> > > >>>>>
> > > >>>>>  #include "efistub.h"
> > > >>>>>
> > > >>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > > >>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> > > >>>>>
> > > >>>>>  /**
> > > >>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the con=
sole
> > > >>>>>
> > > >>>>> ---
> > > >>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > > >>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> > > >>>>>
> > > >>>>> Best regards,
> > > >>>>> --
> > > >>>>> Aaron Kling <webgeek1234@gmail.com>
> > > >>>>
> > > >>>> This patch was originally suggested a few months ago [0], but as=
 far
> > > >>>> as I can tell was never queued for merge. Since I'm also hitting=
 a
> > > >>>> case where this is relevant, I'm sending this in to bring attent=
ion
> > > >>>> back to it.
> > > >>>>
> > > >>>
> > > >>> I've queued this up now - thanks.
> > > >>>
> > > >>
> > > >> And how can I get back the loglevel info? It seems I can only choo=
se
> > > >> between notice, silent and debug now. And the latter two only by a=
lso
> > > >> touching the kernel's loglevel.
> > > >>
> > > >> I'm particularly missing [1] in my UART logs now which is helpful =
in
> > > >> understanding this essential system state.
> > > >>
> > > >
> > > > Hi Jan,
> > > >
> > > > Is efi=3Ddebug too noisy for you?
> > >
> > > Yes, also because it affects the kernel even more. I'm looking for
> > > "efi=3Dinfo".
> > >
> > > I don't get the reason behind this change anymore as well. If you hav=
e a
> > > splash screen shown, weren't you booting with "quiet" before already,
> > > thus also without any stub messages?
> > >
> >
> > Yeah, good point. IIRC that came up in the discussion but I can't
> > remember the motivation so it can't have been very convincing.
> >
> > So should we just revert this change?
>
> I'd prefer not to have to set quiet to get a clean splash screen. That
> doesn't seem like an unreasonable expectation, getting default
> non-debug logs and not having stuff written on top of the splash
> image.

Perhaps you could remind us why this only applies to the efistub
output, and having the output of the kernel itself corrupting the
splash screen is fine?

> But if this needs to be reverted, It would be nice to have an
> option like the original patch which allowed setting the efi loglevel
> separately. Or perhaps leave this as is and add the option to turn up
> the efi loglevel independently.
>

Let's go back to the beginning and figure out to which problem this is
the solution.

