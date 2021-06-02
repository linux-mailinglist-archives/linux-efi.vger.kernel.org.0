Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5E398BCA
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFBOJx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:09:53 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:37216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230386AbhFBOIM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu3C8XNTb7KbgZx3cGlt26Zrd4wHYSaNZEoZejp2R8AewFaFx3sICfh4A0opvXRLn0A2SxVTqd97M2QrxSVOJTmQXNa1S0nc2MbfubxjMdD7wkz1J8W12k+FGwqftSsByh2ZDUC+qqU6xpWQS0/y8BM02De60AZt+eJBmmV1KRRJv9DKyRqFq74Naj9KokN0UAAqiYXLAEikUdAz4mG79XvaI+6iClq4Ll0JAhCsYOKrMfYlcl/MFIp0vLwfzEejcPfjdwEi3ACbGz9SLXF/09eJhsF/M5W3jy6YCir7HLvFzty+og8PhOWIqXY5UdWMtnK3ANjtmumGJq5okf4zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7ZFKwoMevA3mMgIn1B+sT8tzfenkuPQ+1aptZ11G9Q=;
 b=fdw1oNFYCWiIUiPziErRNXP9NChNwsni7RRwuXtMfEx9wCqLHUov+XMkFZPg3B0C098kHyoVnC7j3SbAAP5sLF+Pf0r8jDSEiNymEvGC71k0p6a4MDfCu4tXs41hjf53xE0uMytCmXbrPdDfDDnr83iLzrg4pl8v5ffTDxAJKPX5Tn+XMIk0+1MKxJwwmttGEMSAyPikSop41KQB6fie/yHxrsUGQYvbsdEoBZInCSwyCh/3gG+WFPg67JUYyzwNpJ5uZiZuoNPaMTi16ejpMVPxn+qviXAQ14RKt6Nc/HDNGttltqMqr6M/cDEsXngiZAdpTqmwBBQk6yqLvr+1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7ZFKwoMevA3mMgIn1B+sT8tzfenkuPQ+1aptZ11G9Q=;
 b=hMtkvWSLsYKkUJsznO+CFwIjdLJXtmx/CUOCdRChCA+raxCWbzKPHlheH8USdJV3AaIG3eTdQAr24uL7bUOgXgqsxKUGjferNLNVtME7gbACiMKVaSG7TAObrFvtBODRpUBj5S0/AZFcwF+1aW56pYO/16suXIMrBudVaOP/OOo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:02 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:02 +0000
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
Subject: [PATCH Part1 RFC v3 14/22] x86/mm: Add support to validate memory when changing C-bit
Date:   Wed,  2 Jun 2021 09:04:08 -0500
Message-Id: <20210602140416.23573-15-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6babd7-b186-4cd1-16bc-08d925cf6a22
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB276623A930722E1282022E21E53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/2Oe0rMTHbuQdyKCN/Zw6cBpX0LLWMKmgtjGAdzHXGd40KxcDvvW/ZwjZ64q5QqYNNhZneyKIMRG4l1DllRffGHLoFJRFX4AxvhXQ6gz5mY4TvU0mvdUEgvE8GAh9iRiECOGXPu7mE9nMVjWyOOuxVi09a0Vk8xoI3YBCbrL00RqyykSRAWhcHSpSXc1exOFXCxXWomii7CMHZgSI4eNAt710gmHfeVMtsCDmhUlOT9YosiAa/B1jUOsllMUTVkGM+wo0Wen5etFNCTJ1SwadfOcUGsEAzAwTKAj7Py+VUaR8w8aYDsS3fY9zO3UhwEbMEPO6uPiThY/B8/4R+xo40XpkWfrn8HnYUjmmFTTLTNMrYeRJFO3djXTQyutCOHlqMQIXRjniqjfx+Xh29DkehptVgePFPFX/IjzbjrxmSBbZibtpFB95e83YwtLLB4PTK47MBUkt29uwiTu3XKlEX5YITHIpnxeSc5AqrCw1BKRfcCiQNV7wAiylhN+FDrRDufli1k0TavuQcox8juY8qt1+3OvTLi3swHhkByoaQTmp/IT8bmyiwXqZ360N6qaRl9cpya4OlwrqNKQ8P5MWpdqBjv2KN0+Gm7Q1KEOFonGKR+ELXEL031DagJqHFtLR5RGOHY+xwHieRbPmOlDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(66476007)(15650500001)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?02J8ThA/mmJ21nvCqksivziAhYC+svOZV3MqFMLz1TzJJqiQnqEeyacfwDTX?=
 =?us-ascii?Q?K9/so9n6gKuv865z6cVkrNLKSfM0J82ZkMJqRVpuRVX3rA2rOiBb1I8oCHBA?=
 =?us-ascii?Q?VFY1mNv8EQLtl/c5LrLQfBu2lfBTfkUTM3+YYSafpsFwNh4PuaxxKqm28Ph6?=
 =?us-ascii?Q?791DZBUxlITXiVwi5ngDHFLj7JzEuEMb9MTkVc4KHpSm1jYtsf1q+mcp+m5P?=
 =?us-ascii?Q?x6Hu+tz6qTb5L2Trct80t3/mrEi861J0dymArMTbl72uqHf1ib0ceehAc+La?=
 =?us-ascii?Q?3I8NsVvTfaLEE8jjXV1ntXf2cTRtlb1vZ6f8JORfjniXXYXF14Gilg9VGOsp?=
 =?us-ascii?Q?zlJ0O/ve3a0TG91sJ4Wp4VQaPuhJNh9GjCy0AfezSZk7fEo2i7JrwWscMN3q?=
 =?us-ascii?Q?3wGw7As6+tQ9XTyoCvprmOI9ih8OXE7GNhi3bpMaA+tjGCAncZN4+xJ86D/E?=
 =?us-ascii?Q?LCuRfI6zSycOu4jhgsfAQr+8mta/aEiOt7g09WJq43DNZdKPHe1cwMWHc83P?=
 =?us-ascii?Q?YXIt4W2IQp6L+k/6vEMb6uJr/myXrrXX7pUhgqTr5wh7gPUx3O8JUoqqCE/m?=
 =?us-ascii?Q?Rd0LAvPgjXtvAPISnZl/4pYutttMSLMky5+3P0nifndoH0eF7kwH/juKnvz5?=
 =?us-ascii?Q?uCEiAnBAfB5WMofXL53u4mtkRRNAu1jiAlReTT/d7AAY8HpRKT7KJdFZngWu?=
 =?us-ascii?Q?EYZE6HKOYvPX/rWd6A03W+ftznQcEYrU52l5uPkfkUvmXhrPGKwbZcVweCZs?=
 =?us-ascii?Q?H9wdkM49ByZyhs3Q72g2g9Wh3wyjgChJ7xooBZOTQPYSIf40VkUyQfZk486j?=
 =?us-ascii?Q?tViwn8RNevYo85+3U90g2mOSLKuVDOcYMdoT8zsXGE4Aqi/X55ZL5YPxTM2l?=
 =?us-ascii?Q?28xnz3S/fQPZ+pw9yGw+KKr4xtDfnuPhWuk/j8vdesK1mfgxBf9K6VpLx5qJ?=
 =?us-ascii?Q?A6tHW96PTnwC7Gg30f42FSh3bZV8MAMF/H/SibHacfOeOAzlaeuLHQMUDVLZ?=
 =?us-ascii?Q?HWc4vqV1hOICXyRF+jyiNWh8dLpC2YxmAxIMo2cuW9W+5s0GsYUZ/aPlrpBx?=
 =?us-ascii?Q?58x68tqF5YS7HUO+BJYki56+5EIElX1QhJqsjZ1gZQpOiEFM3xwbJIj81d48?=
 =?us-ascii?Q?3Dt8ePy69HKWH+1s4IBBnCbVQJYGWIBZpzfCRGlhNRivarFL1wD1MB+bD0uA?=
 =?us-ascii?Q?WiQcpNDEesnVjjQ8NiLw1cdj6tob8zw0Ut//p3Fgcg69kHQ1pv4TSuezFwRr?=
 =?us-ascii?Q?IKi1RN6zpsCkE4AOq6Nf6NgRuJqpOpoVH8ZdNrBtV5lZYh3Rza9vMPCDJwHP?=
 =?us-ascii?Q?OeE/5L7Qi8pY3RskGcNWxRKi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6babd7-b186-4cd1-16bc-08d925cf6a22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:02.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mtw2O/0DjWCV1lDJloWXdsLWiMV1y1UG9+BjG+AFcInqkRWvtmtgv6frYVGn6UTT8pdNyo4DpUtRgpvMJLah2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
 arch/x86/include/asm/sev-common.h |  24 +++++++
 arch/x86/include/asm/sev.h        |   4 ++
 arch/x86/include/uapi/asm/svm.h   |   2 +
 arch/x86/kernel/sev.c             | 107 ++++++++++++++++++++++++++++++
 arch/x86/mm/pat/set_memory.c      |  14 ++++
 5 files changed, 151 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index ae99a8a756fe..86bb185b5ec1 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -62,6 +62,8 @@
 #define GHCB_MSR_PSC_REQ		0x014
 #define SNP_PAGE_STATE_PRIVATE		1
 #define SNP_PAGE_STATE_SHARED		2
+#define SNP_PAGE_STATE_PSMASH		3
+#define SNP_PAGE_STATE_UNSMASH		4
 #define GHCB_MSR_PSC_GFN_POS		12
 #define GHCB_MSR_PSC_GFN_MASK		GENMASK_ULL(39, 0)
 #define GHCB_MSR_PSC_OP_POS		52
@@ -86,6 +88,28 @@
 #define GHCB_MSR_GPA_REG_RESP		0x013
 #define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
 
+/* SNP Page State Change NAE event */
+#define VMGEXIT_PSC_MAX_ENTRY		253
+
+struct __packed snp_page_state_header {
+	u16 cur_entry;
+	u16 end_entry;
+	u32 reserved;
+};
+
+struct __packed snp_page_state_entry {
+	u64	cur_page	: 12,
+		gfn		: 40,
+		operation	: 4,
+		pagesize	: 1,
+		reserved	: 7;
+};
+
+struct __packed snp_page_state_change {
+	struct snp_page_state_header header;
+	struct snp_page_state_entry entry[VMGEXIT_PSC_MAX_ENTRY];
+};
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7c2cb5300e43..e2141fc28058 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -114,6 +114,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 		unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op);
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -130,6 +132,8 @@ early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned i
 {
 }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 554f75fe013c..41573cf44470 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_PSC				0x80000010
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
@@ -215,6 +216,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_PSC,		"vmgexit_page_state_change" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 6e9b45bb38ab..4847ac81cca3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -637,6 +637,113 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, int op)
 	WARN(1, "invalid memory op %d\n", op);
 }
 
+static int page_state_vmgexit(struct ghcb *ghcb, struct snp_page_state_change *data)
+{
+	struct snp_page_state_header *hdr;
+	int ret = 0;
+
+	hdr = &data->header;
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest before
+	 * processing all the entries. The loop checks whether all the entries are
+	 * processed. If not, then keep retrying.
+	 */
+	while (hdr->cur_entry <= hdr->end_entry) {
+
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		ret = sev_es_ghcb_hv_call(ghcb, NULL, SVM_VMGEXIT_PSC, 0, 0);
+
+		/* Page State Change VMGEXIT can pass error code through exit_info_2. */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SEV-SNP: page state change failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void set_page_state(unsigned long vaddr, unsigned int npages, int op)
+{
+	struct snp_page_state_change *data;
+	struct snp_page_state_header *hdr;
+	struct snp_page_state_entry *e;
+	unsigned long vaddr_end;
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+	int idx;
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	ghcb = sev_es_get_ghcb(&state);
+	if (unlikely(!ghcb))
+		panic("SEV-SNP: Failed to get GHCB\n");
+
+	data = (struct snp_page_state_change *)ghcb->shared_buffer;
+	hdr = &data->header;
+
+	while (vaddr < vaddr_end) {
+		e = data->entry;
+		memset(data, 0, sizeof(*data));
+
+		for (idx = 0; idx < VMGEXIT_PSC_MAX_ENTRY; idx++, e++) {
+			unsigned long pfn;
+
+			if (is_vmalloc_addr((void *)vaddr))
+				pfn = vmalloc_to_pfn((void *)vaddr);
+			else
+				pfn = __pa(vaddr) >> PAGE_SHIFT;
+
+			e->gfn = pfn;
+			e->operation = op;
+			hdr->end_entry = idx;
+
+			/*
+			 * The GHCB specification provides the flexibility to
+			 * use either 4K or 2MB page size in the RMP table.
+			 * The current SNP support does not keep track of the
+			 * page size used in the RMP table. To avoid the
+			 * overlap request, use the 4K page size in the RMP
+			 * table.
+			 */
+			e->pagesize = RMP_PG_SIZE_4K;
+			vaddr = vaddr + PAGE_SIZE;
+
+			if (vaddr >= vaddr_end)
+				break;
+		}
+
+		/* Terminate the guest on page state change failure. */
+		if (page_state_vmgexit(ghcb, data))
+			sev_es_terminate(1, GHCB_TERM_PSC);
+	}
+
+	sev_es_put_ghcb(&state);
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
index 156cd235659f..20cd5ebc972f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -29,6 +29,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/sev.h>
 
 #include "../mm_internal.h"
 
@@ -2009,8 +2010,21 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
+	/*
+	 * To maintain the security guarantees of SEV-SNP guest, invalidate
+	 * the memory before clearing the encryption attribute.
+	 */
+	if (!enc)
+		snp_set_memory_shared(addr, numpages);
+
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
+	/*
+	 * Now that memory is marked encrypted in the page table, validate it.
+	 */
+	if (!ret && enc)
+		snp_set_memory_private(addr, numpages);
+
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
 	 * in case any speculative TLB caching occurred (but no need to flush
-- 
2.17.1

