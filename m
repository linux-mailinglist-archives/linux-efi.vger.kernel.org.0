Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FB74EA27
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGKJSz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjGKJRw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA6268B;
        Tue, 11 Jul 2023 02:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A368C613FB;
        Tue, 11 Jul 2023 09:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E281C433CB;
        Tue, 11 Jul 2023 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066989;
        bh=iOYBWQy+OpWZQubKe6z0Ew+fNwxurwkduvPjZF5oT8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYrBIkVcfxmb6zFmo0/hlRdFo7f5a+f0b6du55Bc42cNRzYDUT+apoySvjQwkHJrs
         TxLTJv50S2aRlI7LZ1hOYaF7vt47ZyRCY6rMC68NY2sFjNUruNMZlnA5+DCxzGiMMB
         +jDOzcy183mhAVFR33hQt5D12ur/8xfg/6J9Ddp2ilv+wYjfaHgzx/ERTovmM1JNS9
         dcHk/wspDHClt01VaTKGO1ObIImdfByc6iyUziPSpTTmn/sK12889TRgr3l7OrkVPC
         QPmDfOtOs5WczJGeqd04c8WwgOXPdS+KP2d7xzYmYNGb3x4EMl40Hox3Ot45LNcxzB
         jHSrbPQ2PJoeg==
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
Subject: [PATCH v6 20/21] x86/efistub: Perform SNP feature test while running in the firmware
Date:   Tue, 11 Jul 2023 11:14:52 +0200
Message-Id: <20230711091453.2543622-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6913; i=ardb@kernel.org; h=from:subject; bh=iOYBWQy+OpWZQubKe6z0Ew+fNwxurwkduvPjZF5oT8Y=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbPcE9bO7Pxws+jg9nDNqU/pJhQ8vqsyPfJuiePLal qWCE9TKO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEZscxMjQVm03JV5H6lx7K ZviqgeOCiuzq7WevzmLr3sS1Om7zrTWMDJ/KXnd9evXr/k8zNSmmIxKvdtfMvuB6YOWUd1vj+/r +3+QDAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/boot/compressed/sev.c          | 91 ++++++++++++++------
 arch/x86/include/asm/sev.h              |  4 +
 drivers/firmware/efi/libstub/x86-stub.c | 17 ++++
 3 files changed, 86 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3cc752..da25959f618ed398 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -367,20 +367,25 @@ static void enforce_vmpl0(void)
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
@@ -390,10 +395,45 @@ void snp_check_features(void)
 	}
 }
 
-void sev_enable(struct boot_params *bp)
+/*
+ * sev_check_support - Check for SEV support in the CPU capabilities
+ *
+ * Returns < 0 if SEV is not supported, otherwise the position of the
+ * encryption bit in the page table descriptors.
+ */
+static int sev_check_support(void)
 {
 	unsigned int eax, ebx, ecx, edx;
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return -ENODEV;
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
+		return -ENODEV;
+
+	return ebx & 0x3f;
+}
+
+void sev_enable(struct boot_params *bp)
+{
 	struct msr m;
+	int bitpos;
 	bool snp;
 
 	/*
@@ -410,26 +450,8 @@ void sev_enable(struct boot_params *bp)
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
+	bitpos = sev_check_support();
+	if (bitpos < 0) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -461,7 +483,24 @@ void sev_enable(struct boot_params *bp)
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
+	if (sev_check_support() < 0)
+		return 0;
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 66c806784c5256bd..b97d239e18ea25fc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -210,6 +210,8 @@ bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -235,6 +237,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 }
 
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index efb4f5eda6784026..3681700702126615 100644
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

