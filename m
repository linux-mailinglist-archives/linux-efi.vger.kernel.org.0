Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D23BEED3
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhGGSjx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:39:53 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231757AbhGGSjr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kch9wv30QMtytHz2t7FTGhitN2NwhDnORSfEgyvhl/Sv/pMVDdle8A6OvvzhzYQ2lvHkkul/GG+Jy//xG2ZvoiV2N5Jq+G7CdKeCR0b/CftvFLb1utxiZms4GtN5xhiYMJh5Wr1MdbasuMzgeC51z2d/GzeVcnzqcXsMTEShDG2OFmrJ7I39C7JBgRwauCm4eT+MvoqggegnG41nmr45/lPs7XXHq6TQ586X0R7PCPtPNetRzv82exIG280PtJNiFcvYNp4MkNO0XyubCWm8o+gghz3pScBiKhMeaRY6iUMmyrXSshfKrDDQmHEy6p5hEjuafSgJ2pDZ1vzh7TgqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7OcioCq+8o2r70L9N0hO5CldAYJzBAXRKvcHyOO4Vk=;
 b=QLiYleWKtWiQQsJUObi5MLibIPd5L+beqWPOnWk43blrz4/w/FbloVL93S5PfOyb7fj5/U/s2DnNjg3ynYkRCVXZRY7qGD04vQN464XdGNyyM03lAxDgtmd98B2qJ56NIhEGS8fERexfMopQJSXbnPdPanYd5K5D86B6vtYJT+doJUYFQOMYlwPIbAnyMZLgZWEWsRKDhA2F+dE+7m03AM75qYxG5tFGBwp+Wh2XUos/wOqdBcY+1ZGVPtj2ZuQQC/ntlSfW6lc5iA1p/qq+6CryoB+9TsQvmF8rF6wAy4E9X1CIZYzw66+v+Tx8sgbu3EDsmQtPs8HRQ7zpNiLUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7OcioCq+8o2r70L9N0hO5CldAYJzBAXRKvcHyOO4Vk=;
 b=4xTfMAYceWhSQiJKtFYbeTGjtFKQEfd9IqJX83F+F73Q256t4LUryG/XxxDaz7kyYmZYo0GDfSPCB/VAHX9eyFhDRKfJDd4pGWRdW6eFc8g7jHbbxuyQFykZdktRar30J4U+w6CWDYJ4MoVcnHGEhBCmso3UA55VW+16qXi/NcA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:37:02 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:02 +0000
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
Subject: [PATCH Part2 RFC v4 03/40] x86/cpufeatures: Add SEV-SNP CPU feature
Date:   Wed,  7 Jul 2021 13:35:39 -0500
Message-Id: <20210707183616.5620-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:36:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ad1202-cd3f-46b3-c104-08d941763611
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB352522810721BADED9CF3EA1E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4h71EfOY3iTNa8P3/IY+kxeFnFENJ/5y7TUuBl/zVfaDPbNzlE8GWaCOlNnKAYIHj6neXhKN2IVnc1dbBJglMfMx88sSicBWZMGQQTwt3Hm85ND75+TF2Q4NAfMlpuGO2+PxbvM+CqC83I+LtZ7Eq2bW5enSqKkizjudUbJwQ/fN1dJ6GHj6Cb9m9k+OB/ccjxHq6jju6xB3mRNyI3JGWvPfXb48ZqIUfG5KoN7+EUTsGFRiyzADP8KHnafgFQrcne9EIJ7uxyPbnicH9KqgO3ucyKvy9KgtBRMWqeoNofI0hUpm8FB/CxbqueFcFYmsZcY4eiQRLzYXgZMszqJN8hqsJjvU5bg/QdVhT3uY2aGc7bATkKA3H43mvLiHpTOKAmu6UidJArfqHXPcXQ+EfOVGNgaGkrA+ikuH/ySgYudfGYTv7/hKvaurJRTgoLBGh7ghY7VnQtKQGhYvLrVlokfn52Tlx7KBnCwSTp2lYaFe5151MP7ppsI7RlAXOG59pOWVUx2beYcagUdYxETV+sSnB8XV+1TtLQaw4tAqUDyATO7fxVEtdnQAIz2J+3EcTVN7OzME3wpZbo3OeMvTr8zmlVPcTdqxCeRWzBcbsz1fl61MzCCS9WkebBISnPdHs1QAr2sYlIvSHKhIlkALFtzYPvuidNpwGJev8VuOY/ROmnFoUSGUSVAGEyBcaemW04JaWHdJrPu7qLQIVpLxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdMBEMo17KdpN3rsGYB3biAbp7bYQb7fB8+s8UqkgS50EdD2ZOSmr39Q7Zcu?=
 =?us-ascii?Q?FurskpxCqdkh+2er/nlCZqnfhPqxMHEOk1CPz11xGiVv1edVmqh2CC5Lnom7?=
 =?us-ascii?Q?kZUCLpvWmXbE4RZeg5ZlEQSg0ux75eEI0ohXHyHui3mZ04C4WISYf3LMw6Oz?=
 =?us-ascii?Q?d76nDGeWrJFd2G5qXF4oF69NScTQcPhDBumLPL8UUAUbFsv6PlBPckWZrQRv?=
 =?us-ascii?Q?+AozuggXh0GrHjHEkOo83PKulYTlG835BW8kktJn+/mPBd7WAztLQ22m4omB?=
 =?us-ascii?Q?rfb2TVPUasExRKtad+Fqrnd1isXalRhyqAcs5YVsQ9r/TPVDaGuWbEnXRKhG?=
 =?us-ascii?Q?SXV/BxY5UyW7f9WIF9UFGRdpeVMQjk6GPqwRgsFBhw0QVK67L+++Ty4B/yZ6?=
 =?us-ascii?Q?tM2VdAOIDtXMRAjjUEwDPXS9Cc15sQkrTEVzYOHBHNLNsv6ZX0RhLUBok68l?=
 =?us-ascii?Q?WAJLqKndnmbCNMzQch0Ln5ES6Q293ht2TYLyuNxsAaZ6jD9VZcOqF+Lknvl8?=
 =?us-ascii?Q?7CptGSAOxjBToPvNFiwaqh5o3JOpuvvI/3tpmZB/giKJubvjMi74rceHr0LD?=
 =?us-ascii?Q?i9FTb7FOzSSNuuqh6JDdQhvI8tbv0CpuOTYwG6RUh+jl94T9rp8yuzcTzXs0?=
 =?us-ascii?Q?SACfv0mkk87TleX+2Sx1yumo1w0gJPnzeO6fjnlR6PU/pDzSGFF2CAQY6QDV?=
 =?us-ascii?Q?JSmAlgKsTuoRS4Z3cLmXN7KzaWR1lujnx4sptP9lt2oGfSlpIqLPo5GqIvYN?=
 =?us-ascii?Q?JJXiDmu1dp5nzZpAc9dSFduvlbs/YxtQz9ZJJVKnLtpUXpsdrmPLqayC1V8p?=
 =?us-ascii?Q?AHU02C1Oz/YhkoUzcWDyo+ciMfWKmALsgdyMnwiuT5b4weIPORAGO4FL3qpV?=
 =?us-ascii?Q?rSl2pOwf0GWSW0y5TG0xfPLoBlYtZZnnsbaxHYlKdrYMjXGSWgzxiyOLU+tY?=
 =?us-ascii?Q?NVWO0km50BV0iaDL3E0OyVkDNqgHOwpfKyiQOyA4HCd8a/gGTJ4TfDsKd54c?=
 =?us-ascii?Q?jSlhG8dyFhITwpVqL//4gGEKtgvE0Anc8jpYEEU0KejmG5XdqUJLlex/5E42?=
 =?us-ascii?Q?2OZ4DrSrJrxNWIGkgHcnKLMS0NujeoYk+dhOAOYgoc6ubpnIvv3zZ4NCW1yh?=
 =?us-ascii?Q?fzeSM+uLB9/BeCRx/8tdE2qVYFOVO/Buhlmr0tjATBqai2zsQPcT80P29N+x?=
 =?us-ascii?Q?tLj0sRzljhrh/3CeAK195nBrIlrtxjOEyfTO1q7MZyGmDbFCzJur3YTOJCjs?=
 =?us-ascii?Q?mXqlwOzPRHwmqPSHNQEfvzNSXmiJYi7gi4qpmAUmjePHbe25mgO5Z+l8scnq?=
 =?us-ascii?Q?8RaOF7gRKnpOdx326h5cMf31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ad1202-cd3f-46b3-c104-08d941763611
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:02.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjCKkKrgmHDfsJZB2RlL19t2GTBTfe6sMIEMKNxcG3NG4yIhlA/CfUIhMoMwZRiO16JYtzzM2xmtZK2GFaiRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add CPU feature detection for Secure Encrypted Virtualization with
Secure Nested Paging. This feature adds a strong memory integrity
protection to help prevent malicious hypervisor-based attacks like
data replay, memory re-mapping, and more.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/kernel/cpu/amd.c                | 3 ++-
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ac37830ae941..433d00323b36 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -397,6 +397,7 @@
 #define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+4)  /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0adb0341cd7c..19567f976996 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -586,7 +586,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *	      If BIOS has not enabled SME then don't advertise the
 	 *	      SME feature (set in scattered.c).
 	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
-	 *            SEV and SEV_ES feature (set in scattered.c).
+	 *            SEV, SEV_ES and SEV_SNP feature.
 	 *
 	 *   In all cases, since support for SME and SEV requires long mode,
 	 *   don't advertise the feature under CONFIG_X86_32.
@@ -618,6 +618,7 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 clear_sev:
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
 		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
+		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
 	}
 }
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..e78ac4011ec8 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -390,6 +390,7 @@
 #define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+4)  /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
 /*
-- 
2.17.1

