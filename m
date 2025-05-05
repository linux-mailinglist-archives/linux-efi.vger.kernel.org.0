Return-Path: <linux-efi+bounces-3594-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CBAA9698
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7473AAEDC
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0925D1E2;
	Mon,  5 May 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0OzNpU0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E225A2AD;
	Mon,  5 May 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456642; cv=none; b=BI4gBJFUivXvfuvqIw0/ewplt0S11KDHw2kHkqDGVOYRmUkzYh0ctbE4CQMG/lpKFtzTWfCCGybJJMyGlK0mXrwiA7ncrKJ+KTQXPysUyMyh2dunslAcsxLeU4lSgt9DNj4VC6IKaY4+rJJjfvzg/f/33UYDKt7OZqbLaLqqS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456642; c=relaxed/simple;
	bh=1iFA4MrHsrJes5ZE1QowgIQFPmdZzmWGGqNxsUPFh4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoAiMtnhnDtOW2mu7fLWZ5q17mbrnakGpEcQBTlpMQg22mHsuSvK+qV3aEhpL8yhO3Glv/1WhumRZBYGXz03pykQ9/yOyroX0dthowPq7ZO5OjBgD2QWMWHbDXuJGFCnY8bUcen/H0es7C+ES0jZhnVqMqzFoBNKGf8vqj+j+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0OzNpU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30208C4CEEF;
	Mon,  5 May 2025 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456642;
	bh=1iFA4MrHsrJes5ZE1QowgIQFPmdZzmWGGqNxsUPFh4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E0OzNpU0iKfYVt5HWeRDo6+O4e4UQCITUQJXznlokHfRbgJymNjpm/Z0+4AVVdcp2
	 cdczsXAqz065uby7iJTlMg1B5WsAPus2lTCCnrxL1HSAF1sK9en1bXxkEPTt5O/YV+
	 wDxCYWiM3hnB/Z0VFNGWT4DhEGbzBaoqwhEiPBcoqn3mczsKq+FaiX1aOBeZdpvUsS
	 w6mQ59Abi2hTmXl30+jOVEsfnpm4cf8KtNVM+tzysArcj3mGiYw1gqr9/gu8lrN1Xi
	 OXXUtFGptG7vymwr0D7Hj5JpsOX0RHr6arMGlaT7QioqYy7Mzgk89h43FKkXKar0Ys
	 p8uO0FiR9GLcw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so5269922e87.2;
        Mon, 05 May 2025 07:50:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg0iVwr+L3OJqvONp/PaY7JqplvuqoDI2kXu2cDNnaJBCnf3HB8yrsAYm+++6EdVxdtMMZVEVSuq8=@vger.kernel.org, AJvYcCXl0tQ5bTEGI0bbeP1axLyPiNry4sQSAdaQRkvGrZDpJj4QD4tcI1N89+XSUfdnYTOscbBIBCVix5csrpTP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JprMuHH7J45QHimSDL3Z/0FVeGk7mYhdwjcDz4rq/UMhYLtQ
	mhEpf2jR7EhY7nenF0iXRZOjcRWchLklKpvXwf4rFw3ZNGeh6mtiGcJN7CpJgLcwMD+sH2yg4p7
	er9p2GBgHjKxCkWwa51z9ahvoFiE=
X-Google-Smtp-Source: AGHT+IHA8epAlrtM8E4rWqur3uZXdyDd6GYi5xUeSJt0bNVPoW0NjLJT4Tn0TVYxCU8fmQ2U99kuAmE5X7y/KAm3gDw=
X-Received: by 2002:a05:6512:3d0d:b0:54a:cc25:dbe9 with SMTP id
 2adb3069b0e04-54f9f8732c1mr1906019e87.26.1746456640515; Mon, 05 May 2025
 07:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-30-ardb+git@google.com> <836eb6be-926b-dfb4-2c67-f55cba4a072b@amd.com>
In-Reply-To: <836eb6be-926b-dfb4-2c67-f55cba4a072b@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 May 2025 16:50:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPkaBGB9Pq715ChsKvaf1p5wpiL=0_FTvxjPKSwYUrGA@mail.gmail.com>
X-Gm-Features: ATxdqUEwpo5Pi-eDpro09vMUkVsANuInoVN_OnAMg-vm_xlezfMzpBZwJNZdEIw
Message-ID: <CAMj1kXFPkaBGB9Pq715ChsKvaf1p5wpiL=0_FTvxjPKSwYUrGA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into
 separate source file
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 16:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/4/25 04:52, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > As a first step towards disentangling the SEV #VC handling code -which
> > is shared between the decompressor and the core kernel- from the SEV
> > startup code, move the decompressor's copy of the instruction decoder
> > into a separate source file.
> >
> > Code movement only - no functional change intended.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile        |  6 +--
> >  arch/x86/boot/compressed/misc.h          |  7 +++
> >  arch/x86/boot/compressed/sev-handle-vc.c | 51 ++++++++++++++++++++
> >  arch/x86/boot/compressed/sev.c           | 39 +--------------
> >  4 files changed, 62 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 0fcad7b7e007..f4f7b22d8113 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -44,10 +44,10 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> >  KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
> >  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
> >
> > -# sev.c indirectly includes inat-table.h which is generated during
> > +# sev-decode-insn.c indirectly includes inat-table.c which is generated during
>
> did you mean sev-handle-vc.c ?
>

Ah yes - I renamed that at some point and forgot to update the comment.

