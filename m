Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195584D7D95
	for <lists+linux-efi@lfdr.de>; Mon, 14 Mar 2022 09:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiCNI2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Mar 2022 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNI2L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Mar 2022 04:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518101C90D
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 01:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22326124F
        for <linux-efi@vger.kernel.org>; Mon, 14 Mar 2022 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92184C340E9;
        Mon, 14 Mar 2022 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647246421;
        bh=sIQV0KigsF9VL9HA872oOMHiHrPBTf/WVLidEKFWSVY=;
        h=From:To:Cc:Subject:Date:From;
        b=fIPRb/p1kTzJJeActzbh9oONBLA30qVDCvl+DplxY1iBvchQ8RueOILwhK/trL32A
         pPFuzc+6hJQ0lnfozJ5dpzKIozD2V+FOUBjRMKsZ5xFnMh8HCVaOMCn4KpkxoUPMCl
         fUjDPKfWnK0egEDYobtLtHi6oaw83hSlWc6fUNSz401e4ts2dSnqJR77WlsWPBgIha
         DzKl5pWwN+TrhtKEMczkzG+yD8JZouChf/YQM4w3qngXfY4DnkSbdr1+rpHD8Deh0l
         7mD/HQ5WK9XvzOH6hDBzYQHR0DMTnhH9zrHRTxis4PCNHRSxJ7PI1eytJtjlgqNXRC
         tFmNq8gNYh6kw==
From:   ardb@kernel.org
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH v0 0/6] Minimal Linux/arm64 VM firmware (written in Rust)
Date:   Mon, 14 Mar 2022 09:26:38 +0100
Message-Id: <20220314082644.3436071-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@google.com>

One of the tedious bits of booting a virtual machine under KVM on ARM is
dealing with guest memory coherency. This is due the fact that running
with the MMU off is problematic, as manipulations of memory by the guest
are incoherent with the host's cached view of memory. For this reason,
KVM needs to keep track of the MMU state of the guest, and perform cache
maintenance to the point of coherency (PoC) on all memory that is
exposed to the guest (and populated at stage 2) at that point.

Existing VM firmware is often based on bare metal firmware, which sets
up page tables with the MMU and caches off, and does the necessary (as
well as unnecessary *) cache maintenance to ensure that all
manipulations of memory performed with the MMU off are coherent, and not
covered by stale cachelines (either clean or dirty) that either obstruct
the view of the real memory contents, or are at risk of corrupting them
if such dirty cachelines are evicted and written back inadvertently.

As firmware is usually intimately tied to the memory topology of the
platform, we can do much better than this. Instead of setting up the
initial page tables at runtime, we can bake the into the boot image,
provided that it runs at an a priori known address. This means we can
enable MMU and caches straight out of reset, and defer all memory
accesses that go via the D side until after.

This is the approach taken by this series: it implements a minimal
firmware/bootloader for booting a Linux arm64 kernel on QEMU's
mach-virt, which does minimal code execution and no memory access (other
than instruction fetching) with the MMU disabled. Combined with the
series that I sent out recently [0] for Linux, which implements
something similar for the kernel itself, virtually all cache maintenance
to the PoC can be dropped from the boot flow (with the exception of the
.idmap page in the kernel itself). Given that no stores to memory occur
at all with the MMU off, KVM should be able to detect that the PoC
maintenance is no longer necessary when the MMU is turned on.

This is not only a simplification in itself, it also means that minimal
code execution occurs while restricted memory permissions are being
honoured: the firmware boots with WXN protections enabled, and the Rust
code itself as well as the text section of the loaded kernel Image need
to be mapped with read-only permissions in order to execute them.

This prototype is presented as v0, as it cuts some corners, while the
intent is to make this an implementation of EFI that provides all that
Linux needs to boot. Most notably,

- only ~900 MiB of DRAM is supported, due to the fact that the page
  table code I nicked greedily maps down to pages, and the heap is only
  around 2 MiB, so we run out of memory if we try to map more.

- it boots via the kernel's 'bare metal' entrypoint as EFI features are
  entirely missing for the moment.

- only uncompressed kernels are supported

How to build and run:

(first, build a kernel with [0] applied, so the image tolerates being
booted with MMU and caches enabled)

$ cargo build  # using a nightly Rust compiler

$ objcopy -O binary target/aarch64-unknown-linux-gnu/debug/efilite efilite.bin

$ qemu-system-aarch64 \
    -M virt,gic-version=host -cpu host -enable-kvm -smp 4 \
    -net none -nographic -m 900m -bios efilite.bin -kernel path/to/Image \
    -drive if=virtio,file=path/to/hda.xxx,format=xxx -append root=/dev/vda2

* U-Boot in particular carries a lot of set/way cache maintenance that
  was cargo culted from the v7 days, and should never be needed in VM

[0] https://lore.kernel.org/all/20220304175657.2744400-1-ardb@kernel.org/

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (6):
  Implement a bare metal Rust runtime on top of QEMU's mach-virt
  Add DTB processing
  Add paging code to manage the full ID map
  Discover QEMU fwcfg device and use it to load the kernel
  Remap code section of loaded kernel and boot it
  Temporarily pass the kaslr seed via register X1

 .cargo/config    |   5 +
 .gitignore       |   2 +
 Cargo.lock       |  87 ++++
 Cargo.toml       |  12 +
 efilite.lds      |  62 +++
 src/cmo.rs       |  37 ++
 src/console.rs   |  57 +++
 src/cstring.rs   |   9 +
 src/fwcfg.rs     |  85 ++++
 src/head.S       | 121 +++++
 src/main.rs      | 155 +++++-
 src/pagealloc.rs |  44 ++
 src/paging.rs    | 499 ++++++++++++++++++++
 src/pecoff.rs    |  23 +
 src/ttable.S     |  37 ++
 15 files changed, 1233 insertions(+), 2 deletions(-)
 create mode 100644 .cargo/config
 create mode 100644 Cargo.lock
 create mode 100644 efilite.lds
 create mode 100644 src/cmo.rs
 create mode 100644 src/console.rs
 create mode 100644 src/cstring.rs
 create mode 100644 src/fwcfg.rs
 create mode 100644 src/head.S
 create mode 100644 src/pagealloc.rs
 create mode 100644 src/paging.rs
 create mode 100644 src/pecoff.rs
 create mode 100644 src/ttable.S

-- 
2.30.2

