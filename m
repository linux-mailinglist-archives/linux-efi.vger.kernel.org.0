Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926B4C32E8
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiBXRBs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBXRBO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:14 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4833B0A4B;
        Thu, 24 Feb 2022 08:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLNqdN/iMeoYlp8zvH4aAAAEFMEtFFXftrW2Gzfecq6XXU7VMPqGp8atgj/zcsE9A7RUrUKI8dW/HaJLSfVRHjBKGzixqfg6TIluzw4YDxtqKGo8DrV1Or7oLpEv/NnOBmcTdLnsFKgT0n8skQ4OsgNTRkBORQH45ZX8pImbnfpx0BcXTtSy+EVgyE2K25oXnzBvqeaclA+21DngMM6yxFYVA82WDivDbvWtr1B3Y+aWmxPcy4lJ2DVgK9uOnR0jinMzDurjpGb1Bc/BcYDD8SSjjiG0O0QjqHCBCPJPxjx+fHfw3cDNSfhHpi0pOvgpKSTUH5Vr96BhdIbtBJ8ibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru0Ow8P8Y56s5ktioTvnArAhG9CFR+1Uno56elzvA4k=;
 b=K0O8wmpj5uvTT07QSP3lRojh/819Y9K16jF5HR6TuYWSjpsOlgcDdGFlEmwfdiJHBbdHoG0z+qrm6mOqNRyDQpvweI2rtkJgXD/M+qNJ78a/6+IOeDkFenyPR3eE51xn8a+wtIrlfLXLucSgyOe9Ae6r5ZotH97G3xZKNjRXDjojEuSLhTWegaOAplbS5u3icsdz4YjSTzkOmLkVqz1LUivtLcXkwj5oYW9trWKDuRUY19fc9q8LSY7U/Qy90U8A5azUH9H1mPPxEQYiDZiHqSzJGJsaPRpr6ragmrc8TJn4qdihEuMSLVQf0W/hDPLRmM05XCSoJvzz9kEkUKb8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru0Ow8P8Y56s5ktioTvnArAhG9CFR+1Uno56elzvA4k=;
 b=4qUxsmoindOmqP3czQJjlMIHNYlp5DdhqSwuOXtA47OT0ogzMSBEvpif55pt37D1eSxZfbrzSmH6q048p5OyeZ9jZNeKw0ad7XcmDKu+WKyfCIbSyl+RrDO54ohmB4jGDGjNdqlgO+GgGDuCFjEDVfNKn58fXU9g0KzDk4f5VFI=
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Thu, 24 Feb
 2022 16:58:58 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::c4) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:52 -0600
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
Subject: [PATCH v11 34/45] x86/compressed: Add SEV-SNP feature detection/setup
Date:   Thu, 24 Feb 2022 10:56:14 -0600
Message-ID: <20220224165625.2175020-35-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb2a149-bad2-432a-5433-08d9f7b6f355
X-MS-TrafficTypeDiagnostic: MN2PR12MB4784:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB47846C9112F7FFDA819EDBA7E53D9@MN2PR12MB4784.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX9LMtz2Sce45gG+SVhChk7Pyq6G+I4wKa6ZUHZXeWP6ZJILthqkJR+B4BF7K9moJflk3j2sn/B8Qe/SXlYcJ6W1vv/2HAhdst7sf5nW3oUw5waqOc2XkJovkCwavxQuXzWDtIThbw+l74vYPgoLsFILE3a/5on++Q/U4QzqRPh4Jk8MSCynDtVpzGZzOgmpUJUlzqMd2GMpHmwKsCr6LZsqH7FTzxW3IoC9ODgiGQsv6CFp5w464Db3PwCksgBDpM9b0lqA9cAybs4+Z2tsPPtlayUs/3XbQ7XICMRuEAoMM0kEc5EV0d1LGZtmXP6aWT0ciS/DrhprPEyLNYac086a6OioiiOlJHhHod336IIj5Lu7UV8X44ktkJIvgBRJSId2cOdFAZ8m3jFrVicKQrImkWtS2hzlKmqncRIXGTzSkYgRvtxrguVZnX0zHL28KowU1UVYN3vtKSXRYG2+/s4nZc3mwGFZU6so8Ejfh+UC7+piL7t5/TPkqs7UkEN4OZ9xx7oy8KNF6Wu/tcrlNXYSjR62t6u7kqSlncK0J/7f2ox9J94u+wunVvRMNhcULODEAGWy7bL+yIrfsWGtF6RDAEJv4kuVBxoZGFSy2G06Cw6MDmpQtBDpjHrCUb1DhxEGc5mugk7gz0kB9FD2VZ5pui/XQBOKMExixzgZTHefKGbgJ/AFyk0aAcrNi6d8uHrg9c/Vmq1q8bfb0iwg3zVq8+VQGObDRIsneG6plSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(6666004)(316002)(508600001)(47076005)(356005)(36756003)(70586007)(70206006)(83380400001)(7696005)(8676002)(4326008)(186003)(16526019)(81166007)(44832011)(1076003)(7406005)(2616005)(40460700003)(8936002)(26005)(110136005)(426003)(36860700001)(7416002)(54906003)(336012)(2906002)(86362001)(5660300002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:58.7106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb2a149-bad2-432a-5433-08d9f7b6f355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
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
 arch/x86/boot/compressed/sev.c | 112 ++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h     |   3 +
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ed717b6dd246..9e281e89037a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -274,6 +274,13 @@ void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
 	struct msr m;
+	bool snp;
+
+	/*
+	 * Setup/preliminary detection of SNP. This will be sanity-checked
+	 * against CPUID/MSR values later.
+	 */
+	snp = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
@@ -294,8 +301,11 @@ void sev_enable(struct boot_params *bp)
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
-	if (!(eax & BIT(1)))
+	if (!(eax & BIT(1))) {
+		if (snp)
+			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
+	}
 
 	/* Set the SME mask if this is an SEV guest. */
 	boot_rdmsr(MSR_AMD64_SEV, &m);
@@ -320,5 +330,105 @@ void sev_enable(struct boot_params *bp)
 		enforce_vmpl0();
 	}
 
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
+
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
+
+/* Search for Confidential Computing blob in the EFI config table. */
+static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
+{
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	int ret;
+
+	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
+	if (ret)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
+								cfg_table_len,
+								EFI_CC_BLOB_GUID);
+}
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
+
+/*
+ * Initial set up of SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	cc_info = find_cc_blob_efi(bp);
+	if (cc_info)
+		goto found_cc_info;
+
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+/*
+ * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
+ * will verify the SNP CPUID/MSR bits.
+ */
+bool snp_init(struct boot_params *bp)
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
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1a7e21bb6eea..4e3909042001 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -151,6 +152,7 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+bool snp_init(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -168,6 +170,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+static inline bool snp_init(struct boot_params *bp) { return false; }
 #endif
 
 #endif
-- 
2.25.1

