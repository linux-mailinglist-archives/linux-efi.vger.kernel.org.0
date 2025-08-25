Return-Path: <linux-efi+bounces-4602-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E3B33D17
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F113A6B88
	for <lists+linux-efi@lfdr.de>; Mon, 25 Aug 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13712C0F91;
	Mon, 25 Aug 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyh3vJso"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911C262FC1;
	Mon, 25 Aug 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118695; cv=none; b=Z+r1QrkC/rnZ2lC1p138L2yw0wvatg/srcqxuI8/tFQmh4U4T4NNcqqxk1TSAuSQiZ5/xK7X7FJY57zv94azui85Oflawddn4npLXdj4OAS5qCY3/fOpbueUNr3hka6eHJiwrbEhUIK4edWp3lddSHarprsBpocIBVJ6bi1mRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118695; c=relaxed/simple;
	bh=QD8oUBIDGpTVM3NZWJjZ6nU3/bBt4VFqt/FEl2JFavU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahmvYvHdW6T/siEdPvttQ7ADpzXEgCiLA6JzATXzJWzrbzZsPhtdxTBqGQESY1e6EJay3VqflWqISBYt4jpRZNVlmYcG9/Q3Ui9Mbc9fkaC+1jaksCAURFigTn1kTWbltZaB1i2xZ8TW1nEkiiRpzcRU5Mrf+xWbOWJqD+d8V3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyh3vJso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C40BC4CEED;
	Mon, 25 Aug 2025 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118695;
	bh=QD8oUBIDGpTVM3NZWJjZ6nU3/bBt4VFqt/FEl2JFavU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qyh3vJso6kMWP9Wt1t9nJ1gn8inkCL3ZOUdPNo5g906MbnQcPWlLaH2bt6NIgsVQd
	 x/looIJDATFVhZdRmyTCJO5DpY4Q7qPC3mA4TGNRi5Rx5mJEz4ayHeoYP1jFje5+/w
	 JV44zosjAqErr2rPMqLimllXdi2u/3eVDti657nmgx1kxXoh9AqWrZTtJLhApfIiIp
	 /YjoEemmP5BfX6j6CbTXqOWpH1T4tmh6+HN1AtEG3iiYsqNauVP+tF+gjPevfPKTol
	 5j4bjE7Q5xmLNCV/yHrBEUc8QAA3aMvP5y8wpFDGV8KuM5L0eKWhDI6zA7Yd9sJd2I
	 0YGKsxpA3kEJw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f467f3bcaso570529e87.2;
        Mon, 25 Aug 2025 03:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8Ha2RzgUyIskpYLBz60V+dZ1PLuMQ/vGckiuYmRbbc+XYSMkH4mR6Wfi7nT2wpdzCqzUZB/MUwtE=@vger.kernel.org, AJvYcCWw8BwTXyXwWk53Fjlc3oElmfIYd2LaNq1QkpALIqA6lFS4PaqkC158L97fugwLOQrSjVK0moit+6BwnBuK@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJ9D87rXnSxjWIVG2nd00KW3WJUrJS8vPVHOLfbRQrlIRkzfS
	Rjs/uQGwk5q7nlcE8LdTmKo2+GXWF2MtT601yxFx+CSRLJ7unnyUfJ1dxGDKi27xqkEyLr94Cw4
	we42eNqq06TR+GRwvPNv4FEHbwNABNvU=
X-Google-Smtp-Source: AGHT+IHozNFzGZ/Be8XEaeN+LseVN6rYc06MeFFjqExsMToudCZfq84AjGkxH+wYgZCDvw+6AmP7hsiiXBQrs8aekoI=
X-Received: by 2002:a05:6512:4407:b0:55f:42b8:b00 with SMTP id
 2adb3069b0e04-55f42b80cd2mr1194943e87.12.1756118693694; Mon, 25 Aug 2025
 03:44:53 -0700 (PDT)
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
 <09cb03e4-21f3-418c-98f2-66004cc3080f@siemens.com>
In-Reply-To: <09cb03e4-21f3-418c-98f2-66004cc3080f@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Aug 2025 20:44:37 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHyw3Oi=c3p+7q75vD4iJ+x642JzL7zHM4jpF4k937Uxg@mail.gmail.com>
X-Gm-Features: Ac12FXwxflF-hGpLA7ghlAf4OOTW89RuPiS0DEUxZcADPx5d9BUmmLk2eUjtUaQ
Message-ID: <CAMj1kXHyw3Oi=c3p+7q75vD4iJ+x642JzL7zHM4jpF4k937Uxg@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Aaron Kling <webgeek1234@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Aug 2025 at 16:47, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 24.08.25 02:31, Ard Biesheuvel wrote:
> > On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> wrote=
:
> >>
> >> On 15.07.25 03:35, Ard Biesheuvel wrote:
> >>> On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrot=
e:
> >>>>
> >>>> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> >>>> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >>>>>
> >>>>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>>>
> >>>>> Some uefi implementations will write the efistub logs to the displa=
y
> >>>>> over a splash image. This is not desirable for debug and info logs,=
 so
> >>>>> lower the default efi log level to exclude them.
> >>>>>
> >>>>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> >>>>> ---
> >>>>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmwa=
re/efi/libstub/printk.c
> >>>>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c=
54abbbe61a4bf70f1a8c4 100644
> >>>>> --- a/drivers/firmware/efi/libstub/printk.c
> >>>>> +++ b/drivers/firmware/efi/libstub/printk.c
> >>>>> @@ -5,13 +5,13 @@
> >>>>>  #include <linux/ctype.h>
> >>>>>  #include <linux/efi.h>
> >>>>>  #include <linux/kernel.h>
> >>>>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> >>>>> +#include <linux/kern_levels.h>
> >>>>>  #include <asm/efi.h>
> >>>>>  #include <asm/setup.h>
> >>>>>
> >>>>>  #include "efistub.h"
> >>>>>
> >>>>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> >>>>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> >>>>>
> >>>>>  /**
> >>>>>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
> >>>>>
> >>>>> ---
> >>>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> >>>>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> >>>>>
> >>>>> Best regards,
> >>>>> --
> >>>>> Aaron Kling <webgeek1234@gmail.com>
> >>>>
> >>>> This patch was originally suggested a few months ago [0], but as far
> >>>> as I can tell was never queued for merge. Since I'm also hitting a
> >>>> case where this is relevant, I'm sending this in to bring attention
> >>>> back to it.
> >>>>
> >>>
> >>> I've queued this up now - thanks.
> >>>
> >>
> >> And how can I get back the loglevel info? It seems I can only choose
> >> between notice, silent and debug now. And the latter two only by also
> >> touching the kernel's loglevel.
> >>
> >> I'm particularly missing [1] in my UART logs now which is helpful in
> >> understanding this essential system state.
> >>
> >
> > Hi Jan,
> >
> > Is efi=3Ddebug too noisy for you?
>
> Yes, also because it affects the kernel even more. I'm looking for
> "efi=3Dinfo".
>
> I don't get the reason behind this change anymore as well. If you have a
> splash screen shown, weren't you booting with "quiet" before already,
> thus also without any stub messages?
>

Yeah, good point. IIRC that came up in the discussion but I can't
remember the motivation so it can't have been very convincing.

So should we just revert this change?

