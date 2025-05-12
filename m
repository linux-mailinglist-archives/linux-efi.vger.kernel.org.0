Return-Path: <linux-efi+bounces-3665-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81549AB4498
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94F38C2E5C
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAFD299A9D;
	Mon, 12 May 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2ruq6+u"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67113299A82
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077116; cv=none; b=szN7PNwfi0CiCvhw9NaYsKGRtClTdSqkzOAEmN/OotDRZjY/yGy5iVYDBUaVpxpCopH2fitlCqytMjRqi8hfOr0F2kUsud4EGlxgMrGgHHAXKepsMMldsCkUpiVxQFazUU1qbuKISY1SzTqM0cxhkSvu2531JWTrkv90XYf5Ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077116; c=relaxed/simple;
	bh=7K2L+GKfDJZEmOoWCjZzAUSDROLuN9vFgPOoHrZk8MI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpxMXbbyuztwfyPYH4dLN/0meNaMmLh1xBT8+8T5ig+0hiFhDx3FGqC2fgzVwE2vY9nZ6Gt+K3YKkB5WjKitcrWMj+XsCUSwKrkIdC+e6piJRXwvs6OIfDSxfJm6Ct62EFiTgrVkfAbw0qtI7O1bcFKeKsJpf/w7hv85X7nUuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2ruq6+u; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-44059976a1fso16009225e9.1
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077113; x=1747681913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XKokAspLOvkjts4pWwEpgnj480mrGaJGARvds1P8gU=;
        b=H2ruq6+ur9GO1EneyBzUiLVVvZt+fyW+tq4ytWW0WZAnY8WYNXKgG/QjnL4itgy95Q
         KR24Vv0VJfjTJ4y+4qfi5Gn1onLI5gnWv/DpbrAiwXg+J27lTFysnecU6DRa8flSHQEF
         iCCyNS6Va8FdOWGY0u++WcC73bPyJ3gnA7Im3VxMUaB32x4YA7KrNyvReoUcewfqiHN0
         q/eU1Nb0bMnH12g1qmoXpPEdZaeZ+mgL6L6CYHE/HSdvPRImRaVtsNjJ30/5VSmMx6nm
         Dtecd0gYNLHWdR3AvZwT2ywKz9zhBgT1sg9BuMgadMDBVdWNR4OohGUlgu5lXcuxm8N6
         zjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077113; x=1747681913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XKokAspLOvkjts4pWwEpgnj480mrGaJGARvds1P8gU=;
        b=w1xtLqhjuhc1SJZWxuaszQ5B86rpQcBJrV1Pnws2R8Xwv2xA8pDcXDObOaCkvUe4pz
         +1IJ7ZOHO299ZXVOUt+fbCErJ5bn0fYKG7aSgRXQHkjQy6Pz7Ju8la0RvH6e/dYUPeNo
         u+caRr9aRCjrw/csjIH8REJI9VXeo/gNaE9l48L7jwUkadiMEiFZjtUSeIIMJzwt4ZYU
         RvCNrEPc0MXNxekghGTkWyLbBRF6qlDESNli8pr8Nub03wqhhm0IlkdPScQBzcNeVgry
         +sGnnJAhdLWdggMz1VI/HTUN3lx1qhC7prNCHjt3OtXYLIfxUb1WGqOA+E/U5fcjfFDR
         RiCw==
X-Gm-Message-State: AOJu0YzFRr5H4f+Q+pIsExkrURufEozTe+2wq2l8N9YPHjDtknnM3KGU
	buJd/Py0qyylndmWRMxyqNGOse7haqA7RECHmarI1t/wJxqdmJiw540GRcNjrg1X9cWMJw==
X-Google-Smtp-Source: AGHT+IFCBAwZKHnIc2xjqftOjJZwQmyTYMlu5P3aWusXhTyeYtY2YRoTyZ+awOa8ofAOsfGILXoGhK9q
X-Received: from wmqb6.prod.google.com ([2002:a05:600c:4e06:b0:442:cd17:732c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c12:b0:43c:f616:f08
 with SMTP id 5b1f17b1804b1-442d6d3decbmr125763715e9.8.1747077113088; Mon, 12
 May 2025 12:11:53 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:45 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5484; i=ardb@kernel.org;
 h=from:subject; bh=bVbymWKNm9wWjinbz/J23+LuQcjm/YhHZrH0j/hDw2w=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3Z0zI1ElwedOVEPJR+c3x17um37Q6kvA+0c57C84P
 8TJzl3fUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbCksDI8Cuq0nhSuXncrXUi
 y/52Lcl9J7UoxqJu5fUiB8fcFZ+uSTMyvPj53PGLiZ6uwrwvvC9S958q7Kt92b9//4PqCLkZZWd VGQE=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-33-ardb+git@google.com>
Subject: [RFT PATCH v3 10/21] x86/sev: Use boot SVSM CA for all startup and
 init code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

To avoid having to reason about whether or not to use the per-CPU SVSM
calling area when running startup and init code on the boot CPU, reuse
the boot SVSM calling area as the per-CPU area for CPU #0.

This removes the need to make the per-CPU variables and associated state
in sev_cfg accessible to the startup code once confined.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      | 13 ------
 arch/x86/boot/startup/sev-startup.c |  7 +--
 arch/x86/coco/sev/core.c            | 47 +++++++++-----------
 arch/x86/include/asm/sev-internal.h | 16 -------
 4 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 04bc39d065ff..fc0119bdc878 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -37,19 +37,6 @@ struct ghcb *boot_ghcb;
 
 #define __BOOT_COMPRESSED
 
-extern u64 boot_svsm_caa_pa;
-
-struct svsm_ca *svsm_get_caa(void)
-{
-	/* The decompressor is mapped 1:1 so VA == PA */
-	return (struct svsm_ca *)boot_svsm_caa_pa;
-}
-
-u64 svsm_get_caa_pa(void)
-{
-	return boot_svsm_caa_pa;
-}
-
 u8 snp_vmpl;
 
 /* Include code for early handlers */
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 7a3ad17d06f6..2e946dab036c 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -50,9 +50,6 @@ u64 sev_secrets_pa __ro_after_init;
 /* For early boot SVSM communication */
 struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 
-DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-DEFINE_PER_CPU(u64, svsm_caa_pa);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -167,7 +164,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * table.
 	  */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -184,7 +181,7 @@ void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED,
-			      svsm_get_caa(), svsm_get_caa_pa());
+			      rip_rel_ptr(&boot_svsm_ca_page), boot_svsm_caa_pa);
 }
 
 /*
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 39bbbea09c24..fa7fdd11a45b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -45,6 +45,25 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
+DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return rip_rel_ptr(&boot_svsm_ca_page);
+}
+
+static inline u64 svsm_get_caa_pa(void)
+{
+	if (sev_cfg.use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return boot_svsm_caa_pa;
+}
+
 /* AP INIT values as documented in the APM2  section "Processor Initialization State" */
 #define AP_INIT_CS_LIMIT		0xffff
 #define AP_INIT_DS_LIMIT		0xffff
@@ -1207,7 +1226,8 @@ static void __init alloc_runtime_data(int cpu)
 		struct svsm_ca *caa;
 
 		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE);
+		caa = cpu ? memblock_alloc_or_panic(sizeof(*caa), PAGE_SIZE)
+			  : &boot_svsm_ca_page;
 
 		per_cpu(svsm_caa, cpu) = caa;
 		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
@@ -1261,32 +1281,9 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
-	/* If running under an SVSM, switch to the per-cpu CA */
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-		int ret;
-
-		local_irq_save(flags);
-
-		/*
-		 * SVSM_CORE_REMAP_CA call:
-		 *   RAX = 0 (Protocol=0, CallID=0)
-		 *   RCX = New CA GPA
-		 */
-		call.caa = svsm_get_caa();
-		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-		call.rcx = this_cpu_read(svsm_caa_pa);
-		ret = svsm_perform_call_protocol(&call);
-		if (ret)
-			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
-			      ret, call.rax_out);
-
+	if (snp_vmpl)
 		sev_cfg.use_cas = true;
 
-		local_irq_restore(flags);
-	}
-
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 08e2cfdef512..3690994275dd 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -63,22 +63,6 @@ DECLARE_PER_CPU(u64, svsm_caa_pa);
 
 extern u64 boot_svsm_caa_pa;
 
-static __always_inline struct svsm_ca *svsm_get_caa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return rip_rel_ptr(&boot_svsm_ca_page);
-}
-
-static __always_inline u64 svsm_get_caa_pa(void)
-{
-	if (sev_cfg.use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return boot_svsm_caa_pa;
-}
-
 enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt);
 void vc_forward_exception(struct es_em_ctxt *ctxt);
 
-- 
2.49.0.1045.g170613ef41-goog


