Return-Path: <linux-efi+bounces-3215-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6DA7E931
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66AD18836EA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68021518F;
	Mon,  7 Apr 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzD183vC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABD4A02;
	Mon,  7 Apr 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048552; cv=none; b=kBzEQt0kg1Zbj6BwD4LnIrNnx197AHpVQnCUv2r4b0lMLcEgBZXZ5PTpt2imCzSpgiDZ/fAeejpGYoixWbtNZL6t6zu+rXSF1QFG2qMjGsfVbJdtO6RXTnL+eyJJ2syuHYvyl7yIzFmH1uXdwZhFQqa/J2arHHDldm3g8O679OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048552; c=relaxed/simple;
	bh=Pg930JW5nxcugmInTh7igLXOYajjfFWPU7R3nVZHPrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoFJZTqO1vqrSRuY29cBwdhEhNN2OI0wNCrQOsxEM6Ui8k8hmvF6oKIb6nXpCZHZGQJPhPFivPj4LhAzsrOpk+bYm7p5AoCyXLESEfvACLU2p1gHofmkz9bMCQQjcE8nbPMOBpqEGCQovZCoQf7Gb5E7404QSB13B2o6mOzM0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzD183vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3872C4CEEA;
	Mon,  7 Apr 2025 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048551;
	bh=Pg930JW5nxcugmInTh7igLXOYajjfFWPU7R3nVZHPrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bzD183vCIexwxy77uq52aMpNr5fAsXxYXMmityDvOQOByykYH9OFhImCf1E0uwG4C
	 XZpNv80RHs+7106QZ5KRk9pBePkjGqPBiNrSmYWc27REFbJvtRpfdycSHJP3JrS1qo
	 KytF/Rmx4ML74LhhJuf0w52r08qZ/ljFChMzKoyRYZ0Ti4Ao7VrXEqGkinAgGJnJTe
	 qh5BXxosMllOtCvlMrOaaE2jeMeAmSQczkSm92/oWYFHiBww6ozVxiN3TKPYG19x/f
	 ugFG8tOgSuX1wERUgoENs3JDDGmBQeNnYxUo92l0ay6XAm/j8iZJwDLqgFCHugfSys
	 ZR0oBL5Qw4b3g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54b1095625dso5615855e87.0;
        Mon, 07 Apr 2025 10:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqn9BRUUbI0FEeETtuCPdAsvZe/viwR0UbPf1qN83HpJ+sGbI1mrQzeepXpIGMUbpI0y94vehMV4o=@vger.kernel.org, AJvYcCWJ1Hh2HHhKpM0aei24PkUbjJyDl3iMgUbYxL81qGj7e5EIWvrO6UhGjh667gOAFB8/vPHNLULnzhXWv3Y3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TMYn3pApydRhxGWsLjXdNf+pGp0o+TOZJwzOE1VZ0fOtWzpx
	1Sg0JUsHWuOXIXxRNTpRSuu68Y801eKdkxAjVEnAHQy5LLOEuwO0NMd8dtQNVEBtq+ahZ8ZKnGt
	zSHyNpAcKR1w835okE9tUdL0HDhE=
X-Google-Smtp-Source: AGHT+IEdEeem2qww6h+mlfqXI+VdTLbGb7U/GYDtHtt2F8f2orSO/ivrnsb478dtK/93KV0+dHvK4WQOSD+tljhD2Q0=
X-Received: by 2002:a05:6512:b08:b0:54a:cc03:693d with SMTP id
 2adb3069b0e04-54c227709f1mr3644087e87.9.1744048549994; Mon, 07 Apr 2025
 10:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407061132.69315-4-ardb+git@google.com> <20250407061132.69315-5-ardb+git@google.com>
 <Z_QO8QybPCwzRwms@gmail.com>
In-Reply-To: <Z_QO8QybPCwzRwms@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Apr 2025 19:55:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGGpZp_OgUuQ2CkpJdDgsRzxuLz3wjesKxDyHvveuUqUA@mail.gmail.com>
X-Gm-Features: ATxdqUEdQydGu6MR2FN4j8yX9_xudRwUnFo5Ngw9VzERPkthW58H-FeESJ1QJb0
Message-ID: <CAMj1kXGGpZp_OgUuQ2CkpJdDgsRzxuLz3wjesKxDyHvveuUqUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/boot: Move early kernel mapping code into startup/
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 19:44, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The startup code that constructs the kernel virtual mapping runs from
> > the 1:1 mapping of memory itself, and therefore, cannot use absolute
> > symbol references. Move this code into a separate source file under
> > arch/x86/boot/startup/ where all such code will be kept from now on.
> >
> > Since all code here is constructed in a manner that ensures that it
> > tolerates running from the 1:1 mapping of memory, any uses of the
> > RIP_REL_REF() macro can be dropped, along with __head annotations for
> > placing this code in a dedicated startup section.
>
> So would it be possible to do this in ~3 steps: first the mechanic
> movement of code, with very few changes (if the result builds & boots),
> then drop the RIP_REL_REF() uses and __head annotations in two separate
> patches?
>
> Bisectability, ease of review, etc.
>
> (The tiny bird gets the worm, but I might have butchered that proverb.)
>

Yes.

And actually, the Clang boot regression that was reported indicates
that this statement it not 100% true to begin with. While it is no
longer necessary to use RIP_REL_REF() for accesses to global
variables, it may still be needed when explicitly taking the address
of a global variable and storing it in a stack allocated struct, e.g.,

void __init startup_64_setup_gdt_idt(void)
{
        void *handler = NULL;

        struct desc_ptr startup_gdt_descr = {
                .address = (__force unsigned long)gdt_page.gdt,
                .size    = GDT_SIZE - 1,
        };

In this case, even -fPIC may produce an absolute reference to
gdt_page.gdt, but from .rodata not from .text, and this is equally
broken at early boot.

Once all this code has been moved into place, I'll propose the
validation (similar to arm64 and EFI stub) which just greps the output
of readelf -r and checks for occurrences of R_X86_64_64; that way, we
will detect early and precisely whether the codegen is ok.

Please let me know which of these patches you are intending to keep in
tip/x86/boot, and I will respin on top of that.

