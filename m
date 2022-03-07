Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDA4D0A10
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiCGVjv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbiCGVh5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14618B6FB;
        Mon,  7 Mar 2022 13:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcaYWnPtXgvhJ4sd+SQVffCcMsS2QJ3PbZ+VU45kuTk/qdlBzEyan33nM1B8OEWZJ9MPf8kAFYzc/nBTyDC64clAsjJ/DtW1gKHiQxQBRm5wYJRkgHiZqxwRbQZujR/PYUiUx5rkGMwN+Css9Ce0P51Sx3yslRNXGuweNc7D9TIRlqzZhNlMAEMygt6M2peyBX+/TMnVd6nm1RiqXBEqk5Uje7DSV8eF8015Fci5mohji4mggWrhq9x7vgRmPWajqQZ1WRZ+EFnvtMJSyrcSND5q70o4/SZAsU8bFqFW1NMFDdlaW9sI5Luqfe5IAwHnZE3rLbz/2W7Lu5pFuVudiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqagch64G11O0SigeH8VO6YRsAxrQAPIs7uum6soLxg=;
 b=B//x1R+pkA2TDaQ319/nQXagXvP61q4lXaZTrJ9KhFAsxuA9NkH5j5QZHQY+YBEIJjhnshVINRV+sNiifB5oWvUxKGK1GZFT1fd9M9p5U9qcHoD/qfpZC7lkLVuh3hFhH9UucPdDVoQKSYSTt/0MQAotVuBnAK39CP/JF7KElHwXziI+F+tOaaDKt2zwetXT0u3v8OZcMx2kiUrUhZ2gFvGAgqXzqbe1ek3r+HVfxHUtCLq3jyyvBbG4GUxyPTpvj8WZIvZY4k5QKpYYTqGyZYZqbr7+OmfhYbNWWdrHJrRtaBdRA+MauxFX6K9yGVFWPUzyXy6huLH4DqIML77JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqagch64G11O0SigeH8VO6YRsAxrQAPIs7uum6soLxg=;
 b=neUTiNGylguXVbTJ5rZvYyW9HPGHU88BBFhOIOG0KTBo+IfgCIB2rQpcecp9i0cESYX57Ez8DOEsHHAUPzupTyjP9Gu8xybF8WKin4WJXHobY7mYYx2pAz5LaMW6BC/+QK5LiDEHbJM6cRK9HMwQvck5Z8+fgGSaDsx1dtsPHVc=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by MWHPR12MB1166.namprd12.prod.outlook.com (2603:10b6:300:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:35 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::3) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:33 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:25 -0600
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
Subject: [PATCH v12 39/46] x86/sev: Use firmware-validated CPUID for SEV-SNP guests
Date:   Mon, 7 Mar 2022 15:33:49 -0600
Message-ID: <20220307213356.2797205-40-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2793f8e0-3e55-40a8-9b3d-08da00826969
X-MS-TrafficTypeDiagnostic: MWHPR12MB1166:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11660B283328A62DE097E4A8E5089@MWHPR12MB1166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxUFm7Yhyr+CvbxC4Fd9tqrN9Q39IQRn0QCXS2qNXahrfIMIBSQHy6XmMLOtjPDmVTwN0LK9ODf9KXkbWZivexI3evGLK4q/LmJ/xyewWsDw3wPGe8P0D0xCyf3Qd6WWRRyGuuoia3ZDp/+iv2rHkUqOMD7TeWjRPYRx54rlTNWiN79GNP09rkujs4zXxB0Ltl29Dafj48ZvUsdrsWnuqdXlr3RqUHi4v+3ngtEmsWcEe95Cjc+7qeOtfmEqLHUE3GIFuhRwddYkhySTYoOxJ3e/34XJooEYnE9Lj0+6TBlGbHalayPp5QtHxfx7cdtBbQ9P/q6x/1CMpcYCoNXCA+nreFSGUNFLWRS8PHGy4WtpL0Re/qQQi9lh0Htq62gUq2baLQlFG2/kptrr1SyFMndEy23vhnWMBy8tjpMs7v5pzsF/8tLVd9rRIynfNE67TUR984AqQk6grb+5gEadtX0JJV5/rQ7uI3mAnHwQUT5x52Ue7N8Et0RumCCD7MfZ3KLWQAz1HUOjgmusykKcqUu/cYovC0jiBvg/sP6V9FESzvrfymktieCCPW8FMtR8B8ZABnrPT7oznzty3cZI0YQ5utpjHOXL482DiVDSHVrtW1tAYSbgPlNF+2JD1rvDTDRAdQwue+RsuaDv9ze4f7WOOINr/lAoI5wg3tEE22rPnq77FifEDkEOzIPvJBfXl1fs70PZz/q8eQ3QyBjCqQwPr2LXBn4Yj/18NB485lk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(82310400004)(36860700001)(2616005)(81166007)(356005)(426003)(83380400001)(1076003)(336012)(40460700003)(26005)(186003)(16526019)(8676002)(70206006)(4326008)(70586007)(86362001)(36756003)(316002)(2906002)(44832011)(15650500001)(7406005)(7416002)(8936002)(5660300002)(6666004)(7696005)(508600001)(110136005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:33.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2793f8e0-3e55-40a8-9b3d-08da00826969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1166
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 37 ----------------------------------
 arch/x86/kernel/sev-shared.c   | 37 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c          | 24 ++++++++++++++++++++++
 3 files changed, 61 insertions(+), 37 deletions(-)

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
index 5a7df617394b..c6b2e0c58255 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -34,6 +34,7 @@
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <asm/cpuid.h>
+#include <asm/cmdline.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -2028,6 +2029,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	setup_cpuid_table(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2041,3 +2044,24 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
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
+	return 0;
+}
+arch_initcall(report_cpuid_table);
-- 
2.25.1

