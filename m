Return-Path: <linux-efi+bounces-3687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DCAB5699
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90874A2D62
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73CB28DF28;
	Tue, 13 May 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkpKe4JD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2D1D47B4
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144706; cv=none; b=lqhAVlKFCd+rbte4RVvI9SzbtY8Nli6sBvIdHfzo/ZICmtuuHlPXyx/GBrk+L2inPuzoppa5JUzYAoWm8rOnPuq/iOIXuPI1DmPbRodoJHKIPX+Hj1Cny5cUUJDaWwb6h9sLE+5r0CqjVC+vC5+4IBy3SIkg/cd+nYefJbW0r9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144706; c=relaxed/simple;
	bh=DT2puAqqGRYJ86uM1ZdtR9j4iIoQ7OJyLvoBz/7ueYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Z6avhSB7fP1hDLKGqG4MVCSUoHdjf7dUbksTFKqI0QtoD9pfXbTpiOtILTpRBhvMrnZKXKU+1bM3zRS/JTIcfWzhmliZ3kExMBEkfWqQfdHkoy7TRHFEq4Gy6qrPqfYQ/Gp6kgnWzVVvl7P6CLZGNBjb/lrHAPIrTsyi6L2+xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkpKe4JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F002C4CEE4
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144706;
	bh=DT2puAqqGRYJ86uM1ZdtR9j4iIoQ7OJyLvoBz/7ueYc=;
	h=References:In-Reply-To:From:Date:Subject:Cc:From;
	b=IkpKe4JDIdHGxN2xeRP+7jWhRJayfL6uQndEMWSiM5thUkLfA7YcZn62at210YT6P
	 ZD7b6Bes61QoJhexGoj53Lv+qWFJWtSWal5eBoeouCKx0seIktTn1jkBKmmJuS3s2z
	 VJ7HWQ4BYaiu+tZlYC5pj0B9LOIoRd1ikIYBukaFzDEQpBBx9R2d9TBHeBnu85a6ks
	 kmswYq5lpirq8jNvgzPOmTRG501BXu9n++K3GNfDa+WrYX2itWsORdiNetEeH4hkzS
	 Dmc7pjj2/B4oPLtJVtdUdO7GaB5Cjwqx2babaWOIT/sgK9VI9ailnrcBmV/hSK8RXT
	 cgcrg4k8tpCSw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso59272391fa.3
        for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 06:58:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjw+LCBpcEfmOA8BO1MlVo9j/Yz4E6/qo9aqfd1agInC8rNg/BXDiGlM9954l8YsOy9r/EYKArwvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwSyrt/a7/++5SDlhRGDgnlUFsz2idkhOi4JJEwYyPWqLCtMb
	NIJ3yaoIiUWoCdXYMRcjdY7+9VjjdI0h7ACWw86w7P38DuecBqsP8xh/XvKSynK/huMrTLnGd44
	wtJI7RtA3xWBH973NxOvLldn2NDI=
X-Received: by 2002:a05:651c:210a:b0:308:eb34:103a with SMTP id
 38308e7fff4ca-326c46813c6mt81209331fa.28.1747144704565; Tue, 13 May 2025
 06:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-32-ardb+git@google.com>
 <CAMj1kXH5C6FzMyrki_23TTk_Yma5NJdHTo-nv4DmZoz_qaGbVQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH5C6FzMyrki_23TTk_Yma5NJdHTo-nv4DmZoz_qaGbVQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 May 2025 14:58:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE_aQm7w05Mck0umYzA8uH+fPb_FoJjO3XyB5NdznveeQ@mail.gmail.com>
X-Gm-Features: AX0GCFv6f3yl3-9AjZqDf1RNZHGIOD9S7UgBg_hQmhBxEoniGVxa1RI9wHJvPJM
Message-ID: <CAMj1kXE_aQm7w05Mck0umYzA8uH+fPb_FoJjO3XyB5NdznveeQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 09/21] x86/sev: Pass SVSM calling area down to
 early page state change API
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 14:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 12 May 2025 at 20:11, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The early page state change API is mostly only used very early, when
> > only the boot time SVSM calling area is in use. However, this API is
> > also called by the kexec finishing code, which runs very late, and
> > potentially from a different CPU (which uses a different calling area).
> >
> > To avoid pulling the per-CPU SVSM calling area pointers and related SEV
> > state into the startup code, refactor the page state change API so the
> > SVSM calling area virtual and physical addresses can be provided by the
> > caller.
> >
> > No functional change intended.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> This patch is broken - I'll send a followup fix asap.

... or actually, the one before it.

