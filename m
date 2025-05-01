Return-Path: <linux-efi+bounces-3518-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC3AA5C6A
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52C37A555C
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3105213E9C;
	Thu,  1 May 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFoLMRA8"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB621129D;
	Thu,  1 May 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090008; cv=none; b=c3cApOEXix8phcUA5JnSGw8pYSRQAObBz8uTjqEY5q6jFSIas9XKraxr/y65qcjkAwaX1u+RShiBx+nTc5CBt+016l2Gd12n3EykwX0GkgJMUs5kjl6rbmn19ZE9/0/qjaCzZvTX8G7MiLU2v8kmhqeWtSq5yES8hMypbhbbeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090008; c=relaxed/simple;
	bh=LeQASK9/I52gng7uxzpZlaxkXy9CNffjpfRzp80OH34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEocQDOje2u/8RNo2VOAEnvxsKb2fQ4BG0H5XIJjgLBlPDyjqplz5hm4QUGVrNrLjKA3lM6NQWRb2/RXnKCDzZ0mi7Lkb1MI0vapH4bdynwzFRnD0u3ReLeYrYuILqvHNMvxmfoJ25Mq1FWwwue4yCsfeRo0vnzP9tB8QzOV6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TFoLMRA8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/tZiJb6N356eMBa/jJoMPt7lfhTjOew0ChRJTLsc8rQ=; b=TFoLMRA8NSfKAZOaHCGUin+2Zd
	6mAzBd86Y3TLXO2N3a3eHIJvyZw+c7Or4fKCUF4w26oduI1cKDQVxKyJfYgYw2RPW4qgP6U8lqPn8
	0O/i0uwBmmhWA/HaR4O92RXA60r+l0wt7x9mW02DSSgju3ENKhFMNdq9laCPAO35KyZt7eh9mUFxW
	I0sSB/3HhRNdGtlLKSD+94GpRdMJvb81vuUwp7s8LKaqEqu7+JUK9DdBiGnnLbSfCG0X+PqvCDDWn
	YNFTV4MvggOKh/XVsY7kt2CgIA85+Z0yK5KaWIhka2aXKpiF/BesAaw0BKA3PIzhz+1RvEuTpjc58
	jwkvKHtg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAPlm-0000000H35U-13UN;
	Thu, 01 May 2025 08:59:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6BA0D30057C; Thu,  1 May 2025 10:59:49 +0200 (CEST)
Date: Thu, 1 May 2025 10:59:49 +0200
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
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>
Subject: Re: [PATCH v2 12/13] x86_64,hyperv: Use direct call to hypercall-page
Message-ID: <20250501085949.GS4439@noisy.programming.kicks-ass.net>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.335273952@infradead.org>
 <SN6PR02MB41577ED2C4E29F25B82548D7D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577ED2C4E29F25B82548D7D4822@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, May 01, 2025 at 02:36:26AM +0000, Michael Kelley wrote:
> From: Peter Zijlstra <peterz@infradead.org> Sent: Wednesday, April 30, 2025 4:08 AM
> > @@ -528,8 +546,8 @@ void __init hyperv_init(void)
> >  	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
> >  		goto skip_hypercall_pg_init;
> > 
> > -	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
> > -			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> > +	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
> > +			MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> 
> Curiosity question (which I forgot ask about in v1):  Is this change so that the
> hypercall page kernel address is "close enough" for the direct call to work from
> built-in code and from module code?  Or is there some other reason?

No, you nailed it. Because we want to do a direct CALL, the hypercall
page must be in the disp32 range relative to the call site. The module
address space ensures this.

> >  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> >  			__builtin_return_address(0));
> >  	if (hv_hypercall_pg == NULL)
> > @@ -567,27 +585,9 @@ void __init hyperv_init(void)
> >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >  	}
> > 
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
> Nit: With this IBT code removed, the #include <asm/ibt.h> at the top
> of this source code file should be removed.

Indeed so.

> 
> > +	hv_set_hypercall_pg(hv_hypercall_pg);
> > 
> > +skip_hypercall_pg_init:
> >  	/*
> >  	 * hyperv_init() is called before LAPIC is initialized: see
> >  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> > 
> > 
> 
> The nit notwithstanding,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks!

