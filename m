Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A924D0A0E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiCGVj6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343635AbiCGVhu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B689A7E09E;
        Mon,  7 Mar 2022 13:35:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdqJyHUIhawAd1I0n6LY2FmbTOHISh2OL2TFJUBpoZg2bokz1nU2f6YPRhg3W/fckSwoGV4EaKkXiT7Th0P6v5eSL0LucDpbQXbY4cEL5Nst62muXL8DIV50JReMpw7/M87eUIcqKTba46nZ/ewUilH8wrhwnSqXSakHGszat5kPBf1frWPlRP4Pr/anzL8yrL1VZ1QUJfJRt8qrJnTKDrxUwf5XrlH+/aOba+7bGj8lk5d43ExElAWAD4ZbDmYi50hrPwGpxZY+fKzk4RJn82Jws/FouN8W2ie3pw8WQb+aQMGrJek8yf+ggtrt+kZG2asfgsAYPCHoi638oS5X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TauUiJrOWGEd/a9biVcu7UHR5VGYer6dt/kZECY4sCM=;
 b=OFEOMarmexMD0lo/wGozn0r5p+aw1/8kYnBX2zSqmYZZmW5VoTGlqpcStUupJC2bgS9/6KWShW03GyaEJW8LbtcODNHg7erBY1J/2/TBBR4rxq68y6fj2SkPIc1n2k0skndPgPI4eaTAOcBMsB9HBrxpAHhT1royFwJynv/Lo/fYsvIHVThoWCxQwcRHHzaHGYSIOGyh3qL9kla8QjxdGzaCUnwYvSQGB6ciqK1Lf3IW12lFUjXJ/yOAVvqzlzGgYlQfV94UOSRK+j5ExRd8GHm72mM/cX477pwMCdy2h4Z+aHP8sFyt/96mja0AY0ImiKte9M3pBewFkIjDgmlFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TauUiJrOWGEd/a9biVcu7UHR5VGYer6dt/kZECY4sCM=;
 b=4jL4NLJvUdMFfz3UCDaNv7/sdz/zDV30SyDxGy3HLq5QVkV8ovsQoKWDOiBBT24CG+DaiFMbBAmnuljokdW0UO4t3l5Gu2m+6w8Yu0DmPu7h3O5R03CyWcZ2wL97uDZNvFtovcx/prK7pyl4Tqf+D+BCljJF6zhR6JYoPQkzxUQ=
Received: from DM5PR10CA0022.namprd10.prod.outlook.com (2603:10b6:4:2::32) by
 BN8PR12MB2929.namprd12.prod.outlook.com (2603:10b6:408:9c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 21:35:21 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::80) by DM5PR10CA0022.outlook.office365.com
 (2603:10b6:4:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:13 -0600
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
Subject: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
Date:   Mon, 7 Mar 2022 15:33:42 -0600
Message-ID: <20220307213356.2797205-33-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c969079c-6018-4137-42af-08da00826187
X-MS-TrafficTypeDiagnostic: BN8PR12MB2929:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2929E0122AEAD5CF5AE168EBE5089@BN8PR12MB2929.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOLJqks6LYrZCSuWQoGY+rZlMa8GApQErDAvU/TXfUFqzivR4FDK7/YIX8PbH/OeJG0VtDW3oVFgtZnOWhgHWUDPwvGAbfLwPqQE6a5GNdOi2xh8weFYylcpBAdBU3q+dxEUi5QNm1gnMxmSruiZO5xl10wi9ejB2HUYGPx/TgT9IoxE96XZ+7HLVk71Cd/KQIWlxJhp7txVt7iHGT7XEWsjNeGJCxy3qTdB157PBtj6E+HbQz1EguuqLmR+8QS2FoxIJ9gybuWAyK/vA9ZXqDM95olpeWdDoaUeWkr7k6aV8sY/j26AD9IdOzb8grp02rfxLcHDS+npVCcD3jViIXxi/jYPiY0yQv2uImtB3ajquBi7Zz75/7WgxOSJovP/O6NHWVqHsrMXd4xJcufD61XP4JHsEo66paXpmMcWfZsvrvlEqodtvsRDAWHUhzoCWjL5+8/nzPBeAkrN+Q19OP5Yue9vR5ASGnikZn/5dEpRB/isxe2m21X0FW9tjhz76H7wm0j3EtDQJvoB/8rExjehToogKVpt+7MJGK6GaVKEF1l2RhFFDPGpYir1qiSWRUtjpvVIfgSclxR3aCCDtaG7UYIIVt3ulS8ZDqFohwRK9dP+MmEckDjYW4M40nD4cj8q3hyHgut/hJwv8zGJ5PQnbaVMUBuiiPobwPoVet7+XdgMyJvuPjy3cUInOE9ev/AgBy1JGZ5GW208wkZEg7Z02B0uuV6BT7mPodG2WP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7416002)(5660300002)(44832011)(508600001)(7696005)(7406005)(86362001)(8936002)(30864003)(6666004)(70206006)(1076003)(2906002)(16526019)(186003)(26005)(40460700003)(4326008)(8676002)(82310400004)(70586007)(2616005)(47076005)(110136005)(356005)(81166007)(36860700001)(316002)(54906003)(336012)(426003)(36756003)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:20.7411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c969079c-6018-4137-42af-08da00826187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2929
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

CPUID instructions generate a #VC exception for SEV-ES/SEV-SNP guests,
for which early handlers are currently set up to handle. In the case
of SEV-SNP, guests can use a configurable location in guest memory
that has been pre-populated with a firmware-validated CPUID table to
look up the relevant CPUID values rather than requesting them from
hypervisor via a VMGEXIT. Add the various hooks in the #VC handlers to
allow CPUID instructions to be handled via the table. The code to
actually configure/enable the table will be added in a subsequent
commit.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |   2 +
 arch/x86/kernel/sev-shared.c      | 324 ++++++++++++++++++++++++++++++
 2 files changed, 326 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index e9b6815b3b3d..0759af9b1acf 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -152,6 +152,8 @@ struct snp_psc_desc {
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
+#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
+#define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b4d5558c9d0a..0f1375164ff0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -24,6 +24,36 @@ struct cpuid_leaf {
 	u32 edx;
 };
 
+/*
+ * Individual entries of the SNP CPUID table, as defined by the SNP
+ * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
+ */
+struct snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 xcr0_in;
+	u64 xss_in;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u64 __reserved;
+} __packed;
+
+/*
+ * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
+ * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
+ * of 64 entries per CPUID table.
+ */
+#define SNP_CPUID_COUNT_MAX 64
+
+struct snp_cpuid_table {
+	u32 count;
+	u32 __reserved1;
+	u64 __reserved2;
+	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
+} __packed;
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -33,6 +63,19 @@ struct cpuid_leaf {
  */
 static u16 ghcb_version __ro_after_init;
 
+/* Copy of the SNP firmware's CPUID page. */
+static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
+
+/*
+ * These will be initialized based on CPUID table so that non-present
+ * all-zero leaves (for sparse tables) can be differentiated from
+ * invalid/out-of-range leaves. This is needed since all-zero leaves
+ * still need to be post-processed.
+ */
+static u32 cpuid_std_range_max __ro_after_init;
+static u32 cpuid_hyp_range_max __ro_after_init;
+static u32 cpuid_ext_range_max __ro_after_init;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -242,6 +285,252 @@ static int sev_cpuid_hv(struct cpuid_leaf *leaf)
 	return ret;
 }
 
+/*
+ * This may be called early while still running on the initial identity
+ * mapping. Use RIP-relative addressing to obtain the correct address
+ * while running with the initial identity mapping as well as the
+ * switch-over to kernel virtual addresses later.
+ */
+static const struct snp_cpuid_table *snp_cpuid_get_table(void)
+{
+	void *ptr;
+
+	asm ("lea cpuid_table_copy(%%rip), %0"
+	     : "=r" (ptr)
+	     : "p" (&cpuid_table_copy));
+
+	return ptr;
+}
+
+/*
+ * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
+ * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
+ * and 1 based on the corresponding features enabled by a particular
+ * combination of XCR0 and XSS registers so that a guest can look up the
+ * version corresponding to the features currently enabled in its XCR0/XSS
+ * registers. The only values that differ between these versions/table
+ * entries is the enabled XSAVE area size advertised via EBX.
+ *
+ * While hypervisors may choose to make use of this support, it is more
+ * robust/secure for a guest to simply find the entry corresponding to the
+ * base/legacy XSAVE area size (XCR0=1 or XCR0=3), and then calculate the
+ * XSAVE area size using subfunctions 2 through 64, as documented in APM
+ * Volume 3, Rev 3.31, Appendix E.3.8, which is what is done here.
+ *
+ * Since base/legacy XSAVE area size is documented as 0x240, use that value
+ * directly rather than relying on the base size in the CPUID table.
+ *
+ * Return: XSAVE area size on success, 0 otherwise.
+ */
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	u64 xfeatures_found = 0;
+	u32 xsave_size = 0x240;
+	int i;
+
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
+
+		if (!(e->eax_in == 0xD && e->ecx_in > 1 && e->ecx_in < 64))
+			continue;
+		if (!(xfeatures_en & (BIT_ULL(e->ecx_in))))
+			continue;
+		if (xfeatures_found & (BIT_ULL(e->ecx_in)))
+			continue;
+
+		xfeatures_found |= (BIT_ULL(e->ecx_in));
+
+		if (compacted)
+			xsave_size += e->eax;
+		else
+			xsave_size = max(xsave_size, e->eax + e->ebx);
+	}
+
+	/*
+	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
+	 * entries in the CPUID table were not present. This is not a valid
+	 * state to be in.
+	 */
+	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
+		return 0;
+
+	return xsave_size;
+}
+
+static bool
+snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i;
+
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
+
+		if (e->eax_in != leaf->fn)
+			continue;
+
+		if (cpuid_function_is_indexed(leaf->fn) && e->ecx_in != leaf->subfn)
+			continue;
+
+		/*
+		 * For 0xD subfunctions 0 and 1, only use the entry corresponding
+		 * to the base/legacy XSAVE area size (XCR0=1 or XCR0=3, XSS=0).
+		 * See the comments above snp_cpuid_calc_xsave_size() for more
+		 * details.
+		 */
+		if (e->eax_in == 0xD && (e->ecx_in == 0 || e->ecx_in == 1))
+			if (!(e->xcr0_in == 1 || e->xcr0_in == 3) || e->xss_in)
+				continue;
+
+		leaf->eax = e->eax;
+		leaf->ebx = e->ebx;
+		leaf->ecx = e->ecx;
+		leaf->edx = e->edx;
+
+		return true;
+	}
+
+	return false;
+}
+
+static void snp_cpuid_hv(struct cpuid_leaf *leaf)
+{
+	if (sev_cpuid_hv(leaf))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+}
+
+static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
+{
+	struct cpuid_leaf leaf_hv = *leaf;
+
+	switch (leaf->fn) {
+	case 0x1:
+		snp_cpuid_hv(&leaf_hv);
+
+		/* initial APIC ID */
+		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
+		/* APIC enabled bit */
+		leaf->edx = (leaf_hv.edx & BIT(9)) | (leaf->edx & ~BIT(9));
+
+		/* OSXSAVE enabled bit */
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			leaf->ecx |= BIT(27);
+		break;
+	case 0x7:
+		/* OSPKE enabled bit */
+		leaf->ecx &= ~BIT(4);
+		if (native_read_cr4() & X86_CR4_PKE)
+			leaf->ecx |= BIT(4);
+		break;
+	case 0xB:
+		leaf_hv.subfn = 0;
+		snp_cpuid_hv(&leaf_hv);
+
+		/* extended APIC ID */
+		leaf->edx = leaf_hv.edx;
+		break;
+	case 0xD: {
+		bool compacted = false;
+		u64 xcr0 = 1, xss = 0;
+		u32 xsave_size;
+
+		if (leaf->subfn != 0 && leaf->subfn != 1)
+			return 0;
+
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (leaf->subfn == 1) {
+			/* Get XSS value if XSAVES is enabled. */
+			if (leaf->eax & BIT(3)) {
+				unsigned long lo, hi;
+
+				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
+						     : "c" (MSR_IA32_XSS));
+				xss = (hi << 32) | lo;
+			}
+
+			/*
+			 * The PPR and APM aren't clear on what size should be
+			 * encoded in 0xD:0x1:EBX when compaction is not enabled
+			 * by either XSAVEC (feature bit 1) or XSAVES (feature
+			 * bit 3) since SNP-capable hardware has these feature
+			 * bits fixed as 1. KVM sets it to 0 in this case, but
+			 * to avoid this becoming an issue it's safer to simply
+			 * treat this as unsupported for SNP guests.
+			 */
+			if (!(leaf->eax & (BIT(1) | BIT(3))))
+				return -EINVAL;
+
+			compacted = true;
+		}
+
+		xsave_size = snp_cpuid_calc_xsave_size(xcr0 | xss, compacted);
+		if (!xsave_size)
+			return -EINVAL;
+
+		leaf->ebx = xsave_size;
+		}
+		break;
+	case 0x8000001E:
+		snp_cpuid_hv(&leaf_hv);
+
+		/* extended APIC ID */
+		leaf->eax = leaf_hv.eax;
+		/* compute ID */
+		leaf->ebx = (leaf->ebx & GENMASK(31, 8)) | (leaf_hv.ebx & GENMASK(7, 0));
+		/* node ID */
+		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
+		break;
+	default:
+		/* No fix-ups needed, use values as-is. */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
+ * should be treated as fatal by caller.
+ */
+static int snp_cpuid(struct cpuid_leaf *leaf)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+
+	if (!cpuid_table->count)
+		return -EOPNOTSUPP;
+
+	if (!snp_cpuid_get_validated_func(leaf)) {
+		/*
+		 * Some hypervisors will avoid keeping track of CPUID entries
+		 * where all values are zero, since they can be handled the
+		 * same as out-of-range values (all-zero). This is useful here
+		 * as well as it allows virtually all guest configurations to
+		 * work using a single SNP CPUID table.
+		 *
+		 * To allow for this, there is a need to distinguish between
+		 * out-of-range entries and in-range zero entries, since the
+		 * CPUID table entries are only a template that may need to be
+		 * augmented with additional values for things like
+		 * CPU-specific information during post-processing. So if it's
+		 * not in the table, set the values to zero. Then, if they are
+		 * within a valid CPUID range, proceed with post-processing
+		 * using zeros as the initial values. Otherwise, skip
+		 * post-processing and just return zeros immediately.
+		 */
+		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
+
+		/* Skip post-processing for out-of-range zero leafs. */
+		if (!(leaf->fn <= cpuid_std_range_max ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
+			return 0;
+	}
+
+	return snp_cpuid_postprocess(leaf);
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -252,6 +541,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
 	struct cpuid_leaf leaf;
+	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
@@ -259,9 +549,18 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 	leaf.fn = fn;
 	leaf.subfn = subfn;
+
+	ret = snp_cpuid(&leaf);
+	if (!ret)
+		goto cpuid_done;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
 	if (sev_cpuid_hv(&leaf))
 		goto fail;
 
+cpuid_done:
 	regs->ax = leaf.eax;
 	regs->bx = leaf.ebx;
 	regs->cx = leaf.ecx;
@@ -556,12 +855,37 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+static int vc_handle_cpuid_snp(struct pt_regs *regs)
+{
+	struct cpuid_leaf leaf;
+	int ret;
+
+	leaf.fn = regs->ax;
+	leaf.subfn = regs->cx;
+	ret = snp_cpuid(&leaf);
+	if (!ret) {
+		regs->ax = leaf.eax;
+		regs->bx = leaf.ebx;
+		regs->cx = leaf.ecx;
+		regs->dx = leaf.edx;
+	}
+
+	return ret;
+}
+
 static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 				      struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	u32 cr4 = native_read_cr4();
 	enum es_result ret;
+	int snp_cpuid_ret;
+
+	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
+	if (!snp_cpuid_ret)
+		return ES_OK;
+	if (snp_cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
 
 	ghcb_set_rax(ghcb, regs->ax);
 	ghcb_set_rcx(ghcb, regs->cx);
-- 
2.25.1

