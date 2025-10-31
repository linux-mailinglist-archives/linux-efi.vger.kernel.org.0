Return-Path: <linux-efi+bounces-5317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8FC26887
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ABD3BE2A2
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D2350A06;
	Fri, 31 Oct 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd24JM5O"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC7330B1D;
	Fri, 31 Oct 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934376; cv=none; b=Cry2k4P3wuDnSeOPMAm1h0aOATgtc+wlZmOJDYqJobhY9cpZ4I4y7g6XuozWJQPETdw5qvhzBPAtE0QthqpPyyeg9Yubb3nrUW1e2hJ27odAmNrTtlwR8KiWqnWLNe2eZgjMoqB24e+faVnvXPgZA5GNrIJhFqiuPpSCGrcfOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934376; c=relaxed/simple;
	bh=zcsY/9vIUhw+9jGtgQmPAFtoAzO7BoMmBaWoytIMxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/gpXKB6DZKWAHZy9FKgA/KgZTdizSeUzgnWMlW1c6rTJjmPWQcFimKgb/xHuFvzCiLhbXwECTzLyon/eqg+sd+7Ct6gEbmpf55A6zhGMDKvM52ThiYxl9np/PCu1aJ4+AemmRosHXQchfdoU/w7kDL/+YfstvAoxnmmJv9a91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd24JM5O; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761934376; x=1793470376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zcsY/9vIUhw+9jGtgQmPAFtoAzO7BoMmBaWoytIMxjE=;
  b=Zd24JM5Oc9MSA9lmXVTwGXMmyYGve0qwg1vS92hBaUjeTKHhX5YrFhnH
   MP22vFiH2NxpW1ixIghITyl92lr/LbXR1KE1zAkNiGZbuTDUtoUWH/8Js
   DjAMs03c98fp1fa71tXVfk+qICL/sYGEvEo5nFxY69NaRJSG09wH6d+jN
   nakcdR1xDx22j4mvUYuERYJuujuWNtQWI2rQ29pRd2yVc9JKm29iN6maf
   kiNs402b/FnhHx249d3Vdf5P1bwgP3JjsjDnk7YR9pXBOo3b6NRgl5/9d
   R/sVqyUpojqCyuQHwzuF4i7PpzhcIwJe1mrkXVFtQi9PdqnOa5GQ0LTVH
   w==;
X-CSE-ConnectionGUID: AcW4+f5TTH2EcMNMVKa3FQ==
X-CSE-MsgGUID: h+mYulGVQMCYjFThA9197g==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="81730925"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="81730925"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:12:55 -0700
X-CSE-ConnectionGUID: 1VnXeolfTm6K3q91Rpumhw==
X-CSE-MsgGUID: kCkcM2U8TsKJAlGuY5hf7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="217136077"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.52]) ([10.125.110.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:12:53 -0700
Message-ID: <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
Date: Fri, 31 Oct 2025 11:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
To: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>,
 Xin Li <xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-efi@vger.kernel.org
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 11:03, Sohil Mehta wrote:
>> Deferring is a good idea. I was just asking for the same thing for the
>> CR pinning enforcement. The earlier we try to do these things, the more
>> we just trip over ourselves.
> I had suggested deferring as well to Kirill when I was reviewing the
> series. He preferred to enable LASS with other similar features such as
> SMAP, SMEP.
> 
> One other thing to consider:
> 
> Doing it in identify_cpu() makes it easy for all the APs to program
> their CR4.LASS bit. If we were to defer it, we would need some
> additional work to setup all the APs.

That's true. We'd need an smp_call_function() of some kind. *But*, once
that is in place, it's hopefully just a matter of moving that one line
of code per feature from identify_cpu() over to the new function.

> Do we already do this for something else? That would make it easier to
> tag along.

We don't do it for anything else that I can think of.

But there's a pretty broad set of things that are for "security" that
aren't necessary while you're just running trusted ring0 code:

 * SMAP/SMEP
 * CR pinning itself
 * MSR_IA32_SPEC_CTRL
 * MSR_IA32_TSX_CTRL

They just haven't mattered until now because they don't have any
practical effect until you actually have code running on _PAGE_USER
mappings trying to attack the kernel.

