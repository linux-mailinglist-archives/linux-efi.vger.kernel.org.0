Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF875C05B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjGUHsz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jul 2023 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGUHsz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jul 2023 03:48:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203CC11D
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:48:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3159da54e95so1205267f8f.3
        for <linux-efi@vger.kernel.org>; Fri, 21 Jul 2023 00:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689925732; x=1690530532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJbdqgE6rPWGrAZXEIoITNtpmirnzN+6ReuxV7VdPDA=;
        b=ywqx+S8KXdN+x47WQ8bW/Vt7y1IB4iO5NYQjHEyDmpo1l+kaRgvYx62RP/ED+PUrvO
         C2kB4hWtz8WBrNtGPpydotxs2lswkc4rsr1xjSCBJgHSql+j2Jagt/mM9JNUA4iB1dfl
         0Ad8bjNTWVyk6hECaIycphKHCKbmxWegRQw0KrSQ8lfgcLAyYyOb9EHOG+x3TERl3yG+
         6NN8FfsSCvu87pzHhFDsSEuzHEzwbuRlbi9Seyoz9cgJCMSbEOpOsoY16oBFCkGlh3JB
         3Y+muD0TAVZnnIF57+SeO9A3hJb4xf2p7azfDADOxuDh4OS7Gr8a6JByym8URxj7i7Jd
         koxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925732; x=1690530532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJbdqgE6rPWGrAZXEIoITNtpmirnzN+6ReuxV7VdPDA=;
        b=DdPTDhA4vh3jUQc/OqCwMxcPqZle2STTZM9t8cR5ppBoVnFCRn011fSjLxmwg0h9J/
         OM+E9bD0ePfSaG6bKF43oRuaMWQvQJ3nyKbhsyol0kDugox1IwDkbRyVRuOt4KBXdZua
         lO9FJzTWcjVtc/0rXW9TOGO2sU6RPfFaMYMuXnjrcVWpeUCtsH2BjLwGS0ZsqkXT6DsB
         SHpWYQ6hVV+pbtk3s5e23XTguQAqiTbDQmk1+RcE1/vjRZiVjtTW074y6ENgCA0Xal8O
         OxOFkro3L4iPX7MyC+WDhmMPXhzJwszMXqw2rc/qJWxhP29NmymrHUywDYZ3Tws7KFDf
         yuDg==
X-Gm-Message-State: ABy/qLbymePQe/zJ75DFndzc1Zi+EXETNhVn12dkHT4OupRypN90aCzP
        TsaRuq1w5sfFf2dfGOaU6tsPQQ==
X-Google-Smtp-Source: APBJJlE3FlxkcRT8Ksq53OMvhBnx7QbuDFYS9BKGqdSdR+S1yqatJDbL5rDW6LmpyFmfglyjTESmlg==
X-Received: by 2002:adf:dccf:0:b0:313:fce9:c568 with SMTP id x15-20020adfdccf000000b00313fce9c568mr841802wrm.31.1689925732461;
        Fri, 21 Jul 2023 00:48:52 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b003143cdc5949sm3457710wrs.9.2023.07.21.00.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:48:52 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 0/5] riscv: Introduce KASLR
Date:   Fri, 21 Jul 2023 09:48:45 +0200
Message-Id: <20230721074850.310644-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/efi/libstub/Makefile     |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
 drivers/firmware/efi/libstub/efistub.h    |   8 ++
 drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c |  33 ++---
 15 files changed, 328 insertions(+), 125 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 drivers/firmware/efi/libstub/kaslr.c

-- 
2.39.2

