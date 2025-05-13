Return-Path: <linux-efi+bounces-3689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE1CAB57D8
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349243B57BE
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7228CF40;
	Tue, 13 May 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/gALtmW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F015ECDF;
	Tue, 13 May 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148483; cv=none; b=JuH5qgsRuQS2zveQOg2UEUSd569bhVj3w/zh6q/A2OlSUecqpfkbJZiRkts/uV+vHmiCunMCBH6vlV4SRRiEc1siu6qfR2SBrynZcD12CJzspXD4Qao8KCiPQQfgjC9IzfNWmCc2hjTmLBfyuLeKBbVlqnoLFM2CFEVzxVfO+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148483; c=relaxed/simple;
	bh=34s7YxmsaatctKTQbzFyxUDNZ+7apb5XXLKqnullZvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPyGw93IzTQ4ibny2tBJ0H/HnscfdOcIto3bSeDaUtIKnXa1iIYvl/1K1X7pGtm1Rr9V4prAxvHQ9jv916aTTXArPGwaHU6PGnNNvTX55CY50ODzDJud25F1XQpjJbJ2h03KRrRpaz717gxiguxhRwU3IQgqT5wH2+ozu0XBP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/gALtmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF8EC4CEE4;
	Tue, 13 May 2025 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747148483;
	bh=34s7YxmsaatctKTQbzFyxUDNZ+7apb5XXLKqnullZvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/gALtmW+EfzWKoF2KpxSAKZN7jpgEaKdZTy0nucbKFDrrfCosmmp9S5gUlV7iJHB
	 Ast18q8Xo++prH9x1E9N+KbC9cQciG3uSmooQeGsX60XVAn8a8ZvGp/K9pIwmPr4Sy
	 VwAK1VvJxY2yX9XNjwCI/HzcQ6n+EpQ5NEKNYdXzVCtI7PWC0xrUqhJaZ2lPoU5ibQ
	 zIuNEn3EykL/n49836Ho48wQyYX2PGqAbz4zXvr0nlZ2HzrArgrKN8xRJrMefx5gwq
	 9oYTFPOyptmLZNuC3PcNHh+bwTUYEm2C+upRhTLeKD0UciUAZCpJv4cBQm06+bL0tH
	 NkNhb4KljOxmg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54fc61b3ccaso6032532e87.1;
        Tue, 13 May 2025 08:01:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMpipm6FpsJ6xFACsu7TLll7kvykzitYBeWXHILqp3UGNHWE1TXc9fzZiXLKp7BD1JsdPyuAnLJCc=@vger.kernel.org, AJvYcCWvvcBE4GaIanc3jj0Rg5whQtYbGZ0tVDoDUtDt/9vsCbjEPE8fg0Co5Xm7AKBhgw1CIBxVu4vNsEft+aNr@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRIDowAPmTW5dbm81C/zQg0IWk5BkscpRHlIiNKLvkTzKY4uy
	PEOsx1/9gFEEZc13gJVoqQ3BZtpYcKta+NaJlM5eq8NQr9z/NlcHj97UnUT9nRbTIeDY0GRKdZm
	mIJF7Ef1hLscG7wIXfjx1JxVTBnk=
X-Google-Smtp-Source: AGHT+IFE6mAIe5vuAXJSo3LndPPPOdDDg3ad6kR6mPzNI+jVZ4lm/Q3UYaFA2494VDuJ62xbhyRZrudr1sG15MDqqiQ=
X-Received: by 2002:a05:6512:3b88:b0:54f:c66b:8b78 with SMTP id
 2adb3069b0e04-54fc67ecebbmr5413584e87.49.1747148480833; Tue, 13 May 2025
 08:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com> <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com> <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
In-Reply-To: <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 May 2025 16:01:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>
X-Gm-Features: AX0GCFsTW_CqMzWDFZJVcJhvNUrqzoVNzZVp2bRtE1RA4pVO9l2ukTYmMVSKPQ8
Message-ID: <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 15:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, May 13, 2025 at 01:22:16PM +0200, Ingo Molnar wrote:
...
> > Note that two of those fixes were from Ard who is working on further
> > robustifying the startup code - a much needed change.
>
> Really? Much needed huh?
>
> Please do explain why is it much needed?
>
> Because the reason Ard is doing it is a different one but maybe
> I misunderstood him...
>

I will refrain from inserting myself into the intra-tip review and
testing policy debate, but let me at least provide a quick recap of
what I am doing here and why.

Since commit

   c88d71508e36 x86/boot/64: Rewrite startup_64() in C

dated Jun 6 2017, we have been using C code on the boot path in a way
that is not supported by the toolchain, i.e., to execute non-PIC C
code from a mapping of memory that is different from the one provided
to the linker. It should have been obvious at the time that this was a
bad idea, given the need to sprinkle fixup_pointer() calls left and
right to manipulate global variables (including non-pointer variables)
without crashing.

This C startup code has been expanding, and in particular, the SEV-SNP
startup code has been expanding over the past couple of years, and
grown many of these warts, where the C code needs to use special
annotations or helpers to access global objects.

Google uses Clang internally, and as expected, it does not behave
quite like GCC in this regard either. The result is that the SEV-SNP
boot tended to break in cryptic ways with Clang built kernels, due to
absolute references in the startup code that runs before those
absolute references are mapped.

I've done a preliminary pass upstream with RIP_REL_REF() and
rip_rel_ptr() and the use of the .head.text section for startup code
to ensure that we detect such issues at build time, and it has already
resulted in a number of true positives where the code in question
would have failed at boot time. At this point, I'm not aware of any
issues caused by absolute references going undetected.

However, Linus kindly indicated that the resulting diagnostics
produced by the relocs tool do not meet his high standards, and so I
proposed another approach, which I am implementing now (see cover
letter for details). Note that this approach is also much more robust,
as annotating things as __head by hand to get it emitted into the
section to which the diagnostics are applied is obviously not
foolproof.

Fixing the existing 5-level paging and kernel mapping code was rather
straight-forward. However, splitting up the SEV-SNP code has been
rather challenging due to the way it was put together, i.e., as a
single source file used everywhere, and to which additional
functionality has been added piecemeal (i.e., the SVSM support).

It is obvious that these changes should be tested before being merged,
hence the RFT in the subject. And I have been struggling a bit to get
access to usable hardware. (I do have access to internal development
systems, but those do not fit the 'usable' description by any measure,
given that I have to go through the cloud VM orchestration APIs to
test boot a simple kernel image).

What Boris might allude to is the fact that some of these changes also
form a prerequisite for being able to construct a generic EFI zboot
image for x86, which is a long-term objective that I am working on in
the background. But this is not the main reason.

In any case, there is no urgency wrt these changes as far as I am
concerned, and given that I already found an issue myself with v3,
perhaps it is better if we disregard it for the time being, and we can
come back to it for the next cycle. In the mean time, I can compare
notes with Boris and Tom directly to ensure that this is in the right
shape, and perhaps we could at least fix the pgtable_l5_enabled() mess
as well (for which I sent out a RFC/v3 today).

