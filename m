Return-Path: <linux-efi+bounces-3464-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8311A9CB05
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B877B5154
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D16256C64;
	Fri, 25 Apr 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdLCh9im"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7D71747;
	Fri, 25 Apr 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589849; cv=none; b=XEA0nft/NhvJe5VBO9RfY9IYRzPsVAcfCsE68J2dt2pdraEbTFzOnQjgkEDlA9rwUyFQwMlQo75YHKncTWo23zWnCwjpS1hlFnmSaP9KdUaolkWsJFNtzmligbgPAz86PTyhMMWWcMejU8BY33TtyZVpNDwfsBCjno3Qa0fYHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589849; c=relaxed/simple;
	bh=SFupk4v6QJ6TlAyt+7q2iFUfESVzQt4Wl/LCynUO2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUeSrOgG1eOvtuj8DiRn9L8d9JJxWvMG/nUr10emHIVdN4VDYzcZvYxdw4Dwgc3yRNFqRC7HU431hZR3I7lVhnkeZ2dadVhaq6HZZyM4bLnPAEJJBIQ5uxMzc8Bm48u0b8bpSPOvWy7pVLXJU2szozLvyScegyQbitRmG7gxJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cdLCh9im; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6GJUp83AnQU0MiirmcllULgGL0i2UtZufh6Ag9k8WPQ=; b=cdLCh9imvdPDJn9XZSscVYkaOh
	wuLPxe9kSpgU+AwLB3ch8ed3Y4ttOyfmGV2Quf27dKavUqnkZO7IjGeZMHbxImCcjIUNev3buCChm
	/o/QWG+M9l1oTfkrTQvXyHq+0lRT+vofp5q92mqHLvS3st0JvaRUyLRziwX8SoFT4iDsbm5ULuZjR
	QV86LOtz7zRFoEdBpMR0459Z5V6IEDEfabipL6tncIwUgN5V1vmiHUlZaUDXqPbIRWiadblUhXm8z
	H92GbaRMH1yJZRW5ircTv9Ja2MxhyiJsykVcogeFzm8XdlqMBV9ACHbfa/FXlWKhVjtFi4M4gGqxN
	Jn+L1Zkw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8Jem-0000000C3la-0QqR;
	Fri, 25 Apr 2025 14:03:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A91333003C4; Fri, 25 Apr 2025 16:03:55 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:03:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Message-ID: <20250425140355.GC35881@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.435282530@infradead.org>
 <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Apr 21, 2025 at 06:28:42PM +0000, Michael Kelley wrote:

> >  #ifdef CONFIG_X86_64
> > +static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
> > +{
> > +	return U64_MAX;
> > +}
> > +
> > +DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
> > +
> >  u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> >  {
> >  	u64 hv_status;
> > 
> > +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
> >  		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> >  		        "+c" (control), "+d" (param1)
> > +		      : "r" (__r8)
> >  		      : "cc", "memory", "r9", "r10", "r11");
> > 
> >  	return hv_status;
> >  }
> > +
> > +typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2);
> > +
> > +static inline void hv_set_hypercall_pg(void *ptr)
> > +{
> > +	hv_hypercall_pg = ptr;
> > +
> > +	if (!ptr)
> > +		ptr = &__hv_hyperfail;
> > +	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
> > +}

^ kept for reference, as I try and explain how static_call() works
below.

> > -skip_hypercall_pg_init:
> > -	/*
> > -	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
> > -	 * in that there's no ENDBR64 instruction at the entry to the
> > -	 * hypercall page. Because hypercalls are invoked via an indirect call
> > -	 * to the hypercall page, all hypercall attempts fail when IBT is
> > -	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> > -	 *
> > -	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
> > -	 * page, so if future Linux kernel versions enable IBT for 32-bit
> > -	 * builds, additional hypercall page hackery will be required here
> > -	 * to provide an ENDBR32.
> > -	 */
> > -#ifdef CONFIG_X86_KERNEL_IBT
> > -	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> > -	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
> > -		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > -		pr_warn("Disabling IBT because of Hyper-V bug\n");
> > -	}
> > -#endif
> 
> With this patch set, it's nice to see IBT working in a Hyper-V guest!
> I had previously tested IBT with some hackery to the hypercall page
> to add the missing ENDBR64, and didn't see any problems. Same
> after these changes -- no complaints from IBT.

No indirect calls left, no IBT complaints ;-)

> > +	hv_set_hypercall_pg(hv_hypercall_pg);
> > 
> > +skip_hypercall_pg_init:
> >  	/*
> >  	 * hyperv_init() is called before LAPIC is initialized: see
> >  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> > @@ -658,7 +658,7 @@ void hyperv_cleanup(void)
> >  	 * let hypercall operations fail safely rather than
> >  	 * panic the kernel for using invalid hypercall page
> >  	 */
> > -	hv_hypercall_pg = NULL;
> > +	hv_set_hypercall_pg(NULL);
> 
> This causes a hang getting into the kdump kernel after a panic.
> hyperv_cleanup() is called after native_machine_crash_shutdown()
> has done crash_smp_send_stop() on all the other CPUs. I don't know
> the details of how static_call_update() works, 

Right, so let me try and explain this :-)

So we get the compiler to emit direct calls (CALL/JMP) to symbols
prefixed with "__SCT__", in this case from asm, but more usually by
means of the static_call() macro mess.

Meanwhile DEFINE_STATIC_CALL() ensures such a symbol actually exists.
This symbol is a little trampoline that redirects to the actual
target function given to DEFINE_STATIC_CALL() -- __hv_hyperfail() in the
above case.

Then objtool runs through the resulting object file and stores the
location of every call to these __STC__ prefixed symbols in a custom
section.

This enables static_call init (boot time) to go through the section and
rewrite all the trampoline calls to direct calls to the target.
Subsequent static_call_update() calls will again rewrite the direct call
to point elsewhere.

So very much how static_branch() does a NOP/JMP rewrite to toggle
branches, static_call() rewrites (direct) call targets.

> but it's easy to imagine that
> it wouldn't work when the kernel is in such a state.
> 
> The original code setting hv_hypercall_pg to NULL is just tidiness.
> Other CPUs are stopped and can't be making hypercalls, and this CPU
> shouldn't be making hypercalls either, so setting it to NULL more
> cleanly catches some erroneous hypercall (vs. accessing the hypercall
> page after Hyper-V has been told to reset it).

So if you look at (retained above) hv_set_hypercall_pg(), when given
NULL, the call target is set to __hv_hyperfail(), which does an
unconditional U64_MAX return.

Combined with the fact that the thing *should* not be doing hypercalls
anymore at this point, something is iffy.

I can easily remove it, but it *should* be equivalent to before, where
it dynamicall checked for hv_hypercall_pg being NULL.

