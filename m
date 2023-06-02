Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0284A71FF2A
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjFBKZR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFBKYJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E01710;
        Fri,  2 Jun 2023 03:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7DD64E63;
        Fri,  2 Jun 2023 10:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02497C4339C;
        Fri,  2 Jun 2023 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701414;
        bh=Uzc6TTIkVLCBtkTdTqlEAm179xBBwMbrhTFacsgdIgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYk1Zs4tYhSRbRmPt6QrbkWNXwtU/5wEasqMtMC8VqgbAXOCdhpbpGfJDr7UIH/UL
         DAG4Qr2okHRoXHaBooODGt+jY8vdrofyLbC8MAA7e+JqMQoJqNE6tn6b1molzC4kKf
         p4GqArNxm3NOKBiQLhq4S2692DhKyyPTd30gNrzGMAcnnU2fJmjlfoRC2eovkjt+1T
         UUTJgcj0m+P5T7gf5dewMHv2EJ4l0A/6MOeF/g+BHgSTXnjVlpZZnvEV1H8nHRlcxV
         agDzt81CGGipQSzrDszyvIcyNqClz8vqn3qkJWnn2NU6TxkI00f7CtDUYjiNU/JJIi
         a4qBd7O6uhyKw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 20/21] x86/efistub: Perform SNP feature test while running in the firmware
Date:   Fri,  2 Jun 2023 12:13:12 +0200
Message-Id: <20230602101313.3557775-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6505; i=ardb@kernel.org; h=from:subject; bh=Uzc6TTIkVLCBtkTdTqlEAm179xBBwMbrhTFacsgdIgc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywI6G13uSLty0ypBXNL8/nX/CnRtbrQvfTFeMO2w5j ylcp0ezo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk/DjD/7xn6vPNjk145idQ LZXgkXdllcjlTatvv5LcnDt1asiWTamMDA2889Td5+4M+CHXtrlBLVv4kpKnZt7sI855My4wx3z J4AQA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before refactoring the EFI stub boot flow to avoid the legacy bare metal
decompressor, duplicate the SNP feature check in the EFI stub before
handing over to the kernel proper.

The SNP feature check can be performed while running under the EFI boot
services, which means we can fail gracefully and return an error to the
bootloader if the loaded kernel does not implement support for all the
features that the hypervisor enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
 arch/x86/include/asm/sev.h              |  4 ++
 drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
 3 files changed, 67 insertions(+), 28 deletions(-)

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
index 13dc2a9d23c1eb25..e5aad673194698b8 100644
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
@@ -225,6 +227,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2d3282d2ed6eb756..f9d203b5ee6236e8 100644
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
-- 
2.39.2

