Return-Path: <linux-efi+bounces-3487-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9052AA1034
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807227A6353
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E46221554;
	Tue, 29 Apr 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ge2uLYgB"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1C2206A2;
	Tue, 29 Apr 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939903; cv=none; b=sasNp0txgV1v3MVooZBvKKeZwzhN7FOIX2u9QWnI1sWbBd6iGRDMMA5M4a9U5H+aEQYLBUL/jnCpZxm9zQjgIjrpilrtO7FLLbeSh6Epf4CaAAtjjdoDV6+M+SasBkVkmNWEEm1nGPn7abp65Jk40voqGGG3gPpU3vAFbsEEO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939903; c=relaxed/simple;
	bh=8VmsUfy4oGkBgpiVNpKnRzR9FzVBWw8+7h+igFZqohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1PgyjJGyiNnYQW/tF6FQakv6xG16skVndPSnkpE8OfbcrEdW4VCLfGZPy+S7Qv9JmDUXtfLdFfWxIFEg8wZW79Qs77wDlCvOCmTxyC9QPuBm7GKtW1tMwMUdtTvYW8dTBo8jx+YbbKTncyf40Qor3lzzpn3lehEiQtieYMrSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ge2uLYgB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tIP/KdhiQl8cNhYgM0Ij/qnDfzymTW4G7ttqWADxIEQ=; b=ge2uLYgBA36hugS6ygLwErvxiN
	vKjEePgpaCRiMYwV/JWfp4oTOSzFcJQ+N8WwfUReVRT7zD+jmwXZlR1nDZDEURKJuNfDnuNR+DxIy
	UFMy4pTCBjYxkkOtUxG5ak9TGGNOrmBH9RGJbpVA2G2t86pnDRcLsVhDAb7HeVRPOb+lxpcy9249M
	RBdkJUNZlgPNJ2Gj+RNjcKYr6krlPKaJCwarf0IK5jRrKCIXVkzugaIfRxh0/mZnxDC5+INeuzs/H
	0o000QIQ4TT9/CbIlHw0IzCQ3HiobeV4JWdEEDNTeRs7VoFcsMiQFTJ08zMMshrwIFaWkQq8vqTE1
	uVsV/7SA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9min-00000000Gv4-2MOB;
	Tue, 29 Apr 2025 15:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FE5530035E; Tue, 29 Apr 2025 17:18:09 +0200 (CEST)
Date: Tue, 29 Apr 2025 17:18:08 +0200
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
Subject: Re: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
Message-ID: <20250429151808.GJ4198@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.285564821@infradead.org>
 <SN6PR02MB41576A943191D154521C23C8D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41576A943191D154521C23C8D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Apr 21, 2025 at 06:27:57PM +0000, Michael Kelley wrote:

> > @@ -483,14 +484,16 @@ static void __init ms_hyperv_init_platfo
> >  			ms_hyperv.shared_gpa_boundary =
> >  				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
> > 
> > -		hyperv_paravisor_present = !!ms_hyperv.paravisor_present;
> > -
> >  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
> >  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> > 
> > 
> >  		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
> >  			static_branch_enable(&isolation_type_snp);
> > +#if defined(CONFIG_AMD_MEM_ENCRYPT) && defined(CONFIG_HYPERV)
> > +			if (!ms_hyperv.paravisor_present)
> > +				static_call_update(hv_hypercall, hv_snp_hypercall);
> > +#endif
> 
> This #ifdef (and one below for TDX) are really ugly. They could be avoided by adding
> stubs for hv_snp_hypercall() and hv_tdx_hypercall(), and making the hv_hypercall static
> call exist even when !CONFIG_HYPERV (and for 32-bit builds). Or is there a reason to
> not do that?
> 
> >  		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
> >  			static_branch_enable(&isolation_type_tdx);
> > 
> > @@ -498,6 +501,9 @@ static void __init ms_hyperv_init_platfo
> >  			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
> > 
> >  			if (!ms_hyperv.paravisor_present) {
> > +#if defined(CONFIG_INTEL_TDX_GUEST) && defined(CONFIG_HYPERV)
> > +				static_call_update(hv_hypercall, hv_tdx_hypercall);
> > +#endif
> >  				/*
> >  				 * Mark the Hyper-V TSC page feature as disabled
> >  				 * in a TDX VM without paravisor so that the
> > 
> > 

I've ended up with the below.. I thought it a waste to make all that
stuff available to 32bit and !HYPERV.


--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -392,6 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 pa
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
+u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) {}
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
 #ifdef CONFIG_INTEL_TDX_GUEST
@@ -441,6 +442,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
 #else
 static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
 static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) {}
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -39,6 +39,10 @@ static inline unsigned char hv_get_nmi_r
 	return 0;
 }
 
+extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
+extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
+
 #if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 
@@ -48,10 +52,6 @@ bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
 #ifdef CONFIG_X86_64
-extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
-extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
-extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
-
 DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
 #endif
 
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -287,9 +287,14 @@ static void __init x86_setup_ops_for_tsc
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
 EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
+#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
 #endif
 #endif /* CONFIG_HYPERV */
 
+#ifndef hypercall_update
+#define hypercall_update(hc) (void)hc
+#endif
+
 static uint32_t  __init ms_hyperv_platform(void)
 {
 	u32 eax;
@@ -490,10 +495,8 @@ static void __init ms_hyperv_init_platfo
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
-#if defined(CONFIG_AMD_MEM_ENCRYPT) && defined(CONFIG_HYPERV)
 			if (!ms_hyperv.paravisor_present)
-				static_call_update(hv_hypercall, hv_snp_hypercall);
-#endif
+				hypercall_update(hv_snp_hypercall);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
 
@@ -501,9 +504,7 @@ static void __init ms_hyperv_init_platfo
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-#if defined(CONFIG_INTEL_TDX_GUEST) && defined(CONFIG_HYPERV)
-				static_call_update(hv_hypercall, hv_tdx_hypercall);
-#endif
+				hypercall_update(hv_tdx_hypercall);
 				/*
 				 * Mark the Hyper-V TSC page feature as disabled
 				 * in a TDX VM without paravisor so that the

