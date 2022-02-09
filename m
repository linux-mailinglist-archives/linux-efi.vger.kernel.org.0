Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F0E4AF978
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiBISPN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiBISOs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA964C0302EA;
        Wed,  9 Feb 2022 10:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY14EXCDknGqR1fRBOQrj+DtdURa9vouz9CrAghAk51iNVo/hYaJDnr/vHgVdCtn71p8EO3i9zxBbQgxtgmaXP484qH8YQ58qU6uuBwpUPdcoHlLI9qnrEC/hWeJbrc2HusdFfza24F//1murwnwSTLntADUdOtkOTZ7jdmyEryc4xQgBn4qFmxkbdTfxeowB8X/RlmYqd1GcNrXTGJ07mFkPGNPrSzuRaT6QRrgYMN2R3Tz2Vf3FyjUnMutIEeqZOCG5J49CHByLOAtnvKXHPYx2Qj+LflUxSHzsYuYxPJqzQJouBjDkl3mMOG36VCVZC/vne04k60ubrUaG6o57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to41EJqcKsCzQuH137kf8EsDPSNDJj5Kf55GnacB6qE=;
 b=FQWYBzfxj2qmIqLKhsj+zzHFuMpM6wfu94FU2DbALS552R/gRAmi233kvZpPmub/24bQlaUejECz4yhmz4JJjZQm2ZZ2/WeHKsa/RHTcZUkbdYp3ndRPyFQDPLWCK3bcsr/xbq5NoPwNHWTBMU6Mgj5TUWshhLSuqY9jJMOnXPwPz3AZMxv4RoDB9FRPD1DycVQDeHx0u7gzlAAleDWWzNhZHgrekjEY8D6pRkXuG1APNE2uw0eumMXHMX6/XsYKxVKn6vALe1113X3UH2aoWAb9nmUvDjs+3bRsrjvIXkgTFHIomUbHrsY0AL8ol/kj0qNFEQI7uGcE3hH7XPadTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to41EJqcKsCzQuH137kf8EsDPSNDJj5Kf55GnacB6qE=;
 b=rqfP89Xr1bOtdxAhIhzqQsdPf8cuwAIB4kXj5PtEG4kFRjtD/Elr1t/RNs9EiWSLBerR7VTqtZb7LSkbzJTp1kboX217/aHywoXqz1EkZ8OeDLy7Dd48Glsgx5dfMvOVKiBoHY4CYNK5CEUlaOpgbKVDN0Smej+VgBv2NKleL4o=
Received: from MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13) by
 DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 18:12:34 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::b9) by MWHPR01CA0027.outlook.office365.com
 (2603:10b6:300:101::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:33 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:31 -0600
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
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v10 38/45] x86/sev: Add SEV-SNP feature detection/setup
Date:   Wed, 9 Feb 2022 12:10:32 -0600
Message-ID: <20220209181039.1262882-39-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e59d844-3e0c-44b5-1cd4-08d9ebf7bec7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB124292CF79954D482FE67EE7E52E9@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uJks7BKCn2s7EmTJLmTRy8gHqUsqRIcK/H/AB/FbJcQPQAB6VGGyP5oQsgv4hMHrQvi+Gf0Guki92jpqTA2ZBdQMfV/wiKJFJjGAW1bEPlecsmO7QxYPvNZLUBAyaim0mhIHLQ96CNaVDTM0XjmIYAZwc1ltrHD4F323K6H9GsGMc0XUOSzZpn5gmS49OKiwqTq99f4ycKfDymW5f0sSiCIGrxZwnbwuTY48KLwzpLWoxqKVRGUUFIr/U659fjTfF0WS0pH4TqWGn1FRAntCIDA8gVtlfHAa4wLcxXqVOTaB+hPsDMMtlE07pi8UhIwgsaWJ+LGIj7zLQdg2Xe2AIStF8D6ZgLzONsiQwXeErdBmRkB052sApU89impVGhkU8ntx4ssKc2hyeC5LA6wQ3EBTW6THP+Hf14qdncsNABF4tmqcGKpYeFQDoPEgo/u5QagVtv0p3C/c6s5a85ZAUjIQwYCSvHk6bdBQ5Y9Th2MDBDCteMhmRU7agycgx31nUTM/sQxTPLhOZHzu/zYA95XdXleHv1o9MQJD7TQUDcNGKN/N+fWhAqCfOq+ACWaiPDDB5sx2V4tbWLGxxKsEm8CM0T7bU31Sy1Q6etRI3FcBjg0UhZcQn2CHhwVRgZN5TuiAlhyd4Z9YkJ0O+LjYQjiwbmPr293+HqOI+WuiAB67lrXiaxxP2+ND7vRFc12SRX1MOTulf1UTSH7xPXU5DhwxawmL7bEIvl3tfz1G8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(54906003)(8676002)(4326008)(508600001)(44832011)(5660300002)(81166007)(8936002)(110136005)(36756003)(86362001)(36860700001)(16526019)(83380400001)(1076003)(2616005)(336012)(26005)(186003)(356005)(426003)(82310400004)(70586007)(7416002)(47076005)(40460700003)(70206006)(7406005)(2906002)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:33.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e59d844-3e0c-44b5-1cd4-08d9ebf7bec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/boot/compressed/sev.c     | 27 -------------
 arch/x86/include/asm/sev.h         |  2 +
 arch/x86/kernel/sev-shared.c       | 27 +++++++++++++
 arch/x86/kernel/sev.c              | 64 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_identity.c |  8 ++++
 5 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 2a48f3a3f372..2911137bf37f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -352,33 +352,6 @@ static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
 								EFI_CC_BLOB_GUID);
 }
 
-struct cc_setup_data {
-	struct setup_data header;
-	u32 cc_blob_address;
-};
-
-/*
- * Search for a Confidential Computing blob passed in as a setup_data entry
- * via the Linux Boot Protocol.
- */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
-{
-	struct cc_setup_data *sd = NULL;
-	struct setup_data *hdr;
-
-	hdr = (struct setup_data *)bp->hdr.setup_data;
-
-	while (hdr) {
-		if (hdr->type == SETUP_CC_BLOB) {
-			sd = (struct cc_setup_data *)hdr;
-			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
-		}
-		hdr = (struct setup_data *)hdr->next;
-	}
-
-	return NULL;
-}
-
 /*
  * Initial set up of SNP relies on information provided by the
  * Confidential Computing blob, which can be passed to the boot kernel
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4e3909042001..219abb4590f2 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -153,6 +153,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
+void snp_abort(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -171,6 +172,7 @@ static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npage
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
+static inline void snp_abort(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 0f1375164ff0..a7a1c0fb298e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -937,3 +937,30 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd = NULL;
+	struct setup_data *hdr;
+
+	hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB) {
+			sd = (struct cc_setup_data *)hdr;
+			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+		}
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b876b1d989eb..a79ddacf0478 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1984,3 +1984,67 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+/*
+ * Initial set up of SNP relies on information provided by the
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
+static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+		goto found_cc_info;
+	}
+
+	/*
+	 * If kernel was booted directly, without the use of the
+	 * boot/decompression kernel, the CC blob may have been passed via
+	 * setup_data instead.
+	 */
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		snp_abort();
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
+	cc_info = find_cc_blob(bp);
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
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
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

