Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F39C77F7B8
	for <lists+linux-efi@lfdr.de>; Thu, 17 Aug 2023 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjHQN26 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Aug 2023 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbjHQN2q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Aug 2023 09:28:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F703AB5;
        Thu, 17 Aug 2023 06:28:00 -0700 (PDT)
X-QQ-mid: bizesmtp90t1692278826t9cqshyj
Received: from [10.20.8.85] ( [61.183.83.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 17 Aug 2023 21:27:02 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: uGhnJwy6xZLAahZlTopxqtR/Hd/ad1fA+6D6LUyZg6uSwgWzCyYXN2+qE91yG
        d2/G80ssVD5gvAxN4q1iHKG8u6qiveMy7Xl09gneHMfNXC6x3Nk/wlpH7e+w97DCNiFluZu
        F+Wr+cqnPp1/RWhx1V/WKDg6fjW7++o2KCQTwV91vORmlMLfRyTLQgnnCrXCfvt3SHZmKAR
        AH/TSikX5zynNeZE2XM2WMj0Oy3XPjBjgUqSe1Virm3DrqNEATnWHWZz4CzQiypJIo7cBYN
        O2PGYCIyZJP1EJ6err0pLIbll4qTWh47b+PgW2dOmtG66aFkMtZL/s9qSo3x1Wb7WYgUlIy
        8lLVQ3ySe7cK+23D0tLMLZ7BJDsNCBFw4DNlFNm
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16211832311926624224
Message-ID: <93D8412E2714688D+f87fdf42-4c77-ec81-c46f-30eda8ec44ee@tinylab.org>
Date:   Thu, 17 Aug 2023 21:27:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>, zong.li@sifive.com,
        conor.dooley@microchip.com
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <C172F31D25F5ED6E+034cc389-f02c-b681-a989-8592c5dac35e@tinylab.org>
 <CAHVXubhD2r2OYQKRcBUfA+3h4SdejkUhVDD2Gx6WJ6pqBzSKpw@mail.gmail.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAHVXubhD2r2OYQKRcBUfA+3h4SdejkUhVDD2Gx6WJ6pqBzSKpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2023/8/17 21:10, Alexandre Ghiti 写道:
> Hi Song,
> 
> On Tue, Aug 15, 2023 at 1:24 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>
>>
>> Hi, Alex:
>>
>> 在 2023/7/22 20:38, Alexandre Ghiti 写道:
>>> The following KASLR implementation allows to randomize the kernel mapping:
>>>
>>> - virtually: we expect the bootloader to provide a seed in the device-tree
>>> - physically: only implemented in the EFI stub, it relies on the firmware to
>>>     provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
>>>     hence the patch 3 factorizes KASLR related functions for riscv to take
>>>     advantage.
>>>
>>> The new virtual kernel location is limited by the early page table that only
>>> has one PUD and with the PMD alignment constraint, the kernel can only take
>>> < 512 positions.
>>>
>>
>> I have gone through the code and tested this series with RiscVVirt edk2.
>> All seems good to me, you can add :
>>
>> Tested-by: Song Shuai <songshuaishuai@tinylab.org>
>>
>> And a few questions about patch 2 ("riscv: Dump out kernel offset
>> information on panic"):
>>
>> 1. The dump_kernel_offset() function would output "Kernel Offset: 0x0
>> from 0xffffffff80000000" when booting with "nokaslr" option.
>>
>> How about disabling the registration of "kernel_offset_notifier" with
>> "nokaslr" option?
> 
> I'd rather keep it as it shows the "nokaslr" flag was taken into account.
> 
>>
>> 2. Inspired by patch 2, I added the Crash KASLR support based on this
>> series [1].
>> So is it necessary to keep this patch if we have Crash KASLR support?
> 
> I don't understand your question here

Crash can automatically calculate virt_offset by comparing the vmlinux 
and vmcore. If this patch is just intended to assist Crash in setting 
the "--kaslr offset," it might be deleted; if not just keep it. 	

> 
>>
>>
>> [1]:
>> https://lore.kernel.org/linux-riscv/20230815104800.705753-1-songshuaishuai@tinylab.org/T/#u
>>
>>> base-commit-tag: v6.5-rc1
>>>
>>> Changes in v6:
>>>     * Fix reintroduced build failures by compiling kaslr.c only for arm64
>>>       and riscv, as suggested by Ard
>>>
>>> Changes in v5:
>>>     * Renamed efi-stub-kaslr.c into kaslr.c and fix commit log of patch 3,
>>>       as suggested by Ard
>>>     * Removed stubs since the kaslr functions were moved to their own file
>>>       (and then does not trigger any build failure for architectures that do
>>>       not call those functions since they are in their own compilation unit)
>>>
>>> Changes in v4:
>>>     * Fix efi_get_kimg macro that returned nothing
>>>     * Moved new kaslr functions into their own files to avoid zboot link
>>>       failures, as suggested by Ard
>>>
>>> Changes in v3:
>>>     * Rebase on top of 6.4-rc2
>>>     * Make RANDOMIZE_BASE depend on 64bit
>>>     * Fix efi_icache_sync and efi_get_kimg_min_align which were undefined
>>>       in x86 (and certainly other archs)
>>>     * Add patch 4 to fix warning on rv32
>>>
>>> Changes in v2:
>>>     * Rebase on top of 6.3-rc1
>>>     * Add a riscv cache sync after memcpying the kernel
>>>     * Add kaslr_offset implementation for KCOV
>>>     * Add forward declaration to quiet LLVM
>>>
>>> Alexandre Ghiti (5):
>>>     riscv: Introduce virtual kernel mapping KASLR
>>>     riscv: Dump out kernel offset information on panic
>>>     arm64: libstub: Move KASLR handling functions to kaslr.c
>>>     libstub: Fix compilation warning for rv32
>>>     riscv: libstub: Implement KASLR by using generic functions
>>>
>>>    arch/arm64/include/asm/efi.h              |   2 +
>>>    arch/riscv/Kconfig                        |  19 +++
>>>    arch/riscv/include/asm/efi.h              |   2 +
>>>    arch/riscv/include/asm/page.h             |   3 +
>>>    arch/riscv/kernel/image-vars.h            |   1 +
>>>    arch/riscv/kernel/pi/Makefile             |   2 +-
>>>    arch/riscv/kernel/pi/cmdline_early.c      |  13 ++
>>>    arch/riscv/kernel/pi/fdt_early.c          |  30 ++++
>>>    arch/riscv/kernel/setup.c                 |  25 ++++
>>>    arch/riscv/mm/init.c                      |  36 ++++-
>>>    drivers/firmware/efi/libstub/Makefile     |   4 +-
>>>    drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
>>>    drivers/firmware/efi/libstub/efistub.h    |   8 ++
>>>    drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
>>>    drivers/firmware/efi/libstub/riscv-stub.c |  33 ++---
>>>    15 files changed, 328 insertions(+), 126 deletions(-)
>>>    create mode 100644 arch/riscv/kernel/pi/fdt_early.c
>>>    create mode 100644 drivers/firmware/efi/libstub/kaslr.c
>>>
>>
>> --
>> Thanks
>> Song Shuai
> 
> Thanks for testing this and your suggestions!
> 
> Alex
> 

-- 
Thanks
Song Shuai
