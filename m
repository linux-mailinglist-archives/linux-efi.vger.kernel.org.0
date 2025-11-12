Return-Path: <linux-efi+bounces-5485-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CDC53120
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0877351640
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C6338F5B;
	Wed, 12 Nov 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mbDelKTp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33825F975;
	Wed, 12 Nov 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961034; cv=none; b=juR1uOj2dlhO3k3JiVPvqoJoSrL8It/U5eo2FAHHEgVJsxjAEOwqOsqzreKlYR73wuFw5UdN83EqcdhbxJc1H2HPosmrG9OD/QfL6zbycKcCUF8NhgQkwXZ9wilmJ3Y73n/3B21DkcpMDaZh+L52zEZ0FgrHkkxAtDYWRxRBeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961034; c=relaxed/simple;
	bh=qe6wQjSBZGEWx1gys61HAiAAEe3IYJWXu8xOJPtYeh4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=A+P7ajrDtgx6rwPNDzKUTfSs6a8G+fEtH7IR7OeDJJZvnIP2rM1Pj/mGa1KPV1QmtY194puIq/cV06mBKzGebIO2r42qU6t37iCEFkK0DuI2xi5h5PkT+DVu9qJ3iJ+N2jdK9qGP1fTHWG9I/ZC4kcOpgZpD/65knOxONKueyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mbDelKTp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACFN4B7832891
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 07:23:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACFN4B7832891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762960986;
	bh=qe6wQjSBZGEWx1gys61HAiAAEe3IYJWXu8xOJPtYeh4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mbDelKTpD2NFpNHUct6Wt3eJUGlPMtesJ7oawEOSkwcg3iuMn+w8avyJIuJcNafJk
	 Z511QVJQQnwtwUOwxtunVXV9B2c32eKyItXxJuVp7Z4NRJZenDlgYgGAMLuxpjQoHW
	 Bjh72VbT0dJZDkkmnO8oEie4QDmPVn58Q+YwNhcTdgorSFKngWo/NgxVVk/57NWaiP
	 b5exTziC1XrEsp6z5sm1kgUheOeg62FH7+CAtghu4/P6p7GlF07DjOnDOJ385rWU7F
	 NSyL5duvHVq2fk+0J2Y+qJuOS3WjGRSK59B6YHNyYQZavwZSD8QkIkJv5CruWexSGf
	 bpO79YRYoLIeg==
Date: Wed, 12 Nov 2025 07:23:02 -0800
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
In-Reply-To: <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com> <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com> <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com> <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com> <CAMj1kXGyTo=4Va1PevMQyCauEKSutfSPo6je0Ps09TabhTe4zQ@mail.gmail.com>
Message-ID: <E9396874-5D2D-413D-A5D1-A28E4D429C51@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 7:18:33 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wro=
te:
>On Wed, 12 Nov 2025 at 15:58, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On November 12, 2025 6:51:45 AM PST, Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>> >On 11/12/25 05:56, Ard Biesheuvel wrote:
>> >=2E=2E=2E
>> >>> it looks like we would now need to toggle
>> >>> CR4=2ELASS every time we switch to efi_mm=2E The lass_enable()/_dis=
able()
>> >>> naming would be more suitable for those wrappers=2E
>> >>>
>> >> Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
>> >> runtime regions into the upper [kernel] half of the address space=2E
>> >>
>> >> SetVirtualAddressMap() itself is a terrible idea, but given that we
>> >> are already stuck with it, we should be able to rely on ordinary EFI
>> >> runtime calls to only execute from the upper address range=2E The on=
ly
>> >> exception is the call to SetVirtualAddressMap() itself, which occurs
>> >> only once during early boot=2E
>> >
>> >Gah, I had it in my head that we needed to use the lower mapping at
>> >runtime=2E The efi_mm gets used for that SetVirtualAddressMap() and th=
e
>> >efi_mm continues to get used at runtime=2E So I think I just assumed t=
hat
>> >the lower mappings needed to get used too=2E
>> >
>> >Thanks for the education!
>> >
>> >Let's say we simply delayed CR4=2ELASS=3D1 until later in boot=2E Coul=
d we
>> >completely ignore LASS during EFI calls, since the calls only use the
>> >upper address range?
>> >
>> >Also, in practice, are there buggy EFI implementations that use the
>> >lower address range even though they're not supposed to? *If* we just
>> >keep LASS on for these calls is there a chance it will cause a
>> >regression in some buggy EFI implementations?
>>
>> Yes, they are=2E And there are buggy ones which die if set up with virt=
ual addresses in the low half=2E
>
>To elaborate on that, there are systems where
>
>a) not calling SetVirtualAddressMap() crashes the firmware, because,
>in spite of being clearly documented as optional, not calling it
>results in some event hook not being called, causing the firmware to
>misbehave
>
>b) calling SetVirtualAddressMap() with an 1:1 mapping crashes the
>firmware (and so this is not a possible workaround for a))
>
>c) calling SetVirtualAddressMap() crashes the firmware when not both
>the old 1:1 and the new kernel mapping are already live (which
>violates the UEFI spec)
>
>d) calling SetVirtualAddressMap() does not result in all 1:1
>references being converted to the new mapping=2E
>
>
>To address d), the x86_64 implementation of efi_map_region() indeed
>maps an 1:1 alias of each remapped runtime regions, so that stray
>accesses don't fault=2E But the code addresses are all remapped, and so
>the firmware routines are always invoked via their remapped aliases in
>the kernel VA space=2E Not calling SetVirtualAddressMap() at all, or
>calling it with a 1:1 mapping is not feasible, essentially because
>Windows doesn't do that, and that is the only thing that is tested on
>all x86 PCs by the respective OEMs=2E
>
>Given that remapping the code is dealt with by the firmware's PE/COFF
>loader, whereas remapping [dynamically allocated] data requires effort
>on the part of the programmer, I'd hazard a guess that 99=2E9% of those
>bugs do not involve attempts to execute via the lower mapping, but
>stray references to data objects that were not remapped properly=2E
>
>So we might consider
>a) remapping those 1:1 aliases NX, so we don't have those patches of
>RWX memory around
>b) keeping LASS enabled during ordinary EFI runtime calls, as you suggest=
=2E

Unless someone has a code pointer in their code=2E

