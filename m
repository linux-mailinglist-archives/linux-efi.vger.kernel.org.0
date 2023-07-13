Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118427523DF
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjGMNeK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjGMNeK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 09:34:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2061FEA
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 06:34:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fe70f21bso117700266b.3
        for <linux-efi@vger.kernel.org>; Thu, 13 Jul 2023 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689255244; x=1691847244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lni4UWIKw2Lp7DjCo96CHQnoSYyoodWrf2lKDIVVpbc=;
        b=BcfyuInp5jBxZzTvOSoWtOTxgq4kzMeUaI/Vi3ghXwRdt6V7XMYOeMvXYPrMT9YvpI
         wtpSuYNpSjbpK8KC8M+N8XpCKV1KC4XbB9FkTa4vZE6VbRQtGHzZjviZG43Lj9wCCpkZ
         J1HyRhUQU9dd9GeN50S3jHRYETSB8CavwaQuYkvTL4j+TXu9fqX0n6eoLpRFlrMWGcka
         3FkxTV6FIJDOzP8WqiFhgb6rguKq7veV5jLgnmAMOxaPMfeeTSbzQVlAy9jVNSBsfbiW
         bG3uLd7oErowpMqS69XE+Hd5ZYS+WcCsjr3P6wFlfFkg7s25zKhLVTg1RG5lf9VnjH5C
         S8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255244; x=1691847244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lni4UWIKw2Lp7DjCo96CHQnoSYyoodWrf2lKDIVVpbc=;
        b=kWrTnWi5u3mY4KZtOr1CGUT5BogejgD5QYPtSIvQ3q32/lJ0pvXcDuo6k7bbMJ2nLx
         d4E/bYuLdRR+8HGdHa3ZPnrZcbDgwd5g5ui69pItvt11N5Lfj3k0keBGCq5GIHBwa0/K
         MsoY93mtM5ewWu66ojpCG0lNvKmyNXW712ms5SJRxsdns7NRCwGEG10+hGH7rTqfeduG
         Gi8tGiCCZ+irTUwJh0FqKBhLCVHteK1HLV+AvVMejT5jn5tmkB4gfCPdK3mu+f4vuMwP
         o4+viRo2mYcAHIcGa+qiBUR/MlIZLejnms9zp8r5iqE/5t6++gRHuirtL/MgsC6QVJ01
         Nejg==
X-Gm-Message-State: ABy/qLbqx3BFD+Sn08z36QfhkoB71zYr6LP+6D9bxceYfXAsVnX2X0qO
        bHrLoGQSJPp9rmwZNm1gCh5unFoL1HWlApaKzQM=
X-Google-Smtp-Source: APBJJlGvrRWNt/FFlKe8uKPn1T37JqQamvuvd1xh9hAZXGrxTN6z2+pvgee7FNyh0NbM/6xJ+VJhvQ==
X-Received: by 2002:a17:906:20a:b0:982:487c:7508 with SMTP id 10-20020a170906020a00b00982487c7508mr1634168ejd.38.1689255244554;
        Thu, 13 Jul 2023 06:34:04 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([93.23.19.53])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906c20f00b00993017b64a8sm3982733ejz.224.2023.07.13.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:34:04 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 0/5] riscv: Introduce KASLR
Date:   Thu, 13 Jul 2023 15:33:56 +0200
Message-Id: <20230713133401.116506-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
  arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
  libstub: Fix compilation warning for rv32
  riscv: libstub: Implement KASLR by using generic functions

 arch/arm64/include/asm/efi.h                  |   4 +
 arch/riscv/Kconfig                            |  19 +++
 arch/riscv/include/asm/efi.h                  |   4 +
 arch/riscv/include/asm/page.h                 |   3 +
 arch/riscv/kernel/image-vars.h                |   1 +
 arch/riscv/kernel/pi/Makefile                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c          |  13 ++
 arch/riscv/kernel/pi/fdt_early.c              |  30 ++++
 arch/riscv/kernel/setup.c                     |  25 +++
 arch/riscv/mm/init.c                          |  36 +++-
 drivers/firmware/efi/libstub/Makefile         |   3 +-
 drivers/firmware/efi/libstub/arm64-stub.c     | 117 ++-----------
 drivers/firmware/efi/libstub/efi-stub-kaslr.c | 159 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  18 ++
 drivers/firmware/efi/libstub/riscv-stub.c     |  33 ++--
 15 files changed, 342 insertions(+), 125 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 drivers/firmware/efi/libstub/efi-stub-kaslr.c

-- 
2.39.2

