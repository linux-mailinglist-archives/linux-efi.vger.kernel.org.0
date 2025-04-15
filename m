Return-Path: <linux-efi+bounces-3337-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1BA8A15F
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B538C1901AAB
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFAA2951C8;
	Tue, 15 Apr 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp3+5g+i"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183F186E20;
	Tue, 15 Apr 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727986; cv=none; b=nSNTqKJt4f9OB7Jx6PpPVc2d5xhud1eUNX4HRaNf4BbOIgFcxiJPQgL61CzW7ynR5tZ5h+Z1BnbMF7nPHZQvYKXUyMc8tWLnyNnb4nhyOo0VeKBgM9wjiQ+pte5yrcnz4fc3FJ/ApCtDH0baNaXjxrEb0QpVLbt/bd0sB+9mx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727986; c=relaxed/simple;
	bh=ozuDpvd1BZMVE00xvQrMW1pPsmt2NtjEfCI6CBnhgro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUb9uNuc9PGAt0jXHlH0PhtJxLIqNUyutEBba0kp2S+2excMYn8Se2tq8sqEyhCxkQzwccPZ23dGDvzKC8fOCfqMk/ucPQ2NDy0b5wmS6ou6l6Y01LWG1PvQ3XotjawcOQRpqO2UwP/bXGtbT3Uzh4fdWi4ULIvuOT1VtYfWwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp3+5g+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB43BC4CEDD;
	Tue, 15 Apr 2025 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744727985;
	bh=ozuDpvd1BZMVE00xvQrMW1pPsmt2NtjEfCI6CBnhgro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp3+5g+i3mff9jfnM42NTBXMcSXDYrCCXMrGeVWe/CeWEbN/8altQBqr7xLvbvwI3
	 8evngvMvgGS/tAqHXxgabuor3E3AtqbORoEXxmy51Jsa00KFvqPkR97Q4U5wyjIoJ2
	 nkzks5dUbZoDWJ6VUD4ksD941WIJPEF+qwbuWlY5RN+MLnQa1tgrWQrLywxya55CgF
	 QFXQCMzOgN6nznyv34Zw0hNUO1QN8YdB7yJj0BlU/2EDdR+xG+X99577eWRqJmHIab
	 zviWj/9FErIvQAUFKFWtuqyxBfpAqDGK1JeCj9diwDE+afhCMps8G/h8Pd2I/lOibL
	 1ZoPKzsUtDBCw==
Date: Tue, 15 Apr 2025 07:39:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org, 
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.172767741@infradead.org>
 <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415074421.GI5600@noisy.programming.kicks-ass.net>

On Tue, Apr 15, 2025 at 09:44:21AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 14, 2025 at 03:36:50PM -0700, Josh Poimboeuf wrote:
> > On Mon, Apr 14, 2025 at 01:11:43PM +0200, Peter Zijlstra wrote:
> > > Since there is only a single fastop() function, convert the FASTOP
> > > stuff from CALL_NOSPEC+RET to JMP_NOSPEC+JMP, avoiding the return
> > > thunks and all that jazz.
> > > 
> > > Specifically FASTOPs rely on the return thunk to preserve EFLAGS,
> > > which not all of them can trivially do (call depth tracing suffers
> > > here).
> > > 
> > > Objtool strenuously complains about things, therefore fix up the
> > > various problems:
> > > 
> > >  - indirect call without a .rodata, fails to determine JUMP_TABLE,
> > >    add an annotation for this.
> > >  - fastop functions fall through, create an exception for this case
> > >  - unreachable instruction after fastop_return, save/restore
> > 
> > I think this breaks unwinding.  Each of the individual fastops inherits
> > fastop()'s stack but the ORC doesn't reflect that.
> 
> I'm not sure I understand. There is only the one location, and we
> simply save/restore the state around the one 'call'.

The problem isn't fastop() but rather the tiny functions it "calls".
Each of those is marked STT_FUNC so it gets its own ORC data saying the
return address is at RSP+8.

Changing from CALL_NOSPEC+RET to JMP_NOSPEC+JMP means the return address
isn't pushed before the branch.  Thus they become part of fastop()
rather than separate functions.  RSP+8 is only correct if it happens to
have not pushed anything to the stack before the indirect JMP.

The addresses aren't stored in an .rodata jump table so objtool doesn't
know the control flow.  Even if we made them non-FUNC, objtool wouldn't
be able to transfer the stack state.

-- 
Josh

