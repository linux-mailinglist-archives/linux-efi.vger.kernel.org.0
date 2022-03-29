Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444A24EA928
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiC2I2A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiC2I17 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 04:27:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D841F687A;
        Tue, 29 Mar 2022 01:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DF05B816AA;
        Tue, 29 Mar 2022 08:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27658C34116;
        Tue, 29 Mar 2022 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648542374;
        bh=P64VippWtoDYEoAYe0HzOfZq72o+3xuuZhXnLlrgXKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BA18187wrbX7cTMSQzq79snzwaUo5Js7LuiMhKNVQ6k43197XlTAEEmHP1wFoZDu0
         xgSbtGHYkLlsElFzREuGpVV41MsRkf9UO4KnD4yb+mhi4s+pQKLm/tHkH5OX8J4Y3s
         LhE1zzA1StHqs048cRNqQFjWwotM0hWVtz203rEFeNO9TWIXPAy0ZGiD4sR6vW0fre
         zNpl9VyoeUnzVObjnEylmYCN+BxgoqSeT/G1B5WEc/KsVF/H2UWyPhxU8KHAehKmwR
         ZMWQEyxDpAuuLCvkI7OR/mBGLVSoU2YMSFzngEOd+nVjCpjS1gSBcOOL9u3//Rz5Se
         LbhXNPvCBRhQg==
Received: by mail-oo1-f54.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so2973499oos.9;
        Tue, 29 Mar 2022 01:26:14 -0700 (PDT)
X-Gm-Message-State: AOAM531ydOwT4aefQ27l7KByL9ay665zkG/wOvfAwhPvlaOJPpNy6aED
        NNz6Fzt9E0cQ61IyuF2+kQx0/KzMUdqBlpQGQUg=
X-Google-Smtp-Source: ABdhPJwfGCMLk2VB7XvUDpERYxrxLHbFQsesq9dVB+yiEVlxuw1tERLeSRhYva8E1l8LXxwAun4JZTtR9hkxp93TpLU=
X-Received: by 2002:a4a:3391:0:b0:320:d78b:7957 with SMTP id
 q139-20020a4a3391000000b00320d78b7957mr561025ooq.60.1648542373173; Tue, 29
 Mar 2022 01:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220326064632.131637-1-mawupeng1@huawei.com>
In-Reply-To: <20220326064632.131637-1-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Mar 2022 10:26:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwzJE8V-tqJJwZ-RqHB3atKJvoRZ8C6_EVM7caNbttxw@mail.gmail.com>
Message-ID: <CAMj1kXEwzJE8V-tqJJwZ-RqHB3atKJvoRZ8C6_EVM7caNbttxw@mail.gmail.com>
Subject: Re: [PATCH 0/9] introduce mirrored memory support for arm64
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, hpa@zyccr.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, songmuchun@bytedance.com,
        macro@orcam.me.uk, Frederic Weisbecker <frederic@kernel.org>,
        W_Armin@gmx.de, John Garry <john.garry@huawei.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        chenhuacai@kernel.org, David Hildenbrand <david@redhat.com>,
        gpiccoli@igalia.com, Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-ia64@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 26 Mar 2022 at 07:27, Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> introduced mirrored memory support for x86. This support rely on UEFI to
> report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
>
>   http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
>
> Arm64 can support this too. So mirrored memory support is added to support
> arm64.
>

What is the point of this if the kernel itself is not loaded in
EFI_MORE_RELIABLE memory? On x86, this is handled by the decompressor,
but that does not exist on arm64.

The problem here is that UEFI defines this as a memory *attribute*
rather than a memory *type*, which means you cannot allocate
EFI_MORE_RELIABLE memory easily: you have to iterate over the memory
map and look for regions with the desired attribute, and allocate
those pages explicitly. I'd prefer to implement this in the
bootloader, and only add minimal logic to the stub to respect the
placement of the kernel by the loader if the loader signals it to do
so (there are other reasons for this - I will cc you on a patch
shortly that implements this)

This also means that the fake_mem stuff is not going to work: the
memory map observed by the stub comes straight from the firmware, and
if the stub needs to be involved in placing (or respecting the
placement by the loader of) the kernel image, it needs to observe
those EFI_MORE_RELIABLE regions too. If you don't have access to a
machine that actually exposes EFI_MORE_RELIABLE memory, I suggest you
prototype it in QEMU/edk2 instead.

In fact, we have been trying very hard not to touch the firmware
provided memory map at all on ARM, rather than use it as a scratchpad
for all kinds of annotations. This means, for instance, that kexec is
idempotent - the next kernel should not be affected by modifications
to the memory map applied by the previous kernel.

In summary, implementing kernelcore=mirror for arm64 is fine with me,
but there are some issues we need to address first.




> Patch #1-#2 introduce efi_fake_mem support for arm64.
> Patch #3-#4 introduce mirrored memory support form arm64.
> Patch #5-#7 fix some bugs for arm64 if memory reliable is enabled.
> Patch #8 disable mirror feature if kernelcore is not specified.
> Patch #9 remove some redundant code in ia64 efi_init.
>
> Ma Wupeng (9):
>   efi: Make efi_print_memmap() public
>   arm64: efi: Add fake memory support
>   efi: Make efi_find_mirror() public
>   arm64/mirror: arm64 enabling - find mirrored memory ranges
>   mm: Ratelimited mirrored memory related warning messages
>   mm: Demote warning message in vmemmap_verify() to debug level
>   mm: Calc the right pfn if page size is not 4K
>   efi: Disable mirror feature if kernelcore is not specified
>   ia64/efi: Code simplification in efi_init
>
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  arch/arm64/kernel/setup.c                     |  3 ++
>  arch/ia64/kernel/efi.c                        | 37 +-----------------
>  arch/x86/include/asm/efi.h                    |  5 ---
>  arch/x86/platform/efi/efi.c                   | 39 -------------------
>  drivers/firmware/efi/Kconfig                  |  2 +-
>  drivers/firmware/efi/efi.c                    | 26 +++++++++++++
>  drivers/firmware/efi/memmap.c                 | 16 ++++++++
>  include/linux/efi.h                           |  4 ++
>  include/linux/mm.h                            |  2 +
>  mm/memblock.c                                 |  4 +-
>  mm/page_alloc.c                               |  4 +-
>  mm/sparse-vmemmap.c                           |  2 +-
>  13 files changed, 60 insertions(+), 88 deletions(-)
>
> --
> 2.18.0.huawei.25
>
