Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE10B42706C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbhJHSJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:49 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:35136
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242898AbhJHSIU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxnQb2gOZmtT6cKB98Nh+9wnSXp2xN0hbyZUJRV3GIzE9J8IVPOad6p5YP+agjtvVl4tAVNQ4zOa90VlaHSB0UyZZGBREVqVK0GzVKNQAJrTVlkXWW2WgmohAl/v3kdQkVJj/tvKUPBxHPPfNFdvNMx9gOld16G/H0tX6sjuQNu4g5OC/nJiFUk+x8lCp7i1QuJdZnBxjJuT1Zt0Q250xI4A//WACAdRV422RZxye1Ovc0cm6nYBKjOPX6nW1pw6dKwe4NAqOYQbtziNqGCsBjeMf+2/Mv71IhcruEeC2GdD7iIPa/bSdCoBkroOE3yVdbISagnfICG2ipd7AfhH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haJSpmcDhyVcdGiWipRkNfKqI8hYzQMv/xyXXbjv3As=;
 b=WHKFgt5OEYPiGqKA+aTVLYYF58DQ6GWPr/tvSYPSsJPM+ycBlii0f7clfsKbPZMlYyKIfr52cD5BlmSoIDzc4KHH0iUZ3/nGNIOXDXCuGAy5kkKfR5l0wrLEadbM3MwzZU+OXSTAVDGsgk2rfPLTkDxvrj6tNtWSzL0FGbeBmrIOMWrjrF+q0F9RRZ+TQ30UhsUhJvbdyAb4oNbF/JqyWOLTc6B8VJZPhoZTvA28kHHthzh17mIFFU20cVK8DDLRZM/VgysLGtEuQlyfpx9RdRmVOCjTWJR95qKaV6Ga45iQcmWtWIPji9s229ZQRws+QUmdTd/sdJO0thsFHymnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJSpmcDhyVcdGiWipRkNfKqI8hYzQMv/xyXXbjv3As=;
 b=HSXtCzoAZN1a/M+cNSDBas7iKfYyFLk3Ax+nOVbtdOV0hKmWNZNeTCxeCPtvhLms0nWvttTRgRyjiBvFYMUuSwp0g1JNdFeAmogNmJ35JvvmfEF3CZPEdUBypl0sAlf/rDfrSO70GqQg3tkpzf+PGp190Lz82+k8AswV/pQkIgA=
Received: from MW4PR04CA0032.namprd04.prod.outlook.com (2603:10b6:303:6a::7)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 18:06:21 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::17) by MW4PR04CA0032.outlook.office365.com
 (2603:10b6:303:6a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:13 -0500
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
Subject: [PATCH v6 37/42] x86/sev: use firmware-validated CPUID for SEV-SNP guests
Date:   Fri, 8 Oct 2021 13:04:48 -0500
Message-ID: <20211008180453.462291-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0efd54d0-3fb2-4213-fb90-08d98a8654f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4914423FC48C6C2BC5414CACE5B29@BL0PR12MB4914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhiziY8LFSJbr2zgFjnq3zlNyCuazMg/6zFq35SK7gT6QCrLUuoARuNOyit6lb/M2LHN2mvJGlsvkoLxYSSPpG21pz/9Prbu+Pyf+IBfzoNm8oWCg05ES0XYzHyv61P81YnivdIhN9iO9YszTCiNI9Uk0MJfrlYjNCsTq4R6MZNUiuLygLHpHkBoGUnaHhmkTMD56Sm2yWt7wygu0mwUW5Wg4Obp5dv4nQLJO2f7di6HJwx+Ghpoq6NjcqOC93MbA89DvbZsUVkskAELC5kyfuihFY2TLjUOa9Z/ObMC5vZzE5xqK4RKUjmA1c2LIxz/fF3n1ieGrpZvt0YdG1KWx1WmYkvwRoeGvwqIMPKEW4uA764+aav5vVinTqh7QrEZZJWXstZFYYeRq6ej0NPAxE7NcCXAyd5mycsrDNOCh6Ujrw3D/nljcdr/2ACnkaFat4teyk+zuJBKsl9oOw8rkUME+iFAZ26Ay8dV0tfc4uIQk0pCTOgpKJYA/DFSTOTq65+h/QsWcOOKF3blB9mFvWGGGiNbT9AjT9raUcqKa6UV7HFF4ukEg3rkNwQD2yPJiDCruns7KHzdfnLeGS4fq+NUd+ojfwL4S0j+zlZ+lk2bINF8hWxxUjunJkHDjq4Gez/mhDo6znLE5fHsx9bmbu5MMlPyvUwntdDCXQdyp0Vzg/jrMWU7OOZELx1ZslMzxGoOPYjF94QkxTI6NWysyEMn9MPN4qffrmBNGA8P141zIsYnOcAxywYlOSxwCuZV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(8676002)(7416002)(7406005)(4326008)(8936002)(83380400001)(82310400003)(47076005)(36860700001)(6666004)(36756003)(508600001)(336012)(81166007)(5660300002)(186003)(70206006)(16526019)(70586007)(26005)(1076003)(110136005)(426003)(86362001)(15650500001)(44832011)(54906003)(30864003)(316002)(7696005)(2616005)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:20.3356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efd54d0-3fb2-4213-fb90-08d98a8654f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through bootparams field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing cpuid instructions via a #VC
handler.

This must be set up during early startup before any cpuid instructions
are issued. As result, some pointer fixups are needed early on that
must be adjusted later in boot, which is why there are 2 init routines.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c |   2 +-
 arch/x86/include/asm/setup.h   |   2 +-
 arch/x86/include/asm/sev.h     |  17 +----
 arch/x86/kernel/head64.c       |  12 ++-
 arch/x86/kernel/sev-shared.c   |  23 +++++-
 arch/x86/kernel/sev.c          | 135 +++++++++++++++++++++++++++++++++
 6 files changed, 170 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1b77b819ddb4..2f31f69715d0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -361,7 +361,7 @@ void snp_cpuid_init_boot(struct boot_params *bp)
 	if (!cc_info)
 		return;
 
-	snp_cpuid_info_create(cc_info);
+	snp_cpuid_info_create(cc_info, 0);
 
 	/* SEV-SNP CPUID table is set up now. Do some sanity checks. */
 	if (!snp_cpuid_active())
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..cee1e816fdcd 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,7 +50,7 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
-extern void startup_64_setup_env(unsigned long physbase);
+extern void startup_64_setup_env(unsigned long physbase, struct boot_params *bp);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7c88762cdb23..1c58060b48b7 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -127,17 +127,8 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
-/*
- * TODO: These are exported only temporarily while boot/compressed/sev.c is
- * the only user. This is to avoid unused function warnings for kernel/sev.c
- * during the build of kernel proper.
- *
- * Once the code is added to consume these in kernel proper these functions
- * can be moved back to being statically-scoped to units that pull in
- * sev-shared.c via #include and these declarations can be dropped.
- */
-void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
-struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
+void snp_cpuid_init_startup(struct boot_params *bp, unsigned long physaddr);
+void snp_cpuid_init(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -153,8 +144,8 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
-void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info) { }
-struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp) { }
+static inline void snp_cpuid_startup(struct boot_params *bp, unsigned long physbase) { }
+static inline void snp_cpuid_init(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 3c0bfed3b58e..ef5efa484efa 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -571,7 +571,7 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 }
 
 /* This runs while still in the direct mapping */
-static void startup_64_load_idt(unsigned long physbase)
+static void startup_64_load_idt(unsigned long physbase, struct boot_params *bp)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
 	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
@@ -587,6 +587,9 @@ static void startup_64_load_idt(unsigned long physbase)
 
 	desc->address = (unsigned long)idt;
 	native_load_idt(desc);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		snp_cpuid_init_startup(bp, physbase);
 }
 
 /* This is used when running on kernel addresses */
@@ -598,12 +601,15 @@ void early_setup_idt(void)
 
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		snp_cpuid_init();
 }
 
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(unsigned long physbase, struct boot_params *bp)
 {
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
@@ -614,5 +620,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt(physbase, bp);
 }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b321c1b7d07c..341ea8800b9f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -976,7 +976,7 @@ static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-struct cc_blob_sev_info *
+static struct cc_blob_sev_info *
 snp_find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd;
@@ -988,6 +988,22 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
 	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
 }
 
+static const struct snp_cpuid_info *
+snp_cpuid_info_get_ptr(unsigned long physbase)
+{
+	void *ptr = &cpuid_info_copy;
+
+	/* physbase is only 0 when the caller doesn't need adjustments */
+	if (!physbase)
+		return ptr;
+
+	/*
+	 * Handle relocation adjustments for global pointers, as done by
+	 * fixup_pointer() in __startup64().
+	 */
+	return ptr - (void *)_text + (void *)physbase;
+}
+
 /*
  * Initialize the kernel's copy of the SEV-SNP CPUID table, and set up the
  * pointer that will be used to access it.
@@ -997,7 +1013,8 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
+static void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info,
+					 unsigned long physbase)
 {
 	const struct snp_cpuid_info *cpuid_info_fw;
 
@@ -1008,7 +1025,7 @@ void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
 	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
 		sev_es_terminate(1, GHCB_TERM_CPUID);
 
-	cpuid_info = &cpuid_info_copy;
+	cpuid_info = snp_cpuid_info_get_ptr(physbase);
 	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
 	snp_cpuid_set_ranges();
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d348ad027df8..1e6152fe27ba 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1986,3 +1986,138 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+/*
+ * Initial set up of SEV-SNP CPUID table relies on information provided
+ * by the Confidential Computing blob, which can be passed to the kernel
+ * in the following ways, depending on how it is booted:
+ *
+ * - when booted via the boot/decompress kernel:
+ *   - via boot_params
+ *
+ * - when booted directly by firmware/bootloader (e.g. CONFIG_PVH):
+ *   - via a setup_data entry, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address) {
+		cc_info = (struct cc_blob_sev_info *)
+			  (unsigned long)bp->cc_blob_address;
+		goto found_cc_info;
+	}
+
+	/*
+	 * If kernel was booted directly, without the use of the
+	 * boot/decompression kernel, the CC blob may have been passed via
+	 * setup_data instead.
+	 */
+	cc_info = snp_find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+/*
+ * Initial set up of SEV-SNP CPUID table during early startup when still
+ * using identity-mapped addresses.
+ *
+ * Since this is during early startup, physbase is needed to generate the
+ * correct pointer to the initialized CPUID table. This pointer will be
+ * adjusted again later via snp_cpuid_init() after the kernel switches over
+ * to virtual addresses and pointer fixups are no longer needed.
+ */
+void __init snp_cpuid_init_startup(struct boot_params *bp,
+				   unsigned long physbase)
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
+	snp_cpuid_info_create(cc_info, physbase);
+
+	/* SEV-SNP CPUID table is set up now. Do some sanity checks. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* SEV (bit 1) and SEV-SNP (bit 4) should be enabled in CPUID. */
+	eax = native_cpuid_eax(0x8000001f);
+	if (!(eax & (BIT(4) | BIT(1))))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* #VC generated by CPUID above will set sev_status based on SEV MSR. */
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/*
+	 * The CC blob will be used later to access the secrets page. Cache
+	 * it here like the boot kernel does.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+}
+
+/*
+ * This is called after the kernel switches over to virtual addresses. Fixup
+ * offsets are no longer needed at this point, so update the CPUID table
+ * pointer accordingly.
+ */
+void snp_cpuid_init(void)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP)) {
+		/* Firmware should not have advertised the feature. */
+		if (snp_cpuid_active())
+			panic("Invalid use of SEV-SNP CPUID table.");
+		return;
+	}
+
+	/* CPUID table should always be available when SEV-SNP is enabled. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	/* Remove the fixup offset from the cpuid_info pointer. */
+	cpuid_info = snp_cpuid_info_get_ptr(0);
+}
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it. So
+ * do it here, and while at it, go ahead and re-verify that nothing strange has
+ * happened between early boot and now.
+ */
+static int __init snp_cpuid_check_status(void)
+{
+	if (!cc_platform_has(CC_ATTR_SEV_SNP)) {
+		/* Firmware should not have advertised the feature. */
+		if (snp_cpuid_active())
+			panic("Invalid use of SEV-SNP CPUID table.");
+		return 0;
+	}
+
+	/* CPUID table should always be available when SEV-SNP is enabled. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	pr_info("Using SEV-SNP CPUID table, %d entries present.\n",
+		cpuid_info->count);
+
+	return 0;
+}
+
+arch_initcall(snp_cpuid_check_status);
-- 
2.25.1

