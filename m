Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9F6658FC
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAKK0m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjAKK0k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:26:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C7102D
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09EB2B81B8D
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DC9C433F0
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432796;
        bh=fsbVnXfuGdOu17s2UnD/hsgUTD7us9JYo5HXvUCvqT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T5eY/HqBRWhg8Z9yIimOoH6FmBXs6PAxsrvxQJaEdsl9mz2G5mtWzXTBaJpWFHdmg
         X9XcQeLCfT+E9sqnwVd3HvT/voK28qi1mArHeCZLvkwjfaatVpRI99Tq6iQHz0FGNF
         o3WFBuul9mtLri9iEm+2AaFQy6Wmley8U/MKiXi7Zt8aCBpK+64p0Yl2Lrh67GgMto
         k1mFIEW6lgPxqQGUyoUn8TVPGQq/rbkeUwQNhtewD4oQalS56J2ch/jDTtK/IDoPdW
         h50YaCm+6Nu5y15wWN8thEr6GBIcKnZbSiGc6eOvGzmK6RqIBS+VzL2avijG8UxKZY
         pMHSJS/bgavaw==
Received: by mail-lf1-f45.google.com with SMTP id bq39so22859026lfb.0
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:26:36 -0800 (PST)
X-Gm-Message-State: AFqh2kphzMyAfTipw3OPQ3PGhtixqucBU3GrPYTOWoxHX+MR2E/yCP0a
        zM4ZpBAUSqeVtLbFYIcmooZx9b1XDSI9t5DglOg=
X-Google-Smtp-Source: AMrXdXsXo+qM+qTkarne7pRx4uyj7K7Dax5V2ZUDCdE2+V2LNSCuOOk0sKa6sFHEJl4oiD6gmeflJTA0ZN56tWYJhdM=
X-Received: by 2002:a05:6512:3d93:b0:4b8:9001:a694 with SMTP id
 k19-20020a0565123d9300b004b89001a694mr3457923lfv.426.1673432794734; Wed, 11
 Jan 2023 02:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20230111102236.1430401-1-ardb@kernel.org>
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Jan 2023 11:26:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE=3Osh4YCMVEyaERVVgJBuWCExekRQXi9rxx55294=0w@mail.gmail.com>
Message-ID: <CAMj1kXE=3Osh4YCMVEyaERVVgJBuWCExekRQXi9rxx55294=0w@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: Permit EFI boot with MMU and caches on
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 11 Jan 2023 at 11:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The purpose of this series is to remove any explicit cache maintenance
> for coherency during early boot. Software managed coherency is error
> prone and tedious, and running with the MMU off is generally bad for
> performance, and it becomes unnecessary if we simply retain the
> cacheable 1:1 mapping of all of system RAM provided by EFI, and use it
> to populate the initial ID map page tables. After setting up this
> preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
> TCR and SCTLR registers as before, and proceed as usual, avoiding the
> need for any manipulations of memory while the MMU and caches are off.
>

Forgot to mention: as it happens, patches #1 and #2 in this series
also work around a problem that was reported the other day, where the
allyesconfig build fails to link [0]

I bisected this to

commit 5e5ff73c2e5863f93fc5fd78d178cd8f2af12464
Author: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Date:   Mon Oct 17 20:04:50 2022 +0530

    asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info

which seems entirely unrelated, but looks like it may be causing the
number of direct calls (and therefore the number of trampolines) to
increase, causing the ID map to blow up like it does.

[0] https://lore.kernel.org/all/CAMj1kXGAf7ikEU5jLoik0xrOde0xBg0yJkOo5=PtEtNXoUxMXA@mail.gmail.com/



> The only properties of the firmware provided 1:1 map we rely on is that
> it does not require any explicit cache maintenance for coherency, and
> that it covers the entire memory footprint of the image, including the
> BSS and padding at the end - all else is under control of the kernel
> itself, as before.
>
> The final patch updates the EFI stub code so that it no longer disables
> the MMU and caches or cleans the entire image to the PoC. Note that
> some cache maintenace for I/D coherence may still be needed, in the
> zboot case (which decompresses and boots a compressed kernel image) or
> in cases where the image is moved in memory.
>
> Changes since v6:
> - drop the 64k alignment patch, which is not strictly a prerequisite,
>   and will be revisited later if needed
> - add back EFI stub changes now that all dependencies are in mainline
> - panic() the kernel later in the boot if we detected a non-EFI boot
>   occurring with the MMU and caches enabled
>
> Changes since v5:
> - add a special entry point into the boot sequence that is to be used by
>   EFI only, and only permit booting with the MMU enabled when using that
>   boot path;
> - omit the final patch that would need to go via the EFI tree in any
>   case - adding the new entrypoint specific for EFI makes it conflict
>   even more badly, and I'll try to revisit this during the merge window
>   or simply defer the final piece for the next release;
>
> Changes since v4:
> - add patch to align the callers of finalise_el2()
> - also clean HYP text to the PoC when booting at EL2 with the MMU on
> - add a warning and a taint when doing non-EFI boot with the MMU and
>   caches enabled
> - rebase onto zboot changes in efi/next - this means that patches #6 and
>   #7 will not apply onto arm64/for-next so a shared stable branch will
>   be needed if we want to queue this up for v6.2
>
> Changes since v3:
> - drop EFI_LOADER_CODE memory type patch that has been queued in the
>   mean time
> - rebased onto [partial] series that moves efi-entry.S into the libstub/
>   source directory
> - fixed a correctness issue in patch #2
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
>
> Ard Biesheuvel (6):
>   arm64: head: Move all finalise_el2 calls to after __enable_mmu
>   arm64: kernel: move identity map out of .text mapping
>   arm64: head: record the MMU state at primary entry
>   arm64: head: avoid cache invalidation when entering with the MMU on
>   arm64: head: Clean the ID map and the HYP text to the PoC if needed
>   efi: arm64: enter with MMU and caches enabled
>
>  arch/arm64/include/asm/efi.h               |  2 +
>  arch/arm64/kernel/head.S                   | 89 +++++++++++++++-----
>  arch/arm64/kernel/image-vars.h             |  5 +-
>  arch/arm64/kernel/setup.c                  | 17 +++-
>  arch/arm64/kernel/sleep.S                  |  6 +-
>  arch/arm64/kernel/vmlinux.lds.S            |  2 +-
>  arch/arm64/mm/cache.S                      |  1 +
>  arch/arm64/mm/proc.S                       |  2 -
>  drivers/firmware/efi/libstub/Makefile      |  4 +-
>  drivers/firmware/efi/libstub/arm64-entry.S | 67 ---------------
>  drivers/firmware/efi/libstub/arm64-stub.c  | 26 ++++--
>  drivers/firmware/efi/libstub/arm64.c       | 41 +++++++--
>  12 files changed, 151 insertions(+), 111 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
>
> --
> 2.39.0
>
