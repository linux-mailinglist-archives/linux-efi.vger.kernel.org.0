Return-Path: <linux-efi+bounces-2918-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69FA56659
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464851886106
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17D212B3E;
	Fri,  7 Mar 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3tWT9Rv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492520ADF8;
	Fri,  7 Mar 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345954; cv=none; b=Z+glu4+Md4gyrO5N5wvSsIaL0ZDQA8yDH+wp63g+0YMkUtkpbFPgDzouC720RiuszUdF/2MWVB3HLyY2RsBnroUHpwga1V8lH0x0ywpsaKn5tQRaoneXO/WTeh0WsnL2IG92Jmmb+l2FqApZtMyvQx+sTbG1MUs8xF3NlJkCSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345954; c=relaxed/simple;
	bh=QQPfrFS+SCpq2wFbeD26vshWziprh8gVH/CTN9M2hqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjYpfpJ6vL1sz0tasCca1BEqFDZ7i/K5584Q7dqJ1++bbEt/7w7URQ8ddyXhUJrMoPQcYRneR5k6PU0I+DW941JCWXMaKO7/gI9aTKLHOheAC/RaXW90jFqxMDJNs17cDEBAWTlLOcvlrNlVAZMgqPOUAKbYfVpejxMP4nRLI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3tWT9Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF821C4CEE7;
	Fri,  7 Mar 2025 11:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741345953;
	bh=QQPfrFS+SCpq2wFbeD26vshWziprh8gVH/CTN9M2hqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R3tWT9RvhO5aABZsCfuWYZTeXdxa7hzw7wMnOx/xIUA1ISFFwpIIV4dE5ut8APD2M
	 NKvPKIS4Vrcy0XQG8gY2aiNrZ7pU3rfP/q/kKwFm7MgTMQfHj32t4X9DlYPToa+Z9f
	 hG7hwAw0Cx2u7OWiz3SXhwFD15Biqf4AoJgGFnFIHLU5HrHiAB7+FKfcC9Gq6hKfkR
	 X1H9eodLeN4bGJI1V+cd9Xolw4v41OjM0vFxJOKcVo/OKqDG1c/+yRZNFX7pXLKrvt
	 BY8DKjRKI324Y5ytGt4ljpMktKurXLB7P9g3KViNuWiGW3XZDHTGZYGdbQ9Bpod86I
	 mKI1/HTFNHLuA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so1722664e87.1;
        Fri, 07 Mar 2025 03:12:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3loC3rjOr+zRxD+A9XxJwA4gbBzFPqUVHFTYxsusPWL8FqpTniDBVR9A7654rHgHGO0AV5cHh+r4=@vger.kernel.org, AJvYcCUDn+fp9pxzOnBJ/lY2z7Ew6/NK5PbDr9/h0HRkQtgOOXcqvinXdFRTfVkT757nGUfq85gyalBcm04fhnkz@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQZCAq5Q1rRujpgxVybnDYqWCDf9ZsLBW+ln4+F14tlQoyenF
	1mQjul+Te06TRgpYpGH3tgRQ+zsQqc1pPYWXwJvFF/HF1bOc2sCSed/vUtzsA/CUJhwRPBrVYsG
	GA2KymlDB9P90TLpUAnECBI3I0vg=
X-Google-Smtp-Source: AGHT+IGz2keQpxdU5kFb3I2MVj+AhwbE03XOVWNSII7p0/JNGnrwxV3zou5xCVeBVlYVI3nMk+EZ79tpPEF3FaieudQ=
X-Received: by 2002:a05:6512:281b:b0:548:91f6:4328 with SMTP id
 2adb3069b0e04-54990e5e041mr1118510e87.15.1741345952152; Fri, 07 Mar 2025
 03:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305101744.1706803-1-vkuznets@redhat.com>
In-Reply-To: <20250305101744.1706803-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Mar 2025 12:12:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
X-Gm-Features: AQ5f1JqpQPkEQ7sfHFY_GThRf2lD7EZxy3KX3uCeIhAZPx7I1AgNVVsFqzNVO2Q
Message-ID: <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vitaly,

Thanks for the elaborate writeup


On Wed, 5 Mar 2025 at 11:18, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
> by introducing a generation-based technique. Compromised or vulnerable UEFI
> binaries can be prevented from booting by bumping the minimal required
> generation for the specific component in the bootloader. More information
> on the SBAT can be obtained here:
>
> https://github.com/rhboot/shim/blob/main/SBAT.md
>
> Previously, an attempt was made to add ".sbat" section to the linux kernel:
>
> https://lwn.net/Articles/938422/
>
> The approach was rejected mainly because currently there's no policy on how
> to update SBAT generation number when a new vulnerability is discovered. In
> particular, it is unclear what to do with stable kernels which may or may
> not backport certain patches making it impossible to describe the current
> state with a simple number.
>
> This patch suggests a different approach: instead of defining SBAT
> information, provide a mechanism for downstream kernel builders (distros)
> to include their own SBAT data.

Why does this require a mechanism in the upstream kernel at all?
Signing the kernel (which includes appending a cert table) does not
require such changes, so why is this needed when adding an additional
PE/COFF section?

> This leaves the decision on the policy to
> the distro vendors. Basically, each distro implementing SecureBoot today,
> will have an option to inject their own SBAT data during kernel build and
> before it gets signed by their SecureBoot CA. Different distro do not need
> to agree on the common SBAT component names or generation numbers as each
> distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
> upstream will never, ever need to care about the data unless they choose in
> the future to participate in that way.
>

I'm sure this paragraph will make some skeptics happy.

> Currently, shim checks .sbat data for itself in self-test and for second
> stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
> revocations require cycling signing keys or adding kernel hashes to shim's
> internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
> will allow us to do the same tracking and revocation distros are already
> doing with a simplified mechanism, and without having to keep lists of
> kernels outside of the git repos.
>
> Finding a place for SBAT section turned out to be a bit tricky. Current
> PE layout looks like this:
>
> - without CONFIG_EFI_MIXED:
>   +-----------------------------------+-------------------------------+
>   | setup            [setup_signature]| compressed text | data [crc32]|
>   +-----------------------------------+-----------------+-------------+
>
> - with CONFIG_EFI_MIXED:
>   +-------+---------------------------+----------------+-------------+
>   | setup | pecompat [setup_signature]| compressed text| data [crc32]|
>   +-------+---------------------------+----------------+-------------+
>
> Limitations are:
> - To avoid problems with signatures, all sections must be 4k aligned with
>   no gaps between them.
> - CRC32 must be at the end of the file.

We never cared about the CRC32 before with signed EFI images, which
gets clobbered when the image is signed. Why should we start caring
about it now?

> - Nothing can be put before 'setup'.
> - Nothing can be squeezed between [setup_signature] and compressed text.
> - The whole 'setup' (everything before '.text') must fit into 8 4k pages.
>
> Note: .pecompat contains only 8 bytes of useful data but to save the space,
> the tail from .setup including [setup_signature] is also added to it (see
> commit 1ad55cecf22f ("x86/efistub: Use 1:1 file:memory mapping for PE/COFF
> .compat section")).
>
> With the limitations, there are three straightforward options:
> - Put .sbat between .setup and .pecompat. Advantage: with normal sized
> SBAT, kernel grows by 1 page only. Disadvantage: this one page comes from
> the precious '8 pages' limit.
>
> - Put .sbat to the very end of the file. Advantage: no need to touch
> 'setup'. Disadvantage: two pages are now needed as we don't want to make
> CRC32 part of the SBAT section.
>
> - Put .sbat between '.text' and '.data'. Advantages: no need to touch
> 'setup' and CRC32. 'CONFIG_EFI_MIXED' case doesn't seem to make much
> difference either.
>
> Implement the last one as it doesn't seem to have obvious disadvantages.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> RFC part:
> - General acceptance of the idea.
> - .sbat section placement.
>
> The implementation is done for x86 only at this moment but I think it
> shouldn't be that hard to extend it to other arches (and I hope the
> solution for those which use common zboot mechanism will be the same).

Please don't create a special case for x86 again - iff this needs to
be in upstream (which I am not convinced about) it needs to be
implemented for all architectures.

So I'd like to understand better what is preventing you from appending
a PE/COFF section on an arbitrary bzImage (or EFI zboot image).

Given an arbitrary PE/COFF image, I see

  Section {
    Number: 4
    Name: .data (2E 64 61 74 61 00 00 00)
    VirtualSize: 0x47000
    VirtualAddress: 0x934000
    RawDataSize: 4608
    PointerToRawData: 0x934000
    PointerToRelocations: 0x0
    PointerToLineNumbers: 0x0
    RelocationCount: 0
    LineNumberCount: 0
    Characteristics [ (0xC0000040)
      IMAGE_SCN_CNT_INITIALIZED_DATA (0x40)
      IMAGE_SCN_MEM_READ (0x40000000)
      IMAGE_SCN_MEM_WRITE (0x80000000)
    ]

as the last section. There should be sufficient space in the header to
add an additional section descriptor.

So what is preventing us from just appending the SBAT data to the
file, and creating a 5th section that lives right after .data both in
the file view (at 0x934000 + 4608) and in the memory view (0x934000 +
0x47000). That should produce a valid PE/COFF image, no?

