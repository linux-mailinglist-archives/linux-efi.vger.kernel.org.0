Return-Path: <linux-efi+bounces-3619-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BBAACDEE
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 21:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4327AAA48
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9F1EA7DD;
	Tue,  6 May 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHcHa75S"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428221A3A8A;
	Tue,  6 May 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559133; cv=none; b=nDcb0edX/b2JFXhLYORIYiaHHSaqyvUcgcXtaJxnCCLwhJrvxrtf2i+6O7yRFPrrLBOa99psEtLQe9uBMDeAi3+gKteQziQA178dySRfyX8dHcaDbzk5ueHS5spLIj1lKkKytdaCWL3Zsx3stOyj6e8ulgHc4XwzoQKoP858xv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559133; c=relaxed/simple;
	bh=IWWPVYiHCcNYdmZwlOlrJ2372bc/2Pu9nYrjsznihX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LroQDG0JAuFiMY+s5ryyaelvMA6SVtXaEqY7Nuhv4qKR+b2XUloVjcPiUGQan4CSJopU/LrD2YcfxgG9HNtnw9YUw2c0uurcg4ioMl+INZXKFBIPfSNfDcNxQbmwdcdXJEKUB6llTR6YBNh0ozI+wgfX/10RqzlVDHJoe1/hlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHcHa75S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA7C4CEE4;
	Tue,  6 May 2025 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746559132;
	bh=IWWPVYiHCcNYdmZwlOlrJ2372bc/2Pu9nYrjsznihX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHcHa75SVDk9HCrZ9eoC3Up3LWARsKhrbFvjqFKqZ+HbsfFljutHr5Y1ASCbFkPa5
	 5UHJsregxDmG95toGxVxR5pWWSwpUDZymssdlLSvelb1cxf4F4nZnVmZ2O4IjDGQQm
	 bDxHFQf+/iq2DqeZrcGq1EHSWWBgWsCWyxDJ74JGFPyeWREsktmfM8NMQbdxTcEuZn
	 7f67f9GcGRrfUUHfU8Cpng0YuAczGB1SUXfoTiLiKip1tm2JcngfNC2aMSLPTnWOTv
	 QUySPOezZQZTP353tarTds0Fd9VkD74lBUkLAVciu/HLmUMnJQ3i+v36oKTu4iGYaS
	 UAxZ86/pS3Xzg==
Date: Tue, 6 May 2025 12:18:49 -0700
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
Message-ID: <vukrlmb4kbpcol6rtest3tsw4y6obopbrwi5hcb5iwzogsopgt@sokysuzxvehi>
References: <20250430190600.GQ4439@noisy.programming.kicks-ass.net>
 <20250501103038.GB4356@noisy.programming.kicks-ass.net>
 <20250501153844.GD4356@noisy.programming.kicks-ass.net>
 <aBO9uoLnxCSD0UwT@google.com>
 <20250502084007.GS4198@noisy.programming.kicks-ass.net>
 <aBUiwLV4ZY2HdRbz@google.com>
 <20250503095023.GE4198@noisy.programming.kicks-ass.net>
 <p6mkebfvhxvtqyz6mtohm2ko3nqe2zdawkgbfi6h2rfv2gxbuz@ktixvjaj44en>
 <20250506073100.GG4198@noisy.programming.kicks-ass.net>
 <20250506133234.GH4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506133234.GH4356@noisy.programming.kicks-ass.net>

On Tue, May 06, 2025 at 03:32:34PM +0200, Peter Zijlstra wrote:
> On Tue, May 06, 2025 at 09:31:00AM +0200, Peter Zijlstra wrote:
> > On Sat, May 03, 2025 at 11:28:37AM -0700, Josh Poimboeuf wrote:
> > > Can we just adjust the stack in the alternative?
> > > 
> > > 	ALTERNATIVE "add $64 %rsp", __stringify(ERETS), X86_FEATURE_FRED
> > 
> > Yes, that should work. 
> 
> Nope, it needs to be "mov %rbp, %rsp". Because that is the actual rsp
> value after ERETS-to-self.
> 
> > But I wanted to have a poke at objtool, so it
> > will properly complain about the mistake first.
> 
> So a metric ton of fail here :/
> 
> The biggest problem is the UNWIND_HINT_RESTORE right after the
> alternative. This ensures that objtool thinks all paths through the
> alternative end up with the same stack. And hence won't actually
> complain.

Right, that's what the unwind hints are made for, it's up to the human
to get it right.

> Second being of course, that in order to get IRET and co correct, we'd
> need far more of an emulator.

At least finding RSP should be pretty easy, it's at a known location on
the stack.  We already have an ORC type for doing that, but that would
again require an unwind hint, unless we make objtool smart enough to
know that.  But then the ORC would be inconsistent between the two
alternative paths.

> Also, it actually chokes on this variant, and I've not yet figured out
> why. Whatever state should be created by that mov, the restore hint
> should wipe it all. But still the ORC generation bails with unknown base
> reg -1.

Weird, I'm not seeing that.

-- 
Josh

