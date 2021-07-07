Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65D03BEDCF
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhGGSSQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:16 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230481AbhGGSSO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Zeaj904LzCcuPINeVrrhvBUcbThSf2tdiHq/jZtJhU2gxjUNLQYKtJbqHm2w0Hz/k81PtvwoHMoWfqxjpOo18N3YnEIV1K8ZDqRsFpl7dIv9o9gmkIuFjKaJAr7YCrvpCd4wWWTVNkw7+M27Macaw2+RNXXTIpFNmd3e2Ue/0KguJjuMtqLNpBEygdxk+25QhZEpb5MQ5ccuqGLiraF8TxBIhwG+HtEg2qvGKvAtUzKJE8BZn+qwuMlBa6JNdbh4QphDjT35rkC2JkIQuHUGgvxWyGamnmcc+fYbnV/oF0ibCXtWghyr0u7znISKk7+SI4oZH9wG1vfbdextwHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRSFcm/SDSV8jp0c47dbtAeSYKLmz1qsfnLAhRBu7Yk=;
 b=SUC0lcgOSkPXkfxV+2p8dt6HTqrqWVFEQeQc/X3MKSW/bGRZLG5W9q5m5lBCmZ4lPomxNDotvBWkVCEeQFskXzvl3iQZyjw11Q66/rHmKTcL+8i0onkNIuoC9TOarvaWIyOt2WkmL1lHUXLJ6XaAkEE0H/2amPdSfGiFMq0Q18Mf5R7ZH/shHbQP+onGBLbUEcaLKjnPjrUOiiP6IIeBdfpddx0h9S+83z/Z2ZQ3jr0FgmitR1m/V6dmq6QxZeB1RKnQXp8kLaC+2ilVVB7HWm0Ckab4cryeDw0igGy+uUSV66A/P16msHT4mGRPYPHrUrdI+0mVHPacOHRU/XLKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRSFcm/SDSV8jp0c47dbtAeSYKLmz1qsfnLAhRBu7Yk=;
 b=j/hyh3R/jjRX1cIJ3+p3h5VaaKXk2QG7yRwNkUARZk/BCoAlMhBs1Ynouy9B018suqlX/6yMMwt7osrz172XW+1oaJ0cb9sUW6IWcHqWrRcek8r0XWtQ3gT0uJbds5YDNdwNi7U0AdDVmon+EIq8+x+tL9NwfHuRlof4UJTcDCQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:28 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:28 +0000
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
Subject: [PATCH Part1 RFC v4 01/36] x86/sev: shorten GHCB terminate macro names
Date:   Wed,  7 Jul 2021 13:14:31 -0500
Message-Id: <20210707181506.30489-2-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e73936-c752-4237-eb9c-08d941733301
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939840BF5BA1EB05C60614AE51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtpNK3n86Z3Pa+UgX5M9uL7zMFBmjvk0DR5wF+6IUqd8xOUfABJ+RHPTTHIjUIGjJZdpTr7zE8pTUpx9XmIpjUzwN/NRJpW1ziRt1KtzU7N/QYRx0K5rz55mfH6ZH9g1XOnzRIccN8DgcC5EjxPSWUjKBng6i6/aMwnyZblix1TjrutXGwBmQGQITUhO44WujV+kXpta2FhBq3AdCihEvftc1ycThBP75D80ZAj2ifKPfcwAKavse8pN71+RyrFhyd9WIxFyvznE0Pu93rMlGTVuOhhoqcLLOmBAvbYKhd2MYrNxyLLo4keYJZFdhZp8FIWf2iYgVw2666FBUJwEqZDDVlN1mDPHNYAoXpVcZ/bCG0iyMOq+lMcxOK1FMs/7/FtadVc89Cv1WwnyR1s6iWHbttdpPTCR8v90hBXSZA+FdfoQZ7TNrnLBo7Uw7m4JNCn4Udefh6V8ALfd1qMYXviQUs+84CoNFQlr9e5P9APeqGou5U4M6von+Y82koLDR3NZKrQjjHr//q06hWelcSHX43cjsPph1ChKQMVnwHOQ18VFqe5nL2zUEKf1B9keptZwbOGYPDj/X8NEwrPku00r+iOTcVuM/FCuMaar9Ro7MXebx5dfiRCHpY5wMPSjdxP0JvXf3md+qyDN8yRF1pSiv0M4VX6c3wwAEOgWLwA11ugFguhp5Vtm3C03HNvKsxhrC12OX36aGquxSScD6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(6666004)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXLJJ6uKQw/9bnkeUbFxIPOpgrcT0pcPD0vj2EMGuSJU0sQDgdsw+gmqVMGG?=
 =?us-ascii?Q?QagrVFyAddVPDgA5S81CFiN7EWo9qJIsaBjtIKVVDnUBx1yKPycAbKrAmCpE?=
 =?us-ascii?Q?f9vP8fV/29M3a5cWSoWuhL71SyOQgGKRnZEftgHrKS28xtuEk7OeaQGyI0uJ?=
 =?us-ascii?Q?gdtAZDDif8ulsFYaCdAHfXucKr7EQBibyruZYEbaAkDvXuKHHFsU+JOBSuQV?=
 =?us-ascii?Q?9tjzntNQahR+pC99Am7RYvIFQkYsa6yOPXkIo79VUgWxdyEHcxqUaw1O76Ny?=
 =?us-ascii?Q?4+Nx5wyZuPy0wiUUtwdUl59mRdAhgvDr0G+354L/xmFvSOaRFGj1jtFA1HGy?=
 =?us-ascii?Q?zjX9TqvBsdrR5yHhewidX6p017y88IPPvRz+F3JnqZhUHHHj5pHWdfwx0KEs?=
 =?us-ascii?Q?Bk6OZv2YLsxYDN9PuNVZW0lC7hVSBrQufaM45x+zGLXc2I0KUxPw8alFKnE0?=
 =?us-ascii?Q?B0sp8GLDYpWaFFazkqkxhRG6W59ujFeswtcuJ9JK5z3xuNFmVq2lmSz83CrM?=
 =?us-ascii?Q?QMo6pWT41HxjWneNo/+5E6OipLe6RlDw3bFDBHA4O96YJNrxZtXNNtz2JLWm?=
 =?us-ascii?Q?3Lymr5yLsVxU4A5/qHkVkOtwB+UU1PEQngDLwJwFX8k4f2OuQiX1LEhU19rp?=
 =?us-ascii?Q?pwu+F68E7UYQoEE/6/0QxGHM+aAyndZlINZ+yyYta53wVs0f8Om2ahiBndsx?=
 =?us-ascii?Q?E42tpfEOeoLNVZOw5rvYb0h+wqyFmo0fdkYKMxTS3JDAUKVo0aCgATyL7s/x?=
 =?us-ascii?Q?QMEY/Fr0QlbLfYX3p2Z3FuyTRuHGatJ9rTRH3D+V0F0Udgm4keiEQDoM229p?=
 =?us-ascii?Q?tr2hVaPom3qG9Rk6bBl28q8j2MM1cuX1F9yUSwDJy5dxX4T2evfhAEyBh4RS?=
 =?us-ascii?Q?QmOsDXsrWmHgu5oI92l+cBhZlUkS4I932OZ0yB/ej1/xw3+Hl4Qiy7SqqM5I?=
 =?us-ascii?Q?4FyA0hzwjk8gv92ZHWNOH4CDFaACaqS0976Hj9yA2/3CzVS1BqNk/9ofbWjy?=
 =?us-ascii?Q?2AwHdpue3T90IAolNGyXWjaXLlW/HUSCw+EiZv+T5RP9CUvYYd3HHtgXhHxe?=
 =?us-ascii?Q?FSyQqiaMStyu+dsv8nRM1H7f88GlZZjmwOWqx3jYbUc8v/2ghj5yQxG4WeCd?=
 =?us-ascii?Q?aZYRZ2ipsU+giMGTPoWCm2WLsoWSTgkh0OHJ5Y2N74lWDqjk7dLwsCfOk200?=
 =?us-ascii?Q?6B9d0HdwSdv5Bk8PGDiKastZ72syKq1Hq2NgS+eL/rJ5v3XjotnAi9GrBsL/?=
 =?us-ascii?Q?KuowK0MUWyNDHUfZl6HLHpRDWMf/e6kRX1TsgqDF1XHZ6ZpYiR3v4L8SZxmY?=
 =?us-ascii?Q?lWsWpaaOrrs6OQ18xk7fVAC7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e73936-c752-4237-eb9c-08d941733301
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:28.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9DLBySm2FoWO/DwLVxiq52vjewuyBQetJspY2f9M4kZIWV2EezFtdlkByrd4YS+bzxBi3Z3chXsqQ8ozc149Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 6 +++---
 arch/x86/include/asm/sev-common.h | 4 ++--
 arch/x86/kernel/sev-shared.c      | 2 +-
 arch/x86/kernel/sev.c             | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 670e998fe930..28bcf04c022e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
+		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 629c3df243f0..11b7d9cea775 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -54,8 +54,8 @@
 	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
 	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
 
-#define GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
-#define GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
+#define GHCB_SEV_ES_GEN_REQ		0
+#define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 9f90f460a28c..114f62fe2529 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -208,7 +208,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 87a4b00f028e..66b7f63ad041 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1429,7 +1429,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1477,7 +1477,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

