Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6414C330E
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiBXRCZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiBXRBm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511CAB3E7F;
        Thu, 24 Feb 2022 08:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghZGnt88JhdZMjMVbd4K52BZwRi6R0/eWt2i1FcXHpr11LK6IREEkzHyFUWviWLMSSZUqHJXigd8a1q7Yh4P/B4mIWWn8qr1tKWX00NV0Ua1I7AiRYmtqLGudXEVnAQCwYYWk3XTVgYFZrLbd8sz6qr/loC7A7qXXZ4deMl5b1eN8XBFkfbAnrRTQhLfQdTYnKu3APXSCNzQ2PixloPFqPnFs9v3XZnOL22IiDEsmRuG6KTRrm7D42ZFIdHzu4tm+EPzvOm3Wb4dIWxBEjsHF8gQ1x26kp6KprKqXs+2BYLv6IxrFQsLtlhCT6OKfxQ3sCI0RkfhYSxakQvZ5XfKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhquFhz5GxNpJnKdCRbrCYJnQ8UADlx/TmtodjSUKE8=;
 b=dyYKZq3XMQ3XGEA71KfgDaIHuXJyXnlHwS+b46w1DAaKjLRQLaopLcfJNs2cEAAutPau+bInmNE3JLCcjT1NFnimknr0JQxbH6NpJ8OpT0BQlmh+GT6riSJh5ICGbetG1kW+QlaekRGDbMj7gG9wPzUQK67b9ACslSZnHG8Ej5T+faucYeG6EjxZks8vYjLIrS3zsFQV8PEYWr5dx/bCJC9FFo2l+tt12H0cfFYpAk05SGfxdkXbQowyNx6lyyt92wfH9ScDsGPrttBHw5Uy07u2aKgj97AEVWrzRRncVWj0yZLFXX7EoDqeEABEXOUxR4IVQUQxwkDC1a8YlpstbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhquFhz5GxNpJnKdCRbrCYJnQ8UADlx/TmtodjSUKE8=;
 b=DTnVRd0I7/OeaWJ7gqdbjHQx4ZBHdKaS7p9gq15UmzguVISKriTZHZodzRrR8ua1kRGr9RUnjDczFxm4dVGWktARlAymIm/3SCQ2+tR+bd1SjDxCNfS8EBTy5pPXpK32aS6cruAIvbM4bfCGBFuFFe1AkEL6RzT7JSyzctDF7bQ=
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Thu, 24 Feb
 2022 16:58:54 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f1) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:53 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:45 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v11 30/45] KVM: x86: Move lookup of indexed CPUID leafs to helper
Date:   Thu, 24 Feb 2022 10:56:10 -0600
Message-ID: <20220224165625.2175020-31-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41d3c24a-38ce-4d5f-d370-08d9f7b6f07b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42262E0C8F7E9C59A03CC153E53D9@BY5PR12MB4226.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BM2JUDbLtcrKU+FgAlLSnFu/rIFEmKqj9H1CCFlvbQYmE1dkYAJLOvncM/mMq4m7mK8foPLoHKLI6KPbZP8tZ/PhlLvT4ATzLgdXtcDonmApIK6pvH/PN0RokHwiqe+bUndtI3AmIL0ndiVN3gdWMkdh1Ho7/LVrXn4p9bD+TCV5XkaZYq0mYlTo6t3Ed0dxykp4b+P8qSlqRhw7OXvrdYPHYhWMXdvCn10d8XEfXfP5vuU37H57apZ/HZ5rlAGOF7OXsBRT/RWcppKuuALopOlIm8t1Kmh8jFqrvSYGiqViaQwbrZh10stsX+kB3oASkpM0ll3/sTPInpmpcxt9g8AZIp/S2HTG8TG3gz089V/X/OIEloz1BgGSXmxwk+4Zr9hTVEzUMV8DL19m0nCJ4mzyAzBPpgm2a/Al/AAAEQEyh+ZCcci0bH0IGItFrmbmcbzWUR64waUySGq4DfGo6R3BE+85r8RQl2yHT5a9JFg28VIdL0slM4WUEvRInN67YKY+vqWim77L2+G+sWJRJL54753adD9Ei7EFE7jrKslukDb63IOe0gCVecM3IYH3WggoMQ5zvNfT5aeHlrXGlleBrtv0zQjZxMQD9NXE6sc9Zoz4c8lXlI8G8GtkdCPK5wmV+76yr+LhIz51w5uKUaCUUThw6ADtXjHIIdY6p3gyZw9mCyS8nIh/mloSaUEwMNlf5aGzqbet05W7PAZY+o88pOkQymO7wEQDn9L+djE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(7416002)(316002)(82310400004)(70586007)(8676002)(54906003)(508600001)(426003)(83380400001)(110136005)(7406005)(1076003)(70206006)(8936002)(336012)(5660300002)(2616005)(7696005)(356005)(36756003)(6666004)(26005)(186003)(47076005)(16526019)(44832011)(81166007)(36860700001)(2906002)(40460700003)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:53.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d3c24a-38ce-4d5f-d370-08d9f7b6f07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/include/asm/cpuid.h | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c         | 19 ++-----------------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
new file mode 100644
index 000000000000..70b2db18165e
--- /dev/null
+++ b/arch/x86/include/asm/cpuid.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CPUID-related helpers/definitions
+ *
+ * Derived from arch/x86/kvm/cpuid.c
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
index 868fc9526e5a..18a20434759b 100644
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
@@ -719,24 +720,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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

