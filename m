Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9C398B68
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFBOG1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:27 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229929AbhFBOG0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkwHQTPem+MatItVrXytgkmHeWk2XmhBbmu9uu+hWjg0wRsjIa/T7CKa4QC3VjZujSz+m+q5S7yQxO0iqXOTjIt0FA8PZ1I2I9LY6biGtZZfIlIez1l1RFWhtXro3WB+CtMOjzD7fcxJZPhpaRj5xDJq1Mrt3jnnM/bx4r/fOPXKBVw63jID3YRXah2iJYbG34l/cSF+NLYVdECQCpMLVvZVHJCu+CBuQ9Kbxj3EJqUvB48khPgONUXrkD6vJvZDD9Ylh/5SAlhLw6G/2GAmg6LwNvIdjDXYP21byxKRgh2MZa5AxV35vSeoJBrHHP/BvAMBS1OAlvtn+byo3FKspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peVx0zH4JB1ZJYgUG/AjKof+2xC8mo0mNUU2PAGg2KU=;
 b=Pirg4CFMNxVyfqyEImI2uCRx8y7HW/hZnVjEe5DBeXjtios7ZANgEoJEpUSwBltIxEQ2SyiTf0hRFv6/iW6NI4UMw4m9D3KbYCP5C6oZRNQlRJ00Fn8zkH2L5oNRQlVAeIMxjyUtFG9i4jjTCumIuE1WjEl9TA1cxv2MTFmuveSK0cNppb6tukwzneuYrXCsDFRmJkRQ1bs6sgAvjarWr4yGVO5cS7ySR4/hHhgPPtm9nTkyYOVdKINe9kTc1RvE7QbJPuERfuF0ywcOEfGznLKJ2gEG5uwpoGF7GnfQ8Gdo+vgCyX5m4FlYlBM8oJl67JtBGiSymF8oqr/fYdLcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peVx0zH4JB1ZJYgUG/AjKof+2xC8mo0mNUU2PAGg2KU=;
 b=vA0RD39PH5Z9P2Ky1fAIMpASxn1R4LAvkG7VfxGZtYho6goFu4IA/pJ2DRSnB3OljXpIeWU2ofdbyo2nUZhWxYL1bBggR+sH7NNO8m5EU0R1wu4/3oTEvH7lx3l7WotCJ7ERA8imwLZgMsBvLWSZegZHIX1Lpi2p2DD/xSEogd8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:41 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:41 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 01/22] x86/sev: shorten GHCB terminate macro names
Date:   Wed,  2 Jun 2021 09:03:55 -0500
Message-Id: <20210602140416.23573-2-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0566013-336f-4a70-aa5c-08d925cf5da7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45127C47BA4A0CB96C2EE7D3E53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efH/JrUu4fxJJo1/V/ZW/rPfvdhoZznlYtBWMz+UGHn+7sWqO9ORqeHc4fV8eC5OyizhfYAnp5FTb6ebJWPsY/fVyk/qvru2NLktlY7tZ/mI35Qvy3SOvlxmYoQsEnC/jIKGS5YkY3tVPvIL2JRfnJAzMCeflsoiXzSRphWrWjclAzQuW6+E+E+EhnyucFxXFWQKbV4P2IpjBDngY51afMALoNhyw5uFEdrdrKXX7E75iZyZNzGwv+oM0ly8qEqIytOCV9eEpAp70yPH373RaTEWzGPhl8w7VYizfdU1wgaAALCFRSK/eB+IsAILYHSRmtkVXdvtRpZwnOv8lptZU8mn1IDUQulT3Z11+CPaEor+QYKv8Gp7on7vCGFbhk+1oUhlm1t4TjT9pwrUEXUsneTlBxRBYUd8jij4AqzQF9gV0bs+jE5V3n3j9hCZQao8WBsgntNroHuJsW3xmpG1NNbMieg50lCt8JfCqDGhbZcNEMzq8jytzVzUWW3KxPYH/Jqpw9AzZJ6A8eiiyPpG0LAgAPEVUOL1+kJcPkGdTkzfExk2xdTwG3lRPop1hNJ93tqa6oR33+dzckwBHBZ2IaciPdDTPyX+IfUGDeR5qB/t75X+xDlazU/vqfTCXz9z44/PHHTBHk4hqflbBSMcgcSWiU5UVHb9FoBm5nVJDFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+EhLSBTAPylrre06yM2RMSKsYTXFSh6vgg6njcTlDY/wD0OfIeZSZ+q5iDQ/?=
 =?us-ascii?Q?eLnrokUcZ0HkFWd0kJDLkeIFFGUr0gVxbkR5WfwjW7/v2naX/ZuqIOmfSUpa?=
 =?us-ascii?Q?mLmdAA8U0BLvxMC23kULJfZlP2MzevQ8YHalo6J9dzy2m28/41BQZ7LVRObO?=
 =?us-ascii?Q?2dnvHPTkFRd3RfX6ubFyn5WmFyKi0vDYMkIYO75QS4R2ofA7T658U+ZuE2WL?=
 =?us-ascii?Q?20dBjBv2lJhh+f9ejmD7QjxTbGgN4Yp8gVE0spywAVHubTI6LA3BackIb2qQ?=
 =?us-ascii?Q?hS3aS29OeCCRPGb1LU4oZiYrImaxG3acpIf4QTYWRvcfxqd/zLeKqP4IqtvW?=
 =?us-ascii?Q?sEZiGM3sKrnmGkRk76FWjURLDGEVeGMfYfhMsu8wB2AIereRUm2chYF8ictN?=
 =?us-ascii?Q?ucqR4TwDmjmi1/4DjmPR4Y4CiEuSbGeCN5vmas4hH9FWa0vSF9sU1RJ/hjib?=
 =?us-ascii?Q?waDOT3AahoEnE1X/lloqXNV2OUWyrXaUYpHt8iyE/getAaljUgSMUq/DyfUP?=
 =?us-ascii?Q?aMofra+C4kIItBYy1fm40jYouDniN12CaNiOvQZehjKidtFi8oCqBwtaYOqV?=
 =?us-ascii?Q?JVnk7mKZ2YSq9TRqvxp4v5GRrFB/JEyjapGIASek3xwK6tSJOETXmcLMIU2c?=
 =?us-ascii?Q?JqhQ0nMiYTGzqH9YLlLhxzvG7U+zB8O/kOQavT6h0wYIv8Q/bH979HpOrzoi?=
 =?us-ascii?Q?JH+kYSQthEIXiHrVBdrP55TPsa+Xa8m+I2DeFwSL+VdvHfgsiN7/OB005AkR?=
 =?us-ascii?Q?/QzZ3ttVBzDXVY+XJQPjlWW55xf5DRUyrOdUrr7xosq7okdS2nDD61GX17Cf?=
 =?us-ascii?Q?S+tnOJgodh6eGKyZpfQnmBJVriMfrkP8QZFFEyzob5EDQzaXuwn5UtzH97We?=
 =?us-ascii?Q?i1i8yOnPAws6YcaI8q0cJWhYN+L9kmVqD1jr0LAReb0opEToFrmBcm4nXoNC?=
 =?us-ascii?Q?H071vxQssFlXPm6Jjqk2vsHR2q/Ueo1dRIhPRE1jlHcpdxWrzxq+Yi0Z5bAh?=
 =?us-ascii?Q?Fkv1v9/2PqdEHFDZT796QZKcTJxREtBqAd6ZJAPO5LbSE1cUTAy8Cc/z8TnT?=
 =?us-ascii?Q?oCC5gM288JLIlxzW3qOpPyRm1RShjEbT4sdYVAQYZlWFZ9owZWmAZebDJ0JL?=
 =?us-ascii?Q?ofBch0KSwOkMH0wSAOnmdvRuYCydJHPU8xOYPZGOK+gyf9+pGHYHwDnpgk4e?=
 =?us-ascii?Q?wM3bTm1kBhEyI9frNtYHTNqHSD+Z1cDARLnda4IMh7+LhywFdxYTwF9/RPvM?=
 =?us-ascii?Q?YkH3LbHULz54oUw8MZQ6wna4da9QeyJ+32g/YpBAbi13SHk6do6ziEKw4cVh?=
 =?us-ascii?Q?JmFpJOMBJMXT21gI+6zfGQxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0566013-336f-4a70-aa5c-08d925cf5da7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:41.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQcYoKMrzYvZ4kkWBJGSlEnrxlNKZb5gb0fuf97k8b+zSJgtw6hM+3I4y7pS8OYyLeh1bqgkevD/TC8wkJmhrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
index 6ec8b3bfd76e..14198075ff8b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -207,7 +207,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9578c82832aa..460717e3f72d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1383,7 +1383,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1416,7 +1416,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

