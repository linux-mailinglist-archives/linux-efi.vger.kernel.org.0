Return-Path: <linux-efi+bounces-1491-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46493C237
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF77B211FB
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E936196C9B;
	Thu, 25 Jul 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6M9ayMg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6A17557C;
	Thu, 25 Jul 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911190; cv=none; b=IB5zdOoXCSvGtuKdlaZNRUDbpVVCIH7VL6Z2LlLSd+SLVJdIrU3a01zQm8toCFz9WzeejZp0cPaQwSCZvdK8DMPyMA+wkjJT61mtCF1b2cYJLR1gQXkvdZxx6gOR7SsZKmKRSyyHxvqr7F6YwG3QGtZnrkEQcJaZ4v0AJ+ZK3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911190; c=relaxed/simple;
	bh=7CpUjnEhLTzNGigim+H9F3yYm8KzlqkXCoBWCWklL7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEy+q5RAVafxi8Q/98DnqVAFjmNHvpYY4kGoP1Zl9ojh8K8aDI5bsVhjzQjMNc4r4L2g4hyVtytqScaKtmv0BwNErzv11+zxskjtDWAo4cUUDmy1nrNhvgjn5Barl97mxCh9f6Rla45mVHa10HkU/UKEbJf1tQD8eg1EPCjvbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6M9ayMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E1C116B1;
	Thu, 25 Jul 2024 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721911189;
	bh=7CpUjnEhLTzNGigim+H9F3yYm8KzlqkXCoBWCWklL7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f6M9ayMgJod4cJZJ/d724Ul5MXaJYA0b9N6nDzrwwaHWjM3KN+rCe3waOiW4HYaQe
	 3wItbm7nzzjhCiJJj2JyUwRSLrwptb2GiCph1k5t4Ej0V+vcsqfppUwElV4nYN4tH7
	 A+LUHtmgJ4/FRuvyqTY+tfbeUsXbu4TxiF8YG8f0Y47NrBSTeI6p0Dm2EvMrzth1/6
	 IDui6oc5/ZiKtPmQTWimE+Zu1WSqJJQVAnGFE6OpLJ6y5rYityRdDCrzBXfoVV9Lju
	 uRsQZbKR1+pgsesoLsOfpuVM0xM2m6ITlkxTDxvlvvyRk7YlEeDir5ivxSeYizanrM
	 Im++OwocKoCXw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f00ad303aso174503e87.2;
        Thu, 25 Jul 2024 05:39:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWucutVbuMJxOeDTkI7azm8OVDuSRm+TyNHFzzlaQhOCbw4JT7hriwEGOoXYpAJgXf98bOfPmIuZgRxivirLz5uO5QB8gcArnxvvWEoWZhMfitEsr3wvekTMvOTjcUmwzCyJ8B5QW3s
X-Gm-Message-State: AOJu0Yy0w+do+cOsmUiWvv43J31itvsWGLSEfFO9wW5c2uGl1429vMKa
	Ms+n9HSsHq1xF9gFvrHDAAQPpAd2McPpV7hxLDdtOzBJJbDgc1IGhW+XNHK1iT5W1PCbAEw4IMi
	ALNYoW2wRK6iEyy6mB8wgnmxLuts=
X-Google-Smtp-Source: AGHT+IGtA1jrXS7H0LRL4SJstO5aclFgrNhj8R67GDqH8n5yGZX65Zo8J5JFE9RnbLwrRU8IqKRjbjS1QeYm57HDHI4=
X-Received: by 2002:a05:6512:3f19:b0:52c:b479:902d with SMTP id
 2adb3069b0e04-52fd3eefe7bmr1904136e87.4.1721911188169; Thu, 25 Jul 2024
 05:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com> <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de> <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de> <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jul 2024 14:39:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjQKCBd78y=n9MA+gzitotskye4uYz+dAaUBT=_r8ZsQ@mail.gmail.com>
Message-ID: <CAMj1kXFjQKCBd78y=n9MA+gzitotskye4uYz+dAaUBT=_r8ZsQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
To: Aditya Garg <gargaditya08@live.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Kerem Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>, 
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 at 18:27, Aditya Garg <gargaditya08@live.com> wrote:
>
>
>
> > On 24 Jul 2024, at 9:31=E2=80=AFPM, Lukas Wunner <lukas@wunner.de> wrot=
e:
> >
> > =EF=BB=BFOn Tue, Jul 23, 2024 at 04:25:19PM +0000, Aditya Garg wrote:
> >>> On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> >>> For the Macs having a single GPU, in case a person uses an eGPU,
> >>> they still need this apple-set-os quirk for hybrid graphics.
> >>
> >> Sending this message again as for some reason it got sent only to Luka=
s:
> >>
> >> Full model name: Mac mini (2018) (Macmini8,1)
> >>
> >> The drive link below has the logs:
> >>
> >> https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view=
?usp=3Ddrive_link
> >
> > Some observations:
> >
> > * dmesg-with-egpu.txt:  It seems the system was actually booted *withou=
t*
> >  an eGPU, so the filename appears to be a misnomer.
> >
> > * The two files in the with_apple_set_os_efi directory only contain
> >  incomplete dmesg output.  Boot with log_buf_len=3D16M to solve this.
> >  Fortunately the truncated log is sufficient to see what's going on.
> >
> > * If the apple_set_os protocol is not used, the attached eGPU is not
> >  enumerated by the kernel on boot and a rescan is required.
> >  So neither the iGPU nor the eGPU are working.  The reason is BIOS
> >  sets up incorrect bridge windows for the Thunderbolt host controller:
> >  Its two downstream ports' 64-bit windows overlap.  The 32-bit windows
> >  do not overlap.  If apple_set_os is used, the eGPU is using the
> >  (non-overlapping) 32-bit window.  If apple_set_os is not used,
> >  the attached eGPU is using the (overlapping, hence broken) 64-bit wind=
ow.
> >
> >  So not only is apple_set_os needed to keep the iGPU enabled,
> >  but also to ensure BIOS sets up bridge windows in a manner that is
> >  only halfway broken and not totally broken.
> >
> >  Below, 0000:06:01.0 and 0000:06:04.0 are the downstream ports on the
> >  Thunderbolt host controller and 0000:09:00.0 is the upstream port of
> >  the attached eGPU.
> >
> >  iGPU enabled, no eGPU attached (dmesg.txt):
> >  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
> >  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xb83fffff 64bit pre=
f]
> >  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
> >  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pre=
f]
> >
> >  iGPU disabled, eGPU attached, apple_set_os not used (journalctl.txt):
> >  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
> >  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xc6ffffff 64bit pre=
f]
> >  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
> >  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pre=
f]
> >  pci 0000:06:04.0: bridge window [mem 0xb8400000-0xbf3fffff 64bit pref]=
: can't claim; address conflict with PCI Bus 0000:09 [mem 0xb1400000-0xbf3f=
ffff 64bit pref]
> >
> >  iGPU enabled, eGPU attached, apple_set_os used (working-journalctl.txt=
):
> >  pci 0000:06:01.0:   bridge window [mem 0x81900000-0x888fffff]
> >  pci 0000:06:01.0:   bridge window [mem 0xb1400000-0xc6ffffff 64bit pre=
f]
> >  pci 0000:06:04.0:   bridge window [mem 0x88900000-0x8f8fffff]
> >  pci 0000:06:04.0:   bridge window [mem 0xb8400000-0xbf3fffff 64bit pre=
f]
> >  pci 0000:09:00.0:   bridge window [mem 0x81900000-0x81cfffff]
> >
> > * As to how we can solve this and keep using apple_set_os only when
> >  necessary:
> >
> >  I note that on x86, the efistub walks over all PCI devices in the syst=
em
> >  (see setup_efi_pci() in drivers/firmware/efi/libstub/x86-stub.c) and
> >  retrieves the Device ID and Vendor ID.  We could additionally retrieve
> >  the Class Code and count the number of GPUs in the system by checking
> >  whether the Class Code matches PCI_BASE_CLASS_DISPLAY.  If there's
> >  at least 2 GPUs in the system, invoke apple_set_os.
>
> This also looks like a good idea, but I'm not well aware of the pci quirk=
s in the Linux kernel. So, would consider it a bug report for the maintaine=
rs to fix.

That is not how it works.

This is not a regression in Linux, and even if it was, it is not the
maintainers' job to fix bugs.

If Linux is lacking functionality that you find important, please
propose a patch the implements it, and argue why it should be merged.

