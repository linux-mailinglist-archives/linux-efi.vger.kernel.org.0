Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3B75DC96
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jul 2023 14:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGVMjA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jul 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGVMjA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jul 2023 08:39:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1310F4
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:38:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fd2f298712so1470255e9.2
        for <linux-efi@vger.kernel.org>; Sat, 22 Jul 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690029537; x=1690634337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIcbmkTWrDX+Xt/TeGVAtAWUbcdO9qSHs2vQ/hQkz24=;
        b=oNMMTqvReu3FlM4cY7VjMXRIDFVljKhFHKgnZsZXMmUbnZmy0NmZpngBD8NxM0U1KI
         /VT2jSQ2Nuggw8us79pz9ML+gplT+vhgZTDGtrVWMgK+OWNbRQRLhPCJlkARcwua8oDk
         s5qds2Q3gubIUSGrbjXph/jC1wCr2529VHrO4b29IH5Qlub4NOg1LF0IDfx/dB6/TWug
         j5i62gXKv0q3zvrnf00wU3VpUME0wK4z/d/GGuKEJcm9o1Zitjv8nrhGwwT4Lm6uAyp3
         PPQvEsNBGbORCuH8Pj5GlkIfb8CR/ozwHaKXgen9DkQnsL++0NlC/wQ3BkkmcdyPumpN
         1OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029537; x=1690634337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIcbmkTWrDX+Xt/TeGVAtAWUbcdO9qSHs2vQ/hQkz24=;
        b=NlrtX/RSivTAJqMWWNgHaltYce3y6WRC75ntkyETs75DZj24pgPs3MD3AftfZAU6g5
         AMGhNbTKSjTpG3tA6Imnj43OqaHwTeH/B5/0KrRB8XTSU1SDI6NPKV/7jyfI9GXb0ALS
         fpsLidJJan5TORmzVOC6a2SoU3WAc8niBWXYiovnC6Int8FgHJMb4kmyEWeX9SO+FZJ/
         Je/J72uqL5YMlkjzG+HqlXTYeojJQIvxeui+xSyuqrpu5H4negJVbYlJvG9cvVB3hYns
         G9M1ps5gD1BRftMGS7Tfd6tokHA+ODu9UjcZgBo2j1fGTnTRUzxX5wv108nq8dMXELeL
         u0Yw==
X-Gm-Message-State: ABy/qLZjHpwuvorNyQJcMOic7O9RJwvP0JC15E99t/c0DIL1rYn1hYih
        ntOYItl3qs/u2+ECNFVz8HnrxQ==
X-Google-Smtp-Source: APBJJlE3kySORHNjliNzyk1d7E4WKUQ/vw6BhiZyXSU1YW0ZRPEhMV+8g/ko07f1CDM0Jua0EmTMHQ==
X-Received: by 2002:adf:e307:0:b0:309:1532:8287 with SMTP id b7-20020adfe307000000b0030915328287mr2745943wrj.19.1690029537140;
        Sat, 22 Jul 2023 05:38:57 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d5508000000b0030fb4b55c13sm6819378wrv.96.2023.07.22.05.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:38:56 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 0/5] riscv: Introduce KASLR
Date:   Sat, 22 Jul 2023 14:38:45 +0200
Message-Id: <20230722123850.634544-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following KASLR implementation allows to randomize the kernel mapping:

- virtually: we expect the bootloader to provide a seed in the device-tree
- physically: only implemented in the EFI stub, it relies on the firmware to
  provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementation
  hence the patch 3 factorizes KASLR related functions for riscv to take
  advantage.

The new virtual kernel location is limited by the early page table that only
has one PUD and with the PMD alignment constraint, the kernel can only take
< 512 positions.

base-commit-tag: v6.5-rc1

Changes in v6:
  * Fix reintroduced build failures by compiling kaslr.c only for arm64
    and riscv, as suggested by Ard

Changes in v5:
  * Renamed efi-stub-kaslr.c into kaslr.c and fix commit log of patch 3,
    as suggested by Ard
  * Removed stubs since the kaslr functions were moved to their own file
    (and then does not trigger any build failure for architectures that do
    not call those functions since they are in their own compilation unit)

Changes in v4:
  * Fix efi_get_kimg macro that returned nothing
  * Moved new kaslr functions into their own files to avoid zboot link
    failures, as suggested by Ard

Changes in v3:
  * Rebase on top of 6.4-rc2
  * Make RANDOMIZE_BASE depend on 64bit
  * Fix efi_icache_sync and efi_get_kimg_min_align which were undefined
    in x86 (and certainly other archs)
  * Add patch 4 to fix warning on rv32

Changes in v2:
  * Rebase on top of 6.3-rc1
  * Add a riscv cache sync after memcpying the kernel
  * Add kaslr_offset implementation for KCOV
  * Add forward declaration to quiet LLVM

Alexandre Ghiti (5):
  riscv: Introduce virtual kernel mapping KASLR
  riscv: Dump out kernel offset information on panic
  arm64: libstub: Move KASLR handling functions to kaslr.c
  libstub: Fix compilation warning for rv32
  riscv: libstub: Implement KASLR by using generic functions

 arch/arm64/include/asm/efi.h              |   2 +
 arch/riscv/Kconfig                        |  19 +++
 arch/riscv/include/asm/efi.h              |   2 +
 arch/riscv/include/asm/page.h             |   3 +
 arch/riscv/kernel/image-vars.h            |   1 +
 arch/riscv/kernel/pi/Makefile             |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c      |  13 ++
 arch/riscv/kernel/pi/fdt_early.c          |  30 ++++
 arch/riscv/kernel/setup.c                 |  25 ++++
 arch/riscv/mm/init.c                      |  36 ++++-
 drivers/firmware/efi/libstub/Makefile     |   4 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
 drivers/firmware/efi/libstub/efistub.h    |   8 ++
 drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c |  33 ++---
 15 files changed, 328 insertions(+), 126 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 drivers/firmware/efi/libstub/kaslr.c

-- 
2.39.2

