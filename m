Return-Path: <linux-efi+bounces-5349-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A1C32014
	for <lists+linux-efi@lfdr.de>; Tue, 04 Nov 2025 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D4704ED791
	for <lists+linux-efi@lfdr.de>; Tue,  4 Nov 2025 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB812571D4;
	Tue,  4 Nov 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj2eYO6M"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D02673AF;
	Tue,  4 Nov 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272996; cv=none; b=Fb5GYxLVnzsvzRCCP3YfXrpicIYz/a0lchprgJmh9C9yl/vNmrz4wVhkslOOu7rnc/LAswnBQQukhUvRNXvHLO8iUfOa70YYYMnOIZpVnPR9OixG3j+T0u7a5cu6ZFbbISjr33tVStxJLWGLG6AW2/zxiGiWfjxwwC0TdH+Wuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272996; c=relaxed/simple;
	bh=EBvCozXC0B7xS4q4wIuy10Yn3kGVo6sqyYCj5vhUAGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUFzW2NIY+I+oheEqf8eGzZXGVe5V/epP24F7fLjJVX+OBUB3Gx2JFsYQr6Hp7GNF6oo8LhghoZAFUI1TK8luLr1GzwCbFlj52MkxVUaJBQfb2sPH3QqDD4rSJeUt2RIFUMxKKCwt9Kl1AQtS8FCgSfg2ACHgU+NXTdbZcgoywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj2eYO6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA38DC116B1;
	Tue,  4 Nov 2025 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272996;
	bh=EBvCozXC0B7xS4q4wIuy10Yn3kGVo6sqyYCj5vhUAGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lj2eYO6Mtv7X8QLk+/EsC4EsuRFqDvAXLQejVWdxtafr8WSjZVXhWecI5E9kWHCYM
	 C+m/9RgZ4ZIh0a1Cxv59F6YeYQ8VjyPToC64rNT/tZfKAZw8Z573Jav9hEEK5dmFw3
	 eGmW7M4V8oaGxQ/RGRMdQkM0nyxzR7pNkD/g4/NNdA4F+UFdlHl6QqAS3Ai4jp+wtT
	 zPrc7YhyqmVQ9ttdm+bwYcUZvlvDkEqQMuv55GWL6RElmhmjaEjI4AapgAlvF0iNxI
	 POb08jgMRPqfkSi36Bl4ECjOmfaTonzyxnxWgqC444kQPYVuFyVP5v0789++QRtR/F
	 fp8ZEyHLf0vhQ==
Date: Tue, 4 Nov 2025 16:16:29 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Sami Mujawar <Sami.Mujawar@arm.com>
Subject: Re: [PATCH v4 resend 3/7] arm64/fpsimd: Don't warn when EFI
 execution context is preemptible
Message-ID: <aQom3XPDmPTkq47d@willie-the-truck>
References: <20251015205634.3820870-9-ardb+git@google.com>
 <20251015205634.3820870-12-ardb+git@google.com>
 <aQohO07DpxlriQfJ@willie-the-truck>
 <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJ8QWLE=awDUpNa0Cf_1YXMQaW-Se1NvvavOocshDkTQ@mail.gmail.com>

On Tue, Nov 04, 2025 at 05:00:34PM +0100, Ard Biesheuvel wrote:
> On Tue, 4 Nov 2025 at 16:52, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:56:38PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Kernel mode FP/SIMD no longer requires preemption to be disabled, so
> > > only warn on uses of FP/SIMD from preemptible context if the fallback
> > > path is taken for cases where kernel mode NEON would not be allowed
> > > otherwise.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/kernel/fpsimd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > index e3f8f51748bc..3d848c89604e 100644
> > > --- a/arch/arm64/kernel/fpsimd.c
> > > +++ b/arch/arm64/kernel/fpsimd.c
> > > @@ -1934,11 +1934,11 @@ void __efi_fpsimd_begin(void)
> > >       if (!system_supports_fpsimd())
> > >               return;
> > >
> > > -     WARN_ON(preemptible());
> > > -
> > >       if (may_use_simd()) {
> > >               kernel_neon_begin();
> > >       } else {
> > > +             WARN_ON(preemptible());
> > > +
> >
> > Given that may_use_simd() returns false on systems without support for
> > fpsimd, I wonder whether moving this WARN_ON() actually helps with
> > anything.
> 
> This code is only reachable if system_supports_fpsimd() returns true,
> so may_use_simd() will only return false here when running in
> hardirq/NMI context.

Sorry, I missed the check _right at the top of the hunk_!

> 
> > That is, you probably shouldn't be calling __efi_fpsimd_begin()
> > from preemptible code regardless, no?
> >
> 
> Not sure I follow you here: __efi_fpsimd_begin() is generally called
> from preemptible code, and it is the EFI runtime wrappers themselves
> that disable preemption - that is the whole point of this series.

Ignore me. I was reviewing this against the upstream
arch_efi_call_virt_setup/teardown() functions rather than in the context
of the changes made later in this series (specifically patch 5).

Will

