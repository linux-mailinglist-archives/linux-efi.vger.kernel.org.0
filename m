Return-Path: <linux-efi+bounces-3711-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63836AB83B5
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251081BA1EBE
	for <lists+linux-efi@lfdr.de>; Thu, 15 May 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20AE297B7E;
	Thu, 15 May 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUJ1lJPF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7736297B62;
	Thu, 15 May 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304665; cv=none; b=OQRjHBo2IfX/qBdDHu8nZzaHi3EKlMZ8lBcE1BYmNpw6wr0szSgttikkDz5zVZ6YMdKhw/gJXS4QAM62JNX52Zxlynx/VeTSrx2VGw6cAVY9v3Gbe6+YlTNc1rLQyTktwoT08nOsDPAUivgKXprmmn/08HSZFWWD9khQzYAgRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304665; c=relaxed/simple;
	bh=ecFoMDITQ2UHl0CQ2m8pVOnE+Ca1N3yc1ThEnPm8Ieo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmZO/jLWsbOQzZCkwME4MpJ3liQo1zlTzXq0Gq4nSPBJq5Evu6f850KLzvDVYq4Mt4/7S+HqaoBPhzD4rkzpf8o+osqDEk5W+DEw/rqXamQu6u15r3Zor0VDJupub5VGJrJPbEBCt2O20OiH2LlQaT9UQae+UEKaSs5r7TViMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUJ1lJPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D01C4AF0B;
	Thu, 15 May 2025 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747304665;
	bh=ecFoMDITQ2UHl0CQ2m8pVOnE+Ca1N3yc1ThEnPm8Ieo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kUJ1lJPFDq6ZKKwJe/ODc0xAZtd54p3q/qDXLgEIl2gLYnRz5kJN8dfq0Hl7yXVC+
	 sWgnZv5P83vD89PBNdc2ytbdJHR06gnfhO8JqR+oA1ENfKg/3vOQuR1ruujR9AFoQY
	 y7JvkvzLbUdVSvMhPDl0STi131qPHBo/l9ohuqOANu4Q0Kivbo83J0yrxi6VymKSFS
	 3eM8g6F6QVAzsqdumw6s3Ya77TaxppNvUn13+0a/TrNNkekq93UCSDp7GkWRo8tJ+P
	 hgWLFdyHKjEDEKl0QQBp7ZeV2vtB22urq3/Kp93hcOi0HOa0SOWi+zBmmFjRcG/N0M
	 cRxjJQyw3/RpA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-326c77c40b7so8084161fa.1;
        Thu, 15 May 2025 03:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGKS7Pqx8iU+Y7BBmMXUBGXTuRMEA7XzdKqAvVEO2z6vzAPZ0suOCdpBspBpWjZxsLXMCc1cYUInzbQ6cn@vger.kernel.org, AJvYcCV9iQwfxzamron2tGpnOwr3wkoIpoOwvT8HzDYegSIVjbuJirHrszN6zjnHpWbJd9bdxQ7PTa6wnNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweP266EEoaNTwQe7gM70mWIjc9iOfjw9xUoOMwiS5dRgCTkLYT
	AWrkh34W29CefrTzDDqpDVyHt7sGsvEtOnADX7EhGVmK4FTWcWhGps7FQtWktWoV07JjFYFi95u
	Qu0o5xvzQ3VAOtu/2nb3XvPOhDpc=
X-Google-Smtp-Source: AGHT+IG+Qoc89ocGejgLM9+LmK4HpmjzvW2vT0pA3LU8jCpRVfVcV8XTbCmqOQa5YpAG7LmjlQ+VEuoP2cTvXHJnLJ8=
X-Received: by 2002:a05:651c:19aa:b0:30b:d17b:269a with SMTP id
 38308e7fff4ca-327ed09de0emr26138211fa.7.1747304663469; Thu, 15 May 2025
 03:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250512190834.332684-24-ardb+git@google.com>
 <aCWWPmVloPP0_St0@gmail.com>
In-Reply-To: <aCWWPmVloPP0_St0@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 May 2025 11:24:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE0o+ody9V0APmDqRT=skiUyeDDYE3dMVi+sngQ8QxSFA@mail.gmail.com>
X-Gm-Features: AX0GCFs2jBR3F3LJRobjit5GMmZ3fIk-5pQ_3b2Ykzp2eFvRoz7RzXhGPeL7EjQ
Message-ID: <CAMj1kXE0o+ody9V0APmDqRT=skiUyeDDYE3dMVi+sngQ8QxSFA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 08:22, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb+git@google.com> wrote:
>
> > +     if (cr4 & X86_CR4_OSXSAVE)
> > +             /* Safe to read xcr0 */
> > +             ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> > +     else
> > +             /* xgetbv will cause #UD - use reset value for xcr0 */
> > +             ghcb_set_xcr0(ghcb, 1);
>
> Just a couple of style nits here - this new __sev_cpuid_hv_ghcb()
> function

__sev_cpuid_hv_ghcb() is just being moved from one source file to
another - I didn't change a single line, and so I don't think tweaking
the style is appropriate for this patch.

