Return-Path: <linux-efi+bounces-3580-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE1AA86AF
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6002F17463A
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB81CDFAC;
	Sun,  4 May 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4h5ikHn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xcf46/A"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1F1A2C25;
	Sun,  4 May 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368421; cv=none; b=JaZPMkantKYkWf1Im7zBDnIkf3jpZwYZGiIz07e9ihP9PZWmRd7iP1PGCaYapWa2PE17KOS1BP/YRHUuu8e7gCh9R/VazActIwiVNh29/dm1zTugci77KWeztqR8L99pOdSYDmDs6rCgkOfsHp5HmZGfbusObxApf+fXngy/sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368421; c=relaxed/simple;
	bh=zGgXm8i9YNYy8sazqoSgmuV+cf/v2nXfu+PdfddmoK0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=koLgq9fZ59S7GqwV/H6B9SGGjiQNudTIxse2HWAv1vfg0eUTrYygkvzGwb4+Fd92U7IdQJtPmAwcSHHbIaFRWQh3cLUXIQTnYW1XibBlYZLGo3pbpJmLiKA6d19bcsqEei700nupZnSsaH6vU8RrqM7OTWcoXdzupM7Rzc4spGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4h5ikHn+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xcf46/A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 14:20:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746368417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOs2rJmHuUUInIeOUjO5Og716X1D3kaVrlrxBwICRB8=;
	b=4h5ikHn+pzqdtAfTvDtW9N/r4pEAPBjUElQUPKNZAIwLW/FLq2cN+gq+PSWcfp6eG2D9w9
	ydWjO6E+Ui0rdGI5Pm8kHicHzukM6kBc/PldyS/Tyk7mtRKLRFpmgZbADc3qe3TBAI/17K
	W4JxgI3VkuxYVbhLsjZSIAc5O00IV1srvzeUfOrMaU+bxJT8HtectXQknk0egagnp4//bu
	wS1iju6+oPOCU3sgVh2B208OYJjY7HFNjdoNR6Av/jM1Z6M0lpFbbixAGiyGhSkH++3Da7
	/4UqQoA1+AHMeVlYUiRPXXPA0cQbxL3mgHbw8f7T3MxxXcQCxzR5hePLjae8SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746368417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOs2rJmHuUUInIeOUjO5Og716X1D3kaVrlrxBwICRB8=;
	b=0xcf46/AMiqh/7QJSzW6gNfHDbuVqp8oil6FAP73L6/0Tp9LSLEXvbNogCkh5RoeZcSl5Y
	QzZwGPpjlYsiA7Cw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/sev: Move instruction decoder into separate source file
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250504095230.2932860-30-ardb+git@google.com>
References: <20250504095230.2932860-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174636841649.22196.5967342978597862709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     ae862964cbc562582576da91b0b92742a574c437
Gitweb:        https://git.kernel.org/tip/ae862964cbc562582576da91b0b92742a574c437
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 04 May 2025 11:52:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 15:53:06 +02:00

x86/sev: Move instruction decoder into separate source file

As a first step towards disentangling the SEV #VC handling code -which
is shared between the decompressor and the core kernel- from the SEV
startup code, move the decompressor's copy of the instruction decoder
into a separate source file.

Code movement only - no functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250504095230.2932860-30-ardb+git@google.com
---
 arch/x86/boot/compressed/Makefile        |  6 +--
 arch/x86/boot/compressed/misc.h          |  7 +++-
 arch/x86/boot/compressed/sev-handle-vc.c | 51 +++++++++++++++++++++++-
 arch/x86/boot/compressed/sev.c           | 39 +------------------
 4 files changed, 62 insertions(+), 41 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev-handle-vc.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 0fcad7b..f4f7b22 100644
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
index dd8d1a8..04de48c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -136,6 +136,9 @@ static inline void console_init(void)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+struct es_em_ctxt;
+struct insn;
+
 void sev_enable(struct boot_params *bp);
 void snp_check_features(void);
 void sev_es_shutdown_ghcb(void);
@@ -143,6 +146,10 @@ extern bool sev_es_check_ghcb_fault(unsigned long address);
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
index 0000000..b1aa073
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
index f4b7f17..6fe7e85 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -30,25 +30,6 @@ static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
 /*
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
-/*
  * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
  * doesn't use segments.
  */
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

