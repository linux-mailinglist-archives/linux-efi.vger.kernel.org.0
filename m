Return-Path: <linux-efi+bounces-3637-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF539AAE9FD
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C72D1C425B9
	for <lists+linux-efi@lfdr.de>; Wed,  7 May 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119C2144CC;
	Wed,  7 May 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyS9OgUq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F21DDC23;
	Wed,  7 May 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643816; cv=none; b=cnrjkpgjo6+zVZwsSC+Am0BRVOYS/iTVmjwIKgkIHC47XOajlgdudO9diomUuD0ip1Unm94Kf/BxyoH+Ny8t2zlUSh+6InibwzhUHVVioJImP7kJZiedO2Kg6tu7i/RkjWQ0L8lBSIljixadBtIRC6XiV87Jd/poNOldEg/n/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643816; c=relaxed/simple;
	bh=pklMne+Uvlo8TLVLRkTsvsAXsgCA1OJT4SO4xcnvaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz4S7uf2HChMK4KaTo0lCaI9AXjdQ62HMIxN8ryC+rVZHYSFaKSPg0Cr9Y/gBGSeAxiZCzr6aDci/jWYSOjcvK5m3VcdXTcUIQ/TKR/yVLX4anAzNoKXEDiW9ITJhdPUM61aKDyfh1BVB3NzIQl99dc+K2Mt/PpLp+5Jz+PB0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyS9OgUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C8C4CEE2;
	Wed,  7 May 2025 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643816;
	bh=pklMne+Uvlo8TLVLRkTsvsAXsgCA1OJT4SO4xcnvaNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyS9OgUqOslsYJIBB1om4McDnEjsjtTIrC1v7pbqHCbo/MW8470qF1+D65xvvfNmJ
	 4RwIsvR+T0voe5fq91SfF+He4eyas/2NbHBZ2sS1B5GkiigPg14mhXOkFZo3VZ2yks
	 I/YXWGnebwGb29TXO6EUvH34lN14nRKrvxEbvZuI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH 6.14 027/183] x86/boot/sev: Support memory acceptance in the EFI stub under SVSM
Date: Wed,  7 May 2025 20:37:52 +0200
Message-ID: <20250507183825.784953448@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit 8ed12ab1319b2d8e4a529504777aacacf71371e4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/mem.c |    5 +----
 arch/x86/boot/compressed/sev.c |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/sev.h |    2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)

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
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -645,3 +645,43 @@ void sev_prep_identity_maps(unsigned lon
 
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
 



