Return-Path: <linux-efi+bounces-5800-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34627CA519C
	for <lists+linux-efi@lfdr.de>; Thu, 04 Dec 2025 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4495D30A9716
	for <lists+linux-efi@lfdr.de>; Thu,  4 Dec 2025 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BE234AAF0;
	Thu,  4 Dec 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GEdNt1/S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC462E8881;
	Thu,  4 Dec 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875783; cv=none; b=qWpigT9WUyIDJgLtCrgRDnwATtV4Gb1d5F7rYQQyI867BuJi97OviYhclzOGolEHCfaTQYzpk3MlK1nfd10u0kq3n9AvLVCzqb+Q952bQ7lSgXFwm+BM1v5K3ryAbjCPIRRo17xeuYpO3lH3yKsrKBI5Uoyi3NkUWGnMoLHuOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875783; c=relaxed/simple;
	bh=mMtx+dUFEJ1B9KcG/f/azRmejDXYggiC4qrLp/UTPnY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FmcqnaJMMmThF9ixPMZhyo1mhDBcdWJXW1iboAs2HY5eNijjXwn+iGl+2selvARVkon7d9AXDXgSiGJwo8jU6cdmZB/3r1zEq+OoqeFmk4ftWoFMNMoEBhEnGBMbqNDXs01+2g72IjylOZufWzyhDexqqqooGcIr/GoYGPCHpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GEdNt1/S; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5B4JFUrt4109248
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Dec 2025 11:15:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5B4JFUrt4109248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025112201; t=1764875731;
	bh=jxyKhvYqWvUlyVWcr/S98veNQdNKxj8wfORSgOpCulw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GEdNt1/S+y19snaT3iuDPNeYdaNTgm6ey1WcF3O7ohToFSrxESY4K6JfL1fNmtCmT
	 h7D3LRHwzvEfwkbEsF1TZMildq9rVMJiyXHaLMe7zsB7ATG8sDBM9mrFqX3TMX6rzh
	 u4sPKEi5J7zGqvgvztonVyBOnpX+o72wNP7TdUoLb4kyMkw8nb7KAsAKYYJKiJSCgu
	 UuigY7AJ05pI5APouPMRmG+jdK/4o6up9ZCsnCo4KOwgEb5/A+I4x6UzwFccvzKN8E
	 lE8uAcBN0wjCwxuDIRMh6JI5lbRY7cc5gGwAJmL0FTx1Hats2MlYU91p7MaCVM7anT
	 mfUkTj752WlhQ==
Date: Thu, 04 Dec 2025 11:15:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Sohil Mehta <sohil.mehta@intel.com>
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
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
In-Reply-To: <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
References: <20251204072143.3636863-1-sohil.mehta@intel.com> <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com> <5fb937b4-5459-4894-a107-945bfb50a701@intel.com> <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
Message-ID: <B0E164E9-9037-4DD3-BFF6-E628B23349FF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 4, 2025 11:03:52 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wro=
te:
>On Thu, 4 Dec 2025 at 18:34, Sohil Mehta <sohil=2Emehta@intel=2Ecom> wrot=
e:
>>
>> On 12/4/2025 4:47 AM, Ard Biesheuvel wrote:
>> > Hello Sohil,
>> >
>>
>> Hello Ard - Thank you for looking at the patches=2E
>>
>>
>> >>
>> >>   2) Boot services code and data are referenced long after
>> >>   ExitBootServices()=2E For example, efi_check_for_embedded_firmware=
s()
>> >>   accesses boot services memory even after SetVirtualAddressMap()=2E
>> >>
>> >
>> > These accesses use the kernel direct map, so I don't think they come
>> > into play here=2E
>> >
>>
>> I don't mean SVAM should have switched these addresses to virtual ones
>> but doesn't all of EFI_BOOT_SERVICES_{CODE|DATA} have address[63] =3D 0=
?
>>
>
>Whether a mapping has bit 63 set or cleared depends on the location of
>the mapping in the virtual address space, not on the location of the
>physical backing of that mapping=2E
>
>efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA regions
>in the kernel region, so bit 63 will be set=2E
>
>> LASS wouldn't care whether there is an actual mapping behind the
>> address=2E It only relies on the MSB for enforcement=2E So, any code th=
at
>> relied on accessing boot services memory before efi_free_boot_services(=
)
>> could get affected by LASS=2E
>>
>
>This only applies to code that accesses boot services memory via a
>mapping in the lower range=2E
>
>> >>   3) Some runtime services fail to switch to virtual mode properly a=
nd
>> >>   continue referencing physical addresses [3]=2E The kernel maintain=
s a
>> >>   1:1 mapping of all runtime services code and data regions to avoid
>> >>   breaking such firmware=2E
>> >>
>> >
>> > In [3], I mainly elaborated on why it is still necessary to call
>> > SetVirtualAddressMap(), and why it needs to be called with a mapping
>> > in the upper address range=2E
>> >
>> > For this particular call, there is no choice but to disarm LASS, give=
n
>> > that the lower mapping is still active at this point=2E
>> >
>> > However, that does not imply that we have to assume that systems that
>> > support LASS (which are fairly recent AIUI) are buggy in the same way=
,
>> > i=2Ee=2E, that they access addresses in the 1:1 region after
>> > SetVirtualAddressMap() completes=2E
>>
>> I assumed that it must be widespread because the kernel maintains the
>> 1:1 mapping unconditionally without any Family-model checks=2E The code
>> isn't explicitly warning about such implementations, either=2E
>>
>
>Exactly, and this is an oversight that occured 10+ years ago=2E No
>reason to keep carrying that forward forever=2E
>
>> >
>> > In fact, we might attempt to use the availability of LASS as a
>> > preliminary cutoff point for disabling this hack entirely, and only
>> > backpedal if we get actual reports where this is still a problem=2E
>>
>> Sure, I am onboard with this approach, but some folks seemed skeptical
>> about it during the base LASS series review=2E My only concern is break=
ing
>> user systems when they update to a LASS-enabled kernel=2E
>>
>> x86 maintainers, any preference?
>>
>> Would it be useful to put this (patch 2) behind an "efi=3Ddisable_lass"
>> command line option? That way, if someone runs into it, there is at
>> least a fallback option they can rely on=2E By default, we would still
>> expect newer firmware to not need this hack=2E
>>
>
>efi=3Dnoruntime is already available, which may be sufficient to work
>around this in individual cases, to regain access to a non-booting
>system=2E

You are missing something *really* important:

What do you expect to gain?=20

There is basically no downside to the current workaround, which is why it =
is unconditional=2E

All it takes is the BIOS developer missing to register *one* pointer and t=
his problem is back=2E=20

The *real* bug is the BIOSes that not only require the use of SetVirtualMa=
p() in the first place, but require a non-1:1 mapping in the upper half=2E =
For Linux it would be far better to *only* have the restricted 1:1 mapping =
in the lower address space, as it wouldn't molest the kernel address layout=
 which affects, especially, kexec=2E

It is high risk and low =E2=80=93 possibly even negative =E2=80=93 payoff =
to "fix" it=2E



