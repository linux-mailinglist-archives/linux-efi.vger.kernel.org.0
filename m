Return-Path: <linux-efi+bounces-5515-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48952C5C57D
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF34C359C75
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94698306D52;
	Fri, 14 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSLVycc1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023A302CB6
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112948; cv=none; b=FWEmaJRoPktUWos95hkYXdUhNof9Yz9W2VQ7LpXsDS+rQQQDd1AjRuo28vSdF/zMEivFt7ZEkAsXwkmjMTrzgyDbnaSE607o9ZBUGnONVgJLqWHBgfLir8EaxJ5ZD+gJ1+BuyTw26LZg/MtcLXb5xyMHCZIEgbtKIuv9gAJ7nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112948; c=relaxed/simple;
	bh=IMgsq5NLDauGbubQ+vg0+EcdIkmlxJGaT+Z86MVPqmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZU3fpqp9Txc/AOdMw9J6oaT4iJfKv6FkuzZWJXzlU2Vlv7sPpYQ9zi15ejLdEoBx6V1nWwTTmnzskeEdja+HcYPpq/3thWtvwsGDar4uiTe0tGXHiq249f45rNIFL3buOVpAL4XwBmAvI2SIcqdtsYvcOUI6RuSuxs7SKwWSiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSLVycc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B94C4AF0B
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112948;
	bh=IMgsq5NLDauGbubQ+vg0+EcdIkmlxJGaT+Z86MVPqmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YSLVycc1S0+SdvWrf6SD7ReLZAfdPsQBV7s9i7tNf87Hi/G6ycX+QNOov7yclVaN4
	 SpZcukTTtBvNAx3ErZfltD5hyx1PiQ39eMGdaYorX8OdmyOBR6/TdRlmekzKYfKZwN
	 0+t2PA2QCbRRvBdZXGkudcKxyGUbZVymKvjwQnWMAi9uxzQmV7m+WKPHna3iaiY9Cv
	 LnbHjc/+RzWrVTxGwouoxmDr4gwugy1HyVytHjTIsG0wMCkk24OoOOFtkBi/us4Q52
	 jDGa4KduVPQ0QGiI8j85Mz04cv3Dffq++gtmfWYP8uEPM26GnNcBq/OApY2ypYjIRN
	 JadPvlQLYv9WQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59447ca49afso2299654e87.1
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 01:35:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwQjPrimuDIQQOtaZGF5WrVh5dvpfNla2tGKexzn85J5f+T63slA9BkA11okgJrFrHjH1TcWOt3Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrBWnIdGSPg6/gu2+sawhWCkMHo88EEkTsms7ExdlvotB0SAI
	zEcbalti4EephhQ1RrGLpsIwnAvxm0yeIBHn7jxXYhQC+QWw5gMUb4X5vU+/5fJcsV7jh6nZpS0
	CUeIZQiyGF6sFhS79VAE8mfsZPVds8Ko=
X-Google-Smtp-Source: AGHT+IH3q+2BE/eD662R1z0CWOc6ecdAgWhnq7pJgLc5m17wfewBjL0ZutIWUMnpAZTqy6QF6uuUeiEciESCDMRcwY0=
X-Received: by 2002:a05:6512:3d25:b0:592:f5f9:f5a9 with SMTP id
 2adb3069b0e04-5958423edd9mr728749e87.36.1763112946284; Fri, 14 Nov 2025
 01:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
 <20251114085058.2195900-3-sumit.garg@kernel.org> <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
 <aRb2_OmkRTD46vnx@sumit-X1> <CAMj1kXFpi1fMuAhuaBbMSd57F79E7Z0u4okzkKL+_6eKfGUKXA@mail.gmail.com>
In-Reply-To: <CAMj1kXFpi1fMuAhuaBbMSd57F79E7Z0u4okzkKL+_6eKfGUKXA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Nov 2025 10:35:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE60LrWi8Au6qQ4EMQDFxQCJt5h6hBLuQHCz3HEp=2o3w@mail.gmail.com>
X-Gm-Features: AWmQ_blTsMQdIWNQKj48AZxStQ80RvARP2VHX6V8vSoaIBC-53yr7HTzC35uPM8
Message-ID: <CAMj1kXE60LrWi8Au6qQ4EMQDFxQCJt5h6hBLuQHCz3HEp=2o3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: efi: Pass reboot cmd parameter to efi_reboot()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, shivendra.pratap@oss.qualcomm.com, 
	leif.lindholm@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 10:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 14 Nov 2025 at 10:31, Sumit Garg <sumit.garg@kernel.org> wrote:
> >
> > On Fri, Nov 14, 2025 at 10:26:03AM +0100, Ard Biesheuvel wrote:
> > > On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
> > > >
> > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > >
> > > > EFI ResetSystem runtime service allows for platform specific reset type
> > > > allowing the OS to pass reset data for the UEFI implementation to take
> > > > corresponding action. So lets pass the reboot cmd parameter for the EFI
> > > > driver to determine whether it's a platform specific reset requested or
> > > > not.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/kernel/process.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > index fba7ca102a8c..51784986c568 100644
> > > > --- a/arch/arm64/kernel/process.c
> > > > +++ b/arch/arm64/kernel/process.c
> > > > @@ -136,7 +136,7 @@ void machine_restart(char *cmd)
> > > >          * ResetSystem().
> > > >          */
> > > >         if (efi_enabled(EFI_RUNTIME_SERVICES))
> > > > -               efi_reboot(reboot_mode, NULL);
> > > > +               efi_reboot(reboot_mode, cmd);
> > > >
> > >
> > > I agree with the general principle. However, there are already
> > > existing callers of kernel_restart() that would end up passing a
> > > random string to efi_reboot(), resulting in platform specific reset
> > > with undefined result.
> >
> > Yeah true but the UEFI spec says:
> >
> > "If the platform does not recognize the EFI_GUID in ResetData the platform
> > must pick a supported reset type to perform. The platform may optionally
> > log the parameters from any non-normal reset that occurs."
> >
> > So, in these cases the UEFI implementation can fallback to normal reset
> > optionally logging the reset data being passed. Does that sounds
> > reasonable to you?
> >
>
> What the UEFI spec says might deviate from how real platforms in the
> field will behave when being passed a reset type that nobody ever
> tried passing before.

Also, the GUID is expected to follow an unbounded NULL terminated
UTF-16 string in memory, so we could easily cause a crash by doing
this if \0\0 doesn't appear in the memory following the string.

