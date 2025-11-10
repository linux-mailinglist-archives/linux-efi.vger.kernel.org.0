Return-Path: <linux-efi+bounces-5405-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B72C48FF0
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 20:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F053B4C60
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA232AABD;
	Mon, 10 Nov 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k/oIyHx5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86012223DC0;
	Mon, 10 Nov 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802051; cv=none; b=W+FoJipUCOJhj8KLix91XCs9fl95CL3cIepz03rQ0E4T+iG1KUdlF6TKLBntNrddNOEEYfhn1i4+bdp4lojUap6jXMBjfQ6vF2wtW9oMi8tSHdRZhEfsc98CKv/B97Dkq0A6D0MNOA9X1Ll4uKW+OoR942IEKKX5EWmoYwyBqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802051; c=relaxed/simple;
	bh=jzAWVx9Su8bAzd56ECW8UvAEYkBkSERr9RuxpW0KqxQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mWh6tjrpzDYctjnNmB/ZCTXLg3CUSWYcq8bL6FO//Rc9IgfHrphDFP0V8iXFaA863JXs0SOHg/qlwMta5212eukblF7+zt031kxtqj4GYcSxZVshYe2uxx4MdTUlu7hbW0yfYyGgqA2LD7eAves3ie3a5ZhiiNqZg0Nuy33HVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=k/oIyHx5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AAJ9wVb3760859
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Nov 2025 11:09:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AAJ9wVb3760859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762801800;
	bh=nnCZfxBBxg3UdNy9fEr4h1ydR7erPjaFEoY0mwQn658=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=k/oIyHx5SOgXhKqvIMO3vvqjmjL5csppL8LL82kpcvUWyfXhC8znd5pNzJxYRI89C
	 nnm+ErU5a1rp2Sze4Mg1TwoOJRruFUoZUG6wpSJLkdL8GGJsDn2dOvB7gYQOHbCGeU
	 AChmNMTP/YEpv9oRNA+4hN43VB1U+Uvdth+VyBLS85hLHt3lPG4wh+l/fZsKr+3qoL
	 BHT0V4GCgt0rddLv83ZJGRt2KR4UE1py1E+QjE6lUWcYrSOINMyEA+cBXMHhIYEh+o
	 KsktL1Hz4UyEpL5U0S3uTxXmiJvElZbJBX0rNGe3tYwqF2OevJtoeGyuiW5ATr8pk2
	 cA+fWOFafrOww==
Date: Mon, 10 Nov 2025 11:09:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_4/9=5D_x86/alternatives=3A_?=
 =?US-ASCII?Q?Disable_LASS_when_patching_kernel_code?=
User-Agent: K-9 Mail for Android
In-Reply-To: <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
Message-ID: <404E225C-B6FC-4FCF-B4D9-0D079C72E8B2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 10, 2025 10:15:23 AM PST, Sohil Mehta <sohil=2Emehta@intel=2Eco=
m> wrote:
>Hi Boris,
>
>On 10/29/2025 2:03 PM, Sohil Mehta wrote:
>> +/*
>> + * LASS enforcement is based on bit 63 of the virtual address=2E The
>> + * kernel is not allowed to touch memory in the lower half of the
>> + * virtual address space=2E
>> + *
>> + * Use lass_disable()/lass_enable() to toggle the AC bit for kernel da=
ta
>> + * accesses (!_PAGE_USER) that are blocked by LASS, but not by SMAP=2E
>> + *
>> + * Even with the AC bit set, LASS will continue to block instruction
>> + * fetches from the user half of the address space=2E To allow those,
>> + * clear CR4=2ELASS to disable the LASS mechanism entirely=2E
>> + *
>
>Based on the EFI discussion, it looks like we would now need to toggle
>CR4=2ELASS every time we switch to efi_mm=2E The lass_enable()/_disable()
>naming would be more suitable for those wrappers=2E
>
>I am thinking of reverting this back to lass_clac()/lass_stac()=2E
>
>lass_clac()/_stac():
>	Disable enforcement for kernel data accesses similar to SMAP=2E
>
>lass_enable()/_disable():
>	Disable the entire LASS mechanism (Data and instruction fetch)
>	by toggling CR4=2ELASS
>
>Would that work? Any other suggestions?
>
>
>> +
>> +static __always_inline void lass_enable(void)
>> +{
>> +	alternative("", "clac", X86_FEATURE_LASS);
>> +}
>> +
>> +static __always_inline void lass_disable(void)
>> +{
>> +	alternative("", "stac", X86_FEATURE_LASS);
>> +}
>> +

That would be my suggestion for making, too=2E

