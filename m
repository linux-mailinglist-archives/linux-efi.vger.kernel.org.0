Return-Path: <linux-efi+bounces-3135-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CBBA7672E
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86CB167D48
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6700212B0C;
	Mon, 31 Mar 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwuco2tM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB3211A3C
	for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429340; cv=none; b=Me16xrOWhTRGfvi72o6u4ZM7WJPXZSsZHp7Ka8UexqRp4fEeI/uOAZuUxLgioQpanSTzx6tE9qi56zfmAtsZq2nsoTjkJs203QrEmWVl2VeKYQUO1zwJoarrjVnyK0QRaWLqm8DsaZRNEByXYkHsyMgZ/azgzWUuPxSoU000aI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429340; c=relaxed/simple;
	bh=PZcPYzDgKlasM7M5ULjVvoRUDdglTCy5kSysnckWNcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f85JPxKDiyJaMMKn9FpOVhRw35rm/AHNGQ/dWDcy0U/OXuv7jPxCxQPwfHfXvB0Aj+nsZNRKBwk7pdp9tvhYdw1fgucOf+BNFAqYnFrtY3Ph49lo2AB13MfCmB+/VjIhy7Bjt7dyKVt8xCvYV/Hf8eyMiAKkMt0KfwhXeh5Trzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwuco2tM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37248C4CEE3
	for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743429340;
	bh=PZcPYzDgKlasM7M5ULjVvoRUDdglTCy5kSysnckWNcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jwuco2tMfy/B/DsP0swF3ht+YrO1oGVoHcqGNKHanXns/8iJV2WuK7GEazA/EtfgM
	 1mCPwowEW+2jCMaGR6h20UyqdQWrtsQCphoT8vIgAUwJlK09JcLkXEiiBtM4FcRcOk
	 K7xBrMG73YSVBZFbqfggThDhc/f9xB/uWLUDaFXdgng3kpWIvcfUBLz0h0feDswpAA
	 XGLlqnEC3djx5GdIX+nikSUxQx9uiy9LaxeVErZQaUmIEBXJkZFFy7/srXuHZDDKYB
	 686kpGe+QAt1otGF8hus2wX6AMF1/udrImQF80R8ufCQNCmsGqDnSLcpP1mLw1atvT
	 UWdnxib2YoFQw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30db3f3c907so43098311fa.1
        for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 06:55:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjKq30fN4NxB/eBCVQXWcm6e/cx9au5UMxF3rXGkvV3rue+72+TSTqVf8Q9QBQ/KUk9V3o8rbp7Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYo3f+RDAJYzbWgXFgrSLAKO5n8oztVSBDu3Q8+B2OJ7FDNWDI
	ESQ4HhcYKDSFjmgc1vsJFZZKnsaY8GRuZUQMTtR8170GTOmHLesdBtd3u6Xock6wsW16PerUxAE
	Iv7fvS9U2vy9LMk5htNE2zklw1x4=
X-Google-Smtp-Source: AGHT+IEiP9ieoq+Yk97yfkSlVMBC2QdBMBj1qqKwZImdS8dO3N8O/qTlYA0dmd8YcnN2Dq+WKC1Z6yWL4aPf47KaH4Q=
X-Received: by 2002:a2e:9fcb:0:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-30de030102amr33108881fa.32.1743429338515; Mon, 31 Mar 2025
 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com> <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com> <Z-j8b7Z5oja05cCI@gmail.com>
In-Reply-To: <Z-j8b7Z5oja05cCI@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 31 Mar 2025 15:55:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
X-Gm-Features: AQ5f1JryfSF8DmfT67uvBGyUzSCTx6V082ApgZpUsKmdWyqURZv6_gM1h-D2qEs
Message-ID: <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 10:10, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > (cc Ingo)
> >
> > On Sat, 29 Mar 2025 at 19:46, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, 28 Mar 2025 at 00:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> > > >
> > > >  arch/x86/boot/compressed/efi_mixed.S               | 341 ---------------------
> > > >  drivers/firmware/efi/libstub/x86-mixed.S           | 253 +++++++++++++++
> > >
> > > I've pulled this, but I'm not super-happy about it.
> > >
> > > We have been pretty successful in keeping assembler files in the
> > > arch/ directory, and I really think we should strive to continue
> > > that.
> > >
> > > Do we have a few drivers that have arch-specific assembly code?
> > > Yes. But it certainly isn't something to make more common.
> > >
> > > And did we already do that zboot-header.S thing earlier? Also yes,
> > > but that one is afaik actually architecture-neutral and doesn't
> > > have any architecture *instructions* in it, it's just data layout
> > > afaik (and no, I don't know why it was done as a '*.S' file)
> > >
> > > IOW, I really wish you would move this back to arch/x86 somewhere.
> > > Please?
> > >
> >
> > Fair enough. Note that this applies to la57toggle.S as well, which
> > was moved in a patch that went via the -tip tree this cycle.
> >
> > It doesn't matter that much where the files live, as long as they are
> > disentangled from the traditional decompressor. (For C files, it is
> > important that they are built using the EFI stub's C flags, but for
> > asm files, that makes little difference)
> >
> > Does arch/x86/lib sound like a reasonable place?
>
> So all of this is boot code (early EFI runtime calls), right? Please
> move anything fundamentally low level boot related to arch/x86/boot/.
> We can open up arch/x86/boot/efi/ or so, to decouple it from the
> decompressor.
>

As you surely remember, one of the other issues I am trying to solve
is the use of C code in the early startup code of the kernel proper
that needs to tolerate being executed from the 1:1 mapping of RAM
(i.e., all the C files that use RIP_REL_REF() currently). This is
mainly related to SEV-SNP and 5-level paging.

So there is code that
- is conceptually part of the EFI stub but written in asm (x86-mixed.S)
- is shared between the EFI stub and the decompressor (la57toggle.S)
- is conceptually part of the EFI stub but shares code with the
decompressor (handling of unaccepted memory when populating the e820
memory map from the EFI one)
- is split between the decompressor/EFI stub and kernel proper
(SME/SEV-SNP initialization)
- is only needed by the decompressor (SEV-SNP handling of 'demand
paging' logic and TDX/SEV acceptance of memory that was just carved
out based on the e820 map rather than allocated via the EFI APIs)
- early startup code in the kernel proper that creates the (4 or 5
level) kernel virtual mapping while executing from the 1:1 mapping.

IOW, absolute chaos.

I have been trying to disentangle this from the EFI side, but the
5-level paging and SEV-SNP/TDX code clearly needs some attention too.

What the C code has in common here is that it needs to be built in a
special way, i.e., PIC codegen with all instrumentation/paravirt/etc
disabled. And ideally, each object needs to be checked to ensure that
no absolute relocations are present.

So what I would like to propose for this arch/x86/boot/<something>
subdirectory is to move all these source files there, and build a
static library that can be pulled into the kernel proper as well as
the decompressor, using C flags etc that ensure that all code it
contains is safe for execution from the 1:1 mapping. This is how the
EFI stub static library is built, and also how the code in
arch/arm64/kernel/pi/ is constructed to ensure that it can safely run
from a virtual mapping that doesn't match the one the linker used at
build time.

How does that sound?

