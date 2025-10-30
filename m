Return-Path: <linux-efi+bounces-5263-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B169DC215A8
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC3A34EF0B2
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5336334B;
	Thu, 30 Oct 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9bVXpDO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4332E69C
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843505; cv=none; b=EQ2HIoIXyrenmcbuQTPDLzZA8UUp+RM9neoN0ZB3i8Q2IIes5P1wNpWWK6TQ8Xsi05q/ihIA6EmOkNPlNVXsjeawkOm92JFMOC+q8qTZgcDuf0C7XnFtbx4dSr77gnElCF94V1G+sGNH+Ya2+bqJzCc4r5expc3H3s8x0rGn3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843505; c=relaxed/simple;
	bh=Hq8p5I7KnzMNDXe5Bh4E6FjIiLt5mIsSkQFjlD2+pAA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SrPdNs6s1XkWl9Q5iBgCynwKXEfmG3fBpRpAmaOgrWdBVXGny1mLMMCcXKX5Ag8GIvBvNpyie/BZDbRJCYtodDWTVD6qNW/5/bbT7AyZ4oQx3z0+aqnvlpoYsIjGEAyLU8wj8eaFOHcPackpIkObj7zvzaeDd4BDnBeUH6sixYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9bVXpDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE7C116B1;
	Thu, 30 Oct 2025 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761843505;
	bh=Hq8p5I7KnzMNDXe5Bh4E6FjIiLt5mIsSkQFjlD2+pAA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=n9bVXpDOf9VthcUBfHJnC8mpWz6YhCOooMpbFMBp7/ZbvXyo3aD5kV+ZMykjOB93s
	 wWPwbQaMPlVYGQGmCSTuQBQECegPkvmdqcFcSIiaoPauHMlP8WXMUfe66aNrj3tFEg
	 KjFF5qfKShrisJ2AkPA19EEJTGDzgW9HzA1nxp3ksoPtKRoGTLLpQ/gEejWVVhlEQY
	 z3ht9m0v/2PQBZDr6i5r5+x5teguunonpj8L5TTXLE4tWRrqaNYaxFlNKiR7DDYK/x
	 mklxud8NIb+MlcM9Vb7GpAdW6xJPHCuN4TS6WFBLhOOQlW1XrqEtRDBpgOocjfd17H
	 qomLuMoffIrKw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 57047F4006A;
	Thu, 30 Oct 2025 12:58:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 12:58:23 -0400
X-ME-Sender: <xms:L5kDaSlUbQA7GCqRAGTpDeO4iqaK3amShbeM434nOKrxQQFYMzXZyQ>
    <xme:L5kDaUp_hGcJkhoMI3oh8cy-qL4WHo9QoiLfOuCE-RircW3NBuFbg6HO6xHX6r8St
    sbDGIpn_d0j2TkpsXp-_TWpve-oQtxuKIUdAVJqjTlNotY2PhaKeD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepkefhieejfedvueejheehiefgvdfhjeefjeelvdfghfelgeejudevleej
    uddvvefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhspdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepugifmhifsegrmhgrii
    honhdrtghordhukhdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvghrfeestghithhr
    ihigrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrug
    hunhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghn
    shgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomh
    gsvgesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:L5kDaQvgTbcZS_XKBnDK2gguq4s39S4iUBwOXM_ZNzzlvTJ2mWCRBw>
    <xmx:L5kDaXHK4ZNhn8FQSyDMxobbBNzdx6G96JZD5_fsogynaiJBbMe34Q>
    <xmx:L5kDafMflp3Jne2Us4cvLoEgHxHAfjCoVEf9qGYIRYZnwmcVqM3oZA>
    <xmx:L5kDaaHMq5VbBt14P-ssDJUCKMP2U0cfZl6Flcx8Kuowrwcn7g9PRg>
    <xmx:L5kDacEkQVGLVk93dJRcCxKyiW_a8DGya7QjDJB8yzD8znCRGuFEDSV_>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16A5F700054; Thu, 30 Oct 2025 12:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlsNM-Jg7rAZ
Date: Thu, 30 Oct 2025 09:58:02 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Ard Biesheuvel" <ardb@kernel.org>,
 "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Kirill A . Shutemov" <kas@kernel.org>,
 "Sean Christopherson" <seanjc@google.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Vegard Nossum" <vegard.nossum@oracle.com>, "Xin Li" <xin@zytor.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "Kees Cook" <kees@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
In-Reply-To: <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-9-sohil.mehta@intel.com>
 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault emulation code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 7, 2025, at 11:48 AM, Dave Hansen wrote:
> On 10/7/25 11:37, Edgecombe, Rick P wrote:
>>>  	/*
>>>  	 * No point in checking CS -- the only way to get here is a user mode
>>>  	 * trap to a high address, which means that we're in 64-bit user code.
>> I don't know. Is this as true any more? We are now sometimes guessing based on
>> regs->ip of a #GP. What if the kernel accidentally tries to jump to the vsyscall
>> address? Then we are reading the kernel stack and strange things. Maybe it's
>> worth replacing the comment with a check? Feel free to call this paranoid.
>
> The first check in emulate_vsyscall() is:
>
>        /* Write faults or kernel-privilege faults never get fixed up. */
>        if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>                return false;
>
> If the kernel jumped to the vsyscall page, it would end up there, return
> false, and never reach the code near the "No point in checking CS" comment.
>
> Right? Or am I misunderstanding the scenario you're calling out?
>
> If I'm understanding it right, I'd be a bit reluctant to add a CS check
> as well.

IMO it should boil down to exactly the same thing as the current code for the #PF case and, for #GP, there are two logical conditions that we care about:

1. Are we in user mode?

2. Are we using a 64-bit CS such that vsyscall emulation makes sense.

Now I'd be a tiny bit surprised if a CPU allows you to lretq or similar to a 32-bit CS with >2^63 RIP, but what do I know?  One could test this on a variety of machines, both Intel and AMD, to see what actually happens.

But the kernel wraps all this up as user_64bit_mode(regs).  If user_64bit_mode(regs) is true and RIP points to a vsyscall, then ISTM there aren't a whole lot of options.  Somehow we're in user mode, either via an exit from kernel mode or via CALL/JMP/whatever from user mode, and RIP is pointing at the vsyscall page, and CS is such that, in the absence of LASS, we would execute the vsyscall.  I suppose the #GP could be from some other cause than a LASS violation, but that doesn't seem worth worrying about.

So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vsyscall case.  (As submitted, unless I missed something while composing the patches in my head, it's only checking user_mode(regs), and I think it's worth the single extra line of code to make the result a tiny bit more robust.)

