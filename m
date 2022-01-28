Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883A649FF36
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbiA1RUJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:09 -0500
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:54336
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350824AbiA1RTN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocTrlz3P2OKvx3230NFsKxPqQD/ckTOsuaCnOHHgdsDsu+xfbpWGouP0yZLVWVJx0U/Wa455Q2wuguaUMozLD4Aqd2LT/cPZZSXg5FyWzg3xhDq5mNrlWQIySxufrWniZTlfahv27IxlD4cktw+LyEty1y7u6ugt+YMvkuRxN/NusEAeTi6Vd4xKghSBvlnZNzx2400VCeSi85BqpeU0ps1M56LDGjyUPIiI6QFh4Ccom7O8w7IvTPsbHIKTRYRr+DW7+wsmFuAV8bmg1xjBtRfa84Q4/1z3dOI7vxCEXBsiITFCcOklcPcr4BdQBiroGogQnBvmAOPBSjSzH2BsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bos8QtAMKjWGg4IZLkVto+qmm87y/g/t5WuLbzC/sRw=;
 b=WYkXMJFvJuLgvdoDrRXHzae84Z9iCyzfDljuKo/my4tnz0U7nxkJ8bbmX2kG5YMuxjDo3jDHGPc6cLGEDYsidm7WY53JOSOsugmiB+KPsQm3qkH5KGybcEWAu5bUunFDU1sr51GgDN1HLHi0FI58g32pld2DQ73MNoppNm+xBU2uTD1vb8kdjJFWaEfgNrQ2xqUS0ECg6l/eZ8T0rNYTQOtQcUQq6l9uPPoUVr7OzJ5UHY4IBmNCbE5CDXG2Vew0XomRfEJd9vrthG6dbJgltmzXy9LRQ/jmx3e0RD2hTD/clCFzuxB97tvEtxFsDWwllWWkTyFwJB8q/A+7OlQuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bos8QtAMKjWGg4IZLkVto+qmm87y/g/t5WuLbzC/sRw=;
 b=pS7IqT03oMiJMFUg0iwJJ4KdawZ31lQzrsyIwjsEK1MijIXAnhQPUZOTYmNRbR0K3qiNk8lgLGEZTUYnKDVuGu7uFP87KWNpFV/LobFq370clCfAtXtgR6BgXiMG3ke4sLD9ajkCCs9GWQySn8TbR2XlClGVdiCikUYNn5H8E4w=
Received: from DM6PR07CA0096.namprd07.prod.outlook.com (2603:10b6:5:337::29)
 by SN1PR12MB2399.namprd12.prod.outlook.com (2603:10b6:802:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:19:10 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::5) by DM6PR07CA0096.outlook.office365.com
 (2603:10b6:5:337::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:10 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:08 -0600
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
Subject: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
Date:   Fri, 28 Jan 2022 11:17:52 -0600
Message-ID: <20220128171804.569796-32-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0964906a-4e83-4289-823e-08d9e2824c65
X-MS-TrafficTypeDiagnostic: SN1PR12MB2399:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23995D7477A97BD0CCBA5168E5229@SN1PR12MB2399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nt9yE8HoV6ZF1v99dFlarx+QjaL0LLSapQ4Veb0wlJdBbCGFS8e/f2GaxBzjyo6Npchg3ZUKtWzSJqT2mN6Ny7BAIivEzEvwGhl3BALJEqSuvIoGWxWuKEUhwD6T9ruxYAOoWmYfelUjE76Evw04c4c0Vypoh8dZxHWzcyVfgD7MFcXbRSWJHTI5qn0IxI5T2VoT31vXZvSgvZbsnWHLaBvwqOwQ2ytemo967CX0wyQDWSJQ0/cIlMtdxf5V2OMzeRC83kfdY7x8iwKv4OfewAyFVeJQafnG1TYLIphPfT/ed3roJAMar+8KCvUsMzzzVAcA9rAnXPxr3fomdVEXWrsVOoe5hAWklq1yy4K/GuICFTO9G3xdrH+TxJTlFmIcgOnEweo6Z5QCuK3j15UrbUDMTB3chfNsCr2geyiw2Gxp8T8FhKuRw96HXm8K/5MCmMoRdRz3cOFzO24jLvshGaIs7ysdDjnEG12R92XY6JBPzXPP6kawry+WxRN6KDITriNIXjapsNbXLJMw+g3+UIZR87sDcW7yDpNPnoDcOpS2xsFg29jKLUU4lMH95toNEAqJEgVrKJcekg8jKsw0zSjBTphw9Nmdg60sM3rzpErHE7ygEA/gMTHwxVZiTDBRe392H9UAbMk7MTrLt+WTgny96CRSukvr1TvqAcvqL02N7NzsxH4+8FNyoLKT0R6d39yX4qRMOFKtIks75tT+Ud5xO/f9kmiBHtPts1tI90=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(81166007)(356005)(2906002)(426003)(36756003)(83380400001)(36860700001)(30864003)(336012)(47076005)(70586007)(1076003)(70206006)(26005)(82310400004)(316002)(2616005)(16526019)(7416002)(7406005)(186003)(6666004)(86362001)(7696005)(508600001)(54906003)(4326008)(8676002)(8936002)(40460700003)(5660300002)(110136005)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:10.4045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0964906a-4e83-4289-823e-08d9e2824c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2399
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
 arch/x86/boot/compressed/sev.c    |   1 +
 arch/x86/include/asm/sev-common.h |   2 +
 arch/x86/kernel/sev-shared.c      | 336 ++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c             |   1 +
 4 files changed, 340 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1e5aa6b65025..1b80c1d0ea1f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid.h>
 
 #include "error.h"
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6d90f7c688b1..cd769984e929 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -152,6 +152,8 @@ struct snp_psc_desc {
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
 #define GHCB_TERM_NOT_VMPL0		3	/* SEV-SNP guest is not running at VMPL-0 */
+#define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
+#define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 633f1f93b6e1..dea9f7b28620 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,36 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
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
+ * SEV-SNP CPUID table header, as defined by the SEV-SNP Firmware ABI,
+ * Revision 0.9, Section 8.14.2.6. Also noted there is the SEV-SNP
+ * firmware-enforced limit of 64 entries per CPUID table.
+ */
+#define SNP_CPUID_COUNT_MAX 64
+
+struct snp_cpuid_info {
+	u32 count;
+	u32 __reserved1;
+	u64 __reserved2;
+	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
+} __packed;
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -23,6 +53,19 @@
  */
 static u16 ghcb_version __ro_after_init;
 
+/* Copy of the SNP firmware's CPUID page. */
+static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
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
@@ -224,6 +267,266 @@ static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
 	return ret;
 }
 
+/*
+ * This may be called early while still running on the initial identity
+ * mapping. Use RIP-relative addressing to obtain the correct address
+ * while running with the initial identity mapping as well as the
+ * switch-over to kernel virtual addresses later.
+ */
+static const struct snp_cpuid_info *snp_cpuid_info_get_ptr(void)
+{
+	void *ptr;
+
+	asm ("lea cpuid_info_copy(%%rip), %0"
+	     : "=r" (ptr)
+	     : "p" (&cpuid_info_copy));
+
+	return ptr;
+}
+
+/*
+ * The SEV-SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
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
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+	u64 xfeatures_found = 0;
+	u32 xsave_size = 0x240;
+	int i;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (!(fn->eax_in == 0xD && fn->ecx_in > 1 && fn->ecx_in < 64))
+			continue;
+		if (!(xfeatures_en & (BIT_ULL(fn->ecx_in))))
+			continue;
+		if (xfeatures_found & (BIT_ULL(fn->ecx_in)))
+			continue;
+
+		xfeatures_found |= (BIT_ULL(fn->ecx_in));
+
+		if (compacted)
+			xsave_size += fn->eax;
+		else
+			xsave_size = max(xsave_size, fn->eax + fn->ebx);
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
+static void snp_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
+			 u32 *edx)
+{
+	/*
+	 * MSR protocol does not support fetching indexed subfunction, but is
+	 * sufficient to handle current fallback cases. Should that change,
+	 * make sure to terminate rather than ignoring the index and grabbing
+	 * random values. If this issue arises in the future, handling can be
+	 * added here to use GHCB-page protocol for cases that occur late
+	 * enough in boot that GHCB page is available.
+	 */
+	if (cpuid_function_is_indexed(func) && subfunc)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+
+	if (sev_cpuid_hv(func, eax, ebx, ecx, edx))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+}
+
+static bool
+snp_cpuid_get_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			     u32 *ecx, u32 *edx)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+	int i;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in != func)
+			continue;
+
+		if (cpuid_function_is_indexed(func) && fn->ecx_in != subfunc)
+			continue;
+
+		/*
+		 * For 0xD subfunctions 0 and 1, only use the entry corresponding
+		 * to the base/legacy XSAVE area size (XCR0=1 or XCR0=3, XSS=0).
+		 * See the comments above snp_cpuid_calc_xsave_size() for more
+		 * details.
+		 */
+		if (fn->eax_in == 0xD && (fn->ecx_in == 0 || fn->ecx_in == 1))
+			if (!(fn->xcr0_in == 1 || fn->xcr0_in == 3) || fn->xss_in)
+				continue;
+
+		*eax = fn->eax;
+		*ebx = fn->ebx;
+		*ecx = fn->ecx;
+		*edx = fn->edx;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool snp_cpuid_check_range(u32 func)
+{
+	if (func <= cpuid_std_range_max ||
+	    (func >= 0x40000000 && func <= cpuid_hyp_range_max) ||
+	    (func >= 0x80000000 && func <= cpuid_ext_range_max))
+		return true;
+
+	return false;
+}
+
+static int snp_cpuid_postprocess(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+				 u32 *ecx, u32 *edx)
+{
+	u32 ebx2, ecx2, edx2;
+
+	switch (func) {
+	case 0x1:
+		snp_cpuid_hv(func, subfunc, NULL, &ebx2, NULL, &edx2);
+
+		/* initial APIC ID */
+		*ebx = (ebx2 & GENMASK(31, 24)) | (*ebx & GENMASK(23, 0));
+		/* APIC enabled bit */
+		*edx = (edx2 & BIT(9)) | (*edx & ~BIT(9));
+
+		/* OSXSAVE enabled bit */
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			*ecx |= BIT(27);
+		break;
+	case 0x7:
+		/* OSPKE enabled bit */
+		*ecx &= ~BIT(4);
+		if (native_read_cr4() & X86_CR4_PKE)
+			*ecx |= BIT(4);
+		break;
+	case 0xB:
+		/* extended APIC ID */
+		snp_cpuid_hv(func, 0, NULL, NULL, NULL, edx);
+		break;
+	case 0xD: {
+		bool compacted = false;
+		u64 xcr0 = 1, xss = 0;
+		u32 xsave_size;
+
+		if (subfunc != 0 && subfunc != 1)
+			return 0;
+
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (subfunc == 1) {
+			/* Get XSS value if XSAVES is enabled. */
+			if (*eax & BIT(3)) {
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
+			 * treat this as unsupported for SEV-SNP guests.
+			 */
+			if (!(*eax & (BIT(1) | BIT(3))))
+				return -EINVAL;
+
+			compacted = true;
+		}
+
+		xsave_size = snp_cpuid_calc_xsave_size(xcr0 | xss, compacted);
+		if (!xsave_size)
+			return -EINVAL;
+
+		*ebx = xsave_size;
+		}
+		break;
+	case 0x8000001E:
+		/* extended APIC ID */
+		snp_cpuid_hv(func, subfunc, eax, &ebx2, &ecx2, NULL);
+		/* compute ID */
+		*ebx = (*ebx & GENMASK(31, 8)) | (ebx2 & GENMASK(7, 0));
+		/* node ID */
+		*ecx = (*ecx & GENMASK(31, 8)) | (ecx2 & GENMASK(7, 0));
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
+static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
+		     u32 *edx)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+
+	if (!cpuid_info->count)
+		return -EOPNOTSUPP;
+
+	if (!snp_cpuid_get_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
+		/*
+		 * Some hypervisors will avoid keeping track of CPUID entries
+		 * where all values are zero, since they can be handled the
+		 * same as out-of-range values (all-zero). This is useful here
+		 * as well as it allows virtually all guest configurations to
+		 * work using a single SEV-SNP CPUID table.
+		 *
+		 * To allow for this, there is a need to distinguish between
+		 * out-of-range entries and in-range zero entries, since the
+		 * CPUID table entries are only a template that may need to be
+		 * augmented with additional values for things like
+		 * CPU-specific information during post-processing. So if it's
+		 * not in the table, but is still in the valid range, proceed
+		 * with the post-processing. Otherwise, just return zeros.
+		 */
+		*eax = *ebx = *ecx = *edx = 0;
+		if (!snp_cpuid_check_range(func))
+			return 0;
+	}
+
+	return snp_cpuid_postprocess(func, subfunc, eax, ebx, ecx, edx);
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -231,16 +534,26 @@ static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
  */
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
 	u32 eax, ebx, ecx, edx;
+	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	ret = snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
+	if (!ret)
+		goto cpuid_done;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
 	if (sev_cpuid_hv(fn, &eax, &ebx, &ecx, &edx))
 		goto fail;
 
+cpuid_done:
 	regs->ax = eax;
 	regs->bx = ebx;
 	regs->cx = ecx;
@@ -535,12 +848,35 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+static int vc_handle_cpuid_snp(struct pt_regs *regs)
+{
+	u32 eax, ebx, ecx, edx;
+	int ret;
+
+	ret = snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
+	if (!ret) {
+		regs->ax = eax;
+		regs->bx = ebx;
+		regs->cx = ecx;
+		regs->dx = edx;
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 19a8ffcbd83b..c2bc07eb97e9 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -33,6 +33,7 @@
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
+#include <asm/cpuid.h>
 
 #define DR7_RESET_VALUE        0x400
 
-- 
2.25.1

