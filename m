Return-Path: <linux-efi+bounces-5314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53BC26698
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 18:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C9F564EBB
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FF24679C;
	Fri, 31 Oct 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1l1h0AQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5B20C48A;
	Fri, 31 Oct 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932305; cv=none; b=pRwgylaTgXB25FYcGCkUfQ8UigymvO3IVVWc5qJXDouocGfB8/5vFA8NBeMeKK7CVjGAS8daxribdAGQpyzhqXPnZk6zQekHpSBrW16b16RIk2+tlI1SNsNZCXzGjviE2N8rJ834/rJHBqC6oGSwXdDgH15cjs0AgbePj5aubuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932305; c=relaxed/simple;
	bh=A+EKaAZj/opdravHhaxGbAzE4Fmi+1ltGU6/WEimB80=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nUi7coH8+l0uQuC0hOddddk/YFaf1EHel/3wz+jWWcHRsz4Qutym+2HpUS5lEOai+9WO2o4X3W6FeesAURE+TEXEJCx6VBiuGgEEkKId6wEVcIe+B3uwkr8fbE/H4l8+7IBAPz2pKnhYfkLgp9PrVPX/bdp8qjMdp+JezkKuLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1l1h0AQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE0C4CEE7;
	Fri, 31 Oct 2025 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761932304;
	bh=A+EKaAZj/opdravHhaxGbAzE4Fmi+1ltGU6/WEimB80=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N1l1h0AQ4QBDbMcX7gS0dZjNhdkdFVARKyseFJjKrIPhILEDwEOXiJUIYYlKefefZ
	 xX2aVSnh7FQDeEKdRTalQJyeWGFs1EEgUqbLj6o1XhstXEki7iB7gjLtqaNJYbHTz8
	 HEg7sGkQ5ddjCwsjIFT4CzAjnF34t66a9s5HJStfb3r9yjR0r/dhltWJe/2NPVYE02
	 v6SZLQLufngiJoD0kIxyG9bxvnaRqliqa92+kdHjoF5xD3NtA27JUDo1lVdPknyGX1
	 zLJjK89SowPCaM0m5pRNjW33C4xkCP7emlyuayaSHnKej2OaEmjekHSCGdMMVU7Me5
	 joOP/cmr56Zqw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F095DF40066;
	Fri, 31 Oct 2025 13:38:22 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 13:38:22 -0400
X-ME-Sender: <xms:DvQEaex6PPFm77wSkAEb3OyS91VMU1-XlFElv1XuDSW2tb-vR5YfLQ>
    <xme:DvQEaVEyT-LGNoyI_3iE5y3k-ASVtYSFMz8DKS2updDD3mw5bB8vktqEkaP3iJknN
    5_Aaw_bouyW4fclBDUFEPUkGfnsddBUoajWqDCUElaMzdTc5-JCXJyV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DvQEaTFCs1CwDM9ZUMrR4hCL7S0zHCJKXyQznIFTye6dwlcG0_I7Jw>
    <xmx:DvQEaX2M7qSxj7GOZW-MDPopjQfOBe-oHldVS8vczZ9zr051tyunbA>
    <xmx:DvQEabM1qv7XBhxatjuLuaeRD7TLkksvtf3lPFb3Yb5UMvFFjDmCAA>
    <xmx:DvQEafK4bGVcPC6pm0OZtoarYjOWj80Eza3jB5_5-o_5UZpPVY9oRg>
    <xmx:DvQEaUYMOja1L_gMXR7kUd0g_riAbW2DUuCDxKF0Z0xaMru8LFMUAVTx>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AEEBE700054; Fri, 31 Oct 2025 13:38:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXqMjp9ffxoB
Date: Fri, 31 Oct 2025 10:38:02 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
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
Message-Id: <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
In-Reply-To: <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI runtime
 services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Oct 31, 2025, at 10:11 AM, Dave Hansen wrote:
> On 10/29/25 14:03, Sohil Mehta wrote:
>> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>=20
>> While mapping EFI runtime services, set_virtual_address_map() is call=
ed
>> at its lower mapping, which LASS prohibits. Wrapping the EFI call with
>> lass_disable()/_enable() is not enough, because the AC flag only
>> controls data accesses, and not instruction fetches.
>>=20
>> Use the big hammer and toggle the CR4.LASS bit to make this work.
>
> One thing that's actually missing here is an explanation on how it's OK
> to munge CR bits here. Why are preemption and interrupts not a problem?
>
> A reviewer would have to go off and figure this out on their own.

I have another question: why is this one specific call a problem as oppo=
sed to something more general?  Wouldn=E2=80=99t any EFI call that touch=
es the low EFI mapping be a problem?  Are there any odd code paths that =
touch low mapped EFI *data* that would fault?

Am I imagining an issue that doesn=E2=80=99t exist?  Is there some way t=
o be reasonably convinced that you haven=E2=80=99t missed another EFI co=
de path?  Would it be ridiculous to defer enabling LASS until we=E2=80=99=
re almost ready to run user code?

