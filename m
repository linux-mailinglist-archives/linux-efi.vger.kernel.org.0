Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2423BEE64
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhGGSUf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:35 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232095AbhGGSTs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9FNbJYFh71t8bSuyST1dkbNhxLsA31gRZUCqfpEZ/kz99VTsunWMfuoID3qaf2M0kRUIX9Dv+XR57is9EtU9wDyyczFQaWgPfSJAy0kViueB/ORm/2RfylOrrxqYvpwZgP8w4qpjzpMtdmqpskyglVYbXk8COzfPQ494eqFoH8pB97PuvigvTeh9uMBzD/btgsRkwJ/lLUoOmp+beMbQALbgIlb9d+JY1eBN9muvyTPmMzFu8FufS3oUDWu+K2SgzzAgtoyd+3F91xYuJL0gEEdV+4mzB7D+osUnI2XrGpEqXl0r0MUmLVzvnIa9fZDcV/2U0ngtJoRe4vtUitJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBU5NjKVuUubgJqFZUVr/Woemez+mkT4i2hl+Sgn2jg=;
 b=idvRn870tbm2jaRmmm0O8yc+xcvsGVzMjnb4FiHIvyy+bMZ6FepyrN0YzL1fOfp+PhNGy93LWeV5slBXSP2S8Tmraxt/2jmRbu1BgMeEZ451OiFTgfQZ2zTS1y+SlMAInaSW4Of0uWnIkdyPoH6B2stjz18kGmv3mEuvObX9ngRsJi7JhllZA76INtuvoV4fR4jZmEM0dXcfXvEb+E/l2dFyPPq/SvVfSfJBQB4YLvHncrkx8PoH6RqsNVlMcwG890Pbsx7Evf1N1ezk6UHdwq3BcUsTa6TCcC7vMaD8XHnCQEFHOsyArtiWQDcTdLTIw/aU3IltL23BedTJ4GxCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBU5NjKVuUubgJqFZUVr/Woemez+mkT4i2hl+Sgn2jg=;
 b=wPdyUSavU9XuskIMzq6jAj9GSQM7SV27ESHy+9dYjbi9jXJjvlk0XBng6vT3YG6sVwQH0xwyo+cwg+wS3XLfR63PvnwlGx+xRpfG9dMVdYH4ytSEELknvmY+fBbF7qktjEBhxCPELsr3YV3h+2V2IjBU8SR/aUF/eBul7sliIf4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:28 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:27 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 23/36] KVM: x86: move lookup of indexed CPUID leafs to helper
Date:   Wed,  7 Jul 2021 13:14:53 -0500
Message-Id: <20210707181506.30489-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3611973b-3c3e-422f-543a-08d94173565b
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB501605ADEC238A0987879FCAE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsFimDqvzw6lvrhqepEGwsowY5lEme8sZXbuJMpEtnD4nyhx6iGUBpSQRrYSpB5uEaFr47v7ZHjIZnfC5lvTt4W2xD1UNf4KjQmi0XrmPBVUypjreJte/Zdt83o7Y9K0t6gC/CFYKMRFbfi4G5M5Zm5tvJI9QUK2hosbfvBQDEC/WdRlvzdp335uB3tAQ0ontI8I5BzPjLRBqAZ5UmYcpgp5SaAaHJay8+RH+bAThLNC4tQxnIVjFE0H1uZ6JPxPz3CiIeezuoyDasAqJ4KQvmW1O/agFDJbLtJLFWNl+8bglrhGZ6T0nr7h4Jy9fCW9lCWTEy5CtlifTOlCgYYnPY6kZ4TigVa1gF4OhOuEkaGb8cuN9PxYGapGfANeacK67xb9e8U8BDmcGcwHBZzMpKgbD4UkPOZftSZOBcpEIZMCRPEjVMJBW6RN9DPgJZGdSFRf4oW3sZhx1xLTI1zFbLSf36QCXbX73VGcW+CU/60j7I1jv5ATJVzPThrS7L8U8eATapZ+SnqpwMMzvwv0EbuOjX8A16zOz6wmI5LU+hr2+ZEkpIRf056jTemurYpe047hyXOY7OjrzLy/CE7d/VAMaD3u+BFVNi5N0km8NfFpmEtAhkuj88bIsKfHN4gNHMUGu/qujoZbnZ682Fn3+kzZJ/Z+w0DCdgCOGnc8XIFqnF1lHlRzpNDn4SRjp0fy8OpxPtDC76wI1kvcCkZ0tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTvbYX/w5rlXMROyhh0WxN1eEtT9qLSak5ILBDgsxbb0J/Haui/haENosXbK?=
 =?us-ascii?Q?20xf4jQ3k4B/EuA+e6m60izrSmpsSF82qgtYoiqGfuEIooCE0mMEY72LCpSL?=
 =?us-ascii?Q?D8MEgB8gkh0pq73FhM8Xbgm5RpDbtuzaRuUm0NvsmkJ43nnRSj8b+VsVqups?=
 =?us-ascii?Q?PquQAqiaTjVpyukQH2HpCwL2NKWjpz25AlTOWOcmlVi8NH+e5tUExyQhLXON?=
 =?us-ascii?Q?QGQBf9iSH+s8ddpLP1YmTDoBkIDvN0mjtLxWxTWymQPoIaqdeMmfVajm+nEo?=
 =?us-ascii?Q?6P2blyqyhCqehNFG3R8kHSvz8w7BIn1agT+xu6LQkKKcJuPBLneRarojnICa?=
 =?us-ascii?Q?jVJh07TtxWQw/aM/cfVNBbQygT9zCd7vOvXcuY39g6s136a3YNoe/mPQgc7/?=
 =?us-ascii?Q?CoX3Qrq7MM20Ze7724Z62BXR0kVsQOgTVy3xepV1LCC/v9uO++vogBUfkhW/?=
 =?us-ascii?Q?44UMFHPyJCytQX+rfXAHXelwfKISxGZY0rtCRcY+kz/jgcZeJ1CrcIkRqvmy?=
 =?us-ascii?Q?sgyz7M2WrLriDNyENmA3jAR81PSGblLQRLBqHVHD1knSNlciEvyT/fI5w+tN?=
 =?us-ascii?Q?p5CIAYtKoi+PkLttQbY1BSIYHVo8z5y+F+uuXSrJFM3KU2yCARarJ/ofdTZ0?=
 =?us-ascii?Q?T3V8xNHVC2akJpIX327d83uJGVryJ6uHxHuNItocUgLjOfE56NKFZKY0Apu4?=
 =?us-ascii?Q?0dC4HQeP0Mi4Oqv6sympKozzOC2ND2Upco+bKpW7UkU2puopFjLaos3kBX0P?=
 =?us-ascii?Q?oDHG7tz31OMyIBYj+wlcF/e4fMiK6TtDOe/X6dT5zgQ9kQl6nezTVGRoH9gm?=
 =?us-ascii?Q?pwu8/w1VDKm4zCsoLIqI2fo1Y0IuHjfBIGBEHHaUdjOFk1X7023VWSWzJf9e?=
 =?us-ascii?Q?TlLAPIbaRhx/AWOoHGfmdyPu+H1njMY6Wdx2suA8YrDtznDDqaw00NUxFdK+?=
 =?us-ascii?Q?rhdnoBEYa/qBSqi874WedveuP1iTnGysVXpd/Pcg+IbtR9SS6l/UNONyyVee?=
 =?us-ascii?Q?oNH/2LpKxYHp20SMzxfM+2LvLks0HuyPpEAiw+iWJJEPVc1JWRNIPYseicrm?=
 =?us-ascii?Q?xa1sHuM/+I8sGfwciFVwLn8qX8oaq0e3rdxINbTsDT13fz8nYYP1Zn5pLnA/?=
 =?us-ascii?Q?e7SIiBwCr2n1EwNogiu7oKKR8h06//KAg7kSN0zAxLKp57Y+fa2Z7Ykw3XgB?=
 =?us-ascii?Q?EaRQqSuMBuGBa2BqsPD/nJ4b0gcdd+RmzEGS/OJTSsuDbXlqz6vYdyjk9B5f?=
 =?us-ascii?Q?KsQ0RrRhnyPY3+aGMkau1JiKFdkz4NtHEUYKvAPyeGHUV53DM4QQ4J401dwI?=
 =?us-ascii?Q?RHRGPcNI/fgZQad3zLR2Hzka?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3611973b-3c3e-422f-543a-08d94173565b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:27.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZcr/bQyTEe2dwmNCkmvsWnL7NF+VoDmtY7ERwvDEcp4m3eE9vFE/ofNKGTeHO+UG78fAqoiL0ceaqlNyey4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
 arch/x86/include/asm/cpuid-indexed.h | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                 | 17 ++---------------
 2 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid-indexed.h

diff --git a/arch/x86/include/asm/cpuid-indexed.h b/arch/x86/include/asm/cpuid-indexed.h
new file mode 100644
index 000000000000..f5ab746f5712
--- /dev/null
+++ b/arch/x86/include/asm/cpuid-indexed.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_INDEXED_H
+#define _ASM_X86_CPUID_INDEXED_H
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
+#endif /* _ASM_X86_CPUID_INDEXED_H */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b4da665bb892..be6b226f50e4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/xstate.h>
 #include <asm/sgx.h>
+#include <asm/cpuid-indexed.h>
 #include "cpuid.h"
 #include "lapic.h"
 #include "mmu.h"
@@ -608,22 +609,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
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
2.17.1

