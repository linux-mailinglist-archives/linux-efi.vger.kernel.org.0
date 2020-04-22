Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87521B4B99
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDVRYo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgDVRYo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 13:24:44 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CF42082E;
        Wed, 22 Apr 2020 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587576283;
        bh=gG6njuZNXvWtpI2Xiu55BPhnh2uc/oKogGgx7w4dS9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWSrbFluMqNVf7PIP0eCEZ4tXJIb7Q9A7ISPSAoc2OAhHTeHWz66iRGaR+GxAiqdP
         1kA0MqyFMoI0+sWRbCynmQY8AStqFKTnE/c7JsmN/h1jlT1qaJW/uEDhfnUvl+5atG
         JBW43la+kIsKVT0IVnRtOU2L8yncsnN4E75Xpklk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/7] efi/libstub/riscv: add arch specific efi.h header file
Date:   Wed, 22 Apr 2020 19:24:10 +0200
Message-Id: <20200422172414.6662-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
References: <20200422172414.6662-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Add the arch specific efi.h header defining the RISC-V specific glue
for the EFI stub code.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200421033336.9663-4-atish.patra@wdc.com
[ardb: - split off from 'RISC-V: Add EFI stub support'
       - drop unused definition of VA_BITS_MIN ]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/include/asm/efi.h | 41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
new file mode 100644
index 000000000000..3dc495a937da
--- /dev/null
+++ b/arch/riscv/include/asm/efi.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+#include <asm/io.h>
+#include <asm/mmu_context.h>
+#include <asm/ptrace.h>
+#include <asm/tlbflush.h>
+
+/* on RISC-V, the FDT may be located anywhere in system RAM */
+static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+{
+	return ULONG_MAX;
+}
+
+/* Load initrd at enough distance from DRAM start */
+static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
+						    unsigned long image_addr)
+{
+	return dram_base + SZ_256M;
+}
+
+#define efi_bs_call(func, ...)	efi_system_table()->boottime->func(__VA_ARGS__)
+#define efi_rt_call(func, ...)	efi_system_table()->runtime->func(__VA_ARGS__)
+#define efi_is_native()		(true)
+
+#define efi_table_attr(inst, attr)	(inst->attr)
+
+#define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
+
+#define alloc_screen_info(x...)		(&screen_info)
+extern char stext_offset[];
+
+static inline void free_screen_info(struct screen_info *si)
+{
+}
+
+#endif /* _ASM_EFI_H */
-- 
2.17.1

