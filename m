Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505BC470499
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhLJPtT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:19 -0500
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:50008
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243125AbhLJPrq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB6yFzZMdJPrS5bS73Jwp/SlqkuR5rFgcfNR0SL1TeEfwWRJMrbx9CQYeeS1TKnGv4Knp6uczUXesYEQHse02h+N2zTVn+jGfIoyLvmmta4edrqTypUFeu5K0uKVXOWIIVKYQWNcXUztgRDM6gIXngyMGxaGPHP+Eju6OpT0Orf8yIo9If3FmUM7pw0NgSTHH2obyv4hnTQ2uAD9EMAbkeKzmFjdPYXpyvcMOnmx5F0Cp28YSwskU0jA01qNRFNTg4W0ilNKYaj+kVtZzHVsJFsWi4e+2+iHkgG2w+GeiGDszIf6OmxYiGj1h5o0+lsnQv1z34pNHTQ15/1Tq+nQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV793WvNMuYhenWRRw9PvCXKZrb1C0N0OuFr8gaV2p0=;
 b=VmYtPec7iZ92gmGYW99V1+tt6rsx5f7/0pt3jowzLrW3rIGEv8SKnnSPkLmRnnGqG9KQ+ixbsq8K9ali2Me14gsEoLqsERUg64/y2Lc6riIMjlCMBfHgEYI3qbMDRrOw5e7jD6RS9zdeJMO+ZNRDIkKeOhveDJD4r0J00m8cmgx0NiaDPU03Gldy+nC978UjQPfHjZkCDUUFJvluGxPbyjP/O0WvR9f3g12HEYlTDiB4GFFUoWKmYep3dAbc4DkVST14/9yQeeX7QppXzGyqfMO4EpUSGbKJjb4Vjip5hyK8zDVIoOYgAFj+9q619HuHdhUtB/kQZ4U81JHEBvHbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV793WvNMuYhenWRRw9PvCXKZrb1C0N0OuFr8gaV2p0=;
 b=NO92a8mDB4ITJR5dBkuV43tdhJYQaAVv31OPU2uhZp2PNyQ9vWcW9RIy6Dri0pACPhNfti8jYnG4jdWicsEHdSEsHEsSWFTo89zKsCp7U8EaLiChNas7EP1b5NcC7F0B1Bwf8Nw6ABBDRJWLsPI9vHQaUnP6ue1aGYUwycIvniM=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 10 Dec
 2021 15:44:06 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::cc) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:06 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:04 -0600
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
Subject: [PATCH v8 11/40] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Fri, 10 Dec 2021 09:43:03 -0600
Message-ID: <20211210154332.11526-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1aab8d-944c-47f8-0192-08d9bbf3e685
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5048B1DC48184180B5CA5861E5719@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZcH0avrSx2lUjnbP3YupEIp3Uayuu9dTh+JDOdoY+SsPXVcjwQbdKl4TmHoiPv5yzn/NW7OPEip/ldOw2wtjpe10S4JrnaWulUmU8pivTaEw2HLUg99jm2Oo1zN3OWKIfUxab3ROVP4ObUyy6QoAcWK26HUyRUe1WqgRXKzxYx+q+U6YHZydptHbOKJ1zXpLgOOd4+drzV5kbVnOSlSc/PzhDkQGJJcq/QLsAQvlb/B3HtNtvLFoZeOjVJMsPc1kuOvQu9obhGgr5KmpfkV1v0tCECNtFU/K37t3zEC57Qs6zaNhls8AoNdcMfesgeHbd7lT0CTblJhTA1oRxnsnBqhr+IutKSkTsfbH2UXldWYAwzcT6ezgHG3N6ZHaPld7uT1YyP6rv3V23/69q453qrFyRjsD9eDmWmsT5dxc8mbjoB7yXuRLHq0sDPW1Ka9F9g1g98d31AHZF4AV5+2M59BBh7BDMweZaSFS/8osTyXC5mRMXLK/etOQ4eg2JYbqR39R95Z9o0FUx/vYSIBmqOM5r5JDDFfTODa73YSYRlgdWCO3NH8euaR0uS416sYQ/Gby5nsOcjcaWhNw//+KwY/I2JgGPIi+kA9gGzan47hQsVTPyHgIOhksDE4KNAVf0j73W5Vb2I+tDoDhqiZN6+yV26hkEiC8w9XZhe1ohv8yYSK5xy+N/K8/+RfCuX+UB9TS3hfmY1C+N4MBjPl7G8lUKuo4p8RsNpy8S6ipB1zZGAPxODuMItPtXQCOdQEaulE29kBWXAOMy0KiVh4leBCsHmGyV6ZUpNuATWz5NA16+cb5LVTUwPxVtyqZKrq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(356005)(82310400004)(7696005)(8676002)(86362001)(36860700001)(186003)(16526019)(336012)(81166007)(4326008)(2616005)(44832011)(70586007)(70206006)(26005)(316002)(426003)(1076003)(54906003)(7416002)(7406005)(36756003)(47076005)(40460700001)(110136005)(5660300002)(508600001)(2906002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:06.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1aab8d-944c-47f8-0192-08d9bbf3e685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest use a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |   2 +
 arch/x86/kernel/cpu/common.c |   4 ++
 arch/x86/kernel/head64.c     |   1 +
 arch/x86/kernel/sev-shared.c |   2 +-
 arch/x86/kernel/sev.c        | 120 ++++++++++++++++++++---------------
 5 files changed, 77 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e37451849165..0df508374a35 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -122,6 +122,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void sev_snp_register_ghcb(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -130,6 +131,7 @@ static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
+static inline void sev_snp_register_ghcb(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0663642d6199..1146e8920b03 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/sev.h>
 
 #include "cpu.h"
 
@@ -1988,6 +1989,9 @@ void cpu_init_exception_handling(void)
 
 	load_TR_desc();
 
+	/* Register the GHCB before taking any VC exception */
+	sev_snp_register_ghcb();
+
 	/* Finally load the IDT */
 	load_current_idt();
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b01f64e8389b..fa02402dcb9b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -588,6 +588,7 @@ void early_setup_idt(void)
 
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
+	sev_snp_register_ghcb();
 }
 
 /*
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e9ff13cd90b0..3aaef1a18ffe 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,7 +68,7 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+static void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
 	u64 val;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a0cada8398a4..17ad603f62da 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -162,55 +162,6 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	return ghcb;
-}
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
@@ -484,6 +435,55 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -652,7 +652,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
  */
-static bool __init sev_es_setup_ghcb(void)
+static bool __init setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
@@ -667,6 +667,10 @@ static bool __init sev_es_setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
@@ -758,6 +762,20 @@ static void __init init_ghcb(int cpu)
 	data->backup_ghcb_active = false;
 }
 
+void sev_snp_register_ghcb(void)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	snp_register_ghcb_early(__pa(ghcb));
+}
+
 void __init sev_es_init_vc_handling(void)
 {
 	int cpu;
@@ -1400,7 +1418,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	enum es_result result;
 
 	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+	if (unlikely(boot_ghcb == NULL && !setup_ghcb()))
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-- 
2.25.1

