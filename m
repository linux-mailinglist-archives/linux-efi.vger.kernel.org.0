Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58783BEE21
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhGGSTb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:31 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:17601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231441AbhGGSTU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA0yElsDkhD6LI1EkXFuw+ZGYefpnayJv0WFEGvQsIsnxZVgTga7xFh/xLoJN3B+BDGhtUiEPAqxiZk3aNs4R+y37z/mez9VMsKk/a4GvKrtnhLXXRHm34DBhE5U7QikUL9LNsLuYAqU9Tnnam5i7wz95m25i7dRXOsqIC6JN0DIWNQVgJIwA+77BtHRhhHshzyrDthX2WM3jbUfd4O+Vj1zeoFR+FKA5CAs5dv8jzwilrjTUHT2hBvwmSWPEjghz+7+UAl4PPuzfEZ78i7qHahw7eMVanN/vy3XyylwYuJFqhkqymy82zYFMIfngw9r9vfv1M2amtZ10gcJ0I02yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nFihNeDzQrP2uPQ4cYtOE6S4l7eQRdRxyQTHNBaIxI=;
 b=F6vHwqN+wE6u1vFyygHjn8BPsb/6Oc9ywESmP7LwUj1N82TpxisqBmks5L5iMbsshCuRd+NMex9jbZOI2IzPPCfdHD7i5bXEc/VfMNvVreYK2xwmDLuXkU7MWF8B4/itY9Ilgy4lvOBPhuTcvTItuPIoAfNl3kZyMOhu1rEVNlYANLFuSjmCfm8Dk/PXjeFdu4OAdwpitJXa3oj+a2TYcfxk4nw5Ff1NK6xX4VF3M0kbtKk/74dEWRO75XDnUoct+bq1dApIho9e75QWsqJcfLZLlSUUWk5SQnFnlclVXvkKkP3vjb5rzoMt5a0Hxru6bRoa3sR1B/FRxaSicl0adA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nFihNeDzQrP2uPQ4cYtOE6S4l7eQRdRxyQTHNBaIxI=;
 b=jo8VT+BNMVuudRqtvaurdfk9/58ri3Rdyar7WMDPJfhsLYn6jkI+fyN45fk8+L+QLvMrSz5YmlA1xwcXq+FbkpJdgi0SmURGWpT+0VGYdadCOoL8HyKSSNRRGRjCF/yjy2HFOqkSKxd2/yKN8hP+k1rfN/3iM46OciKt9qJM1I8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4644.namprd12.prod.outlook.com (2603:10b6:a03:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 18:16:05 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:05 +0000
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
Subject: [PATCH Part1 RFC v4 15/36] x86/mm: Add support to validate memory when changing C-bit
Date:   Wed,  7 Jul 2021 13:14:45 -0500
Message-Id: <20210707181506.30489-16-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5992d06-c860-4c09-4607-08d9417348fe
X-MS-TrafficTypeDiagnostic: BY5PR12MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4644894AB60123E936FCF758E51A9@BY5PR12MB4644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8vYXOolZ+6Va0SwdFA+ZuyQ7Z0+XwEVqpO5htOZQg8pYP/GUDLrwr/HNAgaABW3Lt4q1MR4MV/Ev9HXC7ynIEd98GbyibaXu62imhBiR5+sfnoJ7tZbSR3FUgZe6SMW9OtCjyYPGSu3IYqyljNPI17yGN8dp2xLBFeyIs1CKadT1aZmvewRJjV+tTT+lGq6LfJAgEYjYE1MbxEC/F70pJUcAmZO3YgabW/q/i1fIVyZqRwqNdiLPkZBl6pJ8uNPs3cnN01PuONIZ1GMbXns5InCiQLGAj8pjU2CfLAeDiqqJt+NBPL0px7N7jP08lphadPJEwNRvB4fASDbMuKfSRLRMmnPenAgkl5SE92LeoYWzSm7Kk6YvC1b+EFoyMWevlNFzDBnOuEd319fM/2yO9H0ge6YdRcZDTPpxHUvocOIRBROKNplxFvfjnFHPKQZun+nVf/fjjo9E4bJKlRQGSRLGhSXM8iGaeC/zrGzX5dKt+iYnZ+cGjSqQf/kRqyiGYZSoc8oK13imOoxLdTfOW+Ddf7PucH9xWztrs9nneQDt87oyHN6115GBQ203+JEjnlNRUR61Vv4RO8IQ5lkTZnrsUxRg6AeJXAWSotMGElgv40l31FPhtsziccaLV3ETxDdAsTgWxij19wPZx4g56/Ot2sBBB5HPtNtYc/UE6lBOaFxj0ty+rijpGsw5xhbdNhDZFThs4+XDmiH15fQgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(186003)(6666004)(2906002)(1076003)(4326008)(83380400001)(316002)(6486002)(7406005)(26005)(52116002)(7416002)(66556008)(8936002)(38350700002)(5660300002)(956004)(36756003)(38100700002)(478600001)(15650500001)(66476007)(44832011)(7696005)(2616005)(8676002)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qe6EFsM5PJ5l35naOYGMrZ398Y94yvh5QIK7F7gflgwX87So0Bvi1Oica7ij?=
 =?us-ascii?Q?aZ6Qo8Av5CS/u+yspqbE/FUObMJJuYl/JPFU4YaXw/NwgVKPuyjmSUEigUDW?=
 =?us-ascii?Q?VrrGPxcJaudl9qRh3PeDTQNe5zXeppuMHaYLY/GdNgAbzidSynt7Zh6d2wTE?=
 =?us-ascii?Q?LBCYhFBeI0bRRJkR2GylJLVL4WHh479ZQ/IYCXKPpFh+xrHcowsNWFkD/haP?=
 =?us-ascii?Q?jmr3FUZwqLklNa+uPiNwY8ulqDWAX6gvpsVaU/GMayjuNkoMubp0r7Nabsx4?=
 =?us-ascii?Q?lwxi8PyryGx3voMMsURAp9t8gDMJpNCb2Z/4GaDQfxa0ucgh+NRuv/u39Iy5?=
 =?us-ascii?Q?KKMWTB6xS8TR2OkPuAkAekjRJsYOfUO0/A6m7Hu3MffuijaB/UTE96bqIO6r?=
 =?us-ascii?Q?ZBen/ft201mQCd2Oy25DBwslFK+lS0fNcnZjUbiAsYSHvE4vS3hpHcqYRp/E?=
 =?us-ascii?Q?i8YBk3x/5j9I7JC5rWSkC/S6GAqSTZI1Lw92CofWKXOWWOXwUHqy/kS6xHkY?=
 =?us-ascii?Q?vvwtMmrJ76haaaTjHX8bcGEPronoCVt92VX2lY0bHS0GQCehPBkv2SpHBc90?=
 =?us-ascii?Q?yYenjM4mYj9o0pxcLKF+DWJ5IcSgWWb3Nc3w8wwQYINWXyIiYSrS/lhRhUD4?=
 =?us-ascii?Q?Zg0RGMk3U8HReJPN5SGU6JyxSLF6URtRf/4hSCk2xXSW2BCIu6bSUl1CmKgn?=
 =?us-ascii?Q?1POielYX1DfoOMQ2GxulLEX/6taiMcpTATGA4t9tQtzkOn3NOblw0klxaoV7?=
 =?us-ascii?Q?+PGipLnLYQlXgrTeDtw/mJ/r5pIyNSJ3kkiOZEwOwOMl9BhxrnoUe5lrb09z?=
 =?us-ascii?Q?Mmn+CplXPTf1ixJCO+07fAQbW84YvkKLMbHw8URTO8wti1xnFMP5DKMWwfu5?=
 =?us-ascii?Q?Q7mAq1t5W8qUf7YZDAV07NRDxFVGXXLFVmiC5n5T36NZ+jlMIqFkoXS4oLEa?=
 =?us-ascii?Q?SyMevujSwKOG9V8rgPohs/W/j/i4iNDZ3dEO4ufG6I99zGlwSkpC+tmzTvft?=
 =?us-ascii?Q?SLdwGS+YuJGhlclg8v2ighPSplsQKDnz/BGU9V6as1rmWEB004A/+KPnt8Xi?=
 =?us-ascii?Q?zb+WbYadrJyEu2BU5377Ol7FufrCu/k79CZwQi6QwvSWsyeyQaYoZG8atoui?=
 =?us-ascii?Q?+n/UiTsIHRXKNVpN99fK/Nc7slS/fVY1HzypvvAnGyKcPCY5luH+o0REKerG?=
 =?us-ascii?Q?svjXft5WF1LO33NtU48didN3b1KTK5ZCn95PovGJuGourqnI4/sktyiEOQaj?=
 =?us-ascii?Q?egWuY9Ny9mGvWQaeZpewlOEnjeaOrzJH+A3BC/BGJgjSClN96obxCUOaXe/1?=
 =?us-ascii?Q?mgWUYQky4dApnvhcoSvaNJSy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5992d06-c860-4c09-4607-08d9417348fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:05.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2bxoUF212Q4yuGvui9aSz2w4sW/Oj8rvjdZR1dkc2ny7pI1+RxoG0li7ZJHsnp6LpktetYSnPLKUj2sVKi48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4644
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The set_memory_{encrypt,decrypt}() are used for changing the pages
from decrypted (shared) to encrypted (private) and vice versa.
When SEV-SNP is active, the page state transition needs to go through
additional steps.

If the page is transitioned from shared to private, then perform the
following after the encryption attribute is set in the page table:

1. Issue the page state change VMGEXIT to add the memory region in
   the RMP table.
2. Validate the memory region after the RMP entry is added.

To maintain the security guarantees, if the page is transitioned from
private to shared, then perform the following before encryption attribute
is removed from the page table:

1. Invalidate the page.
2. Issue the page state change VMGEXIT to remove the page from RMP table.

To change the page state in the RMP table, use the Page State Change
VMGEXIT defined in the GHCB specification.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  24 +++++
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/include/uapi/asm/svm.h   |   2 +
 arch/x86/kernel/sev.c             | 160 ++++++++++++++++++++++++++++++
 arch/x86/mm/pat/set_memory.c      |  15 +++
 5 files changed, 205 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b19d8d301f5d..2277c8085b13 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,6 +60,8 @@
 #define GHCB_MSR_PSC_REQ		0x014
 #define SNP_PAGE_STATE_PRIVATE		1
 #define SNP_PAGE_STATE_SHARED		2
+#define SNP_PAGE_STATE_PSMASH		3
+#define SNP_PAGE_STATE_UNSMASH		4
 #define GHCB_MSR_PSC_GFN_POS		12
 #define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
 #define GHCB_MSR_PSC_OP_POS		52
@@ -84,6 +86,28 @@
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 
+/* SNP Page State Change NAE event */
+#define VMGEXIT_PSC_MAX_ENTRY		253
+
+struct __packed psc_hdr {
+	u16 cur_entry;
+	u16 end_entry;
+	u32 reserved;
+};
+
+struct __packed psc_entry {
+	u64	cur_page	: 12,
+		gfn		: 40,
+		operation	: 4,
+		pagesize	: 1,
+		reserved	: 7;
+};
+
+struct __packed snp_psc_desc {
+	struct psc_hdr hdr;
+	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
+};
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9a676fb0929d..2385651c810e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -109,6 +109,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -121,6 +123,8 @@ early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 7fbc311e2de1..f7f65febff70 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_PSC				0x80000010
 #define SVM_VMGEXIT_HYPERVISOR_FEATURES		0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -216,6 +217,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 62034879fb3f..5fef7fc46282 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -694,6 +694,166 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
 		WARN(1, "invalid memory op %d\n", op);
 }
 
+static int vmgexit_psc(struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret;
+	struct snp_psc_desc *data;
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+	struct psc_hdr *hdr;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (unlikely(!ghcb))
+		panic("SEV-SNP: Failed to get GHCB\n");
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, sizeof(*desc));
+
+	hdr = &data->hdr;
+	cur_entry = hdr->cur_entry;
+	end_entry = hdr->end_entry;
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Checks whether all the entries
+	 * are processed. If not, then keep retrying.
+	 *
+	 * The stragtegy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest access the memory pages. If the
+	 * page state was not successful, then later memory access will result
+	 * in the crash.
+	 */
+	while (hdr->cur_entry <= hdr->end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2))
+			return 1;
+
+		/*
+		 * Lets do some sanity check that entry processing is not going
+		 * backward. This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN((hdr->end_entry > end_entry) || (cur_entry > hdr->cur_entry),
+			"SEV-SNP: page state change processing going backward, end_entry "
+			"(expected %d got %d) cur_entry (expected %d got %d)\n",
+			end_entry, hdr->end_entry, cur_entry, hdr->cur_entry))
+			return 1;
+
+		/* Lets verify that reserved bit is not set in the header*/
+		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n"))
+			return 1;
+	}
+
+	__sev_put_ghcb(&state);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static void __set_page_state(struct snp_psc_desc *data, unsigned long vaddr,
+			     unsigned long vaddr_end, int op)
+{
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned long pfn;
+	int i;
+
+	hdr = &data->hdr;
+	e = data->entries;
+
+	memset(data, 0, sizeof(*data));
+	i = 0;
+
+	while (vaddr < vaddr_end) {
+		if (is_vmalloc_addr((void *)vaddr))
+			pfn = vmalloc_to_pfn((void *)vaddr);
+		else
+			pfn = __pa(vaddr) >> PAGE_SHIFT;
+
+		e->gfn = pfn;
+		e->operation = op;
+		hdr->end_entry = i;
+
+		/*
+		 * The GHCB specification provides the flexibility to
+		 * use either 4K or 2MB page size in the RMP table.
+		 * The current SNP support does not keep track of the
+		 * page size used in the RMP table. To avoid the
+		 * overlap request, use the 4K page size in the RMP
+		 * table.
+		 */
+		e->pagesize = RMP_PG_SIZE_4K;
+
+		vaddr = vaddr + PAGE_SIZE;
+		e++;
+		i++;
+	}
+
+	/* Terminate the guest on page state change failure. */
+	if (vmgexit_psc(data))
+		sev_es_terminate(1, GHCB_TERM_PSC);
+}
+
+static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
+{
+	unsigned long vaddr_end, next_vaddr;
+	struct snp_psc_desc *desc;
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
+	if (!desc)
+		panic("failed to allocate memory");
+
+	while (vaddr < vaddr_end) {
+		/*
+		 * Calculate the last vaddr that can be fit in one
+		 * struct snp_psc_desc.
+		 */
+		next_vaddr = min_t(unsigned long, vaddr_end,
+				(VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
+
+		__set_page_state(desc, vaddr, next_vaddr, op);
+
+		vaddr = next_vaddr;
+	}
+
+	kfree(desc);
+}
+
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	pvalidate_pages(vaddr, npages, 0);
+
+	set_page_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+{
+	if (!sev_feature_enabled(SEV_SNP))
+		return;
+
+	set_page_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	pvalidate_pages(vaddr, npages, 1);
+}
+
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 156cd235659f..d09df2971d30 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -29,6 +29,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/sev.h>
 
 #include "../mm_internal.h"
 
@@ -2009,8 +2010,22 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
+	/*
+	 * To maintain the security gurantees of SEV-SNP guest invalidate the memory
+	 * before clearing the encryption attribute.
+	 */
+	if (!enc)
+		snp_set_memory_shared(addr, numpages);
+
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
+	/*
+	 * Now that memory is mapped encrypted in the page table, validate it
+	 * so that is consistent with the above page state.
+	 */
+	if (!ret && enc)
+		snp_set_memory_private(addr, numpages);
+
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
 	 * in case any speculative TLB caching occurred (but no need to flush
-- 
2.17.1

