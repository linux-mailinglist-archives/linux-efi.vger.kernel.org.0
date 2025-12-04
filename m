Return-Path: <linux-efi+bounces-5795-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AFCA2FAA
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96B9302852C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4AB33508F;
	Thu,  4 Dec 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXMJFlx5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CA326921
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839863; cv=none; b=G+kZJBh3fX6s0P13RGwbNteaFfHQIi2s5jJ6ukTbNEJluSYYduLNFGx48Y0Ylsrj0M28kenF3IB/YycjQapiYpAWEeQG+DaTp9y5wM8OBM56/Kab5fDlwJG3JiCGvuEzouMLCbpxW98wOtx3b1p/motTfjSn/jt5OB3eteBTDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839863; c=relaxed/simple;
	bh=bdxR7v9DL4giaQ0nD6cGSOn8HPdLK+CBHB+mv5p51TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRwrzqEVKMtJ8+iMtaGwHYY/B5a8BgX9H6mt4VTYpU6r2n/t4Qvn4Z/W3VJm1GdMCut2w9IRkAopfodFjssKA0XABrIDRvREdWHJrxlrMB3/wF3YupTKmwM0rmoKJhiKceJcIKNlfbJlgA5CeCJ2dzM7wFBt5+RjfRKcHbPOfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXMJFlx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B4C19423
	for <linux-efi@vger.kernel.org>; Thu,  4 Dec 2025 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764839863;
	bh=bdxR7v9DL4giaQ0nD6cGSOn8HPdLK+CBHB+mv5p51TE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lXMJFlx51rTedas29KHnOrmyDSqkZ9OMYrKSulTiX57PBwHm2eQiqLevCstNDBnVT
	 nCVGTNp7fzETozRNuQAA5mbYmXhdurch8QsIn1ts0SUX0878qPP6F5FVDYrBr3wT9W
	 AkgTKbQXFCzm1WMgZMKHaINZLTSqwLCCAD0dAxU5Kk45tsxO0uZPJvt91vcWn+0bYC
	 C2IgMJeK7my4B4xpP9tsR0pWBNKZ4d4GMAlf00wpJGT2bjit1qFoztrZDlC8sl6QNP
	 7TWkDlYiX/OoujuaVpQfW9eeV92YLP9lkU3JZRQx/bEk4561i1k13l8QYbKxWEI4oz
	 nLySSoiGo2EBQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b96cbd875so5204781fa.3
        for <linux-efi@vger.kernel.org>; Thu, 04 Dec 2025 01:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa0ThNUx+35ce442Dt4v5A7a2flhrm2RPQ4coemumHsgxUNyU1xq6fSMG44gVH6OdT2ksKWrkL+E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnR4ZAq82d20HcaUOelO4O/MvI43udLWlRYDJN62SpQrRJevQ
	zs67jpHjBnF/tjf1a6ef73aXXegx13+CpV6gXlccvvM7Z+OiOW8o15cCFXy8t5K8hZGycLxIEdw
	qc59pTGvnlod7RayTbV8LEdNtLA57TII=
X-Google-Smtp-Source: AGHT+IEepIIomfWFRr0Rx3UmKjb+4HGFPEe9u/4871RbpTRAjdKjp2QqrAmQWNspq2CaP1lGYKWgUBnucw5FQcFMAE4=
X-Received: by 2002:a05:6512:3b0e:b0:55f:4633:7b2 with SMTP id
 2adb3069b0e04-597d3fdddf4mr1972090e87.46.1764839861912; Thu, 04 Dec 2025
 01:17:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126160854.553077-1-tzimmermann@suse.de> <aSe1ZBXa3JBidhem@r1chard>
 <fc4ea259-3389-46e2-b860-972aa8179507@suse.de>
In-Reply-To: <fc4ea259-3389-46e2-b860-972aa8179507@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Dec 2025 10:17:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE8Q6FGX5+64gPyW=ExicR4UbnEDeW4ycCsSsD2WtaYJA@mail.gmail.com>
X-Gm-Features: AWmQ_bm9xn92SSdHRbzJXHCDOFUkHMVJIr0kEdVYpgmMwEspup4WiDKMgeR24mo
Message-ID: <CAMj1kXE8Q6FGX5+64gPyW=ExicR4UbnEDeW4ycCsSsD2WtaYJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] arch,sysfb,efi: Support EDID on non-x86 EFI systems
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Richard Lyu <richard.lyu@suse.com>, javierm@redhat.com, arnd@arndb.de, 
	helgaas@kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Nov 2025 at 08:43, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 27.11.25 um 03:20 schrieb Richard Lyu:
> > Hi Thomas,
> >
> > I am attempting to test this patch series but encountered merge conflicts when applying it to various trees.
> > Could you please clarify the specific base commit (or branch/tag) this series was generated against?
>
> Thanks for testing.
>
> >
> > When testing on the next branch on commits 7a2ff00 and e41ef37, I hit a conflict on PATCH v3 4/9:
> > patching file drivers/pci/vgaarb.c
> > Hunk #2 FAILED at 557.
> > 1 out of 2 hunks FAILED -- rejects in file drivers/pci/vgaarb.c
> >
> > When testing against 3a86608 (Linux 6.18-rc1), the following conflicts occurred:
> > patching file drivers/gpu/drm/sysfb/efidrm.c
> > Hunk #1 FAILED at 24.
> > 1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/efidrm.c
> > patching file drivers/gpu/drm/sysfb/vesadrm.c
> > Hunk #1 FAILED at 25.
> > 1 out of 2 hunks FAILED -- rejects in file drivers/gpu/drm/sysfb/vesadrm.c
> >
> > Please let me know the correct base, and I will retest.
>
> It's in the cover letter: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5 The
> commit is in linux-next. The idea is that the EFI tree can pick up the
> changes easily in the next cycle. linux-next seemed like the best
> choice. Best regards Thomas

Thanks. I will queue this up as soon as -rc1 is released.

