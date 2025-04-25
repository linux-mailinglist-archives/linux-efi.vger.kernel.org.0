Return-Path: <linux-efi+bounces-3463-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C6CA9CAD5
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EE11BA5515
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0121A459;
	Fri, 25 Apr 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mN0LkFd0"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7961FF2;
	Fri, 25 Apr 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589047; cv=none; b=n/TPEjsb4hicRZ/qi1qtwsqpGaMP8YF6Gns7wEbUFWR9RRI6HzliYK6/ONuikr6K/s2727g5VdRgDz2Dhv+kFZekJiwtPxFYNW3F318/naC8/X9LqvsXVt25gee+lI3+HwTIdpGvwJvgyGn48o3Kw4jmsEaL8ZTX1SbFfxqQPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589047; c=relaxed/simple;
	bh=WxQ5Ou/fI09he56FhDFzuvM5OvovP9p41Kpo80ZlRI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdOSypDgMJNC1x2yymFIx4XHrx6Rk8opYLTyV0+6wCagYkS82U7iOLV5VUUZiQK7x64KYAvkiyMfMYh/euiPOTBPu75lWKxbMdJRHSHpv20gHOIJch5BkRK85J2MgMee1a9Nz4LRorPNEKYuTCQ9aqw258qaNWMsYWsDYBZzN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mN0LkFd0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hgYA6FEh3vjzB5qqCTmatdfoxf97Onxqc6wILtW6+qs=; b=mN0LkFd0GR/+ivo3qlMWXNGLgi
	h9IJb5yyG9G4IoK0Lcj/MhbXl2a516EmM+1/AO/mUId6aN08ZsT9ue6rF4TUb/pPLf22G09xAwg4h
	Y1yhoxu36dqnKz6Ywv4uPYzbio8Lh14wg9f/yIT41WKIhsWCl5OGHFJFO1isF1WrPlDoOnFKW9q+s
	tcgVr0e5+ZIBsx7GflmOcxfNjuPxDJaCZf22eamqXu9K0kINXUbXOUidX6jb/NEhvL9Y7t/zuYqMg
	z4BGNK3sgxIjlm3vI/4LLu+TwfABBUSfEY43J/GHzfqlDg2kmoOZm5vH2jon1Di/5Qz5S8VpeY0I4
	weqzQKvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JRf-0000000EcS2-2PpK;
	Fri, 25 Apr 2025 13:50:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE817300583; Fri, 25 Apr 2025 15:50:22 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:50:22 +0200
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
Message-ID: <20250425135022.GB35881@noisy.programming.kicks-ass.net>
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
> From: Peter Zijlstra <peterz@infradead.org> Sent: Monday, April 14, 2025 4:12 AM
> > 
> > What used to be a simple few instructions has turned into a giant mess
> > (for x86_64). Not only does it use static_branch wrong, it mixes it
> > with dynamic branches for no apparent reason.
> > 
> > Notably it uses static_branch through an out-of-line function call,
> > which completely defeats the purpose, since instead of a simple
> > JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> > absolutely idiotic.
> > 
> > Add to that a dynamic test of hyperv_paravisor_present, something
> > which is set once and never changed.
> > 
> > Replace all this idiocy with a single direct function call to the
> > right hypercall variant.
> 
> This did indeed need cleaning after all the CoCo VM and paravisor
> stuff got added. Thanks for doing it.
> 
> From looking at the code changes, I believe the 32-bit hypercall paths
> are unchanged, as they weren't affected the CoCo VM and paravisor
> additions. Perhaps explicitly state that intent in the commit message.
> 
> I've tested this patch set against linux-next-20250411 on normal Hyper-V
> guests. Basic smoke tests pass, along with taking a panic, and
> suspend/resume for guest hibernation. But getting into kdump after a
> panic does not work. See comments in Patch 5 for the likely reason why.
> 
> I've also tested SNP and TDX VMs with a paravisor, and basic smoke
> tests pass. But I'm testing in the Azure cloud, and I don't have access to an
> environment where I can test without a paravisor. So my testing doesn't
> cover the SNP and TDX specific static call paths. Maybe someone at
> Microsoft can test that configuration.

Excellent, thanks!


> > +#ifdef CONFIG_X86_64
> > +u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> 
> Could this get a different name so we don't have the confusion of
> hv_hypercall_pg vs hv_pg_hypercall?  Some possibilities:
> 
> hv_std_hypercall
> hv_basic_hypercall
> hv_core_hypercall
> hv_normal_hypercall
> hv_simple_hypercall

Sure, I'll throw a dice an pick one ;-)


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

I'll try and make it so.

