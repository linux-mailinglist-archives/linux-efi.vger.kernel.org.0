Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8E7255AE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbjFGH26 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjFGH1I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925D2D79;
        Wed,  7 Jun 2023 00:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BC6633D6;
        Wed,  7 Jun 2023 07:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD6C433D2;
        Wed,  7 Jun 2023 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122717;
        bh=FifYFQbUgsc3xafluaKb/KA+ANrpnvv0InNGmp59Xxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLobFQI3nq61lNAKvAy0REEflUflfwMGrkYDtNrNYQR2B3eGyqA9Ieaxh95UNDqpE
         uFedpF9qe2WaEr+c3U9zmy8N6JI3IkQWa7IjP1xLF+/tZtDK5+isuFGO6FO1+FX6Uo
         WnxtZybrW6vIFDvmFHY3qH1rlav3huINWl+ndrCQFDJ4amPviqu0OnxIxZFzllilS6
         9FjDm2R6lK3KpTWumt1jqP98UfNgKsvlzElLn/sOX2kUu7crVJAIS54vrsF2onqa+u
         DdDFP3+/Fv2JngSKHdNvY24HuW1eoDJ3ptYGOwsAFnrPvGUG5q+2EwoWJiL0cKhWRq
         y2XZiClpN6wWA==
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
Subject: [PATCH v5 19/20] x86/efistub: Perform SNP feature test while running in the firmware
Date:   Wed,  7 Jun 2023 09:23:41 +0200
Message-Id: <20230607072342.4054036-20-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6538; i=ardb@kernel.org; h=from:subject; bh=FifYFQbUgsc3xafluaKb/KA+ANrpnvv0InNGmp59Xxo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBoOYn5601kzxYG7UMTh7aM2n1ZmUxsVVueuHZ/1Ofc 3Idu5PeUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbysYvhD5fxtouPBN57/ps0 c5+VQuzRmWoTthY6+BqVuHzvPbPohBUjw7UXuhZLynKXmhnMkDl9vpg1Woo/f6HW8jLJoP7yAy2 fOAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 arch/x86/boot/compressed/sev.c          | 71 +++++++++++---------
 arch/x86/include/asm/sev.h              |  4 ++
 drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
 3 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3cc752..9593bc80c9c6b89d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -367,6 +367,11 @@ static void enforce_vmpl0(void)
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
@@ -380,7 +385,7 @@ void snp_check_features(void)
 	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
 	 * as part of the guest boot failure.
 	 */
-	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
@@ -390,10 +395,42 @@ void snp_check_features(void)
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
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return 0;
+
+	/* Set the SME mask if this is an SEV guest. */
+	sme_me_mask = BIT_ULL(ebx & 0x3f);
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
+}
+
+void sev_enable(struct boot_params *bp)
+{
 	bool snp;
 
 	/*
@@ -410,37 +447,13 @@ void sev_enable(struct boot_params *bp)
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
@@ -460,8 +473,6 @@ void sev_enable(struct boot_params *bp)
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
-
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 86e1296e87f513b7..081c39b0e8d0d208 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -207,6 +207,8 @@ bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -232,6 +234,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 }
 
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index abcd5703e9f3f980..1015ef883f5850a4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -790,6 +791,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
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
@@ -820,6 +834,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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

