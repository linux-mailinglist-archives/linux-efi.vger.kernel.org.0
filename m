Return-Path: <linux-efi+bounces-3818-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C139CAD0302
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51810189D45F
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jun 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAA288518;
	Fri,  6 Jun 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qq10DXT2"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479B20330;
	Fri,  6 Jun 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216062; cv=none; b=V09gYCegjAecAepjZhIgLl9IA/C2TYXNsNsIK1W5Aeq1QV2+gLrGHSncGS77YILZOE74gilfXmljcjTF9ZTyrG19LTDgnhGFrjv0Xmkf6KTdYONzOjmYS5p0L30UwvMn6Jk1fXbSHxclSW/KLvSlQAfmkCAJJVtV6/BSxN2cHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216062; c=relaxed/simple;
	bh=d5xSSZzjIO6YCeawzr4MdDA5aSt61eXqUJbb64Fk4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8ATWoagFE9dvp+Y6g7S+LmFowIV/JUS+qnokcWdI2D65TTJwq8vlly6rL+CFBo6kOXWKxcPlr4tMFbBTRC8zq/Zbdb5H7/KFsbvvMdKGM7sQwHlLDZyhENe8xSY+NW+MZ3pmiGFMc2XAlQx/Kc6zF3uVeiy3qmhE0XxXyiFFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qq10DXT2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9FE0uB61EEETNdTWzbNvrnPXytymt6dcwtvq6U/pJk=; b=qq10DXT2GTNSGudV/qtRDEQlfe
	DhgZVYdDQH26c5BDbUntvNfTk0AMNNN5xGgDlZ9dH/Sx41XiJ1ieT7AYvnTTve4AU4oCBuQF9jyQd
	q6XWBPwWxAk6Jp0Sp6PI4mM9ZPC+CieoW5igq/3W0LNZBKy6BUG+A95PNvHMSWHffELK0a978C+J/
	nqtO1ZljIE6SBA8cZM81e+RZb8uENAekGG0Zys36cQxaH9UsaeADuo8flKbNPT55UcykrS1gQsE6q
	gW+DpATLTNQ1/O3TuETXsIcemTUsKG2hwD0iDrQb0M1yBKIYVRgEX2rAJrMafi4dLeQ5fxbzmu+aG
	UMnuo7UA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNX04-00000001HLz-0rSj;
	Fri, 06 Jun 2025 13:20:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20C8E3005AF; Fri,  6 Jun 2025 15:20:47 +0200 (CEST)
Date: Fri, 6 Jun 2025 15:20:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org, xin@zytor.com
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls
 in __nocfi functions
Message-ID: <20250606132047.GA39944@noisy.programming.kicks-ass.net>
References: <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
 <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
 <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>
 <eegs5wq4eoqpu5yqlzug7icptiwzusracrp3nlmjkxwfywzvez@jngbkb3xqj6o>
 <4z4fhaqesjlevwiugiqpnxdths5qkkj7vd4q3wgdosu4p24ppl@nb6c2gybuwe5>
 <20250606104945.GY39944@noisy.programming.kicks-ass.net>
 <aELptV62mbTC3YA9@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aELptV62mbTC3YA9@google.com>

On Fri, Jun 06, 2025 at 06:15:19AM -0700, Sean Christopherson wrote:
> On Fri, Jun 06, 2025, Peter Zijlstra wrote:
> > On Thu, Jun 05, 2025 at 10:19:41AM -0700, Josh Poimboeuf wrote:
> > > diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> > > index 29c5c32c16c3..5d1eef193b79 100644
> > > --- a/arch/x86/entry/entry_64_fred.S
> > > +++ b/arch/x86/entry/entry_64_fred.S
> > > @@ -112,11 +112,12 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> > >  	push %rax				/* Return RIP */
> > >  	push $0					/* Error code, 0 for IRQ/NMI */
> > >  
> > > -	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
> > > +	PUSH_AND_CLEAR_REGS clear_callee=0 unwind_hint=0
> > >  	movq %rsp, %rdi				/* %rdi -> pt_regs */
> > >  	call __fred_entry_from_kvm		/* Call the C entry point */
> > > -	POP_REGS
> > > -	ERETS
> > > +	addq $C_PTREGS_SIZE, %rsp
> > > +
> > > +	ALTERNATIVE "mov %rbp, %rsp", __stringify(ERETS), X86_FEATURE_FRED
> > 
> > So... I was wondering.. do we actually ever need the ERETS?
> 
> Yes, to unblock NMIs, because NMIs are blocked on VM-Exit due to NMI.

Ah, bah, indeed! Shame.

