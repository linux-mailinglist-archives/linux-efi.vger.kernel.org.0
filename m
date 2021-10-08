Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EB42704E
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbhJHSJ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:29 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:4960
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242220AbhJHSIH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3NdWwo9FO8V6zYThBRYK44mCcbNiMNHQ4ZEAq3zBZWZ7ZodiDp9FjV6JgVYKBT+JcGoWnF3n6X2clCvDaPo/NHujbpLFyhJxLEhJjh0IXk7ljpNtqKTMDEepyclEA6zM3j3QqnfQmvjaxuGtJZNb6B2jKa1B527ze5XntZzBNfHmLqjk/905Q7i/zAWvsZ9ALHiPyhKptnzxUNQpKY6+8j5Z3sXAFHQli5oLh3AQBMDsFhzw1htPAhiUlGDid9gbs2GA+gEzP48ArPD1ZBaXSZtq/RxMDR61PV7PA+7hcFPUvd6hgLjLFiXfhq1VeyhZXUOZSgU0KvN3ejDwTUPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbrIDeWlaB4QDQL/hhRxyhMqzV+ojKUbcVI7/5PAPr0=;
 b=iTvO+f95H8S6Nb0pq3czLgeIKKErjE2YH+9kXC3cGN2hyuKXA43Tu6rfX7I//5R+X2D/2n2VUSVlY0ACoHaa9Sg7Nb5y32dXi2sxhdp+0D2EiZPvqH6sdr3fkAUEKQO1Yc05O7yszPnC1WCnG0toChnPCmGYszQnNVklytDBcR8YEt/qsKy8jO8yacuNTQNyW7ak+MNDu0iWtiP5h0s7wWg3jUIamPVsn1YGWISIaFi3JcLLqV5KMAEW5hMtNezrVNX5gj1JM7jItolkUDTQIDvj92qMy3gDO0elnARUKIq8+7C/hqBzeWHiD0SMnpe/hzKEMv8SzHGHRvuTs0ZIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbrIDeWlaB4QDQL/hhRxyhMqzV+ojKUbcVI7/5PAPr0=;
 b=sdEvoq7nWdBoNQnREWEZJ58YH3iXfZw/6oDj/LFQ4A64Hs/pqp44YF6HUZQVWlb/sxqLiZGFGWBajHeW7JfWu+CjsP5a/hQP5UcuPn2w4h2ijk4DWmXCLDubXczFX/bE2U0wMQ/jG5YrSEJpbxMB4c3Cfb6d5OZnf7WQ5Uukp6Y=
Received: from MWHPR20CA0028.namprd20.prod.outlook.com (2603:10b6:300:ed::14)
 by SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:06:00 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::f) by MWHPR20CA0028.outlook.office365.com
 (2603:10b6:300:ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:56 -0500
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
Subject: [PATCH v6 27/42] KVM: x86: move lookup of indexed CPUID leafs to helper
Date:   Fri, 8 Oct 2021 13:04:38 -0500
Message-ID: <20211008180453.462291-28-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f04729c-f7ab-46f4-383f-08d98a86487e
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5503:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB550388EB0C052E73610CC624E5B29@SJ0PR12MB5503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXbtoPs/G5gtLqi2Cfpebe5aZQiQGKfn2LqVDRRUKzly8u+0QCBkNikmhv1eSS0ul8RNxD+XcZdMtZmtQKWtZEdwJEbd8ml935ClppHG+cVJPfyuISZRY0/1Pp8t7EZ+E/QvpiN4t1dXNs2NKtIwFMYKoe3TM5r2Zu9135S2lnAMJHqfNPzGO1TROW781/aEF/oa1ENp+nIbsp2qx9Cqaeb+CgPP/ycoEK7Uuw9sWfUhQy1VrZnv2ROoDJ2jjoF58bWsvaHR7rEFDWU+A/M8cQxx/5MOy3a9BB/PWWX1sgEZ+hOZx3n1Wst0VyXbZCl275P5WiacxsssA7JFSfR2SzTBY9ijfAjKI/icOx7xZDtQLVFM6VaQA7+XPqz3R0ymT9HWCSaPCU1VN9kufLRPDdAzrg+5x3Ja/InXHt9xctd25Tn2bpErgJRFIdeNFbJLrvHWMSnbNZ7EcuUl/LBBXyJdh7ddW7hqfxx76/xZKLPzwY7ObkfTfE1N669cUY6AzudVj1ahgrbjGRju0zOrv/J2TlXjUfTqws9JGpD7bLjDuFDycD7lw/9HLrIO54gFQYauKwdJwgxRz+pmW6togA/18UcmYU1dFmHWk7T8vyXaS7DXE34lMqlPR8c+UWHZVCjXKVFqzCeGXHNtwF8IWQr7t0+0PlRAbM/nixFrgNvACvFnG5GNZoRJPeB5bgkwXxQgUn9OhwOUQBU/iSlH5l2GsTDb5hl8f9HxV/lnYNLLXcOQEf+kiNTY6SqYmJ5f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(8676002)(26005)(54906003)(4326008)(5660300002)(8936002)(7696005)(2616005)(110136005)(6666004)(82310400003)(70206006)(508600001)(83380400001)(70586007)(336012)(47076005)(1076003)(36860700001)(316002)(36756003)(81166007)(2906002)(86362001)(186003)(356005)(7406005)(16526019)(7416002)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:59.4578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f04729c-f7ab-46f4-383f-08d98a86487e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Determining which CPUID leafs have significant ECX/index values is
also needed by guest kernel code when doing SEV-SNP-validated CPUID
lookups. Move this to common code to keep future updates in sync.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/cpuid.h | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c         | 17 ++---------------
 2 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
new file mode 100644
index 000000000000..61426eb1f665
--- /dev/null
+++ b/arch/x86/include/asm/cpuid.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
index 751aa85a3001..312b0382e541 100644
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
@@ -582,22 +583,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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

