Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CC68BD47
	for <lists+linux-efi@lfdr.de>; Mon,  6 Feb 2023 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBFMtw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Feb 2023 07:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjBFMtv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Feb 2023 07:49:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B614223
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 04:49:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B02360EB8
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 12:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF05C433A4;
        Mon,  6 Feb 2023 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675687789;
        bh=EXNH/fSwpA4HsBvvS096eTWjFLTtoETYbymTTVg2QLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8UUMvGzluvZRa23V9J1wIr32NVVFKYAGrzQR5mMboNkaOAet26xM4Do+nqQ6KRTH
         D8CfP7efO25kv3Nli/f1Fxy8UOJh4X0DNS8WH12sPtQEPOoLeFivoam1GnCBhvuvyp
         Ft9AP2ibQcwaXq8t88mnqMhixMyVNEyI+zL2UasmdJGJatuff0rOiIyfqFaR9OCb/q
         IjdG8LKCnysQfds5F/dqOFOAkjPk0uC8KRoFifO2n/OlcWIIUyerAozBgcb7f6DXGz
         VU9i6nWWYskkDhy6gnoqrE+HIJtNnfwOuU3zuttQ5LXt8WgKK+b2TuGlbwMmdAjNjg
         VHgmqVzEoSw8Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 1/3] efi: Discover BTI support in runtime services regions
Date:   Mon,  6 Feb 2023 13:49:36 +0100
Message-Id: <20230206124938.272988-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206124938.272988-1-ardb@kernel.org>
References: <20230206124938.272988-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7231; i=ardb@kernel.org; h=from:subject; bh=EXNH/fSwpA4HsBvvS096eTWjFLTtoETYbymTTVg2QLU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj4PdeY3MXGNqiWpNQ/c8m4MRoWCtxj+e2MZ3Yv 0AcQ5NEywmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+D3XgAKCRDDTyI5ktmP JEE9C/9oH6i96Jd30ffYj9DQEDrLoXGoA/0g7cvdVbN1nRRit5G2f7Rgam61Kq7IES2TDKG3GCV 92AuOwx0m4nVZHg5bfCsyOpOKHFmCeWCHn8qqdDovi/YacgMvit8VU69PqxJ1b9T8o7IN3+A2hs dYKEkApdfwafYoJqIEtW12BL7IR0KcAHIduUCq1+qlZigAGk39lWWI0myJNjtjBIgWmNAXU9HR/ vDWZxLHvmDg/c00RAHN6IlVt3iAvoT7s/4ibmv/lKE3EN+cZzZVtxsiyByTeJSyh1vlMEgybV8P y9Sle+TYkcY6vkAalplPruoSJbqMStKYEOjuUazQpXHCn+Sm3DngUvXprAApA6jaHKtLgQPBq+f 8jER0BA4nqO/TuO9lA7MTDhKnyhWtxhzEAxMzWWtmuiYaLYy0Qx+9m2mVsq3hClZm2JTt+vMPhg antNBVqwuTM4DL6d8EG8KVcgixg7YYaHV4ozOi4JbFAeKKOjey4Flab3w2uDdGBZFNfiE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the generic plumbing to detect whether or not the runtime code
regions were constructed with BTI/IBT landing pads by the firmware,
permitting the OS to enable enforcement when mapping these regions into
the OS's address space.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/efi.h     | 2 +-
 arch/arm/kernel/efi.c          | 5 +++--
 arch/arm64/include/asm/efi.h   | 3 ++-
 arch/arm64/kernel/efi.c        | 3 ++-
 arch/riscv/include/asm/efi.h   | 2 +-
 arch/riscv/kernel/efi.c        | 3 ++-
 arch/x86/platform/efi/efi_64.c | 3 ++-
 drivers/firmware/efi/memattr.c | 7 ++++++-
 include/linux/efi.h            | 8 ++++++--
 9 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index b95241b1ca656f3c..78282ced50387dd3 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -20,7 +20,7 @@ void efi_init(void);
 void arm_efi_init(void);
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
-int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, bool);
 
 #define arch_efi_call_virt_setup()	efi_virtmap_load()
 #define arch_efi_call_virt_teardown()	efi_virtmap_unload()
diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index 882104f43b3b0928..e2b9d2618c6727c6 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -23,7 +23,8 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 }
 
 int __init efi_set_mapping_permissions(struct mm_struct *mm,
-				       efi_memory_desc_t *md)
+				       efi_memory_desc_t *md,
+				       bool ignored)
 {
 	unsigned long base, size;
 
@@ -71,7 +72,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	 * If stricter permissions were specified, apply them now.
 	 */
 	if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
-		return efi_set_mapping_permissions(mm, md);
+		return efi_set_mapping_permissions(mm, md, false);
 	return 0;
 }
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 31d13a6001df49c4..5d47d429672b1bfb 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -27,7 +27,8 @@ bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
 #endif
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
-int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md,
+				bool has_bti);
 
 #define arch_efi_call_virt_setup()					\
 ({									\
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fab05de2e12dd5d8..78ffd5aaddcbbaee 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -110,7 +110,8 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 }
 
 int __init efi_set_mapping_permissions(struct mm_struct *mm,
-				       efi_memory_desc_t *md)
+				       efi_memory_desc_t *md,
+				       bool has_bti)
 {
 	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
 	       md->type != EFI_RUNTIME_SERVICES_DATA);
diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 47d3ab0fcc36a186..29e9a0d84b16682f 100644
--- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -19,7 +19,7 @@ extern void efi_init(void);
 #endif
 
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
-int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
+int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md, bool);
 
 #define arch_efi_call_virt_setup()      ({		\
 		sync_kernel_mappings(efi_mm.pgd);	\
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
index 1aa540350abd31b0..aa6209a74c83ffc2 100644
--- a/arch/riscv/kernel/efi.c
+++ b/arch/riscv/kernel/efi.c
@@ -78,7 +78,8 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 }
 
 int __init efi_set_mapping_permissions(struct mm_struct *mm,
-				       efi_memory_desc_t *md)
+				       efi_memory_desc_t *md,
+				       bool ignored)
 {
 	BUG_ON(md->type != EFI_RUNTIME_SERVICES_CODE &&
 	       md->type != EFI_RUNTIME_SERVICES_DATA);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index b36596bf0fc38f4f..2e6fe430cb07bbbc 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -389,7 +389,8 @@ static int __init efi_update_mappings(efi_memory_desc_t *md, unsigned long pf)
 	return err1 || err2;
 }
 
-static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *md)
+static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *md,
+				      bool has_ibt)
 {
 	unsigned long pf = 0;
 
diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 0a9aba5f9ceff0bf..3cbf00f04c5b60ca 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -129,6 +129,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 					 efi_memattr_perm_setter fn)
 {
 	efi_memory_attributes_table_t *tbl;
+	bool has_bti = false;
 	int i, ret;
 
 	if (tbl_size <= sizeof(*tbl))
@@ -150,6 +151,10 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 		return -ENOMEM;
 	}
 
+	if (tbl->version > 1 &&
+	    (tbl->flags & EFI_MEMORY_ATTRIBUTES_FLAGS_RT_FORWARD_CONTROL_FLOW_GUARD))
+		has_bti = true;
+
 	if (efi_enabled(EFI_DBG))
 		pr_info("Processing EFI Memory Attributes table:\n");
 
@@ -169,7 +174,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 				efi_md_typeattr_format(buf, sizeof(buf), &md));
 
 		if (valid) {
-			ret = fn(mm, &md);
+			ret = fn(mm, &md, has_bti);
 			if (ret)
 				pr_err("Error updating mappings, skipping subsequent md's\n");
 		}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9d455d502ac92b65..df88786b59471714 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -584,11 +584,15 @@ typedef struct {
 
 #define EFI_INVALID_TABLE_ADDR		(~0UL)
 
+// BIT0 implies that Runtime code includes the forward control flow guard
+// instruction, such as X86 CET-IBT or ARM BTI.
+#define EFI_MEMORY_ATTRIBUTES_FLAGS_RT_FORWARD_CONTROL_FLOW_GUARD	0x1
+
 typedef struct {
 	u32 version;
 	u32 num_entries;
 	u32 desc_size;
-	u32 reserved;
+	u32 flags;
 	efi_memory_desc_t entry[0];
 } efi_memory_attributes_table_t;
 
@@ -751,7 +755,7 @@ extern unsigned long efi_mem_attr_table;
  *                           argument in the page tables referred to by the
  *                           first argument.
  */
-typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *);
+typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
 extern int efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
-- 
2.39.1

