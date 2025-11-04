Return-Path: <linux-efi+bounces-5348-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF76C31F77
	for <lists+linux-efi@lfdr.de>; Tue, 04 Nov 2025 17:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9383B5CE8
	for <lists+linux-efi@lfdr.de>; Tue,  4 Nov 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E29309F0E;
	Tue,  4 Nov 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR2MSp67"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4133019B3
	for <linux-efi@vger.kernel.org>; Tue,  4 Nov 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272048; cv=none; b=twhjgakXbLpGJbQk2CIZaDzbmWXqh5XO37RD1FznFRPk+dQrdHs7QwWAMebAaIdoyo3MacD7UnkOLmuhS+HDalC0RikyOBsc3kC08VDRKRBRsXOfux+hdcQM4hdjKWwPrvjJB6NKF3OdUbf/kPxJ8vUJP6CzQfreAw7vOeNNsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272048; c=relaxed/simple;
	bh=ybUNx2jIsLvN4wny2PiVPksAIEQ72qetHRtyXmJ7k+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyNmCIxDkEPQZu3hbfPGZlNsdVYAHgWPd+Eqq7kgQLF54EVo/aGhoKcLFGlS+Qr/KKHWbwMp/B1WbWaw/PpmZYMgEmg7XwwZjHvjah8pUBRdjdcq7TjVqXndfkN+bAHHA22h4tIyuIgf0QMKxyGs3/IOjjZGsXdBgh8HHwYF4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR2MSp67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB089C19425
	for <linux-efi@vger.kernel.org>; Tue,  4 Nov 2025 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272046;
	bh=ybUNx2jIsLvN4wny2PiVPksAIEQ72qetHRtyXmJ7k+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aR2MSp67zqdggky6ji+ROENkuohDPiaQlj3TFfzgJuVOIikzpSfzs+sq46ojKZw8r
	 A5FlDZe39wDsjKHO5j/9noGKuu2zvq7e8tf44OhtOPqKRjtpZXmupTez8z6OzE3nXu
	 BPq0ODTnbiP9WZQxzzsuKr6vJD68nnX526E8EvNl28saz18spNanPFefLHsLu30olA
	 I6oCp9oHONaotM3RZD+oIso/ZtQSugSn4juCLOk6flkvIAYl3WRR4Y3gHKUl5Y6WHW
	 Vv8dDByVwHj5T06QxIxCa/RGTB0pRLkYg8miXLppj54c+LQdSYShe2HgwA8gQSAbW2
	 ibXI8F9kXwDiQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59052926cf9so6311762e87.1
        for <linux-efi@vger.kernel.org>; Tue, 04 Nov 2025 08:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAbXNfX0+49Vtc/PkcwmaoYn1LThvyoTz7Q1/s00K78Hzr0sO+nnv/aGuv66bC2sZBmGEeHkH7SZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8A1smhGUDrnpMSSobaWTrrAp7lYoYMujb90tpmOV7+KXX22rd
	XXwC9GCXahP/8+/ybI8x7VNoWnE1zP3iLJk4cBj097+aXPxsq3ujNOMFV+ib1F8ca583Aan1QK4
	tBw0s2EgBXiuyvO4iBpkSfu7Bk8Z+wxs=
X-Google-Smtp-Source: AGHT+IHl4TYsbIp7q7RcLM8gvEfvv4DHuvd8GjPAShqj+bYodluXicBE5Hx5rY1swrBJdmW0rYHy3/YN70gri25XdyM=
X-Received: by 2002:a05:6512:2391:b0:594:33fc:d52b with SMTP id
 2adb3069b0e04-59433fcdb46mr1505550e87.36.1762272045211; Tue, 04 Nov 2025
 08:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com> <20251015205634.3820870-12-ardb+git@google.com>
 <aQohO07DpxlriQfJ@willie-the-truck>
In-Reply-To: <aQohO07DpxlriQfJ@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Nov 2025 17:00:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnZWe2FwdCEPmDBbfXyQD7IMRyef3q6dtPcCDOW1XeyOM1FaYaJOwR85bI
Message-ID: <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>
Subject: Re: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI execution
 context is preemptible
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Pierre Gondois <Pierre.Gondois@arm.com>, 
	Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 16:52, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Oct 15, 2025 at 10:56:38PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Kernel mode FP/SIMD no longer requires preemption to be disabled, so
> > only warn on uses of FP/SIMD from preemptible context if the fallback
> > path is taken for cases where kernel mode NEON would not be allowed
> > otherwise.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/fpsimd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index e3f8f51748bc..3d848c89604e 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
> >       if (!system_supports_fpsimd())
> >               return;
> >
> > -     WARN_ON(preemptible());
> > -
> >       if (may_use_simd()) {
> >               kernel_neon_begin();
> >       } else {
> > +             WARN_ON(preemptible());
> > +
>
> Given that may_use_simd() returns false on systems without support for
> fpsimd, I wonder whether moving this WARN_ON() actually helps with
> anything.

This code is only reachable if system_supports_fpsimd() returns true,
so may_use_simd() will only return false here when running in
hardirq/NMI context.

> That is, you probably shouldn't be calling __efi_fpsimd_begin()
> from preemptible code regardless, no?
>

Not sure I follow you here: __efi_fpsimd_begin() is generally called
from preemptible code, and it is the EFI runtime wrappers themselves
that disable preemption - that is the whole point of this series.

