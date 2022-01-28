Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFB49FF25
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351074AbiA1RUD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:03 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:22921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350726AbiA1RS7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/ceAZMuhY0MVaaU0rr6EdAZxpBtNL3az0CFPSo4yC2ZiOoZz5N+7ZTkkuQYqJwNaY5MJoa8MZvYdLeRMtRRfU+Wzl8vmXmpwFOIpa0uwveh3dDQkR4F8ahnghwkActhB2eR+7q2gZ8lW877U06Pnnh8VjUjKYLWpe1SiX3l8knli+pBJu4dIQWJzs/WyWdr+pu7clamXjPbtSr/FrMvaKnNF6IWQM1aA7zfT7qcTqbf4INx9r6sxxfmY5T2UccfhKSj374HZh3II6NMvL2C8pTPFmW6DFVhasnLHVCCnwdnXpbJwM9i47A6HH3z4AtsomAni6HOa70sBK8CWMgkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5Zj5nCJT3EYONARrmvt1e3oOc3EWHZyii7igt/b2zM=;
 b=cqoLT4aL91O4F1bE0Aat9g+7jRcSUnYJim6WuuNoPh949D0kY5BZt3LB/w1W1DECR0ygVc1EB3KBHfru3ii+0zhoV4/XWgY6uT4o/u1Mkm12WgagvzntCEmL9cTiSgnl5ul06C4dDTENRn1/+KBL2WeCkCdBPtTpYbXFezs3VCAn2hphCEjCgTJ3gJk1L8gIeXhl4hxDF3S3rLfMjRlVKXWjWOGMyolKvBKzju1RpaUbLnvx6JFE5hbWr9FbtmVzErJSF9bW2grklDXhzbJOGKWUqOaajnyMBGrzbXI3TQi40M1rVCgNCXnIuSxC3u22ci0IxVmG8lKvTnFAhS2dkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5Zj5nCJT3EYONARrmvt1e3oOc3EWHZyii7igt/b2zM=;
 b=WDNVCh8OVaYAC5KqSRINLwb/QuiXKwTwEaEzmbF6yAe/LjX1eAbkub2i6tvAj9N18xJ1giQj9Yvs4E71uFkUWNnCfubZnqjMu4Xb6huZLYAXA2tYRtAGolHeOlIkDRTJyXeKLiiKFGgz8O8mlm2SSP68NcOfbGShkwTzy5xMh1c=
Received: from DS7PR03CA0126.namprd03.prod.outlook.com (2603:10b6:5:3b4::11)
 by MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:18:57 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::76) by DS7PR03CA0126.outlook.office365.com
 (2603:10b6:5:3b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:57 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:55 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 23/43] KVM: x86: Move lookup of indexed CPUID leafs to helper
Date:   Fri, 28 Jan 2022 11:17:44 -0600
Message-ID: <20220128171804.569796-24-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb6d1775-1ef7-4910-4b06-08d9e282448f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB366371F652262CBAA067BADCE5229@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty86VZfdIhfjMxIkmYKk5+hg3KDZJRF4KT5hAPFguBNb3NMORYDurXfCoHiWVKVYZKSgVXUlKqvs1UM0fhNHkz5MQCz5ZI750iUdAK8NX+nVC2clFu4+CxyyC5p6JgvegNVnEfv/TpyfnhtfgESTjHBQSUuTQVH96RD0QufhQLYeG8t8SYw0exQfSiZ2thcnUv5wrCf2Rxj88sj9KxI5ZPNd8ca8n0dK8gtSVCdjImHnNqFayS9ut3Ph36tOrnp2gmASB7AVm6guLyj9SSOubEnZnDe5eQ7odd2YQOCQw3eRguRW64gE5xcfW/0gMKIQGb60eSwqfGJWyfXdHQJeraTwt1HHQxzH3gcyimEI+emy8B5tarYWtLi477sxm2ShSVuVB74khiXhpv3pozSvuL6bCPyt2BnrlfFPVaj1h2jgHHWn6sqLq5w74W8tho41FaOlvawkGddN+eP1cJsIXTyieyFw8ZRAzUy9+H9bSm6A/cXOc/Tpe67RtZRYS7b8TcJ7fGzPyeuJlftc+0QRRl1aOaYdfGU0/RhGKagMKD04G+6J0QL0aj0sjL7kNaqrvx/8cXH6NkLlZ1BrGALP5G1+mlnueFt8HYtMqveSYsvfAPyNqQrdpy1hA7RQiIrtFOy5j1rnzezo9ejuK1sil/z5foE0AYdQxykxV/soy6TJqqm/Q4APydnXxKxXq3WV5aqqNb3ZJBko9fXKmcyw7FlMoAdcEagxZj0NSGfEGdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(110136005)(54906003)(7696005)(6666004)(508600001)(47076005)(16526019)(82310400004)(356005)(336012)(26005)(1076003)(36860700001)(426003)(186003)(2906002)(2616005)(83380400001)(81166007)(7406005)(7416002)(5660300002)(4326008)(8676002)(8936002)(316002)(44832011)(70586007)(70206006)(36756003)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:57.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6d1775-1ef7-4910-4b06-08d9e282448f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Determining which CPUID leafs have significant ECX/index values is
also needed by guest kernel code when doing SEV-SNP-validated CPUID
lookups. Move this to common code to keep future updates in sync.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/cpuid.h | 38 ++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c         | 19 ++----------------
 2 files changed, 40 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
new file mode 100644
index 000000000000..00408aded67c
--- /dev/null
+++ b/arch/x86/include/asm/cpuid.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel-based Virtual Machine driver for Linux cpuid support routines
+ *
+ * derived from arch/x86/kvm/x86.c
+ * derived from arch/x86/kvm/cpuid.c
+ *
+ * Copyright 2011 Red Hat, Inc. and/or its affiliates.
+ * Copyright IBM Corporation, 2008
+ */
+
+#ifndef _ASM_X86_CPUID_H
+#define _ASM_X86_CPUID_H
+
+static __always_inline bool cpuid_function_is_indexed(u32 function)
+{
+	switch (function) {
+	case 4:
+	case 7:
+	case 0xb:
+	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
+	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1d:
+	case 0x1e:
+	case 0x1f:
+	case 0x8000001d:
+		return true;
+	}
+
+	return false;
+}
+
+#endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3902c28fb6cb..3458dd3272a0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/xstate.h>
 #include <asm/sgx.h>
+#include <asm/cpuid.h>
 #include "cpuid.h"
 #include "lapic.h"
 #include "mmu.h"
@@ -699,24 +700,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	cpuid_count(entry->function, entry->index,
 		    &entry->eax, &entry->ebx, &entry->ecx, &entry->edx);
 
-	switch (function) {
-	case 4:
-	case 7:
-	case 0xb:
-	case 0xd:
-	case 0xf:
-	case 0x10:
-	case 0x12:
-	case 0x14:
-	case 0x17:
-	case 0x18:
-	case 0x1d:
-	case 0x1e:
-	case 0x1f:
-	case 0x8000001d:
+	if (cpuid_function_is_indexed(function))
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		break;
-	}
 
 	return entry;
 }
-- 
2.25.1

