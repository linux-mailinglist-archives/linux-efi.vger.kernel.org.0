Return-Path: <linux-efi+bounces-5802-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE6CA52EE
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F7C4306AE09
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEA33C18F;
	Thu,  4 Dec 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FsXidZ+U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF433290D;
	Thu,  4 Dec 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877900; cv=none; b=DX4iq/nku4E1uq5IGOnMEd1v56hLXGNvthEz6pO8uz6/ylzbm9w1YS+jFOhjqZoet/gJOTCf9V0ED2QprUkMdQIKKjj7qHMq6i0GHQBqgSTJXi2yyK0tudZrt4eJhibpNUURDFYhyRM2tsqWkw5I+2PVLc7W5s394shYwpOwcpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877900; c=relaxed/simple;
	bh=1WNJNuNq0y+AQHqw3/yncUIFr+SRoSK7/2JK6D+Eg/o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aJxGk9GHTMSv6ez2tEgCjn2YQT9+CJsCQUPanE/zYWg/hPmFlv7Oi7K2mS4awu3F/6u0TSaF1hs/9Xk3ZZK711WwdHTmS5DQfjqWiAGSf41wBAkl1xlGp4mnowJYIqCiVsB+DZoCtijo8hLhUDVJJblhxnYZQn0Zi2Qu/SY3xWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FsXidZ+U; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5B4Jp5bv4123838
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Dec 2025 11:51:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5B4Jp5bv4123838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1764877867;
	bh=Bq2t7O/Bm5fgvYG4lj4q01wDQhA/QT8Q9S0CXB9/QO8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FsXidZ+UkIH27BySpR/L1SXD6mhyK7SONdgl9vwkQLZnTSv88Of2Utt0ueITNFQax
	 H0Skq4EjO73Xep0xWfiPjfAxXfyrPMbNEgt+xwTD6nuQEXZDjF/mODGtxbrfiU8IjO
	 JD0leaf6l95I5yiE8gLnGpvNLXQQ1Tltr/crdjXOtURj1YdLQ1TByxJ0f7X5RKYe59
	 aOxGIoVnSBLJICib+iBClkXsRQkbgbSmIJuFgs9zugRFSheuTk+x1jcxhfpXAu4jQg
	 sPz3bvob8yilUI+NvPfSDUYD6nBpta+HNQpjh9bHYelceVKDV1MAuS+mzvrHJ/g5OZ
	 luHUXlJ55N4GA==
Date: Thu, 04 Dec 2025 11:51:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kiryl Shutsemau <kas@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
References: <20251204072143.3636863-1-sohil.mehta@intel.com> <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com> <5fb937b4-5459-4894-a107-945bfb50a701@intel.com> <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com> <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com> <CAMj1kXHYKX4nU_xULC9vBDQxdyq9n_gcDqUTL2QZXvZhkHZRAg@mail.gmail.com>
Message-ID: <F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 4, 2025 11:40:03 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wro=
te:
>On Thu, 4 Dec 2025 at 20:16, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On December 4, 2025 11:03:52 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg>=
 wrote:
>> >On Thu, 4 Dec 2025 at 18:34, Sohil Mehta <sohil=2Emehta@intel=2Ecom> w=
rote:
>> >>
>> >> On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
>> >> > Hello Sohil,
>> >> >
>> >>
>> >> Hello Ard - Thank you for looking at the patches=2E
>> >>
>> >>
>> >> >>
>> >> >>   2) Boot services code and data are referenced long after
>> >> >>   ExitBootServices()=2E For example, efi_check_for_embedded_firmw=
ares()
>> >> >>   accesses boot services memory even after SetVirtualAddressMap()=
=2E
>> >> >>
>> >> >
>> >> > These accesses use the kernel direct map, so I don't think they co=
me
>> >> > into play here=2E
>> >> >
>> >>
>> >> I don't mean SVAM should have switched these addresses to virtual on=
es
>> >> but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] =
=3D 0?
>> >>
>> >
>> >Whether a mapping has bit 63 set or cleared depends on the location of
>> >the mapping in the virtual address space, not on the location of the
>> >physical backing of that mapping=2E
>> >
>> >efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA regions
>> >in the kernel region, so bit 63 will be set=2E
>> >
>> >> LASS wouldn't care whether there is an actual mapping behind the
>> >> address=2E It only relies on the MSB for enforcement=2E So, any code=
 that
>> >> relied on accessing boot services memory before efi_free_boot_servic=
es()
>> >> could get affected by LASS=2E
>> >>
>> >
>> >This only applies to code that accesses boot services memory via a
>> >mapping in the lower range=2E
>> >
>> >> >>   3) Some runtime services fail to switch to virtual mode properl=
y and
>> >> >>   continue referencing physical addresses [3]=2E The kernel maint=
ains a
>> >> >>   1:1 mapping of all runtime services code and data regions to av=
oid
>> >> >>   breaking such firmware=2E
>> >> >>
>> >> >
>> >> > In [3], I mainly elaborated on why it is still necessary to call
>> >> > SetVirtualAddressMap(), and why it needs to be called with a mappi=
ng
>> >> > in the upper address range=2E
>> >> >
>> >> > For this particular call, there is no choice but to disarm LASS, g=
iven
>> >> > that the lower mapping is still active at this point=2E
>> >> >
>> >> > However, that does not imply that we have to assume that systems t=
hat
>> >> > support LASS (which are fairly recent AIUI) are buggy in the same =
way,
>> >> > i=2Ee=2E, that they access addresses in the 1:1 region after
>> >> > SetVirtualAddressMap() completes=2E
>> >>
>> >> I assumed that it must be widespread because the kernel maintains th=
e
>> >> 1:1 mapping unconditionally without any Family-model checks=2E The c=
ode
>> >> isn't explicitly warning about such implementations, either=2E
>> >>
>> >
>> >Exactly, and this is an oversight that occured 10+ years ago=2E No
>> >reason to keep carrying that forward forever=2E
>> >
>> >> >
>> >> > In fact, we might attempt to use the availability of LASS as a
>> >> > preliminary cutoff point for disabling this hack entirely, and onl=
y
>> >> > backpedal if we get actual reports where this is still a problem=
=2E
>> >>
>> >> Sure, I am onboard with this approach, but some folks seemed skeptic=
al
>> >> about it during the base LASS series review=2E My only concern is br=
eaking
>> >> user systems when they update to a LASS-enabled kernel=2E
>> >>
>> >> x86 maintainers, any preference?
>> >>
>> >> Would it be useful to put this (patch 2) behind an "efi=3Ddisable_la=
ss"
>> >> command line option? That way, if someone runs into it, there is at
>> >> least a fallback option they can rely on=2E By default, we would sti=
ll
>> >> expect newer firmware to not need this hack=2E
>> >>
>> >
>> >efi=3Dnoruntime is already available, which may be sufficient to work
>> >around this in individual cases, to regain access to a non-booting
>> >system=2E
>>
>> You are missing something *really* important:
>>
>> What do you expect to gain?
>>
>> There is basically no downside to the current workaround, which is why =
it is unconditional=2E
>>
>
>The downside is that it requires LASS to be disabled - that is the
>point of this discussion=2E
>
>I think proactively carrying over this workaround to LASS systems
>without any idea whether or not it is even needed is not the right way
>to go about this=2E
>
>> All it takes is the BIOS developer missing to register *one* pointer an=
d this problem is back=2E
>>
>> The *real* bug is the BIOSes that not only require the use of SetVirtua=
lMap() in the first place, but require a non-1:1 mapping in the upper half=
=2E For Linux it would be far better to *only* have the restricted 1:1 mapp=
ing in the lower address space, as it wouldn't molest the kernel address la=
yout which affects, especially, kexec=2E
>>
>
>Agreed=2E On arm64, we stopped calling SetVirtualAddressMap() years ago,
>and just use the 1:1 mapping at runtime=2E
>
>This is not feasible on x86, of course, due to the many buggy
>implementations=2E But it would also mean no LASS for EFI calls, right?
>

But your underlying assumption is that disabling LASS around EFI calls is =
a problem=2E It isn't, because the efi_mm has explicitly unmapped any memor=
y EFI isn't allowed to touch=2E In other words, we are already doing the eq=
uivalent of LASS "manually=2E"

I don't see any value at all in keeping LASS on *when efi_mm is active=2E*=
 By which I mean that LASS needs to be on until after efi_mm is active, and=
 be active before switching to another mm=2E

