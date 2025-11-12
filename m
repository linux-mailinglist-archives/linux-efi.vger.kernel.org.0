Return-Path: <linux-efi+bounces-5489-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB41C5379E
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E175C352FFB
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072733BBB5;
	Wed, 12 Nov 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GQmZnHye"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CA33F8BE;
	Wed, 12 Nov 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964849; cv=none; b=PPpN3MG4jT4vtOrPdo0xfDrzBRdTa+jto0//z1FIyF28zfTgOECFCL1BRSPnWvB9c0FYrTMTBvzN2NwdfqQo+1BVXiZ7clxsieAwkz6c61OxAQpgBvBNRVlJjiSt2oJjzSOAd2ifP1k77eS0wNJa5nDKkrXX8WNh0SWwiPWmD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964849; c=relaxed/simple;
	bh=sEWKlD4QGLKI9/2pGS+1W4cf5CuddKyDSsaTt/T0WTc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=A8kO2GTRR50Ym4iVJybxy3CUe1/TrC8SIv88rmUxRqnFl4FBH6imPI6DY3cpIVVFFyUwTE5yykGjSimmDJZuQHMxIWE0081O4uCBJy6zFg+946lVIiLKUgKJ3eDZvLbGGPtb+ssVxkUFB0veRELNKaKngt5TDU0io1MrnqdASME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GQmZnHye; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACGQjmO869590
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 08:26:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACGQjmO869590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762964806;
	bh=sEWKlD4QGLKI9/2pGS+1W4cf5CuddKyDSsaTt/T0WTc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GQmZnHyeLVKbVLLyI2s/zJrtGuzsInwjfNHxW0obBlrG3czj1Shl04w/70vmvuVIB
	 6YWPf3Wa4Okm/0ImOSFXX8GNFjkFiT3GIErN2yJkgvCxZ1AXjXyfHrs0+xtlrLIizn
	 vimsoyWVhScZtrzgTIrF448m7CzKPsRrB52vROkNdQ0qDT7vbyVmR5x7XYsxjKqHb2
	 M2dMow1GYofHNFaU6Z0jaDCRtGYP5laKi9XThnuUAw5k3JGl7LDKCFec+xM7EjQCJs
	 Iquh+BfOhX/3f0G7ktFBWQ4gH0A7shhFT6Ie19w0/NAdB2ZTO2MbDDKGQMew8M8I9c
	 SfP8ppAXUKqBQ==
Date: Wed, 12 Nov 2025 08:26:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Ard Biesheuvel <ardb@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <6ab6e4d3-0caa-41e6-8231-2f3f45949876@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com> <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com> <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com> <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com> <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com> <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com> <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com> <6ab6e4d3-0caa-41e6-8231-2f3f45949876@intel.com>
Message-ID: <1EF49DBA-6C4A-41A4-9CA0-80CE389AA378@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 8:18:20 AM PST, Sohil Mehta <sohil=2Emehta@intel=2Ecom=
> wrote:
>On 11/12/2025 7:28 AM, Ard Biesheuvel wrote:
>
>>>> d) calling SetVirtualAddressMap() does not result in all 1:1
>>>> references being converted to the new mapping=2E
>>>>
>>>>
>>>> To address d), the x86_64 implementation of efi_map_region() indeed
>>>> maps an 1:1 alias of each remapped runtime regions, so that stray
>>>> accesses don't fault=2E But the code addresses are all remapped, and =
so
>>>> the firmware routines are always invoked via their remapped aliases i=
n
>>>> the kernel VA space=2E Not calling SetVirtualAddressMap() at all, or
>>>> calling it with a 1:1 mapping is not feasible, essentially because
>>>> Windows doesn't do that, and that is the only thing that is tested on
>>>> all x86 PCs by the respective OEMs=2E
>>>>
>>>> Given that remapping the code is dealt with by the firmware's PE/COFF
>>>> loader, whereas remapping [dynamically allocated] data requires effor=
t
>>>> on the part of the programmer, I'd hazard a guess that 99=2E9% of tho=
se
>>>> bugs do not involve attempts to execute via the lower mapping, but
>>>> stray references to data objects that were not remapped properly=2E
>>>>
>>>> So we might consider
>>>> a) remapping those 1:1 aliases NX, so we don't have those patches of
>>>> RWX memory around
>>>> b) keeping LASS enabled during ordinary EFI runtime calls, as you sug=
gest=2E
>>>
>>> Unless someone has a code pointer in their code=2E
>>=20
>> That is a good point, especially because the EFI universe is
>> constructed out of GUIDs and so-called protocols, which are just
>> structs with function pointers=2E
>>=20
>> However, EFI protocols are only supported at boot time, and the
>> runtime execution context is much more restricted=2E So I'd still expec=
t
>> the code pointer case to be much less likely=2E
>
>But, that still leaves the stray data accesses=2E We would still need to
>disable the LASS data access enforcement by toggling RFLAGS=2EAC during
>the runtime calls=2E
>
>Can we rely on EFI to not mess up RFLAGS and keep the AC bit intact?

No=2E

