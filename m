Return-Path: <linux-efi+bounces-5378-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4B3C3EDF1
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC763A7AA6
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A930F938;
	Fri,  7 Nov 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SKPYMPnN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F030EF63;
	Fri,  7 Nov 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502709; cv=none; b=E3PybkqgGdjui//E5P88WpApfoXXwT577soXMEuE3yO87Jf3SqjfUD5xlXOVxucPVxHtlQPTBqkB2lwR7/misfvhV/ftYoFwfNVN5hKyTVtx9PEsF86g32nlDgsauACDukKQWLhHaBvN+5s96y6+fwONCYJ6cJQFJb2wK1apbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502709; c=relaxed/simple;
	bh=przJ7zVMB3r5mMPHaYCcx2207IRB2F5XNQuAewa3PMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyfJAduDtO++Vaqct0LI9snlD9oxr21zh9JApTKAJQrqwkBTQjSl271ONHEyx60P3eFR5Xb3GBE4v9748l2kzQr+4niD8179Snt7n0tIJLIW8lL4hlNt//9MH6z0H8wedU/BWkj7ildRAhx27bNYG2Ptx4ZdSBAScxu0I75yfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SKPYMPnN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A781SNm1539466
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Nov 2025 00:01:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A781SNm1539466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762502491;
	bh=RvdlJ/9DuH9+09DL76xBKmhvDyDdYgFyini9IoyNZd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SKPYMPnNYOwSQ1zwk+IDS2vlz+fF3SGn5VdvJQX4zK+liJvTb/iSfukgv1mbgrHS8
	 wXg4egBlHORzF8Xa9JKaZHZF9GM1b1qN44qovNbSl5Kc1MOapaYOO0eEG+1ZbmEynD
	 NeU6Coq3nJ3g5TthmBFPtUOoIuaZ/Hu5B5vVTwr8J/gBBDW/SIuw/3p+J14TvP08cf
	 vCEXMcQkFQl1+y15isd6KfKasssgSz+bHJNkx9sKmzC2xcAoDKtzHYbFGMT1Uf7RCy
	 gzzHwhyrTiSFHfKMX4hMuXBgwwYPFcGJEpN7bzKV+Jl5dfCsS9OqXsVJjniarBYZ1h
	 0vsDlQbdXnOnw==
Message-ID: <255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zytor.com>
Date: Fri, 7 Nov 2025 00:01:28 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
To: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sean Christopherson <seanjc@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <d20a5e9d-dc0b-4bd2-89bb-95dbded8a581@intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d20a5e9d-dc0b-4bd2-89bb-95dbded8a581@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-30 09:27, Dave Hansen wrote:
> On 10/30/25 01:40, H. Peter Anvin wrote:
>> Legacy vsyscalls have been obsolete for how long now?
> 
> I asked Sohil to start throwing out all the non-essential bits from this
> series. My thought was that we could get mainline so that LASS itself
> could be enabled, even if it was in a somewhat weird config that a
> distro would probably never do.
> 
> After that is merged, we can circle back and decide what to do with the
> remaining bits like CR pinning and vsyscall emulation. I don't think any
> of those bits will change the basic desire to have LASS support in the
> kernel.
> 
> Does that sound like a sane approach to everyone?

XONLY vsyscall emulation should be trivial, though (just look for the magic
RIP values, just like the page fault code does now, too.) The FULL emulation
mode is completely irrelevant these days, so I don't think it matters at all.

EFI handling is similarly straightforward: just disable CR4.LASS right before
calling EFI, and enable it on return. As long as we are *already* in the
efi_mm context, it is perfectly safe to disable CR4.LASS, because there *is no
user memory mapped at that point*.

These two things should only be a few lines of code each, and I don't see any
reason to further elaborate them at this time (to handle FULL emulation, or to
take a LASS trap inside EFI to write a shame-the-vendor message; if we wanted
to do that, it would be better to make that independent of LASS and empty out
efi_mm entirely.

Am I missing something?

	-hpa



