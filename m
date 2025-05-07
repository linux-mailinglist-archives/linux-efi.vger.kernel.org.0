Return-Path: <linux-efi+bounces-3625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81AAADE7A
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 14:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76644E1014
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320526A08E;
	Wed,  7 May 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcisaLPH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11725DCFE;
	Wed,  7 May 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619550; cv=none; b=fhH/HaNjb8rXO9VAGMNrUu36wgu394H96LDNmK0M26dswiNox+Pmuf2f8Qq/UXYgc5f5dnlLIJNjwEcnBsuITqn389zhSej9XxNJVUzhQaDu7UD6Gz9ediZgd7kit83SWPXnbBYN3YlYR0IQjo1+CwjlCOjcFUUeFhERuSonlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619550; c=relaxed/simple;
	bh=usuz4EDiyG7MhMNFI7ICmDMZJlt1l2XENHcwErgJEuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg0Qm2vbLvofwWrsmKumERAKYouWbroO6bn2AgqPYwjoO1GQf+Aiu+Dmlmq8jQotWwI+OTt2bX+LCR03ZMvoktPl+Y0pMcxNidL9ZrzgliL2e2sKg3dbImbgmGr3giKy/sXqua7jh3wdtU8S3PY65aBL61czzqOjYXIft9Nc1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcisaLPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1956FC4CEE7;
	Wed,  7 May 2025 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746619550;
	bh=usuz4EDiyG7MhMNFI7ICmDMZJlt1l2XENHcwErgJEuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LcisaLPH4Im7jUArmUG3ZoAwwzo0MQXHvIGP7fO+dd50W5G/PUFksjyBzpKmUeZIp
	 JQmF9gEkD7MmOAxhg9GytNn9TL3kiWkl4Rq7pFvYn/51+IOY/T+GSVr8/4Z8VXB/Eh
	 qwpo9e/tlqUCohkRZt5qqxVcLuP8DOL+RFfiuwvsHGe6FwN8XGkB0Ki27MsMgVMzms
	 7hgdkqbm3k1lqBBhCEkDlWdMPj/UTv50syjhaAB2X7yVcAxaw3zHI//xM2jfrin94Z
	 x9nfKzejsaHvKl5jkCb3A8p1khfPmtY3xbaLdqgmrEiIBZ7PphxoDeMYYUHFlzrYMZ
	 mqCY/xeSA6uyw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30de488cf81so69936871fa.1;
        Wed, 07 May 2025 05:05:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURAmeUEioo9Mn3WbIhbhChupcVlSt84jEItBfQb7zCntE6G9PDWlHvgQK5CK35ygTPAHjj7CbZeTR0od8R@vger.kernel.org, AJvYcCVoUOFEdvDhkq+CrO7nM4oJa3Eb1qEePMNo8jK5K6ApH3Jo/+XwLCpcVx7dnswoOcZbVhUXFYZChuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypKWnud2vceA3j7gLY5NX5QgBTwOa00xdtrH3o11KGmW0ou0HM
	3PQZUyzGh3DjGRVH9b0uAsqjGcILfEmipxEMfdFGkAYFpxZXGsztQrVkK9OZBbXVn6WKenS01zN
	KtYUbC4eYcMs5mSu74SnwyZArdgY=
X-Google-Smtp-Source: AGHT+IFT1qaInBN+T1KP7RThez/pR56nL3ca6QQyi31dhQBjUwD5FKYIbDOU0DKQ5Td+NmfDHIas0V3DKO0+3/oDgHE=
X-Received: by 2002:a2e:a585:0:b0:30d:e104:d64b with SMTP id
 38308e7fff4ca-326ad33bdffmr10329931fa.39.1746619548488; Wed, 07 May 2025
 05:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com> <20250507095255.GMaBstd1-nsMixe3Kn@fat_crate.local>
In-Reply-To: <20250507095255.GMaBstd1-nsMixe3Kn@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 7 May 2025 14:05:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJk1JsehK3jtbR7yOKFV4UvySYbq10x8td1gM9ryHeBw@mail.gmail.com>
X-Gm-Features: ATxdqUF-lXLC4RRpyuo_Q2IGeDqX3qyiStlTF4uqiY_d8Y7asq_2_RzRWKMrY6U
Message-ID: <CAMj1kXGJk1JsehK3jtbR7yOKFV4UvySYbq10x8td1gM9ryHeBw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/23] x86: strict separation of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 11:53, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, May 04, 2025 at 11:52:30AM +0200, Ard Biesheuvel wrote:
> >  arch/x86/boot/compressed/Makefile              |    6 +-
> >  arch/x86/boot/compressed/misc.h                |   12 +-
> >  arch/x86/boot/compressed/pgtable_64.c          |   12 -
> >  arch/x86/boot/compressed/sev-handle-vc.c       |  134 +++
> >  arch/x86/boot/compressed/sev.c                 |  210 +---
> >  arch/x86/boot/compressed/sev.h                 |   21 +-
> >  arch/x86/boot/compressed/vmlinux.lds.S         |    1 +
> >  arch/x86/boot/startup/Makefile                 |   21 +
> >  arch/x86/boot/startup/exports.h                |   14 +
> >  arch/x86/boot/startup/gdt_idt.c                |   17 +-
> >  arch/x86/boot/startup/map_kernel.c             |   18 +-
> >  arch/x86/boot/startup/sev-shared.c             |  804 +-------------
> >  arch/x86/boot/startup/sev-startup.c            | 1169 +-------------------
> >  arch/x86/boot/startup/sme.c                    |   45 +-
> >  arch/x86/coco/core.c                           |    2 +
> >  arch/x86/coco/sev/Makefile                     |    6 +-
> >  arch/x86/coco/sev/core.c                       |  189 +++-
> >  arch/x86/coco/sev/{sev-nmi.c => sev-noinstr.c} |   74 ++
>
> Can we drop the "sev-" prefix to filenames which are already in sev/
> filepaths?
>

Sure.

> >  arch/x86/coco/sev/vc-handle.c                  | 1060 ++++++++++++++++++
> >  arch/x86/coco/sev/vc-shared.c                  |  614 ++++++++++
> >  arch/x86/include/asm/init.h                    |    6 -
> >  arch/x86/include/asm/linkage.h                 |   10 +
> >  arch/x86/include/asm/pgtable_64_types.h        |   43 +-
> >  arch/x86/include/asm/setup.h                   |    2 +
> >  arch/x86/include/asm/sev-internal.h            |   30 +-
> >  arch/x86/include/asm/sev.h                     |   78 ++
>
> Pfff, sev-internal and sev.
>
> I guess I'll know how the new structure would look like once I go through this
> but there are so many sev* files now.
>
> Can we tone that down pls, through aggregation, moving up into headers and so
> on?
>

I think the main issue with this code is that everything was in a
single source file, with no structure or layering whatsoever.

So I'd actually argue for splitting this up even more rather than
bundling it all together, although the sev vs sev-internal distinction
is a bit dubious - it would be better to split this across functional
lines.

I added sev-internal.h so that that single mother-of-all-source-files
could be hacked up without exposing implementation details to external
users that were hidden before. I.e., the high-level APIs that other
callers need to use should be in sev.h, and the implementation of that
API should be carved up meaningfully. For example, perhaps the #VC
handling stuff (which now lives in a separate source file) could be
exposed via sev-vc.h, and only included in places where that
particular functionality is being used.

