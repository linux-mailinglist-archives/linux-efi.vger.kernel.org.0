Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821FD49FF67
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiA1RVW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:22 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:44623
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350675AbiA1RTa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBdYw5FFf8QhdkG2hWiLqJcdArdmNfKilSYmCOx1bd1me2J9ASwwI5l3dpbA6RKVu+E9CGaeZafNeZNhXb6b6Q2SAUoRpa5PhCIlfql07SKRyUiLKM8cpjjaB9oyl3RHBFaILD5HW/w659NxP1jwwKtQ1eErjopmGw342I9hbmE4ia9kk7c/S82MRzqA9wN4AIeD2kRRf8iPHgwEE8qEnInwOZljs7+BNVV+VzxFzrA7SEF7YmfW2gICAAe42UvqW/Omt7HlHXusv0+7D/3lMSj++KtwniNRGwEn7I4FySA+TQNToi3IJXmW52mjGbRZIVZ1NQtN+6U5RcX44h4h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqDiKIBLEmOYPzIbgQH4Pbk3+UK6339kPVbtrXswd5s=;
 b=DS/kTe3PUD7q+z0KjgB3K7JT9kE50CNmguq8tw3O9t91DVrFRRHPTD75ElhKh251nN4JXu6AaYDrwSdG6muKtm2HYJ4ZSpToyxHCEY/Z5g+1vb0ehXatPfNtqSfiIA8e+5gkcznJN9wP+jHtoIYrgwaun1IVTN3PW7mgNo0gbkIZ1kSL3U3/bQJY3M2E7dUcNOty8GDJ+R6jZL6evuHB7zqnyxPR7I1XuRPsvZGIm2xRHbD/RuhCNDVdgbthhnoTXR+bI0UQO9murpsLzGUp6kb1fpVOrMsEDAvm/6NwFkBH5+n/nFPYDls1ill0B2HDAti9CQe+qaePBc221BJ47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqDiKIBLEmOYPzIbgQH4Pbk3+UK6339kPVbtrXswd5s=;
 b=UifMbztZ55Ps6joW2CKgXmuUruE7iesJUxKz/W+Ftsv/k3RkQrPNA8BMDMMMpKCj8R0pb7srvEOjkjpZ7ch4g01mHov4N1FwATu/sLeyyAHHAStPus/n4HJaQuFTN29WunRePc37dkDTKb8NyRRp9HGA7AvspfttU7y4vKbngC4=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 BN6PR1201MB2498.namprd12.prod.outlook.com (2603:10b6:404:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:19:27 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::1b) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:19 -0600
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
Subject: [PATCH v9 38/43] x86/sev: Use firmware-validated CPUID for SEV-SNP guests
Date:   Fri, 28 Jan 2022 11:17:59 -0600
Message-ID: <20220128171804.569796-39-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a364fc05-8b1c-4e98-9170-08d9e28256a3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2498:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24987D3030B4BFA74481EE4BE5229@BN6PR1201MB2498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgichVzOe2wirhbspkUZCJ/ZI3G8y9bSHPihERTrp53AjRSR77ERjjlG9A8RXTX+OaEkZdyfCYvAaZ4F0wOJSY8MlsB/QS1PtMJ1K7hygAN9Q9zCtJHX4aJp2bfY7raZgwi2cafEYo0y3BVLM/oXCefSMZit9gj/dL2R4UvmSrBsWDxySInFNUJoDPj6XWGWCjhxd9Wcl/xHPE5Q15iQVktw5DBBV27gERhwdbVd03TZrt+rFm/hG8SkT8FzqC8j0HkqHT+0yK3HVuvhCnyZfMGZvr8Zg0UDjBXqUG3CF8+kagy+T4yrUaUuvZMJnDxmQF7dvbTPq5bjujPueJetK9ziugbB3BOuS+9J6WHEqATUrlHKEHGcQyFiHaDJd5/2qx0zbBgllmX68CYTQ4Tg2Pceobu49VYT/bI+hU98W0zHJutZHjuZOK0zUr157+62czVxKc65IDfhgLqI7nW3yiRcFmcDvxRj1R1WvNNogHO98bWh35H2eqix/kNhg80RNBFNPRaY18/ltA+b15k1Mk3rJi+J1qjuVw1AESq3ieMkdx/RwKjD5M1461V7a8qHTN6AhzRBg+ftNkvPSwocmkUmllJ2QvE8b0fZQIvo3GhoktvRIgEzkF0VGA7fXxeW0Qpwdkdq1O1QGfXu7D5CZ+JlyindABPDrTr2Z2/z9jHHD5QW8xpXX9k98BEZhsqgcwALbyMlEBvxCwZWKCFbd+xNLXn7oUBMzlDP+4eGHms=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(83380400001)(36756003)(186003)(426003)(336012)(26005)(16526019)(36860700001)(1076003)(47076005)(2906002)(2616005)(316002)(6666004)(7696005)(5660300002)(54906003)(110136005)(15650500001)(44832011)(82310400004)(356005)(81166007)(86362001)(8936002)(8676002)(40460700003)(508600001)(7406005)(7416002)(4326008)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:27.5571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a364fc05-8b1c-4e98-9170-08d9e28256a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2498
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through a bootparams field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing blob from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing CPUID instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 37 -----------------
 arch/x86/kernel/sev-shared.c   | 37 +++++++++++++++++
 arch/x86/kernel/sev.c          | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index cde5658e1007..21cdafac71e3 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -393,43 +393,6 @@ static struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-/*
- * Initialize the kernel's copy of the SEV-SNP CPUID table, and set up the
- * pointer that will be used to access it.
- *
- * Maintaining a direct mapping of the SEV-SNP CPUID table used by firmware
- * would be possible as an alternative, but the approach is brittle since the
- * mapping needs to be updated in sync with all the changes to virtual memory
- * layout and related mapping facilities throughout the boot process.
- */
-static void snp_setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
-{
-	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
-	int i;
-
-	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_info_fw = (const struct snp_cpuid_info *)cc_info->cpuid_phys;
-	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_info = snp_cpuid_info_get_ptr();
-	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
-
-	/* Initialize CPUID ranges for range-checking. */
-	for (i = 0; i < cpuid_info->count; i++) {
-		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
-
-		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
-		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
-		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
-	}
-}
-
 bool snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2bddbfea079b..795426ee6108 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -961,3 +961,40 @@ static struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *
 
 	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
 }
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
+static void __init snp_setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_info_fw = (const struct snp_cpuid_info *)cc_info->cpuid_phys;
+	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_info = snp_cpuid_info_get_ptr();
+	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
+
+	/* Initialize CPUID ranges for range-checking. */
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 5c72b21c7e7b..cb97200bfda7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2034,6 +2034,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	snp_setup_cpuid_table(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2047,3 +2049,76 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
+
+static void snp_dump_cpuid_table(void)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_info->count, cpuid_info->__reserved1, cpuid_info->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		pr_info("index=%03d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it.
+ * So do it here. This is also a good place to flag unexpected usage of the
+ * CPUID table that does not violate the SNP specification, but may still
+ * be worth noting to the user.
+ */
+static int __init snp_check_cpuid_table(void)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+	bool dump_table = false;
+	int i;
+
+	if (!cpuid_info->count)
+		return 0;
+
+	pr_info("Using SEV-SNP CPUID table, %d entries present.\n",
+		cpuid_info->count);
+
+	if (cpuid_info->__reserved1 || cpuid_info->__reserved2) {
+		pr_warn("Unexpected use of reserved fields in CPUID table header.\n");
+		dump_table = true;
+	}
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+		struct snp_cpuid_fn zero_fn = {0};
+
+		/*
+		 * Though allowed, an all-zero entry is not a valid leaf for linux
+		 * guests, and likely the result of an incorrect entry count.
+		 */
+		if (!memcmp(fn, &zero_fn, sizeof(struct snp_cpuid_fn))) {
+			pr_warn("CPUID table contains all-zero entry at index=%d\n", i);
+			dump_table = true;
+		}
+
+		if (fn->__reserved) {
+			pr_warn("Unexpected use of reserved fields in CPUID table entry at index=%d\n",
+				i);
+			dump_table = true;
+		}
+	}
+
+	if (dump_table) {
+		pr_warn("Dumping CPUID table:\n");
+		snp_dump_cpuid_table();
+	}
+
+	return 0;
+}
+
+arch_initcall(snp_check_cpuid_table);
-- 
2.25.1

