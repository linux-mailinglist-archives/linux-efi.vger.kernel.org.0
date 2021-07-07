Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876253BEEF6
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhGGSkX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:23 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232252AbhGGSkS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuFAWheCXarvfh5TPqkcMoY7oBQi9iKqVnrdYLeaXb55Zytd3nZHJhC2UgP0CIY6b8D4zPBDzJFx5yeypK9elWpDlpOZdTK76Zm8+Ok/lGJgge2A7cqtDwCJWltmuAcPkcqXBQLvzX4Dgc5eZHepi9qHPHWROVevEWPx8yErfqFZH+F8ylamCOL4XQ6QE3bXwvGgijbNgpt6tMWWZW/eCS8gBfZ/+wbOw4bzjinZQ2B3GiyPgusu0S2cmo1AP5FrS/D6ROLezs5jy6T6kociZQty8KzjNy5Roz8YiiJy/+RmiJCRfgijzF0e/z+QgPpmRV6JCdvbsVpx9cQDMdECEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kMgeuH0W/ppzYhomnorpB9wPtuOoMzgXAXMyamT6Q=;
 b=BTTtyuomOX35YYJ9Jq3iEPmaEqy0aW7cmLTchjVw/lJu8SWbdefwcjUmFQSxmX+wU/Nr425Z4SuuVxE1NJ8PCf8wKIMO6RkXw3JaH4FpWqdFgB/hCM95Q3JXcr4snQeyaayTzI7Aie+8P3ABOj5uWGKLpwisvVn+fcMbl/OR14TZyAl9enqykA1o8w8zcdPytNa2rMOoLHZe2H5Ay7CpOKgx1iqRnDBiPECLTUGqHNN+zG9PhBZrgX+Pvsrf4k9dfNPOEEITV7PYTMCC7VCQS/oov5E1g9ASLqLmiHQ7kySTN1vwezeGOY6QO69iXksMJy8AQGKcNcfvAuHMtYDjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kMgeuH0W/ppzYhomnorpB9wPtuOoMzgXAXMyamT6Q=;
 b=v1tsemzWU9PMZuaoMhSHmqv4volM5xY3ME8F4AGUiKbhcdX6BzphRN+77VxvsLxVgl7h1mhjCcUaJWU7F4nded+xOpdPZPK2ynRk8Y8vqunknBOvABeFOrh3CPnoaNhVDdTmHorAnRtdSot9+tKLlFt3YZ84SbBjLBrdNUDgrmE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:20 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:20 +0000
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
Subject: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the RMP fault for user address
Date:   Wed,  7 Jul 2021 13:35:46 -0500
Message-Id: <20210707183616.5620-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a9902a5-ae22-42bc-2c57-08d9417640f5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28081401BA72A0141A1678F6E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BaXXfeM+0rPvrPf2S7/HtAmPz15BRd5yXQEUm+HU/ZogGs2ww2klnuwS8ThS75oruutFLjpoP3AcDB2IAZQwGObMa+lEWPRpDBU8lT4+Az4Xw+x+nhPhxxHja6k8UOzsajIjgkwZxsH7FEzodO/70AyHVHhyUYkVVZ7674eLeV3NuVOwaCqYO878fPe8HDK2AJeN3xXWgP/yoOLEi9rcUdeiY/MlXmGJCkgziGyesBHCpDcUi4uIsyyEvbiShMkS8jYNkqmJo+sbUYog0FqR6eFhHEOdhGIu+6HuIovzxaU74oxBB0VdoyBO0muSXE8l2pK6cycAvdcE18/MJ4LqML4cMS1XacRjR26ekW+NcnFUb4ZwOfaVIS9XaBIntgkzGyXdROjpXjN/l/DtuilcdUgq93dUFnCJyPfYlChyqnKLkjlIGObAPpLR57jCv82e+7fl9ALD8I0ug6LDb/UPpz9UfHJDIo2475VIViGLvQ0qrSNLcUrYnxG9g7WqD8hjGxnTdiRJWmFbCmi+V82Yk8HpEMEvPueuUjqOljcRXLsF7xb5lK0oFJvTHLYbul9He1q8+q3dGCOfESceEr43VJLlbLNY/NNNZR2zpYxmzBvHDuy+YjczkNflsAOuIuMNpb0gLQ9uJDW3gwGNIAEOTBadYY/bhD8Zi3rI65WGefwDQBJfH0hNPvDWCxi5xXF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1sLSUpw82Sl8tfr0OoI7dh21Hg8P9gTpcUA6OGMcVPsWB72LHu34rt3NvBG?=
 =?us-ascii?Q?ZwesPQ4N13qJGBNk8bWy423RV503YFKwLj2mXBzYQYqjdHWamrhRIcSU/XEa?=
 =?us-ascii?Q?nV8vqQA7o6YtLW5kJBE4zHlIwaxqoRbwpnbtDvtaN55piilxZoqKcn8ckKWb?=
 =?us-ascii?Q?u7A51dD5IhjvpXeZI6fKjjRem3l25r/Ag7CA5VpkknCfp/WXXeKQuAbaDvbZ?=
 =?us-ascii?Q?O03rUmAHMML/19p4f3h9BLp4uw33Fi0UP17AdqsnKXFU5RnhznoGrdg0g3VZ?=
 =?us-ascii?Q?rRU/iHSeZO5Qkt0qLL6XtlGjSwWeQ34gNBM1oOkTWEutl93QqmbbO5BnCKgR?=
 =?us-ascii?Q?x47K+VxBVmnYZEOvmf+Er48XJ618b2n5tTJD/OA9NFvL9vx3oR+7i26Fr7X4?=
 =?us-ascii?Q?ki8sbSZF1Tz/ZeYvUmEKd3eltBz7Dm7BTh8IHQS1cQEdYLbaviW7qjg94cyD?=
 =?us-ascii?Q?atbU9GcRF2IfvnQenB6AWk034mgxE7H6OopUOrkE4tyzJ3W7Caqfy03XLi+a?=
 =?us-ascii?Q?yU2IU8ExPfqpPJRCnVPTp4ClkAUU5q3UH3fbKiznRC9glCR6M3xT62vhY0++?=
 =?us-ascii?Q?eUIUjds6S/SZPBuKcmOz990Zhvg+Oi3Wo+kWDrgM5XI8o0TJ3uPuZE9l1Vlr?=
 =?us-ascii?Q?reJ2STekQE1ojzsuOsREyn+Pml9XNQaOlQ8YfaJbeX4RSFnAKVwBm9iEEVrr?=
 =?us-ascii?Q?UEz7htDonPmS4QO11Sun3Ub84X5LtlqAPKx0O/6C8EFwql0kIcqrBhckCo+5?=
 =?us-ascii?Q?9P7M9aRsiy6FgsbI9VKWY2A8xU0GbDWyyKRz9ymqPdkFkx0Mgiw1NH8RAPCM?=
 =?us-ascii?Q?qUj7RYDf2qbMRmZSR+gxeAFMzMneBa//I2mbhP9cqLbDZjrVvtm3chmumkBY?=
 =?us-ascii?Q?T/J7R1W+XJgYnbErgIgql54Q+9OdP+0P/fHE0g348B+zlJzdbUL+LT+MdUt+?=
 =?us-ascii?Q?tMJA7YkWEI88QAVI6LuRaxNCzHw4ta6dJPwDDOHOGTe3XR/CMeqpaEQLLNKr?=
 =?us-ascii?Q?TPWK+YZnuQkebIn9h4j1YgQX+acFuXmYImp+k+LBcpcm2FQSXnuFGgSG0i4U?=
 =?us-ascii?Q?hPhRyIvdfOXJOG210ASOtLC6qlypgWU2rHXyJqRGtDWXIrHS3VdNxiX4Zika?=
 =?us-ascii?Q?XeRzb5pELD/sWde76QvyyG1VFulzMWmBAw8QguRCX2yKUHccpL84jhJjqvOJ?=
 =?us-ascii?Q?4zq3ijqqHEuoJNnv97WELF6Jk8kGQ4sFq2g5viAkFKdgUCN1Y0YZAVHKu8O9?=
 =?us-ascii?Q?xjYT58N9qfR1X0YOLpiVV1PlVffhRCpcQm8Z1v74MvNRf5Cw3tJpAhGvKVVT?=
 =?us-ascii?Q?SE7/VXjBTL/wJsIM4H5u7Z7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9902a5-ae22-42bc-2c57-08d9417640f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:20.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHNH8Fe2P7HG4YctzJ7BFlbYhp2grCZ6nmFQKmINFgyj8Ovt4FOcBq8rxIjo+JU5LeMivrI5AoGCc3riJrIffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When SEV-SNP is enabled globally, a write from the host goes through the
RMP check. When the host writes to pages, hardware checks the following
conditions at the end of page walk:

1. Assigned bit in the RMP table is zero (i.e page is shared).
2. If the page table entry that gives the sPA indicates that the target
   page size is a large page, then all RMP entries for the 4KB
   constituting pages of the target must have the assigned bit 0.
3. Immutable bit in the RMP table is not zero.

The hardware will raise page fault if one of the above conditions is not
met. Try resolving the fault instead of taking fault again and again. If
the host attempts to write to the guest private memory then send the
SIGBUG signal to kill the process. If the page level between the host and
RMP entry does not match, then split the address to keep the RMP and host
page levels in sync.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/mm/fault.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h  |  6 +++-
 mm/memory.c         | 13 +++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 195149eae9b6..cdf48019c1a7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1281,6 +1281,58 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
+#define RMP_FAULT_RETRY		0
+#define RMP_FAULT_KILL		1
+#define RMP_FAULT_PAGE_SPLIT	2
+
+static inline size_t pages_per_hpage(int level)
+{
+	return page_level_size(level) / PAGE_SIZE;
+}
+
+static int handle_user_rmp_page_fault(unsigned long hw_error_code, unsigned long address)
+{
+	unsigned long pfn, mask;
+	int rmp_level, level;
+	struct rmpentry *e;
+	pte_t *pte;
+
+	if (unlikely(!cpu_feature_enabled(X86_FEATURE_SEV_SNP)))
+		return RMP_FAULT_KILL;
+
+	/* Get the native page level */
+	pte = lookup_address_in_mm(current->mm, address, &level);
+	if (unlikely(!pte))
+		return RMP_FAULT_KILL;
+
+	pfn = pte_pfn(*pte);
+	if (level > PG_LEVEL_4K) {
+		mask = pages_per_hpage(level) - pages_per_hpage(level - 1);
+		pfn |= (address >> PAGE_SHIFT) & mask;
+	}
+
+	/* Get the page level from the RMP entry. */
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
+	if (!e)
+		return RMP_FAULT_KILL;
+
+	/*
+	 * Check if the RMP violation is due to the guest private page access.
+	 * We can not resolve this RMP fault, ask to kill the guest.
+	 */
+	if (rmpentry_assigned(e))
+		return RMP_FAULT_KILL;
+
+	/*
+	 * The backing page level is higher than the RMP page level, request
+	 * to split the page.
+	 */
+	if (level > rmp_level)
+		return RMP_FAULT_PAGE_SPLIT;
+
+	return RMP_FAULT_RETRY;
+}
+
 /*
  * Handle faults in the user portion of the address space.  Nothing in here
  * should check X86_PF_USER without a specific justification: for almost
@@ -1298,6 +1350,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	vm_fault_t fault;
+	int ret;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -1378,6 +1431,22 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+	/*
+	 * If its an RMP violation, try resolving it.
+	 */
+	if (error_code & X86_PF_RMP) {
+		ret = handle_user_rmp_page_fault(error_code, address);
+		if (ret == RMP_FAULT_PAGE_SPLIT) {
+			flags |= FAULT_FLAG_PAGE_SPLIT;
+		} else if (ret == RMP_FAULT_KILL) {
+			fault |= VM_FAULT_SIGBUS;
+			do_sigbus(regs, error_code, address, fault);
+			return;
+		} else {
+			return;
+		}
+	}
+
 #ifdef CONFIG_X86_64
 	/*
 	 * Faults in the vsyscall page might need emulation.  The
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 322ec61d0da7..211dfe5d3b1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -450,6 +450,8 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_PAGE_SPLIT: The fault was due page size mismatch, split the
+ *  region to smaller page size and retry.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -481,6 +483,7 @@ enum fault_flag {
 	FAULT_FLAG_REMOTE =		1 << 7,
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+	FAULT_FLAG_PAGE_SPLIT =		1 << 10,
 };
 
 /*
@@ -520,7 +523,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_PAGE_SPLIT,	"PAGESPLIT" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/mm/memory.c b/mm/memory.c
index 730daa00952b..aef261d94e33 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4407,6 +4407,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+static int handle_split_page_fault(struct vm_fault *vmf)
+{
+	if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		return VM_FAULT_SIGBUS;
+
+	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
+	return 0;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -4484,6 +4493,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
+
+		if (flags & FAULT_FLAG_PAGE_SPLIT)
+			return handle_split_page_fault(&vmf);
+
 		if (pmd_trans_huge(orig_pmd) || pmd_devmap(orig_pmd)) {
 			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf, orig_pmd);
-- 
2.17.1

