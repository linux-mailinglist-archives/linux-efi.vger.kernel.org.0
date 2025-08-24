Return-Path: <linux-efi+bounces-4597-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FEB32CB6
	for <lists+linux-efi@lfdr.de>; Sun, 24 Aug 2025 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04AA200372
	for <lists+linux-efi@lfdr.de>; Sun, 24 Aug 2025 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F6CA5E;
	Sun, 24 Aug 2025 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjV7Ulxj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A91FB3;
	Sun, 24 Aug 2025 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995508; cv=none; b=MuOeUWphrmUaHOq+eiBzn5VHgAT1mmzpu4+pahnnU2OEr0hyUrKAUgo0SmTD6C/mTmm0whutskxYPH8QCqC66jtN6tQpodUF2rHq3DAi3Al3PFwB/MqR8rleP4RXrmCnFl+YWg2FTTpyzzNNdDsfbTtixD3rlQmZkRcndXEsBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995508; c=relaxed/simple;
	bh=odEFLxYSjofajBpnAwKdZQ8ZowyJqgbEtlSPVVz6DA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs9KCa2249DMed6+CuZgFH45zEx+ovEdmgC7PCv09BdtWcxzSLS0e7kd5a3sLk1W2gWf4i3CUuE94wRxFJj6pCejS5R5rrk08kG0RMyJCgM+6C3rZ9BleEUUtsS/XPgLZYFkVYavkDdXoQb78xR1szifq9EweuRJiTJTGWGY7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjV7Ulxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D3AC113D0;
	Sun, 24 Aug 2025 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755995508;
	bh=odEFLxYSjofajBpnAwKdZQ8ZowyJqgbEtlSPVVz6DA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JjV7UlxjyEPU0iBkzfLbD0P5qfFF6bmqDaFTN6mWDKqL00/r1Tqyyvsu5DVnktUQo
	 cs2IInlzuoU0JXi5rX+rvFysZONzHzK+3PP4tzkLUMmcfJXXhEZkNN7r7Artpwm14f
	 u3gINapu0FyfIT/efnWLAZs6XqLKUtoZw377clrT3QOEiWgClOxdi/e6wCkCBV3LDb
	 u0C5wOulO8urJAHujfTUsfSdJPR9T5DskHcgikih3qc3nRdsZ9i6WAUV/1053FZQI3
	 O8wp2U19ZjxDbAsxBtSv0si5Q+CcjbUVe+zt6fNd83VRpbmQS7zqrH4kPTGERq12Y/
	 gEqzMcXBlSr2w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5097493so2977463e87.0;
        Sat, 23 Aug 2025 17:31:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTZiZtfA+BwQaZZpvwjabYHBNJHq63DSwVt+OVR0Pmham8s887M1/WXf2CWYmhVFzQckyDafxgIJg=@vger.kernel.org, AJvYcCXUZZ//irY/UwLZb2ZyXwridOUwwihHbZVBbOl1DcIrYfte2yXxxZgZPuTEtYOa86vUukoXn9i5jYCkXZem@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgkSug2JgO0jTF+L1y2QA1EaXoEYZV42FGOd8rF3OkqdzoYmk
	GCSgOLdorQcUhvqvpJ1mW2pzMJQeydYgW/LBkWoAMiOqLtjI6xAULUoDPpDjmTkAqRy5FucoBdx
	UbqM9RtQ8Tm5/EMuyEpxxBRMDK/sdDc4=
X-Google-Smtp-Source: AGHT+IE+CGTNYQ8ipKOG7G5GQbFG46Vul5T3gKWQTTzUNEdBTzlD9Tc/YII3dXd0fy0LA8Amewyg2O5LP3WnH6Pl2Lk=
X-Received: by 2002:a05:6512:234c:b0:55f:42b8:b11 with SMTP id
 2adb3069b0e04-55f42b80c99mr39270e87.45.1755995506679; Sat, 23 Aug 2025
 17:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com>
 <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
 <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com> <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com>
In-Reply-To: <45692a2c-ba3d-45a2-9ab1-cf6982dbf788@siemens.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Aug 2025 10:31:35 +1000
X-Gmail-Original-Message-ID: <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
X-Gm-Features: Ac12FXw_QXkkq4rLy1icWgf7Z2gtdX1LLyLPc5SKyeedN9znQl9aP222HrlZmC0
Message-ID: <CAMj1kXG=zG8j+cr0gNMpkKRvdekqMR-EiEkMHiFgRvbaWy9aKg@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Aaron Kling <webgeek1234@gmail.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 at 16:52, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 15.07.25 03:35, Ard Biesheuvel wrote:
> > On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrote:
> >>
> >> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> >> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >>>
> >>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>
> >>> Some uefi implementations will write the efistub logs to the display
> >>> over a splash image. This is not desirable for debug and info logs, s=
o
> >>> lower the default efi log level to exclude them.
> >>>
> >>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> >>> ---
> >>>  drivers/firmware/efi/libstub/printk.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware=
/efi/libstub/printk.c
> >>> index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54=
abbbe61a4bf70f1a8c4 100644
> >>> --- a/drivers/firmware/efi/libstub/printk.c
> >>> +++ b/drivers/firmware/efi/libstub/printk.c
> >>> @@ -5,13 +5,13 @@
> >>>  #include <linux/ctype.h>
> >>>  #include <linux/efi.h>
> >>>  #include <linux/kernel.h>
> >>> -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> >>> +#include <linux/kern_levels.h>
> >>>  #include <asm/efi.h>
> >>>  #include <asm/setup.h>
> >>>
> >>>  #include "efistub.h"
> >>>
> >>> -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> >>> +int efi_loglevel =3D LOGLEVEL_NOTICE;
> >>>
> >>>  /**
> >>>   * efi_char16_puts() - Write a UCS-2 encoded string to the console
> >>>
> >>> ---
> >>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> >>> change-id: 20250708-efi-default-loglevel-4da5a36cac87
> >>>
> >>> Best regards,
> >>> --
> >>> Aaron Kling <webgeek1234@gmail.com>
> >>
> >> This patch was originally suggested a few months ago [0], but as far
> >> as I can tell was never queued for merge. Since I'm also hitting a
> >> case where this is relevant, I'm sending this in to bring attention
> >> back to it.
> >>
> >
> > I've queued this up now - thanks.
> >
>
> And how can I get back the loglevel info? It seems I can only choose
> between notice, silent and debug now. And the latter two only by also
> touching the kernel's loglevel.
>
> I'm particularly missing [1] in my UART logs now which is helpful in
> understanding this essential system state.
>

Hi Jan,

Is efi=3Ddebug too noisy for you?

