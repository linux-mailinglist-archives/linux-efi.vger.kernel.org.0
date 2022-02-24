Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9596D4C329E
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiBXQ7E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiBXQ6i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:58:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC95F4C5;
        Thu, 24 Feb 2022 08:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZq5Co6L76a5oJIh2IrKzwbIVdpQrRC3GdkmK59gKeNvp+F0ba4N3ZF5cGOFXJuOhO0xVfJd8MOFulyb81Qp+OBboWxh3b+Iv1bsLGqG/BwrKr2DDt0YYaXfw4IWx9rZtB75t9WQ1VywNxNT6t75ntc+vF4VEJ9YQONx1aIN65/ebZGkSy1ziJDw7vm3l99E0kL3ajUTSjohBKsZwpQoWp/gRBeQjOBMfee9R1fAPTaw+SiPhpY+8pUX52D+Nffo/hz0uuEMsBu/luolhsLa1+91M/RXo39xTfYbAT7V/d7+X0z8075hb+gACITWp+swXaBbUBwWguNNmZF66ZJVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=JfbwcdGu5AGldLP/KqEKmFGxA7+KF2rKzeOd74EdU3k4LEf2zKgX+RItU+n1p6IAiJqD1c6bVAiXNupQvqIL+3TpossT61mGI9yrrrn6D0LwKFC+YjvvvoNYLV0dAsX/iJSxFHgs4mMP9BulpSLqsNNoC6+3Zq6juLfV83RrPR21F4Vt4pewnoC06bgaizB6XXk1kBzgcTY/bdn3xu/mfCWSk2+Ne59eB4H9ydndEN+7C+cstNA1BCEFS/ZmLAcXoRCDB1ZzkyEzsr8xsY1NVQfru+t1oBqU9PH8T2eJtDtz9lwPxrfSyuV2eBC+Osr0AZd4hjfAGCL5bO+91kqFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=Q/e0ejWvnkItik0T92pyRtf1x0/DFuszCtIk0LRnietTjyJNwO1hpUshx2zcyyJrPdTDODXueAOVxmiT7hMFNgeh3GGAMCSwFz3aHlxChsKqc9lN7SDJGF+UoLi90vpbjMW6IEzEsVcC0gl9ZhsereBS6pmRegynIkjhU+cDTHs=
Received: from DM5PR05CA0001.namprd05.prod.outlook.com (2603:10b6:3:d4::11) by
 SN6PR12MB5693.namprd12.prod.outlook.com (2603:10b6:805:ed::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 24 Feb 2022 16:58:04 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::e7) by DM5PR05CA0001.outlook.office365.com
 (2603:10b6:3:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:03 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:00 -0600
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
Subject: [PATCH v11 05/45] x86/boot: Introduce helpers for MSR reads/writes
Date:   Thu, 24 Feb 2022 10:55:45 -0600
Message-ID: <20220224165625.2175020-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d23db98a-ca4a-41ce-1962-08d9f7b6d284
X-MS-TrafficTypeDiagnostic: SN6PR12MB5693:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB569352089FCA3D5378AD31B3E53D9@SN6PR12MB5693.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVsr81qB1e1Hky4+mjt7VodKw1qU8UoQJZ/16mbeD3nETwYZtRVguT1AfQ+cEk3WbOQuXKTLXHeZjw0bYBlKn8HtukFVzRl4U4ZPbP0nWAzLQQuWZHUJUisakwCZKxJPDXSs6gZCjR9Dv/EqwbChegAj+jIIQj7jw625rc3YdT9rjDMMF+uIw5qu21p8M0cnN0A4BtNJj12dk/P5GfNW+M/XT86I+9hjUcxVCXFAbhToH2XOnRJXgPLEC/kDM5682qT2h5gZOSOXAx0V7b+SWGzGB0EDB9/vrd/wFhPELDDFFXw9N0+oG55SIAQ/F5kD95OVsOUojX8EgWBdD96vSnDT9OmbnSf5OClACOVG8PjTbrHpwdSl8XjqjGPPDjEI2bBYLtdFjM3sBhoxt7SmheII/4fG7Z0fBBoSw+5AGgDoBgqQB0D7jWWSsM4KWLSWgyhEZhdM3/A2ABAh/7EBA+pts6HpanBELhembLG9YZOi3C+a9V/j5FFCoWzj0qShg16g0haIMUoqx7G5FTja+0v0EjB3RQvHgsM4lVwQcxodzTmSG1Xvcj36DxoSuVrCVH5EEMmYuByIgQjVUFuTl9VT0CC0cHS7qh3/m4EilWzFFhiFcdpHVdJVfNZQ6/DtiWtNaeNoOfa587fUjHVd3PZm/kEGORTL9soiXfLNvaV9nObVxZyfa6tt403zN/3n8bDlKsthBr7bPlHbnyqCwy24HnHATeljAMO7M2Kg4f4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(82310400004)(83380400001)(6666004)(7696005)(70586007)(70206006)(4326008)(47076005)(2906002)(40460700003)(2616005)(1076003)(426003)(36756003)(16526019)(26005)(336012)(186003)(356005)(81166007)(86362001)(36860700001)(8936002)(7416002)(7406005)(44832011)(5660300002)(8676002)(110136005)(316002)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:03.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23db98a-ca4a-41ce-1962-08d9f7b6d284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5693
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

