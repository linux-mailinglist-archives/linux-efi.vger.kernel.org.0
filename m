Return-Path: <linux-efi+bounces-3556-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E7AA85A4
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FA63BB862
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479951B040B;
	Sun,  4 May 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQ7zNLE1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F361AA1F4
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352398; cv=none; b=ktVUY0oMxtQWkWGMgCFjf2+gwRQ4mjZfKFwGiebj1EEpqHj9SSkYt9K40EJwUAxA+k7BclgKEfP/B3rYcClrMAbuR79FY8NvDAgz7yB7At4wS+gF3TZGpPDpXP9kUhPrb3O7mS9TuaQ9x3odmPZsrsaeG7FdbfpJfoYgT0QcDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352398; c=relaxed/simple;
	bh=8oU3sJmLLw7lhWsobG4CuwI5p2a/Vx6rsE7nZ4672nU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o3MU9zsXqy6ysA/G1Q1cNYTumdJ2PB4QmWqK1A458MJRSYH0OMP4OhC6p9mnpVGIry1BP974zy6xvxHMTFjrb664nperGCI/yu2rw0/pwDDPF9lmB8LMMjVGG0LbEHHLYq5BbcxO80YB9ag/qd5nQfXKBXuzCdHL4wQXJPc8pUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQ7zNLE1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so24969785e9.2
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352394; x=1746957194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8k5UXPfAUt7lWY46f0DCoraoS5cNNXwyrCGcmYgyMZU=;
        b=FQ7zNLE1FNH9iDCo2/cBXAYVjUsh6P0WDmIPG6L5yaeJ7RPzYSunSL5ajklvSkqm+a
         CzAEuq3j1lhhiyU7OCGGziTqfcsaSbpCzwMRb0IUAaLuPeblLe3SBNrdN9XlZhLE2X3w
         XVpZbiadoXqCjg3xOxhiDfpyaT/FN6QSJiYs93+G38iV+pQqY0mpTFSaK3QrAp8IxV8b
         Ka0JGNWiTViPly73dGWS7J1xoE4rCiwhbayRlVAjlDgPSdNc6AYsf3mOKjX8qVhH1wvS
         kjKg8e/t2bAkpb/xHy66FJzmkDo/MiScrVBwIFp/8HIweF+cvk+DWxhC43UPoDBqGgaE
         QcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352394; x=1746957194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k5UXPfAUt7lWY46f0DCoraoS5cNNXwyrCGcmYgyMZU=;
        b=qg0xcg8FE40ET37xHmvEl/PcFtiYL+Y3VOp06fPrDaTCfTmWetm9XYQQaGyBF0fi30
         Vsg9cw8n0hNZKH82U57MFn31ClBi794N436oEP35Lu/u4z2pG8K9XV+gqs3Dz/A1H4mg
         kOQ9KvGGXlBgGn6io2sUN2rZiA56+DpOAeXNCpVb4saLUfsgPi/Pww2amOUMwpdsRL8c
         kh+E+YADcqhI4rqktrfvOztpadBtFUZvsovc67eanMletgVNrif6RhplXpQDkM6hhjNQ
         hfdvZHyT4p3o3L5QeQaBdGhN0h9wVizAWj7p3IAbYInbUUYI1UF6cH8TLIL4lfdHb3WD
         ooHA==
X-Gm-Message-State: AOJu0YwZD5VY8qjOvoAaXeA5HHUiXxMHGW1Ko1LARsH2Mm7medLbHD/i
	VOZNPIsF37GXnCujhEETHXbV2ygq46ZsRhHAjPX+hZv+oi7kImFPTtXKUlXC+9txjpJTtw==
X-Google-Smtp-Source: AGHT+IHhtVzNEx2SNv42+ELTk1PY7qJSz7ugHEVU92NSyY7RvnJQpT9z9PBwulmS9Mhnm5dcqMazof68
X-Received: from wmsp7.prod.google.com ([2002:a05:600c:1d87:b0:440:6128:9422])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8708:b0:43d:83a:417d
 with SMTP id 5b1f17b1804b1-441c48bdfc4mr29016015e9.12.1746352394623; Sun, 04
 May 2025 02:53:14 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:35 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6109; i=ardb@kernel.org;
 h=from:subject; bh=dIha7Dx3IwFCZV+ZQ2fqjImHHrNrFiQAc9XOg6z2oBc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4qnokriZ4pN14t+8rvabY7PTx/HW/9BS5o0x3/7e+
 XVu/fZ5HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAixy4xMuzaKH5m+Y9d3V/t
 2UzXZL8+eF0pinH36bJn0clad9/pu95kZJgRWnkuL+REgrfQtsYzJY0etz4drlvUKxH6ie1n3W+ DbHYA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-30-ardb+git@google.com>
Subject: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into separate
 source file
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

As a first step towards disentangling the SEV #VC handling code -which
is shared between the decompressor and the core kernel- from the SEV
startup code, move the decompressor's copy of the instruction decoder
into a separate source file.

Code movement only - no functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile        |  6 +--
 arch/x86/boot/compressed/misc.h          |  7 +++
 arch/x86/boot/compressed/sev-handle-vc.c | 51 ++++++++++++++++++++
 arch/x86/boot/compressed/sev.c           | 39 +--------------
 4 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 0fcad7b7e007..f4f7b22d8113 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -44,10 +44,10 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
-# sev.c indirectly includes inat-table.h which is generated during
+# sev-decode-insn.c indirectly includes inat-table.c which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
-CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
+CFLAGS_sev-handle-vc.o += -I$(objtree)/arch/x86/lib/
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 
@@ -96,7 +96,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
-	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o $(obj)/sev-handle-vc.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 450d27d0f449..ccd3f4257bcd 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -133,6 +133,9 @@ static inline void console_init(void)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+struct es_em_ctxt;
+struct insn;
+
 void sev_enable(struct boot_params *bp);
 void snp_check_features(void);
 void sev_es_shutdown_ghcb(void);
@@ -140,6 +143,10 @@ extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
 void sev_prep_identity_maps(unsigned long top_level_pgt);
+
+enum es_result vc_decode_insn(struct es_em_ctxt *ctxt);
+bool insn_has_rep_prefix(struct insn *insn);
+void sev_insn_decode_init(void);
 #else
 static inline void sev_enable(struct boot_params *bp)
 {
diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
new file mode 100644
index 000000000000..b1aa073b732c
--- /dev/null
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "misc.h"
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <asm/insn.h>
+#include <asm/pgtable_types.h>
+#include <asm/ptrace.h>
+#include <asm/sev.h>
+
+#define __BOOT_COMPRESSED
+
+/* Basic instruction decoding support needed */
+#include "../../lib/inat.c"
+#include "../../lib/insn.c"
+
+/*
+ * Copy a version of this function here - insn-eval.c can't be used in
+ * pre-decompression code.
+ */
+bool insn_has_rep_prefix(struct insn *insn)
+{
+	insn_byte_t p;
+	int i;
+
+	insn_get_prefixes(insn);
+
+	for_each_insn_prefix(insn, i, p) {
+		if (p == 0xf2 || p == 0xf3)
+			return true;
+	}
+
+	return false;
+}
+
+enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int ret;
+
+	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+
+	return ES_OK;
+}
+
+extern void sev_insn_decode_init(void) __alias(inat_init_tables);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bc52c0aa96d4..5cd029c4f36d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -29,25 +29,6 @@
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
-/*
- * Copy a version of this function here - insn-eval.c can't be used in
- * pre-decompression code.
- */
-static bool insn_has_rep_prefix(struct insn *insn)
-{
-	insn_byte_t p;
-	int i;
-
-	insn_get_prefixes(insn);
-
-	for_each_insn_prefix(insn, i, p) {
-		if (p == 0xf2 || p == 0xf3)
-			return true;
-	}
-
-	return false;
-}
-
 /*
  * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
  * doesn't use segments.
@@ -74,20 +55,6 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int ret;
-
-	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
-
-	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
-	if (ret < 0)
-		return ES_DECODE_FAILED;
-
-	return ES_OK;
-}
-
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   void *dst, char *buf, size_t size)
 {
@@ -122,10 +89,6 @@ static bool fault_in_kernel_space(unsigned long address)
 
 #define __BOOT_COMPRESSED
 
-/* Basic instruction decoding support needed */
-#include "../../lib/inat.c"
-#include "../../lib/insn.c"
-
 extern struct svsm_ca *boot_svsm_caa;
 extern u64 boot_svsm_caa_pa;
 
@@ -230,7 +193,7 @@ static bool early_setup_ghcb(void)
 	boot_ghcb = &boot_ghcb_page;
 
 	/* Initialize lookup tables for the instruction decoder */
-	inat_init_tables();
+	sev_insn_decode_init();
 
 	/* SNP guest requires the GHCB GPA must be registered */
 	if (sev_snp_enabled())
-- 
2.49.0.906.g1f30a19c02-goog


