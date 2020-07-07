Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6D2167BD
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jul 2020 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgGGHt1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jul 2020 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGHt1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jul 2020 03:49:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE0C08C5DB
        for <linux-efi@vger.kernel.org>; Tue,  7 Jul 2020 00:49:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so44018624wrj.13
        for <linux-efi@vger.kernel.org>; Tue, 07 Jul 2020 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2pxDDruVdpBNY9voLxLtSz3gp0J3oInIn5OFSK9v7g=;
        b=V3vv2b8DJqkujHE5W2g3BcOMuRt5leIZZWQUW3BHOHP1VckBulL2Fm1CwWk4h41NHl
         egiQb2Ue5kiZbmrUvSGb4Bsp8Ek2B4waU04kdX2/WD3lkRw+vDHRrYyCwtXPtMTQ6ao0
         PuoL6aqk2JIGEauVZ4sKcrjoKN+ts+OrlOZKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2pxDDruVdpBNY9voLxLtSz3gp0J3oInIn5OFSK9v7g=;
        b=mgnutHS/Pl8MmcZSRv+n5GzVd8hYCp25+nW6RCEuNvJTlsVeJr04wQH1RykkVtt07E
         z8CTqV8NPc18NtC9kg4VIB6rK80R8LxtkKMiGv3NdOmIq7Nhl7Khcf1n58VsIfV6GKKD
         aJtCxunbVLbV7u7Za69nHwlHArVFQ/tdT04npyMYKK69EH9xUXfpxShN3s98MNPJO1Vh
         pe0l6pt3Sq1e5pAECDhY8veIdfCuKTgrHPuyn5pRTbmaiZDMPrmRguTvBG9gltJfUetG
         zqBuJWIJEXVrdFGzBcKrIKBv9wGZ4zerR2ebAwToHP3o4Uq+3rzCMV71PkW/5rVNHqEr
         UXNg==
X-Gm-Message-State: AOAM531yuQt2bRiyxzHxiZqW4LXa9RTkmLIQ4SiMn4M4odD+EAa3WWrj
        /hbmHmrLHqpHZDk549MYdRkCiSbQuZ96TEQU8P3t
X-Google-Smtp-Source: ABdhPJwUXpEEyZQIUtPjkA0NYrN6lp6EdSH5wb8/o1vki+kpP1ntbxG1+7hdZ7llctZAshRg7/imXdwmlN3KVsN6CCI=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr51080157wrv.162.1594108165570;
 Tue, 07 Jul 2020 00:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200706172609.25965-1-atish.patra@wdc.com> <CAMj1kXG5OxRod_-Z5K55XLXDda2ahfezm0yaRbv=82JmrFRZxw@mail.gmail.com>
In-Reply-To: <CAMj1kXG5OxRod_-Z5K55XLXDda2ahfezm0yaRbv=82JmrFRZxw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 7 Jul 2020 00:49:14 -0700
Message-ID: <CAOnJCU+PzfTGiJc5hegU72+z_RJErO=avYV9dz1zB3zH8_Yzow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Add UEFI support for RISC-V
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 6, 2020 at 11:41 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 6 Jul 2020 at 20:26, Atish Patra <atish.patra@wdc.com> wrote:
> >
> > This series adds UEFI support for RISC-V.
> >
> > Linux kernel: 5.8-rc4
> > U-Boot: master
> > OpenSBI: master
> >
> > Patch 1-6 are preparatory patches that fixes some of the geric efi and riscv issues.
> >
> > Patch 7-9 adds the efi stub support for RISC-V which was reviewed few months back.
> > https://www.spinics.net/lists/linux-efi/msg19144.html
> >
> > Patch 10 just renames arm-init code so that it can be used across different
> > architectures. Patch 11 adds the runtime services for RISC-V.
> >
> > The patches can also be found in following git repo.
> > https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v2
> >
> > The patches have been verified on Qemu using bootefi command in U-Boot for both
> > RV32 and RV64.
> >
> > For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
> > beyond 1G of physical memory for RV32.
> >
> > EDK2 can boot quite far into Linux with current series. Currently, we are seeing
> > some traps from drivers (spi/network). At first glance, they don't seem to be
> > caused by efi. I thought it is better to get some early feedback on the series
> > while EDK2 issue is being debugged.
> >
> > That's why uefi runtime services are not actually well tested in RISC-V.
> > Any suggestions to test the efi run time services are appreciated.
> >
> > Changes from v1->v2:
> > 1. Removed patch 1 as it is already taken into efi-tree.
> > 2. Fixed compilation issues with patch 9.
> > 3. Moved few function prototype declaration to header file to keep kbuild happy.
> >
> > Changes from previous version:
> > 1. Added full ioremap support.
> > 2. Added efi runtime services support.
> > 3. Fixes mm issues
> >
>
> Hi Atish,
>
> This all looks reasonable to me, so I think we can merge this once you
> can confirm that the runtime services actually work.
>

Blibbet pointed me towards the Firmware Test Suite (FWTS). I will try
to use that to verify basic runtime services
in addition to EDK2 testing (Abner is debugging that).

> Could you explain how you are dealing with the memory map? Are memory
> nodes in DT ignored entirely as they should be?

Yes. That is handled by the generic code (patch 10 renames arm-init to
efi-init) in the following path.
setup_arch->efi_init->reserve_regions()

What about memory
> reservations?
>

I added patches in U-Boot that parses the /reserved-memory nodes from
DT and add it to the efi reserved mappings.
As a result, Linux kernel takes care of memory reservations as per the
reserved memory regions present in efi memory map.
I am expecting EDK2 already does that as well.

Here is the relevant boot log:
----------------------------------------------------------------------------------------------------------------------
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000

[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')

[    0.000000] printk: bootconsole [sbi0] enabled

[    0.000000] efi: Getting UEFI parameters from /chosen in DT:

[    0.000000] efi:   System Table         : 0x00000000bff61528

[    0.000000] efi:   MemMap Address       : 0x00000000bd46e020

[    0.000000] efi:   MemMap Size          : 0x00000000000002d0

[    0.000000] efi:   MemMap Desc. Size    : 0x0000000000000028

[    0.000000] efi:   MemMap Desc. Version : 0x0000000000000001

[    0.000000] efi: EFI v2.80 by Das U-Boot

[    0.000000] efi: RTPROP=0xbe73c020 SMBIOS=0xbe736000 MEMRESERVE=0xbd671020

[    0.000000] memblock_reserve:
[0x00000000bd671020-0x00000000bd67102f]
efi_config_parse_tables+0x192/0x1e6

[    0.000000] efi: Processing EFI memory map:

[    0.000000] MEMBLOCK configuration:

[    0.000000]  memory size = 0x000000003fe00000 reserved size =
0x0000000000000010

[    0.000000]  memory.cnt  = 0x1

[    0.000000]  memory[0x0] [0x0000000080200000-0x00000000bfffffff],
0x000000003fe00000 bytes flags: 0x0

[    0.000000]  reserved.cnt  = 0x1

[    0.000000]  reserved[0x0] [0x00000000bd671020-0x00000000bd67102f],
0x0000000000000010 bytes flags: 0x0

[    0.000000] memblock_remove:
[0x0000000000000000-0xfffffffffffffffe] reserve_regions+0x56/0x134

[    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] OF: fdt: Ignoring memory block 0x80000000 - 0x80040000

[    0.000000] efi:   0x000080040000-0x0000801fffff [Conventional
Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] OF: fdt: Ignoring memory range 0x80040000 - 0x80200000

[    0.000000] memblock_add: [0x0000000080200000-0x00000000801fffff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x000080200000-0x0000812befff [Loader Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x0000000080200000-0x00000000812befff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000812bf000-0x000087efffff [Conventional
Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000812bf000-0x0000000087efffff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x000087f00000-0x000087f04fff [ACPI Reclaim
Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x0000000087f00000-0x0000000087f04fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] memblock_reserve:
[0x0000000087f00000-0x0000000087f04fff] reserve_regions+0x110/0x134

[    0.000000] efi:   0x000087f05000-0x0000bd46dfff [Conventional
Memory|   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x0000000087f05000-0x00000000bd46dfff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000bd46e000-0x0000bd672fff [Loader Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000bd46e000-0x00000000bd672fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000bd673000-0x0000be731fff [Loader Code
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000bd673000-0x00000000be731fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be732000-0x0000be734fff [Reserved
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be732000-0x00000000be734fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be735000-0x0000be735fff [Boot Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be735000-0x00000000be735fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be736000-0x0000be736fff [Runtime Data
 |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be736000-0x00000000be736fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be737000-0x0000be738fff [Boot Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be737000-0x00000000be738fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be739000-0x0000be739fff [Reserved
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be739000-0x00000000be739fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be73a000-0x0000be73bfff [Boot Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be73a000-0x00000000be73bfff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be73c000-0x0000be73dfff [Runtime Data
 |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be73c000-0x00000000be73dfff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000be73e000-0x0000bff60fff [Loader Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000be73e000-0x00000000bff60fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000bff61000-0x0000bff61fff [Runtime Code
 |RUN|  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000bff61000-0x00000000bff61fff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] efi:   0x0000bff62000-0x0000bfffffff [Loader Data
 |   |  |  |  |  |  |  |  |   |WB|  |  |  ]

[    0.000000] memblock_add: [0x00000000bff62000-0x00000000bfffffff]
early_init_dt_add_memory_arch+0xac/0xbc

[    0.000000] memblock_reserve:
[0x00000000bd46e000-0x00000000bd46efff] efi_init+0x132/0x1e6

[    0.000000] memblock_reserve:
[0x0000000080200000-0x00000000812befff] setup_bootmem+0x98/0x1d0

[    0.000000] initrd not found or empty - disabling initrd

[    0.000000] memblock_reserve:
[0x0000000080233000-0x00000000802348f7]
early_init_dt_reserve_memory_arch+0x14/0x1c

[    0.000000] memblock_reserve:
[0x0000000080000000-0x000000008003ffff]
early_init_dt_reserve_memory_arch+0x14/0x1c

[    0.000000] MEMBLOCK configuration:

[    0.000000]  memory size = 0x000000003fe00000 reserved size =
0x0000000001105010

[    0.000000]  memory.cnt  = 0xb

[    0.000000]  memory[0x0] [0x0000000080200000-0x00000000be731fff],
0x000000003e532000 bytes flags: 0x0

[    0.000000]  memory[0x1] [0x00000000be732000-0x00000000be734fff],
0x0000000000003000 bytes flags: 0x4

[    0.000000]  memory[0x2] [0x00000000be735000-0x00000000be735fff],
0x0000000000001000 bytes flags: 0x0

[    0.000000]  memory[0x3] [0x00000000be736000-0x00000000be736fff],
0x0000000000001000 bytes flags: 0x4

[    0.000000]  memory[0x4] [0x00000000be737000-0x00000000be738fff],
0x0000000000002000 bytes flags: 0x0

[    0.000000]  memory[0x5] [0x00000000be739000-0x00000000be739fff],
0x0000000000001000 bytes flags: 0x4

[    0.000000]  memory[0x6] [0x00000000be73a000-0x00000000be73bfff],
0x0000000000002000 bytes flags: 0x0

[    0.000000]  memory[0x7] [0x00000000be73c000-0x00000000be73dfff],
0x0000000000002000 bytes flags: 0x4

[    0.000000]  memory[0x8] [0x00000000be73e000-0x00000000bff60fff],
0x0000000001823000 bytes flags: 0x0

[    0.000000]  memory[0x9] [0x00000000bff61000-0x00000000bff61fff],
0x0000000000001000 bytes flags: 0x4

[    0.000000]  memory[0xa] [0x00000000bff62000-0x00000000bfffffff],
0x000000000009e000 bytes flags: 0x0

[    0.000000]  reserved.cnt  = 0x5

[    0.000000]  reserved[0x0] [0x0000000080000000-0x000000008003ffff],
0x0000000000040000 bytes flags: 0x0

[    0.000000]  reserved[0x1] [0x0000000080200000-0x00000000812befff],
0x00000000010bf000 bytes flags: 0x0

[    0.000000]  reserved[0x2] [0x0000000087f00000-0x0000000087f04fff],
0x0000000000005000 bytes flags: 0x0

[    0.000000]  reserved[0x3] [0x00000000bd46e000-0x00000000bd46efff],
0x0000000000001000 bytes flags: 0x0

[    0.000000]  reserved[0x4] [0x00000000bd671020-0x00000000bd67102f],
0x0000000000000010 bytes flags: 0x0

----------------------------------------------------------------------------------------------------------------------

Here is the detailed boot log.

https://pastebin.com/4LE2SY4c

> In any case, I will take the first patch as a fix, so it should turn
> up in mainline in 1~2 weeks.
>
Thanks.

> Thanks,
> Ard.



-- 
Regards,
Atish
