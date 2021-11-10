Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3791344CC1D
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhKJWNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:30 -0500
Received: from mail-dm3nam07on2085.outbound.protection.outlook.com ([40.107.95.85]:18940
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233840AbhKJWLw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoU0rboXuIoWx/ZmcrVNoRfZ2oMbChWy7RQCvPefJXVrzUtl+00nWWA2LJPNceV9z6wKDYo49xn6IzvTAt7itR3ugjP25aZ2WIfcP4adN41ydv5CE5XN5Mk+Gg0htllww5UPhHEfd7eeYDVEU3E0dVc5N1hbPj0IE9Lbbykoj7R7EYKYPcfI+FLcuAwAyJVSEOH8GxGy1HthEQEKTk01wc9J+Pz+MeoMArmr4RKLNKrTHT32gDXhLg3mLRa2ZMOGo3XDJOIn2KevxK8SUO9IEtV1LN+BFgzvXCh7WGb83Tmao3rxChsXwHOplk6IoU08NaQJ2TD2yl5cwUdyjegU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khYIQEgHdhihpuOY/a7yWVOsveKHClV9OLAIlqW4YLI=;
 b=AruTGcy61VQn0LMw0QR5lZ3ME3XT9wdVQKPu5m4uRCrVctlhMI0hGVMmes93Cadhj8qFlnTj8CNnHvx6K9WMexUBROzZeDj0WG6Ff++qOKe4YkpQ7A/S7EmygU8zDB+r2IibqoZMedOQeqXSOTo2iR/zFHXv89lj0P4DvSgYQf6f6EDNGLDhGKgWjaIJRb+4NwiV2pugZZGQAOqVwiVLS4SLCXTi2zPnekRodBEBJgPZtR9lBOEVDzFc5nfvo6BCwVNdvnKD6yRY1wvVhhXFBWVl/NWUh7TLKvIMG855WQuXXvy7tJYE+WWqmBvRp57lSjCTMfURABuCLxki8ydHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khYIQEgHdhihpuOY/a7yWVOsveKHClV9OLAIlqW4YLI=;
 b=uzZHxtU/d+Zuy34T+ZA1+cqRv+ak4rDwPjStn/qOQz4UQCygKgLuj1TNTxZYgSN11XKHZeKE1AqytD/Hyx+2x45p3eEjv0acHQU9kB557+kN+IkqIQDf2b71RhoP0nGM4b3C/VSdG0Lkg4mUtCFHEaB+SvE9cy+Agb0NPiSD6v0=
Received: from DM5PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:4:16::14)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:08:59 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::5) by DM5PR2001CA0004.outlook.office365.com
 (2603:10b6:4:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:55 -0600
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
Subject: [PATCH v7 39/45] x86/sev: add SEV-SNP feature detection/setup
Date:   Wed, 10 Nov 2021 16:07:25 -0600
Message-ID: <20211110220731.2396491-40-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb32574c-50f8-4cf1-0d44-08d9a496b254
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1586796FF83657D5CF29CAA5E5939@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lw6gdwYKWra+o3eICQi/0hkSHtUiArEG0rfpeBjxecPqr0x+goFdlEpPWvkejld4EN+EfWTWkaoTy/DP5wiPCqmudCRZMEHqrE41NWBKpKa6O+nzrfUlERaMXbXD6pPj0MhwcRq7QkVmbCWxhD/YygsqqKsCn4e2tIzAGnIpGqvrrfmsUakxJV8C+ss2kypznrh3FPfUBMXMxwIX1MOVAdO2E9bqsvJi7goPaPSZBl13cHr5B586Xzpa+38Bz4vBdOvN2JDMMvk6X2xJ6kflfax+ITE73yDEO4Yq8YJMQ2IsQIEeGe4iVJbzMpAkTN9zOWzJefQ1Jdlb3+xAE0eUX6G31RvSxOlO7bkpm5WqsXsNdOmtzMZlgDckCO4w1AUw3bSwNwYGCRmsc0NdKh/z+s6yEawgQb9WOdQ/i2DXxf41EnSpee3m7IjgP9f0pb1CfoX+grIP54ngRxsCDmTELUYjMMS+Vnqkna+eU0HXSAviuYsk6G2ZprknIBSfOVYrBbFsIOvjRckHLIjwfhZETPw+pV3oE4iJlx/NDGbonfemy7C7ohxr10JZv2KCZ9dKRjpmFkva/NxXte7FiFr6OrMSUxZ0SRxRSJcbXZlgNeqiWNg2jhloIcpnCG/+RqD9SiVEfQQHjtXPzZN/G6wEnEogUx2+XC0mxBY6oWvKods5+BinfcGTm2cV+hebhtuxg0uEiLaf0+S/25ilSMFwDWqA18peM8v7vNCGkUIZ/7S7RKtZKmewy1w1PAxS8Qx9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(36756003)(2616005)(356005)(2906002)(47076005)(4326008)(5660300002)(36860700001)(426003)(8676002)(54906003)(7406005)(7416002)(81166007)(316002)(44832011)(16526019)(8936002)(336012)(186003)(1076003)(508600001)(83380400001)(26005)(110136005)(82310400003)(70206006)(7696005)(70586007)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:59.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb32574c-50f8-4cf1-0d44-08d9a496b254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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
index b6a97863b71f..2c382533aeea 100644
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
 void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
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
index 4189d2808ff4..d91b61061b1d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -989,7 +989,7 @@ static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-struct cc_blob_sev_info *
+static struct cc_blob_sev_info *
 snp_find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 403ae5cddbe8..b794606c7ab2 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2010,3 +2010,68 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
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

