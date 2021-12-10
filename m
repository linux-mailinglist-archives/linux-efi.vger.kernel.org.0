Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436DB470470
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbhLJPsg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:36 -0500
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com ([40.107.102.52]:7392
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239764AbhLJPsF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIV9VKjXNKuH7sywdahWwgQcY6qrfN+x5za/E8mQYKwmNweUZelCp3Xcc8hxi12w0vMgB9pmSDHZRGK8XH6SIkbLAocP24MvQH2kg4vdM5j9BMi+vtYEg85QrTJ0OOV4eLXvzhCcQYt/pQB+aYBDGpVHl+DmHH0EeMAb6ybobpziW7VNVlpF90NotWaSajSWS8wZVZ5U0cbyg0ps8A/y63BqZFjfvst4yE9SSxmx+CIOKAtCBowPgYcfvghYbnVb+LJxEYGb40MjHvDjQlyCuAddKVr7QdseArJ51SYc5BXsVOgJr3hDJBq/TwNGdreCmDUf2ggUuTMuaGz6BX3s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pjn8BMIZWX1OhmxVtPToI3CrCbbWwTDpB+tD/8K6Dw=;
 b=i3k2B+IEAfkjE3FHM/oZsW5f/4LrWzBtOCKve75MH45eND53I4ULbex95kQs785hD8LJreP6e4ceK61tFuucAjxfTSDsOc2dPDL6NZesTopKfVtyVU8XoOJS6uinfb1coWCsIAf+YkEJgXjKynqGb2YTIWJSzux3pUAC8NaZvArUAogvVhscs689UyyEmZMY5E61+pK2hth8qXte5XEjpa4Xg+SU+DUGddoN5vWvQj3HBkyKXb9PrxabmTnH/eHWNBg/T+Jb5IudSupAe5J5mmI+Cve+rOmq8yD/ydiRSbgcDtPl1AYWuZXEM1U8YvZVY2mxOWjz0SINgfcjEnaNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pjn8BMIZWX1OhmxVtPToI3CrCbbWwTDpB+tD/8K6Dw=;
 b=FeiRVXXI+HPAbOT0cDjlgOvZvTlNTity2GDLlVh4awp+R/r4qJ3z/fpXzYDUkbyEcvO3CCMh0sWoK8ylNY2oKqW0Evu/Zs0SFc6WOmCSDhTeZG3+y7JBssFH6McogWmN4wROqzF1Kcj9hg1J8S1tnJxsb/c0Iv7WnskrmJ1L+mk=
Received: from BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21)
 by BYAPR12MB3365.namprd12.prod.outlook.com (2603:10b6:a03:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 15:44:26 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::7) by BN6PR13CA0059.outlook.office365.com
 (2603:10b6:404:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:26 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:24 -0600
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
Subject: [PATCH v8 23/40] KVM: x86: move lookup of indexed CPUID leafs to helper
Date:   Fri, 10 Dec 2021 09:43:15 -0600
Message-ID: <20211210154332.11526-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7787bd83-5be7-4205-69e2-08d9bbf3f220
X-MS-TrafficTypeDiagnostic: BYAPR12MB3365:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3365C66C924BCCCE701A1153E5719@BYAPR12MB3365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sewv3GANHC42yZcXm7pkWIugUlzXG6BTJardj3DRhb3yeqO6/N9HEyTf7cxvKvSheKIPM8vxl65rHF18aLkJYyywFRUZRPm01kqw4Vu+6U9b8xf/KhQR5mrvSWpgav0cnaONZma3NlxkjeS/lLIaInl/YL0Z99lxgme5Wp5B6C9sXOUtY01dmQevNrm3EaswAgEwy1/QNuyXlM4xbcQM8cLOH7ytuOH5jAf2AfLIbANMANu/nf4Obs3LHMtfMdIemLcU2p5KkvqwxzOfqmEkUOBMZXhmCqm6KjIKzGw+whhgbIKNJbvmrfJnpcv6AhjF6/aR2/smmtvDLGxaXRXQOwKdWhjDJJ7YoW5s6J6xVN+KTSj6L4SWTu/zX/La8uTZS1hBbbAX031bkNXYmefA0V2zfjRIhiHlqs4/GHeJ9mMZQeiBd/hfObdJmQXhNzyrGn70xTSDCYf7FJ5eTwbE4AAXcIOSPj2fpoenGWyDBjOtdcdinmmlDW91BmDhSZXIPW5UhMl81yQuHTLoi8vW3qmeJlh90tIGpzqJRjVCTb01Dg45u8aPhus0lYla++v/S8f1Gx2zZmk1HlZzLMixtThtqn29aFGHMHS6ZSOW+8ftIWE7ieJdUoEgHxmfRlhD0muMJZ61/Xz3iNySWPLJcaMsg4lhJ1i914zad7aJ03w5/gUmW/Yp05F9ITVj/g7s+pgX76ots3Nl3/ie7fwyrdP0f6GGeiiKoVxR+YHn4WmHWORFtMSqLWkIBweMPeaHxMn4XNje6yWrOXLBRAgdeSO8O/NnQdM7uXKsJcSTWsv5HEcgBvqiJAX1ZaceSDZm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(81166007)(7406005)(2616005)(44832011)(86362001)(7696005)(40460700001)(2906002)(47076005)(26005)(426003)(1076003)(508600001)(7416002)(82310400004)(16526019)(336012)(6666004)(186003)(5660300002)(316002)(8676002)(4326008)(54906003)(356005)(83380400001)(110136005)(70206006)(36860700001)(36756003)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:26.2824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7787bd83-5be7-4205-69e2-08d9bbf3f220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3365
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
index 07e9215e911d..6b99e8e87480 100644
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
@@ -626,22 +627,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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

