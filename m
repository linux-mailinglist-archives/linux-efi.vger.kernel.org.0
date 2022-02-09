Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388234AF975
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiBISOu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiBISN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D159BC035414;
        Wed,  9 Feb 2022 10:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZQGr+1/koNniNv/x3rs1jmhbDuF1wo+tEj2mH8Rvm8+pKZp+CVc8C8fQUc0Akpp+xWSpK37d4HrIl/Tj16GW+nibBiBQNdplUjQ5XbtP7oUwZY3MtlsOrktW3AU1/NK8JOIcHFoK1EHsCN589Ed9UyBpna+7V7nb3FjwY/4OmRJLMFh0eNAGCVS10I6PH1VlfrccocwSXr5tiNGuYnfTnrW3M873e/lPvyEdsmSWksN+UJTJ6OlUI1NCNJg7DG14E0PH+ULqbRwzkSerSKJFLxNBuEroK66kxplz0gmavAzg1V1YUL1BDF+p0lw08nDVMFv+jIhYgkcCz0LkTyBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdrKphhrf27VGh6aqz9uuWMACK5r7ZHw+UjZyBoEbh4=;
 b=VtAsKoff7BOMHxh4ee2mgjcvrY8PPeYwqA1SpOHJS0ZAbECTvDAjOr74G3Q2qyP5JzofG+Vqvz1/iJmQD7ayZ+zjPieZqJ+3dgZxo4EJQZ/ZnBEHuzmGocMyW/dUBq27PDFPQSHpwP2ua75mi93Ih3f6E8tcNkoW+RM4NS9SBmpjaWXR/raBwIQ4iw+U+Ml6/WRC6SUZSInOPfB4zTBfrTNE/kmTpkGMHDLGJHMa9cXTx+a407M05Gd8qGz75/0awLSr8gE324c5MMk5pyqX5nE1YHQ5DDW0iX4fdy9pT+DxGXvY6sras+26jNEkKQ1egVvwTXGWboFQ4xwaqAajEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdrKphhrf27VGh6aqz9uuWMACK5r7ZHw+UjZyBoEbh4=;
 b=GfjHHj4R6fBmcCjuqDcIkJ4/TxOTsXC55UjmCyPq+BT1gWiEFkmy7lFmeVZU5iDJHhAYg8qB35DH4qFApkK20T9I1e/Ln3oIKLjBVAAKCAGb6SCrhmpdDVz6D6Dz14QZazEmw3Wz4gl1TaD/zC6gQ+B8GUgcQ74SZ3/cOYXUcwg=
Received: from BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::26)
 by CY4PR12MB1174.namprd12.prod.outlook.com (2603:10b6:903:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:23 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::29) by BN9P223CA0021.outlook.office365.com
 (2603:10b6:408:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
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
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:18 -0600
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
Subject: [PATCH v10 31/45] x86/sev: Move MSR-based VMGEXITs for CPUID to helper
Date:   Wed, 9 Feb 2022 12:10:25 -0600
Message-ID: <20220209181039.1262882-32-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9939feb0-cce7-4037-f915-08d9ebf7b842
X-MS-TrafficTypeDiagnostic: CY4PR12MB1174:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB11747DF461126597C40009D6E52E9@CY4PR12MB1174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1fDcbge87ssWFSrNISZhSi7T24RUybiHQFYXqEptSrXpO0QnOt/bJNUqJ77NUG9OBoYJDIBzoDP+FMwrpxFcvHnen779grEL3XJZ50qs2cUcD7JMGCGmwsA4iq5GVTuB7XxnPqEldwJT2AarIOXAVT5PBTEecWR7jgjr1nlfaxovc+pYbv2o9cmLhXVqCS+QZ6smOMou9Tek6EKi2WHuaKm469yD+r2dsZGVPyrTB5ag9Bbm5PtWNoZxuFvsiwkiCWshcbYkAm7pdruo0NlmRoZhnjnn8arDOv5slQlytEGGRz6N/nSrUEoSGyHvKwSR2evpmQGEyggiLrlg6Mv/J7sx3/fBqxAoxLYzuei8aMLM/pFfGzznjt1psamaE1aDehrs1aexfBiIYDTEWJ2+G64vItUkFNA4MO1sIccfmAiaVnsa9kPtfz3fVjDB2gG9la6/afRvemULhQFTXgKWlpLBbb0ZBirKPLxwlTLX2Nj5SZq1JKUuV7oThsMOPZTezGOD/v325rQMY2GUPYpUzvAtKh8xYqqsmzFtyEhhaYHLrFU83miXI6+JTjKW3otWH8U25Sh6OBEzN5xClOTX30SF0YK153VJyUPwLjiS2sAc3Y+0f57UUYOgRbC0dFKYJBCxHEZrEWg6p8urkM+Lhn4CqeQ34L5fB4IdLgc+HzmymDBaskNbn0deCd0IDg7Re5hTSxVegQg81M0azq0Z+znG1S97M01BJAhRLnlpDc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(36756003)(70586007)(83380400001)(70206006)(40460700003)(81166007)(7416002)(2616005)(26005)(426003)(336012)(54906003)(110136005)(508600001)(8936002)(8676002)(4326008)(1076003)(316002)(7696005)(6666004)(82310400004)(7406005)(86362001)(2906002)(36860700001)(186003)(356005)(16526019)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:22.9700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9939feb0-cce7-4037-f915-08d9ebf7b842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1174
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

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

While here, also add a check to terminate in cases where the CPUID
function/subfunction is indexed and the subfunction is non-zero, since
the GHCB MSR protocol does not support non-zero subfunctions.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c |  1 +
 arch/x86/kernel/sev-shared.c   | 83 +++++++++++++++++++++++-----------
 arch/x86/kernel/sev.c          |  1 +
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 485410a182b0..ed717b6dd246 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
+#include <asm/cpuid.h>
 
 #include "error.h"
 #include "../msr.h"
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3aaef1a18ffe..b4d5558c9d0a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,16 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/* I/O parameters for CPUID-related helpers */
+struct cpuid_leaf {
+	u32 fn;
+	u32 subfn;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
 /*
  * Since feature negotiation related variables are set early in the boot
  * process they must reside in the .data section so as not to be zeroed
@@ -194,6 +204,44 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 	return verify_exception_info(ghcb, ctxt);
 }
 
+static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
+{
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, reg_idx));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+		return -EIO;
+
+	*reg = (val >> 32);
+
+	return 0;
+}
+
+static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+{
+	int ret;
+
+	/*
+	 * MSR protocol does not support fetching non-zero subfunctions, but is
+	 * sufficient to handle current early-boot cases. Should that change,
+	 * make sure to report an error rather than ignoring the index and
+	 * grabbing random values. If this issue arises in the future, handling
+	 * can be added here to use GHCB-page protocol for cases that occur late
+	 * enough in boot that GHCB page is available.
+	 */
+	if (cpuid_function_is_indexed(leaf->fn) && leaf->subfn)
+		return -EINVAL;
+
+	ret =         __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EAX, &leaf->eax);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EBX, &leaf->ebx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_ECX, &leaf->ecx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EDX, &leaf->edx);
+
+	return ret;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -201,40 +249,23 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
  */
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
+	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	struct cpuid_leaf leaf;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->ax = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+	leaf.fn = fn;
+	leaf.subfn = subfn;
+	if (sev_cpuid_hv(&leaf))
 		goto fail;
-	regs->cx = val >> 32;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
+	regs->ax = leaf.eax;
+	regs->bx = leaf.ebx;
+	regs->cx = leaf.ecx;
+	regs->dx = leaf.edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 439c2f963e17..b876b1d989eb 100644
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

