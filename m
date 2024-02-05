Return-Path: <linux-efi+bounces-473-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05B8494BC
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57241C21510
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2D10A17;
	Mon,  5 Feb 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0GhAJkQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D610A0F;
	Mon,  5 Feb 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119237; cv=none; b=kjm3NdFFHs0pik8RtiITA9DGHjkBovB20yfBDVSThftetjeII8IGX7YTttEXaD7c9D6F1gkn8mnZlJFTuPOwerHmnhUIIGdAEwnpr16QP1zmc8OFAqZHCSu5MR5ApUrKxydEe9DI+T7ko6pLgMdTAQgBXmk3Gu6F9OTXc/1o9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119237; c=relaxed/simple;
	bh=SCWJBXw1oTKDsvcQutBEiqdDOJsJRN2Zly7jD9qJ6ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2XiC5NUiFzZTfURLMl8SVd7BVL/rbSr9JUp0skfsOQQ7lB3FzeyDtI9z7SjZ45l5zEHaXBoHwCrdUFvmE39VR8bckioQyDYG2T7rE8BQ3UN3lXqdI4fVAfMDtcqDrkCnZyVKgLCD4Ph6WIkliJTZtZ405o4vhgaZGLxwTjmuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0GhAJkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B0C43399;
	Mon,  5 Feb 2024 07:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707119236;
	bh=SCWJBXw1oTKDsvcQutBEiqdDOJsJRN2Zly7jD9qJ6ZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T0GhAJkQXt4uafhc+pThqoyJO6txYLDKJ5U6542K3xQ1R3An40ocU0z6g/+q0lVVn
	 4p+xvUPoMLau7jfAtqv385h1z9HZLIwWHUrD7U2UYJ1KCPkpOz9cCb8ffRIlUDz7HG
	 Dftfq12gFITiL0Vy9RwLWOnyfrronswAzXgM5lnppXbhI0JqTVHkNC1Xyws6gGAogK
	 Pk7rBVXS1L+TPrbg4OvnqFkWkko/saSxR65u9sygM8JlGHpzip4Z+Y7H/VNjByMsOe
	 iPnV3NzK2B34s+s+omRUVIOgBVh9I6GGqxL7Qs9GY4pQbNvR+tTrNUmFqi0c/h5yFs
	 DCiqmkL1cVfSw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510faac8c57so1919690e87.1;
        Sun, 04 Feb 2024 23:47:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yyph4vaqD3XEncTpbDn3VOXnypOe7MnwgUvX/uZdJY/A+ExsLIP
	Ttac+gap9hWuys4oK9gB1mMTupe2Pho0NPzyCCjZshjDdaJ36koHCxkNW9KCLIyzSWGqHT/cjk5
	AvY/NFifGHkzkzA8iRJFpwR+J3Yw=
X-Google-Smtp-Source: AGHT+IHeIvhbMvGh/vI5n12VkC4BC7Bs6UpxkWGwzl9rzz0JlqFFlJJnuDIZVJ+NI9RyheULWZLpa4m8L5xeC4o9Vdk=
X-Received: by 2002:a05:6512:1151:b0:511:5467:4fbc with SMTP id
 m17-20020a056512115100b0051154674fbcmr231223lfg.23.1707119234700; Sun, 04 Feb
 2024 23:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>
 <ZcBCiqOroolz1hoh@archie.me> <CAHzAAWQ2snWppQK_D3cSR6m35htVqM+4Su9f1JT9oWZ2A9Vznw@mail.gmail.com>
In-Reply-To: <CAHzAAWQ2snWppQK_D3cSR6m35htVqM+4Su9f1JT9oWZ2A9Vznw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 Feb 2024 08:47:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFyVKRg0DTTrZGPGfVPxqY5zsXbK+Sxp0GBid-msqe46w@mail.gmail.com>
Message-ID: <CAMj1kXFyVKRg0DTTrZGPGfVPxqY5zsXbK+Sxp0GBid-msqe46w@mail.gmail.com>
Subject: Re: Broken section alignment in 6.7 and 6.8rc EFI stub
To: Mike Beaton <mjsbeaton@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux EFI <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ivan Hu <ivan.hu@canonical.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 08:37, Mike Beaton <mjsbeaton@gmail.com> wrote:
>
> On Mon, 5 Feb 2024 at 02:06, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > So v6.7 onwards misses .reloc section, right?
> >
> > Confused...
>
> Reloc info is still present as normal in data directories, e.g.
> `llvm-objdump -p` shows NumberOfRvaAndSizes = 6. Reloc info is taken
> from index 5 https://github.com/tianocore/edk2/blob/master/MdePkg/Include/IndustryStandard/PeImage.h#L128
> . (I've been told a dummy .reloc section was dumped recently?)
>

So there are a couple of things going on here:
- the .reloc section was indeed dropped because we could not find any
evidence anywhere that the reason it was added is still valid;
- the .compat section uses a non-1:1 RVA mapping, to avoid padding,
but reading the PE/COFF spec again, I suppose this is not compliant.

Note that objdump looks broken too, on an image I have locally, I get

(llvm-readelf -a)

  Section {
    Number: 2
    Name: .compat (2E 63 6F 6D 70 61 74 00)
    VirtualSize: 0x8
    VirtualAddress: 0xB82000
    RawDataSize: 4096
    PointerToRawData: 0x4000

(objdump -h)

  1 .compat       00000008  0000000000b82000  0000000000b82000  00004000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

So the .compat section is in the correct spot in the file view but not
in the memory view.

Given that the .setup section is not relevant to EFI boot anyway, we
could try to use the same file mapping as the virtual mapping, and
just split the content preceding .text across the .setup and .compat
sections arbitrarily.

Could you try the below?


diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..f8b48ff86dd9 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,8 +106,7 @@ extra_header_fields:
        .word   0                               # MinorSubsystemVersion
        .long   0                               # Win32VersionValue

-       .long   setup_size + ZO__end + pecompat_vsize
-                                               # SizeOfImage
+       .long   setup_size + ZO__end            # SizeOfImage

        .long   salign                          # SizeOfHeaders
        .long   0                               # CheckSum
@@ -143,7 +142,7 @@ section_table:
        .ascii  ".setup"
        .byte   0
        .byte   0
-       .long   setup_size - salign             # VirtualSize
+       .long   pecompat_fstart  - salign       # VirtualSize
        .long   salign                          # VirtualAddress
        .long   pecompat_fstart - salign        # SizeOfRawData
        .long   salign                          # PointerToRawData
@@ -157,7 +156,7 @@ section_table:
        .asciz  ".compat"

        .long   8                               # VirtualSize
-       .long   setup_size + ZO__end            # VirtualAddress
+       .long   pecompat_fstart                 # VirtualAddress
        .long   pecompat_fsize                  # SizeOfRawData
        .long   pecompat_fstart                 # PointerToRawData

@@ -173,7 +172,6 @@ section_table:
         */
        .pushsection ".pecompat", "a", @progbits
        .balign falign
-       .set    pecompat_vsize, salign
        .globl  pecompat_fstart
 pecompat_fstart:
        .byte   0x1                             # Version
@@ -182,7 +180,6 @@ pecompat_fstart:
        .long   setup_size + ZO_efi32_pe_entry  # Entrypoint
        .popsection
 #else
-       .set    pecompat_vsize, 0
        .set    pecompat_fstart, setup_size
 #endif
        .ascii  ".text"

