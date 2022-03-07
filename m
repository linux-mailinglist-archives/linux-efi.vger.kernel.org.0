Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04654D0A0C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiCGVjx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbiCGVgn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF289CFC;
        Mon,  7 Mar 2022 13:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3LAQgrjUz6jfIm8Dz7eqLjcCHkinuJZUUIhqIxmdkv508C+olH3KIc65ROeF6etqEQmWT/L4xSnSNgp9KmE7MfhtQOwqiNOV+/S4lkcKpcMBGAZ7ZWQxJr3lfsBt2tg+2cOrqcMEJSO430GK8ZWa37MXKv+NiDILQtVqdIZhzjfAJxQUuHugi8eTV4iVdtoY1PseyvCXbFs4nsbGBWKPGAqRRmD4HnPNtFwubotDHq7y3j9NmykrhRIkAXrhmrV0uI9bT4yq0OM7S1GjUEgaV7L4myMOPrzZAJs4nIIgwE2JTcLvbGQatsg6+p0nVzO+y0pvM7TaAvnFI1NMdVhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6s1C/Zn/hZRROUmwhJnVXMc2cu/EWhVAXRDi+KITkc=;
 b=hQa1fvvauKphvqU/25YWPYgb4GKrRQGDfTWLGoDtVoaWoVVUYZPTwLRwagpxOKXrf7xjCYUPHLt+57uXV4yleVkLrHf4EcWKpkC6BEmTbzS7KgumFcppuVyAahWgRo8gixSfszDRff13F+QEYANBHy1SFDnvwaZdTzoF/lw4mD+RUYt84T4bymgk25xWn7e386lqBy8w9g30l/3/stZ53Jz9HG9y+gUhFngJThhIHdR3QYXw8hVk0UoQAN+PnJl4G578lHPhkJu0YFH4U5aUIcJ8PjLGzkj/GnzVoscp78GCLJx3lozEa+DsfB7Hct4PrvY0EbKlc6e8l3PWYrVCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6s1C/Zn/hZRROUmwhJnVXMc2cu/EWhVAXRDi+KITkc=;
 b=Tng3dtiI400SQA52GEoA8YhkDKDos8YHZnrUhDsuccj4mFjl1k6En/Gn8dJFkUOLwXf/HkLwBDBFt1/BDlMBrM1PRD5x4FWTBhseMuWLssEqqQ+FqB4z6bn9OramHcDpm1foGkLUWhWtNNPSEMXZOlcQI+Bt/rIfVFZchjFIgNk=
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 21:35:16 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::f3) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:15 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:11 -0600
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
Subject: [PATCH v12 31/46] x86/sev: Move MSR-based VMGEXITs for CPUID to helper
Date:   Mon, 7 Mar 2022 15:33:41 -0600
Message-ID: <20220307213356.2797205-32-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96d1ccc5-acc4-4de4-6877-08da00825e97
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13817BD477F4C30B695CFFA2E5089@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjecHdwwKIYS1WqG2Es40+lCwhHuEE3kX38solBv3odjlxU+HZ7uxH6yMhqz5RMNKVoSQmUGM/iF410HuByNQVoYeqVGLMBM9ZX8j+0oVdzVlqFQ6fezwThTRh01R4NpHMR/6q8NeStOfALpTWpGBzweHQx+A8dN+KtawC2/6a8PQ5m97iyHLJU+1gVVb2GqdSIH+MmWStAePpdQu+g4x6y3Iss/DRvaOZvLeZn8wP0rl3K9O87cWiSGUMO1hOGz7hd6/sxf8XAbcwiAEsjFdwX4tlFI9ipbWDWSST/ZuSAgGSOMru2cL1WOuFDFZ5h7S9rQJoOsjQ58G3WPE/0fqUE19kBYzahWxlzAf3/Aeab8C9zIXHrscCroEucdo7/1iDUlmK8r7h/XjMxA35t3XTuViqKrm9CfUkooZnQ9HnUzgFC9Pl+RP72HRQc/PdRQ9FSC3I37mOVAN2bVYaYzZgoSZUXKCjJU96LgY7mWt+hxXnURV09B87ctpCpLel1xYYFXsYD21yTvGfPZzWM4wGcRnXXEeay5BuWtqDHuh1J6DzOKJ7JD/JZjUmCciICSexsii16ZmGspqyQMu6hJg7SvxltpWcp7lC9xkQhAZUTibZuvP76BY6afCzIerFMjRROgFTT9bl59Qn9wUbT5xmWVu1tjwdWv8HPCLjOL+upZIfJa5w5sVExyZPGriHgo10jsg4SemtzL22/g9xSxMsqa9xpLrKNYTu7PTIpiij8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(16526019)(186003)(2616005)(1076003)(26005)(81166007)(40460700003)(356005)(83380400001)(426003)(70586007)(336012)(82310400004)(36860700001)(47076005)(8676002)(36756003)(54906003)(70206006)(110136005)(316002)(4326008)(8936002)(2906002)(5660300002)(7416002)(44832011)(7406005)(508600001)(7696005)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:15.8294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d1ccc5-acc4-4de4-6877-08da00825e97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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
index bc9bb7e0c04d..97c0aa44ce2d 100644
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

