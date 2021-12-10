Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB95B470495
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbhLJPtR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:49:17 -0500
Received: from mail-dm6nam08on2059.outbound.protection.outlook.com ([40.107.102.59]:10720
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243530AbhLJPsS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA+/3qiErGk5xfeMQ4IWpxj6bzJpiJfZsbS7fttmL4dz7t9yldNf4g1xs0RfKuuLoEtlmT/LRkDmNeMlb55AUpDM9JDIEmGVhho4i+Ou0YVtxmGF9bklJgtk6jXa+yuTzIzIMnDGinaOkys/i/JUxXjcXtIKNG59nSrftL3pHeTW+ODj1yjAnytlmX7MAqt2TOknwMg6mcyPkTeIyLosK+cI19MoY3qdVPfUYyas+CUD+OPjkWLCzxExIE57tOWYUp8TgbWEFiuOKsmrrrCET3dMburIfDy+LXdDUyTE2sBsx3x5XYIckNUzkKNh+FL+9CnkjKCu0E9feOQzdl8sbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbZLSZ93H0GOKPTgy9HoogvFtczaoMe4sgJaHksKsYw=;
 b=foXgsVy6Pq82SUs/2kW4Ts189s0rCJbYhE85T4inoNp4dLg2/LLhiMo/bH0HauXvtudf7XqcmAz0enrex7ikt7beWPxXnXidn/j7RrNlmMC+yM5qxOIIAU5If+1Z6ieoZfww+Oegz5gFTW/SWv3m8nllh6nCvGh/UK2e+9R99k5+QYVY8uEuQRe0JMPP9cFYU4mkdObClF+noQf1QgZUE5pT2TNiQahbwh3dab1j2W9qahS8uY/SCCkPSYp9rgluSA+4u50C/mjJTPfrS1ELgPrDMq3MKwavO5cQA1tm1Fvl/b40XHvXOqMb1O3KvnPII+HJjnWz90/AUY5w/w+b6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbZLSZ93H0GOKPTgy9HoogvFtczaoMe4sgJaHksKsYw=;
 b=Kg5yUt/aAg7fh4z6JmbRY2/xUoKzX4iFES08PMXxj8PRGSsxGMRBBfHM3O7r2xDDh/2LMefl/ag1lnFAyc+SGc3J0a1w3E1aalocG7h9/MlK6XhZGXg3DRX5+RiSASNW5ayfOVmHnpLIkVngKxf7wPpTwQu9YUaKMBCYjPOQbuA=
Received: from BN6PR14CA0002.namprd14.prod.outlook.com (2603:10b6:404:79::12)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:40 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::27) by BN6PR14CA0002.outlook.office365.com
 (2603:10b6:404:79::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:37 -0600
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
Subject: [PATCH v8 31/40] x86/compressed: add SEV-SNP feature detection/setup
Date:   Fri, 10 Dec 2021 09:43:23 -0600
Message-ID: <20211210154332.11526-32-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7b70b9e-220b-4c44-91c3-08d9bbf3f9df
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915E0C53E8B396B3D7A00C3E5719@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDxEYKwyXjmffqL5docS2Y82CWohw8726hFGjD/PVmiJARQI9a8IjPwBNwnrAlJr0wAG1TiaoqPk/pf0Yz0BKLc+LI+2hm3CkpP5XYspz+Tgf0/AjhFq5rUTGUYSd0RgPbU5ZYat2NmKArJUhc9e6tm5vL0fbHZss1vJYZh6+yVhG4Nx1jX0ZO92RtLPYI7KKqQB6MN210tQO0y6SJXnmrXWflvHXk1PtrDw46zkgjLLmR7RpCIqspLrPklHL2Hk/Qtzmo3Zey3E/ThL7wQUAVFfD4Y6WByvpUO/Uw4CEZy5GeDx95gcoAlqu1hWH5gA6fro95njRNdrhZorwE2ocG9AaLijUK5Oz3Qyxx+VNtkudXPLFryzQd2pAkNdmfRDEk2d663UdviV6CQE90WzF6mLsWmgBwuP+XbI+LNtnpHloAToNUPlfe/Wh8IsPJMS6fKWxF91Vp/rTfRbdkn1oXThOx/J7KI7K8utwSa9nm8zKdf7DBgBBEGQ00lMig1Po9DaRRTM15xoF8oq9Zjv1EDtbn7L55ACVas/gVwI3bH94pOstwzXUj1wTnXW6luD63mqYqhx3UMtfsiw7ULQDg78uNV2+X+8v32OkyPHPFo6CsS5EBcEoeizi6sHQE7xjnaciZhdee+I6WRVzrSmSnzuq76ucAeowTLbSePL2M1fimSTqVahSYpDPGn264hl94TvralsFYflloAuTh0nNmb6tg5+YykVPcLgNDe8di4iTAYbWoEPml7PsPs8YGKP5xl/rBJP4YFnNrQxHU30kVMmX9xckhcc9HRRFxyD1JNhTzU68/XEhBKP7lxdb+Uv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(36860700001)(2616005)(2906002)(36756003)(44832011)(5660300002)(54906003)(7696005)(186003)(356005)(4326008)(82310400004)(40460700001)(81166007)(110136005)(83380400001)(426003)(26005)(316002)(336012)(16526019)(8676002)(8936002)(70586007)(6666004)(70206006)(1076003)(7406005)(86362001)(7416002)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:39.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b70b9e-220b-4c44-91c3-08d9bbf3f9df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
 arch/x86/boot/compressed/sev.c | 91 +++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h     | 13 +++++
 arch/x86/kernel/sev-shared.c   | 34 +++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3514feb5b226..93e125da12cf 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -291,6 +291,13 @@ static void enforce_vmpl0(void)
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
+	bool snp;
+
+	/*
+	 * Setup/preliminary detection of SEV-SNP. This will be sanity-checked
+	 * against CPUID/MSR values later.
+	 */
+	snp = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
@@ -311,8 +318,11 @@ void sev_enable(struct boot_params *bp)
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
 	sev_status   = rd_sev_status_msr();
@@ -337,5 +347,84 @@ void sev_enable(struct boot_params *bp)
 		enforce_vmpl0();
 	}
 
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
+
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
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
+ * Initial set up of SEV-SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
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
+bool snp_init(struct boot_params *bp)
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
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	/*
+	 * Indicate SEV-SNP based on presence of SEV-SNP-specific CC blob.
+	 * Subsequent checks will verify SEV-SNP CPUID/MSR bits.
+	 */
+	return true;
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f42fbe3c332f..cd189c20bcc4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -145,6 +146,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+bool snp_init(struct boot_params *bp);
+/*
+ * TODO: These are exported only temporarily while boot/compressed/sev.c is
+ * the only user. This is to avoid unused function warnings for kernel/sev.c
+ * during the build of kernel proper.
+ *
+ * Once the code is added to consume these in kernel proper these functions
+ * can be moved back to being statically-scoped to units that pull in
+ * sev-shared.c via #include and these declarations can be dropped.
+ */
+struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -162,6 +174,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+static inline bool snp_init(struct boot_params *bp) { return false; }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index dabb425498e0..bd58a4ce29c8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -934,3 +934,37 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
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
-- 
2.25.1

