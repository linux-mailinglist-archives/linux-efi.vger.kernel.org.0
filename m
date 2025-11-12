Return-Path: <linux-efi+bounces-5483-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E7C53515
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2278565C70
	for <lists+linux-efi@lfdr.de>; Wed, 12 Nov 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F733E349;
	Wed, 12 Nov 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Co/1ww/T"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D53375A4;
	Wed, 12 Nov 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959516; cv=none; b=EtJh6zzPILjv3FpOIa7SYcs9eCQ6GccSj27kyeOJcIzpKzqEicGn/ghzJu/qxyt0+Uj3nHfhi9g91CmtbeXW4WWJybCP4qvm5zO7nmr3KxWcwUoy0FI6pF0SdSvxNgfzAuZW9YSAqAIbMpOuL/43Hgyn20WowN9iNDr6hcnTlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959516; c=relaxed/simple;
	bh=iaqn6o1aj5TZseje8nhSMU7wox1uBx34PG/FfEn4ATc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hK8oKM0AkeBM4DHm4+PUSRdhEVYCK2tIy3re64Svn0zUNogN8Po8a96jk1CQ6GPqOWrDO+27ITYaEps2lBf4iSeSoH0/rliCrTRsUKO3D3Yup7aIGvQBSW8htc2F+1vue6SyPBp4ATW7dgI31j3W4HAC9KhfSckoaB8VxQHbhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Co/1ww/T; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACEvgP1819880
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 06:57:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACEvgP1819880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762959464;
	bh=iaqn6o1aj5TZseje8nhSMU7wox1uBx34PG/FfEn4ATc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Co/1ww/TpkmHgs8/lIQoL2DgJe7NYavKgjqIdkRsL3U5QOfDZIGT8C1ThipluORfH
	 Ggbnw9LZf5lqF0FCzU8b3vKz1aFJf3tQSkPet9rnWpsBIF22Yy97I1FoL/kNWt8qCN
	 cNDRk/2imanrbXUGZSGDXMiokFCve+KMIuV7ijry6Ms84Dl+is7nqCWtw22eZE3299
	 GW27okgXrG9ZTWFCZl07qg2H/AVfmNNnSrxLJsubzr7R5yjPy0lstKVVGnfFexNPFM
	 Snl9K+VKyqvFFKgZI4NZXEw0akGY+bPIHIAqvTmrMDGe+mC1MRbJbuG00QlD2pC83o
	 ESIYQptY33FSg==
Date: Wed, 12 Nov 2025 06:57:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
CC: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-5-sohil.mehta@intel.com> <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com> <CAMj1kXHvfgMqFncvP5A6ed=2qEPkNkS8ecoM6iXMect51Tpz4w@mail.gmail.com> <7c26ae81-3495-457b-9f64-f5b2e169a63b@intel.com>
Message-ID: <DDEF6164-D1E6-4003-A251-804738CB59E0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 6:51:45 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 11/12/25 05:56, Ard Biesheuvel wrote:
>=2E=2E=2E
>>> it looks like we would now need to toggle
>>> CR4=2ELASS every time we switch to efi_mm=2E The lass_enable()/_disabl=
e()
>>> naming would be more suitable for those wrappers=2E
>>>
>> Note that Linux/x86 uses SetVirtualAddressMap() to remap all EFI
>> runtime regions into the upper [kernel] half of the address space=2E
>>=20
>> SetVirtualAddressMap() itself is a terrible idea, but given that we
>> are already stuck with it, we should be able to rely on ordinary EFI
>> runtime calls to only execute from the upper address range=2E The only
>> exception is the call to SetVirtualAddressMap() itself, which occurs
>> only once during early boot=2E
>
>Gah, I had it in my head that we needed to use the lower mapping at
>runtime=2E The efi_mm gets used for that SetVirtualAddressMap() and the
>efi_mm continues to get used at runtime=2E So I think I just assumed that
>the lower mappings needed to get used too=2E
>
>Thanks for the education!
>
>Let's say we simply delayed CR4=2ELASS=3D1 until later in boot=2E Could w=
e
>completely ignore LASS during EFI calls, since the calls only use the
>upper address range?
>
>Also, in practice, are there buggy EFI implementations that use the
>lower address range even though they're not supposed to? *If* we just
>keep LASS on for these calls is there a chance it will cause a
>regression in some buggy EFI implementations?

Yes, they are=2E And there are buggy ones which die if set up with virtual=
 addresses in the low half=2E

