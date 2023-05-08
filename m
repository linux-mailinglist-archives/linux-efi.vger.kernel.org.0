Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63D6FA091
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjEHHGO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjEHHFc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41E1A48B;
        Mon,  8 May 2023 00:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1ED61FAB;
        Mon,  8 May 2023 07:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC39C4339B;
        Mon,  8 May 2023 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529491;
        bh=1s9q3daoOQOBrHBekUCXV36l5RIRydobOaLGHT6RGX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dizxd39pyJpk7qPy00tyI7ARKRjwRCg6IbXhfAaFqS0fOwEzHwhyiE+1QoeLCnLWc
         JbwYT6S6c4DtlbA5C1sv7hulLiRj01KNcNbkMnI4IBM71JZicp1+sx4Y2SOVYVhyM/
         h0v/3N5R92HJjDjb5bhpKH7mVE++907eyPB6y/nfWDZjYjz/v8eFehJBgDtK4iu1l4
         dRcdVERloU/AOCE6ZVaSqPMNO9EvQvGNjCfTx9bIUAbF/93bLXpxKOsZ5hqyXAnZiA
         JNkvWN2KtBVLrJ6h3vzE8uBrV+dAlfdod0j7SUY7lKs9ANMfjXOw+7ymkaABdHNuhW
         OQara+MdLdPpQ==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while running in the firmware
Date:   Mon,  8 May 2023 09:03:27 +0200
Message-Id: <20230508070330.582131-18-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4790; i=ardb@kernel.org; h=from:subject; bh=1s9q3daoOQOBrHBekUCXV36l5RIRydobOaLGHT6RGX8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3j5DUbGKXbHtG99vV/+zWC9A+SD3nk2i2485Lvu/7 krjnd3MHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiHy8z/NNLYbZetyhzwqPG +cWubxYvXOhTfb7+m8JZxguvt+/iqGhhZNgcumHK2ei/33QOaG/ucT5cvmRaaPePdV99Jtzf4LF 0Bws3AA==
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

The decompressor executes in an environment with little or no access to
a console, and without any ability to return an error back to the caller
(the bootloader). So the only recourse we have when the SEV/SNP context
is not quite what the kernel expects is to terminate the guest entirely.

This is a bit harsh, and also unnecessary when booting via the EFI stub,
given that it provides all the support that SEV guests need to probe the
underlying platform.

So let's do the SEV initialization and SNP feature check before calling
ExitBootServices(), and simply return with an error if the SNP feature
mask is not as expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c          | 12 ++++++++----
 arch/x86/include/asm/sev.h              |  4 ++++
 drivers/firmware/efi/libstub/x86-stub.c | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c890887b9a..19c40873fdd209b5 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -315,20 +315,24 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(void)
+{
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		return 0;
+	return sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
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
+	unsupported = snp_get_unsupported_features();
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1eb25..bf27b91644d0da5a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern void sev_enable(struct boot_params *bp);
 
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
@@ -202,12 +203,14 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+u64 snp_get_unsupported_features(void);
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
@@ -225,6 +228,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+static inline u64 snp_get_unsupported_features(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index ce8434fce0c37982..33d11ba78f1d8c4f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 
@@ -714,6 +715,22 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
 	p->efi->efi_memmap_size		= map->map_size;
 
+	/*
+	 * Call the SEV init code while still running with the firmware's
+	 * GDT/IDT, so #VC exceptions will be handled by EFI.
+	 */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		u64 unsupported;
+
+		sev_enable(p->boot_params);
+		unsupported = snp_get_unsupported_features();
+		if (unsupported) {
+			efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
+				unsupported);
+			return EFI_UNSUPPORTED;
+		}
+	}
+
 	return EFI_SUCCESS;
 }
 
-- 
2.39.2

