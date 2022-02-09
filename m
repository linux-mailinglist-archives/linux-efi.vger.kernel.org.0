Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FB34AF987
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiBISPD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiBISN7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:59 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B249C033256;
        Wed,  9 Feb 2022 10:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abeT7KDfwQ/RBv6+bqVBTbgxImDK0FM0bzk96MViFwQjSAVgrPWYK5HluIfay2Hag8XzK/zl/vxbaM47TcGNnZPMFcgcg9q5A1T1O1lpQbQdDtHCuUkSc7O2Kk1z7d7cSixf0dDotCXou0m2plr0MwuYcqNZPiKlWR8fBXJDzu60Bvj+FF/mlsAtirax6pL/vJlNB0PIPCLJtsEYgvTRfHJ6wL2snjg7lwWJItBrXjvC7lQDq1zZI0GWIEJWr+arImyh64QfU3dyG6wrhVvV2M4FADCL3stgRnWTLqlgkOmbVXJP8R4QS/LFxXkQO35tfsz5N+3dey3Ehdn3nJ9CoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TauUiJrOWGEd/a9biVcu7UHR5VGYer6dt/kZECY4sCM=;
 b=Zi3+1QcUA6dfgXgAUEqtSlYbSfQhKR2aTyVsRw8aB27JCHbPJu8Z9qf8uPvhoQR83B/FYHsTZRP2SLdZJIDtv6bKOPocqY1xVHjKSh4soEhh3I+1HBv0POAVKAyfnqYwBreeZwOIyTdbO/K46wrG+WvMBMlu8OPbaISK+o/8pB2e8VIFxe38oDSLMy4SS/g2ntGoQlBC5bqWgP+MKSo0moD8aybtAvWknFDGwtz1nndyBwnJzF9QRMJOTb4WidjeWcEJLNVDQtzO+eXErrJd/LhkkL7q30cvMRS19IDgT8PAH8SqaAadr8VyVfCGtDberCf2UbxVnwo+L+dCHH4Tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TauUiJrOWGEd/a9biVcu7UHR5VGYer6dt/kZECY4sCM=;
 b=jc+vBUEJeOll2OWcD6Fg1VAJrUyidHHpIPZ6S8YdvT+/WjSXPvXRTvg/ZlOvCYuxlkR8YWUNqBxxeDDw1sgAgLJAD2JxXDY3yeZNTBb+rLcceQLGn1F/+oYoZpD2mqzSfYle5lNwdUURlHJ8Z4WzIsRdkDwA93UnQKPg70BnWQ8=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by CH2PR12MB3845.namprd12.prod.outlook.com (2603:10b6:610:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:24 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::67) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:23 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:20 -0600
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
Subject: [PATCH v10 32/45] x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
Date:   Wed, 9 Feb 2022 12:10:26 -0600
Message-ID: <20220209181039.1262882-33-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28c7b3ac-45d0-42aa-42d9-08d9ebf7b88f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3845:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38453379E20F609E901CE2C3E52E9@CH2PR12MB3845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSl7LV7+0+Oan3uOCNNnKEeY0CLfpdzhGt8q0lujpX4WBxlES9Mkehvhqp6dbHNP40Jzl1udTOvXz2HptWPRSEg3w53Viynb4euhFVJBxGXnNJ0BY/lli7BWqvkPO39BbVHU1I33/ogsm23fvutCvkCJhgFuHivpHIJl5Ldeudic4oTEcAouFf49MovxP0LVUfOWzvUgdNiVJZCkpc08Svpm279R5fd7EqJsMujsQLaZyvXF4+k7Df/JFaDaBc5YNET/kopOke7G1BwaFVgEibGSBUj8zSlChzj45zNirbEwN59s4gox0zkf7SsehmSCPZFU17xIub5Hm/E5tdFFmBxkeRX58iTnT/ZoNgru3r/Zqrq3OXPUnPxBQqMIij3dJG6IEx8TyhTXn1qTOTRgMOwiEll9lGb/tkgTkiEap9DYDYSNZciF8WcAEYtJAW5qEfOlWz1tEBk+nWBkrC/vqJ0vkiRkj+urMqf3q4kYHDQ+4Fe8UTzFRd4ej5c9fKqG5NnL+6D9rKy6aYlOzDJdjAbOtm3AUTbeDsIZhWbumLeQttq78mrM5roN4WnSG6bt2HRTnH8xjSUsKPJoQh9JjumCoBplnQW7m7VCKavPHBHdFUzDUsy+m3sYf2qzV7tDPgoMO0SN4CMuMFm9mx5jkdRgbRZ/IoSvD1mp1bvDs1HJs4ekpuT7NCOs0ddSrsxttn6rRmOjCfP4TPxQhTA24xh2+Gl1G/QsrxJjGU5TcAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(70206006)(8676002)(70586007)(81166007)(47076005)(5660300002)(8936002)(54906003)(110136005)(316002)(44832011)(36756003)(2906002)(7416002)(7406005)(30864003)(426003)(82310400004)(336012)(7696005)(508600001)(186003)(16526019)(2616005)(1076003)(26005)(356005)(83380400001)(40460700003)(36860700001)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:23.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c7b3ac-45d0-42aa-42d9-08d9ebf7b88f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3845
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

