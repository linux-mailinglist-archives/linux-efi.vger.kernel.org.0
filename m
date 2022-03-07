Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C464D09E4
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiCGVjt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343520AbiCGVgn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28689CF9;
        Mon,  7 Mar 2022 13:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcU6ZTnqlfxZPFK2gaK7QKTtGLTOfSShk4xGXa1VRolkWIpWbNg02hZbXWw0vst7NwB/tVQt94Bgs0W8O7+QhzBy5OE65EfXa9LB6n7d1JEfI3OMmZCkOZ4V5OFICoTU4yP7i2p35uo4Eh4xueFxyGgGhNUT0ETpqpHOvCkyp9kQKImoR3JMu934l27LNqtb0JEPKbhG0naVGWlft9zwiZlaMXFgUC6FZ+CNMpDRhCSUYX1WznzJN4yZ6H4WB6rGf2IbnSWIR+cryhW/x827xK0oyAbgYjsBEWVlM18Vzv4X5FJZLD+KoquHuaRXIKwxWCdPYc5yM29V3YEVcalX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xgavE+Qngi0lQtzohwL6zfz8vtyDWyBLLQYa+FsZ3M=;
 b=PIiH/fKEEt88JMDeNifngYscsi3BiH/Cx6cPsILY0lxS8myzydlt7dbOubwgeHgOVFvU/x9vWfNhj1t2t2toUEoBUoePMekqcvdOrMw4I7bv6gMOZ+CF8zOvmwv3FSFXYhIeTiJkbCjrRYb9yyp6OJCd0vl/KrngMZEKymvpa9eZiipGu9VPR/mRF71TTH4z671rUrQxoK6I7DClVJ/52WnmwL8XnSclNhEMEGduU146N0y9vM1upYcHY0Vp1q2nFhVUhjpiT4Z54Ae8++aQhMSSpTIIQi+mHp2/i+PVMZAq5eC2HWXeYS3gjNrCDDw7DzsJNj23RCFtjoZyoUV/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xgavE+Qngi0lQtzohwL6zfz8vtyDWyBLLQYa+FsZ3M=;
 b=MxXI0VGChPbHUhK4o5Fi31fJNfzHTSnsssvRXNq9m/epXyDjRozT7MmVddyDwPTAxK951i/jhOr5IslVlDuljvbSXbL9HCmENelwPK/B3MiitMMX0sJbOpmRi7XGbbl5m2IUTk3M22L/HVLhvLnXp1g6vd2UCkBhlISps+voHCU=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:14 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::44) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:14 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:09 -0600
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
Subject: [PATCH v12 30/46] KVM: x86: Move lookup of indexed CPUID leafs to helper
Date:   Mon, 7 Mar 2022 15:33:40 -0600
Message-ID: <20220307213356.2797205-31-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f362ed2f-51c5-4644-6260-08da00825dca
X-MS-TrafficTypeDiagnostic: DM6PR12MB2619:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2619E1A6622E76DA671BFB43E5089@DM6PR12MB2619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kt2An9lWKwWf05/dhKZZQ6Kyq0L577z8/qBmVsbSvYCARHhEgPFT1QXBXDthTXDpKKHcdpaN2KNgy272guLpdf3PjX56T+mLxfn9H+2R59Tt9qBcudCrI/HjLSmCDNKzDl7VPpAAYf1kALQkHUobVvgiy0LizW5JLJtxgjfvEJVy03lJvoajoX7Xm6OAYBaBqY4mbSyAtYvhVhQmfmEVLkrTkRpM51OLuEcpaOBavPrjR0xHpAyoSrnGojb4iCf6FyMLS57O2ABK5OpiSY/b7V9UBB5szE36qbVdeWS1i5XK00tBqMYxQWEFLOzQZfvk6Sh/1s0gxFciiwXYC4Mc9ZHaH6akDYEmXjtH9lr3JoyUKyxtZ+6LpKzl5n0R427GZpU4imrdDQAgESxy7vlXgvDk6NHZgdv72/0/hxe61f0YK4Kj8Vadhz/pxmC1AV+WTbEuVB3gdYZZTlMwcg5S28i3ATpVHFu9tRZk1HQPAtI2lUQyJjghjA999MqWaNfxk8au81b8FIQIhSQv0gz6IbxyhMWo5eFl0xb9XJzOCDNQbhUAe++zf2BbFhkSbpmwjU/fmZEMJbCcdEgWQTaANWbVGxl4SPQltrGD0ZaEg6R8wu4q2bvGIJJo8Ne4ab9ipdjgs0EmVxalGJTJaAWZcCZjaD+dY87W21DvGM7ITtCFoTVxYVQgVMMi1qQUOSyU6BtAL3OBsTkn3c/sMBQfCsu7MYD01kxCTBGCP7ZJQEE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(36860700001)(36756003)(7696005)(2616005)(83380400001)(2906002)(7406005)(7416002)(5660300002)(40460700003)(316002)(26005)(54906003)(82310400004)(8936002)(81166007)(70206006)(70586007)(44832011)(336012)(426003)(356005)(86362001)(186003)(1076003)(6666004)(16526019)(8676002)(4326008)(110136005)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:14.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f362ed2f-51c5-4644-6260-08da00825dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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
index 8bf541b24b4b..848ad1723fae 100644
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
@@ -722,24 +723,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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

