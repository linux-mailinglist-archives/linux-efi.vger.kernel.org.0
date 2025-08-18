Return-Path: <linux-efi+bounces-4569-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2EB2A132
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 14:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F915E5417
	for <lists+linux-efi@lfdr.de>; Mon, 18 Aug 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591930E0C9;
	Mon, 18 Aug 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hw7yqwRt"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567227B327;
	Mon, 18 Aug 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518972; cv=none; b=IagEqSG2B27InQCyuTcHfpPfFHedt0tYr3WibxUzZd/q/6Ra4V6ojwPJ6W7UYi3Xy3o8HtXwyEvMPlqy20+rHnnydyYwRogQ+yrCKQUsRjbEDQnPKNlp7UzmRcaIB44z23iuclezSAmkjR1ePoBm6klq8DX1hSRaqyiiMFEvwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518972; c=relaxed/simple;
	bh=OpLQdy0G/Okp0F0LQiqP1NL9Gk/7mF8nmHn0cni2z3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPnYwa3e1jRZ9dubszOzFhliWS9PZSP4QkUwA6Ch2zPoR+lIVXcoyO+gVWKhEk0qp4FHUtW/8S+5+yZ/L4NemREsdnUUUdw+IdedgHdQMvjQ3y2/5cpng0PGQtKsnqiTuwY1OL4NPYZA77Ht5vc7QU5vljzRHVQcos43l98LjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hw7yqwRt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JIDCDEr/1d5V29Dqy9cjcsDweAzjIcSrXoBz7OAnOQc=; b=hw7yqwRtgfcqq+EjufE2Jc2iV3
	3fgmJNFglB7kHDM+xLP3/4A2d2aAUgICLohp9OUwk/5+Y/8O6mojpbZ/Vq3JiWKbY0Wl2+niLNbY0
	DhwP3Vcaus9WsenOgucD+O81dU4PMH+52JXxpr7aFfyvnuCI0WTUl4yNo+04j1BF4clFLWLmRqNFy
	CIpHLDI9+fwQter0IIL4OFu37dXbdgBv//lIeXXrjE8qeUpux8tfIjv5+fsewXmbti1fYSNIsW39u
	qp17HHNclKL1lnQFsuZMrxEOtvOgQMMDRrv8qV3qaV3VYNdqTAzawH6DW38ZuV3hnjOJLKTgHXJeA
	jdeY576Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unyfv-0000000HMQW-2uzq;
	Mon, 18 Aug 2025 12:09:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 453B830029B; Mon, 18 Aug 2025 14:09:19 +0200 (CEST)
Date: Mon, 18 Aug 2025 14:09:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xin Li <xin@zytor.com>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH v3 14/16] x86/fred: Play nice with invoking
 asm_fred_entry_from_kvm() on non-FRED hardware
Message-ID: <20250818120919.GG3289052@noisy.programming.kicks-ass.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.245417052@infradead.org>
 <f6925ee5-bbd7-42e3-9e3b-59d2e8ec2681@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6925ee5-bbd7-42e3-9e3b-59d2e8ec2681@zytor.com>

On Fri, Jul 25, 2025 at 09:54:32PM -0700, Xin Li wrote:
> On 7/14/2025 3:20 AM, Peter Zijlstra wrote:
> >   	call __fred_entry_from_kvm		/* Call the C entry point */
> > -	POP_REGS
> > -	ERETS
> > -1:
> > +
> > +1:	/*
> 
> The symbol "1" is misplaced; it needs to be put after the ERETS
> instruction.

Doh, fixed.

> > +	 * When FRED, use ERETS to potentially clear NMIs, otherwise simply
> > +	 * restore the stack pointer.
> > +	 */
> > +	ALTERNATIVE "nop; nop; mov %rbp, %rsp", \
> 
> Why explicitly add two nops here?

Because the CFI information for all alternative code flows must be the
same. So by playing games with instruction offsets you can have
conflicting CFI inside the alternative.

Specifically, we have:

0:	90        nop
1:	90        nop
2:	48 89 ec  mov %rbp, %rsp


0:	48 83 c4 0c  add $12, %rsp
4:      f2 0f 01 ca  erets

This gets us CFI updates on 0, 2 and 4, without conflicts.


> ALTERNATIVE will still pad three-byte nop after the MOV instruction.
> 
> > +	            __stringify(add $C_PTREGS_SIZE, %rsp; ERETS), \
> > +		    X86_FEATURE_FRED
> > +
> >   	/*
> > -	 * Objtool doesn't understand what ERETS does, this hint tells it that
> > -	 * yes, we'll reach here and with what stack state. A save/restore pair
> > -	 * isn't strictly needed, but it's the simplest form.
> > +	 * Objtool doesn't understand ERETS, and the cfi register state is
> > +	 * different from initial_func_cfi due to PUSH_REGS. Tell it the state
> > +	 * is similar to where UNWIND_HINT_SAVE is.
> >   	 */
> >   	UNWIND_HINT_RESTORE
> > +
> >   	pop %rbp
> >   	RET
> 

