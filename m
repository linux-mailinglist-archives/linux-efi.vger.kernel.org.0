Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C03FD477
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbhIAHfM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Sep 2021 03:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242556AbhIAHfM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 Sep 2021 03:35:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C65961059
        for <linux-efi@vger.kernel.org>; Wed,  1 Sep 2021 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630481656;
        bh=oS0sztXTdyAnYKsFS231FKzM6cAKbvmJzOU1lz0354A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jSWh8l8hD57uvMRvL3FQHfLI3Na4/Rc1t2eQshfNVRL40YThG5GOWmeOzickZzzvc
         wkT2Zrs56ANlwPgzvsFcFjnfSAAK+Pnen/Oi6GVYRkq2YWe7S5A1fLNNrh0IYNxV9e
         ttMJGCuYZ7bEHqjdvQHmvPG2+LoWy6uz5BM5QGf8pvESCsL7lQSP3NjFSAWmRLl7nk
         XFb+FufHYpEKdJn/BzfYP8OzpZy5j2vfWzYa1WUzvG9SPoqThbB+EYOoBvHPEseive
         FMX1NMvXpHEepuqpb1lCpMrS3M9ldX8It39yZJFmwc9NfZgGCcXiuebljuW5I5DZKk
         +KIpNGKryN5wQ==
Received: by mail-ot1-f44.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso2378361ota.8
        for <linux-efi@vger.kernel.org>; Wed, 01 Sep 2021 00:34:16 -0700 (PDT)
X-Gm-Message-State: AOAM5317HBhxDflHdhnFCoEbiF/3yWbTKH/Tv3DV+KrCXv7MbQLSo3qq
        7F1P6lBl2jkv2KfzBrNVJ/B8UvAe8x3m6WC//Cc=
X-Google-Smtp-Source: ABdhPJwyYpz6wiwheOaJNtkSp6rxe05CPBr0vkU5RD9+Q9uO4/HGFveHAru2nhuWrNQYE1d+dWXVzSUi+41kHcCEoCA=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr21123464ots.77.1630481655514;
 Wed, 01 Sep 2021 00:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFAniHs=a8d1t-3KxH8uGYmeCDKm8DOAb_HiRQNeehw6g@mail.gmail.com>
 <FD131CA7-415E-48D5-8BBD-F236AC6D4055@gmx.de> <5fafbb62-b93d-1f08-0e52-54b892f2ad30@northern.tech>
 <341cc376-540b-0c96-a2db-728cc276d983@gmx.de>
In-Reply-To: <341cc376-540b-0c96-a2db-728cc276d983@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Sep 2021 09:34:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuzW+yjgao2anrGFAqJ=G0RT8WMHKPxzzNURunQtseZg@mail.gmail.com>
Message-ID: <CAMj1kXFuzW+yjgao2anrGFAqJ=G0RT8WMHKPxzzNURunQtseZg@mail.gmail.com>
Subject: Re: Fwd: Re: [PATCH] efi_loader: Omit memory with "no-map" when
 returning memory map.
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-efi@vger.kernel.org,
        Kristian Amlie <kristian.amlie@northern.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Aug 2021 at 18:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> On 8/31/21 1:12 PM, Kristian Amlie wrote:
> > On 31/08/2021 12:46, Heinrich Schuchardt wrote:
> >>
> >>
> >> ------------------------------------------------------------------------
> >> *Von:* Ard Biesheuvel <ardb@kernel.org>
> >> *Gesendet:* 31. August 2021 12:33:56 MESZ
> >> *An:* Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> *CC:* Kristian Amlie <kristian.amlie@northern.tech>
> >> *Betreff:* Re: [PATCH] efi_loader: Omit memory with "no-map" when
> >> returning memory map.
> >>
> >> On Tue, 31 Aug 2021 at 08:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >>
> >>      On 8/27/21 9:55 AM, Kristian Amlie wrote:
> >>
> >>      You can use scripts/get_maintainer.pl to find the right addressees for
> >>      your patches.
> >>
> >>          efi_reserve_memory() states that memory marked with "no-map"
> >>          shall not
> >>          be accessed by the UEFI payload. Make sure efi_get_memory_map()
> >>          honors
> >>          this.
> >>
> >>
> >> Accessing memory and describing memory are two different things.
> >> Describing reserved memory in the memory map is important, because it
> >> helps us distinguish it from MMIO regions.
> >
> > Ok, my mistake, I thought the kernel would deduce this separately
> > through the DTB.
> >
> >>
> >>          This helps the case when booting vexpress_ca9x4 under QEMU. Because
> >>          the kernel wants to use an address in the lowest 128MiB of the
> >>          range,
> >>          but this range is reserved with "no-map", the kernel complains
> >>          that it
> >>          can not allocate the low memory it needs. In reality the actual
> >>          usable
> >>          memory starts much higher, which is reflected correctly in the
> >>          memory
> >>          map after this fix.
> >>
> >>
> >>
> >> This is a u-boot patch right? (I cannot tell from the context, as
> >> there are no mailing lists on cc)
> >>
> >> It is u-boot's job to describe all the memory, no matter how it is
> >> used. Even if the kernel itself may not use it as system memory, there
> >> are cases where kernel infrastructure is used to map these regions:
> >> for instance, the ACPI core may need to map a SystemMemory OpRegion,
> >> and we need the EFI memory map to tell us whether to use memory or I/O
> >> semantics.
> >>
> >> As for the 128 MB issue: can you reproduce this with a recent kernel?
> >> We made some changes recently to the EFI stub as well as the
> >> decompressor code to prevent the decompressor code from relocating
> >> itself to the base of DRAM, and to allow the decompressed kernel to
> >> reside at any 2 MB aligned offset in memory.
>
> This would allow putting the kernel at the very top of memory.

No, not at all. The way Linux/ARM defines its linear map is tied to
the placement of the kernel image, and any memory below it cannot be
used by the OS. IOW, placing the kernel at the very top of memory
would result in zero MB of lowmem being available, and therefore no
successful boot.

Formerly, the decompressor would simply round down the decompressor's
load address to 128 MB, and use the resulting value as the load
address of the decompressed kernel. This meant that
a) systems where the DRAM banks are not on a 128 MB boundary were
difficult to support
b) having reserved regions at the start of memory was problematic,
because the decompressor did not look at the device tree at all (this
is why we have all these TEXT_OFFSET hacks in the ARM kernel)
c) the EFI stub was forced to relocate itself into the first 128 MB of
memory, or the decompressor would misidentify the start of DRAM.

This has been fixed now: we can find the start of DRAM in the device
tree when necessary, but for EFI boot, we use the memory map to define
that kernel load address and pass it directly. This means we no longer
need to move the decompressor before invoking it
(d0f9ca9be11f25ef4151195eab7ea36d136084f6)

This uncovered another issue, though: the minimal relative alignment
of physical vs. virtual addresses was 16 MB, to ensure that the
PA-to-VA and vice versa routines worked correctly. So the tiniest
memory reservation at the start of DRAM would mean losing ~16 MB of
memory (given that DRAM below the kernel is not usable)

I fixed this in 9443076e4330a14ae2c6114307668b98a8293b77, and so now,
the kernel is loaded at the lowest available 2 MB boundary.

> But
> consider this function that misbehaves:
>
> arch/arm/include/asm/efi.h:
>
> 76 /* on ARM, the initrd should be loaded in a lowmem region */
> 77 static inline unsigned long efi_get_max_initrd_addr(unsigned long
> image_addr)
> 78 {
> 79         return round_down(image_addr, SZ_4M) + SZ_512M;
> 80 }
>
> 0x1F000000 = efi_get_max_initrd_addr(0xff000000);
>
> And below 0x1f000000 there may be no RAM at all.
>

Yeah, that function is broken in more ways than one: the 512 MB is an
approximation, but you could actually boot the kernel with a larger
vmalloc space, in which case the lowmem region could be smaller than
512 MB.

But patches are welcome to address the issue you identified: taking
the max() of (u64)(image_addr + SZ_512M) and ULONG_MAX should do the
trick, I suppose.
