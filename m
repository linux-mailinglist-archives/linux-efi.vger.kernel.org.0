Return-Path: <linux-efi+bounces-3694-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421CAB64B7
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3C8189C194
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60420766C;
	Wed, 14 May 2025 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwTrLJb4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712C201004;
	Wed, 14 May 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208510; cv=none; b=CTK38sjay6sVuxJV8EpmfigqvlLWzG5VgglTR3Ju0H0NVKcuI8AnZzqZ8gvw5wFDSlXvM8f3+QXxVzM5dxoJgDMF8ewTrfppNdoWGwHUknyeh+J3HaS8i9+wEhUKulk1VmPIQ4llhbneVurd/ffoMweYmpg3Om1hhPViW5/f/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208510; c=relaxed/simple;
	bh=jo+adrnc48N5zwYDRXxyN3PWTy2SX/NhEUGfMF8JA2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn3jC+A4jzacG8/9a2RmPygOv0HY5lr9wnK18vM8Zy5EZu39FOzg+qWr/o+aCPQRg1SJFQXB6FoO1sB2WHSO/8VhT+Erv6u0DLaLoI1ewReMFS/WTux8OhjLe6GMprFiaiJ90jcze9+62CgGg49x0rX0gTKgA9/1Y1JQSS+k6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwTrLJb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479BC113D0;
	Wed, 14 May 2025 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208510;
	bh=jo+adrnc48N5zwYDRXxyN3PWTy2SX/NhEUGfMF8JA2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PwTrLJb4uoTxnvzGifeqmkD6jKhnN49F/7oo1EXMpCGgWlVpsG0PT870ko3DH2ULK
	 IC2ux/eGqe5kefsVEnWv1p9OufGFhZ+dk/b8PAQxAtiqOmTz0YdxzAlpput+Pm83UM
	 Fy3qQgcD87+y8kKDM586NWIPVVIWeJ8sSWEuLWW5YI8L5hAa2npZXhHKqqUomvnVUH
	 v2ESdlnJd7+VlLXiWVTQT9pIYgMawfZ7dz8oFr15iglvwzDkr3Cz2u7uXsLTRnSq5x
	 QyrVsop9RvwqQjhtlNqLNkzXqYW6ZZgvwTace6LfwIRf2iu+/kEuPzQujMjyXrCov5
	 NMks7fxXsHChg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30effbfaf61so7535851fa.0;
        Wed, 14 May 2025 00:41:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI9R4RS30W4zAPBbcgw3dYalAA3FjgCx0AkmXqczX/yKuASKQiNX7iOlTKVQRe2tOxs6MM4dGnx5xz6j7N@vger.kernel.org, AJvYcCUaxEFUECUhJWeDVxFCzuIjE165/o/oo/f0Rf4FKYk67p6+Q7YSR31Z3jho2TPelTAlib3lkjsCYK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvMzKzmCszVr901XAd8u+yM8wb/I+pJO3xGtuNa3xMLWEUZeP
	6w1w6CnofIq+BSzKFMdJOxVkq33/c2axUGFqRWed7n9m6TzJZn+LXmHUzdl+M+skiL6lD1GgDJf
	caMjQvoOeurQuFrAwGgTtTDp1Jdw=
X-Google-Smtp-Source: AGHT+IF1PkBr4PHzNyt6JEZKfqOpJZxK09kpQ2HIZSQxzrcAD/IcCTx93JBAooZpxHUe84q1BNE4PsAxvNSbdUOqjzs=
X-Received: by 2002:a05:651c:4112:10b0:327:ef41:8b0a with SMTP id
 38308e7fff4ca-327ef4197efmr2797641fa.18.1747208508701; Wed, 14 May 2025
 00:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com> <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com> <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com> <aCQ444zAwwkUwwm8@gmail.com>
In-Reply-To: <aCQ444zAwwkUwwm8@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 May 2025 08:41:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0UHyTXZ31R_ps=Nk0+AsFy1tLj04Zg6cR90wdN=7pBA@mail.gmail.com>
X-Gm-Features: AX0GCFsz3fsSA4_YKcvzBRbGrzJlaZCyGDwF-6rwZdT4WoVTPwyq1W4SuQrqd5g
Message-ID: <CAMj1kXE0UHyTXZ31R_ps=Nk0+AsFy1tLj04Zg6cR90wdN=7pBA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 07:32, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
...
> > In any case, there is no urgency wrt these changes as far as I am
> > concerned, and given that I already found an issue myself with v3,
> > perhaps it is better if we disregard it for the time being, and we can
> > come back to it for the next cycle. In the mean time, I can compare
> > notes with Boris and Tom directly to ensure that this is in the right
> > shape, and perhaps we could at least fix the pgtable_l5_enabled() mess
> > as well (for which I sent out a RFC/v3 today).
>
...
> We could perhaps do the mechanical code movement to
> arch/x86/boot/startup/ alone, without any of the followup functional
> changes. This would reduce the cross section of the riskiest part of
> your series substantially.

The first phase of this work, which is already queued up, was to move
all of the source files that were using RIP_REL_REF() into
arch/x86/boot/startup to be built with -fPIC so that RIP_REL_REF()
could be removed.

The current phase is to separate code that really needs to live under
startup/ from code that doesn't. This is the bit that was
straight-forward for mapping the kernel (including the SME encryption
pieces) because they were already in dedicated source files, but not
so straight-forward for SEV-SNP.

In reality, the mechanical code movement in this phase is mostly in
the opposite direction, where things are separated into startup and
non-startup code at a high level of detail, and the latter is moved
out again.

> If that sounds good to you, please send a
> series for review.
>

Not sure what happened to the tip/x86/boot branch in the meantime, but
assuming that what was already queued up is still scheduled for the
next cycle, I don't think there are any parts of this series that
could be meaningfully rearranged. IOW, the SEV-SNP refactoring needs
to be completed first, which accounts for most of the code movement.
Then, implementing the confined symbol space is just a couple of
patches on top.

