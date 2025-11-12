Return-Path: <linux-efi+bounces-5487-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E1C533B9
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65C8535286A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBC33CEA1;
	Wed, 12 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uc2H3fsR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459D339B41;
	Wed, 12 Nov 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962494; cv=none; b=ITkeEv30nVXA1348pT3iZoo0ykFh0S7LT+ZKK2eRG45rPNsJ77WL1EedPNfdsDD27f6B8u59Ld0jL3mJzQjd3N1eI9Qmd7WvYizLMPLipVhB9y8LmYCyHBGCpxG4eQt1K/OeVdKqpGXbMl6dZ2vR8sc1nioxMFHDX+rL9usBreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962494; c=relaxed/simple;
	bh=Wy1Eaa/voOhC2M9knmleEyG2kLA8QjWdHOKRAFg737g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D3P7Hl2S06/1Z4lKk03dwE5sVpeI74L+Zt1YPm6sILHe2FWjVL6AxkkSXuZfv/t2wZKaM3GnPpNWXSZiydS7WpsDN+J91MrTJUgoPnjKa4tl4lpYwfNYxA+czMQXKwa1qkDSvk6DqSZacYxwxLoMHBF9vQPoGhIB714mWAtH/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uc2H3fsR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACFlTJI847027
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 07:47:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACFlTJI847027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762962451;
	bh=Wy1Eaa/voOhC2M9knmleEyG2kLA8QjWdHOKRAFg737g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uc2H3fsRzqGxTeUk38BlznRPgI5S6sANKhQUiBmroyJg2MGkKKiuh6k9Vo80kNZYh
	 QMDraBLfN/CIkasyf5htntP4FnHQ0n5niEWpEX0jqU6p+cfHQpWMzHyEVISyNAKDiv
	 hFb08qTaUNv8sieFQppamq4Xq5xC73OkvfJfiu8E0FRVsPaZHwZmC2flG6rE+S/Y+2
	 mZsjbUHbqefuNqkrmFFHaRQqMeBglWkB56z5GU4yYRM0nnsmWX/N8e21L/KQc8OcD7
	 ifEuSnzJ4LmHjsGetElxvtBkQyLj9O34W1XXed/C4u1pqtjf+0XKQVjNc5UhwbAAiU
	 5ob8U+bSk/7DA==
Date: Wed, 12 Nov 2025 07:47:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
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
In-Reply-To: <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com> <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com> <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com> <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com> <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com> <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com> <CAMj1kXECkKeDUDdjmrQjcYk=2Y5ydTV2L1Pg73X7uCC-=DC9Ww@mail.gmail.com>
Message-ID: <2D5B8457-7A69-4DE6-884F-61E20D1A6976@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 7:28:12 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wro=
te:
>On Wed, 12 Nov 2025 at 16:23, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On November 12, 2025 7:18:33 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg>=
 wrote:
>> >On Wed, 12 Nov 2025 at 15:58, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote=
:
>> >>
>> >> On November 12, 2025 6:51:45 AM PST, Dave Hansen <dave=2Ehansen@inte=
l=2Ecom> wrote:
>> >> >On 11/12/25 05:56, Ard Biesheuvel wrote:
>> >> >=2E=2E=2E
>> >> >>> it looks like we would now need to toggle
>> >> >>> CR4=2ELASS every time we switch to efi_mm=2E The lass_enable()/_=
disable()
>> >> >>> naming would be more suitable for those wrappers=2E
>> >> >>>
>> >> >> Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
>> >> >> runtime regions into the upper [kernel] half of the address space=
=2E
>> >> >>
>> >> >> SetVirtualAddressMap() itself is a terrible idea, but given that =
we
>> >> >> are already stuck with it, we should be able to rely on ordinary =
EFI
>> >> >> runtime calls to only execute from the upper address range=2E The=
 only
>> >> >> exception is the call to SetVirtualAddressMap() itself, which occ=
urs
>> >> >> only once during early boot=2E
>> >> >
>> >> >Gah, I had it in my head that we needed to use the lower mapping at
>> >> >runtime=2E The efi_mm gets used for that SetVirtualAddressMap() and=
 the
>> >> >efi_mm continues to get used at runtime=2E So I think I just assume=
d that
>> >> >the lower mappings needed to get used too=2E
>> >> >
>> >> >Thanks for the education!
>> >> >
>> >> >Let's say we simply delayed CR4=2ELASS=3D1 until later in boot=2E C=
ould we
>> >> >completely ignore LASS during EFI calls, since the calls only use t=
he
>> >> >upper address range?
>> >> >
>> >> >Also, in practice, are there buggy EFI implementations that use the
>> >> >lower address range even though they're not supposed to? *If* we ju=
st
>> >> >keep LASS on for these calls is there a chance it will cause a
>> >> >regression in some buggy EFI implementations?
>> >>
>> >> Yes, they are=2E And there are buggy ones which die if set up with v=
irtual addresses in the low half=2E
>> >
>> >To elaborate on that, there are systems where
>> >
>> >a) not calling SetVirtualAddressMap() crashes the firmware, because,
>> >in spite of being clearly documented as optional, not calling it
>> >results in some event hook not being called, causing the firmware to
>> >misbehave
>> >
>> >b) calling SetVirtualAddressMap() with an 1:1 mapping crashes the
>> >firmware (and so this is not a possible workaround for a))
>> >
>> >c) calling SetVirtualAddressMap() crashes the firmware when not both
>> >the old 1:1 and the new kernel mapping are already live (which
>> >violates the UEFI spec)
>> >
>> >d) calling SetVirtualAddressMap() does not result in all 1:1
>> >references being converted to the new mapping=2E
>> >
>> >
>> >To address d), the x86_64 implementation of efi_map_region() indeed
>> >maps an 1:1 alias of each remapped runtime regions, so that stray
>> >accesses don't fault=2E But the code addresses are all remapped, and s=
o
>> >the firmware routines are always invoked via their remapped aliases in
>> >the kernel VA space=2E Not calling SetVirtualAddressMap() at all, or
>> >calling it with a 1:1 mapping is not feasible, essentially because
>> >Windows doesn't do that, and that is the only thing that is tested on
>> >all x86 PCs by the respective OEMs=2E
>> >
>> >Given that remapping the code is dealt with by the firmware's PE/COFF
>> >loader, whereas remapping [dynamically allocated] data requires effort
>> >on the part of the programmer, I'd hazard a guess that 99=2E9% of thos=
e
>> >bugs do not involve attempts to execute via the lower mapping, but
>> >stray references to data objects that were not remapped properly=2E
>> >
>> >So we might consider
>> >a) remapping those 1:1 aliases NX, so we don't have those patches of
>> >RWX memory around
>> >b) keeping LASS enabled during ordinary EFI runtime calls, as you sugg=
est=2E
>>
>> Unless someone has a code pointer in their code=2E
>
>That is a good point, especially because the EFI universe is
>constructed out of GUIDs and so-called protocols, which are just
>structs with function pointers=2E
>
>However, EFI protocols are only supported at boot time, and the
>runtime execution context is much more restricted=2E So I'd still expect
>the code pointer case to be much less likely=2E

Yes, but it only takes one=2E=20

The main thing, though, is that this is being bikeshedded for no good reas=
on: there isn't much to be had from trying to narrow down from what we have=
 now, other than restricting the *upper* mapping further=2E

And this has nothing to do with LASS=2E

