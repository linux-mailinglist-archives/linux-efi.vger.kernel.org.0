Return-Path: <linux-efi+bounces-5597-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A88C6AC63
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1092E4F0006
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C20361DD1;
	Tue, 18 Nov 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyNoXJq4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05813596F9
	for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484746; cv=none; b=IddaBYHPCx6XFffrFug3fUgO0fBIZtwrMb4jNQrUVfzE23ZtJnhIMcWERo3bnYu2rpXSzhStMjWahejrp48tKGH2nlwLjUUtQzd910bwFhfjUhmaM+aWeA82i0bWxeSta9ui7TJ4OxoaiQLec1MoJxQnJyMZEBMDdXOrA3yyhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484746; c=relaxed/simple;
	bh=/UYbgwArONFdvk5Zr+rtS+c/GYFVhvmgd+R153ybqGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLsvBC94qB2tM3ZSuEGLHAqZzhEnWH3sijOzY8b1AOlBygW9t6NvGegqcbiykGwxjzu7NXSQh3Z0D+We6DbjuA1cB0B3POR+YIXrlC3StY8FpXBFSg1bj9zUisywl3YzH+s3iOpS4g9kk56HoaOH5q9DYmiEV4z8wnBuddJvshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyNoXJq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51430C4AF09
	for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763484745;
	bh=/UYbgwArONFdvk5Zr+rtS+c/GYFVhvmgd+R153ybqGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SyNoXJq4jqfUAHQHyTiqEz9LkvLvKoyPVCWUygPrHGjdxKHyZtAh/0rofTzJJiOJv
	 QGO+N1GFrcndODXDQtyA9Dl2ctgZ2+jylsXszcIbvDGH4w0h8DTt0XIeOKhd7+US09
	 CrXtRg5mV8GaB5E2zR5OJ0mWc28Zfk4b8cPEm53PQHe+mYFmbd7POgX9ZvlJpR1hhh
	 4RGuABPqVb0/iFJ5EyIL8Y+saWmcA/nIaOGbGGCRo7bZV/ChfeoRXxqpDJ8TIrdgQS
	 LChIeLsq1jTPXzdxRQ2bu9s0O8VjH9kqHedUmRjvPZ7DpokZv5mHagSS/aFRZhJU0z
	 0ryOx6wYUYWoQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5958187fa55so4284436e87.3
        for <linux-efi@vger.kernel.org>; Tue, 18 Nov 2025 08:52:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjM3bRuX5Ap0et/nb4U9YCwDp2SxZYIUoMqH+f3jQXurV8FjN8dwq7ZGs+TEk3taEXBXCValIIHJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRlIN6yeRoIj0xiwwhorK4K4uKq+LGo0wt2fDQffljHp+21xD
	0xQZcr9m6zHUqoBFcHe0Is3Pj5n1AsyeZTPuVl+gQoSeGJglT1VECR92DP1hfobtLt7sIWRlnVA
	sVAIaf6rmXfCBptBJaI+GE+ali5IQekQ=
X-Google-Smtp-Source: AGHT+IFksk9/clMmZi7mOOu8rAadkOumT7VeVOL++ibIDj8QdKllEdllcxF8SVt5pBbMxZLv1hClzabPHWc/9O7alyo=
X-Received: by 2002:a05:6512:32ca:b0:595:7e2d:986a with SMTP id
 2adb3069b0e04-595841b664emr5509917e87.24.1763484742954; Tue, 18 Nov 2025
 08:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015160816.525825-1-tzimmermann@suse.de> <CAMj1kXF62pEMUJAM12HnF7qMt5xhZaZXpPoMdebMUKCfoAYisQ@mail.gmail.com>
 <b6801420-6ae4-44cb-9d86-e9353a2a59d8@suse.de>
In-Reply-To: <b6801420-6ae4-44cb-9d86-e9353a2a59d8@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Nov 2025 17:52:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHKc4jJnQ9x+sUhAO54PeZ6QN6yzcHVTovGvunp2QYnDA@mail.gmail.com>
X-Gm-Features: AWmQ_bl7etIV5p_8fkgiaE4DIbmT-ztJJoP0b_jbGjWYhamjdP8Q_QlshQ_xgdY
Message-ID: <CAMj1kXHKc4jJnQ9x+sUhAO54PeZ6QN6yzcHVTovGvunp2QYnDA@mail.gmail.com>
Subject: Re: [PATCH 0/5] efi: x86: Provide EDID from GOP device
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jonathan@marek.ca, javierm@redhat.com, linux-efi@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 09:02, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 14.11.25 um 09:31 schrieb Ard Biesheuvel:
> > On Wed, 15 Oct 2025 at 18:08, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Add support for EFI_EDID_ACTIVE_PROTOCOL and EFI_EDID_DISCOVERED_PROTOCOL
> >> on x86. Refactor the GOP helpers for EDID support, then retrieve the EDID
> >> into x86 boot_params.
> >>
> >> Later boot code copies the EDID from the boot parameters into the global
> >> variable edid_info. Graphics drivers, such as efidrm, can pick up the
> >> information from there. In the case of efidrm, it provides the EDID to
> >> user-space compositors, which use it for improved QoS on the display
> >> output. Similar functionality is already available on old VESA systems
> >> with vesadrm.
> >>
> >> Tested on x86 EFI systems.
> >>
> >> Another patch is required to provide EDID on non-x86 systems via the
> >> generic EFI stub. The implementation can directly build upon this
> >> series.
> >>
> >> Thomas Zimmermann (5):
> >>    efi: Fix trailing whitespace in header file
> >>    efi/libstub: gop: Find GOP handle instead of GOP data
> >>    efi/libstub: gop: Initialize screen_info in helper function
> >>    efi/libstub: gop: Add support for reading EDID
> >>    efi/libstub: x86: Store EDID in boot_params
> >>
> > Hi,
> >
> > Apologies for the delay. This series looks fine to me, although I
> > would prefer it if we could make things a bit more generic?
> >
> > Everything you are adding here is arch-agnostic, except for the bit
> > where we use x86-specific plumbing to pass the EDID info between the
> > EFI stub and the core kernel.
>
> Attached is an RFC patch that I already have. This would be the next
> step for EDID support. I've not yet sent the generic-EFI patch, as I did
> not have opportunity to test it. The patch addresses most of what you
> ask for, I think.
>
> >
> > More specifically, could we do the following:
> > - move struct edid_info edid_info into common code
>
> edid_info is related to screen_info, so it follows the same conventions.
> Arnd Bergmann made x86-specific changes for screen_info in commit
> b8466fe82b79 ("efi: move screen_info into efi init code"). x86 has it's
> own thing, sort of. See the attached patch for my non-x86 solution.
>
> > - pass the detected EDID info block via a EFI config table instead of
> > boot_params
>
> The x86 code uses boot params for screen_info already and also transfers
> edid_info on VESA systems via boot params (or if grub set up boot_params
> for us). [1] It's all there and working already. If we transfer
> edid_info via config table, we'd need extra code on x86.
>

I understand the x86 already uses edid_info for non-EFI boot, but that
doesn't mean we have to introduce new dependencies on legacy bits like
boot_params to the EFI stub.

For generic EFI, I don't think it is necessary to clone all the config
table logic with GUIDs and stuff. Instead, given that the EFI stub is
tightly coupled with the kernel anyway, we can just decide that the
config table has both a screen_info and a edid_info struct, and the
generic EFI code consuming the config table populates both.

