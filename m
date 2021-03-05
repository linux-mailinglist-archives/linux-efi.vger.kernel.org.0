Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274132ED3F
	for <lists+linux-efi@lfdr.de>; Fri,  5 Mar 2021 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCEOgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Mar 2021 09:36:19 -0500
Received: from foss.arm.com ([217.140.110.172]:54942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhCEOfu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Mar 2021 09:35:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7502811FB;
        Fri,  5 Mar 2021 06:35:50 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EC8D3F73B;
        Fri,  5 Mar 2021 06:35:45 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
Date:   Fri,  5 Mar 2021 20:06:09 +0530
Message-Id: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: James Morse <james.morse@arm.com>

As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
might contain a range of values to describe supported translation granules
(4K and 16K pages sizes in particular) instead of just enabled or disabled
values. This changes __enable_mmu() function to handle complete acceptable
range of values (depending on whether the field is signed or unsigned) now
represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
also fix similar situations in EFI stub and KVM as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h           | 20 ++++++++++++++------
 arch/arm64/kernel/head.S                  |  6 ++++--
 arch/arm64/kvm/reset.c                    | 23 ++++++++++++-----------
 drivers/firmware/efi/libstub/arm64-stub.c |  2 +-
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index dfd4edb..d4a5fca9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -796,6 +796,11 @@
 #define ID_AA64MMFR0_PARANGE_48		0x5
 #define ID_AA64MMFR0_PARANGE_52		0x6
 
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX	0x7
+
 #ifdef CONFIG_ARM64_PA_BITS_52
 #define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_52
 #else
@@ -961,14 +966,17 @@
 #define ID_PFR1_PROGMOD_SHIFT		0
 
 #if defined(CONFIG_ARM64_4K_PAGES)
-#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN4_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN4_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN4_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
 #elif defined(CONFIG_ARM64_16K_PAGES)
-#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN16_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN16_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN16_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0xF
 #elif defined(CONFIG_ARM64_64K_PAGES)
-#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN64_SHIFT
-#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN64_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN64_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN64_SUPPORTED
+#define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
 #endif
 
 #define MVFR2_FPMISC_SHIFT		4
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 66b0e0b..8b469f1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -655,8 +655,10 @@ SYM_FUNC_END(__secondary_too_slow)
 SYM_FUNC_START(__enable_mmu)
 	mrs	x2, ID_AA64MMFR0_EL1
 	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
-	b.ne	__no_granule_support
+	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
+	b.lt    __no_granule_support
+	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
+	b.gt    __no_granule_support
 	update_early_cpu_boot_status 0, x2, x3
 	adrp	x2, idmap_pg_dir
 	phys_to_ttbr x1, x1
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 47f3f03..fe72bfb 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -286,7 +286,7 @@ u32 get_kvm_ipa_limit(void)
 
 int kvm_set_ipa_limit(void)
 {
-	unsigned int parange, tgran_2;
+	unsigned int parange, tgran_2_shift, tgran_2;
 	u64 mmfr0;
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
@@ -300,27 +300,28 @@ int kvm_set_ipa_limit(void)
 	switch (PAGE_SIZE) {
 	default:
 	case SZ_4K:
-		tgran_2 = ID_AA64MMFR0_TGRAN4_2_SHIFT;
+		tgran_2_shift = ID_AA64MMFR0_TGRAN4_2_SHIFT;
 		break;
 	case SZ_16K:
-		tgran_2 = ID_AA64MMFR0_TGRAN16_2_SHIFT;
+		tgran_2_shift = ID_AA64MMFR0_TGRAN16_2_SHIFT;
 		break;
 	case SZ_64K:
-		tgran_2 = ID_AA64MMFR0_TGRAN64_2_SHIFT;
+		tgran_2_shift = ID_AA64MMFR0_TGRAN64_2_SHIFT;
 		break;
 	}
 
-	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
-	default:
-	case 1:
+	tgran_2 = cpuid_feature_extract_unsigned_field(mmfr0, tgran_2_shift);
+	if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE) {
 		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
 		return -EINVAL;
-	case 0:
+	} else if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT) {
 		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
-		break;
-	case 2:
+	} else if (tgran_2 >= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN &&
+		   tgran_2 <= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX) {
 		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
-		break;
+	} else {
+		kvm_err("Unsupported value, giving up\n");
+		return -EINVAL;
 	}
 
 	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b69d631..7bf0a7a 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -24,7 +24,7 @@ efi_status_t check_platform_features(void)
 		return EFI_SUCCESS;
 
 	tg = (read_cpuid(ID_AA64MMFR0_EL1) >> ID_AA64MMFR0_TGRAN_SHIFT) & 0xf;
-	if (tg != ID_AA64MMFR0_TGRAN_SUPPORTED) {
+	if (tg < ID_AA64MMFR0_TGRAN_SUPPORTED_MIN || tg > ID_AA64MMFR0_TGRAN_SUPPORTED_MAX) {
 		if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
 			efi_err("This 64 KB granular kernel is not supported by your CPU\n");
 		else
-- 
2.7.4

