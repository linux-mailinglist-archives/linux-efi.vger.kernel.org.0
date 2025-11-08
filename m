Return-Path: <linux-efi+bounces-5398-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A7C435B5
	for <lists+linux-efi@lfdr.de>; Sat, 08 Nov 2025 23:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9513188B74D
	for <lists+linux-efi@lfdr.de>; Sat,  8 Nov 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292151D799D;
	Sat,  8 Nov 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lNJEf1Ga"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC415695;
	Sat,  8 Nov 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642252; cv=none; b=jzRJBVqblbSNLX/AeUXHTfQOE+mtmFtcAserVFw9nyX2izUXQ8LXDusBDxPIyxpsmWOolla0Jb2S8D1U5fBxt4zL9h3doK9A7PrnibuC1g6iBJMsZwarJOZT2wlPVtWWp/ZFVafRHNsDV7EBNeap2YLG//2uhvIxIxzEbshFYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642252; c=relaxed/simple;
	bh=Ca7/YNodRus5eia0lM3nJa1dKQJVHLJkRstjfG6zoFk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gR8w+O7TkaIruVaVpev4h/q0JffIKLTGSScLbEB4qwe9lB+9L+8GijDYMkF3KAJC3P/BS/4RskdgzampIJNGFBHuOIzXGYsQ/flZBMLHWTGGwSrm+UnFghdnMwvV4AWlH2aIPWTqGXSanmRxzrw43OIPT4RHQKD4hQ73uWHl0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lNJEf1Ga; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A8Mo5B62491141
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Nov 2025 14:50:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A8Mo5B62491141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762642208;
	bh=Ca7/YNodRus5eia0lM3nJa1dKQJVHLJkRstjfG6zoFk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lNJEf1GaZLDu0K2v7RvEBuF7keW7GIbhZNoXCvxiSW54CQHSLk1/27oAg9lihpyBA
	 BdZSFH83ZBfiXrLknM6DA9I4ZCz9gioJvLu9Hkqz7VyilyoGX0mUmproAv8H6e6RZQ
	 6u6/ESiXPaWLD23/B2L4oc/lNCJbteJibCHWBB/IjNJSCX2WWNjufAK9itT3DUPYB+
	 RwttRF+BtY1BDhM99wa5qNS0s23a50jQrK58Mgi4m8J+7nUYUtekTC/OWVb8o6zbWu
	 5/23LQgQjQpB3fQo3RQ3xVRu4NrEdcIQ2UI45rV076uJooA46WaZC8oyojjy493ka7
	 nQQGw+6tTMOOg==
Date: Sat, 08 Nov 2025 14:50:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sean Christopherson <seanjc@google.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_5/9=5D_x86/efi=3A_Disable_LAS?=
 =?US-ASCII?Q?S_while_mapping_the_EFI_runtime_services?=
User-Agent: K-9 Mail for Android
In-Reply-To: <99143293-1715-4c40-b937-3e7472e26732@app.fastmail.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-6-sohil.mehta@intel.com> <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com> <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com> <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com> <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com> <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com> <20251107090406.GU3245006@noisy.programming.kicks-ass.net> <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com> <20251107094008.GA1618871@noisy.programming.kicks-ass.net> <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com> <99143293-1715-4c40-b937-3e7472e26732@app.fastmail.com>
Message-ID: <C05D668B-2C88-4BAA-A0F0-0DB881F2F3EF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 7, 2025 4:48:05 PM PST, Andy Lutomirski <luto@kernel=2Eorg> wro=
te:
>
>
>On Fri, Nov 7, 2025, at 2:09 AM, Ard Biesheuvel wrote:
>> On Fri, 7 Nov 2025 at 10:40, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>>>
>>> On Fri, Nov 07, 2025 at 10:22:30AM +0100, Ard Biesheuvel wrote:
>>>
>>> > > But that's just the thing EFI is *NOT* trusted! We're basically
>>> > > disabling all security features (not listed above are CET and CFI)=
 to
>>> > > run this random garbage we have no control over=2E
>>> > >
>>> > > How about we just flat out refuse EFI runtime services? What are t=
hey
>>> > > actually needed for? Why are we bending over backwards and subvert=
ing
>>> > > our security for this stuff?
>>> >
>>> > On x86, it is mostly the EFI variable services that user space has
>>> > come to rely on, not only for setting the boot path (which typically
>>> > happens only once at installation time, when the path to GRUB is set
>>> > as the first boot option)=2E Unfortunately, the systemd folks have t=
aken
>>> > a liking to this feature too, and have started storing things in
>>> > there=2E
>>>
>>> *groan*, so booting with noefi (I just went and found that option) wil=
l
>>> cause a modern Linux system to fail booting?
>>>
>>
>> As long as you install with EFI enabled, the impact of efi=3Dnoruntime
>> should be limited, given that x86 does not rely on EFI runtime
>> services for the RTC or for reboot/poweroff=2E But you will lose access
>> to the EFI variable store=2E (Not sure what 'noefi' does in comparison,
>> but keeping EFI enabled at boot time for things like secure/measured
>> boot and storage encryption will probably result in a net positive
>> impact on security/hardening as long as you avoid calling into the
>> firmware after boot)
>>
>>
>>> > There is also PRM, which is much worse, as it permits devices in the
>>> > ACPI namespace to call firmware routines that are mapped privileged =
in
>>> > the OS address space in the same way=2E I objected to this at the ti=
me,
>>> > and asked for a facility where we could at least mark such code as
>>> > unprivileged (and run it as such) but this was ignored, as Intel and
>>> > MS had already sealed the deal and put this into production=2E This =
is
>>> > much worse than typical EFI routines, as the PRM code is ODM/OEM cod=
e
>>> > rather than something that comes from the upstream EFI implementatio=
n=2E
>>> > It is basically a dumping ground for code that used to run in SMM
>>> > because it was too ugly to run anywhere else=2E </rant>
>>>
>>> What the actual fuck!! And we support this garbage? Without
>>> pr_err(FW_BUG ) notification?
>>>
>>> How can one find such devices? I need to check my machine=2E
>>>
>>
>> Unless you have a PRMT table in the list of ACPI tables, your system
>> shouldn't be affected by this=2E
>>
>>> > It would be nice if we could
>>> >
>>> > a) Get rid of SetVirtualAddressMap(), which is another insane hack
>>> > that should never have been supported on 64-bit systems=2E On arm64,=
 we
>>> > no longer call it unless there is a specific need for it (some Amper=
e
>>> > Altra systems with buggy firmware will crash otherwise)=2E On x86,
>>> > though, it might be tricky because there so much buggy firmware=2E
>>> > Perhaps we should phase it out by checking for the UEFI version, so
>>> > that future systems will avoid it=2E This would mean, however, that =
EFI
>>> > code remains in the low user address space, which may not be what yo=
u
>>> > want (unless we do c) perhaps?)
>>> >
>>> > b) Run EFI runtime calls in a sandbox VM - there was a PoC implement=
ed
>>> > for arm64 a couple of years ago, but it was very intrusive and the A=
RM
>>> > intern in question went on to do more satisyfing work=2E
>>> >
>>> > c) Unmap the kernel KPTI style while the runtime calls are in
>>> > progress? This should be rather straight-forward, although it might
>>> > not help a lot as the code in question still runs privileged=2E
>>>
>>> At the very least I think we should start printing scary messages abou=
t
>>> disabling security to run untrusted code=2E This is all quite insane :=
/
>>
>> I agree in principle=2E However, calling it 'untrusted' is a bit
>> misleading here, given that you already rely on the same body of code
>> to boot your computer to begin with=2E I=2Ee=2E, if you suspect that th=
e
>> code in question is conspiring against you, not calling it at runtime
>> to manipulate EFI variables is not going to help with that=2E
>>
>> But from a robustness point of view, I agree - running vendor code at
>> the OS's privilege level at runtime that was only tested with Windows
>> is not great for stability, and it would be nice if we could leverage
>> the principle of least privilege and only permit it to access the
>> things that it actually needs to perform the task that we've asked it
>> to=2E This is why I asked for the ability to mark PRM services as
>> unprivileged, given that they typically only run some code and perhaps
>> poke some memory (either RAM or MMIO registers) that the OS never
>> accesses directly=2E
>>
>> Question is though whether on x86, sandboxing is feasible: can VMs
>> call into SMM? Because that is where 95% of the EFI variable services
>> logic resides - the code running directly under the OS does very
>> little other than marshalling the arguments and passing them on=2E
>
>Last time I looked at the calls into SMM (which was quite a while ago), t=
hey were fairly recognizable sequences that would nicely cause VM exits=2E =
 So the VM would exit and we would invoke SMM on its behalf=2E
>
>But it=E2=80=99s very very very common for VMX/SVM to be unavailable=2E
>
>Has anyone tried running EFI at CPL3?
>
>P=2ES=2E Forget about relying on AC to make EFI work=2E I doubt we can tr=
ust EFI to leave AC set=2E
>

They certainly cause vmexits, as they are mostly I/O port accesses=2E Mayb=
e there are MSRs on some platforms=2E But what do you do with them?

