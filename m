Return-Path: <linux-efi+bounces-3799-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B76AC7B14
	for <lists+linux-efi@lfdr.de>; Thu, 29 May 2025 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E499F5008FB
	for <lists+linux-efi@lfdr.de>; Thu, 29 May 2025 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C221D3C6;
	Thu, 29 May 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RsvQyuoD"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD321CC45;
	Thu, 29 May 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511034; cv=none; b=ZxcnYgQUYEh/IbdbY3VgYnXBfr4fj9dbOQkWPAizE1JZ9sCyBp+J7ATxdxld9LDWxXcS64vXeBlkpuMmR8bafbo4Nd3yjZgXOG0erS2ytIDeQLUpKbHdtrGOGEY825k68MFXxk9ePn2tCaeyEHuG5KwG2hoh5Pm6hqw1LHcV4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511034; c=relaxed/simple;
	bh=P357ogc7f1VbC1UPh+OtIqamhcNuhn+o16OFujjaTpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKwWgiE9Nq9ZPtJL0L83vRy731jdhttSXg0XtQx4n8YBTswr5BU9xmit7JQ5INFbkkwq439JpaiJdY4ybXLlYyFuqd9l2La0daBB3inkXYmFS1fdE/Ng1WR+83LGoGQFZVfzQ7Y6VffRroVfltk55GCLprm4YYgFGeXJhXX2BR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RsvQyuoD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EyUAi17+fveJwmfXKTYA2SfmONRajqoVKFlFZ5vAqew=; b=RsvQyuoDa5r1vAzZNCgRC7mJIX
	Vkb+9ORQn3yJK2oy+5gKoa931eMg3ugwOmZjY8yyd0OWPUmTyaoQeLOZKfbsAEa4ey41qZIPnUqtb
	W9SS9/9VWK3W7S0iNGwvJwuw0Meh24x0DZNOVTgCCyrq88MCa03kTmuSuePJbV5P9OwNCc0K/WrzM
	LGCRucP9HGVyl5i+nD5TgM5O03siLtX1SsSjPg6WM4Xl6TAcn6A/SXQ7LMKwZAH5VxufilG7uBPI9
	4ssNA2kVbN8Vc1NBCwy18tdxWLNpZUCVKW0khmPYUV77YLrD8mJWuvZJfyeFpChPCCIx5y8YaEkor
	ScwYkU2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZab-0000000072k-2g8k;
	Thu, 29 May 2025 09:30:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11894300399; Thu, 29 May 2025 11:30:17 +0200 (CEST)
Date: Thu, 29 May 2025 11:30:17 +0200
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
Message-ID: <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
References: <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528163557.GI31726@noisy.programming.kicks-ass.net>

On Wed, May 28, 2025 at 06:35:58PM +0200, Peter Zijlstra wrote:
> On Wed, May 28, 2025 at 06:30:35PM +0200, Peter Zijlstra wrote:
> > On Wed, May 28, 2025 at 09:44:52AM +0200, Peter Zijlstra wrote:
> > > On Tue, May 06, 2025 at 12:18:49PM -0700, Josh Poimboeuf wrote:
> > > 
> > > > Weird, I'm not seeing that.
> > > 
> > > I Ate'nt Crazeh...
> > > 
> > > https://lore.kernel.org/all/202505280410.2qfTQCRt-lkp@intel.com/T/#u
> > > 
> > > I'll go poke at it, see if today is the day I can figure out WTF
> > > happens.
> > 
> > It manages to trip the CFI_UNDEFINED case in op->dest.reg == cfa->base
> > in update_cfi_state().
> > 
> > I figured it ought to tickle the regular 'mov %rbp, %rsp' case above
> > there, but it doesn't, for some reason it has cfa.base == SP at this
> > point.
> > 
> > This happens... /me looks in scrollback ... at POP_REGS 'pop
> > %rbp'. ARGH!!
> > 

More fun!

> > So the sequence of fail is:
> > 
> > 	push %rbp
> > 	mov %rsp, %rbp	# cfa.base = BP
> > 
> > 	SAVE

	sub    $0x40,%rsp
	and    $0xffffffffffffffc0,%rsp

This hits the 'older GCC, drap with frame pointer' case in OP_SRC_AND.
Which means we then hard rely on the frame pointer to get things right.

However, per all the PUSH/POP_REGS nonsense, BP can get clobbered.
Specifically the code between the CALL and POP %rbp below are up in the
air. I don't think it can currently unwind properly there.

> > 	...
> > 	push %rbp
> > 	...
> > 	pop %rbp	# cfa.base = SP
> 
> This is the POP !drap and dest==base case.
> 
> > 	...
> > 	mov %rbp, %rsp  # UNDEF
> > 	nop		# FAIL
> > 	RESTORE
> > 
> > Note that the MOV+NOP is the 4 bytes ERETS needs.


