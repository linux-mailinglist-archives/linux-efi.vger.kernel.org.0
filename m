Return-Path: <linux-efi+bounces-5267-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8ADC21822
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E65C3BB1BB
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4136A5F1;
	Thu, 30 Oct 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxv8mOU5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED336A5E7
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845539; cv=none; b=UuvH5CBc+TBuHhi1ourWqZpXTr2uOG+K13VnDLLsGjmvx3aLx0fGQHcWb3eUapG9T0/1N4w+g8mGkcVAXets8aRBc7nm4NApmBFnL271H2+1eXBvC+60yFj2+omVBt2E/lxv3NTxVewN8h7Kz58qblXOoN8DkZkfuIJEyXB4Rcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845539; c=relaxed/simple;
	bh=1LWwMX8upkOTWfTHLCsISQfEujN76GC+SV8w1/AUXTE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JbmKdVasRvU8zsqgkqp0sUrQe5MsJ0hxu4/5zPO4Sb1jolCgJmFt3X1Qk2JLYSVMRuyE+O8I3MIMboxkP40cwdE/LhDFTQ51JlVkX5ATs2cq9OFA5ZGaNCvE0Ip7Eq2e5z6j7LqPf8ElYJX34QeltlX0i4A/i+mAijiHTFpzyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxv8mOU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4828AC4CEF1;
	Thu, 30 Oct 2025 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761845539;
	bh=1LWwMX8upkOTWfTHLCsISQfEujN76GC+SV8w1/AUXTE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pxv8mOU5PLc91m3ZAo6bvhZWNDwbLG13du4TRJ/rnYcyOfntPNxSCc8ryMosyu6wA
	 L1RUc8TVZ5ROcpQetZL/ZtYU242ttNJjd9DNPEs+EI0cYDseQs8CoYBdVr8lQQNL1Y
	 4Vz04n8xX+ZeJhM7R2MZS8P/c3vFJ/AC4V4HLBi5/r/GPkPHYvZlIWyh03iDl/KWYy
	 akiZVQr2cGfKrOkpiLs9kM1GwSYXKo+7PqpBlYt0VKqT85FD/Mqzi9kWN4i9iVMYlY
	 ZiOzfyPfr3DdaLgHGOdGn+BYZbnxw8BkteHgUd44AadUa6FKQXn7cIPjt0Ci3JzvgC
	 1kCYM1g9hVLXw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70726F40067;
	Thu, 30 Oct 2025 13:32:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 13:32:17 -0400
X-ME-Sender: <xms:IaEDaTwsQry2nvvCHtJ_vWvSkYjw1X31kdlLJBvDuvuFXr2Pe_wCbw>
    <xme:IaEDaWGRyUYQmFiqyCYQoMRDjvxTgmjwzt3yLO1eIByedCkFneSvtMRe25BLeKMQf
    6fxSr_ArAj92LYziMQDqfHfKwulaE1zGv33s0Z0XjJbpFK_jCnR4Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjefhvdehhfffkeetteelfeetgfethedvgeeiheehudffteefgfekjeef
    gefhudeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
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
X-ME-Proxy: <xmx:IaEDaWDDD7iMbRU-14N4TryucS55IZuq0YSvaB5tWF1E0kVe7v8onw>
    <xmx:IaEDaY4IA0_RbjToT1mi5GSjwvQdpNAy4MReRAtSH8w3A_kqpTBacw>
    <xmx:IaEDabyQpo817sZskxYO8jgwV_41yMGt4k_rD9i0-OdSJ_u-kRsf6g>
    <xmx:IaEDacm5ojZm6GCK3yGCCFKkBkDB6TaLj0L1XGhg-k31XqOa038SJw>
    <xmx:IaEDadUZUVP5Lk0RoraKbWzkZaah2R2Yep-05GEvfamy_LS8U-WWX_W->
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2AD63700063; Thu, 30 Oct 2025 13:32:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuvVN0AAjWd7
Date: Thu, 30 Oct 2025 10:31:56 -0700
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
Message-Id: <202682ea-304d-43b2-8a69-c8bc9d8e3e2c@app.fastmail.com>
In-Reply-To: <e3215a62-335f-463b-98d1-de95e5859b9d@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
 <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
 <ed1a6e12-68cb-4103-946a-761260d18eab@app.fastmail.com>
 <e3215a62-335f-463b-98d1-de95e5859b9d@intel.com>
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU initialization
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 30, 2025, at 10:24 AM, Sohil Mehta wrote:
> On 10/30/2025 9:53 AM, Andy Lutomirski wrote:
>
>>> On the other hand, supporting EMULATE mode during a #GP is a bit tricky,
>>> which isn't worth the effort.
>> 
>> I would say it's definitely worth the effort, but it probably does make sense to get the rest of the series in a mergeable condition such that it only works with vsyscall=none.
>
> I meant the full emulation mode where the Vsyscall page is readable. It
> is only available via vsyscall=emulate. No one should be using that one,
> right?
>
> I thought you and Linus agreed on removing EMULATE mode completely:
> https://lore.kernel.org/all/CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com/
>
> I agree that it would be worthwhile (and relatively easy) to support the
> execute (XONLY) mode (that only does instruction fetches). That is what
> the separate vsyscall series would do once the LASS base is in.

Ah, I misunderstood you. I agree.

