Return-Path: <linux-efi+bounces-5394-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26670C4229E
	for <lists+linux-efi@lfdr.de>; Sat, 08 Nov 2025 01:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFBF94E19F8
	for <lists+linux-efi@lfdr.de>; Sat,  8 Nov 2025 00:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB726E165;
	Sat,  8 Nov 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gswunZeU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1623AB9D
	for <linux-efi@vger.kernel.org>; Sat,  8 Nov 2025 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562915; cv=none; b=eFFYcXG4ciEOfuB6Q9nWCoDGXDoHxPy2QlqOoQnZPmQtW3nENYwLY8MFF/Lwf1cmvDBEHV3D2Zp/JpOHiKM6PCkzlMYBjmacSyHfoyFofrABz/E27PY23ndyr3i5aB9U0JKxpnhPqYF8mfS3BIY2LKl1FFJrtkoduTxVv85CTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562915; c=relaxed/simple;
	bh=lhCi1JXBZrowYMZNCBd1DSzIM50iVkagNImXrUhUvYU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D3ycj4iY6WbTcf23W1c+2L6O/JiB4BQ+bKhQGtrqQ9tj3X0E2ukOHdDO+Dd+xcABhtIwpPH4IopdGXksVcgGeJUOONJYJ8/6k7+viKxx9k4WexlfTEL+AmeaQpuxc9dssyQQTo3O949h9Gd4Zz17RKgqum0vf++eQni6GpXNf1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gswunZeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF5C113D0;
	Sat,  8 Nov 2025 00:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762562914;
	bh=lhCi1JXBZrowYMZNCBd1DSzIM50iVkagNImXrUhUvYU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gswunZeU6p3iEknl+EC2reiaR22VtehXJDZ+aZ2pa5OT0UZ7XCqJkhucRE8txzjzX
	 Px+5k77qJmO4GCQ0fKkUYntLysjz5r3XvmdpeMEzGChXw2sDsQvBYpkY+6U0JmDFaa
	 p/ucgJqPe60IJMYkPKLl0TgpKRdcgY+mD21AHHORwXR2JNfZBlHKQIjuK+OvdWamQ1
	 mhcUJnKbI9Ig6KHiJ29qqP5FAat/EdPILj7Rl4XmdXQ4bzqVQ+gwRlXdhS3figxlxL
	 1HoZPj/hN1vy8HUn+QmMc/426Ji6RmvDZxUk1eBNneiKzT0UPhPrELR/v+tK+cEteO
	 ANi3NOiMTDF7Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25301F4007E;
	Fri,  7 Nov 2025 19:48:33 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 19:48:33 -0500
X-ME-Sender: <xms:YJMOaTVRL4AKewLf-d6j2vDCNLKevTX_epZDh_3gHPY3eXX735sNAg>
    <xme:YJMOaWYFhsVU1tzPSJophTADFm1ERok1QC44ZgQphIT0tXOVG2awzCdG-Ol5SMTrJ
    MMukEzkwxpAI7jApMYd6NO1woBQ7d6FDPuhqFDsL7GR92umff3FwU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleduudegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YZMOaTqX01a8plPFu1dH9pAQWaJWejvvr-lQogf_dSI2Un2vQztvFQ>
    <xmx:YZMOaVLXZH_we85t1eBghbI5ZLK7gVm7_WEZkI9YkEPbhbHf63f0cw>
    <xmx:YZMOaWRwn_zzuw5T8aX0xSwd_CY_J1hvJyZ_SY4e63rHVLULU4WZ0A>
    <xmx:YZMOaU-8vXL3goRPTdhCxi1i1J4F-LtdJMQ9kouGLnK5LQ-dK1eOgw>
    <xmx:YZMOad8IemqdaLz5xausC_sXwBU5fQ8HhabxH1ClBCNK_LxeFeZvxQgQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDF3F700054; Fri,  7 Nov 2025 19:48:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 07 Nov 2025 16:48:05 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Dave Hansen" <dave.hansen@intel.com>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Jonathan Corbet" <corbet@lwn.net>,
 "H. Peter Anvin" <hpa@zytor.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Kirill A . Shutemov" <kas@kernel.org>, "Xin Li" <xin@zytor.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Sean Christopherson" <seanjc@google.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Kees Cook" <kees@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 linux-doc@vger.kernel.org,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-efi@vger.kernel.org
Message-Id: <99143293-1715-4c40-b937-3e7472e26732@app.fastmail.com>
In-Reply-To: 
 <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com>
 <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com>
 <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
 <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
 <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
 <20251107094008.GA1618871@noisy.programming.kicks-ass.net>
 <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI runtime
 services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Nov 7, 2025, at 2:09 AM, Ard Biesheuvel wrote:
> On Fri, 7 Nov 2025 at 10:40, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>
>> On Fri, Nov 07, 2025 at 10:22:30AM +0100, Ard Biesheuvel wrote:
>>
>> > > But that's just the thing EFI is *NOT* trusted! We're basically
>> > > disabling all security features (not listed above are CET and CFI=
) to
>> > > run this random garbage we have no control over.
>> > >
>> > > How about we just flat out refuse EFI runtime services? What are =
they
>> > > actually needed for? Why are we bending over backwards and subver=
ting
>> > > our security for this stuff?
>> >
>> > On x86, it is mostly the EFI variable services that user space has
>> > come to rely on, not only for setting the boot path (which typically
>> > happens only once at installation time, when the path to GRUB is set
>> > as the first boot option). Unfortunately, the systemd folks have ta=
ken
>> > a liking to this feature too, and have started storing things in
>> > there.
>>
>> *groan*, so booting with noefi (I just went and found that option) wi=
ll
>> cause a modern Linux system to fail booting?
>>
>
> As long as you install with EFI enabled, the impact of efi=3Dnoruntime
> should be limited, given that x86 does not rely on EFI runtime
> services for the RTC or for reboot/poweroff. But you will lose access
> to the EFI variable store. (Not sure what 'noefi' does in comparison,
> but keeping EFI enabled at boot time for things like secure/measured
> boot and storage encryption will probably result in a net positive
> impact on security/hardening as long as you avoid calling into the
> firmware after boot)
>
>
>> > There is also PRM, which is much worse, as it permits devices in the
>> > ACPI namespace to call firmware routines that are mapped privileged=
 in
>> > the OS address space in the same way. I objected to this at the tim=
e,
>> > and asked for a facility where we could at least mark such code as
>> > unprivileged (and run it as such) but this was ignored, as Intel and
>> > MS had already sealed the deal and put this into production. This is
>> > much worse than typical EFI routines, as the PRM code is ODM/OEM co=
de
>> > rather than something that comes from the upstream EFI implementati=
on.
>> > It is basically a dumping ground for code that used to run in SMM
>> > because it was too ugly to run anywhere else. </rant>
>>
>> What the actual fuck!! And we support this garbage? Without
>> pr_err(FW_BUG ) notification?
>>
>> How can one find such devices? I need to check my machine.
>>
>
> Unless you have a PRMT table in the list of ACPI tables, your system
> shouldn't be affected by this.
>
>> > It would be nice if we could
>> >
>> > a) Get rid of SetVirtualAddressMap(), which is another insane hack
>> > that should never have been supported on 64-bit systems. On arm64, =
we
>> > no longer call it unless there is a specific need for it (some Ampe=
re
>> > Altra systems with buggy firmware will crash otherwise). On x86,
>> > though, it might be tricky because there so much buggy firmware.
>> > Perhaps we should phase it out by checking for the UEFI version, so
>> > that future systems will avoid it. This would mean, however, that E=
FI
>> > code remains in the low user address space, which may not be what y=
ou
>> > want (unless we do c) perhaps?)
>> >
>> > b) Run EFI runtime calls in a sandbox VM - there was a PoC implemen=
ted
>> > for arm64 a couple of years ago, but it was very intrusive and the =
ARM
>> > intern in question went on to do more satisyfing work.
>> >
>> > c) Unmap the kernel KPTI style while the runtime calls are in
>> > progress? This should be rather straight-forward, although it might
>> > not help a lot as the code in question still runs privileged.
>>
>> At the very least I think we should start printing scary messages abo=
ut
>> disabling security to run untrusted code. This is all quite insane :/
>
> I agree in principle. However, calling it 'untrusted' is a bit
> misleading here, given that you already rely on the same body of code
> to boot your computer to begin with. I.e., if you suspect that the
> code in question is conspiring against you, not calling it at runtime
> to manipulate EFI variables is not going to help with that.
>
> But from a robustness point of view, I agree - running vendor code at
> the OS's privilege level at runtime that was only tested with Windows
> is not great for stability, and it would be nice if we could leverage
> the principle of least privilege and only permit it to access the
> things that it actually needs to perform the task that we've asked it
> to. This is why I asked for the ability to mark PRM services as
> unprivileged, given that they typically only run some code and perhaps
> poke some memory (either RAM or MMIO registers) that the OS never
> accesses directly.
>
> Question is though whether on x86, sandboxing is feasible: can VMs
> call into SMM? Because that is where 95% of the EFI variable services
> logic resides - the code running directly under the OS does very
> little other than marshalling the arguments and passing them on.

Last time I looked at the calls into SMM (which was quite a while ago), =
they were fairly recognizable sequences that would nicely cause VM exits=
.  So the VM would exit and we would invoke SMM on its behalf.

But it=E2=80=99s very very very common for VMX/SVM to be unavailable.

Has anyone tried running EFI at CPL3?

P.S. Forget about relying on AC to make EFI work. I doubt we can trust E=
FI to leave AC set.

