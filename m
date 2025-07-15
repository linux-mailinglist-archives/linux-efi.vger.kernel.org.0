Return-Path: <linux-efi+bounces-4340-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC26B04D7D
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 03:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71384E0A46
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 01:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA7288C11;
	Tue, 15 Jul 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO+w+Xka"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C22882B7;
	Tue, 15 Jul 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543353; cv=none; b=hCTZrqydSbDUtmx4/GhzVlMXmxcmNP4h3hS9t3ivHjEX2SM7wqbhwLYWgC97lG1j6MT/thsqMYgrmuPLlREksdCFecMVm9HPxjV4a0Hxivu6UAeR8OAmD3Yx64ZA8RyNPTp9iG49FeKUBB22nUL0YfTHTxMVKUgXFNp06+xwNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543353; c=relaxed/simple;
	bh=6jmGd/PPfAlW3DmpDOjl7UBuTiSmfxF9WlN8BgGKdeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWkDbICFxxLvPKIZ/wNqjResyFGSSSaBzamdz4msQvIfuguENfEz5b/+dAPMod8GMykNo9oxzhbp/Tnn+LftHmFea5j42nVuA1NdJzTo46N4VA7ERzIW7It3a0EMh0Y7o3vhuA4ODiX+eUjDA991+DlHce4sEmdhnuFZIcr2TSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO+w+Xka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BD7C4CEF4;
	Tue, 15 Jul 2025 01:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752543352;
	bh=6jmGd/PPfAlW3DmpDOjl7UBuTiSmfxF9WlN8BgGKdeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gO+w+Xka6sMjBdNot6x4UY34v7azU7KTZTOJqeKk+cP/Fh1KKEm3PRPL7n54/P/Is
	 RZbdCT1dfS711gYwTMC/fi+YS1n+HEWs/iHBfxQ5bi/8IqOhK3CfxPi9fwKOMeAN0M
	 d8NoDWbLe0K22y2WH5wiYazJLE8usF2G6ooKmtm47QBdO08/ml8YLDx4gFwqc2aSxn
	 RO+7YkKZWMjAfx1411OUsb8ksUeIAezmlcSh9t4uXZ7UhW0vGsTtlCtrBcpKo6dJar
	 KfrcLfTTPVVtQu+wDL7mEhy/+e68YcG97mWozxRWQ+0Jsctsh0480taiS+72wr23Gm
	 lkZvNlDlRxqHg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so6080345e87.0;
        Mon, 14 Jul 2025 18:35:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHbCWSLIMkV9mOkL6ydKbb9fl6qPatthXmw6Wg4lct2hfOzkEye3RfhfcrTNeEtNp06dd4o7jHsYaIUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kwr0l+2LiV5gwWpJUrG8tOoBB1z/v1TsG4gJFKqVNYs6TleJ
	ijf4+SjpQFVM1Eemnpt/fngewFvZTBPGcje2kQ+iSjQdGWf91EyvqJepE9a3Ahqdw5o3/omMuzG
	6t0CLpsTLbrj8Sogacx21TlIoIfiuEdE=
X-Google-Smtp-Source: AGHT+IFdqkhtmnZjBWYaeN4z4pCq9RwhZ/HVK2IuCMVtsMechDB2xiILXmuaivF6/LuTlmv3Jp8ihhUt2g7n3BrjO/E=
X-Received: by 2002:a05:6512:3406:b0:553:2e37:6945 with SMTP id
 2adb3069b0e04-55a0463b94dmr4158497e87.32.1752543351242; Mon, 14 Jul 2025
 18:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-efi-default-loglevel-v1-1-12b80db5af16@gmail.com> <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
In-Reply-To: <CALHNRZ9T0dHzbXBUdBa4hE-Ao8ebeLLPRX+1ThkuLT+Rp8_Jeg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 11:35:38 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
X-Gm-Features: Ac12FXyFKkyZGDDl6j9P4r-6ZGO6bwa2mt8ieySjXxtWL5aGhhywShZF1W5IUlk
Message-ID: <CAMj1kXEwyaHUkO5aO-sL3YAN=qRoSTuotHMRpBDLX9BhERnN=g@mail.gmail.com>
Subject: Re: [PATCH] efistub: Lower default log level
To: Aaron Kling <webgeek1234@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 at 17:31, Aaron Kling <webgeek1234@gmail.com> wrote:
>
> On Tue, Jul 8, 2025 at 2:30=E2=80=AFAM Aaron Kling via B4 Relay
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> >
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Some uefi implementations will write the efistub logs to the display
> > over a splash image. This is not desirable for debug and info logs, so
> > lower the default efi log level to exclude them.
> >
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/printk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/e=
fi/libstub/printk.c
> > index 3a67a2cea7bdf1aa215d48dbf9ece4ceec6e4c28..bc599212c05dd746a9c54ab=
bbe61a4bf70f1a8c4 100644
> > --- a/drivers/firmware/efi/libstub/printk.c
> > +++ b/drivers/firmware/efi/libstub/printk.c
> > @@ -5,13 +5,13 @@
> >  #include <linux/ctype.h>
> >  #include <linux/efi.h>
> >  #include <linux/kernel.h>
> > -#include <linux/printk.h> /* For CONSOLE_LOGLEVEL_* */
> > +#include <linux/kern_levels.h>
> >  #include <asm/efi.h>
> >  #include <asm/setup.h>
> >
> >  #include "efistub.h"
> >
> > -int efi_loglevel =3D CONSOLE_LOGLEVEL_DEFAULT;
> > +int efi_loglevel =3D LOGLEVEL_NOTICE;
> >
> >  /**
> >   * efi_char16_puts() - Write a UCS-2 encoded string to the console
> >
> > ---
> > base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> > change-id: 20250708-efi-default-loglevel-4da5a36cac87
> >
> > Best regards,
> > --
> > Aaron Kling <webgeek1234@gmail.com>
>
> This patch was originally suggested a few months ago [0], but as far
> as I can tell was never queued for merge. Since I'm also hitting a
> case where this is relevant, I'm sending this in to bring attention
> back to it.
>

I've queued this up now - thanks.

> [0] https://lore.kernel.org/all/CAMj1kXFKSrVx4SO_T8sHU=3D4hie8pjk8CUWQDV8=
oh+bz=3DxMn4rw@mail.gmail.com/

