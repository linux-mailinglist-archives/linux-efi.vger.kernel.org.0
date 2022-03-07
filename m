Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA904D09E5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiCGVjr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbiCGVhu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE677A9F;
        Mon,  7 Mar 2022 13:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/sbS9xIktOj5gCzqf82lhv4H9r5owC7+GVu8CV3SaCqKjVxh/5neoKVo+/ARMVP4TInT6XF6cIGZ6l/PaYwdBxIYYsckK5tXR8L9niQxIRrIhE9zjE+5YnWBDL2qBAPinovC8lzSMHPW///5YcUl3eWzyn3B0S0UkaVx9rgOfCY9NSIVrFrN2G5LWcWFxKndARE8hn65js6X9kgcoLRohhRXMQWQ44RvVhu2ck0zeWIUpKgh92ylFOrCJKYis/zPijzWvVSQxKyi9EeTtZpx67hcEXrQQjhgrhZGD5sWn65amAR3lLA8otWEsNpNaXE9ciJylhoGWetKTjuyFMWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru0Ow8P8Y56s5ktioTvnArAhG9CFR+1Uno56elzvA4k=;
 b=Tzzx3P2EYWDTIYAfSO3dSoNf4czt2rogutLWo3V6TO6aS/7oPp0eFRLJ8y+Y/Irw7JY7f+iLz88BIZYN0stu4qrIY/Ypc6gZ/iKZSS8U4/0QVvtOG0G4rWw2LEqOnlC3FNR+qZD2DQaqpuJYQEdt/Uwul7C3TkICbyVKevQvDEoXdtPAcrWExyHt6dW5ZxzRmQri25TXdo4TY3/TDxOyBTbtremuXallVApkFPTBdrvGOGdQMeDZiI79boIDSyIoK1b+yHrsivqH38cie2yXI/cDsle6qZB0bpn0WMtBtIiLx29xlI75qsAe5tdKV2arUdLUjLf2wTG/5wPlEZlPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru0Ow8P8Y56s5ktioTvnArAhG9CFR+1Uno56elzvA4k=;
 b=ufJTOrW9WTBBr5J/6eUgqhD0X6GA07PQ0Y6lm6rU/cAENmNEIVKXrNTBTFk6zfdWR3qtcx7waKLIyMzUx6kh25Umx/B0FDcK+JX38v/0o87fNM1GhNNsDrUc9tmqZKh2raN3ltum7nDxPWxKWjw34GDxl9LNoHBzhbFbxtw2G80=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:23 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::5c) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:16 -0600
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
Subject: [PATCH v12 34/46] x86/compressed: Add SEV-SNP feature detection/setup
Date:   Mon, 7 Mar 2022 15:33:44 -0600
Message-ID: <20220307213356.2797205-35-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2904f51-9bfe-4b24-3ba9-08da008262de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090131D1F9B05995A35B56FE5089@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUQFchqd6nvFe0NgJ8ljoWZBIuh/5YRROJQfe7kTUf9E14/o61rTKMou83j1goHTrM9bkREJw7MXCK7sPjWFchs3HhEx7umU+O/08oIg0/7h6gFv2GVlaifyFTo2yqiYwPINMc1ehizVyioowpOkZs0gx8CN92/xijtQVhwVMECmV/bS78mbjYjACocB8v2c/a/mpcU2y65viYZuGuPxEMguH6PGXynJHUkk38gmVNUB1YJH8qp3OzuWptmmbDMur0FByCl42XrBTTkHF2xWtkg+M9sgTVJxrs4vnSLkSvRH4GGkJXuLUMLXjr16Mv3vllnzMBbX0gkykaweI1zvb0VkoVQMmN8lSAJw1fG+auAS9W45ZGF4uInB8PeQWMPpQrwByFnAzbVMFCINIbKFVnXjSK5Zy7VyEzJHTm3vLnSlCGAp0AkZ2yUVspNEFHDZPhNpe2wonynI9cxLKuRXcA9E8IG/KNTHIJXBmM6jAb9f5KDjmcEUPvIu+qiEeHGS9bDgvcVsMv8aL5AblOWxPVyOAHo0v1NQUlQhGGoSlftc0TNx0OgkqFuSQw+0ukRNqM29h5I3zo8zNgtP3VzH2h94W5STO0fLSa2x90fAtzh8Kxba1soOZ4cvgJ2RT4o4Yehl30qDf9m8h2F0MplM7nRllVC9E2iadjC7oNvT8AFqiORfvtexShDms30GhFYYovgHjxCkQ3n8N5+IM5n363pt5slHX7rm/DQEfcrK3I4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(6666004)(508600001)(82310400004)(1076003)(186003)(86362001)(36860700001)(16526019)(426003)(356005)(2616005)(7696005)(81166007)(336012)(83380400001)(8936002)(5660300002)(7406005)(7416002)(4326008)(8676002)(70586007)(70206006)(47076005)(36756003)(44832011)(2906002)(110136005)(54906003)(40460700003)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:22.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2904f51-9bfe-4b24-3ba9-08da008262de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

