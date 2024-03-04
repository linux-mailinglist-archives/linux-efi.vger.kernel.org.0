Return-Path: <linux-efi+bounces-704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782DE870043
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A141F23EE5
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80338DC8;
	Mon,  4 Mar 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhTKS5LJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00238DE6
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551248; cv=none; b=byzWeJEI4jN40shY/jm7f7g09IXOSuEK3ocT1QkYPT7odyT1LDDGrU1YO5bmnd3NKt9LVtSFzcVYJUq8ixev4Q+Bxs4CZmIubHakJTbAtsM69/yEILVvBoTAfHsqklWM806WoWslLJPoAGIlFVq4Uj0frv23L7F6WonGW1vT00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551248; c=relaxed/simple;
	bh=MPjG+81at1ckc7jlgy4H92kTOlHwGNwT7cArqw8ofCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AA2KalLW5PHSgQS/nzfmsXawSa3jMxG+oTPDWViVnOjtp4GChhJwfh+yoRxziiOiwcqDA6JumjvGL85BEMLBNBjtkOcldJx4v2JakzkmG/WShQzX9mOped0JdbLXvaMODm7KlqDRVm1lN+61b/CWUONCsjfHzeuSY7G3p4xi3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhTKS5LJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608852fc324so62681967b3.2
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551246; x=1710156046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQEOl+zFHutZjuVUfqmQ3HrmxCFhMCilSMNU7sG1cos=;
        b=BhTKS5LJTG/58px8rU6SlUhsyLCHs5qYA/AeMry5Ilf+1elNuTQQ/9BnPdaiBjfUCO
         QdhpCdm4PQA6m4SMz0W4SbfL2vyJBw2mBrrC5GTkaxyofd/ief+04SM51Y2eR5ngtTVp
         KJwYEaygEgO7HJa/pt/4DbKZdteZgOBZIKT7woE5Qd2TgZJ+ocMqAQ81J/cSZV41sXyV
         srs4Uaspom5pPlrkCccdvMJxCrCuk7+zmn1LzctxR+4koFcP7eQUcEWNq5x3z2A7fOX6
         uFUrmw5dO+tGhS1Vpu/st1kdy9ZFKYwDAyUF4i+zEofwyBQONf9//fyNcb45t2s5bc/o
         eeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551246; x=1710156046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQEOl+zFHutZjuVUfqmQ3HrmxCFhMCilSMNU7sG1cos=;
        b=PkZ3DjuGZ0IAmhGwrz9nKiVS7L4rLW24iTYlGS54MYl+Q4EyNqrznfeQfcI+it6/gN
         3UntJvQd9nzCSaQbQYpHVsOh/mzIV+herC7Yp61ya7tJt+TYEWjx03FurG63fSmRy374
         YMgWi0g32gzDUJ3m0aluy9OHA3113EovfEoyPIVpVjeGkWFCH2xXlRB+8rQFvxddxMwI
         A864lNQBKmrK2MADDyXchUUPqdl2rjAaKCeL7Lw3HPRu0lMRQN4oAKvV8i353blRIw45
         VIIN6EBsZ/OerLGkWSSnW4/z4tBACDnLXAdpxPEDHIgvJ8vMcn3kQP7ZEuzDCm7tr7jZ
         cOqA==
X-Gm-Message-State: AOJu0YyRKgdrfZqutjFLC8b4yAZEjVQn3hLUOQblr2O8jUSXTnCGL0iw
	okNuDQlPnpKZVDEBla0l2pCAn/fhJiRnK1qO9d7qY/B4LwkKLmRuzqsMoJGgeWi/+q4E9g==
X-Google-Smtp-Source: AGHT+IFGB6giO5Ze4dV9T1NHIdN/QLerdM5tPY4C7V4SF7DAhcR55OWFVMPbQeMhnNQkJe2VDWHIsumx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:110a:b0:dbd:b165:441 with SMTP id
 o10-20020a056902110a00b00dbdb1650441mr2270477ybu.0.1709551246410; Mon, 04 Mar
 2024 03:20:46 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:50 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8077; i=ardb@kernel.org;
 h=from:subject; bh=Cz4GkNTDeebiqFwn4gZLKTQjPsXyvhZTNZmHVYzdE48=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpurASmwWLeeybzyceVWrk8JlUMelr13qVWdPUFB0WH
 L7z4VdaRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIziyGv2L/58v+vsfD/cqd
 M+3IzcMh7WVcK4xbHjx+6zl/Spp3SxjDX/EqRm/n2cYWOpN11wTs2n9e3Tj+3zWz7ownK066dEQ IMgIA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-32-ardb+git@google.com>
Subject: [PATCH stable-v6.1 12/18] x86/efistub: Perform SNP feature test while
 running in the firmware
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 31c77a50992e8dd136feed7b67073bb5f1f978cc upstream ]

Before refactoring the EFI stub boot flow to avoid the legacy bare metal
decompressor, duplicate the SNP feature check in the EFI stub before
handing over to the kernel proper.

The SNP feature check can be performed while running under the EFI boot
services, which means it can force the boot to fail gracefully and
return an error to the bootloader if the loaded kernel does not
implement support for all the features that the hypervisor enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-23-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c          | 112 ++++++++++++--------
 arch/x86/include/asm/sev.h              |   5 +
 drivers/firmware/efi/libstub/x86-stub.c |  17 +++
 3 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 9c91cc40f456..8b21c57bc470 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,20 +327,25 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(u64 status)
+{
+	if (!(status & MSR_AMD64_SEV_SNP_ENABLED))
+		return 0;
+
+	return status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+}
+
 void snp_check_features(void)
 {
 	u64 unsupported;
 
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-		return;
-
 	/*
 	 * Terminate the boot if hypervisor has enabled any feature lacking
 	 * guest side implementation. Pass on the unsupported features mask through
 	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
 	 * as part of the guest boot failure.
 	 */
-	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
@@ -350,35 +355,22 @@ void snp_check_features(void)
 	}
 }
 
-void sev_enable(struct boot_params *bp)
+/*
+ * sev_check_cpu_support - Check for SEV support in the CPU capabilities
+ *
+ * Returns < 0 if SEV is not supported, otherwise the position of the
+ * encryption bit in the page table descriptors.
+ */
+static int sev_check_cpu_support(void)
 {
 	unsigned int eax, ebx, ecx, edx;
-	struct msr m;
-	bool snp;
-
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 to ensure that uninitialized values from
-	 * buggy bootloaders aren't propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address = 0;
-
-	/*
-	 * Do an initial SEV capability check before snp_init() which
-	 * loads the CPUID page and the same checks afterwards are done
-	 * without the hypervisor and are trustworthy.
-	 *
-	 * If the HV fakes SEV support, the guest will crash'n'burn
-	 * which is good enough.
-	 */
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	if (eax < 0x8000001f)
-		return;
+		return -ENODEV;
 
 	/*
 	 * Check for the SME/SEV feature:
@@ -393,6 +385,35 @@ void sev_enable(struct boot_params *bp)
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
 	if (!(eax & BIT(1)))
+		return -ENODEV;
+
+	return ebx & 0x3f;
+}
+
+void sev_enable(struct boot_params *bp)
+{
+	struct msr m;
+	int bitpos;
+	bool snp;
+
+	/*
+	 * bp->cc_blob_address should only be set by boot/compressed kernel.
+	 * Initialize it to 0 to ensure that uninitialized values from
+	 * buggy bootloaders aren't propagated.
+	 */
+	if (bp)
+		bp->cc_blob_address = 0;
+
+	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	if (sev_check_cpu_support() < 0)
 		return;
 
 	/*
@@ -403,26 +424,8 @@ void sev_enable(struct boot_params *bp)
 
 	/* Now repeat the checks with the SNP CPUID table. */
 
-	/* Recheck the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Recheck for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV is supported */
-	if (!(eax & BIT(1))) {
+	bitpos = sev_check_cpu_support();
+	if (bitpos < 0) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -454,7 +457,24 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(bitpos);
+}
+
+/*
+ * sev_get_status - Retrieve the SEV status mask
+ *
+ * Returns 0 if the CPU is not SEV capable, otherwise the value of the
+ * AMD64_SEV MSR.
+ */
+u64 sev_get_status(void)
+{
+	struct msr m;
+
+	if (sev_check_cpu_support() < 0)
+		return 0;
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7ca5c9ec8b52..e231638ba19a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -202,6 +202,8 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -225,6 +227,9 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 01af018b9315..8d3ce383bcbb 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -747,6 +748,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+static bool have_unsupported_snp_features(void)
+{
+	u64 unsupported;
+
+	unsupported = snp_get_unsupported_features(sev_get_status());
+	if (unsupported) {
+		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
+			unsupported);
+		return true;
+	}
+	return false;
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -777,6 +791,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	if (have_unsupported_snp_features())
+		efi_exit(handle, EFI_UNSUPPORTED);
+
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
 		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
 		if (efi_dxe_table &&
-- 
2.44.0.278.ge034bb2e1d-goog


