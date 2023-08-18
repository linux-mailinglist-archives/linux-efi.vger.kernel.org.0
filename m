Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2C780B38
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376703AbjHRLiR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376695AbjHRLhq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F92112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E2861182
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AEFC433CB;
        Fri, 18 Aug 2023 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358664;
        bh=AlXtUSfmgQDJEeIgIXVb9iOmWqjJa0RzB4mpyp7T7lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrGmOczGoissiN/pI1DaGIsRVgfXqWev0Y+jtQ4l9nsIx3ad2Pka3iS9FQkAw64Ar
         VmqUhvc8NOcbnGe4tkvSOUjDgDSA8pjbRn1r1NW58CY2AgrEgiIcE5iIk6Fe/j00eC
         7f5o0F+d2UOHuEeDSse0xmyOBIb7b2pQYOU3CsDtD0fs1lbkF0oXV/W+uQ3E3MzFy3
         IR5uwwskiNWP0I+NlHkoEGivE8TTPE3EtSNNEnyD1iFX+wlMc1ILIh5pSjyGNsdHJU
         ZsBJZhi44FLaKb97hg2P9UrDXfMqlMsSlp7b/glSLtEhTYO+uq76y1G55L/QEs3v41
         cUg8Jcbgi2IUg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 03/11] efi/riscv: Move EFI runtime call setup/teardown helpers out of line
Date:   Fri, 18 Aug 2023 13:37:16 +0200
Message-Id: <20230818113724.368492-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=ardb@kernel.org; h=from:subject; bh=AlXtUSfmgQDJEeIgIXVb9iOmWqjJa0RzB4mpyp7T7lM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++NsN17ikehRWH1t32K3rpZOlx/pVgpaui5oi/26Re 6uU9pG5o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk+15GhlW/VOM/sQk/jtr7 8ej02PIQx+rCU+opJuWLo/+c0lXgSmNkeHZojekzZUlrl9l746V6PBgqXzKdXh/9vofR/DdnrvY cNgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Only the arch_efi_call_virt() macro that some architectures override
needs to be a macro, given that it is variadic and encapsulates calls
via function pointers that have different prototypes.

The associated setup and teardown code are not special in this regard,
and don't need to be instantiated at each call site. So turn them into
ordinary C functions and move them out of line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/include/asm/efi.h         | 10 ++--------
 drivers/firmware/efi/riscv-runtime.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 29e9a0d84b16682f..8a6a128ec57fc02b 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -21,12 +21,6 @@ extern void efi_init(void);
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, bool);
 
-#define arch_efi_call_virt_setup()      ({		\
-		sync_kernel_mappings(efi_mm.pgd);	\
-		efi_virtmap_load();			\
-	})
-#define arch_efi_call_virt_teardown()   efi_virtmap_unload()
-
 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
 
 /* Load initrd anywhere in system RAM */
@@ -46,8 +40,8 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	efi_get_kimg_min_align()
 
-void efi_virtmap_load(void);
-void efi_virtmap_unload(void);
+void arch_efi_call_virt_setup(void);
+void arch_efi_call_virt_teardown(void);
 
 unsigned long stext_offset(void);
 
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index d0daacd2c903f182..09525fb5c240e668 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -130,14 +130,25 @@ static int __init riscv_enable_runtime_services(void)
 }
 early_initcall(riscv_enable_runtime_services);
 
-void efi_virtmap_load(void)
+static void efi_virtmap_load(void)
 {
 	preempt_disable();
 	switch_mm(current->active_mm, &efi_mm, NULL);
 }
 
-void efi_virtmap_unload(void)
+static void efi_virtmap_unload(void)
 {
 	switch_mm(&efi_mm, current->active_mm, NULL);
 	preempt_enable();
 }
+
+void arch_efi_call_virt_setup(void)
+{
+	sync_kernel_mappings(efi_mm.pgd);
+	efi_virtmap_load();
+}
+
+void arch_efi_call_virt_teardown(void)
+{
+	efi_virtmap_unload();
+}
-- 
2.39.2

