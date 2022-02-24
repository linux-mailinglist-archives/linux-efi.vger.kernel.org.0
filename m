Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC984C331B
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiBXRDw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiBXRBq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:46 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BABECF3;
        Thu, 24 Feb 2022 08:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsjl+h0o5+c2tvc88UlI1evujlVmSsPkRyAGQqhkAmYel2jg3usKCR8tn6LIOBM94B6efrgrKXQj58hQG1jIXKfTTsxrh8y1vv101PMEc6Ey/PrrsJp0/I7uqtu3fWyVxMiYHxulkbVUAVN4X4daVnIZbFvftPuasXaAPz0qrWWWeVIXepI7nvazXXfhXO76QK3u8bRKxsxvU7IccmvlLWTOnNu2/sK4yMVie3gxN6e9uWHp7S/0AsRo+xfIhnbrt09BlLq3zQ3TCXUjMEAgcBdJXPgamtjYPfQUmia2n1tqfJxMQH0R28SrzDpZVkYWpYq0ZQf4n7IpbYwEd7w9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NvohDStQZZ0rcznZHgVVc5LOHJft4HGdoplMNFP2ZY=;
 b=MS9oPpSdrsOXkq1pdVnLLWWR+gZc1obHN2FH2q389KglxbhTNNSGRTI32XNpvKM2HtRVELVMOJUk2+656KFzTsotGlrQ03FRoBLHYEFfqjoKrbhIUjfanTaJZ1+P1FTv6H0mC8xkZ8O125aVyZMD/dNaJBjobTR+pG4aPYwffBBGYR1GI1UseG3ngczFgJ+GxgLNff2Q2EfW/9hUYSS+QodJpdD/zfHOJFSqwSt1ZuNTHufFfgIJPYvqyf+dsldxnJ/0teG3qTuuEdUBJESW5BzSVdwZpOkJ6i9hqlNto3WxhrgrgRsTfWXW6tb9eqyy5BS+FCFAGv6D/R2475Lq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NvohDStQZZ0rcznZHgVVc5LOHJft4HGdoplMNFP2ZY=;
 b=Pp5Ej+2NiOn2tutI3U67yTxlrJ4ipi7PfXUXI/B0rHAINZ6omXozZs9mmPgaCpL+H9PMG4Hwjrp34Q7ZecxBYo+bd47p95Nz9kDdJ3N4TkJVzgvcBumqMlBiUwl7BuozUBhUtDIyLC8CyryS10XfVSus9luf2yNbUPDK3I4Pako=
Received: from DM5PR13CA0043.namprd13.prod.outlook.com (2603:10b6:3:7b::29) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 24 Feb 2022 16:59:11 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::7) by DM5PR13CA0043.outlook.office365.com
 (2603:10b6:3:7b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:59:10 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:59:01 -0600
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
Subject: [PATCH v11 39/45] x86/sev: Use firmware-validated CPUID for SEV-SNP guests
Date:   Thu, 24 Feb 2022 10:56:19 -0600
Message-ID: <20220224165625.2175020-40-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8844d78c-1ac5-47f5-0361-08d9f7b6fa3c
X-MS-TrafficTypeDiagnostic: MW4PR12MB5625:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56251C3931A9C7E8933E667DE53D9@MW4PR12MB5625.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1OtZnX50JVSzbW4kkZvaSwjnSGRnSUj83qnZfMoaye1IZsecBXtwZ3ohKonnBB1zFhWjmYHACyK5NYhPd9AvNVaW+8BrKEv9LegOByFYmzT8J4CwBCURgCmDjzjR+TXUNy/iLe5IXH+kr7s5qFgWixUDjt2FYpwxUWjvBTv7iCn12T8RgSIuetzRW7/lrJpxpC97LLl4Xs4jC4H9kyHK/vl+m06BI27Qh1qizBI19FL/BscKzmNNTPdISGsTNo3yOconoUR2XlHJbVcSGjVbJ81c50gQJ22Y4DoQ0LdJtKj7rn+y6a5cYVIPoeGuPn5Qx+yBvLhRZF7EsCPd3hNHPDtAe8lEEzNHeOK8XM7pkJ268QW0RSlfr8a11e1DJutApoxHFvhMOb9b660Jtf0xOQwglznVfxxzRfOg/8xcmYI6dKE4gdmp69DdAerhYj/+zwagytlpp9r8OSBjZPDiARtKpAZ6rsvMwOWAx3VEKOEfcS2TshKZ5bh1swzJrdvdJaZS1aBj//RkcAzRSIPJE3IE8mqtPsXMGeZr5t9A+u8fLFoBeT3EbUWDzOi2jmU7C5L3OPVduy1uUrPuy9OktONAgvvAhYuB7wGGhHkCvx930aIG83Lk3s66VIgJxvX0gMGaIzp39T4O75ctA9D653s4PFD8f3519EOImtDSvLst/gbHc5RkE0cdVh7I4V2HJSiS8O/fBahKLjbUQbLEcXn2v0CthXSwUt/mx9j3aw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(110136005)(508600001)(54906003)(47076005)(70206006)(336012)(16526019)(70586007)(8936002)(26005)(83380400001)(36756003)(426003)(7696005)(5660300002)(2906002)(15650500001)(6666004)(2616005)(8676002)(36860700001)(316002)(7406005)(1076003)(81166007)(40460700003)(86362001)(356005)(44832011)(4326008)(82310400004)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:59:10.2887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844d78c-1ac5-47f5-0361-08d9f7b6fa3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through a bootparams field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing blob from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing CPUID instructions via a #VC
handler.

Also add an "sev_debug" kernel command-line parameter that will be used
(initially) to dump the CPUID table for debugging/analysis.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 arch/x86/boot/compressed/sev.c                | 37 ---------------
 arch/x86/kernel/sev-shared.c                  | 37 +++++++++++++++
 arch/x86/kernel/sev.c                         | 45 +++++++++++++++++++
 4 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..990125cc701c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5229,6 +5229,10 @@
 
 	serialnumber	[BUGS=X86-32]
 
+	sev_debug	[X86-64]
+			Enable verbose debug messages related to AMD Secure
+			Encrypted Virtualization.
+
 	shapers=	[NET]
 			Maximal number of shapers.
 
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 2911137bf37f..79a59027f3d8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -381,43 +381,6 @@ static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-/*
- * Initialize the kernel's copy of the SNP CPUID table, and set up the
- * pointer that will be used to access it.
- *
- * Maintaining a direct mapping of the SNP CPUID table used by firmware would
- * be possible as an alternative, but the approach is brittle since the
- * mapping needs to be updated in sync with all the changes to virtual memory
- * layout and related mapping facilities throughout the boot process.
- */
-static void setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
-{
-	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
-	int i;
-
-	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
-	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table = snp_cpuid_get_table();
-	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
-
-	/* Initialize CPUID ranges for range-checking. */
-	for (i = 0; i < cpuid_table->count; i++) {
-		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
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
 /*
  * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
  * will verify the SNP CPUID/MSR bits.
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index a7a1c0fb298e..2b4270d5559e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -964,3 +964,40 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 
 	return NULL;
 }
+
+/*
+ * Initialize the kernel's copy of the SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SNP CPUID table used by firmware would
+ * be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
+	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table = snp_cpuid_get_table();
+	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
+
+	/* Initialize CPUID ranges for range-checking. */
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
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
index a79ddacf0478..7bef422b428f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -34,6 +34,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/cmdline.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2035,6 +2036,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	setup_cpuid_table(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2048,3 +2051,45 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
+
+static void dump_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it,
+ * so do it here.
+ */
+static int __init report_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+
+	if (!cpuid_table->count)
+		return 0;
+
+	pr_info("Using SNP CPUID table, %d entries present.\n",
+		cpuid_table->count);
+
+	if (cmdline_find_option_bool(boot_command_line, "sev_debug"))
+		dump_cpuid_table();
+
+	return 0;
+}
+
+arch_initcall(report_cpuid_table);
-- 
2.25.1

