Return-Path: <linux-efi+bounces-5321-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B9C26DBC
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 21:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20461891455
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF436324B14;
	Fri, 31 Oct 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyuV7hXB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA626ED3D;
	Fri, 31 Oct 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941039; cv=none; b=PSKP20cfGauRzu1g0GAcbrlC6od8zvhmCXyicdHU9wZx6UCtDWHFd59tbP9Ts3DHrO7smgksHlUO1gypk30gVaiIdg8zonLed755KifB9aDEEf2sSRAvUeQgWczHSxUMwUnhmvBJm9ZEOEOdxD8BDFuw1hEBy1739o/cGzsJHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941039; c=relaxed/simple;
	bh=7OpjZrf2rZUatPRiVLDJEnIQhiXR+wFpVF1nDKy21Ik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZqpRotQjqa9D4zfMdT5lgIsnlvRnb/9F8ZzmhfwcC3qp2cZCPuQ+BJL8Ol7tP0DrURe38L2MLntUbPX3EIH7UdQu0k+EvYiXX0eLqC8tl7jjvsA/Kjxn9vEw4byS6NXNSboqLrR1zVYThSvvVH0dNQdlpX9OdGa+lb9BsOG6yOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyuV7hXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EEBC116B1;
	Fri, 31 Oct 2025 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761941039;
	bh=7OpjZrf2rZUatPRiVLDJEnIQhiXR+wFpVF1nDKy21Ik=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fyuV7hXB3xAdk4HZRBBZY80r0CFYJPDRMEneWv83X5ImR935R76k6NIhlCmHTVNU8
	 lmQpfnzQeef40uXtciVx4ZQ0Y5JSR02vhRAfdD0Q+4NVQ6kt02/m5Tbcj5JAShYRvo
	 dE0UF8nPvDXFXHwt9df8bnxxrPksHdloxlKszFdYmwAxBErC1e5xaSdfTm4U0r525r
	 eNxkNu/Gx7ZJOPVjc1AwxwmDlHLW/1JFjJVvsRWtFoWmWxV6KKzMe6OJYBPB/GECOq
	 sbAckZf6tuU+HIaYcILMTzpSpBTbyrRXrNM6RQQHhnZFJL3UQTphKEbZ9SRO5UkPRK
	 U8y+4FfhvAPZA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E6CEF4006C;
	Fri, 31 Oct 2025 16:03:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 16:03:57 -0400
X-ME-Sender: <xms:LRYFacKrKOf1iscUlDM66NDTTn7db2-Q9dJZXohAqdw7B2BIEYMIrA>
    <xme:LRYFaW9BCGXcziBIXZ3j9jeTLkeHB4wA_vUoNHpHEF-_F_g1T6Zhr4YcnNlSx8vsB
    KjSky_-MbdvhWBrm5jL0Q7BOB9FM1LwOjOAPJatpsILYf4LfEbvhlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeejvddvtdehffdtgfejjeefgefgjeeggfeuteeiuedvtefgfffhvdej
    iefguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepugifmhifsegrmhgrii
    honhdrtghordhukhdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvghrfeestghithhr
    ihigrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrughu
    nhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnsh
    gvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgs
    vgesihhnthgvlhdrtghomhdprhgtphhtthhopehsohhhihhlrdhmvghhthgrsehinhhtvg
    hlrdgtohhm
X-ME-Proxy: <xmx:LRYFaRviLjJGYlm0WNJCc_-A2pn-yO32V4nAbXcmu9NvQwBum--b-Q>
    <xmx:LRYFafmdouFSWJAiTe7YEAbDXbdYBmqNx0vNCP_GesCqNeH2Rr5e7A>
    <xmx:LRYFacACaAsq3HcwXn3D5E_Vx3xCmfvQKqicZ2DHjLB-0fcsFCbl6A>
    <xmx:LRYFafyMb1Q-hl0AnFQwo81XvZeSeA1fGCq6OZVEPLLO7peFd2ATqA>
    <xmx:LRYFaYfCnOm1QDuYRGKx3g1iFPFYPwX-aUxiz1F2Rb_ydnzfbgNv-_VO>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C5F1700054; Fri, 31 Oct 2025 16:03:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZew4vHeQ4DB
Date: Fri, 31 Oct 2025 13:03:24 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Sohil Mehta" <sohil.mehta@intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-Id: <fe662d7c-d537-495e-92e5-baf64ebbcc2d@app.fastmail.com>
In-Reply-To: <76e8411b-e5ff-4c01-b63c-ef60e29388a3@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-8-sohil.mehta@intel.com>
 <9a4794f5-2a1f-4048-a870-b99fb5ab8136@intel.com>
 <76e8411b-e5ff-4c01-b63c-ef60e29388a3@intel.com>
Subject: Re: [PATCH v11 7/9] x86/traps: Communicate a LASS violation in #GP message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Oct 31, 2025, at 12:59 PM, Sohil Mehta wrote:
> On 10/31/2025 10:16 AM, Dave Hansen wrote:
>> On 10/29/25 14:03, Sohil Mehta wrote:
>>> To make the transition easier, enhance the #GP Oops message to inclu=
de a
>>> hint about LASS violations. Also, add a special hint for kernel NULL
>>> pointer dereferences to match with the existing #PF message.
>>=20
>> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>>=20
>> This also reminds me... Are there tests for this somewhere? How did y=
ou
>> test all these new messages?
>
> I have some very simple kernel modules that access invalid user memory
> and generate these faults. I configure the kernel not to panic/reboot.
> But, I have been running them manually.
>
> Invalid accesses from the kernel generate:
> #PF (without LASS):
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   BUG: unable to handle page fault for address: 0000000000100000
>
> #GP (with LASS):
>   Oops: general protection fault, kernel NULL pointer dereference 0x0:=
 0000
>   Oops: general protection fault, probably LASS violation for address
> 0x100000: 0000
>
> For testing user SIGSEGVs, the Vsyscall tests have been sufficient to
> cover all scenarios.
>
> Were you looking for anything specific? I can clean them up and post
> them if required.

LKDTM is basically meant for this use case. If you can=E2=80=99t provoke=
 a LASS failure from there, maybe just add another failure type?  I woul=
d expect that LKDTM can already do a SMAP violation.

