Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6526697EBB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBOOvX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBOOvW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 09:51:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0C392AA
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:51:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so19433898wru.2
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctWJSElYx/FpQ+Il/jr6fw9xbpiBuK2KMIX0fff726o=;
        b=GLyffEPMYlT/cmqtzo2hfct/e9+r4hBtyDtRC0QOsgxl5uG2zZYS2aCeBLUuFLsLqo
         8+EWhE3A1okDf4bDVnsCqQh0zxTcTgI3IgDy3ipTGvN5RnxzX5bgBRFJ0Vj5GFgyKzQ+
         wt8YZ2u0Imx2utyxu9hadRnNSm0/IAzax1OHpC5qcF7/RoD3qznLt+K6ps/tHRTi2Jnb
         piFePO8J/H/acKIh43ArzCYPygQ9tUbRj7rz3nDujjJEhM2YvC5y3L4VDSAtKs6HERy6
         X2lnmKW9ak0eHD5b5b+67yNd4M4yCK7/yIO6dLFdEuI00JPlYwg/UgxhH7hOpj+2NrM6
         aYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctWJSElYx/FpQ+Il/jr6fw9xbpiBuK2KMIX0fff726o=;
        b=TfOWoo3CYWI+kpdk48GSdZfoqkLOu/tQOt0rKGcnpTxnOdzUlcPVaF+lkZkt0iIKno
         tXRN3P6q4Dre+pyFn06PlbPquYbfUmBCUDZdjKNsu4MWGciVVW1UQTKc5jE/dozOLAWB
         RQesOFGKtLU7S+Nu6QAWh5OQcT+r70lEcVtBBVOCE1O4CGrYTNyLpq6lfeXCzniy/Lep
         fHyDa4cjiGaLB+145B3Q6j69rn6Dlw1/Tt9evVpT6JbwEIzZoPwLLFWrvCU5cJxDLX01
         qApu/1QmqmKYIhci7sRV4svvG0oieXalPPV5nlUWkIINpK/4z5mz/1rTXMEqb2rWlngE
         mJCQ==
X-Gm-Message-State: AO0yUKX5rK1LQf9c07qVkIvxNHsbova2wHXxeJxWdmSqt+1INMOkdu9n
        8ujPVAx7lLWfGxKcROKp7YxrOQ==
X-Google-Smtp-Source: AK7set+Nq5t/4Q7aVf6eQyb5vxlI9IEku3M0RuLvSxT47U9GMbWRMLO9/X1s/whi16YDzCCafZULdA==
X-Received: by 2002:adf:ecca:0:b0:2c5:5943:27e5 with SMTP id s10-20020adfecca000000b002c5594327e5mr1877958wro.15.1676472676157;
        Wed, 15 Feb 2023 06:51:16 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b002c54e89fcadsm11022524wrh.55.2023.02.15.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:51:15 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/4] riscv: Introduce KASLR
Date:   Wed, 15 Feb 2023 15:51:09 +0100
Message-Id: <20230215145113.465558-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Note that the patch "riscv: Use PUD/P4D/PGD pages for the linear
mapping" is necessary to retrieve the memory below the physical kernel
address, so that the EFI stub does not have to try to relocate the kernel
as close as possible to the start of dram.

This patchset is rebased on top of:

Introduce 64b relocatable kernel (https://lore.kernel.org/lkml/20230215143626.453491-1-alexghiti@rivosinc.com/)
RISC-V kasan rework (https://lore.kernel.org/lkml/Y6TTvku%2FyuSjm42j@spud/T/)
riscv: Use PUD/P4D/PGD pages for the linear mapping (https://lore.kernel.org/lkml/20230125114229.hrhsyw4aegrnmoau@orel/T/)
riscv: Allow to downgrade paging mode from the command line (https://lore.kernel.org/lkml/CAHVXubjeSMvfTPnvrnYRupOGx6+vUvUGfRS3piTeo=TH2cHKNg@mail.gmail.com/)
base-commit-tag: v6.2-rc7

This patchset was tested with u-boot boottime service for the seed on:
- ubuntu defconfig + kasan outline (sv39, sv48, sv57): OK
- ubuntu defconfig + kasan inline (sv39, sv48, sv57): OK
- ubuntu defconfg (sv39, sv48, sv57): OK

Alexandre Ghiti (4):
  riscv: Introduce virtual kernel mapping KASLR
  riscv: Dump out kernel offset information on panic
  arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
  riscv: libstub: Implement KASLR by using generic functions

 arch/riscv/Kconfig                            |  18 +++
 arch/riscv/include/asm/page.h                 |   1 +
 arch/riscv/kernel/pi/Makefile                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c          |  12 ++
 arch/riscv/kernel/pi/fdt_early.c              |  23 +++
 arch/riscv/kernel/setup.c                     |  25 +++
 arch/riscv/mm/init.c                          |  31 +++-
 drivers/firmware/efi/libstub/arm64-stub.c     | 110 +------------
 .../firmware/efi/libstub/efi-stub-helper.c    | 147 ++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/riscv-stub.c     |  27 ++--
 11 files changed, 281 insertions(+), 123 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c

--
2.37.2

