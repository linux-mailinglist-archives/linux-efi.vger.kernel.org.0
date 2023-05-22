Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD270B64D
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjEVHRr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEVHRN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA35C1;
        Mon, 22 May 2023 00:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99CC61DD4;
        Mon, 22 May 2023 07:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732C5C4339E;
        Mon, 22 May 2023 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739757;
        bh=6oUMrt+Q90a10bD/8IHJeLA9pGO90K+akqZ6KAUmlwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXnVT3BBGvOGBrGEKonh+CX6QVme5/hVLSlw2yXeQXl2TLB09u+M3bh0UJGbN7e3F
         o8U8YhxkGjydM1bYGVigVs/MF0KAzwZLi5LYKcr1o5XY3UnGB2ww+7hjypc/bpEeqe
         izLcMA6n31A6gToJtRiUFZxrk7VJg7Odjtp+/9+fJg4kty9m2+PsdXmxw6vFWcLZOF
         rfl2lBhzbnM5V5Bo83XyeOR7f/BzdTfoI96wdGn21m6cXrIBFlVv1FQn8pL5cV1VOt
         RUKgSvqCDSyo3ss+WbaGlRvPs8PxDlIvcldFKFzdCDOWAcLG76Dktm2+sb9RtS0tvi
         Pydsneaa0xVqw==
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
Subject: [PATCH v3 20/21] x86/efistub: Check SEV/SNP support while running in the firmware
Date:   Mon, 22 May 2023 09:14:14 +0200
Message-Id: <20230522071415.501717-21-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5088; i=ardb@kernel.org; h=from:subject; bh=6oUMrt+Q90a10bD/8IHJeLA9pGO90K+akqZ6KAUmlwE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzNXusDBrtcaNl5M7/t9ojDjNn1TBPrvD9+Knc1r97 rd8nz7oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJaGf4nzbt4eUn1RdK08// X7SmYN975qIrAQVKX1i/8k/dHaCXuIHhf8TFRb+qSy8cfizF/+dYeVBLi8XlrmdXvFfZ/fsur5j 3lgkA
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

This must be done after calling ExitBootServices(), to ensure that the
SEV initialization does not corrupt any state that the firmware itself
still relies on. This means that, unfortunately, the only recourse
available when the SNP feature mask contains unsupported features is to
terminate the virtual machine, which is what the bare metal decompressor
does as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c          | 19 ++++++++++++++-----
 arch/x86/include/asm/sev.h              |  6 ++++++
 drivers/firmware/efi/libstub/x86-stub.c | 17 +++++++++++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c890887b9a..d33d48359d09bfb5 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -315,23 +315,32 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(void)
+{
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		return 0;
+	return sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+}
+
+void sev_es_terminate_snp_unsupported(void)
+{
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
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
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+			sev_es_terminate_snp_unsupported();
 
 		sev_es_ghcb_terminate(boot_ghcb, SEV_TERM_SET_GEN,
 				      GHCB_SNP_UNSUPPORTED, unsupported);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1eb25..084a91aa5a6c708f 100644
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
+u64 snp_get_unsupported_features(void);
+void sev_es_terminate_snp_unsupported(void);
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
+static inline void sev_es_terminate_snp_unsupported(void) {}
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index fcdae5db0c63c7e5..02633199a8502b71 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -923,6 +924,22 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/*
+	 * Call the SEV init code while still running with the firmware's
+	 * GDT/IDT, so #VC exceptions will be handled by EFI.
+	 */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		u64 unsupported;
+
+		sev_enable(boot_params);
+		unsupported = snp_get_unsupported_features();
+		if (unsupported) {
+			efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
+				unsupported);
+			sev_es_terminate_snp_unsupported();
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		efi_5level_switch();
 
-- 
2.39.2

