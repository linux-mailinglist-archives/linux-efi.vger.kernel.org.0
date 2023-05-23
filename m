Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684370D9E9
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjEWKGo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjEWKGm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 06:06:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59416FF
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 03:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDCB6300A
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 10:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEECC433D2;
        Tue, 23 May 2023 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684836400;
        bh=7psQwV392CjQ7zhIF+j5mCvHPI1vovfh6RDuvWJ1xRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=La7a/uL5uUQfmoQrY2u0/0v/xeY03BLxiwwsMRHyHtZhBJwG/SnjXnBz6WCtHrMOH
         y032wZPO/bzE86oTV4wOSzAJBPIyztjboU5bRMcDVTSY/DF/FZqfX2ZfNbBUOuiNI9
         rMBKZLNGiqEvdwHLsqq71ic3A0UUq7rJPQBFRhB/5/vogBu0i93dDgM+phGtgWr1Qw
         4TBgMQVsP+yLSbEIK30Tmp+WcaWWg8p3i1hwoucKrYtiutj8ZvzdH2AFovtfTvX+VC
         x7pzwiM+3u5n6v7F1wgzcv2TuIei+t9yrlNp485enKqLfDfgpSx1TmS9KVyUM1b6NY
         AjFfHb6tm/awQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v3a 20/21] x86/efistub: Check SEV/SNP support while running in the firmware
Date:   Tue, 23 May 2023 12:06:18 +0200
Message-Id: <20230523100618.728795-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-21-ardb@kernel.org>
References: <20230522071415.501717-21-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7996; i=ardb@kernel.org; h=from:subject; bh=7psQwV392CjQ7zhIF+j5mCvHPI1vovfh6RDuvWJ1xRI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVnguTxKsETHraiIS7x62tP5q5/8KYm4372akPWyxG/v py4u/d2RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIHA6G/8GMUz70XvjtHbH5 yqsjuopTvF4sK/6x4mz9reQ5O7llG3sY/srkfdNbGrNEirVv4uF5bqrbNJVSzlsqppUxcni37kh ewQ8A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before refactoring the EFI stub boot flow to avoid the legacy bare metal
decompressor, duplicate the SEV initialization and SNP feature check in
the EFI stub before handing over to the kernel proper.

The SNP feature check can be performed while running under the EFI boot
services, which means we can fail gracefully and return an error to the
bootloader if the loaded kernel does not implement support for all the
features that the hypervisor enabled.

The SEV initialization must be done after calling ExitBootServices(), to
ensure that it does not corrupt any state that the firmware itself still
relies upon.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
This is a replacement patch for v3 20/21

 arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
 arch/x86/include/asm/sev.h              |  6 ++
 drivers/firmware/efi/libstub/x86-stub.c | 23 ++++++
 3 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c890887b9a..be021e24f1ece421 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -315,6 +315,11 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(u64 status)
+{
+	return status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+}
+
 void snp_check_features(void)
 {
 	u64 unsupported;
@@ -328,7 +333,7 @@ void snp_check_features(void)
 	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
 	 * as part of the guest boot failure.
 	 */
-	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
@@ -338,10 +343,38 @@ void snp_check_features(void)
 	}
 }
 
-void sev_enable(struct boot_params *bp)
+u64 sev_get_status(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	struct msr m;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return 0;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return 0;
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
+}
+
+void sev_enable(struct boot_params *bp)
+{
+	unsigned int eax, ebx, ecx, edx;
 	bool snp;
 
 	/*
@@ -358,37 +391,14 @@ void sev_enable(struct boot_params *bp)
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Check for the SME/SEV feature:
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
+	/* Set the SME mask if this is an SEV guest. */
+	sev_status = sev_get_status();
+	if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
 	}
 
-	/* Set the SME mask if this is an SEV guest. */
-	boot_rdmsr(MSR_AMD64_SEV, &m);
-	sev_status = m.q;
-	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
-		return;
-
 	/* Negotiate the GHCB protocol version. */
 	if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
 		if (!sev_es_negotiate_protocol())
@@ -409,6 +419,14 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1eb25..b08f58148c7252d2 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern void sev_enable(struct boot_params *bp);
 
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
@@ -202,12 +203,15 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
@@ -225,6 +229,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+static inline u64 snp_get_unsupported_features(void) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index fcdae5db0c63c7e5..32c69fbdcee9c779 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -756,6 +757,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
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
@@ -785,6 +799,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	if (have_unsupported_snp_features())
+		efi_exit(handle, EFI_UNSUPPORTED);
+
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
 		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
 		if (efi_dxe_table &&
@@ -923,6 +940,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/*
+	 * Call the SEV init code while still running with the firmware's
+	 * GDT/IDT, so #VC exceptions will be handled by EFI.
+	 */
+	sev_enable(boot_params);
+
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		efi_5level_switch();
 
-- 
2.39.2

