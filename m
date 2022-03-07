Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687A84D097D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiCGVfq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245589AbiCGVfm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CF6E4FC;
        Mon,  7 Mar 2022 13:34:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWW4g37BpE1pTK2/EEjUOR3pIQUwcONe9n87JxIpRIiUiqthfzahbZrsJ6EGo0S4ga/BfXRO6MK1e6oXzlwmimonlkK4H4lvpBxAn+EwVABrnu0UtsjAT8gGqScfbf76db3+ubNGfPETqfLzj4ZAwC7j4mIueXiuM2kIjXjV1N+qgV50clcPq1j4xbfLwOKFDuvxYpBzTRvlp/qno2/eFRZK12ASUGtZfzZ9ZYyFkJWuYSze/vrSKhdbG7qOmgIpterG/lyaDYm2/mcTVG/YnUbpdmNNclJCFd7sOV8yoWtPqI9nHxyIDaaMPEQGNAYCWsYX2FDiNbXubgfSS0ff9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=ECl4Oru/HhaRyIK8mg/rnPTaNVPaUAe+e/GRJ0XnUFJstmP7uk87HRXW65lDzOz2QXs04auu0S+YbkEORU5YhGu6oibXK98VrhcxQKfgkvzbD7zghn6Bw94eq2Ij7m4A5LPCcLEaLzHKiA5ybilMg5nO/wq8hrvBb2L2GWqzil8WD9Tu/XEdxqlWaEjZ1mzjuz03HTwFX2m/A4IT9m34bGzPIiKc5Q+iQWvD9SkPXZ2OCGh4VZQYnk3YkMv5tZdT9fQ1pUyHafnECRYmgfOBENjT6LCn5dsgX7KRN39f2aIzmCVuPbTCJEyA0D1Wc9HiPLx5iMOjK7GWbktCU55UuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=1f8lG1uYTsm0cmxIzTgl9g4w6M5kmojHR+PblLoZV7Cc/cItTBXDpzjnx/r95J0m8lT6oQ8Pv2uqEsDm5DWNjlwECmMJev74xI8HTtQ9FUXW0wBpw8jxOLPaB4/SQVgPEFhwty99uhQsF4AbucH9vnbBmz8IIswDXQsT3Mgz2dU=
Received: from BN6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:404:121::19)
 by MN2PR12MB3359.namprd12.prod.outlook.com (2603:10b6:208:cc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 21:34:35 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::17) by BN6PR18CA0009.outlook.office365.com
 (2603:10b6:404:121::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:34 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:25 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 05/46] x86/boot: Introduce helpers for MSR reads/writes
Date:   Mon, 7 Mar 2022 15:33:15 -0600
Message-ID: <20220307213356.2797205-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7a1070b-8724-461b-60c5-08da0082461e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3359:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3359F5D923C259E72F0728FDE5089@MN2PR12MB3359.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFbOymzHSqjlmQuflO5yewGtzDApL8d5mX1PGzVAMir1FtzpVN2IoYwWx61Yx2APZ9ucDU1It/BskMz+fQwpyB2ey7PDSy0JXBHLrYBdKzaGLmW99BIDK17fiCPyNdZ0DkkI/5+c2qMGZP/+VU4/gLmj/UI10EjrGdLviLyfgo6s/fcPpvpXX6iIs8q+XUdVi97nI31k2WJHltOFqiyTWCrDNZno1TdW5NMyrO6l+ZjNOTs6E2TB2tM5naETI7Ox1qUx8TEDE/wW10tZLCFls4Dh1IyCSccNePpINh5RHHIlAPpASF9TjqU8cBKVdYlty25ixiOUcRvQE62sbwk7t/y7FqOhyWX0rQgfVvgFrSRo8eQJddP5gbESkK7NF8nzXy9/AjxfOZWNWh0ICKyeQX+zKDlUWWfhYEXoi/X+8Z//1LQDUrpIvCROsvnCff5qY1hQLN/NEqVKldEoPMeGATX2GMQBengzPmT4iOP2+qo+SBNen2Y4fWV3416tUM9mOMUXEExNvnU3amTKsTxv2RlorOvINqzZhFh0g/EEGvGEb/r2egckH97cunfW6PgL86yC/gK9N+A4imhOVFSpvDZSVMi4zWKO/rNJpsIwuRwuKHB2OsR8tr0TUsID8j8FY5xnYu4HKE2MWuzxCUv9p9Bfrxwfi7n/0WJIKGbkoUBPoSEMpvRlNMPdycvhd6Ji58RDcd3PABhE/g4z2yr1G0tzhRPNrW+GC5P/bwfd7Ew=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(36756003)(7696005)(2616005)(83380400001)(2906002)(7406005)(7416002)(5660300002)(40460700003)(316002)(26005)(54906003)(82310400004)(8936002)(81166007)(70206006)(70586007)(44832011)(336012)(426003)(356005)(86362001)(186003)(1076003)(6666004)(16526019)(8676002)(4326008)(110136005)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:34.7397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a1070b-8724-461b-60c5-08da0082461e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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

The current set of helpers used throughout the run-time kernel have
dependencies on code/facilities outside of the boot kernel, so there
are a number of call-sites throughout the boot kernel where inline
assembly is used instead. More will be added with subsequent patches
that add support for SEV-SNP, so take the opportunity to provide a basic
set of helpers that can be used by the boot kernel to reduce reliance on
inline assembly.

Use boot_* prefix so that it's clear these are helpers specific to the
boot kernel to avoid any confusion with the various other MSR read/write
helpers.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/boot/msr.h               | 28 ++++++++++++++++++++++++++++
 arch/x86/include/asm/msr.h        | 11 +----------
 arch/x86/include/asm/shared/msr.h | 15 +++++++++++++++
 3 files changed, 44 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/boot/msr.h
 create mode 100644 arch/x86/include/asm/shared/msr.h

diff --git a/arch/x86/boot/msr.h b/arch/x86/boot/msr.h
new file mode 100644
index 000000000000..b6bb2161da27
--- /dev/null
+++ b/arch/x86/boot/msr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers/definitions related to MSR access.
+ */
+
+#ifndef BOOT_MSR_H
+#define BOOT_MSR_H
+
+#include <asm/shared/msr.h>
+
+/*
+ * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
+ * boot kernel since they rely tracepoint/exception handling infrastructure
+ * that's not available here, hence these boot_{rd,wr}msr helpers which serve
+ * the singular purpose of wrapping the RDMSR/WRMSR instructions to reduce the
+ * need for inline assembly calls throughout the boot kernel code.
+ */
+static inline void boot_rdmsr(unsigned int msr, struct msr *m)
+{
+	asm volatile("rdmsr" : "=a" (m->l), "=d" (m->h) : "c" (msr));
+}
+
+static inline void boot_wrmsr(unsigned int msr, const struct msr *m)
+{
+	asm volatile("wrmsr" : : "c" (msr), "a"(m->l), "d" (m->h) : "memory");
+}
+
+#endif /* BOOT_MSR_H */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d42e6c6b47b1..65ec1965cd28 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -10,16 +10,7 @@
 #include <asm/errno.h>
 #include <asm/cpumask.h>
 #include <uapi/asm/msr.h>
-
-struct msr {
-	union {
-		struct {
-			u32 l;
-			u32 h;
-		};
-		u64 q;
-	};
-};
+#include <asm/shared/msr.h>
 
 struct msr_info {
 	u32 msr_no;
diff --git a/arch/x86/include/asm/shared/msr.h b/arch/x86/include/asm/shared/msr.h
new file mode 100644
index 000000000000..1e6ec10b3a15
--- /dev/null
+++ b/arch/x86/include/asm/shared/msr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_MSR_H
+#define _ASM_X86_SHARED_MSR_H
+
+struct msr {
+	union {
+		struct {
+			u32 l;
+			u32 h;
+		};
+		u64 q;
+	};
+};
+
+#endif /* _ASM_X86_SHARED_MSR_H */
-- 
2.25.1

