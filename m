Return-Path: <linux-efi+bounces-5476-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E08C4F819
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AACE4EBC9A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2A285C9F;
	Tue, 11 Nov 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1NhlQxA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40423AA19B
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887062; cv=none; b=GWpsfOahp8FbXMdtu7JuPtUVHypIEtbVm60Q+t/kIqczNUq4YyHENTyC6DmxLbn6IxGV9FmXdg2NVqS/nrh6h1tnKP3cCVXHrYf49KItEyEDRKxVb2IOZg7HnUhvQDfezo/xueHtk8dxzb3WM7OxcOu0L3i19f2u4rtk6cT9GW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887062; c=relaxed/simple;
	bh=XJ4g0f0gVuYpinuWbbR3hceAqP09MK82bKYB3vvGeVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuQHLSZbZLL35xdtInf0ecyTIf5LgRHd+BQ+5vNybEoqUv+L4A3Bo8evbhUxK5vUKtXKzCx9KxnZwmt6GF0yIXFaYRnypb0jNVc34otvZc8D4JVjgCsLgDH7CTHUKS970skg3kjE+3EjB0VHMf8U0AAvwkNTOO8wx9ELWFDqOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1NhlQxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82524C16AAE
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762887062;
	bh=XJ4g0f0gVuYpinuWbbR3hceAqP09MK82bKYB3vvGeVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1NhlQxAxeJdhO7bkL3wBsXuhIl5LSvdmcwbJWTX1gG+spiewS/p3BdLBcLpC74v5
	 AVZq0VFLoGGjLqAcXDviZORf2ZWxB3mE14YMn6+pXVeNkCzbDEh31UAIVC7u+v5h3k
	 CqGjEoSfFbPgxTZjaUERNg0Eh4HDqsWTMDzJOrJI/xDSRDIEzWv/up9Lof71GUDTY9
	 0qeAqL73WRJjxKUaqQR2UIO1wB+KjLjPL9NKe8sDMe7nSGMw3DWUEELcQ8YO0Z6yzV
	 RipWUECuEnIn/UxhYMnFXkQom8aWB4FwvNMUTwaCJxblrD5d44GX4+w+4xOzfTvkPy
	 /iZ8Hn4BTCOcw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so9512e87.2
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 10:51:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxiVETU8EV5kPxc0YFNpIrcF1gQlxFawAN4MtETy1KwlyFJYGpMvxgsdMt3jnaw4oXGLmnXIiXm/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBgbGOY0hm48YPSyiiod8+yfMo/8YrQDWrG52fZtSaB43bGGT
	JADRIeVI0vcc9xtT+Nog+NHZIuMvyO2ba7IQthFAyMr7lgBCaXf7y/+ct+khHgSoQnsR0k+pM+n
	FQLIaMGVWPNr2EVuzhya6NepKIl+AlKk=
X-Google-Smtp-Source: AGHT+IH+f6meLkHSJnvqK/GI+08sHMkWRWmZmzjoXE5pVS4YB6CNivhW0spMcyvs1k9S/4LXS4QimEbZb50C4gOFpNY=
X-Received: by 2002:a05:6512:3d21:b0:594:27fb:e80f with SMTP id
 2adb3069b0e04-59576e22001mr74109e87.37.1762887060676; Tue, 11 Nov 2025
 10:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com> <aROEXadFWdJoQEzx@arm.com>
In-Reply-To: <aROEXadFWdJoQEzx@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Nov 2025 19:50:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGYGSrhUbJ8jboSbch6tp00zfpnGdfJEQcbq=RmLFy5CA@mail.gmail.com>
X-Gm-Features: AWmQ_bmn0XfBWIxhlEWjmu5ftCNZ6fTZUngXH8l15WK1fdsKV0lT36GtFrubF_s
Message-ID: <CAMj1kXGYGSrhUbJ8jboSbch6tp00zfpnGdfJEQcbq=RmLFy5CA@mail.gmail.com>
Subject: Re: [PATCH v4 resend 0/7] arm64: Make EFI calls preemptible
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Brown <broonie@kernel.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 19:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Oct 15, 2025 at 10:56:35PM +0200, Ard Biesheuvel wrote:
> > Ard Biesheuvel (7):
> >   efi: Add missing static initializer for efi_mm::cpus_allowed_lock
> >   efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
> >   arm64/fpsimd: Don't warn when EFI execution context is preemptible
> >   arm64/fpsimd: Permit kernel mode NEON with IRQs off
> >   arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
> >   arm64/efi: Move uaccess en/disable out of efi_set_pgd()
> >   arm64/efi: Call EFI runtime services without disabling preemption
>
> The series looks fine to me:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> What do you plan to do with this, merge via the EFI tree? Are there any
> dependencies?
>

As you prefer - I can take it via the EFI tree, or you can take it.
There are no conflicts with the other kernel mode FP/SIMD related
changes that we are taking via libcrypto, and there are no other
dependencies that I am aware of.

