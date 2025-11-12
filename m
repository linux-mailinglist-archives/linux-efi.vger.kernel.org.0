Return-Path: <linux-efi+bounces-5482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEBC52F11
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13B2B3566E5
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBFE340DB7;
	Wed, 12 Nov 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOnptTC0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89408340A6F;
	Wed, 12 Nov 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959109; cv=none; b=t+WFd/XM6hIclf9xN3EcGqteRf13lTSVl+dFL3CsgMguBzGbkpGTNOjfwBZvt/HU6l7sI67sclK+KUrzAyolcEefnhpVWlBlAmMsJNNZfqrtpwExAziwvHpxxLI4tx7tQnT4SZmqAvpJmkS8FIHy37eTan0YjnzwUXRon/nbcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959109; c=relaxed/simple;
	bh=27blj8GKZo8pAndfSHRBAeeQO/EOp4oDNPqcFqlBC60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7Acp2zQYI+gNX7GxgsKenLn+PAbLYjfUZin7m+4WQXHG/IXZvw9gnpqm6zoefXVJyRKEwHLyNHrCCxmJ8JiJbcJV3C7CP7flNctQ73gLYjNOlIwhTRI9FXj0oetdxNn51mkSgaPZjLzPEYnA760LYjq5OVMfkfd8Kn/sDGerYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOnptTC0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762959108; x=1794495108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=27blj8GKZo8pAndfSHRBAeeQO/EOp4oDNPqcFqlBC60=;
  b=bOnptTC0Cwu+b3h/hU+NaHg6tBD7ahO4/k12RLg1TmSOzBmtDWzGGJzI
   sXDl0GZySTce/0f/ZQo+YYcMvVlNiAPZz3quTAmLQAZA+9ORyq9d8MnaJ
   nDBdKixhFAPwgdLusPg93ckGQD1SL5wVX417E5maxbxJk8Fc4BD5XX9rJ
   pJTw8CzELzNZuK9zJKTkMOTuoQ55A6icOKr5puU6bIHprBy/y4tvtkKgS
   y2ZTubaZTWbWf/XPVTqBcbuKvnv1xt9zEy3D3UoAr1EmMluHIGehEC72d
   9hntW3EiSHeGw5h156BuhkmumIybTI2rh6V0enem1931MMEbUOYnWRxNv
   A==;
X-CSE-ConnectionGUID: Gj1v038uRgOd1bHFSsaIHQ==
X-CSE-MsgGUID: 4oXm14PeTMuhi+Cri+QYsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76480796"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="76480796"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:51:47 -0800
X-CSE-ConnectionGUID: Noq6dh2LRumZznWAxx9tqg==
X-CSE-MsgGUID: ip8fkKCHSPOkLQqdrVLHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189218764"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.22]) ([10.125.108.22])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:51:46 -0800
Message-ID: <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com>
Date: Wed, 12 Nov 2025 06:51:45 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
To: Ard Biesheuvel <ardb@kernel.org>, Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Jonathan Corbet <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov"
 <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com>
 <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
 <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 05:56, Ard Biesheuvel wrote:
...
>> it looks like we would now need to toggle
>> CR4.LASS every time we switch to efi_mm. The lass_enable()/_disable()
>> naming would be more suitable for those wrappers.
>>
> Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
> runtime regions into the upper [kernel] half of the address space.
> 
> SetVirtualAddressMap() itself is a terrible idea, but given that we
> are already stuck with it, we should be able to rely on ordinary EFI
> runtime calls to only execute from the upper address range. The only
> exception is the call to SetVirtualAddressMap() itself, which occurs
> only once during early boot.

Gah, I had it in my head that we needed to use the lower mapping at
runtime. The efi_mm gets used for that SetVirtualAddressMap() and the
efi_mm continues to get used at runtime. So I think I just assumed that
the lower mappings needed to get used too.

Thanks for the education!

Let's say we simply delayed CR4.LASS=1 until later in boot. Could we
completely ignore LASS during EFI calls, since the calls only use the
upper address range?

Also, in practice, are there buggy EFI implementations that use the
lower address range even though they're not supposed to? *If* we just
keep LASS on for these calls is there a chance it will cause a
regression in some buggy EFI implementations?

