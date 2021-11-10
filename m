Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62844CBDB
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhKJWMK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:10 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:8673
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233892AbhKJWLc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpKK+MDxvdoJg/zF5iSQMR9GWr/VJ7pgbOPoLHNgr5t1+qQ0kDF7davlyeJqD+dLDevOYPNIHevw9z5eXcP0w2g0jGIf58oGY7uktCqvJztuLCbfH/HjgMxGZSDGEqLc1qS3mmSPNd+Qt+HdBNB/JG8zznzwd3hivhIM98duFpimZuO5atrPLG7PfvoNIY9Blz2vQoV5Y8DmJ4xiFOPHIV/OLGLXg9JlhXuNNU/UmIB48QBufjV/p2UecXnOPxelUDXqGlOZwiomKPJ5yH8un4fgrfblwEYgQWxwApg9TAYw+qmWsOEOO6blWGBGLPtxpJtbu+mrH1rjkSwCygK9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbrIDeWlaB4QDQL/hhRxyhMqzV+ojKUbcVI7/5PAPr0=;
 b=ND81XqOLzcLsBRHJ2OALtx9xYEjKB33HagVopb8yIkdWqGRRmU0FjaGFaj7goQIXzuxFywuebaS7S1Fsta6gypmkIkaORMDgdZzkX6tnW5YyxftO3uxWkAMY7RYAgSFh6I6bS5LoW2/7FctpnV61zba6I5y2a3Ybnesem1Z37yJk8Xqt6JVRU8RbMKeUKl+iQXMEUE+oreEKGEaP/6dovo8HtS78Db0p0/hV7WYvVKsWsplWLc0Q7+ENXtrjIfMFFVNnN5G5Z4CT4E5cDqI7DiyoatfxEVYSrYMmLJmZwFNKseCBV10aX5+hB0scDYGm2+N4V4KnYUIsT3kwgU6uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbrIDeWlaB4QDQL/hhRxyhMqzV+ojKUbcVI7/5PAPr0=;
 b=yZMlEMtd2gLr9u3WGh/w67idTmIHoAhogJxzb1BsPtSFtBtuwGc0tH40SugOSGAiYy/jU9Oyvj1PSqtjEN1mCD4xJcSWUHap5tLRyzO7JZ9w5o9y6y/Gcf58a93xJgX/+uniQTgd3mjF28n0VsYud5ZuhiBGRriteYQnlAiJOAk=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 22:08:40 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::14) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:37 -0600
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
Subject: [PATCH v7 28/45] KVM: x86: move lookup of indexed CPUID leafs to helper
Date:   Wed, 10 Nov 2021 16:07:14 -0600
Message-ID: <20211110220731.2396491-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15721a3d-a424-4708-c74a-08d9a496a6b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2695D4200D7A40473B726D5DE5939@BYAPR12MB2695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9Gard9nSuHQJYLXP/bU519TcMXyRRWmjYwo3Pj+B8I8CDLU71fERcaaTypMUkRliEsS4me53Z2GxO1mbIbKdrbeXg0DhK9xmnnJFSeZ36vKrAw0OIrGbCuevwudBjIhHi9vZvdpUTLxoqbpceWZtSfqvmHr9wBD20ohRj4bSZxpNPhsUnkxNVfGTZsUacirDz8YCRWuABHy/vg7RYuKLy0jnoLpV+OgNKt19t1DX4Aue4fl45jcgui2BmZ8ecoEHzf3+2Y7+tZ3pL7nu7Lcrk6A70lnERDix8JsNOGxqyJkalQ9tjahZ35Q0yqtf312QgT3F/NvNxViW8lM9JDZ4NHU7JMSjBQSPjqUmSUAN+OCWhh0IA+n4xGCI+B2fy5QzGwFUCAV2bRIfuAg82p/9MO10tztyAqYs8fuQuv9YBPG2C9YsOv4GW9Sv7q1BSQ/Z6Ch8Kc7oXldUzJr2xFZMGEynSEpIEAT4hrzMAI0yILn6T0SkcVDaq6+tz3gl+Ts0Ba0BfUTcWEaSL4a+7ECXdJHtor0olxK7uCYiU6FKrIJrs76m2WeLNLpoyIrSz9V07C48YreeVbbOhgteGXLM/gaYzzyIrezC1j3NLUPTcGyqnptYYrHagWFRzkxnk6s1yag2FwaB0RIXmkIl4XM3V/b1XKsL5YW/sAICZCzHLW35YiUA17v8heSN+7+1EZaAlknXLhev5gkST1+OcxtToqSEzrP/mzK7Ni+jDv5Dgi4mfLqdLqPLiMHKsI33Oig
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(336012)(86362001)(36860700001)(2616005)(7416002)(110136005)(508600001)(4326008)(426003)(7406005)(26005)(5660300002)(186003)(82310400003)(16526019)(7696005)(83380400001)(44832011)(1076003)(70586007)(2906002)(54906003)(81166007)(47076005)(70206006)(8676002)(6666004)(8936002)(356005)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:39.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15721a3d-a424-4708-c74a-08d9a496a6b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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

