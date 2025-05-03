Return-Path: <linux-efi+bounces-3546-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F47AA81ED
	for <lists+linux-efi@lfdr.de>; Sat,  3 May 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928FD5A3C45
	for <lists+linux-efi@lfdr.de>; Sat,  3 May 2025 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4927A471;
	Sat,  3 May 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuL9IAtO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30036DCE1;
	Sat,  3 May 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746296921; cv=none; b=uYf6gS+qlhVBFvHqN6WpdyUTg3jvD1rglUjbQ8dv5pPFvRQ9gMhWlYLjEmv5c05PtDP5WtZqcwMyTG+u3WIX3PcMNFyFPYVc/HNenGW+euv5NFX7qAb66AFQLXpnCvqiUys9t0bmPSS07wg4jyHLvW0G1TyVIHUbZyuu6HIRrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746296921; c=relaxed/simple;
	bh=3fKBodp5CHqkWEFP9lvNQWnLHEOn5YEIduo8h9PK+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7ziVV4IWZFFHxUf2ZF1KafTf5aYvhqc7+25g+IRl/qU6BDrcEJPN9BeJZcjFAKg6j1jJYeZySq1bOMfofgie/7ToXjneDQtvb9xe4G3NtKbEI3PtN1gC0pKskxyQHS4E0ExokuuL6TZL9hDwiDK4ForQt+inpF3DCK5l88vbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuL9IAtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4890C4CEE3;
	Sat,  3 May 2025 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746296920;
	bh=3fKBodp5CHqkWEFP9lvNQWnLHEOn5YEIduo8h9PK+nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuL9IAtOE7d193OKwDBV73buJtEMeabKO9HM7XEjD+YA88mKiDABuwUGNX+FGv4R4
	 4VDW1tO3Vy2KCTyHsvoSRv8BvS8GJOU8rWIXholkdw6QYaFO/GZmhacyMu+2RD5HI0
	 dcfPQT/uu+hFaXu11qKuPsmiUSJbhxf+ZoJmm+fbf6GnxZSlE5DPHlNpKR21xM//Bf
	 2KW3zSwmof5v9vOd2UQx256HHwi4VmgCnx+oW0zYB7iLwUJTpLwHe20qIbSjE2DIVx
	 iLPt0T7jUHJR+tpo49FRs9as7xJXRVxeq1fzmyjOQm6moyc3+7xYBJ9RKHwEN8+12k
	 RH27QZpxtPM8A==
Date: Sat, 3 May 2025 11:28:37 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
References: <20250430110734.392235199@infradead.org>
 <8B86A3AE-A296-438C-A7A7-F844C66D0198@zytor.com>
 <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503095023.GE4198@noisy.programming.kicks-ass.net>

On Sat, May 03, 2025 at 11:50:23AM +0200, Peter Zijlstra wrote:
> > +++ b/arch/x86/entry/entry_64_fred.S
> > @@ -116,7 +116,8 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> >  	movq %rsp, %rdi				/* %rdi -> pt_regs */
> >  	call __fred_entry_from_kvm		/* Call the C entry point */
> >  	POP_REGS
> > -	ERETS
> > +
> > +	ALTERNATIVE "", __stringify(ERETS), X86_FEATURE_FRED
> >  1:
> >  	/*
> >  	 * Objtool doesn't understand what ERETS does, this hint tells it that
> > @@ -124,7 +125,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> >  	 * isn't strictly needed, but it's the simplest form.
> >  	 */
> >  	UNWIND_HINT_RESTORE
> > -	pop %rbp
> > +	leave
> >  	RET
> 
> So this, while clever, might be a problem with ORC unwinding. Because
> now the stack is different depending on the alternative, and we can't
> deal with that.
> 
> Anyway, I'll go have a poke on Monday (or Tuesday if Monday turns out to
> be a bank holiday :-).

Can we just adjust the stack in the alternative?

	ALTERNATIVE "add $64 %rsp", __stringify(ERETS), X86_FEATURE_FRED
1:
	UNWIND_HINT_RESTORE
	pop %rbp
	RET

-- 
Josh

