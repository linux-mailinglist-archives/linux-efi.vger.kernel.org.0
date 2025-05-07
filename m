Return-Path: <linux-efi+bounces-3624-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69EAADDB4
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAA53A542E
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89509242913;
	Wed,  7 May 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSO14H+I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61481233145;
	Wed,  7 May 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618572; cv=none; b=uVP272xiNuqPtfLbj6LV8I+LRS8zHEWCRANl7sQTPP1T00VjqAZrx5dx+cXXHC80i1U7BWZnPNNLQsV/gvh/NuNaLPX4OnkYzkftxUBHuA6e4mtZA04YdgkYQbb0brGF3PyP1goiu7KPtr+GL9Gcn3HWEEAEui/deIBeE+iT/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618572; c=relaxed/simple;
	bh=Q4o0fFmfThH09sb0d8R9/UT4Ki/dcycKtlq2v1Yg8cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF0DPkvNgSMLkdONW/rSmW8BESHSFOOv4bZSZm89Cd32kyT/6T3zVhmu6JANp/LBo17JAMJpFAA9EV8Ua0F2IdtRRjQe+7Z1fIn7lWigAzAtInilEsmNBTeGi1SQIJDy6Jbfl9apg9JwA+IxMmx1Apow22QlcF3c+tQ0mbKSYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSO14H+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4A7C4CEE7;
	Wed,  7 May 2025 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746618571;
	bh=Q4o0fFmfThH09sb0d8R9/UT4Ki/dcycKtlq2v1Yg8cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DSO14H+IpsNgJc1JF6TVkBOno/ZTvSaGvXOtI8F7caSC1Su6hQJIESypVzBcmOpZT
	 1h3wbKEF/FtbWkPY/pBUD/suEXaAQmE72Se+Y+OGqvSN9vJy/qUEuwA8oas+ha9u5K
	 cnTXFlZ9pfKlBGccaSf8Narri4djKLI2y7sZcuwzmyTVdTmU3sAF1vniOrWoW2Kt3r
	 b1GcaY9aTB3CKFnGxpb9FbW/dLJZnPcmJL8YlcgBImuUKro1fWXST8nQ+/4sJ3PJZ2
	 7kBRzXWAUuGagevFJVQVQPTCTvKFrlmxoLdk4pmI3pNxcY9E5CaGXHXnqujqpWkhNJ
	 Nkqko6CufPaKA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so54994301fa.2;
        Wed, 07 May 2025 04:49:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkjwUsYwf+lFVi5kvz+pOqg/atqRzUve/Mv+pP7FnG4KTRmd13508MV15PVtQt8SB41asDR6vWXtwRaxEm@vger.kernel.org, AJvYcCWzP3l+IC6J9PzgZO/FiT/G9WKzzMfBy+bjlNr3XYb32rVGTbJmZd9YUERLgMkeK6EEj7O3RVpSIu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQ9ET5+as/63W20ggXXs4JRYa+koNkm5iX0Hp1mpRwxWz8Vnm
	dxLbTnltru8ubDHCuI9rhKrw1MBLZ15lrapEDVGcIVX5YFlgvEeYUvq61GxeuOXvIn/Q8PFvR6e
	kc5WxWhsIV84pYwG5NET6hZsutt0=
X-Google-Smtp-Source: AGHT+IGyuczRVoIfKOuvSe4gWmNKzJpVRRL6/4X0pW0V0I6ErEGy9VFfhIR3MsuIm3dmJf3Yo1p5j6Gkk/7fcY8NYxg=
X-Received: by 2002:a2e:b891:0:b0:30c:f60:6c6 with SMTP id 38308e7fff4ca-326ad15318fmr10546881fa.6.1746618570255;
 Wed, 07 May 2025 04:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-30-ardb+git@google.com> <20250507095801.GNaBsuqd7m15z0kHji@fat_crate.local>
In-Reply-To: <20250507095801.GNaBsuqd7m15z0kHji@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 7 May 2025 13:49:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEpO3bip+Zyi9x4WN_=qy+oBQ+PpJRw-Je=roQcRt3KsA@mail.gmail.com>
X-Gm-Features: ATxdqUH9fH7i7x1fH01oa-ejsPddPFo25J-cW4bGdzm04ZYbdzUayU21u3lgbvA
Message-ID: <CAMj1kXEpO3bip+Zyi9x4WN_=qy+oBQ+PpJRw-Je=roQcRt3KsA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into
 separate source file
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 11:58, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, May 04, 2025 at 11:52:35AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > As a first step towards disentangling the SEV #VC handling code -which
> > is shared between the decompressor and the core kernel- from the SEV
> > startup code, move the decompressor's copy of the instruction decoder
> > into a separate source file.
>
> Why?
>
> I'm still unclear why that happens.
>
> I'd like to read some blurb in those commit messages which explains the big
> picture: the insn decoder bits are going to be in the bla mapping because...
> , and because... and this is wonderful because ...
>

Sure, I can add some more prose. I'll add something along the lines of

"Some of the SEV code that is shared between the decompressor and the
kernel proper runs very early in the latter, and therefore needs to be
built in a special way. This does not apply to all of that shared
code, though - some is used both by the decompressor, and by the
kernel proper but at a much later stage. That code can be built as
ordinary, position dependent code with instrumentations enabled etc
etc.

The #VC handling machinery and the associated instruction decoder are
conceptually separate from the SEV initialization code, and are never
used on the early startup path in the core kernel. So start separating
it from the SEV startup code, by moving the decompressor's copy of the
instruction decoder to a separate source file. In a subsequent patch,
the shared #VC handling code will be moved into a separate shared
source file, which will be included here too and no longer into sev.c.
That way, it no longer gets included into the early SEV startup code,
and can be built in the ordinary way."

Does that help?

