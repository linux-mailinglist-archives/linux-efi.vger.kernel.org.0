Return-Path: <linux-efi+bounces-3196-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A2A7B8DC
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85AF189DDF9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Apr 2025 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4118B463;
	Fri,  4 Apr 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDJ80Esq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E519924D
	for <linux-efi@vger.kernel.org>; Fri,  4 Apr 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755377; cv=none; b=OsfSGdqQRqSMuC4/SNHSdgY7i0NnROTzmCIrpjb9b8QxWkUobNqNKZyQBCgqWg4GEC5Z0hTGonx1C+Zc7+kdhOT+ifIqTa0cvs5e4CH0ICbBKPgqqCLqDuwUuV1rWyVbOg5PYeT6ORSaOe1dq5eNYIEL753SYl3NxuKOe2m6OEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755377; c=relaxed/simple;
	bh=CUYtQcUJjqD/0qbbx6y1aire71Oowdr+5/jf1s0Zshs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6cIK7EEsYZV7E5mER6j3LtQp1KpGfX5nSa+/HnCVEtN3usRFI7mWAeQhHwLyhEie7HWuEXiLw/+yrZ2L9QQwH+iEhEO2YpFzoDWMEr76dKIw5DU+vsN+GMIUWJ/WRHN/O5GXsfYQh6/V+2b50xoh5qyQZ0efArr+yov0zsYrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDJ80Esq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so11936475e9.2
        for <linux-efi@vger.kernel.org>; Fri, 04 Apr 2025 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743755374; x=1744360174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fs3rumgXYlNdIo0aPoSPqrWy63NrFhU04t96nvkXVE=;
        b=jDJ80Esq/bdEQSBLUoJuLFY5BVSg7tbO31LgcYWnDg2VgIupb+9C1nEu69YfxRi4pG
         qM4Wc3bi5S6Ts+Tr3F0Uqc2s+7Wqzgr+pERu67INSxiCp8lKzr4F7B1ynELaT1lZifJu
         AVOWjCOLsoSLJB2J/R+g5l1j4bTBh1KBuMAjJCbBBPY3VdZtwXxVMFW7tegIsyC3SbTE
         WsXfi+WCK8z6T4DqAL7tW11AFOqULWYLE1WXGheZVsvKtmgcakaSJNjLnXDZy5GVdtU+
         hfFxBgaq7yBJ8q7pk4l4uv+7i04e59RJMQpFnnnLi2NumNyN/VhXWO/qzys1QNTg8/24
         pswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755374; x=1744360174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fs3rumgXYlNdIo0aPoSPqrWy63NrFhU04t96nvkXVE=;
        b=q4FR2UNEoejcO4wjQ2P++u0OTHMCFSOVQRLYAfHokhJPyfn/iTUK1q7s3p4qrYpSXX
         ed21n5z2qdQtzy16tFlFmeUnE3NsQ4tVkGKFjHw1DdIwMfGMOclhIepsyUur4KVpy+w0
         WqjOdmazzmMdfiVphBThm1TsE/W19K3oksd4frVS+0LE3W0+8QFWDX6G15eSKZ6bvSRx
         mYU5jhl85GW4YU1FBDzrcI8h8l4YwmIVe9yU44RIDzByegCBsjviovlGoRZ+Si6gshdF
         UqlxedGXHm1sojnRSaVK3xXCwi8RCbSDY3ldsXNXdW/t8XKtlUYC5ZAyIM5NPv0izFow
         4KxA==
X-Gm-Message-State: AOJu0YygehRr0hZNsVLuW4rkTlcAbxUNKtOq4H2s2+epoMFCU5Pjqpjw
	bpURXXNT5U1DsBMBm3y1u+JXeaKXvtdYj1p+IzLAO4c8BlspC1j4JNmdV90gO6TG5Zp3sPhWoXF
	VXViyUtPznW8l0+q/l6vTNwLshqCKrIRDL9L4KIzzSnWUhO/lrm8UzLReNb2GE1VNud75Frs3Er
	GxlVc9qVCTASJ8rClUAPVwa297eg==
X-Google-Smtp-Source: AGHT+IGykQasf+1H0ClSKYIvXLOSj5e5GSTKJXwp9D5dqminxf5F5O91uvLT25YsY0d5LKA66+W6hP+v
X-Received: from wmog19.prod.google.com ([2002:a05:600c:3113:b0:43d:1c63:a630])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3494:b0:43c:efed:732c
 with SMTP id 5b1f17b1804b1-43ecfa0714emr17114135e9.28.1743755373919; Fri, 04
 Apr 2025 01:29:33 -0700 (PDT)
Date: Fri,  4 Apr 2025 10:29:24 +0200
In-Reply-To: <20250404082921.2767593-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404082921.2767593-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5396; i=ardb@kernel.org;
 h=from:subject; bh=BXF8E0AZdhhPev1MpXG0fcbAXL1mKRFgDJG1RHi4ock=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf39jJRUppeHLyZ0aIe6aP/cte6O8r1i1nNVEkwGVv/d7
 kf1lad0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkEmjAyLJCb+MvDtXF9qMBK
 oT1LNupOrDBrzY2fmeD51o6nK232V0aGkzzn+f8qt0YsT7/Q8dkzXuW9Lh8HG0vc3Z8ijjo7F1W zAwA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404082921.2767593-7-ardb+git@google.com>
Subject: [PATCH v2 2/3] x86/boot: Use separate API for memory acceptance in
 the EFI stub
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI stub runs in the execution context of the firmware, and even if
the memory acceptance that occurs when constructing the E820 memory map
after ExitBootServices(), it is still too early for SEV-SNP based memory
acceptance to use the shared GHCB page, as this requires manipulating
the firmware's live page tables.

So implement the unaccepted memory processing locally in the EFI stub.
The SEV-SNP handling will be updated in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/mem.c                   |  2 +-
 drivers/firmware/efi/libstub/efistub.h           |  3 +-
 drivers/firmware/efi/libstub/unaccepted_memory.c | 12 +++---
 drivers/firmware/efi/libstub/x86-stub.c          | 39 ++++++++++++++++++++
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 6a888b80669e..caa3640fc2a0 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -32,7 +32,7 @@ static bool early_is_tdx_guest(void)
 	return is_tdx;
 }
 
-void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+static void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f5ba032863a9..88751d83f584 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1231,8 +1231,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
 efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 					struct efi_boot_memmap *map);
 void process_unaccepted_memory(u64 start, u64 end);
-void accept_memory(phys_addr_t start, unsigned long size);
-void arch_accept_memory(phys_addr_t start, phys_addr_t end);
+void efistub_accept_memory(phys_addr_t start, phys_addr_t end);
 
 efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
 efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 02040bd6a330..4e90077ca797 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -118,7 +118,7 @@ void process_unaccepted_memory(u64 start, u64 end)
 	 * immediately accepted in its entirety.
 	 */
 	if (end - start < 2 * unit_size) {
-		arch_accept_memory(start, end);
+		efistub_accept_memory(start, end);
 		return;
 	}
 
@@ -129,13 +129,13 @@ void process_unaccepted_memory(u64 start, u64 end)
 
 	/* Immediately accept a <unit_size piece at the start: */
 	if (start & unit_mask) {
-		arch_accept_memory(start, round_up(start, unit_size));
+		efistub_accept_memory(start, round_up(start, unit_size));
 		start = round_up(start, unit_size);
 	}
 
 	/* Immediately accept a <unit_size piece at the end: */
 	if (end & unit_mask) {
-		arch_accept_memory(round_down(end, unit_size), end);
+		efistub_accept_memory(round_down(end, unit_size), end);
 		end = round_down(end, unit_size);
 	}
 
@@ -144,8 +144,8 @@ void process_unaccepted_memory(u64 start, u64 end)
 	 * into the bitmap.
 	 */
 	if (start < unaccepted_table->phys_base) {
-		arch_accept_memory(start,
-				   min(unaccepted_table->phys_base, end));
+		efistub_accept_memory(start,
+				      min(unaccepted_table->phys_base, end));
 		start = unaccepted_table->phys_base;
 	}
 
@@ -165,7 +165,7 @@ void process_unaccepted_memory(u64 start, u64 end)
 			     unaccepted_table->phys_base;
 		phys_end = end + unaccepted_table->phys_base;
 
-		arch_accept_memory(phys_start, phys_end);
+		efistub_accept_memory(phys_start, phys_end);
 		end = bitmap_size * unit_size * BITS_PER_BYTE;
 	}
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..7d9cf473f4d0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 #include <asm/kaslr.h>
 #include <asm/sev.h>
+#include <asm/shared/tdx.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -364,6 +365,44 @@ static void setup_unaccepted_memory(void)
 		efi_err("Memory acceptance protocol failed\n");
 }
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+
+static bool efistub_is_tdx_guest(void)
+{
+	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {};
+
+	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
+		return false;
+
+	native_cpuid(&eax, &sig[0], &sig[2], &sig[1]);
+	return !memcmp(TDX_IDENT, sig, sizeof(sig));
+}
+
+static bool efistub_is_sevsnp_guest(void)
+{
+	return sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
+void efistub_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	static bool once, is_tdx, is_sevsnp;
+
+	if (!once) {
+		if (efistub_is_tdx_guest())
+			is_tdx = true;
+		else if (efistub_is_sevsnp_guest())
+			is_sevsnp = true;
+		once = true;
+	}
+
+	if (is_tdx)
+		tdx_accept_memory(start, end);
+	else if (is_sevsnp)
+		snp_accept_memory(start, end);
+}
+
+#endif
+
 static efi_char16_t *efistub_fw_vendor(void)
 {
 	unsigned long vendor = efi_table_attr(efi_system_table, fw_vendor);
-- 
2.49.0.504.g3bcea36a83-goog


