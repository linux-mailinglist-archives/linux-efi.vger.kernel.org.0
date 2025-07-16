Return-Path: <linux-efi+bounces-4377-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D83B06C75
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 05:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF822563965
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11985211A35;
	Wed, 16 Jul 2025 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnbyNZ/u"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794785260;
	Wed, 16 Jul 2025 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637944; cv=none; b=WvI6ySC+niOAiU5dxBp9+qM2z6F1hScYr07wqHOL7Svde8fHwwye+hJBWTHQeulA7WHlBMMoSPrBPAJt/1Ie1/onl3+3N4wMRgaloGtTh4WmWgdrNWc46sPzOlhKpKDrqwmz8FMOuGXfyxiTbAtqki5W094TTc6GfBXm0MToZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637944; c=relaxed/simple;
	bh=kbKYP37k7zLxmRSGbkuGEEJMcz1AsBvMEBjt1v4DxZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYsaNYDcoUTZaE05TaZfZqqhWvcJ5+EMK3BVXEo9Lnk3Dtpy+1oWQogyQRFjFb/pEqU7xOTZjc+TNxGGuot8ONDn4W0RLqXTObcgTQnEMWA37f6hnWacB5qyMRbv6P1nY4DwW+GhVP6Cjdcbmj5YVEyNgEMzpqxE45ghq5v2Gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnbyNZ/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F48C4AF09;
	Wed, 16 Jul 2025 03:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752637943;
	bh=kbKYP37k7zLxmRSGbkuGEEJMcz1AsBvMEBjt1v4DxZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fnbyNZ/uofGXdgO7Yr2YWSNB67zbnOFOQ+pTadx543mwEWroEHJc4Ic64pAA3Z/11
	 UGhzH/VIGx0r+EL5bHdyNhfO5qenQAGqdqQXc4sMTG4jO0oHJB6QDFPWPfsXbCmZlH
	 WLBqi80urwpHRK2uEhCd3hCdgh6UPIlGy7x1ES23qXjUPSoX9k+ltIj0Bj+U9ncrzV
	 77QMIdVHowgEY/FSjC0zrhqNhEDFdeSB2r9kmK+gvSIfE4jKLfBHdQ6Ootdl1piht0
	 uqH/qfLzgFHH1RUJtKWlIjdcG5PtZLDK0INZv9ODqbHmZUtQvuXb2pJVrnQ+w0d2FI
	 XTSf8/KvR6vrg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553e5df44f8so5490821e87.3;
        Tue, 15 Jul 2025 20:52:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsktIoCYEXbui/DE2Q8u8WlYnlXJt8l3D954giHIbeKW3PoGPiBfOJSMtiBWXDuap37Bwf1umnVcw=@vger.kernel.org, AJvYcCWF/gzQ2X0WU4LInxpT4Rf+EEatcwBqR325IeOjsJ6NiPKfSr8hbwylP5tMCLr7sw6irLDKy9muDhl0IRp2@vger.kernel.org, AJvYcCXo/5jlBJc0ttIHmQ7SNWbiiuBQ33vVu1j97eg2pRUlqWkjta0ZBELHVeCeSYPi2nxyMJD2RlIdpBAY@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfqlr7OPFba2eKRvxuygQj42jbnfgMU843NmRFE49gJ0M6L+n
	FdQFvMk8X95yuVx/XBgt9e/Y4ASMFkLgQNuyjzOg80nC51AxPpU+YMnlwJkcNzEm6tPfBdw95Uu
	f9svObsjLxQr+DGtD8L4VH2fitL+JvVY=
X-Google-Smtp-Source: AGHT+IGsx+1eBRK7VlvwwK4lrn2tedS/8CBhSaETgUda6ZBIDw8ZzbYDB45sUI1HO8Bko2rjpL9ZJH4DB6I0F9C6dzg=
X-Received: by 2002:a05:6512:3416:b0:553:ae05:9c48 with SMTP id
 2adb3069b0e04-55a23fa8c7amr357898e87.45.1752637941719; Tue, 15 Jul 2025
 20:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com> <422e2a72-972f-41f4-a0b3-d69a6cb0c2e2@canonical.com>
 <CAMj1kXEXpBF8hPaVMU0sDgNysYT66MDRmr3JHO4Lg1sJB_Yteg@mail.gmail.com> <aHZsohPoxLYML___@sunil-laptop>
In-Reply-To: <aHZsohPoxLYML___@sunil-laptop>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Jul 2025 13:52:09 +1000
X-Gmail-Original-Message-ID: <CAMj1kXF+AP-3hKb8vJQ3oCoPxmEG=udexNCxMLvGE_KHCKcZxw@mail.gmail.com>
X-Gm-Features: Ac12FXyJHyI8FNCWondq-usX0O9Wq8IR0GvzToxJvHq2L_BDfrGw4oT1HSN0fVw
Message-ID: <CAMj1kXF+AP-3hKb8vJQ3oCoPxmEG=udexNCxMLvGE_KHCKcZxw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Remove unused EFI runtime APIs
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-arm-kernel@lists.infradead.org, Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Bibo Mao <maobibo@loongson.cn>, 
	linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 00:58, Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> On Tue, Jul 15, 2025 at 01:29:15PM +1000, Ard Biesheuvel wrote:
> > On Mon, 14 Jul 2025 at 18:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > On 7/14/25 08:08, Ard Biesheuvel wrote:
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Using EFI runtime services to program the RTC to wake up the system is
> > > > supported in theory, but rarely works in practice. Fortunately, this
> > > > functionality is rarely [if ever] used to begin with so we can just drop
> > > > it. (Note that the EFI rtc driver is not used by x86, which programs the
> > > > CMOS rtc directly)
> > >
> > > The main problem I see with firmware offering access to the RTC via UEFI
> > > services is that two different drivers, the firmware one and the Linux
> > > one might be trying to access the same busses or registers which might
> > > lead to unexpected results.
> > >
> > > Recently there was a discussion in the RISC-V technical group for the
> > > server platform specification where the same issue was discussed
> > > concerning SetTime().
> > >
> > > As a UEFI firmware should not care which operating system is booted, it
> > > should be up to the OS to disable EFI access to the RTC if it has native
> > > access.
> > >
> > > Could we disable all the EFI services for the RTC in Linux dynamically
> > > when an RTC driver is successfully probed?
> > >
> >
> > I don't think this would be the right way to do it.
> >
> > It also depends on whether ACPI or DT is being used to describe the
> > platform to the OS.
> >
> > ACPI does not support describing the RTC device, so it should provide
> > the EFI services.
> >
> Hi Ard,
> IIUC, TAD is defined for this purpose, right?
> https://uefi.org/specs/ACPI/6.6/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#time-and-alarm-device
>
> > DT can describe the RTC device directly, so I think it is acceptable
> > for such firmware to mark all RTC routines unsupported in the RT_PROP
> > table, and just expose the RTC device directly.
> >
> > The OS shouldn't have to reason about these things: it is up to the
> > platform to describe itself unambiguously.
>
> I agree. But I think even with ACPI, EFI GetTime/SetTime can return
> unsupported if there is a TAD exposed with proper _GRT/_SRT and _GCP.
>

Thanks for the pointer. This device did not exist yet when I last
looked at this stuff.

So it seems like TAD is a suitable way for exposing a RTC to the OS
without the need for a hardware specific driver. However, the existing
Linux driver does not appear to support get/set time, and is not
hooked up to the RTC subsystem [yet].

