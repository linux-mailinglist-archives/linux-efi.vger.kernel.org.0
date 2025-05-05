Return-Path: <linux-efi+bounces-3589-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F2AA8B87
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 07:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7001892712
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 05:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2314A0BC;
	Mon,  5 May 2025 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exmGiryL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AC139E;
	Mon,  5 May 2025 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746421700; cv=none; b=X+A1M5h98/ApxVFKispHsCQp4r7z0wvo2XPbiWIWpHy4Cmo7PeYemtlfdOowLemh95gqPvelFKtANnu0x8n/HAgX2PFXKFf0Ye87zCN9M+8oL+9eSGozxRiJz3hpHJblzT+KsQIYZZ2KR3yEjiNKyPghGLsXLiQ5y+gsPAkOirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746421700; c=relaxed/simple;
	bh=BfERElOtc/victv+YVhmT09PRXBQfeRmJhOGq28EXYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWkyS5G5cqUWT1qj9BgIwlc5hXwkiVkFhAB3rcsntVRgcvZeIlOVd0irvoiUsw+ir1H/9c34Bs1ReZx0QQyxpLIZULUiHE95iokrbATCKVQgDcDjqg534/UJKxEuHb+mkXpJx6ErALDl6UBL3y3pjGuXYGIIz21Oc6M92GOFefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exmGiryL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C021C4CEE4;
	Mon,  5 May 2025 05:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746421698;
	bh=BfERElOtc/victv+YVhmT09PRXBQfeRmJhOGq28EXYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exmGiryLJY7+m/IER+kywI4fauBXrFx+LHgG7QMeGQ3VYHU9dGMrjR3L0sMbaXxrs
	 mQ69H30mFZxcyuTS8WTnxPBGf67VlCBFvis7zaKyTL65JLGg2TPna8qXrLhK7XHA3O
	 Dhv3I5uQ/MNFf1gy8M+cyuo02CFrgoq1Yrq0sGbXy1duDWPdiuaI4X3tKK2d2q6O7k
	 tcPTb6zh9GEBLw/u2b5ioId4AaGjPuuGuLYSBc/BmaQ9cK1ew3z65b9lIbf+w0GA7R
	 YzsAGj/TMVw+NehwyeH0t3NncC8PVJbwPomsgYbCKyauuVRCVGknApySR+ua/L7v6I
	 l6FwehStrMJFg==
Date: Mon, 5 May 2025 07:08:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
Message-ID: <aBhHvRajKQ7BkmeK@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <aBdz-4hJu0zp40mC@gmail.com>
 <CAMj1kXE7Ctbsu+z2WST9s22NFvPVXoymPfidjJSXgdfvtWZVxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE7Ctbsu+z2WST9s22NFvPVXoymPfidjJSXgdfvtWZVxg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sun, 4 May 2025 at 16:04, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> ...
> >
> > So to move this forward I applied the following 7 patches to
> > tip:x86/boot:
> >
> >         x86/boot: Move early_setup_gdt() back into head64.c
> >         x86/boot: Disregard __supported_pte_mask in __startup_64()
> >         x86/sev: Make sev_snp_enabled() a static function
> >         x86/sev: Move instruction decoder into separate source file
> >         x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases
> >         x86/boot: Add a bunch of PIC aliases
> >         x86/boot: Provide __pti_set_user_pgtbl() to startup code
> >
> > Which are I believe independent of SEV testing.
> >
> 
> Excellent.
> 
> > I also merged in pending upstream fixes, including:
> >
> >    8ed12ab1319b ("x86/boot/sev: Support memory acceptance in the EFI stub under SVSM")
> >
> > Which should make tip:x86/boot a good base for your series going
> > forward?
> >
> 
> Yes, that helps a lot, thanks.
> 
> Please also consider the patch
> 
>   x86/sev: Disentangle #VC handling code from startup code
>   11 files changed, 1694 insertions(+), 1643 deletions(-)
> 
> It just moves code around, but it is rather large and is likely to
> cause merge conflicts if it lives out of tree for too long. The +/-
> delta is mostly down to the fact that a new file vc-handle.c is added
> which duplicates most of the #includes of the file that it was split
> off from.

Sure, applied, will push it out after testing. I almost applied it 
yesterday, for these exact reasons.

Thanks,

	Ingo

