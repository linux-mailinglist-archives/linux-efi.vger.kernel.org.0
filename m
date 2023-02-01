Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401416866CC
	for <lists+linux-efi@lfdr.de>; Wed,  1 Feb 2023 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjBANZx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Feb 2023 08:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBANZt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Feb 2023 08:25:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BB469A
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 05:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 381F4617A5
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D2C4339B;
        Wed,  1 Feb 2023 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257947;
        bh=7Y4MtRYYFDXeW9NgA5qdXTCRHarDb/Kd7ng404/n2WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmkIotHxzpkW1bNOM23WuaJc99SFqfW79VtRA3w9qnQhEOClWO2gkOrAINOB8YA5p
         /1lgiQ0PRqM+2BLbFaWRs2Be7W+iGAN/8RndGnaxVg8GWmxbzz1i1qkCVJDVGbDqET
         dLCTo0HNK+RSqlUVM8S56HfHRWTl2pSTPLifnLNjbAxzp6BC1gQZW9bQu24p9IimiL
         BoY8JrSDCTByiUJvqJQi10eNMaUpF79N9fMWdUEBQ+LtqvFyVsNVRyb3Bv4CwGTjQN
         b2ZA6fu+NgO5xlltQGZtuLKCAJ/2lK8KCKHiFnBZEU+e9L0x3UmJ551RFyI/rjBIaX
         SeRjjalJFFkPA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] efi: Discover BTI support in runtime services regions
Date:   Wed,  1 Feb 2023 14:25:39 +0100
Message-Id: <20230201132540.2196065-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201132540.2196065-1-ardb@kernel.org>
References: <20230201132540.2196065-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7423; i=ardb@kernel.org; h=from:subject; bh=7Y4MtRYYFDXeW9NgA5qdXTCRHarDb/Kd7ng404/n2WU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj2mhSX68T6D8lFe9nZxa9q3eF+QX9rWG87w/GL RDLN4EeRt2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9poUgAKCRDDTyI5ktmP JO4iC/sENnNd5Vbx95tR29FvzhCjHSX9hgnhmj+g3jTHYeworBsJ0q/yaLRp2xdkPhEl0U9paV+ eNpqkmK1HoWQ55aCY+Uk4XrlPAFRM3f73CiZ2WcC8YfgE0AoaUSSTRJ4SYk7ra7SbVWcLKDMe43 wYrnFW95GCJRiJcGLGnAHFq62MPruRMB0MrJ1LXwB+dGWA3A7r5q14YQ3wF359Cj8kglLJgxBUc Il5aeH577CXdDtaFk/LJs8M4tBPL3bm0/Tcufe+w8/zP0tSbY6DuP0fS9ErQMNa4kzAkpRUb4O8 q55npC+aFIt3oktMis1DvIxflscnvXMPXyykJZktDFi6R+fGzJE2gQRQExer35Py/UWF8X8quXl Sik64FyZuRDxGJuubPySPKWsd5h1A5ggB57QoTStJJDSqrZMzUtQbpKbi+L5JUItGcw7ZPp3Zpw UItBZVlXhisi2AEVFacx2CbsRpj0yBxzMDcwk+yaZ646pFYbAo2f/1H8f1wr2cDIlqi7c=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
---
 arch/arm/include/asm/efi.h     | 2 +-
 arch/arm/kernel/efi.c          | 5 +++--
 arch/arm64/include/asm/efi.h   | 3 ++-
 arch/arm64/kernel/efi.c        | 3 ++-
 arch/riscv/include/asm/efi.h   | 2 +-
 arch/riscv/kernel/efi.c        | 3 ++-
 arch/x86/platform/efi/efi_64.c | 3 ++-
 drivers/firmware/efi/memattr.c | 9 +++++++--
 include/linux/efi.h            | 8 ++++++--
 9 files changed, 26 insertions(+), 12 deletions(-)

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
index acaa39f6381a084b..8adca3b83c62a52b 100644
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
index b273900f45668587..908499486b00274e 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -111,7 +111,8 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
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
index 0a9aba5f9ceff0bf..ab85bf8e165a3575 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -33,7 +33,7 @@ int __init efi_memattr_init(void)
 		return -ENOMEM;
 	}
 
-	if (tbl->version > 1) {
+	if (tbl->version > 2) {
 		pr_warn("Unexpected EFI Memory Attributes table version %d\n",
 			tbl->version);
 		goto unmap;
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
index 507390dda8b9c2f2..3ba27f34fe445aa3 100644
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
 
@@ -752,7 +756,7 @@ extern unsigned long efi_mem_attr_table;
  *                           argument in the page tables referred to by the
  *                           first argument.
  */
-typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *);
+typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
 extern int efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
-- 
2.39.0

