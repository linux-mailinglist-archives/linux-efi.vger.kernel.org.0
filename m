Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B542707A
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243150AbhJHSKF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:10:05 -0400
Received: from mail-sn1anam02on2068.outbound.protection.outlook.com ([40.107.96.68]:20470
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242735AbhJHSIR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfJD3MO0gzghNGrl7bJ9PXS3hj7sns/HSsOxVbEKetNbcDUlOBjvnWYZANurMRkOL9c6PZIIzRHCwAQSIPyem+YSfvFRhJFSCq87FgdXmcK4+I/DFqwfuxnE10XgW/wWe9OwU/7QeHvXUTVm9ZwdFj8ANYXdL+LeLe+0iYaOrm7g0IhPkexVY+1VyDP4KdlN/OVmr1CHNh4hb7t4eh4YTQMSP7Mcm0fjsGw/kYBoJbG93GdbvkPn93X8eWDAPpv/1AvE0pNU0cX2NhXIn84JY1/qX7WxF+yB11VAfhHUySnK68tmBBbZ59AVMJO2BZ2Ca1fzcrFlO2fU3p+JJt60jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6xL5QK6byaBGUxccg9UtjZ8m7Gy1jhDNdrR0YIktjE=;
 b=WHLvg6TanHciD8n0aLoM6NGpczgAZfgive7bkGX0oTxkaBRqguMUjf7w2GP2JnG+5i5eNPKetJ+4a9kVlx10U/R2PJn7CVyOhzxlwzNNIllvKcvnAxI4Hg1D//CFRRiuAyg5bhF1+zYgMcWXlO28M18XkwTrecVliH9tADVUSOxZHYpMtic2cWV4eKas7gyX3sPjWT8vRRZqTJ6ui9Opu2RLVWOrGKeZLIvkLw5IaYdFJCK3bENrNrdc9N7zC4ywQlySqmj1g+SXCZg09WOqp9x+gBweX+KAGRwaPvtkL0OL2pw/ToCUALhTVgXAXykHAn2ErS84KgMF//qeknYD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6xL5QK6byaBGUxccg9UtjZ8m7Gy1jhDNdrR0YIktjE=;
 b=zgCnVM0PlIkgPURyYrZDtHB6WpysdFZhZmfvmknVmpQHj6w1uBiQRLbi0jYhVzqCTOS2XrsKxJbHnQuxuiCIA55uZ2Tz7dK566f1Dp+wNG0YmGLke02zLJ2joLnT37S3vWnyTBRd3x9ZHCnZP3ztnEMDvtPjCIt2+6Th5598ae4=
Received: from MWHPR20CA0033.namprd20.prod.outlook.com (2603:10b6:300:ed::19)
 by BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:06:16 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::59) by MWHPR20CA0033.outlook.office365.com
 (2603:10b6:300:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:15 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:04 -0500
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
Subject: [PATCH v6 32/42] x86/compressed/64: add support for SEV-SNP CPUID table in #VC handlers
Date:   Fri, 8 Oct 2021 13:04:43 -0500
Message-ID: <20211008180453.462291-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3e0f26-2e1d-4330-178e-08d98a865241
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR12MB271067F2B06BD21D2988B794E5B29@BYAPR12MB2710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/UencLad3+2XT9+pEq57ZTVwdYbAgAe1uJyL3IemOedUFL5iWbEQX0otOiSVAvMcLW569SlTrAPeQcXOg4aJh0nOxcemYVxP00U88u1W0Z+cukBuVRjE3/3XYoUzFKAwd6A83Glgf7tom8kFAHqcMkjX+jbz/sMFZxmFnVd1vMKOkCyVbrNRelk4+JOBT0ZsmApWQiYp8l/9gnn5tLKhyy7kIGyoTKfutjwCN7y6emcCXY0ZFtHJuW5jm42GFoWC+WjAGH/1mCdXFBb/wFHB+gaUlcPQpH3oRbWcrYSe+aKxXfd92A5m95OZMTOsjsSsW5Z+ouJfzBokWwCiE7Y0Dbx52Bq1x/QQhHs16FvczViPZdt2Uw1LmfrB8ROlF42XiACDkO4pm83+5EQcfZr51j2gqPkSyd12X7oeF+j53ysmUahZWtoTCFllqItGmSC0PvX5zsoKzSOnXsRrBSbQfKbUE2JYR7jE3ljVH0CuMuqJsgxdl7qqEpYC8iJIPLiAL34KJ80YuefBJcbqaMt6YdnR5ptnh/NyBt8zog2b63K4/uBn6k9Kobkwic56cJtQPJcGNQN858i1OCyTGgba7mdebMRn03cJrPSxXjECud7yYGQcRxkLQ1aQTksb7jNbsJQrqAiVLZ5c4XgB3jt40dwqMJLa+c9f92UimZOBIopelVeW7AlLFuxrfBz/wAfSu8bcbCCwdKZKUuVKsb0PTsfSn5F0mpJOKnknK4+bvfr+5qXF+4y5/XF4WMh8aSLeGzkoJWPBMUsqGux/E6rsA1lwIow0WY5oeXgi9lJV60=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7406005)(7416002)(8936002)(30864003)(4326008)(83380400001)(70586007)(508600001)(70206006)(336012)(81166007)(36860700001)(356005)(2906002)(186003)(16526019)(8676002)(426003)(47076005)(5660300002)(26005)(1076003)(82310400003)(86362001)(7696005)(54906003)(36756003)(110136005)(316002)(6666004)(2616005)(44832011)(36900700001)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:15.8355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3e0f26-2e1d-4330-178e-08d98a865241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
 arch/x86/kernel/sev-shared.c      | 308 ++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c             |   1 +
 4 files changed, 312 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index e8308ada610d..11c459809d4c 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid.h>
 
 #include "error.h"
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index c380aba9fc8d..45c535eb75f1 100644
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
index 402b19f1c75d..193ca49a1689 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,41 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Individual entries of the SEV-SNP CPUID table, as defined by the SEV-SNP
+ * Firmware ABI, Revision 0.9, Section 7.1, Table 14. Note that the XCR0_IN
+ * and XSS_IN are denoted here as __unused/__unused2, since they are not
+ * needed for the current guest implementation, where the size of the buffers
+ * needed to store enabled XSAVE-saved features are calculated rather than
+ * encoded in the CPUID table for each possible combination of XCR0_IN/XSS_IN
+ * to save space.
+ */
+struct snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 __unused;
+	u64 __unused2;
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
@@ -26,6 +61,28 @@ static u16 __ro_after_init ghcb_version;
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 __ro_after_init sev_hv_features;
 
+/*
+ * These are stored in .data section to avoid the need to re-parse boot_params
+ * and regenerate the CPUID table/pointer when .bss is cleared.
+ */
+
+/*
+ * The CPUID info can't always be referenced directly due to the need for
+ * pointer fixups during initial startup phase of kernel proper, so access must
+ * be done through this pointer, which will be fixed up as-needed during boot.
+ */
+static const struct snp_cpuid_info *cpuid_info __ro_after_init;
+
+/*
+ * These will be initialized based on CPUID table so that non-present
+ * all-zero leaves (for sparse tables) can be differentiated from
+ * invalid/out-of-range leaves. This is needed since all-zero leaves
+ * still need to be post-processed.
+ */
+u32 cpuid_std_range_max __ro_after_init;
+u32 cpuid_hyp_range_max __ro_after_init;
+u32 cpuid_ext_range_max __ro_after_init;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -245,6 +302,224 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return 0;
 }
 
+static inline bool snp_cpuid_active(void)
+{
+	return !!cpuid_info;
+}
+
+static int snp_cpuid_calc_xsave_size(u64 xfeatures_en, u32 base_size,
+				     u32 *xsave_size, bool compacted)
+{
+	u32 xsave_size_total = base_size;
+	u64 xfeatures_found = 0;
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
+			xsave_size_total += fn->eax;
+		else
+			xsave_size_total = max(xsave_size_total,
+					       fn->eax + fn->ebx);
+	}
+
+	/*
+	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
+	 * entries in the CPUID table were not present. This is not a valid
+	 * state to be in.
+	 */
+	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
+		return -EINVAL;
+
+	*xsave_size = xsave_size_total;
+
+	return 0;
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
+		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
+
+	if (sev_cpuid_hv(func, 0, eax, ebx, ecx, edx))
+		sev_es_terminate(1, GHCB_TERM_CPUID_HV);
+}
+
+static bool
+snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			      u32 *ecx, u32 *edx)
+{
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
+		if (snp_cpuid_calc_xsave_size(xcr0 | xss, *ebx, &xsave_size,
+					      compacted))
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
+ * Returns -EOPNOTSUPP if feature not enabled. Any other return value should be
+ * treated as fatal by caller.
+ */
+static int snp_cpuid(u32 func, u32 subfunc, u32 *eax, u32 *ebx, u32 *ecx,
+		     u32 *edx)
+{
+	if (!snp_cpuid_active())
+		return -EOPNOTSUPP;
+
+	if (!snp_cpuid_find_validated_func(func, subfunc, eax, ebx, ecx, edx)) {
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
@@ -252,8 +527,10 @@ static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
  */
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
 	u32 eax, ebx, ecx, edx;
+	int ret;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
@@ -273,9 +550,17 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		sev_status = (hi << 32) | lo;
 	}
 
+	ret = snp_cpuid(fn, subfn, &eax, &ebx, &ecx, &edx);
+	if (ret == 0)
+		goto cpuid_done;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
 	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
 		goto fail;
 
+cpuid_done:
 	regs->ax = eax;
 	regs->bx = ebx;
 	regs->cx = ecx;
@@ -569,12 +854,35 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
+static int vc_handle_cpuid_snp(struct pt_regs *regs)
+{
+	u32 eax, ebx, ecx, edx;
+	int ret;
+
+	ret = snp_cpuid(regs->ax, regs->cx, &eax, &ebx, &ecx, &edx);
+	if (ret == 0) {
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
+	if (snp_cpuid_ret == 0)
+		return ES_OK;
+	if (snp_cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
 
 	ghcb_set_rax(ghcb, regs->ax);
 	ghcb_set_rcx(ghcb, regs->cx);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index dfb5b2920933..d348ad027df8 100644
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

