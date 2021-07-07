Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7583BEDE6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGGSSb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:31 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231479AbhGGSS0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyXJqZZGjhpxt3ZsZvd7kHnXfnPjbkZUq/p05tbOOCWLtpbypjxZKuFB0LwTnMgt9qQFRHiyCTiQEe+0B1LsBirY3wqWZkTOSXM5Ic8G6ULI/Fsbb7IXtm98c5Wi/rnmKfuVv2vR0H14oMXbcyFgJTe6zw7bmSiEyyw8BiC+YKZpgxMvVywLQyyhEr6oWUHBP2wcRa8TNfzirR6iALV64jitdCUmXwkUFpmwEB8+/lpYid1S5Ia3wnkJdSStvYVrq2ZpHT/VDTTJ1G/pCu7PSIVgG0Gj4ZhgtGC9TnK9tMjdWPNaOF7dogtfTreXEXw9GcXt7ZdKb5va9RCOx2oUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtNhJC0W4p6xNKQnWOKJN8mlkiNi8O2qF5UIBoVBVOw=;
 b=YfZyVHshPuMYAFWPcuLL39lVIOdp2zOkk3GRF8NkZBlZT/qhbDZ5LhmHqVxysHFVNCdEgPezazXhPfhxce/i5i0fA4YI9fRyvgecR3Lh2sQFujagm49Ype2i1vIQQMD9k4dRLcq15kGnn84TX68WMhfkTt8JSK6GvVoVQLXum2tchbuexHqkN7toLyiPhAY5LwlvtK8cVnNTkRhLVmF5tXxCeIAXhoxRH3TAQZRxbn1avvsof2NRnul2dwA13Mm7HG8snhbcQHubW/THLBPo0nbpDgBn/BgqCByMY+o+NLA/bew6wkZh+rzpZTrsf0Zw/Nq/tlLcyUnYSmtLuLiFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtNhJC0W4p6xNKQnWOKJN8mlkiNi8O2qF5UIBoVBVOw=;
 b=lEUk/druT9eH4skeR68qo7sABFX7YAuTBqBS1HE94YBtTKXlxIjC8/M1Wv0D0tzTHFZh7kiS3zAhaKmlr18nOYTjp205KnUwTpOMaVopKezR+xM1ipFGYTtLXYihrNVdYrKavQPdLdS3fIB6yr/77P1yrI+tn/ZWPstrwrjvCj0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:41 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:41 +0000
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
Subject: [PATCH Part1 RFC v4 06/36] x86/sev: check SEV-SNP features support
Date:   Wed,  7 Jul 2021 13:14:36 -0500
Message-Id: <20210707181506.30489-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3075f44e-757b-4c3e-c487-08d941733ace
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939EA259CBD9838193DA9BFE51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSgaYhYKlprjJJQgh7EtryRyCLCSgHUm8S8QQe0b1h97bp22AWclV4xD9ph9y5q/CdS6xnTMkD1HAoDfGqsL1n9Ui1nEBqYiwrROEX42kMIR48b+FS2uq/0ubdC3XbLc5uMZGG6l2lnqwCrGif1JLnaqfYYdhISb10h0aJUHx41emKS9P0qYlOm+avCgIUh1nhKBkoxkwc2wNUXQcDbLHilmlhKxqAdgY6k5c97x4Zq8VzqDPyJ7gXXdh4/z0caTI8d8HYclqHuiWbzHyUfmonSSJABifQmZUUE6DrWGMKAsAdcf1JaSD4QrubZsAJeBP8gJNYtBbz+6zR/pxpYDFguo216u6KU/OtqEPuS7Uxl4h49S3ZTQRDKU+dnCIn+9kAaVvP3XYcufPd1S9FsMTZw0zq1cd67MmUltDg6Ab0YPppFZoN0utr4V2MM55YVFXtv/WXgV8tXjN2gpDQmndNv7ngyqcaob/Oa6gkJ5ZRnGNLrOaSK6hX6Dm1cS1wHj+r1JtPkPZZixssczcPD6cBI+HzO+0WcGx4yF/d0PQysK7jr4i/cZMKgU7Ag0EE2hCMS8dl8yaRG9BfS2neP6q4HvLUEo8Mu9zX2S8MYeKTEDnvTWv/6TLOsPyb1EpIs7HYGwP/DE7ozWfFzB+wtfl3uzR7zgkA39AINki7R9A6txPJShpbKzppBgMBr6LuysQuqo3SJIKlyWAXPlPwaVhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(6666004)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tp7BpiXfDPSUwmkmzMkIRLZdbcXlTl0f0G4p6ElpOHdbg/gHWVlwrdPCMGJQ?=
 =?us-ascii?Q?O/F7cnEO3rOSAG0xxe1ynIaC0PIHFi8zSofmzaYxg5RS7o0fO9p9hhqxqlaV?=
 =?us-ascii?Q?92ydK7N2eV25oNEiMAkIn+2AH0/y2zsnohHK6S0F0OMvL3G94RYJrS29TXPC?=
 =?us-ascii?Q?ZZt1kFpsLrK7WPsKwDgxTwoB4+UmiIDfTngnuByV8fFu8l78JPddvQTWRW19?=
 =?us-ascii?Q?YMDWbLYI6qSuWLL3nJZdIjeDOl7zmH6qGRv8BR7BvUi3Ng+lJ8ubt6nM09mI?=
 =?us-ascii?Q?JnT+3A99QxFIK1XbnqsOT7EywKGlnUluIYHxFrtrqb5rf+pC1utPus6NXtMC?=
 =?us-ascii?Q?1u39iVf2q5MxqCmqhEZ62jxdrXZKIApPQ7e2vnq4sb3E8fXAR/a0n1UvsPYX?=
 =?us-ascii?Q?WPqFCPyFokEjOxDBVgZ5oZP41T8cvmD9skXwXE2wih1aRnh/YOshNcdPLCN+?=
 =?us-ascii?Q?spY277N/pa2sxf3GN1lFzp12xQNRyazlUeYP1NC6/qA3qdcj2ykUGDIsiSoO?=
 =?us-ascii?Q?0tSaV5AvBMfAzMNFYz4ZiHGASDn5pQC71JpBXIFv6MILa59OM0EausT2ilql?=
 =?us-ascii?Q?G0WrtZoJ2TnqBk2u+kk5AjU7D7GdzQPysKLZwybfLNWe1Pjqeraqskbm1Q96?=
 =?us-ascii?Q?afhd/9zeg1xJYhBlKAMDM0E8TT2Qf6tsIH1p1u0w8/E2UhPxnYWTkCDr7Ycc?=
 =?us-ascii?Q?JpQB1eRznbk22kb0qY20akEWkaTCefs9gAvTmXkYVyYUBll8lGmN/vgmBrHT?=
 =?us-ascii?Q?RT7YqSIyPTno15UeRrlNd3E8jOzpRncoRbvFMe4zVkSF20jc96TCFYh6QHpb?=
 =?us-ascii?Q?Ajvq3+9gsFRSahpjQh29hyMDyLwPugc15m0r5ACb2TdmtP7I5Kc1dk9/AWim?=
 =?us-ascii?Q?Z1Y/I3yX5ILGR5vNUbz4mgt9AzQeUndySjddK49tiZuW2/jSLzKVLkN5U/A6?=
 =?us-ascii?Q?fHD1yU4BQmfoXRCK7tdIAwL3jWMn5LbORHtOgxNW6fctVYHW8YlsOJl7PRUa?=
 =?us-ascii?Q?m4diK9UUGYmQb5PyrXVaMbA33irLrp/B2ljgx8gO4JjXjxWU5GhghPHQoMu8?=
 =?us-ascii?Q?a9OjHxsjvzpp6cakyi+4vhI+rAW+Q1Zti14xaxAklXky9yYYravwW9O/LcMx?=
 =?us-ascii?Q?rfN6romZ+osfOxq+Bs3oKT/YP4dlFJslZ2vhmxKGiZss/I4cE5pBFk8eSLDs?=
 =?us-ascii?Q?qZ6Qfg8lKM46zKYD7MDmUNP+F3yfmBZZyE2RksxSAkAb1T59jnuKs2+XjUOt?=
 =?us-ascii?Q?k4QDVGJcWhKBy4RrxNu1tG/eV8Bq62FjuLXVShr3tLOXd2yEPEh4gLBmhGx7?=
 =?us-ascii?Q?zQ/kdll7DcP1XxLpmabBgedy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3075f44e-757b-4c3e-c487-08d941733ace
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:41.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8uyJ/Ne8+jJJhDRvsw68E9+fz7+Hmqd+5PGpw22jj/cj/BMNdvtZOYbjj7m3ur9qHvtYvljwUW//flwpjz1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of the GHCB specification added the advertisement of features
that are supported by the hypervisor. If hypervisor supports the SEV-SNP
then it must set the SEV-SNP features bit to indicate that the base
SEV-SNP is supported.

Check the SEV-SNP feature while establishing the GHCB, if failed,
terminate the guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 26 ++++++++++++++++++++++++--
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/kernel/sev.c             |  8 ++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 7760959fe96d..7be325d9b09f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -25,6 +25,7 @@
 
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
+static u64 msr_sev_status;
 
 /*
  * Copy a version of this function here - insn-eval.c can't be used in
@@ -119,11 +120,32 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static bool early_setup_sev_es(void)
+static inline bool sev_snp_enabled(void)
+{
+	unsigned long low, high;
+
+	if (!msr_sev_status) {
+		asm volatile("rdmsr\n"
+			     : "=a" (low), "=d" (high)
+			     : "c" (MSR_AMD64_SEV));
+		msr_sev_status = (high << 32) | low;
+	}
+
+	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
+static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
+	/*
+	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
+	 * features.
+	 */
+	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
 
@@ -174,7 +196,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_sev_es())
+	if (!boot_ghcb && !do_early_sev_setup())
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index e75e29c05f59..8abc5eb7ca3d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -54,6 +54,8 @@
 #define GHCB_MSR_HV_FT_RESP_VAL(v)	\
 	(((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK))
 
+#define GHCB_HV_FT_SNP			BIT_ULL(0)
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
@@ -67,6 +69,7 @@
 #define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
+#define GHCB_SNP_UNSUPPORTED		2
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0245fe986615..504169f1966b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -665,12 +665,16 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
  * This function runs on the first #VC exception after the kernel
  * switched to virtual addresses.
  */
-static bool __init sev_es_setup_ghcb(void)
+static bool __init setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
 		return false;
 
+	/* If SNP is active, make sure that hypervisor supports the feature. */
+	if (sev_feature_enabled(SEV_SNP) && !(sev_hv_features & GHCB_HV_FT_SNP))
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
@@ -1479,7 +1483,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	enum es_result result;
 
 	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+	if (unlikely(boot_ghcb == NULL && !setup_ghcb()))
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-- 
2.17.1

