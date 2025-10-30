Return-Path: <linux-efi+bounces-5268-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6273C2182B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 18:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BE21897A24
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24F36B96F;
	Thu, 30 Oct 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve4Jsu+W"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800E36B96D
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845732; cv=none; b=JDN0qt7yl6ixWmH3lzhr2Gt/2DVmhc3kLsK8u+4HFmvL58n3uZ3S7PIVBFQZ6WAiNhCsNATRmk5t5GiENFqb7rNhA1HCO67ft6L7aAgORdOSGQ0R1eEd2zJLkTxeM+XPiNCssMO4r2SOBqPT/Ot6klFIYAvWvHGTDCx9rRoprJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845732; c=relaxed/simple;
	bh=/GttvS/7vzzS+wZjSKq5U3nvJRf9+dVtCEgqno6zKMk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LHkFdBqqM8ZqSxBnaUPH8LTwNBZEAuyMqP/Z2AWU/fypaat8zXtK4SL3/0e6ge/6yIvDujynFa88rx3vxavvgxb+IhxY92VyIUyuLllKlUJjPsYwUVEBSjufaTnWmH0PLtPmNTCKDeMIW65SlRuIyiv261MnXkXku5DcStHsel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve4Jsu+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC64EC4AF0B;
	Thu, 30 Oct 2025 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761845732;
	bh=/GttvS/7vzzS+wZjSKq5U3nvJRf9+dVtCEgqno6zKMk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ve4Jsu+WHzAVLMCvmBu23MzC1AUuelxWlSWcCSXKfhcxvJYpPCTX9KtRZRSMa1vLY
	 XJMSsmaQZnFjScry+1XY2qqq/dscHOuI+FphJTlyG/Wd3UppymD92tz+SaI9/uZMxm
	 zO5KvUitl/vzEJuLTa05DPBOS2zUsrqXwQKyqCbkIFJDOCVm6DgcZHhDUjWDaUrEAf
	 zMf8RWtB8JKihXmRUwwzz3YImfSkDtEtX4IwiuC9OOU+/glWHYLO7T/QTCK8dBzxaF
	 Mws5uLFhUHBpJrpfyYaTs7m+Mbh0vxrNuLdw5jXZdiFjiBGKEjCSewRYRa6tnBjRJ6
	 8Qg1hOgxs6B0A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id CAF86F40074;
	Thu, 30 Oct 2025 13:35:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 13:35:30 -0400
X-ME-Sender: <xms:4qEDaWCtPmwUryAsSSY2tEEpZopueGq2TCFMEb9Q73ki_V0VPDII_Q>
    <xme:4qEDabXlglZRZTI4a3kFOS2oxdAQZ4SASWmMTmbN3mYrI3yafXhtUCNIkuflJLx2c
    MfDhEUeThzX0CNEYq519QZ3mM0w8KNF4TarYN1AE3OoUZQrXH5hClQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4qEDacqegio7cphyCEdczd1rvspJnw08Z_nIz0AvPC9B4EqZKi-Ccw>
    <xmx:4qEDacSbyn75oUH36Cih4MAh5jWqsoyNecTfNu1h65R_FpxzXUrBrQ>
    <xmx:4qEDaUrSS8FD_WPmu5u4a3c8qtQUProMLKSN7nSM55sweH1ewNT6zw>
    <xmx:4qEDaazlduJmGiuqLMQpic3Ap0J_Yw9zlx0jLG9JK60hvxTK7S5XLg>
    <xmx:4qEDaXCwXhxdjfxUaavXoadDKWRfmT_tHRK6y2wnfIQqoy18S3swvz5W>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B386700054; Thu, 30 Oct 2025 13:35:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlsNM-Jg7rAZ
Date: Thu, 30 Oct 2025 10:35:09 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, "Dave Hansen" <dave.hansen@intel.com>,
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
 "Kees Cook" <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <0630921a-a99f-4577-bc8e-0aaf08b3175d@app.fastmail.com>
In-Reply-To: <E95F62DC-0B5D-47ED-8B72-F619B45340C8@zytor.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-9-sohil.mehta@intel.com>
 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
 <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
 <E95F62DC-0B5D-47ED-8B72-F619B45340C8@zytor.com>
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault emulation code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 30, 2025, at 10:22 AM, H. Peter Anvin wrote:
> On October 30, 2025 9:58:02 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>>
>>
>>On Tue, Oct 7, 2025, at 11:48 AM, Dave Hansen wrote:
>>> On 10/7/25 11:37, Edgecombe, Rick P wrote:
>>>>>  	/*
>>>>>  	 * No point in checking CS -- the only way to get here is a user mode
>>>>>  	 * trap to a high address, which means that we're in 64-bit user code.
>>>> I don't know. Is this as true any more? We are now sometimes guessing based on
>>>> regs->ip of a #GP. What if the kernel accidentally tries to jump to the vsyscall
>>>> address? Then we are reading the kernel stack and strange things. Maybe it's
>>>> worth replacing the comment with a check? Feel free to call this paranoid.
>>>
>>> The first check in emulate_vsyscall() is:
>>>
>>>        /* Write faults or kernel-privilege faults never get fixed up. */
>>>        if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>>>                return false;
>>>
>>> If the kernel jumped to the vsyscall page, it would end up there, return
>>> false, and never reach the code near the "No point in checking CS" comment.
>>>
>>> Right? Or am I misunderstanding the scenario you're calling out?
>>>
>>> If I'm understanding it right, I'd be a bit reluctant to add a CS check
>>> as well.
>>
>>IMO it should boil down to exactly the same thing as the current code for the #PF case and, for #GP, there are two logical conditions that we care about:
>>
>>1. Are we in user mode?
>>
>>2. Are we using a 64-bit CS such that vsyscall emulation makes sense.
>>
>>Now I'd be a tiny bit surprised if a CPU allows you to lretq or similar to a 32-bit CS with >2^63 RIP, but what do I know?  One could test this on a variety of machines, both Intel and AMD, to see what actually happens.
>>
>>But the kernel wraps all this up as user_64bit_mode(regs).  If user_64bit_mode(regs) is true and RIP points to a vsyscall, then ISTM there aren't a whole lot of options.  Somehow we're in user mode, either via an exit from kernel mode or via CALL/JMP/whatever from user mode, and RIP is pointing at the vsyscall page, and CS is such that, in the absence of LASS, we would execute the vsyscall.  I suppose the #GP could be from some other cause than a LASS violation, but that doesn't seem worth worrying about.
>>
>>So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vsyscall case.  (As submitted, unless I missed something while composing the patches in my head, it's only checking user_mode(regs), and I think it's worth the single extra line of code to make the result a tiny bit more robust.)
>
> user_64bit_mode() is a CS check :)
>
> There is that one extra check for PARAVIRT_XXL that *could* be gotten 
> rid of by making the PV code report its 64-bit selector and patching it 
> into the test, but it is on the error path anyway...

In the hopefully unlikely event that anyone cares about #GP performance, they should probably care far, far more about the absurd PASID fix up than anything else :)

