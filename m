Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0342707E
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbhJHSKH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:10:07 -0400
Received: from mail-mw2nam08on2064.outbound.protection.outlook.com ([40.107.101.64]:54112
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240180AbhJHSIQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKcPfWiLy9nvzWCU27n39nA6A9Eb1v0a69QqRtDYUBZHmV0GdMVKosfcsSHNXDmUIB9HhkkG2So7/CDM+qJzQYbVG+KpLID7E4xf/TcXIVNfMZwSicEtiKjhYNxPcCvg8Fxw+HvwP6MLXE2vS+Wi/mW3SmyvbmWcB3UtcwtLX684Mz2dHSgAN8n3v3TqsxQmtSTWinouUMgbWYPEvY1At1Pbl5kFQ1FfLC0W/Uxclale1RB+5FS8VucK3kCgKZv/LNxIE4wiuQvI1QfO7XgUt2Q36dnHYaMg5v1tDn+mHV86xwMTKjXlRvhwwbcEN9cLUlQ2JJkeP44m2H5c+pXjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z3Uwo/439DgUupULEU3BaKqg1myHpqlwb9VlZrvz5w=;
 b=CtZ+EGzBrDgFXabbaxhM1AlY9MdbZJsjhb3nGXN34gl+mTAILfx+mPQ3EYFGrZMeEn70gH0a9BgxGQ4IBqeVqHkVCn4/Hu+MMjw4fmielJtgLnPdacsaCbdwK6SsD10EzNZtNd+zHuaBx0+CZ5chEqb7lLNFlOFHFlUIfZy99WpmYPqylzS//HU+b6orQH1cEe4UyXTBE4fCPgVzrtXRH3F6cBcxGJTKYNZdY3lPb+bLaGo+MJ8uv7UnS73UEXJzgcbbZB0+TzBbFMgS0alb3cTpWLFOYweiM4gINDdsZL0pQXPjji6S99IsM+AW4QpGbFmtqWUkxB/0tU1o8mB2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z3Uwo/439DgUupULEU3BaKqg1myHpqlwb9VlZrvz5w=;
 b=xB5AdnbvSO+eLhvXowgUTJHh8EgbgI+ejsvaaHnrqPTq8uv9BqeqK1E0vTt6K3T98A3xmTDIYRnTVlaLpdPOfQmlO2hufeD51kHfKWFvBY4to5tRa6h1wNCGesYNe0UUTTr/rBPYt7mJAjzFTcbi5LWTvsbO22o/qco0hEC9mzs=
Received: from MWHPR20CA0037.namprd20.prod.outlook.com (2603:10b6:300:ed::23)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Fri, 8 Oct 2021 18:06:17 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::cc) by MWHPR20CA0037.outlook.office365.com
 (2603:10b6:300:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:16 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:06 -0500
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v6 33/42] boot/compressed/64: use firmware-validated CPUID for SEV-SNP guests
Date:   Fri, 8 Oct 2021 13:04:44 -0500
Message-ID: <20211008180453.462291-34-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e95bd3e-3ef1-498f-a0a2-08d98a8652d5
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54477F8FBBEF41CE2CC4158EE5B29@DM8PR12MB5447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdAAfaHqKuoLGTdzC+dO8XYhyApSRuP0AA3Nl2Va10WEV9ldlGITTXr3p3IQb00llD8cZgfr7IocOP84bSbdc36MszoVRlRw9bn5pYmH05/cZsV7z+bDjN9Oy4jTn732WWdOzatgvv3K9L/bvu6g4iA8XQOUA2j40SasFLRahkH88rHoTyxh+mcAJDJDLZc9SA3pwpDfp5822b7/jluG7JyFDRvAkigoeXP4TD4Mcj3dXAP8wtDbPk/1lIwC70NysZXf8ajG0rjAdoGIzGQmhnZR9WYSgjntuzzhTAETeIgJ/Z753GcBXYRtoFS16BHWPW8qBeA0EScQuJQ2+sUPWXK7Dy+PvxOcj+AsRvr3bkJKzlWrgEr3IsXSfwkS+4qqirKKHaRXhsn6cgtskFWhDQK6UEHYFgNeBqmIsutleyRemYwM9xlX18VCMt+hRriayX2Y8CmtCLuXEiq8C9SffgMJ8TTXEcxg2miTXqwritMFCLjTsmbfe4YyuoF+1h0ciMGi5lXQAU1PBOy63kJBtla9dTLtoq5KsujOEAHzi3oMVOR4u3idbXV4csBnhl6f7IYVnJGzOcaiQl5TqNVwqy0VzDrYszOglPwaBS5qUEtOwzBFXpCfDZyMAXgNOlL8NPJAVL68/1PGhZtKkh5ToKqKACIb0fx298PNDGY9zrJZ4SdddusZKS8N/cL+T3QQYfoZx2GIDqzDsdIIMowcidy9FQ0FPkJOtBEyeiJBVZ1RwandFR4f8IX4xSDvqA/+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(110136005)(7416002)(30864003)(47076005)(15650500001)(7406005)(2616005)(36860700001)(6666004)(54906003)(5660300002)(26005)(8676002)(508600001)(86362001)(336012)(316002)(16526019)(70586007)(82310400003)(4326008)(70206006)(44832011)(186003)(83380400001)(81166007)(1076003)(7696005)(36756003)(426003)(2906002)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:16.8089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e95bd3e-3ef1-498f-a0a2-08d98a8652d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the boot kernel either through an EFI config table entry,
or via a setup_data structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
boot kernel will use when servicing cpuid instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/head_64.S |  1 +
 arch/x86/boot/compressed/idt_64.c  |  5 +-
 arch/x86/boot/compressed/misc.h    |  2 +
 arch/x86/boot/compressed/sev.c     | 79 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/sev.h         | 14 ++++++
 arch/x86/kernel/sev-shared.c       | 78 +++++++++++++++++++++++++++++
 6 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535cf45b..c9252f0b0e81 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -444,6 +444,7 @@ SYM_CODE_START(startup_64)
 .Lon_kernel_cs:
 
 	pushq	%rsi
+	movq	%rsi, %rdi		/* real mode address */
 	call	load_stage1_idt
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 9b93567d663a..3c0f7c8d9152 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -28,7 +28,7 @@ static void load_boot_idt(const struct desc_ptr *dtr)
 }
 
 /* Setup IDT before kernel jumping to  .Lrelocated */
-void load_stage1_idt(void)
+void load_stage1_idt(void *rmode)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
@@ -37,6 +37,9 @@ void load_stage1_idt(void)
 		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
 
 	load_boot_idt(&boot_idt_desc);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		snp_cpuid_init_boot(rmode);
 }
 
 /* Setup IDT after kernel jumping to  .Lrelocated */
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index d4a26f3d3580..9b66a8bf336e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -124,6 +124,7 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+void snp_cpuid_init_boot(struct boot_params *bp);
 
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -133,6 +134,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline void snp_cpuid_init_boot(struct boot_params *bp) { }
 
 #endif
 
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 11c459809d4c..60885d80bf5f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -297,3 +297,82 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	else if (result != ES_RETRY)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
+
+/* Search for Confidential Computing blob in the EFI config table. */
+static struct cc_blob_sev_info *snp_find_cc_blob_efi(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+	unsigned long conf_table_pa;
+	unsigned int conf_table_len;
+	bool efi_64;
+	int ret;
+
+	ret = efi_get_conf_table(bp, &conf_table_pa, &conf_table_len, &efi_64);
+	if (ret)
+		return NULL;
+
+	ret = efi_find_vendor_table(conf_table_pa, conf_table_len,
+				    EFI_CC_BLOB_GUID, efi_64,
+				    (unsigned long *)&cc_info);
+	if (ret)
+		return NULL;
+
+	return cc_info;
+}
+
+/*
+ * Initial set up of SEV-SNP CPUID table relies on information provided
+ * by the Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	cc_info = snp_find_cc_blob_efi(bp);
+	if (cc_info)
+		goto found_cc_info;
+
+	cc_info = snp_find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(0, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+void snp_cpuid_init_boot(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+	u32 eax;
+
+	if (!bp)
+		return;
+
+	cc_info = snp_find_cc_blob(bp);
+	if (!cc_info)
+		return;
+
+	snp_cpuid_info_create(cc_info);
+
+	/* SEV-SNP CPUID table is set up now. Do some sanity checks. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* CPUID bits for SEV (bit 1) and SEV-SNP (bit 4) should be enabled. */
+	eax = native_cpuid_eax(0x8000001f);
+	if (!(eax & (BIT(4) | BIT(1))))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* It should be safe to read SEV MSR and check features now. */
+	if (!sev_snp_enabled())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 534fa1c4c881..7c88762cdb23 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -126,6 +127,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+/*
+ * TODO: These are exported only temporarily while boot/compressed/sev.c is
+ * the only user. This is to avoid unused function warnings for kernel/sev.c
+ * during the build of kernel proper.
+ *
+ * Once the code is added to consume these in kernel proper these functions
+ * can be moved back to being statically-scoped to units that pull in
+ * sev-shared.c via #include and these declarations can be dropped.
+ */
+void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
+struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -141,6 +153,8 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info) { }
+struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 193ca49a1689..b321c1b7d07c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -66,6 +66,9 @@ static u64 __ro_after_init sev_hv_features;
  * and regenerate the CPUID table/pointer when .bss is cleared.
  */
 
+/* Copy of the SNP firmware's CPUID page. */
+static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
+
 /*
  * The CPUID info can't always be referenced directly due to the need for
  * pointer fixups during initial startup phase of kernel proper, so access must
@@ -390,6 +393,22 @@ snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return false;
 }
 
+static void __init snp_cpuid_set_ranges(void)
+{
+	int i;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in == 0x0)
+			cpuid_std_range_max = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			cpuid_hyp_range_max = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			cpuid_ext_range_max = fn->eax;
+	}
+}
+
 static bool snp_cpuid_check_range(u32 func)
 {
 	if (func <= cpuid_std_range_max ||
@@ -934,3 +953,62 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
+{
+	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB)
+			return (struct cc_setup_data *)hdr;
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+struct cc_blob_sev_info *
+snp_find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd;
+
+	sd = get_cc_setup_data(bp);
+	if (!sd)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+}
+
+/*
+ * Initialize the kernel's copy of the SEV-SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SEV-SNP CPUID table used by firmware
+ * would be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_info *cpuid_info_fw;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info_fw = (const struct snp_cpuid_info *)cc_info->cpuid_phys;
+	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = &cpuid_info_copy;
+	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
+	snp_cpuid_set_ranges();
+}
-- 
2.25.1

