Return-Path: <linux-efi+bounces-5262-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C82C21538
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353AB1899D54
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E12EDD50;
	Thu, 30 Oct 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0l/4Twk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5591D618C;
	Thu, 30 Oct 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843244; cv=none; b=LAIUUL09shfQgxYSwk7K9cCycyish37i0MxFdG7zsBLd1k32ABZuqVgHHERY9y7Dkytq9D+adBFZq7W3hdX1f60nCN8gVxzd9C4UdAA4BMFeq376+1vPdIEkmukTPi/pNPDfCTIQmps1NmWWZPnC9uTfxYaa5LwuG0wrg1cHUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843244; c=relaxed/simple;
	bh=nhQWtm1oUaMK7I82idlzIVZuW8HPtEQdMdDI/3KSAK8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z/GvS+36h1etVMEuK4m4tnX2ad9ePmqvoTBnf2IMemAQSoMAN55kjPHhO1WZ+Y0BVIuY/WHo4aomzj7p5lzhqqer4hDc8z/Zwb86ftjjssY6RrUio8tgmNRXsJbB4TyHmvjE0VJTfUwwZS5c5gsJljA33qQuh19aT810e2zak0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0l/4Twk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75933C4CEF8;
	Thu, 30 Oct 2025 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761843244;
	bh=nhQWtm1oUaMK7I82idlzIVZuW8HPtEQdMdDI/3KSAK8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I0l/4Twko5Sn4/u3mTViJ7/iR5bpZay1IHkqMwY7uz34hHWA2vXSvevDOjPjq48zz
	 xm0nVMERM7Kiwi6Zr7vMO72bFGJKWZ3OyZEQnG4vmgdDv646g/wQGkPfd4rOejtyUb
	 V7g4Ek9BRW+Cd/Lj5894g8Z1GSSb6lTsv3C79bxzwZrVD2181oJjheZBu+IGYQbkKc
	 jddsLGoqlaIWLqFDFu3ks2WiEO/LV932oR6jPfm65Tn0fUPLdCZYU4cqTEdoNQLgwZ
	 /jROoG1iH36As58X6Mel4VgEGJ7H9DZ8KxIv4FJ7KatzMHE2h/Cb7te87WauiF3Rrx
	 no0WyV29QjImw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 74BE4F4006A;
	Thu, 30 Oct 2025 12:54:02 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 12:54:02 -0400
X-ME-Sender: <xms:KpgDabihH0z186GuRo5ElIwGqsL1AkENgyGBc45lWedVSbmQV9cEDQ>
    <xme:KpgDaS3_8VUEy6vzItNtpTGgYQqiKiRjVXAcHPpKW-4Z7gq0CKrLE33bZIi42E3mK
    PDTxqpOO-xMirXMb123NOo1Eq3VcAa1PAUhFawfluIsE2D1fSX1I50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhephffgieeuueevvddvffehiedtteduveejtefhuedtteehfffgieehhfeg
    ffehvddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoh
    eppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhushdpnhgspghrtghpthht
    ohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrd
    guvgdprhgtphhtthhopegufihmfiesrghmrgiiohhnrdgtohdruhhkpdhrtghpthhtohep
    rghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopehsvg
    grnhhjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtgho
    mhdprhgtphhtthhopehsohhhihhlrdhmvghhthgrsehinhhtvghlrdgtohhmpdhrtghpth
    htohepthhonhihrdhluhgtkhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:KpgDabzAziOmhgRrFLgWkaXa5RPVXdbZYbqVhZR7t2qXePjlguFMsg>
    <xmx:KpgDabqQxR_pHoj11bszIoQ-WFG-hkBTr6YSZ9l1lUAy0f-Cda-QiA>
    <xmx:KpgDaXgTYunVTmHerTP5zONR0NwWyB67HCRp64ldaQm-jBgGDwmCMw>
    <xmx:KpgDadVLPnDRTp0FaUOflwcgpzri0RLfHmAhZaHfJGiyaKvkp1trrQ>
    <xmx:KpgDafEQ1aro8EzL-qYNN7N4GXvQpUYyl6R-V2tHwmgTwRRGePglIHsP>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 39A9E700063; Thu, 30 Oct 2025 12:54:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvVN0AAjWd7
Date: Thu, 30 Oct 2025 09:53:41 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Sohil Mehta" <sohil.mehta@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>,
 "Xin Li" <xin@zytor.com>, "David Woodhouse" <dwmw@amazon.co.uk>,
 "Sean Christopherson" <seanjc@google.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Kees Cook" <kees@kernel.org>,
 "Tony Luck" <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 linux-doc@vger.kernel.org,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-efi@vger.kernel.org
Message-Id: <ed1a6e12-68cb-4103-946a-761260d18eab@app.fastmail.com>
In-Reply-To: <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
 <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU initialization
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Oct 30, 2025, at 9:44 AM, Sohil Mehta wrote:
> On 10/30/2025 8:45 AM, Andy Lutomirski wrote:
>> On Thu, Oct 30, 2025, at 1:40 AM, H. Peter Anvin wrote:
>>> Legacy vsyscalls have been obsolete for how long now?
>>=20
>> A looooong time.
>>=20
>> I would suggest defaulting LASS to on and *maybe* decoding just enoug=
h to log, once per boot, that a legacy vsyscall may have been attempted.=
 It=E2=80=99s too bad that #GP doesn=E2=80=99t report the faulting addre=
ss.
>>=20
>
> Unfortunately, CONFIG_X86_VSYSCALL_EMULATION defaults to y. Also, the
> default Vsyscall mode is XONLY. So even if vsyscalls are deprecated,
> there is a non-zero possibility someone would complain about it.
>
> My primary goal here is to get the base LASS series merged (soonish)
> with the simplest possible option.
>
> I am planning to follow-up immediately with a vsyscall specific series
> that relaxes *most* restrictions.
>
> IIUC, supporting XONLY mode with LASS probably does not need complicat=
ed
> decoding because the vsyscall address is available in the faulting RIP.
>
> The spec says:
> "LASS for instruction fetches applies when the linear address in RIP is
> used to load an instruction from memory. Unlike canonicality checking
> (see Section 4.5.2), LASS does not apply to branch instructions that
> load RIP. A branch instruction can load RIP with an address that would
> violate LASS. Only when the address is used to fetch an instruction wi=
ll
> a LASS violation occur, generating a #GP. (The return instruction
> pointer of the #GP handler is the address that incurred the LASS
> violation.)"
>
> I attempted to do that in the last revision here:
> https://lore.kernel.org/lkml/20251007065119.148605-9-sohil.mehta@intel=
.com/
> https://lore.kernel.org/lkml/20251007065119.148605-11-sohil.mehta@inte=
l.com/
>
> On the other hand, supporting EMULATE mode during a #GP is a bit trick=
y,
> which isn't worth the effort.

I would say it's definitely worth the effort, but it probably does make =
sense to get the rest of the series in a mergeable condition such that i=
t only works with vsyscall=3Dnone.

