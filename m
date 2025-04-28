Return-Path: <linux-efi+bounces-3478-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60764A9F7A1
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DB53A836B
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3C293B6A;
	Mon, 28 Apr 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBALPa9G"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6128DEE1
	for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862217; cv=none; b=gVpq7sWb5Nb/nqqEUQ4UuFrvFkN+6sLijzILFBgrOdSo5ppQ5jiL0LRkSMHU6r2C/mX5WUAgSii0uGn8XAP9HvuEDvMx4ldWRslPxc2g5uaTPl7dLeapgT5TEQ903UaRPe08afAc3TEfPEX5X05z8EwJQPdg0F1iKGgSsreRG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862217; c=relaxed/simple;
	bh=eC4hnSICOLldxzWsqCNKPWHQ9spSJAIzP/aFlUIu2m4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jsjT7JULk4KBD7lsfPqYTMnCv0fpmAr9xLQC/2wVF2CRlAxT1UnHCGKjLPQBejp1ehvfJp5/uBe9oRNTts57hMi8aD8swoNquL0GwmZLXlpSIvjVq3WjaXzRWW0r9yoYvzPwaiCfBMau416Xlrk9UUdpKrt2DzLo+KWsH2X9EW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBALPa9G; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39123912ff0so1231784f8f.2
        for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745862214; x=1746467014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b13otSG5T9YE2UWElXsRfq/klSsjCrs3vll5JxMFIWg=;
        b=UBALPa9GC7jXFsAn/1DywB2fAOEw+Ycw+jB75BXLqCW2XI03MXNo5ufY2+gDSRThJ4
         RN9v9CCCJWbajT0Kd945jCB6WWwRzrDtyZpoHD0ON1xZd43pGBkzgUlUBunCSCvrIYqF
         aMvdnMdZLsaCADRmAt/8JkgJjg5t6vmCbfnnVk/7qJNnoFPkqhD2QamYe6pZkHMbyEka
         isnF3eA2xQ8VNDivb1v6Da3uxUjs/DCVAX8FtwxU2DPwKBgLs6uhMhWPe7+P5RRqeXeH
         eWgrCAkM16otq3tqCrx18YCcXirDRasG074LEZSKbdo/8jt/26ybD8THnw8jguAm4JUx
         stZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745862214; x=1746467014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b13otSG5T9YE2UWElXsRfq/klSsjCrs3vll5JxMFIWg=;
        b=EcBe3U0Vq8+Rh0Jkj4jgsHM9GBX02/4gBX7mga6kHS322nL6xAWMpQTkXki4UFDe7Q
         ALCzpw1sqfux43dCn0I9aGtbMiX2S/MDnytzBZGuthPPjwCeU65C+Zxxi+iqEjqXKm5S
         vCrp5SndyPqPSbW23T3QnZeyV7EleE0Zs4pNbqldjDihNzS76eXcbhBxXDHY8BU7xcm0
         KXOlOFa6ULAaD6k8GIrRFevIjMWnb4UVA1L0MYoyTP5VROpGr6ojLcd05kiwjn685tiY
         wiSgvEOZTj0Yz7axmsVG89SRGK3XAliDFrBHtOKjtDNuc7eNRIYNMbWbncURY0xNlnT5
         /DYg==
X-Gm-Message-State: AOJu0Yy/q+uP/2aPgCCI0N0lhA7ngRPqpYTpcMA9rd6Oc7XZJ3B8gD31
	pL8ByUhEzL92rgvezEjk36xgIQ8m5UzGWEps1L1Sexm+XNUTZJBOSlmnZZM3yhO/lPsaV6p0Wy/
	h4AHTzSan9IJufSnlvh7If982uS+9V4RqAieW9p/cVen73X5kUNT7zGXo3o+d8gRUKK7/cU/RCO
	NEMiXMRDk5/4/ft02ZZOLdDAfoiw==
X-Google-Smtp-Source: AGHT+IHdvP7lyYwbk2+MKSLhcPItmAxpa7W6McyocWvOJM+LpQV//QoGdQsxfPunb/KDq69AvZKxXJio
X-Received: from wrbel6.prod.google.com ([2002:a05:6000:2286:b0:39a:be3a:407])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f91:0:b0:391:29f:4f87
 with SMTP id ffacd0b85a97d-3a0894a393emr613583f8f.49.1745862214070; Mon, 28
 Apr 2025 10:43:34 -0700 (PDT)
Date: Mon, 28 Apr 2025 19:43:22 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4034; i=ardb@kernel.org;
 h=from:subject; bh=cblhaOnVfTJ9gIB7KoLwy8L/HaMT+xWe94HrwaoMuAc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYN/n7XlnqlT2OwfzgmoDl2/Klbix1L1ifo27GcrfRkD7
 yb21qR3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlsOMbwv9zKnXv60tUvHWIk
 gvUm7s+/L+a5ybn3yNP2jScXnZmS2sLI0P+vpcr/y67gIL+j35y8svZz3fq6OPV55LlSWdYz2T0 FPAA=
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250428174322.2780170-2-ardb+git@google.com>
Subject: [PATCH] x86/boot/sev: Support memory acceptance in the EFI stub under SVSM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit

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

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: <stable@vger.kernel.org>
Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Tom,

Please confirm that this works as you intended.

Thanks,

 arch/x86/boot/compressed/mem.c |  5 +--
 arch/x86/boot/compressed/sev.c | 40 ++++++++++++++++++++
 arch/x86/boot/compressed/sev.h |  2 +
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index f676156d9f3d..0e9f84ab4bdc 100644
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
index 89ba168f4f0f..0003e4416efd 100644
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
index 4e463f33186d..d3900384b8ab 100644
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
 

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.49.0.906.g1f30a19c02-goog


