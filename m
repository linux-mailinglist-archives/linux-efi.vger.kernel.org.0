Return-Path: <linux-efi+bounces-3811-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC665ACBFA8
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jun 2025 07:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D853A2E5C
	for <lists+linux-efi@lfdr.de>; Tue,  3 Jun 2025 05:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7871EF38E;
	Tue,  3 Jun 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO4zKErd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7512CD88;
	Tue,  3 Jun 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748929422; cv=none; b=QpSMdP7hq1JCY8xMF1Fvyl1M1dgG3tXo9n8KfWRKSIFGua8NJ857lWyj4WI3occP4uRiwOLYG9yWF6WBPHpcACZdzKKxa7TCw0SGwWuZpqo8+YEnpGCURsUdPEDWKe8cBFk+y91TlBepFacXEp3nMMrY8iByFAIUn/68SvIxAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748929422; c=relaxed/simple;
	bh=dBDuxX25tTZhWyablUxEmDxuDN0NyCprcLe7uD1BThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSLq+wtUFWK+ePKAYRuZiqPXIaePLCP3wgAVqkwKGu8FtoQvvfgtUjxS6aCVUS+8ZTHRqeZ73zI0uUWQqQWg1wWqwlrPZOJORE6Yq3+SFYi0/4tyuP5co7QfR5rlbPhTF7xjw+AzhBoz8Oyowehi2e4GgNDM5tZTTgANBmeJ4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO4zKErd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189A8C4CEED;
	Tue,  3 Jun 2025 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748929422;
	bh=dBDuxX25tTZhWyablUxEmDxuDN0NyCprcLe7uD1BThU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO4zKErdl73wwdFKnOZK/idz3ZOuGTHPttM5VKjOj3KQ8vgQg95j8jBTGe46kpL0u
	 +Mto1GvtaW12jj/7WJC4ar56TEhfIiWIMc0N1jpKjbnpadFGTL8EtsWBVAHPOlNJvl
	 H9wNcrmge6B2LRZJHeVTL+bWqmapAOV/IGv5+4PDKpIJcwC9XLeFXKTTLIYYfWw12O
	 kH/kPLwqwJMmtP799tTxXK1fyuqUtK+n1aFY6z7puZNccp73x0ftgEPN/5NMlu8Q14
	 iUEN/Thg6kE6RVb4kCd0acF/QCZl6FiDxgSwoBm5OaGZwWJ3A3cK4CXVd7uyxbxGFj
	 xnA+WM2Cjoweg==
Date: Mon, 2 Jun 2025 22:43:33 -0700
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
Message-ID: <fp5amaygv37wxr6bglagljr325rsagllbabb62ow44kl3mznb6@gzk6nuukjgwv>
References: <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
 <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
 <20250528074452.GU39944@noisy.programming.kicks-ass.net>
 <20250528163035.GH31726@noisy.programming.kicks-ass.net>
 <20250528163557.GI31726@noisy.programming.kicks-ass.net>
 <20250529093017.GJ31726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529093017.GJ31726@noisy.programming.kicks-ass.net>

On Thu, May 29, 2025 at 11:30:17AM +0200, Peter Zijlstra wrote:
> > > So the sequence of fail is:
> > > 
> > > 	push %rbp
> > > 	mov %rsp, %rbp	# cfa.base = BP
> > > 
> > > 	SAVE
> 
> 	sub    $0x40,%rsp
> 	and    $0xffffffffffffffc0,%rsp
> 
> This hits the 'older GCC, drap with frame pointer' case in OP_SRC_AND.
> Which means we then hard rely on the frame pointer to get things right.
> 
> However, per all the PUSH/POP_REGS nonsense, BP can get clobbered.
> Specifically the code between the CALL and POP %rbp below are up in the
> air. I don't think it can currently unwind properly there.

RBP is callee saved, so there's no need to pop it or any of the other
callee-saved regs.  If they were to change, that would break C ABI
pretty badly.  Maybe add a skip_callee=1 arg to POP_REGS?

-- 
Josh

