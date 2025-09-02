Return-Path: <linux-efi+bounces-4669-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0589B4008B
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63996544344
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9782E5B1F;
	Tue,  2 Sep 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYkyzCKE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FF2E172B;
	Tue,  2 Sep 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815885; cv=none; b=lvXfEv6O8H3PBF9eXjS4GR66RLkplU51xzVFisC66eFiqGLMo92VgoL8Dt2Wsbs+cZJm8r8CxQoH4nkxeWxiE1uS+FT8MEPaM7dhZfM7uyMIyPCA/bPUuA+LAOQp7V6c12BdmpLVN90D1ALPMp02kEgTE0D2vgLOhMROCkh2GBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815885; c=relaxed/simple;
	bh=rZv4I7rYDL6YjF6t2ZcCqK5+V44EkkaBs7e289lpm0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUnstVM/nWx/vz3eiuB1vvZzUjbdzQOL1bcEH+n/oWEEi0OutGQeOkAn0q5ejhGLlT7ES9ecrEBwrQJJPvDwYCOJCqKtKJ/7cd8EkILc+j6R+dFMHb2iTAMa5X6ZBLpeAcerV5mj4+iJroYeE1NdE0ZDoqenQd0ljrHu+L7jXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYkyzCKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F21C4CEF9;
	Tue,  2 Sep 2025 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815884;
	bh=rZv4I7rYDL6YjF6t2ZcCqK5+V44EkkaBs7e289lpm0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SYkyzCKErj0vHjkXMlivm/3pjIAMMf+bJu4IguGNc9PCrlNXI8EWc/+oCJ5qUC19V
	 r5gewW5fabaBzLS4JARkUN97m5KRMXNvM8gQkHPcc7LsXdgqv/Oc1RnFD3zII+0hYb
	 FpVEcItMxDS/Nb3ao2ABT50/NdzohlieNABT9jiT40hk5IuarmOV50mXNw2vPkKNBR
	 jxI4Wbe3eMGHJ/NoRWDKDhKq3LDOCKw10m9KF5H/ee59ukpSh2ZwbrQGCoqYsP/cpB
	 hu4GOzm4wWWk0geazmrikNlJAqUP8LM7VK+7Od9UzkGEtMHw1co10xvMI+GRATcAND
	 GpRYhi8eL8isg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so1896072e87.1;
        Tue, 02 Sep 2025 05:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURVDuIgyne1nw4qnV4aTWj9cuJ9/TH43p7lK7KekvnVZNp80nc6ZNxDi3T3TsxbxZjM20wIEsFEZ4=@vger.kernel.org, AJvYcCXo9JhkcS8StE1tmIHT/1ytBQJD9ybjQNpRiuDziDmEoF2clU/DIiPVFJeR3pGkRHJwNObDMc/lgLQESNvy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmRB5nTDk60lXiGrkAG4ITWCJ+CuBgZ1CLd4shz9Q/x09oAtM
	Jls9Dz4vfWrneLY3X2Xpmrja5cKPEOcxknXU4tGOyotr1QZkNXmNV5fZKYq2rbDzelGJOCupkQv
	L1aEC4P0RtKT7LDqEsyBFqgkw0F0flyw=
X-Google-Smtp-Source: AGHT+IECiPX03/QZqNVE9rU0XP4OGNVxyVywxo2pznP31QhpZ58f7na947xSfCVTxS7TqssjQmTyHgB0ZmNH3EoiCZk=
X-Received: by 2002:a05:6512:1095:b0:55f:6457:1931 with SMTP id
 2adb3069b0e04-55f7089c6b9mr3850521e87.3.1756815883077; Tue, 02 Sep 2025
 05:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-36-ardb+git@google.com> <20250902120648.GFaLbd2LyZYkQ4l8WV@fat_crate.local>
In-Reply-To: <20250902120648.GFaLbd2LyZYkQ4l8WV@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Sep 2025 14:24:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGiy4XU0nrPU9UL3C1KHDznim1gj=P-MabVu=D59k3Fww@mail.gmail.com>
X-Gm-Features: Ac12FXxfKaD09GSFE_CDkKG9WW-EwtKXdsqZ9NQqW8brqgQpgDx6hB_TtdO8EuM
Message-ID: <CAMj1kXGiy4XU0nrPU9UL3C1KHDznim1gj=P-MabVu=D59k3Fww@mail.gmail.com>
Subject: Re: [PATCH v7 12/22] x86/sev: Provide PIC aliases for SEV related
 data objects
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 14:07, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Aug 28, 2025 at 12:22:15PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Provide PIC aliases for data objects that are shared between the SEV
> > startup code and the SEV code that executes later. This is needed so
> > that the confined startup code is permitted to access them.
> >
> > This requires some of these variables to be moved into a source file
> > that is not part of the startup code, as the PIC alias is already
> > implied, and exporting variables in the opposite direction is not
> > supported.
> >
> > Move ghcb_version as well, but don't provide a PIC alias as it is not
> > actually needed.
>
> I see
>
> SYM_PIC_ALIAS(ghcb_version);
>
> below.
>
> Stale commit message?
>

Yes, as a result of

https://lore.kernel.org/all/20250530165507.GBaDni69NqgOi4mFNn@fat_crate.local/

it was exported but I failed to update the commit log accordingly.

