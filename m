Return-Path: <linux-efi+bounces-5514-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D4C5C57A
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B66B635EDF0
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22E2FE560;
	Fri, 14 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ4YGEiZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29738306D58
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112832; cv=none; b=tgvwZHejS6sHB5I1DTDZuQ8Ly0SI+sxNNGViR85Zm7WTbuNunf/yZ9+iMRsNyvt2ovb20MSqpoam8KGko1rMMaNWGO7jby01g5xRpTjfKx5qwmTEDvmVfSOCmonKYyE39t8a1X63AOlRswDdIaPDqVBY13p5ECpcJVETeUGBe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112832; c=relaxed/simple;
	bh=XiBSb7FH3zCffmam4wmviNPr+VJUJFbNKxuRVSO+b6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLygPelW23bEfCIAEto3OddgONF1oCFNZVI8VzjGIn3olxf0C/YYI9U0GMVdEhEcpi6NeAq1/r/ddRkGswkQBVareFTAWiTGFrL3XX0GUsKWPapuOEtgE5xynY9HWtyiT6Rj6hQ2jSoJlO4oFiDWYcXXvc4H2sgKW0oy9kODkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ4YGEiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F236BC2BCB0
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112832;
	bh=XiBSb7FH3zCffmam4wmviNPr+VJUJFbNKxuRVSO+b6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QJ4YGEiZuxUGLGNujd6UBqA1q681ZmbCcZqGh0YdNUSMJrzAavugWvmuk8dzC/407
	 IaO2b2ev5cnfH8UKg0zMn1HHqa+IVHh6gQjT8i9Uv5I2ZLvgrFaOkZfJLV7HTbCSHc
	 1XNaKOENrEei7rLBr2srMeFcMpL2wLbuSJmdki18QgreIHRc9EgzVzaoWNiYjCPWyv
	 D9naXYmL6+xspHY/1+Scu8S+a/eslSBtipy+OOwtpZ+R9tnRIZLY7D96hP/lv4xT8d
	 QLDZmvgFIqabzm76XWQKjs/LgQ5Qa+vo6FcHeMcb2qm/9u+CbiG4RYgv7eL7wMO2em
	 YJY0skWz/rwuQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-591c9934e0cso2432260e87.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 01:33:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2Sr93LYwG8nT+ofvMw5KhXNPYQz+xTdJ7PH2Ae6RBYIm2IDI+RrzjSg8P3aZI8Eixdg049K20iGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprrZaGForH3CBcp0FHFII2crg0zM+uKEfuARuqSJ473U0ef+8
	Kzc7WJUpo/APN4iCHbHhsvGSlSMOpMOYTwdXo8OukxJo+uexemGn9kfLm+CtyVBES4BlGQsP5LK
	mNT62AaQl5czxMfNdFq2yRL54NOu37Jg=
X-Google-Smtp-Source: AGHT+IGujLpOpLR83xupoHypQEytbFSL4y9j6Fw3w9j/upVEUGIaFlG0mTpVZsRWJhHZ7VHr6/NDwhAoVLJgrSeOE/4=
X-Received: by 2002:a05:6512:10cb:b0:591:ec83:3183 with SMTP id
 2adb3069b0e04-59584228369mr894551e87.57.1763112830189; Fri, 14 Nov 2025
 01:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
 <20251114085058.2195900-3-sumit.garg@kernel.org> <CAMj1kXE4Fo3i9f3npB0MBSOZP0x7HgF4A0KX_aUSBEBmar=NpA@mail.gmail.com>
 <aRb2_OmkRTD46vnx@sumit-X1>
In-Reply-To: <aRb2_OmkRTD46vnx@sumit-X1>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 14 Nov 2025 10:33:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFpi1fMuAhuaBbMSd57F79E7Z0u4okzkKL+_6eKfGUKXA@mail.gmail.com>
X-Gm-Features: AWmQ_bndnOT6-BvSjcKok_Oi36VTIAD_k4KIdOomr4Jh-VHDQmhl9S7HHNsrKwY
Message-ID: <CAMj1kXFpi1fMuAhuaBbMSd57F79E7Z0u4okzkKL+_6eKfGUKXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: efi: Pass reboot cmd parameter to efi_reboot()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, shivendra.pratap@oss.qualcomm.com, 
	leif.lindholm@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 10:31, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> On Fri, Nov 14, 2025 at 10:26:03AM +0100, Ard Biesheuvel wrote:
> > On Fri, 14 Nov 2025 at 09:51, Sumit Garg <sumit.garg@kernel.org> wrote:
> > >
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >
> > > EFI ResetSystem runtime service allows for platform specific reset type
> > > allowing the OS to pass reset data for the UEFI implementation to take
> > > corresponding action. So lets pass the reboot cmd parameter for the EFI
> > > driver to determine whether it's a platform specific reset requested or
> > > not.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/kernel/process.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index fba7ca102a8c..51784986c568 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -136,7 +136,7 @@ void machine_restart(char *cmd)
> > >          * ResetSystem().
> > >          */
> > >         if (efi_enabled(EFI_RUNTIME_SERVICES))
> > > -               efi_reboot(reboot_mode, NULL);
> > > +               efi_reboot(reboot_mode, cmd);
> > >
> >
> > I agree with the general principle. However, there are already
> > existing callers of kernel_restart() that would end up passing a
> > random string to efi_reboot(), resulting in platform specific reset
> > with undefined result.
>
> Yeah true but the UEFI spec says:
>
> "If the platform does not recognize the EFI_GUID in ResetData the platform
> must pick a supported reset type to perform. The platform may optionally
> log the parameters from any non-normal reset that occurs."
>
> So, in these cases the UEFI implementation can fallback to normal reset
> optionally logging the reset data being passed. Does that sounds
> reasonable to you?
>

What the UEFI spec says might deviate from how real platforms in the
field will behave when being passed a reset type that nobody ever
tried passing before.

