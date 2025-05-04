Return-Path: <linux-efi+bounces-3547-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B488AA8468
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 08:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2D8179FBF
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD0D183CB0;
	Sun,  4 May 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLSq9mD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK3u6gBv"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB14130A7D;
	Sun,  4 May 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746341883; cv=none; b=AVGZVVQzQvP4gk7x/gmg+7lH07qPqcVcVDonO+M1S3ajoVRQOTse9U7YjzEmVevIanT4AL6lPe788viMlDfGtVflXMnmugWpC288gp9DQ5HSkIO8eww93TV/fsQk0nkbIB21s7dS850jukoLN/2HMX2b1/eunVUp2+R4Si3JfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746341883; c=relaxed/simple;
	bh=hnu4Nc3S6VKLMCxUIJhllk0RF2PfPOO1fXOC6zmH3wo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IJCoHO5pmSGWHNgw7IbF68GksPbpJLPfxnH8svlAZWi5RDXAUM/NfGppezhQ6TQ6AXt1Nhxfb3Mz22q+nyxHg36osPbOC1qqycaEwLXasZqEfgnqyb+2UgX2o3wWXPODYgl+epUKiULngiuc72e63dPK/Ls2p+V6/rLxG6xY0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pLSq9mD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK3u6gBv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 06:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746341873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qV9q6fKEQc/wdLQCvNRakX9Kvw3ZigCKFVWwmbfRUJ0=;
	b=pLSq9mD21uX4/ihTsuYpYcvYioHfO9JYedSbdFiIQ17DFNsaZezZQGqvNvke+DPV7+Sy8t
	c9I1EH4d3xft8jhMhzzt8+ztrFJIguzLzy/xtjD/lwMkkgbtHhzvf+IHwVSHVvNrWwoEgb
	eFyLBmTWT5uGupr98ntMNcNGxXERsNsu0kKh77UwTSmigmSEhm9BrWrGfEtKVH9BPh6IH5
	1jybwRUHuWA3K1w8i/2jnz5vB+bQaVIEWXo4iuKHczh4qf4gZ526P4hkaw9kFEa0tyjhOS
	h5W+Q76YK8YlDg1eQaJ2ESWssWWEA0Ci1V0HLKOLyPgHSYn4REEJy4NgUwaeOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746341873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qV9q6fKEQc/wdLQCvNRakX9Kvw3ZigCKFVWwmbfRUJ0=;
	b=zK3u6gBv6c6L/7fdkBW+tUtVEnM729ecCJELCe8HcoDZGuQgIgdN54ZgW1eCdZ8Hpk+Tgc
	IS2FQ4beX6x06xDw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/sev: Support memory acceptance in the EFI
 stub under SVSM
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428174322.2780170-2-ardb+git@google.com>
References: <20250428174322.2780170-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634186772.22196.3588344121951287997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8ed12ab1319b2d8e4a529504777aacacf71371e4
Gitweb:        https://git.kernel.org/tip/8ed12ab1319b2d8e4a529504777aacacf71371e4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 28 Apr 2025 19:43:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 08:20:27 +02:00

x86/boot/sev: Support memory acceptance in the EFI stub under SVSM

Commit:

  d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")

provided a fix for SEV-SNP memory acceptance from the EFI stub when
running at VMPL #0. However, that fix was insufficient for SVSM SEV-SNP
guests running at VMPL >0, as those rely on a SVSM calling area, which
is a shared buffer whose address is programmed into a SEV-SNP MSR, and
the SEV init code that sets up this calling area executes much later
during the boot.

Given that booting via the EFI stub at VMPL >0 implies that the firmware
has configured this calling area already, reuse it for performing memory
acceptance in the EFI stub.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: linux-efi@vger.kernel.org
Link: https://lore.kernel.org/r/20250428174322.2780170-2-ardb+git@google.com
---
 arch/x86/boot/compressed/mem.c |  5 +----
 arch/x86/boot/compressed/sev.c | 40 +++++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/sev.h |  2 ++-
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index f676156..0e9f84a 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -34,14 +34,11 @@ static bool early_is_tdx_guest(void)
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	static bool sevsnp;
-
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
-	} else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
-		sevsnp = true;
+	} else if (early_is_sevsnp_guest()) {
 		snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 89ba168..0003e44 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -645,3 +645,43 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 
 	sev_verify_cbit(top_level_pgt);
 }
+
+bool early_is_sevsnp_guest(void)
+{
+	static bool sevsnp;
+
+	if (sevsnp)
+		return true;
+
+	if (!(sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED))
+		return false;
+
+	sevsnp = true;
+
+	if (!snp_vmpl) {
+		unsigned int eax, ebx, ecx, edx;
+
+		/*
+		 * CPUID Fn8000_001F_EAX[28] - SVSM support
+		 */
+		eax = 0x8000001f;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (eax & BIT(28)) {
+			struct msr m;
+
+			/* Obtain the address of the calling area to use */
+			boot_rdmsr(MSR_SVSM_CAA, &m);
+			boot_svsm_caa = (void *)m.q;
+			boot_svsm_caa_pa = m.q;
+
+			/*
+			 * The real VMPL level cannot be discovered, but the
+			 * memory acceptance routines make no use of that so
+			 * any non-zero value suffices here.
+			 */
+			snp_vmpl = U8_MAX;
+		}
+	}
+	return true;
+}
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index 4e463f3..d390038 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -13,12 +13,14 @@
 bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
+bool early_is_sevsnp_guest(void);
 
 #else
 
 static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 sev_get_status(void) { return 0; }
+static inline bool early_is_sevsnp_guest(void) { return false; }
 
 #endif
 

