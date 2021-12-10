Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329624704BC
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbhLJPuL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:11 -0500
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:47411
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243574AbhLJPsW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEFn+LDYn9FcLJTyI50dEI29QcxBpR5uWI5NL4/2po1ubxYnHz1OgBe2UTFaNPxVWgqi7ITVM9bKwIDGM84xfMCAAe/VKERb2yrdvRaOGDbapWOWRnzvTxzMLBZxpWUr3luwiIVyzSlkSCGV9NBsaDodKLqRDjLan1mDfqN7YfuewOhJsP6X8xKVC5ZcZtMq8VY/ldC/ZUzY/02tDvfsLjr/oBjq043vtwjVjlo4zD79opwzqKp69iGw04INOaKDew0lkv0wCcAlz6Re7Qk7/r9LCSOAIWXwROkxKabkQXEoMmTTtUKzyQ6pw79hq8L/Qiw9wELpVSMcOiWWdL+F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqAzHdQtyIicU98/nv/v9LCDDHQyD52KHThBCP2DCxA=;
 b=ePY4XkmVEz+d+lBeQidGICvaNnEOW3UB8t1WCfS9ZkmVHrrgOv0TjH9MdlapXIPOG3OORAwidLYATaQyerdp/dRYhzIphXY+8qO6PatmBiMC2s9xIpq+SellVTo0oUvD2MCX1X1DCUVmjhtG+dxg/zpBIlyanzwYpwu8KAjUA59L8mPhPILTY+NxKU7v8d/WfKYXQkBurIXqXNi/5k1+iFlGSsolXCHuzFcEAZA9YM0C3nIJ33s4sVmRxpdkrCOaV6+zNruCWDkD7+1NOTTrfEcnyaf36cDC54nLurk3kzxC25VEZXIPaCmEfOV/kF41HiN3MQlS1CbUVr2SXDBQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqAzHdQtyIicU98/nv/v9LCDDHQyD52KHThBCP2DCxA=;
 b=lAGZcPcWfEB7+A8hBO/ZsIBD9CzJyyHCI0A9suZ0MygJtJjm2uacX6u43vKpc35tz8YsB/9xGo0SD54GyD6LnIWWBDoiGPcVkcXH2l2PZyPXc7NaGB6Th5sPu08xcB9Q3FT9gB/Jc2cIuzku7FfrVtYdwM8NOXpIIS35Bvvx0oc=
Received: from BN8PR16CA0018.namprd16.prod.outlook.com (2603:10b6:408:4c::31)
 by BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 15:44:45 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::62) by BN8PR16CA0018.outlook.office365.com
 (2603:10b6:408:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:44 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:41 -0600
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
Subject: [PATCH v8 34/40] x86/sev: add SEV-SNP feature detection/setup
Date:   Fri, 10 Dec 2021 09:43:26 -0600
Message-ID: <20211210154332.11526-35-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 132c4e97-9653-4dd5-b8ce-08d9bbf3fd54
X-MS-TrafficTypeDiagnostic: BY5PR12MB5557:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB555706AF02E1D7190823BF99E5719@BY5PR12MB5557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ywT2Tnd4ivzxNvrV4hTX7WsVtYA3KEijPgTYZAZ1C8K+fOJ+mRvwdj2PpEt2unIS2LYRwYaIVx56zBFt6CYuBHGdb8HdIl/+No40sx+mFlAYjqHFjMVVyVj7hLdUsk2DoUAJveSAA4GF6y+GPrVUNMnvMB1QDpcXjyZ4nyDrBoJ6sZTsooW9B7f8LNgR0TmrRLUk4v2F6U9WzTL9vYuLbHI36FXLjzdlBx2MH0vKA6lCk2teS5aQNqOG/DLACta7PvWvtt+5R9uYP1W3VRdUKYK5xi5Z9rcSa6FzsAq4ZJvzGnxHK5Ksk8pexJTyLOqK9z3pan8j+c7XPbiF3e4ZeABt++Qzq5BQ3XQnSID0SLhXLgixOCmpMJhMrYr0CPq28bPQsoJTCL91bOZqavDVHnw9Ak/0aU+HGj1rHBttZ7c0ZcGQbRuqAH4As7O4ID/QO9patzWmO9zc9z07jBDGArCQh+bfNIke51l7UIgv1VEmm2On5iY7d0QCYJJapS4B3FXRjUwVpW3pLME972lkSoBUnVQmDs6wnQPn+c/XlpcM8DI0Yjh8qMh/81Ngy918jFIWx2czE6VOIAp2G9zS8gew1U1MWKNrDVKDncJeh7lbvpGy2qdY6iDWCRNv2QKXwPlVKdnXUUCMnv29sg9Rrwdm/IigrXe8Gsi7iNoFbquMn7axnkpC/VZNrt+FXf+v/gq9+bIzcsqp0Vz04fLfhdjE0gCwkoTCdDz5IVqytg8RIx1sRS4ldKOLe9G1P7TVgLUwH/ALsAFpD5nM8FQPQQX0AqpqQsPOvxDWXWIN/Z7ooL9dilJqRB6EVCLOmN0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(82310400004)(6666004)(2616005)(1076003)(83380400001)(508600001)(26005)(16526019)(86362001)(44832011)(4326008)(36860700001)(5660300002)(36756003)(7406005)(7416002)(47076005)(336012)(7696005)(316002)(8936002)(54906003)(110136005)(426003)(70586007)(70206006)(40460700001)(356005)(81166007)(8676002)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:44.7353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132c4e97-9653-4dd5-b8ce-08d9bbf3fd54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Initial/preliminary detection of SEV-SNP is done via the Confidential
Computing blob. Check for it prior to the normal SEV/SME feature
initialization, and add some sanity checks to confirm it agrees with
SEV-SNP CPUID/MSR bits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h         |  3 +-
 arch/x86/kernel/sev-shared.c       |  2 +-
 arch/x86/kernel/sev.c              | 65 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_identity.c |  8 ++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4fa7ca20d7c9..4d32af1348ed 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -147,6 +147,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
+void snp_abort(void);
 /*
  * TODO: These are exported only temporarily while boot/compressed/sev.c is
  * the only user. This is to avoid unused function warnings for kernel/sev.c
@@ -156,7 +157,6 @@ bool snp_init(struct boot_params *bp);
  * can be moved back to being statically-scoped to units that pull in
  * sev-shared.c via #include and these declarations can be dropped.
  */
-struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
 void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
@@ -176,6 +176,7 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
+static inline void snp_abort(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 5cb8f87df4b3..72836abcdbe2 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -974,7 +974,7 @@ static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-struct cc_blob_sev_info *
+static struct cc_blob_sev_info *
 snp_find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 32f60602ec29..0e5c45eacc77 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1949,3 +1949,68 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+/*
+ * Initial set up of SEV-SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the kernel
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
+static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
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
+bool __init snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = snp_find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	/*
+	 * The CC blob will be used later to access the secrets page. Cache
+	 * it here like the boot kernel does.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
+
+void __init snp_abort(void)
+{
+	sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
+}
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb403340..2f723e106ed3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -508,8 +509,11 @@ void __init sme_enable(struct boot_params *bp)
 	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
+	bool snp;
 	u64 msr;
 
+	snp = snp_init(bp);
+
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
@@ -541,6 +545,10 @@ void __init sme_enable(struct boot_params *bp)
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
+	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		snp_abort();
+
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
 		/*
-- 
2.25.1

