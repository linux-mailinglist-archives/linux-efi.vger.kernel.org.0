Return-Path: <linux-efi+bounces-3327-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B774FA87F89
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28AF1664C7
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B22580E7;
	Mon, 14 Apr 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cH/FVMrZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDA199FAF;
	Mon, 14 Apr 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631281; cv=none; b=FTsYAMiYhVP/wtMX28xuiQ7RG1LL6FyGTrzgYvaiv4+beoBGi86J532VhIplD9mpOinnhwswOTYru63EsnhDv5wpCCwR6mDrvzriBeGXBoUr0uOI9J63ziT4SqlwqnLFnIgiKiC09R/DR2wFAu7YDLvZfjvk0UUhXBJb9M48OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631281; c=relaxed/simple;
	bh=rsZJVMyiJWRZIkgXEdTJUAU7MRBMZlOfLgE1wevy0I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilqon0l3GZe2nHF1de/fUqQfEkTkjSWegi5aSKIJLyI1ogPY6ps8WW3yxJdeUo2WWpFXQmbcMlYucfeV1rWpW54HffRKwe46N460WVPemTSJDgMB0+eTIp9xpYKzj7ou7e4Gp+ZLQ/KSNIz+qL8iHwRtn6+P8BidbL8+M/h0d1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cH/FVMrZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxeTC3AwF/U4zM+fafNv0sTiM765czZfk/h3ZPa9SE8=; b=cH/FVMrZ0BZM4Ru4hVdJfoOKdo
	+tJ7sZ1vGwT/YQdwWrckK92xUscWHWIypr2s9x/r8f6dAoeA+wONaCBDVVfGT/THVl+83RwgNFvhD
	pwJ3ur3ZRGlRMMhsD1NvPaePPlxAe1LPidVCLedwO+NZXobWx+4fjSRVzu9Wzii4WomjnIcxtmAIn
	Y8j1OG+evJ278ZlD6jEJDStS7dUJQ7tnOmV8pWUYRMhcO/ew6oR/31rgRQ1M+wdbiRd+U4MOmAWn6
	3ZfYCkqO+2vWZSrWKwBQPg4OfYm2MNOGDxFpdKIt/trfgywuTvoc3Oz4d2+YIFDvnHMmQvREkNXZe
	f7tf0z7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4II2-000000084qm-3ALM;
	Mon, 14 Apr 2025 11:47:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2716300619; Mon, 14 Apr 2025 13:47:50 +0200 (CEST)
Date: Mon, 14 Apr 2025 13:47:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
	seanjc@google.com, pbonzini@redhat.com, ardb@kernel.org,
	kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, samitolvanen@google.com,
	ojeda@kernel.org
Subject: Re: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
Message-ID: <20250414114750.GG5600@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.285564821@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414113754.285564821@infradead.org>

On Mon, Apr 14, 2025 at 01:11:44PM +0200, Peter Zijlstra wrote:

> +u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	if (!hv_hypercall_pg)
> +		return U64_MAX;
> +
> +	register u64 __r8 asm("r8") = param2;
> +	asm volatile (CALL_NOSPEC
> +		      : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +		        "+c" (control), "+d" (param1)
> +		      : "r" (__r8),
> +		        THUNK_TARGET(hv_hypercall_pg)
> +		      : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}

I've tried making this a tail-call, but even without the
ASM_CALL_CONSTRAINT on it confuses the compiler (objtool warns on
frame-pointer builds about non-matching stack).

I could of course have written the entire thing in asm, but meh.

