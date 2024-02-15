Return-Path: <linux-efi+bounces-559-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90065855E6B
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449AB2814E2
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86922324;
	Thu, 15 Feb 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daxxJb+O"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3B21A1C;
	Thu, 15 Feb 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990131; cv=none; b=Ona1/5Lp8Dz8lk70jptBTgl40jinTqXrlG0SAAxLF6y3tSUZGCL2EYyLB9r8IqqlC82lF4n+ze/5jUhTGLq/rBR/oH9HJmItbnOxCE3Dq1oopdZ7WTbkyf820RwZb/hElkpdZbm9t5NgjgAGlp0wGB3efeJu46aA+F1F9SnXXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990131; c=relaxed/simple;
	bh=ayhN2E3UsNs6uEXn4dK9YxLU7rzCSxc1XU8EwcHkYsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGmL8avmeUJP/FaJsGY9pXrCo4xKGNPuZxqwiTM7q9mHGMSQVoc/Jlp2/ggwQMIVz+5ppIsxyywS+MVk+kPc2WLZdGJthe5J4snqVSikxPDKblYPzWf4w2IPAfCsk8+8LuhgklzXanajK5cffF7LMLcSD0VkN10zfvG+UAn3fNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daxxJb+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6525C433A6;
	Thu, 15 Feb 2024 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707990130;
	bh=ayhN2E3UsNs6uEXn4dK9YxLU7rzCSxc1XU8EwcHkYsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=daxxJb+OeK0fGyL/hBn4SBIY1t5TSa85o/kzg5n9MXh16gATqKNmFkCcW8wfbBd0l
	 DIzmb1KjBCkpJZQ7IPzUGC/yQzBETG7mrtVlpWHR8Zi49L0ufPEV+MalucC7LE3sKu
	 W/0YNxRGnd6ThMZatqq8a44Mpo+MWpqSwiZEzwEM1RwJIEZ2gb3JjTocGFf/ePcCM9
	 Vy6au3YywBdHfXrGdjmkaWQTt+217ZYLq4Lm0k5HBuTlR/wy23U0rJ6wGujX66Nc/X
	 G8XJtSPbHa9tQLC2uRYlElikkbW4HrFEKfMMxh/eTjJKGQXAGujYW47r593VFumHLS
	 8Y/5AdhQ2R97g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1080cba75so6928431fa.0;
        Thu, 15 Feb 2024 01:42:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcDyAD9BsEE+7NrFU4IaJgoz+ieDxlUv3e4w0bjSrtEx4kJgxsxmp/hUCcIhBz8Nbx08+pyoTqgZD31WCEPDiT42RNj74ODVDJ
X-Gm-Message-State: AOJu0Yx4jUsNMeETzKnY3ucWerHECzD3eLV0vYQNIg2FV5LviwIQV/rz
	1pKIFqV9eeAc8k8aPAlZD4GW0q1veSh9GzMlMQ8psQDYS8BxsyemgB4hpgfypM1nxYfhaJ9OZZa
	7OM61z7Y5J+s7epl9ZRI2MpQdmT8=
X-Google-Smtp-Source: AGHT+IHICT7XsU9MX6iai7uH6/h0d1Dcec6ibvQD7gHqZtPuZhe55g/xvvMm4sV44kYr3JMk84qPQetelTHpaXQSqnw=
X-Received: by 2002:a2e:be0d:0:b0:2d0:d282:3fdc with SMTP id
 z13-20020a2ebe0d000000b002d0d2823fdcmr512683ljq.2.1707990128798; Thu, 15 Feb
 2024 01:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
 <2024021552-bats-tabby-a00b@gregkh>
In-Reply-To: <2024021552-bats-tabby-a00b@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 10:41:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHVMDq670JhAwsYeGjYVVfgCxFC7YUChUF1GSerCUB1ow@mail.gmail.com>
Message-ID: <CAMj1kXHVMDq670JhAwsYeGjYVVfgCxFC7YUChUF1GSerCUB1ow@mail.gmail.com>
Subject: Re: x86 efistub stable backports for v6.6
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, 
	jan.setjeeilers@oracle.com, Peter Jones <pjones@redhat.com>, 
	Steve McIntyre <steve@einval.com>, Julian Andres Klode <julian.klode@canonical.com>, 
	Luca Boccassi <bluca@debian.org>, James Bottomley <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> > (cc stakeholders from various distros - apologies if I missed anyone)
> >
> > Please consider the patches below for backporting to the linux-6.6.y
> > stable tree.
> >
> > These are prerequisites for building a signed x86 efistub kernel image
> > that complies with the tightened UEFI boot requirements imposed by
> > MicroSoft, and this is the condition under which it is willing to sign
> > future Linux secure boot shim builds with its 3rd party CA
> > certificate. (Such builds must enforce a strict separation between
> > executable and writable code, among other things)
> >
> > The patches apply cleanly onto 6.6.17 (-rc2), resulting in a defconfig
> > build that boots as expected under OVMF/KVM.
> >
> > 5f51c5d0e905 x86/efi: Drop EFI stub .bss from .data section
> > 7e50262229fa x86/efi: Disregard setup header of loaded image
> > bfab35f552ab x86/efi: Drop alignment flags from PE section headers
> > 768171d7ebbc x86/boot: Remove the 'bugger off' message
> > 8eace5b35556 x86/boot: Omit compression buffer from PE/COFF image
> > memory footprint
> > 7448e8e5d15a x86/boot: Drop redundant code setting the root device
> > b618d31f112b x86/boot: Drop references to startup_64
> > 2e765c02dcbf x86/boot: Grab kernel_info offset from zoffset header directly
> > eac956345f99 x86/boot: Set EFI handover offset directly in header asm
> > 093ab258e3fb x86/boot: Define setup size in linker script
> > aeb92067f6ae x86/boot: Derive file size from _edata symbol
> > efa089e63b56 x86/boot: Construct PE/COFF .text section from assembler
> > fa5750521e0a x86/boot: Drop PE/COFF .reloc section
> > 34951f3c28bd x86/boot: Split off PE/COFF .data section
> > 3e3eabe26dc8 x86/boot: Increase section and file alignment to 4k/512
> >
> > 1ad55cecf22f x86/efistub: Use 1:1 file:memory mapping for PE/COFF
> > .compat section
>
> Is the list here the order in which they should be applied in?
>

Yes. These are all from v6.7 except the last one, but that has been
queued for v6.7 already.

> And is this not an issue for 6.1.y as well?
>

It is, but there are many more changes that would need to go into v6.1:

 Documentation/x86/boot.rst                     |   2 +-
 arch/x86/Kconfig                               |  17 +
 arch/x86/boot/Makefile                         |   2 +-
 arch/x86/boot/compressed/Makefile              |  13 +-
 arch/x86/boot/compressed/efi_mixed.S           | 328 ++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S        | 195 --------
 arch/x86/boot/compressed/head_32.S             |  38 +-
 arch/x86/boot/compressed/head_64.S             | 593 +++++--------------------
 arch/x86/boot/compressed/mem_encrypt.S         | 152 ++++++-
 arch/x86/boot/compressed/misc.c                |  61 ++-
 arch/x86/boot/compressed/misc.h                |   2 -
 arch/x86/boot/compressed/pgtable.h             |  10 +-
 arch/x86/boot/compressed/pgtable_64.c          |  87 ++--
 arch/x86/boot/compressed/sev.c                 | 112 +++--
 arch/x86/boot/compressed/vmlinux.lds.S         |   6 +-
 arch/x86/boot/header.S                         | 215 ++++-----
 arch/x86/boot/setup.ld                         |  14 +-
 arch/x86/boot/tools/build.c                    | 271 +----------
 arch/x86/include/asm/boot.h                    |   8 +
 arch/x86/include/asm/efi.h                     |  14 +-
 arch/x86/include/asm/sev.h                     |   7 +
 drivers/firmware/efi/libstub/Makefile          |   8 +-
 drivers/firmware/efi/libstub/alignedmem.c      |   5 +-
 drivers/firmware/efi/libstub/arm64-stub.c      |   6 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
 drivers/firmware/efi/libstub/efistub.h         |  28 +-
 drivers/firmware/efi/libstub/mem.c             |   3 +-
 drivers/firmware/efi/libstub/randomalloc.c     |  13 +-
 drivers/firmware/efi/libstub/x86-5lvl.c        |  95 ++++
 drivers/firmware/efi/libstub/x86-stub.c        | 327 +++++++-------
 drivers/firmware/efi/libstub/x86-stub.h        |  17 +
 include/linux/efi.h                            |   1 +
 32 files changed, 1204 insertions(+), 1448 deletions(-)

(Note: the commit hashes below are bogus, they are from my tree [0])

If you're happy to take these too, I can give you the proper list, but
perhaps we should deal with v6.6 first?

9d2df639ec41 x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
4dae7beb5530 x86/boot/compressed: Move 32-bit entrypoint code into .text section
8b6ddf82c1e7 x86/boot/compressed: Move bootargs parsing out of 32-bit
startup code
31d3e51c565f x86/boot/compressed: Move efi32_pe_entry into .text section
4099d7a76e86 x86/boot/compressed: Move efi32_entry out of head_64.S
7bed86e158bf x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
d808c48f53d1 x86/boot/compressed, efi: Merge multiple definitions of
image_offset into one
bb183fa754f7 x86/boot/compressed: Simplify IDT/GDT preserve/restore in
the EFI thunk
b78d930f51c9 x86/boot/compressed: Avoid touching ECX in
startup32_set_idt_entry()
8c69f96fe1df x86/boot/compressed: Pull global variable reference into
startup32_load_idt()
6b84fc96784b x86/boot/compressed: Move startup32_load_idt() into .text section
6dd53426e8ef x86/boot/compressed: Move startup32_load_idt() out of head_64.S
82db0efabd4a x86/boot/compressed: Move startup32_check_sev_cbit() into .text
7aaa10f2f01a x86/boot/compressed: Move startup32_check_sev_cbit() out
of head_64.S
6b5a2ab4d783 x86/boot/compressed: Adhere to calling convention in
get_sev_encryption_bit()
bdd9c458fdf8 x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
a249efa7500c efi/libstub: Add memory attribute protocol definitions
1bbd66011e5e x86/efi: Make the deprecated EFI handover protocol optional
763512bf9ff8 x86/boot: Robustify calling startup_{32,64}() from the
decompressor code
3cfd94f97c8d x86/efistub: Branch straight to kernel entry point from C code
2684d78d8bdc x86/efistub: Simplify and clean up handover entry code
9ef61120b2ab x86/decompressor: Avoid magic offsets for EFI handover entrypoint
067f18102a11 x86/efistub: Clear BSS in EFI handover protocol entrypoint
c674fa468fa6 x86/decompressor: Store boot_params pointer in callee save register
ed871fc7d947 x86/decompressor: Assign paging related global variables earlier
63915dd5a8fc x86/decompressor: Call trampoline as a normal function
3f6e9fe794ea x86/decompressor: Use standard calling convention for trampoline
eef60ef496f6 x86/decompressor: Avoid the need for a stack in the
32-bit trampoline
1f328cfb5700 x86/decompressor: Call trampoline directly from C code
49e67636077d x86/decompressor: Only call the trampoline when changing
paging levels
a4b6bdff1065 x86/decompressor: Pass pgtable address to trampoline directly
fe802898e7a4 x86/decompressor: Merge trampoline cleanup with switching code
bd1fd32fdce1 x86/efistub: Perform 4/5 level paging switch from the stub
a0bfe7904515 x86/decompressor: Move global symbol references to C code
a0731d919a4b x86/decompressor: Factor out kernel decompression and relocation
402e20d21f65 x86/efistub: Prefer EFI memory attributes protocol over
DXE services
4eda5ae9b321 efi: libstub: use EFI_LOADER_CODE region when moving the
kernel in memory
e09c5817b3bb efi/libstub: Add limit argument to efi_random_alloc()
b31fdf98b3c0 x86/efistub: Perform SNP feature test while running in the firmware
03c9bd02cbc8 x86/efistub: Avoid legacy decompressor when doing EFI boot

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-efi-peheader-backport

