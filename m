Return-Path: <linux-efi+bounces-4927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0532B8F330
	for <lists+linux-efi@lfdr.de>; Mon, 22 Sep 2025 08:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C43B3B8ECD
	for <lists+linux-efi@lfdr.de>; Mon, 22 Sep 2025 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E470823;
	Mon, 22 Sep 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI+Yzh+s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDD182B7
	for <linux-efi@vger.kernel.org>; Mon, 22 Sep 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524148; cv=none; b=ukaSe5Q/ApY6ID1/4uEPlFItXR9Tf5NCOoYLkzvxHdfOct/+K1SEZHkIlr5vPvlQ8lbQth8McmndANc4XIhUS0xhtlTBBJfA3EgqXXXcFIBrFIMtHU56/pYDOyYkqNrsUNhn0rz5FHTHrE/xgXbDeAIPuZDFeQkk/Pdb5qnSw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524148; c=relaxed/simple;
	bh=cStxNPR0+6f9gxfR6Jcf39Q6otOQTf0Wm6ycPUO8mOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBLAjUZCEYc2H0vWcYT4YwF+P/OOQhwALyJ+HTIx816hqwjqDIG/p8VJvt2J2FwXEXmsWT+J1+H2icX96qYb411GxDculvKzB/Rgi8v8DY1fwH35AHyvMKl7X7KP9TUOhrRogeOoAonzCKkRtK/3aun7HeG+qx6LPWLxLFaj25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI+Yzh+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09A2C116C6
	for <linux-efi@vger.kernel.org>; Mon, 22 Sep 2025 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758524147;
	bh=cStxNPR0+6f9gxfR6Jcf39Q6otOQTf0Wm6ycPUO8mOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FI+Yzh+sxnP+7y7AeY/UzD+AvO5J9BcZlzQ1Ig9XiOhmmPIGaHdmNLQO8yPkfSvpY
	 GmXGfrpVJsPf4MehwrNyRufodTnae+ejYEvF1SrCdwXJSMGZO05+qUgM/6qjzBOBK4
	 VSp9qYhI0rB7d8MHHb8IwGZllDScC+k362rcxBpeO/lx/KcmcxJr+pVg/YsnEihcvz
	 uL8LEo1EGp7oWP3Bk20pEycuJ04Y6FJ8h+CAeL4CBgKABmc8YvB9c0bz5K9MFPqbfB
	 cmdnUeX5/qc2YV9s/PCtkgjCqdv7dy/k5mraTiuVjhoWWMQodcdwnB8Na/FvQ8WK+M
	 rE0JNpsJ04NCA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso651132e87.1
        for <linux-efi@vger.kernel.org>; Sun, 21 Sep 2025 23:55:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpQmlsCzVyzP2jc1Dvc5eJ1YgG4WFzFDmAWerMeLVDGCpZt0wDZdLZT/CRmE83YcE9yKsMH7m/Rzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXl2YiS8zvNsjOnlEYlI3rJudetUZeldKt5UN66/1hgAOZnkLa
	wM5nCXw3uTJzPS21L9xQCpQOwIvjCMT/TsYymdsQQqSLqhEC7eXKpkjwZ5QBBpxq4ihvZEm6qCY
	dktsUL22o/zo95NxQaK5Ps/G0Nk/B8Wk=
X-Google-Smtp-Source: AGHT+IFEuuIizw00M5tOMIlDV79GLzIy8VumPMrZQwg+c8cGe2MnwvUkmO7jOkF/XPepPXL3XhK5bQF243dup2ewVbE=
X-Received: by 2002:a05:6512:39c8:b0:571:75c8:43a5 with SMTP id
 2adb3069b0e04-578932c711amr5316823e87.1.1758524146258; Sun, 21 Sep 2025
 23:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-15-ardb+git@google.com> <19b370e4-d6a8-4a60-bc14-4adb55616040@sirena.org.uk>
In-Reply-To: <19b370e4-d6a8-4a60-bc14-4adb55616040@sirena.org.uk>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 22 Sep 2025 08:55:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrbQW-0ERuHWz1cGhnm81j1_2Kf_FEUT5pzZZa=9Cuyw@mail.gmail.com>
X-Gm-Features: AS18NWDhOO8LR2J_B_pV8xirK6v2Tu0IG5sHBmb-PL3i5tNUhl9Y83YVb_5Bcvc
Message-ID: <CAMj1kXGrbQW-0ERuHWz1cGhnm81j1_2Kf_FEUT5pzZZa=9Cuyw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] arm64/fpsimd: Drop special handling for EFI
 runtime services
To: Mark Brown <broonie@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 15:10, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 12:30:16PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
>
> > Now that the use of kernel mode FP/SIMD is generally permitted when IRQs
> > are disabled, the only purpose served by the EFI-specific fallback code
> > in fpsimd.c is the case where an EFI call occurs from hardirq or NMI
> > context. No such cases are known to occur in practice, and it is
> > doubtful whether calling into the EFI firmware for any reason under such
> > conditions would be a good idea to begin with.
> >
> > So disallow EFI runtime services in such cases. This means all the
> > fallback code can be dropped.
>
> This is a really nice simplification, with the fixup rolled in:
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Sadly, this is not as simply as I had hoped.

So even if we address the irqs_disabled() case, there are three
remaining code paths where EFI pstore may end up calling the
SetVariable() runtime service in hard IRQ or NMI context: panic(),
oops_exit() and emergency_restart(). So disallowing this is
problematic, as EFI pstore might be the only way to do a post mortem.

As such an IRQ could potentially occur at a time when the FP/SIMD unit
is being used both in task and in softirq context, there still needs
to be some special handling, even though a) this condition is
vanishingly rare, and so having elaborate logic like we do today that
is never exercised is not great
b) much of the logic deals with SVE which is user space only, and we
can just disregard that under the conditions where we may enter in IRQ
context.

