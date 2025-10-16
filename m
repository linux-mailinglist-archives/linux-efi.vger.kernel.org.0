Return-Path: <linux-efi+bounces-5062-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6934BE1543
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 05:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCFA54E01FA
	for <lists+linux-efi@lfdr.de>; Thu, 16 Oct 2025 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490981CAA7B;
	Thu, 16 Oct 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b2iF/cpC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D057260F;
	Thu, 16 Oct 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584297; cv=none; b=iyjws5dchnXaiJc1uihNWYjMAqXwzlNeuQxLCgjNtrpEAG02T6WHrcJd2cfKokRQsl2U9iTwb0tvSWmFFB4N1g84icLbYg7PAFPVLnLT0wzPEIE3HyUizHgliMiERF9M5LhVinsJd4NOGPxyIvEaNNafTQ+KUhyn5ajxbLYQEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584297; c=relaxed/simple;
	bh=PSUFLzM/sUjlNBalWuNjP/B0B8hxIYxq5kDmv2L17mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ6mPmKC0+fF9lV6gdn8nId87GEjj2CNYCVgfZj7r4vfrhc74cmYpY4hHrZtsQ24kOp1Q9xO6NGVBvRpky+yBOYzqXczGP042K5XvFyrE5SR2LL6Lo1TXty/f/oNDMUChg3+ATdE4keJkSiXgZRoTe5k4zGMiobr39WQbuZroqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=b2iF/cpC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59G3ARDA2798705
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 20:10:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59G3ARDA2798705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760584231;
	bh=eCDrqpdDSCCbgxuvwfM/A/XESeZ1rZMuetA+BzOccp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b2iF/cpC1bYjFpCVSY9rMyzNqGIsbgvYKHh9V0aSKiFzW+BiG4Y8mSBrVXwgIm5bS
	 snWktCXM494AvOMMJNsuj2oZ8bITQgfTBd54J95VPwYoJxdILAE4CCWgGNczm2QOHT
	 aOFIuOGmbazc469Sq6kAdpSY4oiZLSigyoLGaymyADXcvJSGusRb96uJsmBf2Y7Dsd
	 NeQmxIXBqeDzFVkvwyQh490glQQkxLNfTf43067cjjBaN/OxGDCCYIMvycW/5WBpwL
	 vJZkAU3xNSL4p4uZdoJM04xnWCFVv31cCr7kW2M6LwWuK855dA2ZwOTY8hCMz0LAWm
	 Ku4QdqLp1WMaw==
Message-ID: <6da9ae07-622e-428b-b1de-df4ead7a7761@zytor.com>
Date: Wed, 15 Oct 2025 20:10:27 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "kas@kernel.org" <kas@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
        "xin@zytor.com" <xin@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kees@kernel.org" <kees@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
 <5d95d421-1413-46de-a578-c2a0e44e3aa1@intel.com>
 <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-07 13:20, Sohil Mehta wrote:
> 
> The spec says,
> "A supervisor-mode data access causes a LASS violation if it would
> access a linear address of which bit 63 is 0, supervisor-mode access
> protection is enabled (by setting CR4.SMAP), and either RFLAGS.AC = 0 or
> the access is an implicit supervisor-mode access."
> 
> One could argue that the LASS hardware enforcement of the kernel data
> accesses *depends* on SMAP being enabled.
> 
>> Actually, it might be worth breaking this dependency hunk out into its
>> own patch, just so there's a nice clean place to discuss this.
> 
> Sure, we can talk about the above wording in the spec, as well as the
> STAC/CLAC dependency in a separate patch.
> 
> I included some information in the cover letter to explain that:
> 
> When there are valid reasons for the kernel to access memory in the user
> half, it can temporarily suspend LASS enforcement by toggling the
> RFLAGS.AC bit. Most of these cases are already covered today through the
> stac()/clac() pairs, which avoid SMAP violations. However, there are
> kernel usages, such as text poking, that access mappings (!_PAGE_USER)
> in the lower half of the address space. LASS-specific AC bit toggling is
> added for these cases.

Just to be clear: there is no reason to spend any time whatsoever on
supporting LASS without SMAP, because no such hardware is ever expected to
exist. The CPU feature dependencies are not all necessarily architectural, but
also Linux implementation choices -- Linux is in no way somehow required to be
optimized for every combination of features, and a lot of the time it makes
perfect sense to say "you don't have X, so I won't use Y either."

	-hpa


