Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4257A4D09E1
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiCGVkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiCGVh4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB65888ED;
        Mon,  7 Mar 2022 13:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8UQRmbHDQAIMU4lZSuzgeeokCNMR8g7ugDTBXQD53FZP+yoTDa9VGPb7iW0I5DNpGNSUQRPEj+MzpiTYnXMiFah0wg18IOKxK7b6lRyQtC+G/Eqi7zs1eOFDYPxOOyvz7HFtBA5z4EK4W+V5sCYc4nKS4SVe4btGL2hMASBocjWNRrHoSYNTyLH74AOn4DyljwNoUm6s4n9tf/F2PmkcruCpuTNS6amtiHLGgkux8ZVddzd3tBazqVycm+H+9C0cG5t9P5lbrMKtJCVt+QLO1AN033j2Uc85BExVaGs/4ebc6jzMtSYrRhhVg8jCNQLN/VnPdT6DwPFCikFjXNA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g7GSkNevjftmQo31UT8/9iaSW7ZtQ6aPYXpQ9HnkRI=;
 b=GDlBrnFbxsGcrCGxweJROVU3Kl1Yw8pd0BWrEOeCGYYfntry8UYzbV8+7245qU6UEq6AHze7Nrh9duLpE/V+EoxXFtrdjLxuRY7pL8WUL4krxqkWVsKhOzT4Eucc5ox9GqNLEJ0OZZO/XzIX64Lw4bqfjD4UtaT/6qCihWbmx6I+zfX+ub2JJNPZ/qmEE2qZbzOLoOI6FnRkOrPY2y8VUQlXjfxCuuMlrFELADuX3gJMEsJN3quLDoe5sL33OKqo03Dbd4ITefhmLdLFZfflehMRweiSlAZgfRk72LrLnGcQNhzMyZZ45FfNUpmOhA++SurbhOpTeFZr2rFcOuOfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g7GSkNevjftmQo31UT8/9iaSW7ZtQ6aPYXpQ9HnkRI=;
 b=VwWSl9nw6e1R5bX0SHwXsCRqKjwOfiFzZTAC6hXzr+dbjGpiy0f1Ix88iT+R+0jCMR1YImNd5bzyJyoi+E4RH47gZMWR/0xxiq4syqNqFXf/M/zFI3Nv6N1DmoSkQGiiFRpIgDFtOlrOl5rxTUxsCORw5sAvNxfa3e3qsnVEEfU=
Received: from BN9PR03CA0097.namprd03.prod.outlook.com (2603:10b6:408:fd::12)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:34 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::96) by BN9PR03CA0097.outlook.office365.com
 (2603:10b6:408:fd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:33 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:23 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup
Date:   Mon, 7 Mar 2022 15:33:48 -0600
Message-ID: <20220307213356.2797205-39-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd585919-83f9-4ceb-823a-08da0082693a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4240AE9E5A0F67CC85306CC1E5089@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4KBKRTPGyD+jW677K/799HqoQRH7he994mIKxRbYt8HLXzyxosHyF+pHyN9TeoR4Xvuwf1fnpYdMyeQ1YUNIH6tni8nDCNOAKjMGD9/EJt2Y4/+EhGMBeYxm7qrliAsuLyPn/8vfsTTSaKFvtNlarTnyfNy+0ojRfdDnbdOhpW1mXGJFSf02Hi2MsSfOj4s351KZhdXZ5NIK2zdaGNKp6w5TDZpJ/OWsCznaFqKstt1H13KhJTvHd5+Q/06LF6yrWlzWBnSNmio8lJDqiquON4pVhMQBPGkY2R+/Q7RUBfcY7TEws8CejXzKbg1S0ClrtFS0qvu6mJfgPXGLO4FOr9js1389mZ/mJepz7kzCM/cXsnGJKHqyYon5z5WuKPT6xUC3+sCIBahb6f6c32sZ10aXinL+MrQdSPvgsnBfxbiayw7JAEyDXWCe5FNt03/rwSSLcrJsY5dEc/bqfc7rcnalQqwpnBqKzVtxFfxydGvwMXewUz49c9fLj/JuhsTvXmRiZNVZJuHtRmMRsm5vVPXDEcefuZl/kpy0ZzLH4S/3bbTkjoJw78tQUjkJwgmXEkcDfu28FJOdXb2bjo2flAAlDUw1Jvhf4k/eM9BmN0hacucOO5qrNRm7eItMEEPAkdo2jeYN/hasTSmuyF0WmxAMgoaY/ICh1NbB8OTE6XhviO3vMJL9W6jbt4HT1V+3hZo+h6h6QX9eNiuw20JnUUJfrqQOmSe5El2r8Q/hKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(44832011)(86362001)(82310400004)(8936002)(356005)(6666004)(2906002)(81166007)(7696005)(40460700003)(83380400001)(47076005)(7416002)(508600001)(336012)(54906003)(16526019)(186003)(26005)(110136005)(426003)(36756003)(316002)(1076003)(7406005)(8676002)(36860700001)(70586007)(70206006)(4326008)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:33.6912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd585919-83f9-4ceb-823a-08da0082693a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
index 97c0aa44ce2d..5a7df617394b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1977,3 +1977,67 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
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
index b43bc24d2bb6..f415498d3175 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,6 +45,7 @@
 #include <asm/sections.h>
 #include <asm/cmdline.h>
 #include <asm/coco.h>
+#include <asm/sev.h>
 
 #include "mm_internal.h"
 
@@ -509,8 +510,11 @@ void __init sme_enable(struct boot_params *bp)
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
@@ -542,6 +546,10 @@ void __init sme_enable(struct boot_params *bp)
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

