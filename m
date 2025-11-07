Return-Path: <linux-efi+bounces-5384-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F884C3F587
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7854F3A6287
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C92F746F;
	Fri,  7 Nov 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4+YicdZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD82E88A7
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510197; cv=none; b=rrlOYRs4LiFclXIDxUFYsT/OOpW77X6e8ZHRYjkeNaGMbudG4EaBio1DC4tgN9+qUT1xcWxyDJGWtZdvz3J21Yy5SViqif+XCTNptJSaAuD8Q+D4W1rpDk7cD2AlYj9yfOnoOAze+fFW0YO1oq+xqcfejLZMSepRdBXWR27+Hi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510197; c=relaxed/simple;
	bh=Y4UnvmVEVl/VmK0eAUfCDmIuEFZ7ECEMGmODhSpYss0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of+JA6KHxxG9xmJN9seosNwuk73qD1Zw5/p7KDPYGpTw0+aL7lmANdF+sgoBvE+4H5d96Ito/D227knVljkpyi+C35n9lOnLodIcn+mMXfLSZE0BCS0xZZyMjQCtpxGN+K+j8yBtJEMZtFy5vRec++yL6pZfNd04DGgNTgCFKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4+YicdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556DAC2BC86
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510197;
	bh=Y4UnvmVEVl/VmK0eAUfCDmIuEFZ7ECEMGmODhSpYss0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A4+YicdZzzatseb6uptZVndgt8AfpamNCHAb/GI6Hz2QIYwQ4vPWW7UVkwxcb2tOQ
	 sHHhGCEUNGgKda93UZOjdW6yOoqSGTGtcsAkhVXBIxYKwM/icAfInUVwU2n4JVt4VR
	 YkzB9mYAm2CefxLt7qwpzbHz/3SDysVlgrjJGCXIrhJnU/87XFQxlGvBvG0be0hO0Z
	 egWeTMmN711bmtVPo1/zW4pdMQ4AokNbPt0qMuon4jJvcnnmCYsSrWU4WRjIIUpKcq
	 xehDUqhI9hKUWKvdUSlqbFSCb+OtGbbHmThKCTtGrjE12ESdfuhYxMvR+5un0tu4Vg
	 tuStJV8xvn+7A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591c98ebe90so604858e87.3
        for <linux-efi@vger.kernel.org>; Fri, 07 Nov 2025 02:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiNYBTJDutzFsBPAJnY07d60LPadxdx01sky4r39B3+tzGQwQFgjm7z17y08r3/86mAGsPsIStR+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYDudx5C3dOMBNfBxX7TcRIL1EL8aj6RfLL1PD6zMZ4rV1gHV
	ljzO9YoMhZPvvEij+j4jEFu9f9SM2zpxVJl34Gcncx0dxXUQKKuGwIXBjehPIzm0ukLNICm8B3T
	4gv4OFiZ5xASz0FabQuWrG56IjZKv/FY=
X-Google-Smtp-Source: AGHT+IGnDKxY7oI2g9yt5Gzfh2nRLlBmc9PtoKoHuMl22HWZECriXuV0Z+q2cSR+rmWH8VKqPl40aUH9kYUfXJAIVP4=
X-Received: by 2002:a05:6512:ad1:b0:58b:8f:2cf3 with SMTP id
 2adb3069b0e04-59456b5bf7fmr796812e87.21.1762510195538; Fri, 07 Nov 2025
 02:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com> <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com> <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com> <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
 <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
 <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com> <20251107094008.GA1618871@noisy.programming.kicks-ass.net>
In-Reply-To: <20251107094008.GA1618871@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Nov 2025 11:09:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>
X-Gm-Features: AWmQ_bkPAqMiulzBzQqZdwUslnFwT-57GxShague_DPzlvByepJhmBalkp194_M
Message-ID: <CAMj1kXFWCwEENyS=JM5mAON6ebfTwwJh-mRDYCY5NA+5UGzZJg@mail.gmail.com>
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Andy Lutomirski <luto@kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Sean Christopherson <seanjc@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 10:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 07, 2025 at 10:22:30AM +0100, Ard Biesheuvel wrote:
>
> > > But that's just the thing EFI is *NOT* trusted! We're basically
> > > disabling all security features (not listed above are CET and CFI) to
> > > run this random garbage we have no control over.
> > >
> > > How about we just flat out refuse EFI runtime services? What are they
> > > actually needed for? Why are we bending over backwards and subverting
> > > our security for this stuff?
> >
> > On x86, it is mostly the EFI variable services that user space has
> > come to rely on, not only for setting the boot path (which typically
> > happens only once at installation time, when the path to GRUB is set
> > as the first boot option). Unfortunately, the systemd folks have taken
> > a liking to this feature too, and have started storing things in
> > there.
>
> *groan*, so booting with noefi (I just went and found that option) will
> cause a modern Linux system to fail booting?
>

As long as you install with EFI enabled, the impact of efi=noruntime
should be limited, given that x86 does not rely on EFI runtime
services for the RTC or for reboot/poweroff. But you will lose access
to the EFI variable store. (Not sure what 'noefi' does in comparison,
but keeping EFI enabled at boot time for things like secure/measured
boot and storage encryption will probably result in a net positive
impact on security/hardening as long as you avoid calling into the
firmware after boot)


> > There is also PRM, which is much worse, as it permits devices in the
> > ACPI namespace to call firmware routines that are mapped privileged in
> > the OS address space in the same way. I objected to this at the time,
> > and asked for a facility where we could at least mark such code as
> > unprivileged (and run it as such) but this was ignored, as Intel and
> > MS had already sealed the deal and put this into production. This is
> > much worse than typical EFI routines, as the PRM code is ODM/OEM code
> > rather than something that comes from the upstream EFI implementation.
> > It is basically a dumping ground for code that used to run in SMM
> > because it was too ugly to run anywhere else. </rant>
>
> What the actual fuck!! And we support this garbage? Without
> pr_err(FW_BUG ) notification?
>
> How can one find such devices? I need to check my machine.
>

Unless you have a PRMT table in the list of ACPI tables, your system
shouldn't be affected by this.

> > It would be nice if we could
> >
> > a) Get rid of SetVirtualAddressMap(), which is another insane hack
> > that should never have been supported on 64-bit systems. On arm64, we
> > no longer call it unless there is a specific need for it (some Ampere
> > Altra systems with buggy firmware will crash otherwise). On x86,
> > though, it might be tricky because there so much buggy firmware.
> > Perhaps we should phase it out by checking for the UEFI version, so
> > that future systems will avoid it. This would mean, however, that EFI
> > code remains in the low user address space, which may not be what you
> > want (unless we do c) perhaps?)
> >
> > b) Run EFI runtime calls in a sandbox VM - there was a PoC implemented
> > for arm64 a couple of years ago, but it was very intrusive and the ARM
> > intern in question went on to do more satisyfing work.
> >
> > c) Unmap the kernel KPTI style while the runtime calls are in
> > progress? This should be rather straight-forward, although it might
> > not help a lot as the code in question still runs privileged.
>
> At the very least I think we should start printing scary messages about
> disabling security to run untrusted code. This is all quite insane :/

I agree in principle. However, calling it 'untrusted' is a bit
misleading here, given that you already rely on the same body of code
to boot your computer to begin with. I.e., if you suspect that the
code in question is conspiring against you, not calling it at runtime
to manipulate EFI variables is not going to help with that.

But from a robustness point of view, I agree - running vendor code at
the OS's privilege level at runtime that was only tested with Windows
is not great for stability, and it would be nice if we could leverage
the principle of least privilege and only permit it to access the
things that it actually needs to perform the task that we've asked it
to. This is why I asked for the ability to mark PRM services as
unprivileged, given that they typically only run some code and perhaps
poke some memory (either RAM or MMIO registers) that the OS never
accesses directly.

Question is though whether on x86, sandboxing is feasible: can VMs
call into SMM? Because that is where 95% of the EFI variable services
logic resides - the code running directly under the OS does very
little other than marshalling the arguments and passing them on.

