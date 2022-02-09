Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8816D4AF9A2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiBISOw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiBISN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:13:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE6C03544C;
        Wed,  9 Feb 2022 10:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTEQ5Myd+1gFRjW3N5RmO9EimsDq5SL7ICkorNdnCcfcPSQFWTsmlitNXFAd42wtueftrLFAupdrtYmLIGJnz3NbXXRIdLe7jUpxXw98KDElPAgfg47nkDiJSj16fuYPRTV5FxaDic5cdDGj6BynSgpJnpQVmDk3qgJ4GDBNrruJU7l3m9y0HuwVef9C+mctliQ03J1d5spHhk+niuXnWKB5TU4vvjSi1M29jrkX/E10H/I8nwbDhSqyEDXdDHCXTBPG59yUDiB3FuqynaERWGcaSOKenKhOPz6Ps0930jJmIZMEgUdkuzDq83umPl0R2EsaeaFLIaorQqica4TW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhquFhz5GxNpJnKdCRbrCYJnQ8UADlx/TmtodjSUKE8=;
 b=aqVUe7dEKB3WvjL647o+yWJkzbkxTY7xurbAsfrTHHGf1T0fW6r4Nbs4WIxuLPz7k89EFV/cFMtGnf9Gme9qidzo2rbHnYqJKTRPijq9a6BsV/Z1hutsLAbU6jvwsyVd2ZzPo+MV+J66jTRpw06ksrVzzU8svsRMl2W0XCo8QzB2Afpnv+znhjy4uZhFKPJ2sSI2v2Y4XP9g1pZ0U6EkfSA01xcPf7YL0EDOsCr9aewJq3ZRhH/stBhP/qs3E4OIB4gFTcZNfta1I+rr0B+rg3jBfl5To88GZ1xdhQ9Lzvx7CcMFIjDGpZQiRMp56JJI1iypvBhG3XAObKzg8yvUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhquFhz5GxNpJnKdCRbrCYJnQ8UADlx/TmtodjSUKE8=;
 b=Bvo3yzvTy3nyqmO/2Q8+kGSXi3Jc9qM8BCQBwhcQc6aUDgOoqJBjgs0JCPGGYlAFlPFgy+E8bMPqlRO/vvDItvxwr1WEeIzAARpnQTJaA83W4f5sMOATJldOkLCV2hbyu2yn9bgkzTluD89Ux4222aX5jAhlgoxatTg91eECfi4=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:12:22 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::2e) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:17 -0600
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
Subject: [PATCH v10 30/45] KVM: x86: Move lookup of indexed CPUID leafs to helper
Date:   Wed, 9 Feb 2022 12:10:24 -0600
Message-ID: <20220209181039.1262882-31-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5219e5c-34b3-4151-c311-08d9ebf7b7ea
X-MS-TrafficTypeDiagnostic: BY5PR12MB5510:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55108FFE14256E3F596241EEE52E9@BY5PR12MB5510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc5p9o+Z9PnPLi58SfYksrIHlLx0b+mQ/Kt98IxPk26p7INooH6MYO/btoj+PfAvTSrFDqjQ+f9Ybxx6KfL8/1ScDTiNoAKtLZiehFKVyr/I7O9gPLLxexjqIXwU49LMZjncfpcZYtVjkudAt9OmFrw6rqFA56GOaU4OFbOEXwFzuSrJiCP6QoHSBx5/rWh36aMAV3pcy/cUR6HtMcQhUl6zBVHqO+2dv5ngqV93woA6mTayBu0HFgihdJtZxY2sRCYGgI2xZEyq/N9HQ8Pz59i/f5rP6HqOrp1m8xTgK6c2KN84aEc1ulDp+ihrKGA16BLW5hQ4LiIpnA0tJH/9wTNqLR5Ky21Moc+C/1xSr5Ji6NBSrsu1HTOwq+PqAiwneSyfQKP7NwsQ8J/08/KkwaJz2uHtbD4WGehAMoSmdD1ud7IYWp9IKb1hx2p+Cu05npwkjMEHC2LvxKp71Pk7S1AZMHOPpVlITCG5s4Gc2yStrGA3DLlDPFUWi7BXPkcXmcfDydPV2REmtl1kWBzNaMBDWFzi25wSVFnYQ6oFc+Tha3ksPGHt7vnZVUz80Rh6rdoyB3O+QupNH6s0zto6Xv9+/j7Pyyljn76anDcO0LwqqV29JMynC2koyX4E+qTYpufzREJEBA4asBS4urryqDt7ui9k2Ra8Kh2EkL+hxYoz/kJP8WEqHq5kXiSHRVR1GPkp/JoKAPHgDVUCoUCHkU6UP9s84CNfoOLfKgHSdTA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(54906003)(8936002)(356005)(2616005)(44832011)(16526019)(5660300002)(7416002)(7406005)(508600001)(36756003)(70586007)(316002)(81166007)(110136005)(70206006)(47076005)(86362001)(6666004)(36860700001)(82310400004)(40460700003)(2906002)(83380400001)(426003)(336012)(7696005)(1076003)(26005)(186003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:22.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5219e5c-34b3-4151-c311-08d9ebf7b7ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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

