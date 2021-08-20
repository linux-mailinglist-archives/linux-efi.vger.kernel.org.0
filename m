Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76F3F2F35
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhHTPX4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:56 -0400
Received: from mail-bn8nam08on2040.outbound.protection.outlook.com ([40.107.100.40]:2451
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241464AbhHTPWx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBAGl7AwNfI+GiEzUPB3q9/EnbHQAS2X9pYnfY6j76dj2ieE/q6iWKTzWMIqi8UNA+4belGjt8/VyWLJP/8+5tzc/MkmBJvpxt2PDSPtDJuiQp3HF3ML6el5Rc3hHAT69btrcvXO7MRAdypbHhsjyyKxvJ4OpUA20glNgZ+dvtZsCpGoqhREpLo7AaFip7QZBR5UmGYxeE9smg1B1Xcm3YsKDmMHor1Nue2XflUJUemOnIDdgAorGfUHRk9bZoZ8g3/WJjKXrx7dMScLLoOac/3awQded9tQUwTZHhvOGH35OOYqxzm0QqEquOStYFVFwBameN1biOkcH0D68/S6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Leho8Jmkv5yLql5LB5x4IW1bbgPiHRPzBpGLROjWfHc=;
 b=oRqaMYPvlcGRGe85PPSSO5lhaaCXfNc9PiQi8lGCMAM/0CVClnn/ZJdGbyncnfV1heyMvzmSqAEP8UHkZhPH4UfIJoqMshLEkCPnPoQRourqXGwjPpHKNqasnHZQcofTdAm7XVyKHyzLnHH94PPxwabByH+VnD+U+4xQAjkTxW9B+JFwvJpbIJQYffPZEb5rlLBCUvruLWxI4E/Ex12CWv3fqpwRX8ujftTe+BmXDa0+Jwz2T0Wskx/6WXHsEDWKPhWbnTQCWSSOBAHeSXCb83Qugny0sbt/JYUQ+E/9niBtkoO2yZupUAaGFF1XNxOtV9Y4N0NWAMPsDzxiDdlzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Leho8Jmkv5yLql5LB5x4IW1bbgPiHRPzBpGLROjWfHc=;
 b=MeOFTVnfWalVA5MSID8xxswBtMV6NQIBSQA7JbsfNAsB4AcEssW6rlZdLPmDrVe7oDP2cQN6aFbG6PBhDK0LllJNTQv3GXd0lzg2Rzh0wAUd2/8pqaTdLqhj3m7iAoPevrhNRBTWxqND+xvZvxzE+YWK7af5UtL1tE9fcgWLCwM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:20 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:20 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 25/38] KVM: x86: move lookup of indexed CPUID leafs to helper
Date:   Fri, 20 Aug 2021 10:19:20 -0500
Message-Id: <20210820151933.22401-26-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87d552e6-b495-4996-3257-08d963ee2978
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45578B7DD682164A217D3934E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIRe7PU1d0CLqbUOpp0gBMy4UIEHppyrODbISf9rqmXcY/n6v846cGcFhAgdq0eWgyseTszsUjASozOCAzJYhaynwmlugqcH2smk3WXy+eabDrczy0ZeaU74p3ivwACUy12cWd3t8TIv+18N1nEBQAHIVfYlS+6j5877CnqRwhN8kJ0vtSZStj3jZcRzRLGXhB1ZLDF+q99sT6S3nUcHwrO7zsGHR3Jl2dmeh0vLKtHlxhYMK+asjyjw5UTnVYY2eGh3ZAshsXtyeI0BOMi9FMb15+WUwmxU7CvPFNJKkmmOUkCE2FxNxGHr1EhQQLDafep+fnFIlr/4kq/65rbXO2dFBoROwjRIFwZtPJu2SxDx7umjtgmvfBJ3cH7sJHOlieIAjojFgNazvQtQaEgnzgDAW0KiJhw9OyHS9H1Ev1Ga/a4wfga1jkqFL+xmYWJRAY9GH89S9FOXd+1u19ysYgMxej0OdKO7tkspZsunSYWJAmuQfMollarYy6I9g2ou9dJN00lhsY9MAUgJ3G2rqcdgYyy7yYkPRWKoOCSf1zrlY/QB1a/7SGesFBrcRAyYQIoNLiDSf2D3xSKIvrhmGUw89ovTGqXXUja4ffpe55K1butM+oFDVthD6+ucS/Hbx6lvzanMUPln8HvqUHYlfRmGyzZGqitYfmx+uji+fw0VnfJ2BHUFvX9aGKdNHsznjAsDzU0kDK3fSLbVbfZrww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(6666004)(36756003)(186003)(316002)(8936002)(2906002)(83380400001)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFGDeabkwHdw9A5ABB0Lam0EFgog80Qo729/bzQ4ZL9J39S4tnphfykg68Yg?=
 =?us-ascii?Q?htgrAxD20ehskg2Q0DTeZBjO6H8CKLEPg3GYthKLAhi85RR6sAr0nntpe35g?=
 =?us-ascii?Q?DOyPxsDhv62x1rP3rTI0DcVg3MpkCDWBd/dVnDZnwmtEHZEd/DjkVjV9Hq6k?=
 =?us-ascii?Q?10x6iS/8l41NHvUzhwsjKWz5ycOAutSlwp9ALGMiT7mzw23H6tPhLd4LCX5D?=
 =?us-ascii?Q?F7/jdLj/l4Bvh8UQqiLG8pw6n0irW1a9IT/erPVmTWxISYxdm491AwmvkLBT?=
 =?us-ascii?Q?aOGUT1po8bSQyOhLZl53AKkX8oyrkWahhM4tFfR/O4mJDzkuVMFSNo98ZEi6?=
 =?us-ascii?Q?AZZvZ6LxoINm8+EwVf3zhjJBrPAdwnlokYVkifmSeFH/+6Z6NpbjtfIQqwxd?=
 =?us-ascii?Q?wug9/xPNHPEL2thUPi4/o88G5U0nsCjxCRnFjqnbiz0s/nY11zd2YkyTIo/k?=
 =?us-ascii?Q?7qD7axzYn2Spma6h2zkjb1bPU1La2VW6QEHS2RLeiLhEye3mDk2mmNJa2VVi?=
 =?us-ascii?Q?tajqeXwAcRSY3JODMPTWSZOgkXHznERILjqrti00qow244lPv23yoQGbrX1H?=
 =?us-ascii?Q?Xa/00SfdecN3GHR/E8TXw1Ib4WGvrO9YuEivrmGbDw3i/dH8otf7vo5h+sw/?=
 =?us-ascii?Q?GXkg/UaoeE6+yYgPridq3xiRRJghbKwj6cmmpJ6xfw+RvgYMzWqShicDNnoE?=
 =?us-ascii?Q?KcAtE8DYFLZIaeXS1WgUYDNv9FBtVC7bWzorxKrzjEgbW2s9MA06WLaXP5Lm?=
 =?us-ascii?Q?3Ggc3NdLw9XIKQ5/5wGi+abB+KPw8q9uN5E+rStzBi0CcxXIRIYetvzuVpcS?=
 =?us-ascii?Q?y5TiGDn6i+Bn5PkqNBJ3lZMchTo3gbV9yu1mtyM0dyPjf2peZPraycj8HFsG?=
 =?us-ascii?Q?QvLSF73Wa1t20y5ilClRNdQ/TdYzUiUH7yJk+1J3630MA8PN/LEzfXkUoBXZ?=
 =?us-ascii?Q?cBAzX/i7+r8hFkeYdRYCS2tzNgLoyvEj3YUJwB+qmE5ji8kOn5PFjTgBKOhe?=
 =?us-ascii?Q?0G5Kv7gV78xbrb/hx3xhADwgGfhT24tdscbWmTmA+JjwSwuniznkZ3Ha88y3?=
 =?us-ascii?Q?SbpxaHYijpGYZwFMMURf+U0lQML58PY5oRAul1pP9Bj51wsOHPGTi3rIB/Sn?=
 =?us-ascii?Q?osL9yPT6t2hpXiFtn7Vpb1EiaXab+AOmkxpmAm91P0bJ9HuDNRUHm8oPKZhu?=
 =?us-ascii?Q?q0yXj32SghYDm5SiI1azZkXuP5rUG2Rx6Y0QcRFZaMK59EXhyHii9HIkGFXw?=
 =?us-ascii?Q?t4s2y6eFO42qR9g7RTii031bba+VjbES1d6uepvN/0ibCbgWyyaIpU2YEteh?=
 =?us-ascii?Q?rTnVxbpRQXONhc8eYfTQalfo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d552e6-b495-4996-3257-08d963ee2978
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:20.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpsMZ7O858Qb73Pq8Z0sYXXfjFVba7wwe02KcVOOgvLiHTjlZHIjnK+C11mF1spvnoQ7Ctv3mqVAEKiHPZaPlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
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
index 739be5da3bca..9ef13775f29e 100644
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

