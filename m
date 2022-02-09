Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974E94AF93C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiBISLi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiBISLf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4CC0613C9;
        Wed,  9 Feb 2022 10:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du6CbrW32EmJ8W9YlADNLj7WFoHaEVJWJdKGZkcANogVNyhPUopNsSse4RLKgoUJHyGveYDCXY/JMx2EMAbpV4NAKiWu7MSRDaU4s2s+T5ZIID8oojF2JtCtI8DYUWwL0jbS1cKZGuhgm60ovdYYYGyH17Gy02/igDMPoJZASbXxj/PeowoTJOhadzW6D4/I0Qb1vNQ9d0A5wyh/Mj+FdrGKr6L4ZQ5//RCMV2WlRTMsLi8JJHygFs8GHc/9gd6IWFPgIhtE2dpz3AoJtscFzp99SYhmtZmGQTjktMT9UJx527f6aVlKr4FHdfQVtlnCNP9CyBazMbEpOJNjb6Jgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=fyZBh/cP02s5fPLHC2smwtfpst9vV++1DyIS36lYr015VgQ2INfahpChMlSk+uuCN2G6+Zp1PbvRPuakffie+/nwKADMtHMyfc1uvgkYrDnOhUfzEPkL6oAeZBsyxIGI5bTtrnz9x0XlJaNN26bkueQm9TM+X0F2sTfaAvGd0JmgsNYJKhRBPqvwoyJNM+fxkb6JH10eozGH0F55fdSWYlWdbSEpJNM9+GepIQb4MVo432uWb8yQ9a51zTs4SxW3rsLVgEqAisKoVsDWdW3PPPGUbEww4E0wsvGXRCuortkP14ht5WULz+6wYExE/AnCZJ4cX0wLVE8gCRMhIhi28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2B8/eKcdZO8Q6zMcKvymJSknbhAEnFEcNq7aU86tXY=;
 b=WQNjD6EKuLxDrnBnkyzFuyUUp1Gr8n8vC6Xh/9JU7LqYK+Yg9MlsJFKd+52nM/cL6p9jJaFkR5f+6jKa8jp0s832y4Jp6XzzdDDPuOqyU9qaFizPnD2zk3R3YIrVPwrizI5Zgodv9IWy/xNU8XBJWO+qX52V9aZHXuUVsfarERQ=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:11:35 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::1e) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:35 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:32 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v10 05/45] x86/boot: Introduce helpers for MSR reads/writes
Date:   Wed, 9 Feb 2022 12:09:59 -0600
Message-ID: <20220209181039.1262882-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2de6007-8119-458c-84a2-08d9ebf79be1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB457801AE43AC84E0DDFE7081E52E9@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC1x/vrbUxIpIhgHTh5NOnS6W1shK9V5Xnk13FJ1zhimmy08oESpVzj5aRDVxfrt+7xoBEs6U4uYm7JTmdYwQufNDwNK6qrWVX3ivRtayTHOxn5aXQaV/sSNfMvq1cyx+gUkYR7fhGojdDFxj6ffhzINxO3OUr3fcJQC9Ft5djfZU5eO24Jhjs7EpygqcD2tJZwx2rKQfmtoi9AyK5NyOcJ3mcGOGtitY+cP6C8wERBFL4tRbjVqdc77Hwtayq6lxai9CfbDU2NAt9100BFZOBiz4v3OIPcwwY32sxxQN/oM/IdAxve1FgXT4DZzu38O67kfEDjWjOFz/X4W1HwSM7sHLDja9qeZp1tP05ji5c+Vt37STmt+tFtLm+6RK2FLZP5pfqzSRkJghvoHgVDsHpgkBf/b/MyjpwyHtnD3JRs4qK1rMKRNsmdtveV0D5sZdyGIzsVnc1Yn9wH0HVLxnSrlcAFEuYUTtkYZjbDCUeCd0aH46APq8pxOBUfOtvLa0i8vokRB/A4IB6/fGreffcH1/TmQVeWU0iml3hsufwN3l4bHF0Z0EdkTUgEFgRitpIhTzc433v6u5E58RU0dBECXVZi9XEjSvSldJTSzfmtPslEuibFoZ1Gd73HcxGgyGyAJC7cgmNgd9YimDuZMZ3JgwnjQq0n2AE2dh9CE0SDFP6XZSjlYSBzvw+K/7vIAT0HQpqpeNHftkg+pRN6wPWDIgfTQFnDe/4VgXgpgquU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(81166007)(316002)(356005)(54906003)(110136005)(70586007)(70206006)(36860700001)(36756003)(4326008)(8676002)(40460700003)(336012)(6666004)(2906002)(2616005)(1076003)(86362001)(26005)(7696005)(186003)(16526019)(8936002)(7406005)(5660300002)(82310400004)(83380400001)(7416002)(508600001)(44832011)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:35.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2de6007-8119-458c-84a2-08d9ebf79be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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

