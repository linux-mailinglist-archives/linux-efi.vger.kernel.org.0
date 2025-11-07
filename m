Return-Path: <linux-efi+bounces-5380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA707C3F20C
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 10:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F44EA1CB
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A02D876B;
	Fri,  7 Nov 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAOQN8Xf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34D2BDC03
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507364; cv=none; b=X7LEuDHpOfCG461fMdNhxNi7XQo6ezMrnn+iKxAX58qsYU+qRnDED3u0uKkGzfeJBP9BidrBh4rkDIWfaykjIUf8ZdlVuyYuAM4kZ2FqhOor8aUQdfqxKfiBEzEjfApR14+GfzK4sHXYNXEwSnCSCKLIk27k2+qtLnoSulmFAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507364; c=relaxed/simple;
	bh=iZDRgcEuZ2V744y8rAQO73yQtoqGq8IRRPZO6cq2TFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7tmM1aYjyd9cU3x9LuKCK+dSx4D7L2v6oebwTyoqF6MSp4evWTF7hmWc9VQBQya8Y8k6mYKBBScUaKQ+GCMNV39WyuhsNBnr6z2DIZmlOy5ehQ2QYaAF0xDzlERpYA/9J9G58zpIW0NgDl2Wy+Qy88zWJVjji8TMKuanmkW/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAOQN8Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF82C4CEF8
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 09:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762507364;
	bh=iZDRgcEuZ2V744y8rAQO73yQtoqGq8IRRPZO6cq2TFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HAOQN8XfV2tXH9zC1JKw3RVTGpCv0TN1PnefYCG1WHeINNgYWpIBMi6hlRHXVxtkp
	 rTwLJsH5FMLIMaZ6V6NAa89urr1lKWE9y2RlypRN7rrdUpYgJ5kyAkqFywutc9IKcy
	 DAB24U/MCZcxHvBLBfGKyGOa7c6kyU5OfBx9EPZPDbCvyIo8fCK8aJz/Zyvw6QHyk7
	 AIGVag1L/CIc6r7ModHLP6AvTeEdz36ch7NQoMojIfb/I23nZ7N+JYCpHEl6asxxSo
	 L0H68biCD05/JL1/aAizYiP13MxLeE2sDrj0u0/DXLgpLazyZrlYo2hHI+h6uDUjMb
	 An5MhQFExjzxw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so455356e87.2
        for <linux-efi@vger.kernel.org>; Fri, 07 Nov 2025 01:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK7lLa7MIdS3T80nrVdznsbesaY9laKKYoGiLOS/t25DiENWdch9PbXutjE84kfKlqJvsrU17DQy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzew0qYtvD7CpHtmBRAjZRBMfuzr83Fff5gNwhuigUGiVK6CTpU
	aiTAb8ryMyIfCJc7t3yGydEIlwgGHNHIxR3aSdiPlgd8VSJaVYJXGd5LJQYcC98VKWf64RrDNvX
	zo7rr3oq8GxmR4z7kDrtei5/7dh25PBM=
X-Google-Smtp-Source: AGHT+IGlwZWI4oeJf7pO+l1K3S2g+h8ztknlPLUmU6zqyEc5Ck9Im7sNJuCIeml3UJYuz/bNFMn/5SZws7DSXSaNxeo=
X-Received: by 2002:a05:6512:ad1:b0:592:fd2d:71be with SMTP id
 2adb3069b0e04-59456b79d0dmr804208e87.34.1762507362356; Fri, 07 Nov 2025
 01:22:42 -0800 (PST)
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
In-Reply-To: <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Nov 2025 10:22:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
X-Gm-Features: AWmQ_bkVh3g2m014X3CF9FeiWJxHz8daqUtyC2uNOKnv9aB3oJxm48KiajGK_ao
Message-ID: <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
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

On Fri, 7 Nov 2025 at 10:04, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 31, 2025 at 11:12:53AM -0700, Dave Hansen wrote:
>
> > But there's a pretty broad set of things that are for "security" that
> > aren't necessary while you're just running trusted ring0 code:
> >
> >  * SMAP/SMEP
> >  * CR pinning itself
> >  * MSR_IA32_SPEC_CTRL
> >  * MSR_IA32_TSX_CTRL
> >
> > They just haven't mattered until now because they don't have any
> > practical effect until you actually have code running on _PAGE_USER
> > mappings trying to attack the kernel.
>
> But that's just the thing EFI is *NOT* trusted! We're basically
> disabling all security features (not listed above are CET and CFI) to
> run this random garbage we have no control over.
>
> How about we just flat out refuse EFI runtime services? What are they
> actually needed for? Why are we bending over backwards and subverting
> our security for this stuff?

On x86, it is mostly the EFI variable services that user space has
come to rely on, not only for setting the boot path (which typically
happens only once at installation time, when the path to GRUB is set
as the first boot option). Unfortunately, the systemd folks have taken
a liking to this feature too, and have started storing things in
there.

There is also PRM, which is much worse, as it permits devices in the
ACPI namespace to call firmware routines that are mapped privileged in
the OS address space in the same way. I objected to this at the time,
and asked for a facility where we could at least mark such code as
unprivileged (and run it as such) but this was ignored, as Intel and
MS had already sealed the deal and put this into production. This is
much worse than typical EFI routines, as the PRM code is ODM/OEM code
rather than something that comes from the upstream EFI implementation.
It is basically a dumping ground for code that used to run in SMM
because it was too ugly to run anywhere else. </rant>

It would be nice if we could

a) Get rid of SetVirtualAddressMap(), which is another insane hack
that should never have been supported on 64-bit systems. On arm64, we
no longer call it unless there is a specific need for it (some Ampere
Altra systems with buggy firmware will crash otherwise). On x86,
though, it might be tricky because there so much buggy firmware.
Perhaps we should phase it out by checking for the UEFI version, so
that future systems will avoid it. This would mean, however, that EFI
code remains in the low user address space, which may not be what you
want (unless we do c) perhaps?)

b) Run EFI runtime calls in a sandbox VM - there was a PoC implemented
for arm64 a couple of years ago, but it was very intrusive and the ARM
intern in question went on to do more satisyfing work.

c) Unmap the kernel KPTI style while the runtime calls are in
progress? This should be rather straight-forward, although it might
not help a lot as the code in question still runs privileged.

