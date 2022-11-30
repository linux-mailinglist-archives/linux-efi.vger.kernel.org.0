Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890B63E3C9
	for <lists+linux-efi@lfdr.de>; Wed, 30 Nov 2022 23:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiK3W45 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Nov 2022 17:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiK3W4s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Nov 2022 17:56:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47991C2B
        for <linux-efi@vger.kernel.org>; Wed, 30 Nov 2022 14:56:45 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p0W0L-0005PW-Hi; Wed, 30 Nov 2022 23:56:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        ajones@ventanamicro.com, heiko@sntech.de,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 07/14] RISC-V: rename parse_asm.h to insn.h
Date:   Wed, 30 Nov 2022 23:56:07 +0100
Message-Id: <20221130225614.1594256-8-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130225614.1594256-1-heiko@sntech.de>
References: <20221130225614.1594256-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

The current parse_asm header should become a more centralized place
for everything concerning parsing and constructing instructions.

We already have a header insn-def.h similar to aarch64, so rename
parse_asm.h to insn.h (again similar to aarch64) to show that it's
meant for more than simple instruction parsing.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/include/asm/{parse_asm.h => insn.h} | 0
 arch/riscv/kernel/kgdb.c                       | 2 +-
 arch/riscv/kernel/probes/simulate-insn.h       | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/riscv/include/asm/{parse_asm.h => insn.h} (100%)

diff --git a/arch/riscv/include/asm/parse_asm.h b/arch/riscv/include/asm/insn.h
similarity index 100%
rename from arch/riscv/include/asm/parse_asm.h
rename to arch/riscv/include/asm/insn.h
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 61237aeb493c..2e0266ae6bd7 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -11,7 +11,7 @@
 #include <linux/string.h>
 #include <asm/cacheflush.h>
 #include <asm/gdb_xml.h>
-#include <asm/parse_asm.h>
+#include <asm/insn.h>
 
 enum {
 	NOT_KGDB_BREAK = 0,
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index 29fb16cd335c..a19aaa0feb44 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -3,7 +3,7 @@
 #ifndef _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
 #define _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
 
-#include <asm/parse_asm.h>
+#include <asm/insn.h>
 
 #define RISCV_INSN_REJECTED(name, code)					\
 	do {								\
-- 
2.35.1

