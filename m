Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B13BEF1F
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhGGSk4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:56 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:36832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232479AbhGGSkk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwooQ1uoedAAklpwTCWjPusVxm+wQ26AyuLqNjdINWrIQJck/LLXPCVYQhBjkfKs4aCakDuIBeo4qmXp7FgEgfd9ENMBK+2mkyWBbjUxAKFCOZJScQEppCJvTnHvxqRL4ifryEoCkqmXwHG+BrO88lAAaCQ8EAh5Qv1iLGUeu9yHGnZ6hPFqlNzMftj9K5tkNH+NyrUTLVRsDbgF3bvRMjWC1r+wey2g8gSZMVlNdbCT5erC3p56fGrtg2qIeaG390V97BNUXWmX6lvRcORRRKu6kQpjjg20Aav3SFiKWYV6G/ks2fIPLbkb8o6HA+tu12AEmlNIM4xjPx5pafIcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw+QyiHFFdW/X8hC6sJAwb+ezTMuBysW35k9e/eZNg0=;
 b=AGx8RwYhGggIxMKGSYw6FoBVIKPaFqHqQ/8Sjv8Px464Dluy1yWIGghHW0NJUXT6IglYmRA2piHvCzuaNkrOq7+Tbf3ES7rpPuUOjrXmd0TNKNw2zS4cfXgTcGT/3t4AHXBlARxvFNJ6+23isP+f02W1ZxKo6PCXaTiuHrD+CYvjuYS1mi3ajTzMKrCvlqP4WKoA+MAJeUzaiuNFJ7UpCdF7Y9+RQwPwp47qa4pD7Fv7HY5XgdPFgvB9nkR0Wp+KSq9N8rf0Mynru+ER00G/N3xid5B8g9vnUgfOtFGDBYH5VcdaBcepnvVwMRtMrf5d/kpovIWXrMa36CRg6soz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw+QyiHFFdW/X8hC6sJAwb+ezTMuBysW35k9e/eZNg0=;
 b=K/UDIKWW6lsXu9kq8XB0mkoS7FLSM0a6u6pxK820BIujuLytruAMYKUknLsKM8BApuck1Y8hD6IJ+lmpsy0tFf+i1BOOLRYvFB96njh+0V5/BPMO4fvudb9GefTdMM5cifR+/KyU1HRKPCxZLudsjV2Ku/hP6t25/QcY4k1E8rM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:37:57 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:57 +0000
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
Subject: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_UPDATE command
Date:   Wed,  7 Jul 2021 13:36:00 -0500
Message-Id: <20210707183616.5620-25-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1a2cfc-c987-4c9b-71bf-08d9417656d9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082E5FF622F61C24E41A680E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bp4zkrDBQYQtyUCU116RnRCGzLv/g3O5Yf838Gi3oKIvQs7zpI2s2mf4ezvriZENYi5YMKVezZHzbcYxBw1U1zp/C6Asn7sWc/VV/vuq1HyrJDjtzqFe8axIjcuI3+zoGZVOz1M8dScjuZZLGGmXtMjUR+1skOWFTENaOZYIlTYwtOOgRR9RZF+ZJ1X8kNJTxZJPLWssIsPSr05oPmPXeM3yD6t4NVJkVLb9W/ehySjGjvOzxwT46CaNVVDcr+hM6AOMsuJaQsNw3CiHsWLwQ+TQt7R/sq94IcnNm2skNhFMP8AEkS4sixEfSYneAW5ueIYe/AZhttgXfswVndFFfOQtHrkbOILsOycahNr1HW8M5jcQhmLuLuzLkryD4HGi/J+BrzvTpyGIsXoUX5z17yVNvmTKYOgi3KWwtOIi/boZti5+eDKFI9PBmTE8GOXdhZ6lVIqVkaQdmKaUNl3fVmWDI3hPN7lQZg/Ye2lxoshNV5WT508NcOmqZ4zSUxA7MFMpnGfX+bAJ5eP/iQcSIc32FzRXcn9dd46Y0cP46OggyFKXPt1L6JEnxo7oAsGye/UOzImn05Rk+fUJN4o4R1/bAPYLLh1siwRDLrmu0fvirX3NdBAa66s745IbK4V1K6Ix9TjGzKKJED+wJSbODGsTF8FbVTDwdqQYSFn+5+e3B0o4KZQdsKKEh/L1nEQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(83380400001)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1yW85ZJgxRYun1vZSRVIsysCBLwaf1rt/IhDJMa70GKPNCcz7SN8DzA2srO?=
 =?us-ascii?Q?bZLwzKhL25U5XTncL2bY0i4UGkbrT60hAh0HG6M0RVjqIPyQoO6IJdUivmzq?=
 =?us-ascii?Q?CzsV+fJO4FAC/bWkLg31VmBDOvrROr/1OF8KyhtRjcTTBUHxGwPXR3nKvb0h?=
 =?us-ascii?Q?0KLCa1IRlEsjRopyK0RV8CJUByKJCdFtFZq68BGVHDeDDyPPQRfVRnBKouNp?=
 =?us-ascii?Q?GmeoKTdHhv8LAt3LehAiviiUcRITQog6hh8EfbVBua7g0uOeIz29saiBw3FM?=
 =?us-ascii?Q?dqd25u0FpjAgqLJ9mxNwv/iUvI/gHCr0Xh887mmqxGhNDjNRC8496tpC2hey?=
 =?us-ascii?Q?4CqotHwpF91q+6qEpIQoCwqmJA1hhHPOrkPnTIx/O/xHVoTGdUQWEBV4amwD?=
 =?us-ascii?Q?bgKVIgahpwUSi7KEr/pOBDNvkWKeBCojumK56VWfpKDYwCE6P4M59mLzHr3X?=
 =?us-ascii?Q?C136rvrAhwnFfwOzoaOQ1ZxkfCjxrHgLQfFD5g9H9ExbE+Dk3FrKihT1U1b/?=
 =?us-ascii?Q?lAjNyxpBNJhvk2xBdnioNiPnbWNSRxpYFCKeTVJfMg5tYh0Tqmkhbp1IEGoT?=
 =?us-ascii?Q?rcNXccbYH0Ndj7AxAIDbUL7zLNp8XFs1Y6MDDr7H9VVL7BOBdzPophoBy4kI?=
 =?us-ascii?Q?ghYzW3NC0sqUkQW7XiOe8tsG9aecR6Z3IuUJNapDSWNUL3gnMVpo6WXSO7uL?=
 =?us-ascii?Q?NUfBnvMAnf+L/Ntbj7K0OPb7js+gQaMfR9oYsVEcBbDBEHmaMA9KO7UVjTnv?=
 =?us-ascii?Q?gLlPi0s18o8omlyupeLY7GPh6gyyXhBdRxPJgyG20IO9+tJyYBc9iM8nU64Z?=
 =?us-ascii?Q?K49P1m/wBhdtnV0LQUP2eE5dk6h78TYvIsK0urkm15B2qEwJOqiZ7V0sFaJj?=
 =?us-ascii?Q?CWHa0A7JteNJY5h7uMEDoqcqe21i4dnpK+jEoO0mj7UnM17dXBi5F2w6Z3T/?=
 =?us-ascii?Q?AbL4tEdEVVNOVvlenZ8GEjbNnsxB3yL+/BXsS4yO6P0VjJXTgkMTcy3XgmG4?=
 =?us-ascii?Q?qu+PcWQuNaOoxeCfj411hjzhiKvuaX5o6VmmCenhmnlNjg2jhYt8FZc/mI8l?=
 =?us-ascii?Q?Q/dm6O9e1NFIfcIR4DClLNFEuXUHaO1o4XOkdkelq8kg8fczduyoCL8VVMhn?=
 =?us-ascii?Q?/QylqpL4x/IP2J0xIFPzUwPg9OQLTzEDFXyZDWuXW3PXGRgAn5c1JdetoiLK?=
 =?us-ascii?Q?SAEzhOgYLtIOH0JEfrT8et1ZXRYNlpQ1ORuhPpRHIKV1gJqqbpBrB5dxguGD?=
 =?us-ascii?Q?528KmakYycsrGSTaMC64985fvtLUOkVw8HZ48FPjNIvErz8H0pg0JS3HDY0a?=
 =?us-ascii?Q?0oSLgkZJmNmQ4h8hQeaZmmzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a2cfc-c987-4c9b-71bf-08d9417656d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:57.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8LcVRtZJUKANq64Le4SdGnBUkhZD0YUJhgTxwQ6dT6ximNPM1COsTO0CGPbwFuvxEXV7B/lW8dUl/5V9seQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KVM_SEV_SNP_LAUNCH_UPDATE command can be used to insert data into the
guest's memory. The data is encrypted with the cryptographic context
created with the KVM_SEV_SNP_LAUNCH_START.

In addition to the inserting data, it can insert a two special pages
into the guests memory: the secrets page and the CPUID page.

For more information see the SEV-SNP specification.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 .../virt/kvm/amd-memory-encryption.rst        |  28 ++++
 arch/x86/kvm/svm/sev.c                        | 142 ++++++++++++++++++
 include/linux/sev.h                           |   2 +
 include/uapi/linux/kvm.h                      |  18 +++
 4 files changed, 190 insertions(+)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 8620383d405a..60ace54438c3 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -468,6 +468,34 @@ Returns: 0 on success, -negative on error
 
 See the SEV-SNP specification for further detail on the launch input.
 
+20. KVM_SNP_LAUNCH_UPDATE
+-------------------------
+
+The KVM_SNP_LAUNCH_UPDATE is used for encrypting a memory region. It also
+calculates a measurement of the memory contents. The measurement is a signature
+of the memory contents that can be sent to the guest owner as an attestation
+that the memory was encrypted correctly by the firmware.
+
+Parameters (in): struct  kvm_snp_launch_update
+
+Returns: 0 on success, -negative on error
+
+::
+
+        struct kvm_sev_snp_launch_update {
+                __u64 uaddr;            /* userspace address need to be encrypted */
+                __u32 len;              /* length of memory region */
+                __u8 imi_page;          /* 1 if memory is part of the IMI */
+                __u8 page_type;         /* page type */
+                __u8 vmpl3_perms;       /* VMPL3 permission mask */
+                __u8 vmpl2_perms;       /* VMPL2 permission mask */
+                __u8 vmpl1_perms;       /* VMPL1 permission mask */
+        };
+
+See the SEV-SNP spec for further details on how to build the VMPL permission
+mask and page type.
+
+
 References
 ==========
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f44a657e8912..1f0635ac9ff9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -17,6 +17,7 @@
 #include <linux/misc_cgroup.h>
 #include <linux/processor.h>
 #include <linux/trace_events.h>
+#include <linux/sev.h>
 #include <asm/fpu/internal.h>
 
 #include <asm/trapnr.h>
@@ -1624,6 +1625,144 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return rc;
 }
 
+static struct kvm_memory_slot *hva_to_memslot(struct kvm *kvm, unsigned long hva)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot;
+
+	kvm_for_each_memslot(memslot, slots) {
+		if (hva >= memslot->userspace_addr &&
+		    hva < memslot->userspace_addr + (memslot->npages << PAGE_SHIFT))
+			return memslot;
+	}
+
+	return NULL;
+}
+
+static bool hva_to_gpa(struct kvm *kvm, unsigned long hva, gpa_t *gpa)
+{
+	struct kvm_memory_slot *memslot;
+	gpa_t gpa_offset;
+
+	memslot = hva_to_memslot(kvm, hva);
+	if (!memslot)
+		return false;
+
+	gpa_offset = hva - memslot->userspace_addr;
+	*gpa = ((memslot->base_gfn << PAGE_SHIFT) + gpa_offset);
+
+	return true;
+}
+
+static int snp_page_reclaim(struct page *page, int rmppage_size)
+{
+	struct sev_data_snp_page_reclaim data = {};
+	struct rmpupdate e = {};
+	int rc, err;
+
+	data.paddr = __sme_page_pa(page) | rmppage_size;
+	rc = snp_guest_page_reclaim(&data, &err);
+	if (rc)
+		return rc;
+
+	return rmpupdate(page, &e);
+}
+
+static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	unsigned long npages, vaddr, vaddr_end, i, next_vaddr;
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_snp_launch_update data = {};
+	struct kvm_sev_snp_launch_update params;
+	int *error = &argp->error;
+	struct kvm_vcpu *vcpu;
+	struct page **inpages;
+	struct rmpupdate e;
+	int ret;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	data.gctx_paddr = __psp_pa(sev->snp_context);
+
+	/* Lock the user memory. */
+	inpages = sev_pin_memory(kvm, params.uaddr, params.len, &npages, 1);
+	if (!inpages)
+		return -ENOMEM;
+
+	vcpu = kvm_get_vcpu(kvm, 0);
+	vaddr = params.uaddr;
+	vaddr_end = vaddr + params.len;
+
+	for (i = 0; vaddr < vaddr_end; vaddr = next_vaddr, i++) {
+		unsigned long psize, pmask;
+		int level = PG_LEVEL_4K;
+		gpa_t gpa;
+
+		if (!hva_to_gpa(kvm, vaddr, &gpa)) {
+			ret = -EINVAL;
+			goto e_unpin;
+		}
+
+		psize = page_level_size(level);
+		pmask = page_level_mask(level);
+		gpa = gpa & pmask;
+
+		/* Transition the page state to pre-guest */
+		memset(&e, 0, sizeof(e));
+		e.assigned = 1;
+		e.gpa = gpa;
+		e.asid = sev_get_asid(kvm);
+		e.immutable = true;
+		e.pagesize = X86_TO_RMP_PG_LEVEL(level);
+		ret = rmpupdate(inpages[i], &e);
+		if (ret) {
+			ret = -EFAULT;
+			goto e_unpin;
+		}
+
+		data.address = __sme_page_pa(inpages[i]);
+		data.page_size = e.pagesize;
+		data.page_type = params.page_type;
+		data.vmpl3_perms = params.vmpl3_perms;
+		data.vmpl2_perms = params.vmpl2_perms;
+		data.vmpl1_perms = params.vmpl1_perms;
+		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE, &data, error);
+		if (ret) {
+			snp_page_reclaim(inpages[i], e.pagesize);
+			goto e_unpin;
+		}
+
+		next_vaddr = (vaddr & pmask) + psize;
+	}
+
+e_unpin:
+	/* Content of memory is updated, mark pages dirty */
+	memset(&e, 0, sizeof(e));
+	for (i = 0; i < npages; i++) {
+		set_page_dirty_lock(inpages[i]);
+		mark_page_accessed(inpages[i]);
+
+		/*
+		 * If its an error, then update RMP entry to change page ownership
+		 * to the hypervisor.
+		 */
+		if (ret)
+			rmpupdate(inpages[i], &e);
+	}
+
+	/* Unlock the user pages */
+	sev_unpin_memory(kvm, inpages, npages);
+
+	return ret;
+}
+
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -1716,6 +1855,9 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_START:
 		r = snp_launch_start(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_LAUNCH_UPDATE:
+		r = snp_launch_update(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
diff --git a/include/linux/sev.h b/include/linux/sev.h
index bcd4d75d87c8..82e804a2ee0d 100644
--- a/include/linux/sev.h
+++ b/include/linux/sev.h
@@ -36,8 +36,10 @@ struct __packed rmpentry {
 
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
+#define RMP_PG_SIZE_2M			1
 
 #define RMP_TO_X86_PG_LEVEL(level)	(((level) == RMP_PG_SIZE_4K) ? PG_LEVEL_4K : PG_LEVEL_2M)
+#define X86_TO_RMP_PG_LEVEL(level)	(((level) == PG_LEVEL_4K) ? RMP_PG_SIZE_4K : RMP_PG_SIZE_2M)
 
 struct rmpupdate {
 	u64 gpa;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dbd05179d8fa..c9b453fb31d4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1681,6 +1681,7 @@ enum sev_cmd_id {
 	/* SNP specific commands */
 	KVM_SEV_SNP_INIT = 256,
 	KVM_SEV_SNP_LAUNCH_START,
+	KVM_SEV_SNP_LAUNCH_UPDATE,
 
 	KVM_SEV_NR_MAX,
 };
@@ -1790,6 +1791,23 @@ struct kvm_sev_snp_launch_start {
 	__u8 gosvw[16];
 };
 
+#define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
+#define KVM_SEV_SNP_PAGE_TYPE_VMSA		0x2
+#define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
+#define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
+#define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
+#define KVM_SEV_SNP_PAGE_TYPE_CPUID		0x6
+
+struct kvm_sev_snp_launch_update {
+	__u64 uaddr;
+	__u32 len;
+	__u8 imi_page;
+	__u8 page_type;
+	__u8 vmpl3_perms;
+	__u8 vmpl2_perms;
+	__u8 vmpl1_perms;
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.17.1

