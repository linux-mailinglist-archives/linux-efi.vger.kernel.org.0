Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C673BEE4B
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGGSUC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:20:02 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232136AbhGGSTe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHdhl9ptc/8r1x5fIIkIsryWS7GfKLbKbTs6iVWLP9pNE6+ISTqWtBSpH4NiHiZ6PgoZc64t7YRg7Zr487tuIJKQNl/w0pQNgUUJ6jMaX3IWcNJCxnsiXWGa/GptbI6788JdM6MfSLgYQLzs2sv1rDNytE3nju8GYBmAk1Cn4UkAsXV1ArWWDz3fEfu7jT27ZK34Jvnnesr6w8GcS+KGuawSaCczlZBao8Lt7CkShyQTpD+G4qCmJg6MY1H50q65iLTgiDVNyKhJpAn3bLCnn5RvdyIxOAdl3knJxN8OECvDLfr4o0ThSmNHuEswvYoki0Q9vLHOVIzL86gD7x6NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx2WDBdjGaBF/g6x3agK+7pQ+o9Ag8h7WcyLfaEPrfQ=;
 b=GiGE7epdlK9IW5SQWb3Ar4TR88+QZV2vmtu5CL6UiWHFhtKdjc/27yS1BQCdEDbqeteYq1dGNN2GSIFI+H3LFmnovRLirhc9gIn6n6NgIfvP65FpuNFpyNuqJp6u3MqTEeN0RLfuLwBQAAzCkSfZAUsKk5UMoj2e+H61ujfMB2jcYAf+e6YhveuusUg33dgf7+OoezcnH45WwIbZbOembhZxWXld7iF+quRJY9QCh8bpwFQdoFaq052T8xQxQHkqSP25fT+LScpuBKu56MnOf7AzTRmfYjQKxUcHQ2suSufGgWAcMNcSAkeR/txSzYCm5K6/vcWjhF8TImkPZB4feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx2WDBdjGaBF/g6x3agK+7pQ+o9Ag8h7WcyLfaEPrfQ=;
 b=NjOBBCtyjfX4X0LsD7Mdc2VDsL9qsplL74aaFOahWim2QmQZEesyE1UXDMxLg4WzpXehf6gd7O+xIA7CWzTVHLljuDpaIfD+oMevb9/Ry9lHLpmhVHmTWCnzpv0xKtell9fyXxowX4elwwWyaV/AchBSFCUNpbib5VNuhKsSMBw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:22 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:22 +0000
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
Subject: [PATCH Part1 RFC v4 21/36] x86/head/64: set up a startup %gs for stack protector
Date:   Wed,  7 Jul 2021 13:14:51 -0500
Message-Id: <20210707181506.30489-22-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a99c028e-c169-415f-c418-08d94173533b
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB50162CFD6BBDB3AA0D9C8D52E51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtGAYpi3IPs5rPY1/y/t4LiGBmh5rbAIfJG4NHbXRzT5XD/E+n4pGPO6mDXg8dJqTMnUFDhOxGq15wBX36JWXpIy6v9VEsvnWSL59mwQ8LwTuBn+3ufhUvxiUn/xuIBf9MEccUM76pKjOGUf21WnM9NaJyJUoYxJNaZEBK/iT013Ur2cIfoQ8fWKs9nZZuPHivw5P6U4a6G/z9pAUvs3FzGF58AIZ69oDx2m/X5n0Ee8XvIhPr2IX22FYR6nVp0gYVymg41/fP9nUTEaOMkmO6XxCPmzarT5HRnymD+SnVfpp189IBmsxl+G/loWzqivUYKGrjoikaN+DvGtOgcd5/6JiQyjakQOxGvO4fifrlwz9UMDVDOi6wh2jRt04lQKfV7QShs5RmmHeiJMKkarY0J5plTw4yEXZB1lCgF0ruJ444H5CsalossixGtmGmeieTF0mYtEXCCGEup0G2YWvajfK6mc7lERH0kEucB2QeMdAoWRnedCDKquDsKCPmNtG+GJMznBhig5l8APvS+mSkSMbBs7nsn56HkccGf4I1ccZ4H+YJZygCOM2jiwg7uPJZqEj3Gi95dOoHP0gam1jOH50rnHfY3oeBG1AM4VR1r4t589AI3L84+YoHYFYiubVVDPqdod/rC7+jqPpD9p1yPtvc4GVD6fAUSrCAtyjFxXMktU8ty1hABqKTlnGgG7CXcieG9wb4S5lR0cdfZkfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N87hNKigKyD5zHjB1BXm9lUrGOXkKm1SPKK8w6EG5HTFOJJ9ulyiSJ5WK7+Q?=
 =?us-ascii?Q?7s46GfJTxehXrBAqk9q354l4DZNIDRLjxcnqG3NnLZRYV6+SeKypQfAQ/Ets?=
 =?us-ascii?Q?KYZ71gdH2ZqskPI95Lp17ZqlR1pIsCewtm6ogxQFtYZbpNSqGrNU1iN2paFL?=
 =?us-ascii?Q?3VnsyqSmvFxl0GTGnC7QK6SCmqsurSpnaxEfZwBfyV5fo7Xz0VfNOW+Xc3LL?=
 =?us-ascii?Q?lDx8MJ8TqJCQc674VLz2w6vbmLkNL9YlUWvk11cIK2L4tpt5V66wpdPNoul+?=
 =?us-ascii?Q?+0R/eSdr6dBFJoR5p5/YkqflK4nNIRufok2MeWWwG7Eap+DtuUo8+z69soCA?=
 =?us-ascii?Q?I+74QkQ/pafw2DQADdAxV6f41iFU0vkqxAhJAQnOaO6ckOTe/AFBdgNj/K17?=
 =?us-ascii?Q?pznGV99P+ynu4m9/zDzL9hpz/Anwrw7OjfGSoUjKgx599uuMvtYCOQp7Q6SO?=
 =?us-ascii?Q?CdFR5Hhxztwl5GixP0qDWty1CJPpV8qi5zp4yIcCFCwDSiAbr7gM/Di13ddA?=
 =?us-ascii?Q?PFU2VE2Ci2gAGnSKh4XIqxohWIhrzg21Ci4DVZg04+vX2+M9gM2oPO/cT1t0?=
 =?us-ascii?Q?OZJpbCkhiqZpygGIY8RW5SbgRUdt6iU+jBS6LUoa+Djm+F3ssh0a3P/bt1UK?=
 =?us-ascii?Q?DRWRWzjQ7l5zpszxdy8cC5i/sCI0q/Rw2mnX7wAGG+uk0YKoHqurIrZhtLvo?=
 =?us-ascii?Q?JGsRtGAlHP7/cHmteODhkbOfayp+oPKQKuG6ag1gHdYLBXLy4vkVF/C+fz+5?=
 =?us-ascii?Q?qiDJU8hSJB9qcWZ99Ldp+XAGdaW65RPnTAwP9obIfl64g+EeU/k+mbu6GOFg?=
 =?us-ascii?Q?8bKgdw+Mz+2y13U+PE4DlstPp+xb9FykHIH/20ksHzknXSQ6tNY6JkE2vuXl?=
 =?us-ascii?Q?771eFNZ4QtDAFxd5Gn5CQwHn7DD6OLfvUy9A+I+vNywFU8bwximX443hETU3?=
 =?us-ascii?Q?K3QN18kHCAEjjwkIilxKKGe3KDxi9iaWjqB6/4aJY1Pxy2y1hHdMmjJcpuiK?=
 =?us-ascii?Q?ihEErktexSt+eFgPU0ldP2QSbbU3CW7ej34P2rzZ9iSbJCPXqrd1LQXMl8at?=
 =?us-ascii?Q?8L+tFGDspVnA7WumACAQmi31AlOAurdw4t2PPy6t0cmcewBz70gUwg83Ld8G?=
 =?us-ascii?Q?57UsOhEGSFulVPPzxCmCL6tqee6ADUNUk3QpQ5zzCW//idIcjeRKk/Jp5BXx?=
 =?us-ascii?Q?QG4AKoMKP+GuIzu+bAFfGxUCo+8WJ170Ry9/UlWIKM9F5NHnZ0n1j6wx8hEr?=
 =?us-ascii?Q?4B/x6BozK0lu7Ki+0tLi/VO6qqloqTC2OiHT4AeOAu7UGfY2nMpbBCCsnh0s?=
 =?us-ascii?Q?RfpWofCDYtBAKo3TcS0jSwdj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99c028e-c169-415f-c418-08d94173533b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:22.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9S9IF+jTOfvYLIhDNYYsKdOB10i8nOu8Ua0mTsH02HBgyuWahmBl8n/r06L2Bj3xVHsP11iB+0S6SZaqrhcnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
to allow a call to set_bringup_idt_handler(), which would otherwise
have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
sufficient for that case, this will still cause issues if we attempt to
call out to any external functions that were compiled with stack
protection enabled that in-turn make stack-protected calls, or if the
exception handlers set up by set_bringup_idt_handler() make calls to
stack-protected functions.

Subsequent patches for SEV-SNP CPUID validation support will introduce
both such cases. Attempting to disable stack protection for everything
in scope to address that is prohibitive since much of the code, like
SEV-ES #VC handler, is shared code that remains in use after boot and
could benefit from having stack protection enabled. Attempting to inline
calls is brittle and can quickly balloon out to library/helper code
where that's not really an option.

Instead, set up %gs to point a buffer that stack protector can use for
canary values when needed.

In doing so, it's likely we can stop using -no-stack-protector for
head64.c, but that hasn't been tested yet, and head32.c would need a
similar solution to be safe, so that is left as a potential follow-up.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f4c3e632345a..8615418f98f1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -74,6 +74,9 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
 };
 
+/* For use by stack protector code before switching to virtual addresses */
+static char startup_gs_area[64];
+
 /*
  * Address needs to be set at runtime because it references the startup_gdt
  * while the kernel still uses a direct mapping.
@@ -598,6 +601,8 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_env(unsigned long physbase)
 {
+	u64 gs_area = (u64)fixup_pointer(startup_gs_area, physbase);
+
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
@@ -605,7 +610,18 @@ void __head startup_64_setup_env(unsigned long physbase)
 	/* New GDT is live - reload data segment registers */
 	asm volatile("movl %%eax, %%ds\n"
 		     "movl %%eax, %%ss\n"
-		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+		     "movl %%eax, %%es\n"
+		     "movl %%eax, %%gs\n" : : "a"(__KERNEL_DS) : "memory");
+
+	/*
+	 * GCC stack protection needs a place to store canary values. The
+	 * default is %gs:0x28, which is what the kernel currently uses.
+	 * Point GS base to a buffer that can be used for this purpose.
+	 * Note that newer GCCs now allow this location to be configured,
+	 * so if we change from the default in the future we need to ensure
+	 * that this buffer overlaps whatever address ends up being used.
+	 */
+	native_wrmsr(MSR_GS_BASE, gs_area, gs_area >> 32);
 
 	startup_64_load_idt(physbase);
 }
-- 
2.17.1

