Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53C3BEEE7
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhGGSkO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:14 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231785AbhGGSkN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdLcZ8d2I+2L57X3p6s6IcOvCzViNPVOcIJvQkRp7czep+96hHUAM6RM/RInpOuO7MZhXaMWnxApIqQSOpNHpUp2JhT2ZqApt65ksVjkvY4o0vOBZxp8QEr8GglnZMtT5yyA4eAy5vkMdGs3rOouvMSyrUldy6srOhuFLwLI2ARPYW1StMAhRcNV3H+ZEq3S9luiCAYp9q3Z3kFnMqJ3VOKXs4b0PGmShHy9+EwTLF0AC8l6YFph7pR5QWsuwX/QYuY8GyeuiywSPVbulQ8r8zwDnkKpRNWkUhJxpTijWghOvLTs665JlzsY08QfQYFp+PnG1oLOSlYk9v3zw6hjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IpMdpyuUJv/iUkp9gcvE2Lk8D0OpiJS+R9aTNr+fEg=;
 b=c/PVjFkLpjr2UmlXwMUsI5oDYix4Qrg6F8p9VuVmfVCDBW8xctjM5Z9vKh5z+fR6U/H1j6agbfunXi+LlERBQ8TqIO8VA1f/Ki0bt/fWGjPyIU1vxxSNpHztZJfuCoIiX0kM66nByVnat0Z6Uzx7TKYTOb9RuYcgK+maIBIIbUy4WMZ/GaDyLtRj+lit9YU1WUuj+ET3SwIMhBK23WEDc2gXJeMUZYMQvB6QsfLWMVcN/SiSxH4o/hqY12zGqAmdxnI+RKFeew3Z9HKGy1ZHrIb0JUwYujdIPid9SAMGpz+ogkNH4NJWc3R2DQbc/Vy0nt4h77LMSdxSmc85vbx/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IpMdpyuUJv/iUkp9gcvE2Lk8D0OpiJS+R9aTNr+fEg=;
 b=BryJYEUoMaohkLrKPTCmBK1pNjznyuO5EfGqsnh0ocBL1OPLh7wT69J5+6FIm0F00nnEtFEUiERl4DVXZ9TXh3hY0hyTi/Bz6hS2QxbO/I98dlksudMUj4ALZhBrOVfBsTHJj4odYsVFZl2hJl7+n/pR4ZeP0Vp1We3DvdfJR/w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:15 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:15 +0000
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
Subject: [PATCH Part2 RFC v4 08/40] x86/traps: Define RMP violation #PF error code
Date:   Wed,  7 Jul 2021 13:35:44 -0500
Message-Id: <20210707183616.5620-9-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8b16327-605e-4cba-bf02-08d941763dce
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28086ED31CE042723D7BB6D5E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TVCAW8mJFhixsEWZ7qip/8kalJp5NzmW11frHzru3B2Dp12qvXc6F+DISAhArwO4GaxhgcqsSlAibc0fVpnF3V8OdVfqKWRmGOPr6k+ZaKzFNYjRpiC4veKgNUBfTUYHPNq2gCtlgKZE59sWSWnvTd+S/qItqlbipYGOCxauWfV2i3mjNz7LQGT7epQZVb7mpDpL64jknoldphGWUUXEFyIYhz9OPYERjXPWv6ENA83T3ZIJBoB3MZWkW1mXisVdompo7qKIuoT3lerKSc+NIdzxvKNn6OjK2NwazmOotSWNvYknowILmad+hNO+Z9kp8/0P03uaQ6cJL7BVE9podwVdfQiQA8TA1EuR+0CZTs8Hsii+wKk0xqWj7YPdf9NQhXJfVK/pVmyMeNyGA8jsnZKAUDgyCLNRfvt56VWQNt3e2kozC/TasnnQGTAbAN22tALfyzeIoFn/GO461u5c/bSWHPZsJM2q9Q5w4DRXg+59HlWwVqLRlaydHOGxfETDVk9ulYuIFEMTpjLuy/7q69igUjCGOCG/spSA6YK0Bwsbx7cMgdse34CdM5MboMCdoL5NqZwIwaoMkBbVn8PNGQIS4kJ+AliSzX9mSEkgz7Qz7wzp7XdyeYFDZK/VRh+/uaL/2ZDbYsFjWLtUGIzz36ZD9bO9nZl2pWw42FRjjZWXwEaVbXR4oceooTqngEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdyh7sBb/cS1c4r44HyT/ONOzqq8PSKrETLgJhO4NbjtznvbZMTHRLhYvkwJ?=
 =?us-ascii?Q?hvXpFa5TGmV1E/Uv5OnkvrsVBPTH9vwosOqAwIKzN3YZULH8A8+EzpNR0fzc?=
 =?us-ascii?Q?IpLxAO/AkK4QvNxvHWzWvZ2N9Xk0/DFG7/zC0auVuW7cth/XpQmdZfFBmXhI?=
 =?us-ascii?Q?pCds/YbJ14W8VKrIJ9wXOQYsdbl61kDolbki/9t7cHBy8FxnA4YWdFUleuR0?=
 =?us-ascii?Q?a3fOGbdPURdSZMMrpDCoORrD3HtkNWGAFk3glOXzb9d/sYhxs528eDX6gkDF?=
 =?us-ascii?Q?9yIJ+zp6koYmwnajPltfIgIUOUGwzRi4K/pV9z4da4/azpNCDoK5DTqS7j+c?=
 =?us-ascii?Q?ipvLU5jIpReFQ8lRZcadYRyVlMkHHwlmgMBgWnnRx8EZmAz1Tw+88rkXpmqf?=
 =?us-ascii?Q?45bTpwaWuHkxmOSUIY/iEppHkxZ5ltNrwOC6ygsZXfZ1FEdUFmo9tQ1rWZ99?=
 =?us-ascii?Q?rKHflPxiVDQUM17qGf16xCbCY/78R697hEtcRGavqZxlWTod8O1dEewu6Sxu?=
 =?us-ascii?Q?OFR2DHps0RqnLTI9Ri0bY7NHULqlsx3+VG8WevFZEu0TI/rDzg21PAB+z0ln?=
 =?us-ascii?Q?as5m7yrdVtN6qDXaSr7DjA1Qpwb2yP5/grmGROjlXvh2yl/etWpcsWaKKvBI?=
 =?us-ascii?Q?Nqz1rP4ryqTYf0DEpwZrp7iCy+nQ+jUX1t7Xnu/syc/uo1KG5Ng6PCWNYQ8K?=
 =?us-ascii?Q?AcK/Jszmj8Qbm906dcdX2AskY6pNWIj27eb08+AQy06UVqUAKRWCNSN5AEx6?=
 =?us-ascii?Q?e2Kh0aAqaJEx12voTCV89jiPBSVN1jm5Dbd967c+NN4tGS2AWjYfq8+hzZN3?=
 =?us-ascii?Q?QUYzUylnYpbxNLK9IOMrlOBwv7BE5zKn0mNs4J5IIMubhxehSO38LRAm+cey?=
 =?us-ascii?Q?67uKL54d1g4SUbNNJUXNcE+mi2x74PMKN0AkgaevylHf/Z/H5ikdmXXG7zDY?=
 =?us-ascii?Q?8nz/ynPaN/VNtFPJwi/i2dkT4GPMlz9EE+J3cGqD3nlGa2lZFTOJGi2cgE8C?=
 =?us-ascii?Q?PVGcTtnOvJ39iQXyZLxqLVV0aNwyubp3KUa399aw/D6IXhnvd/7wuicA/qBq?=
 =?us-ascii?Q?7nhTQQ/D2prMqgea0qHipBDGv/jA/6XrQY+UzA1TaD5QxQWStbm2L36txayQ?=
 =?us-ascii?Q?rGDBeACtnuSaZEy6RxfMo26qsika0svphuWNtxPNDmstn4JqEUys4KB6o3X2?=
 =?us-ascii?Q?BVFj7ddI3w7C7qwBwyoWcelVI44U5I3I9IOEsT5MaGoHvrug6LN6s97EO5Nb?=
 =?us-ascii?Q?kh/RuuultAv5c2ypIIEVeK6QuTs5X5JXisvu6ERRE+gBQ0gaX+u8KKtf3ZSt?=
 =?us-ascii?Q?+58UU4ZPL4SWmtOS9xa0SZA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b16327-605e-4cba-bf02-08d941763dce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:15.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgRyfCiHafadZfOBrWI9lR3igvVDlpE4spvs2AEYxamcqBhsZ/XjmSt/4Tdm8p00EjZd4ruE9hfr/hcBvmp0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bit 31 in the page fault-error bit will be set when processor encounters
an RMP violation.

While at it, use the BIT() macro.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/trap_pf.h | 18 +++++++++++-------
 arch/x86/mm/fault.c            |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
index 10b1de500ab1..29f678701753 100644
--- a/arch/x86/include/asm/trap_pf.h
+++ b/arch/x86/include/asm/trap_pf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_TRAP_PF_H
 #define _ASM_X86_TRAP_PF_H
 
+#include <vdso/bits.h>  /* BIT() macro */
+
 /*
  * Page fault error code bits:
  *
@@ -12,15 +14,17 @@
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
  *   bit 15 ==				1: SGX MMU page-fault
+ *   bit 31 ==				1: fault was an RMP violation
  */
 enum x86_pf_error_code {
-	X86_PF_PROT	=		1 << 0,
-	X86_PF_WRITE	=		1 << 1,
-	X86_PF_USER	=		1 << 2,
-	X86_PF_RSVD	=		1 << 3,
-	X86_PF_INSTR	=		1 << 4,
-	X86_PF_PK	=		1 << 5,
-	X86_PF_SGX	=		1 << 15,
+	X86_PF_PROT	=		BIT(0),
+	X86_PF_WRITE	=		BIT(1),
+	X86_PF_USER	=		BIT(2),
+	X86_PF_RSVD	=		BIT(3),
+	X86_PF_INSTR	=		BIT(4),
+	X86_PF_PK	=		BIT(5),
+	X86_PF_SGX	=		BIT(15),
+	X86_PF_RMP	=		BIT(31),
 };
 
 #endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1c548ad00752..2715240c757e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -545,6 +545,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 !(error_code & X86_PF_PROT) ? "not-present page" :
 		 (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
 		 (error_code & X86_PF_PK)    ? "protection keys violation" :
+		 (error_code & X86_PF_RMP)   ? "rmp violation" :
 					       "permissions violation");
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
-- 
2.17.1

