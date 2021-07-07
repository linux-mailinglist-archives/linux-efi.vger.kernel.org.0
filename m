Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444A3BEEEE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhGGSkT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:19 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232054AbhGGSkO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXXYuRRSLayg6qeK74dck6jOa69BrYtBUXmxw6Q4aWnj3lSpsb7VwgKJsyhbkE/qAyXyf6g8xV4fDKAYyLqhJzVBTH7E+0juFboWJxBP3O1vXDLsiSPnv1mlrNHxvVSFMSAkUREJe/ExC34exOFEuBRfZGcRKgEPU4ApPI8ja8ao0Anu5q8NDCfTqpze64ikolXoT8LmhyzuCGN8aJrwKlbnQeHPkkRNI4/ImD1jZANQtXqR138fBdU/gMgW63AemX0yEGxTmJDYqNXOJ1m3RPrk3YLaep8qAaVypN+gNcWjFNyqj4u++mlXQLcg9cZIfovb2JeCEZrheWuRaTdDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ObO9K6loxHrMjGpmBDX7cm6oM+IxUTu/qDRMC2Fg8=;
 b=C14EcQpbzBGeRa87ziu/vlLeRWTeHX7wf1liFWqVl3uf4z4B1tNYjfsc2PbVkozP8j1G9GSlI4zysNzNF9tqoIcbs8O7G4iMtheuAkzeIJ8aJRtzz+YMasomfledscvdK4CoM+ImWEB9MkBGHHRbz5fJLSA19nPYxuDTCnRKk/mgQTBTSn1vAQPWcW2xAIn64ab0baAfvBNYa67hDbWsdy+RBNxmZlYaaO8uTBis2qMXgTBori2boJtVuJ8PGsVB98cP0M936oZAcJjzs7GG34Iw6Kef4T09/KhpzBT4poFcWpet8RRvl6dCYH0zM6YzfIR0xcUQF98b/Nno16nhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ObO9K6loxHrMjGpmBDX7cm6oM+IxUTu/qDRMC2Fg8=;
 b=Vsbc1NUBn6H/ex2quaOko5wAvQVaAJESeRKeLcQioSXBytanGRCGQwG8VVIR9QjrKMozBkR6fpnG4d7iHed6I3f0JKGLUWPe9vngl4mpbaptg8u0G+RgVSTIzPE4LT9cQc7TYTRW2fUSpJIGCPwJumPr9AbSB5hoiIhapkObXhE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:17 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:17 +0000
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
Subject: [PATCH Part2 RFC v4 09/40] x86/fault: Add support to dump RMP entry on fault
Date:   Wed,  7 Jul 2021 13:35:45 -0500
Message-Id: <20210707183616.5620-10-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522fa53f-4453-4343-9c05-08d941763f4c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28087EC2F062CC470B48D5EAE51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU3h5mqQCFl8YkDTfRp5K4Lz7gR3wNHSM/NbqBlx2LXZTcM3vlrzHMqzMbcYtc+fQJeRGKcZzB8yyJAvXlLmVXWLMf2n0ydzx08CvrSBETPvXKYL2j7YnRMP+sItUCMPHB+AFkkCI5qs99bDVhiV6DRD8RSCnh/2OVP4SdRd3jFYN1+JNwLJDk2+ZA3zHAO2X0/RBZVkL5rlC5Pyz0/4H3ohY4k/pkSyTdYno5ijgBG9biDaS54aOp1i1U+5VHuM3JtlQYz/7+KXd1ZxXbth2tCHrHr2pxo4O+ViM/AE/0JkwREoH1hlcIOQ2TeHkyWCXN4U6w6QdY54W/oWfanlw4AqBrDS3RpdsGs0iG8IGW7I/aN38vR293LpobFZvT1NHrs6/83Feaiwbm3fz0dPDAf/uHyKSBPkxH2hXlRgsCkkfKP0hWdfOp82vh7/uRqDtjOhb+6NqlBdmU83+b23tWhORyJ8jqHilikDqqfcq+Qi+LZ5QRHBw881hsjU6ebfAbvNBj7K73sY3EgK1Pf7NSgZs3IDm5GkKkKmvzPNEGcg/ybHXnDKfAwyf5e1flYmRSGch5YRExpp9vFTerTOKLDwR/rqYFBHY7JbYP8QWAOFBAgY9q+Q4LeHXpOEUVNrdVEYTCt3dB1IcBQkVQBQJ3vYEQfs2+QbxzTXTnyVMHUXoX0BEzskgKk1C6xIvrTO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ggORShfZ9s/xfC9r1gKV2Gg53aUkl9LzF6dJFqXF4jTERxWRjNDDJmlWvPH?=
 =?us-ascii?Q?4GgSoY8cZTrPejSEipSODMzpmZm1PQOuSBTXcqWHk7BZEY06eozvosrQIoxt?=
 =?us-ascii?Q?lhTFYXB/9fuzFDOsEYzsQhKhF6T7ABgd8JaH8gsGU8wt+1nZgnlA7jyCk3Vn?=
 =?us-ascii?Q?XiKI5JeepHkgSkravSIBKkD6L1Ox2G7JIDG4lIN1qiTTp08K8fNkat/QH5W+?=
 =?us-ascii?Q?w1rU1wscvlV5NTjH/gcm0T8aYVRw7NftdWUOhMhVQLPfUm5L+PpqpkjmWNUj?=
 =?us-ascii?Q?7TJnYmf4jxcExMGUURPZRDzXu6nMb2kZU87NOr79nA1OzHszMguvNQNPqa9W?=
 =?us-ascii?Q?S19EH5RrvbF5/zluh4aISRDQiuBaZe6qxGNA6/sz7lss1MBjDLL1zEmGVvPK?=
 =?us-ascii?Q?CnFzz3O+fmEMKOsRJOpv1TtbmS+G7n15JJDYmQb0mj2yZuQ3Jvtlz1BFEIH+?=
 =?us-ascii?Q?G/YeOEyb22s/MKZhpPsYnQnMgDHhOp34pTcyaj26/iI8eXvWLcHMXe5I9yid?=
 =?us-ascii?Q?THLo2kkv0PbsCc0YtQxzg9fcICrCsmkdMDyHqafilsf+uQSG6g9hZfCB7oOX?=
 =?us-ascii?Q?6/e5pnGAjVD215WTOwJ5N79q+MJ4HF6LLY6o1xDiGX+QFvD7jhZKyDnyQAwg?=
 =?us-ascii?Q?mvfgCAMtCukio9odp4Z5YY/WKcZWMSFFzVUPn7cno1Qb0NX4bDg8r73w7NG0?=
 =?us-ascii?Q?z9daZXD5ndTP9jQzu6lMrFLftcFz7RDjIHrXan0hm0aB1JvNRwMgzP6LR35s?=
 =?us-ascii?Q?FHFFD3Xc+93BT/l3wwdkl4j0dOTD0NNaMDYwGTMdzlwq+ym8P0U1xg8VI79o?=
 =?us-ascii?Q?3/L1XETJvXcZnVLJkJblFTkSdBqxCPaRLFeQ8ZHwkBjJ5Ara8gB18XjOoYwL?=
 =?us-ascii?Q?ZHUKro4sbSFm0z8MdixnWHvGhsjZTlc8t/mxcKPwnaFmm3ZMr0Zyd253HZvY?=
 =?us-ascii?Q?lIKX+KSVD1BooeuHKMwKkL1ijGf64i/pS4Yx1lknswdY/DXqAZ133DUmKBC2?=
 =?us-ascii?Q?QGUC2RRSRBxPxGz31jFbrDScuOqjxHu8Ow69vJYnKuebIKJRd24F8wQn1RtW?=
 =?us-ascii?Q?WCvV4byMIF0FmjTXDt/AvdIeSfZ5yDja9hkxGxgLsVtA6fQ536M2ppe19bTR?=
 =?us-ascii?Q?5z7RHPUGaKwuw3WpIi3kBH+aW7QRnwmtgjzkau1Lg9Htyk0+oLsNZn0mChZf?=
 =?us-ascii?Q?kn78LDZ6azc92t8ke8jQHs68zUdQ5UEQZHkONdZWpNeJxuJ/M3D5v7ygn7Lh?=
 =?us-ascii?Q?hPW9yCxU6F4RFzKH/3vNthD/PC6X1RRWfJrrqPjVhsc1+K3WJu8Ssjne6+WG?=
 =?us-ascii?Q?FHR/UWfB7q9o965GofZ5p/2x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522fa53f-4453-4343-9c05-08d941763f4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:17.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIw/1Kt2higPTPOkUnUOuWyoXPUYxsd1e3cO/BmQMirNeR1xFVqQO77gWZ0UBxKlJOED7pHKqLRrQcbXFNTYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When SEV-SNP is enabled globally, a write from the host goes through the
RMP check. If the hardware encounters the check failure, then it raises
the #PF (with RMP set). Dump the RMP table to help the debug.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/mm/fault.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2715240c757e..195149eae9b6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/sev.h>			/* snp_lookup_page_in_rmptable() */
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -502,6 +503,81 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
 }
 
+static void dump_rmpentry(unsigned long address)
+{
+	struct rmpentry *e;
+	unsigned long pfn;
+	pgd_t *pgd;
+	pte_t *pte;
+	int level;
+
+	pgd = __va(read_cr3_pa());
+	pgd += pgd_index(address);
+
+	pte = lookup_address_in_pgd(pgd, address, &level);
+	if (unlikely(!pte))
+		return;
+
+	switch (level) {
+	case PG_LEVEL_4K: {
+		pfn = pte_pfn(*pte);
+		break;
+	}
+	case PG_LEVEL_2M: {
+		pfn = pmd_pfn(*(pmd_t *)pte);
+		break;
+	}
+	case PG_LEVEL_1G: {
+		pfn = pud_pfn(*(pud_t *)pte);
+		break;
+	}
+	case PG_LEVEL_512G: {
+		pfn = p4d_pfn(*(p4d_t *)pte);
+		break;
+	}
+	default:
+		return;
+	}
+
+	e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
+	if (unlikely(!e))
+		return;
+
+	/*
+	 * If the RMP entry at the faulting address was not assigned, then
+	 * dump may not provide any useful debug information. Iterate
+	 * through the entire 2MB region, and dump the RMP entries if one
+	 * of the bit in the RMP entry is set.
+	 */
+	if (rmpentry_assigned(e)) {
+		pr_alert("RMPEntry paddr 0x%lx [assigned=%d immutable=%d pagesize=%d gpa=0x%lx"
+			" asid=%d vmsa=%d validated=%d]\n", pfn << PAGE_SHIFT,
+			rmpentry_assigned(e), rmpentry_immutable(e), rmpentry_pagesize(e),
+			rmpentry_gpa(e), rmpentry_asid(e), rmpentry_vmsa(e),
+			rmpentry_validated(e));
+
+		pr_alert("RMPEntry paddr 0x%lx %016llx %016llx\n", pfn << PAGE_SHIFT,
+			e->high, e->low);
+	} else {
+		unsigned long pfn_end;
+
+		pfn = pfn & ~0x1ff;
+		pfn_end = pfn + PTRS_PER_PMD;
+
+		while (pfn < pfn_end) {
+			e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &level);
+
+			if (unlikely(!e))
+				return;
+
+			if (e->low || e->high)
+				pr_alert("RMPEntry paddr 0x%lx: %016llx %016llx\n",
+					pfn << PAGE_SHIFT, e->high, e->low);
+			pfn++;
+		}
+	}
+}
+
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
@@ -578,6 +654,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	}
 
 	dump_pagetable(address);
+
+	if (error_code & X86_PF_RMP)
+		dump_rmpentry(address);
 }
 
 static noinline void
-- 
2.17.1

