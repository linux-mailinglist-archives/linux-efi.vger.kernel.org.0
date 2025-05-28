Return-Path: <linux-efi+bounces-3798-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD3AC6E16
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF857A8480
	for <lists+linux-efi@lfdr.de>; Wed, 28 May 2025 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B602882A7;
	Wed, 28 May 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CI3whra/"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671EB79FE;
	Wed, 28 May 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450168; cv=none; b=k42Fw8lyOAPeneoy+uUnfXgUvCJZ1zwE5ER88629KVGwx7nCA3dypsHYpSv+km+Ow6xYm1quKiIylhVrE9zmddkqvQJ5Y7WYF09+1pQUTMDrICQVjEsn76XBMj2s2RLc0fF5w/aXEDHEqqavdjjHlfFPV3FuHdnZKpbJH5nB70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450168; c=relaxed/simple;
	bh=8tkCt7P4+2Itg5B4iyjr2bnz0MD5gJmHFsKamVWzmY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKGtkAy+7jrPN5LT+oRVwjTsPanUVKfUP8WhOfcfcV1+ro1OCiTumsAxRUQNt1t1UuyzihovvLVHSWxudab3vYYj3TAdzS0WietNsQeWT7aG2RagfdBk7gefmEjsFlmjVIroYHG/vFpMCLL+ZzhbtyCbHKkEeRuMzmpC9zpI2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CI3whra/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=568UXfg09DhGtkTDBYV5iMDI+b3lSxDAU/RR+HqOCYA=; b=CI3whra/FNKgPC6/MrrW3/7oAv
	gJ5A/lFJJfDNjjvOWVxWPYcIaNKO5GhQHKgKeQBfWXQ5KsbRarMDrQ+JT3DIIXQ2qkBV1LtduiLLO
	WHtwhFJlmkqQ1lexDv8Sw2MAzPE9g4AlHH3iaSQEuIRMd2BLFruRjyBtdpwUjQlQEPbisK3s2IO4S
	ktBd+DGQuegeItaFJsTX+0XvLscXM7mt1HEashHGAGbUHkx4nIVJPzYzcSj5bVnJpMYfDqlE2ZSAb
	426Hsd8fujIAwPu2cXH1c210B8lEDyUDFp4VIzVaxWbIgO/xhBKefAc/BYjqYzcMZZRYb+b8b52DV
	6rqvJ3tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKJl0-0000000Dr3Y-1soE;
	Wed, 28 May 2025 16:35:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 05D793005AF; Wed, 28 May 2025 18:35:58 +0200 (CEST)
Date: Wed, 28 May 2025 18:35:57 +0200
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
Message-ID: <20250528163557.GI31726@noisy.programming.kicks-ass.net>
References: <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528163035.GH31726@noisy.programming.kicks-ass.net>

On Wed, May 28, 2025 at 06:30:35PM +0200, Peter Zijlstra wrote:
> On Wed, May 28, 2025 at 09:44:52AM +0200, Peter Zijlstra wrote:
> > On Tue, May 06, 2025 at 12:18:49PM -0700, Josh Poimboeuf wrote:
> > 
> > > Weird, I'm not seeing that.
> > 
> > I Ate'nt Crazeh...
> > 
> > https://lore.kernel.org/all/202505280410.2qfTQCRt-lkp@intel.com/T/#u
> > 
> > I'll go poke at it, see if today is the day I can figure out WTF
> > happens.
> 
> It manages to trip the CFI_UNDEFINED case in op->dest.reg == cfa->base
> in update_cfi_state().
> 
> I figured it ought to tickle the regular 'mov %rbp, %rsp' case above
> there, but it doesn't, for some reason it has cfa.base == SP at this
> point.
> 
> This happens... /me looks in scrollback ... at POP_REGS 'pop
> %rbp'. ARGH!!
> 
> 
> So the sequence of fail is:
> 
> 	push %rbp
> 	mov %rsp, %rbp	# cfa.base = BP
> 
> 	SAVE
> 	...
> 	push %rbp
> 	...
> 	pop %rbp	# cfa.base = SP

This is the POP !drap and dest==base case.

> 	...
> 	mov %rbp, %rsp  # UNDEF
> 	nop		# FAIL
> 	RESTORE
> 
> Note that the MOV+NOP is the 4 bytes ERETS needs.

