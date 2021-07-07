Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD13BEDFD
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGGSSx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:53 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:45063
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231522AbhGGSSh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqg9kVkqOUYCQzn5Qmaa0U1SeG3qk3VZ7ocIoM/adniiaSVVVoscxweDcVb/L6m9iSDkHb3sEUpGN8hRSMKQcj3KfiUfHs0VJ5t2A9vtPZA2pU89bKj64mgViykMaB21eG5Slbvfh+ynt55SbjP4VtKYlqDgWw2jLQcnm3p2j/t/Mc++xDIdMxrf2xtRWAqaBAFi8aXawoLOgtUpdJ8yoI6+PdYK7gHYLMu6Qtf+vVcAcW5D6Su7xxUWKZgHKa+GXQIelJl4OSnwsToMRZU24xxghAlO13YR/g0u4rvsZiP0EREHhqffpCjV2t5BgaAlnFkPlgTqacOdspZR+JC0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AhqcPsdf05x2f48CtwiBuMds0v4HsWlxYUp+Nw2Y6E=;
 b=IPfBav54KB//clpLvn2ZT2GZDWu2FO8YpXVfI1knZvN5mdlmS1c77S9sWu61RFEKGnWKkLM6ObUwsQ95Q2RJL9VDRMSulzzf26voqXKrTDkdgYW19thBgSRG1ONWLUBAZjNNDX+NTUQkgj47WIn3UyJf4PCW9wdc7maqndQBCM9huRKf8Mim8X+pHAYZ1gAmcLMnkyBUi6xFjoaNojKjWBzqicDeMGkyarx3/EqBKceg1vPh3EA5msH1MLOgWl1kG7Ach7WDlCdKsilznioFX3Z8JbQ2MKaYI2rjWJy9t2ra8NMs1ZGZs02bCZlNfe0TDl7oszbMb1ysXfqU3PwRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AhqcPsdf05x2f48CtwiBuMds0v4HsWlxYUp+Nw2Y6E=;
 b=0mluJoapzqTja6VBx3KN9bz7Tyr5r90z5IH+hm2jtPpZai2vBI1A+X97QIRaDkII303nN13ncGUB9CfYN7LtU0DEU2y28S6eF8t43lnC0ASyPSHbkaPV5JQZDoLX3Ki2dfXMiu1RMDOGGKHJp3h9mSDqUmsmBCMVF6jRXFVnjAs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:15:52 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:52 +0000
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
Subject: [PATCH Part1 RFC v4 10/36] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Wed,  7 Jul 2021 13:14:40 -0500
Message-Id: <20210707181506.30489-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87579292-6c40-4a99-2375-08d94173416c
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB50166AA174A3932F59E826AFE51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4A0Flyfz7nbKhdjVyY9B0yI6MA+LcGwGLFd18ZXWYw2SXk7phz0mLAL2gxvphsdLwhoj5G12EeiuFSyjvpSepgnHEAiyyAxVXLonlvzHIoKLEZ3xPcQqPxTgCUfWWW8Hhxboglwzz5bvtrVmE4GIRWLlRQ7hLO1h+lWid/iBEZl7pgMjgLsgBSvQZq64WDJm09IOusxMCnR0aEeAxq9DvBSqg9BoaKumBkxFpOZ9q6Ngf2QYVZGtnM4mfA4fnfRWWCltD8MLDlvvwDc0U9Ohx1yRNpx+aq1gW4ifATFxJC/UOvNTqvC2S9qVrTJYnY2XRBZ+kxh6IBqViksmRQgAlpz+Dpplca473o+cCo7f0lKKQeIAMCrgpuAnBpry2eAI9jHOgAMNc3KImEJpcOfrrTGAblG+tHiBAPbMByzhIB6br1g4+pZtPO5b6fJfF8ArfG52poLowxH9meFe7XmOEHBsWbp1vqBK3eI5bt8OzIJXvLTnCNjnQIsyREgaqnl1c8mmndba7hVaLG+lJU+n8W6KGmN5A+oud3REzvysmFLK693u/K+pZuAbOEfEJmqH6KUzQ3L81W+goF0DTm3kpmQOhVyOL5M2+YXjU/KHLe6NEMpB2EDyOREsycQUQ8ulzpvoPRezcdUM93e6Pp6eaWhRPBgAGiHR+XB0okTUNZgmRpSHKkBzDAOhFENSmle9dSzEt+Fx1x4RlTG+NJQP5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgxNCXmCUgUTMmWMAb9PdrjwG0pwFEUihMQVcJWekRE97zP2gg3Tqij6gJZc?=
 =?us-ascii?Q?CiaibTJCcJbYHsVjGjfP4idKai1atQ//JYk5ln8ag0xdQpkxpYpmWG7RUUy2?=
 =?us-ascii?Q?7VG/jY101E1W8td/QTvFSv7JhsEEk5rCxBN9m93a7HkRJIcaSup7K/igJgLi?=
 =?us-ascii?Q?B/umPDzptk+me7vPjVjAv3dtFs63iCxtlQioNyd75yho5/WJGJmfjMcJdGU7?=
 =?us-ascii?Q?7MnAvzw6w8vL4HKSez2kePVBPDuanXs1LszGgcd578n+1oXZvHWD7OEpxCNs?=
 =?us-ascii?Q?9VqIIi8R/6RbKYN+bj60ecdsyFpl35PaATvLBN4QsDkZ6Ql/YCZkSD5S4Hnt?=
 =?us-ascii?Q?am4r/VcIhaljtTuYRHwRQCDz6c5e2/OEmVtUUg+CZTP0ybTiob4hH5rdBcuW?=
 =?us-ascii?Q?B82OWAtusVtPW6qlqUFE7Kku1E52D6BVSFYCvjn/80hrE7IlE76TcWosCR/R?=
 =?us-ascii?Q?aynuqHTzueL8t7NW07ysjCWIgs2c1vAOYrjbYcF+FzVQ/29uRzlNbaS/p3AJ?=
 =?us-ascii?Q?KCu2EpgBZawNtmJaMfvIdCJiZxDFO+hAamgg28Ari6ewYYhqD4F2nDi3kuD/?=
 =?us-ascii?Q?crJ3wsb53UIcrr8zFqp6kryjl8N7HKiF2NZvNziwxWUBmIzDLXS7/q7PSvrC?=
 =?us-ascii?Q?/ugaFva9H2vl1Y5rt1ihCx0QPw/Au7MJhH9iU3xP4WN2yTGVuF98pWrrRGPE?=
 =?us-ascii?Q?YiLXoXExkyf72aEVesnlU4d3HBr2d7QPzNLO0asXD1fT3vNdXsmqEVnAn3A8?=
 =?us-ascii?Q?On5HS4g4/wclU7H8uGqe8pqgIzTdAoeD658gfBQsIxcCAhrbk2n4yeuBpWbM?=
 =?us-ascii?Q?Yvi1jcUZFBoPJNVhf7/JRCLjewYLQVpd9cnJCoT4WoG6Eo5ThndvhuDflCX8?=
 =?us-ascii?Q?bFPqjfOI375uymtIG3iigVX64azbr+eKnIvjhiszoRzKKzQWG1drkSQgqQSb?=
 =?us-ascii?Q?ek9xfVuAVodenHm4v9UVwXOwE4nVi+6tIRObuy2D99zflRy8bhG3x5Gp+CAd?=
 =?us-ascii?Q?FS/sd2PoucSrm0k9Ph5f2mJM9xbXAkHUL2P1pXWrkxowkOAil4iwGIuUHJLY?=
 =?us-ascii?Q?lQq2vQ6Ki0aVnLlhQAMjwvyGYFdoK9lfUaHhIrgWwbuV9YvdUmUQ4bv5CPjr?=
 =?us-ascii?Q?z2qx1BiRtMwuIJT6ZOiMH0gip2JIdxzV3HX4U8QD11cazQ0pFk1XBuhhyYJR?=
 =?us-ascii?Q?V/n05LmiIdfYnfRCpEwh/uuZfHEUGm7kBXXwaBfR+2aQWEQrxUhzYiGCgpT7?=
 =?us-ascii?Q?PfFc99JW892W9tV6QiG2vNYREYAujuGBKKXEUuI/7VhN4jnMCsUEib1jJTcV?=
 =?us-ascii?Q?UVBoZOX4FUwWnUFNvJ9dAY17?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87579292-6c40-4a99-2375-08d94173416c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:52.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+XWePje5+pPwDmRPplcZC8E43QUtkf+UcHH5FSFQ4/IL4JgC3fz66vO5kIcy793tN6lpaVNV/kLonh79H4zdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification.

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 11 +++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index f386d45a57b6..d4cbadf80838 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -233,6 +233,10 @@ static bool do_early_sev_setup(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index aee07d1bb138..b19d8d301f5d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -45,6 +45,17 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* GHCB GPA Register */
+#define GHCB_MSR_GPA_REG_REQ		0x012
+#define GHCB_MSR_GPA_REG_VALUE_POS	12
+#define GHCB_MSR_GPA_REG_GFN_MASK	GENMASK_ULL(51, 0)
+#define GHCB_MSR_GPA_REQ_GFN_VAL(v)		\
+	(((unsigned long)((v) & GHCB_MSR_GPA_REG_GFN_MASK) << GHCB_MSR_GPA_REG_VALUE_POS)| \
+	GHCB_MSR_GPA_REG_REQ)
+
+#define GHCB_MSR_GPA_REG_RESP		0x013
+#define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
+
 /* SNP Page State Change */
 #define GHCB_MSR_PSC_REQ		0x014
 #define SNP_PAGE_STATE_PRIVATE		1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index c54be2698df0..be4025f14b4f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -67,6 +67,22 @@ static bool get_hv_features(void)
 	return true;
 }
 
+static void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_GPA_REQ_GFN_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_GPA_REG_RESP) ||
+	    (GHCB_MSR_GPA_REG_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.17.1

