Return-Path: <linux-efi+bounces-3797-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB5AC6E0C
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7820F9E8514
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7B28C851;
	Wed, 28 May 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZGM34tr"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C51286D60;
	Wed, 28 May 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449844; cv=none; b=LsgQdJekijiCr90AFvEbr9NDQ1StNBJNrDi0eFmOpBH9kivFqlJh0EA8L1BNJ6MqeLsFytjzRZ1E2obfnZSAcOaM/0ALdGsoh8mHxzD4PGgr6386ZbuNXsl629QZNOPFPyPxrQZbZABVokrrWnRdR2CHoS2tm54EuOg9EAdzj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449844; c=relaxed/simple;
	bh=1tbP8NGTysAyLnBcbOao/6nlF/KpXN5Kj8jDrC4wW3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWM5IpEsSHhMidOiyoADE3hHr5qsPRpQybk3SZ2BiLYRqDId5D+k3XZAE4MskP5UiMmGNGr+dSDaoRmLrwM0XNV86b7+Y6FM/2tfzPguZ/AOrzRiQN927gOn3prYxBoy/+M0DWcBo61jeRiXCVVTXtVDZH+Dyrjsr9kFmzl5t6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nZGM34tr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XzNgzVM/OEVZ+RLegAjSkzoDiYYza0R+KlXhx6KrfY0=; b=nZGM34trj98iolZ9YbYPglJvKZ
	4nZ9cTwYUfobD6NOHivUypANtFU9MxRBrSLM0LdG5uwyZ85mwrRiRlnH4OxhV0FJJiht7zaIbXnCa
	in9W607mjqkAk624BNTDeyhksLwRhWDhb67uy2HGeGnuPQyVvu2Ari/Sky/qMjj9hByF+wcUBSrM+
	BPhZek0J/ZHcxePqihuOjLLUCchVF/faSJLTDK/TPxFUHkKOoGPtT5SAYFwdGsUo48Qq0d0VhJe48
	nqe3GjEriP/s6WMJd2mDWse0zL10MXPmLLQpFJgWKRfqi71SmTRQ58xih4NE1IGeX0jtdcQ9Bcw9Q
	nQ9LTFqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKJfo-0000000Dqjg-1t2e;
	Wed, 28 May 2025 16:30:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F160A3005AF; Wed, 28 May 2025 18:30:35 +0200 (CEST)
Date: Wed, 28 May 2025 18:30:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250528163035.GH31726@noisy.programming.kicks-ass.net>
References: <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528074452.GU39944@noisy.programming.kicks-ass.net>

On Wed, May 28, 2025 at 09:44:52AM +0200, Peter Zijlstra wrote:
> On Tue, May 06, 2025 at 12:18:49PM -0700, Josh Poimboeuf wrote:
> 
> > Weird, I'm not seeing that.
> 
> I Ate'nt Crazeh...
> 
> https://lore.kernel.org/all/202505280410.2qfTQCRt-lkp@intel.com/T/#u
> 
> I'll go poke at it, see if today is the day I can figure out WTF
> happens.

It manages to trip the CFI_UNDEFINED case in op->dest.reg == cfa->base
in update_cfi_state().

I figured it ought to tickle the regular 'mov %rbp, %rsp' case above
there, but it doesn't, for some reason it has cfa.base == SP at this
point.

This happens... /me looks in scrollback ... at POP_REGS 'pop
%rbp'. ARGH!!


So the sequence of fail is:

	push %rbp
	mov %rsp, %rbp	# cfa.base = BP

	SAVE
	...
	push %rbp
	...
	pop %rbp	# cfa.base = SP
	...
	mov %rbp, %rsp  # UNDEF
	nop		# FAIL
	RESTORE

Note that the MOV+NOP is the 4 bytes ERETS needs.

