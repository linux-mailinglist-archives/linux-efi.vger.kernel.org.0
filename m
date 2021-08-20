Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD393F2F17
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbhHTPW7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:59 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:40033
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241112AbhHTPWV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDLSvJUp7woQ3tiXwj2Q7b1F5ivgkMf2mpET4hIlu57ufkDGQ+LS55jF0fCUFIRFirZyqpPrZIsbvZlLQq2JT4MPtG126s+iazLPtsiVVQAwY3u6GWwm0hWbrg8uVDwx3lal/w2vYJDA3HXFueMjBdbn7R1pdm6C2Rn93CxYRtCBt4ZT5VuK3pbX998J1cawJdfbWCGOMR2m4hLs3Uvtah3VoTAsyVcboJDh8pVK+MskBJUmPFPR5ixk0sQBGDgZaauqxRlfU2wzTCZIbLOx79+vG/mZLkPoSMntZEPy6BaOiiXMskKFnSj9wfJC+JPXlz3JfCtw4MAY6E+QW9FA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSbJjpXf4ZAM86SXRaSKtnfJ0KgZZpjemjGJtTqJQYM=;
 b=oBs86YctdExZ+OwePQNkdanlYi1mrftwVWeq1gzPjhJn4Jo6WyGiA0yZ3xPPOhcUPCisp7h0xBAcFljoll0rX9vTOFcNJzXySd6fdugER8yI94+cHjRx3iVe2gk7g7rSL/Ns/sGy0B2Vhvvl4rl5aDpAJCTxGmCV7UvDqJi57ouKflBzqgAp5vBfxDX0kzpP4qqL/5084yH4eu5NFU+sN9kh2PSOCV5DoBwKKHLc8ZQmH8a+5oGxv9y6+p9aczo90uC5XPfS3MkC2OLi7m4EmygoxPq5tmDX8PaYB0tXL4NvLIgHdTS2pP9V2TvG6iBknd5l3mWzU+KUOXRSL0ZIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSbJjpXf4ZAM86SXRaSKtnfJ0KgZZpjemjGJtTqJQYM=;
 b=QQvl8UmQg0TxUlZWJnlK4yp1FwyyPIhNWTselXDjRcOTgNfdjlQRxgTqWYv/ni8v0j9AVb2fofRcXm4g7DEiTevCkqMjTKz2cy7JsF4tHoOrJ/zXRZkvPPwCA2pj+zHDJTRQmdgRZCSITuP6EtmBocPUMpSdk6pSEr8xf5AFMCM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:09 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:09 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 17/38] x86/mm: Add support to validate memory when changing C-bit
Date:   Fri, 20 Aug 2021 10:19:12 -0500
Message-Id: <20210820151933.22401-18-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6adb851-c2d6-49b0-69c1-08d963ee2313
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24463E1B5C35B4A6E6B68FEAE5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKGa/FgnhPekSZEBegpdudwQcJeIPEXlkFlO1uK1sfxRUOXyp3/Vl3qwR5hRgvaildCde2xMyr0OYb2cn0xZdEhvFB/BgPiFd3gGaXHsP7QI6I7vK/jV7RKKsOiXa9EOX8rgDYjfznZ/gChHV24IoDlD5Gqs8qWPTf7KseSjOdw4FNLQ1U/kFT2xVFIsX0Lya/8g2xRaYgwx2uBlitRSmmeEN2lKTW796sKg4PEAEigg9aR0RaqD2Z+R47ufpIJUC4i9L+RnNWfj/y2m1UQ057PAleOeVDsBFihQcZmlThnJGoCfWRQVNrdpTaMwfeDnvIO+XJSmFv0Goh6AcJYdFt5hdFjBQYSJUNw2IO6fNi+ojpeyva8hcjcETT7QC6WoY5pZcFtF5G0KCO7P62QTTT72/J/s8uARJfY36IkVNSHyQN9/nN7Hq7ImumNbqt9WsEr0eItXGfeWSRZVejJ8biL1IGqixZAaJUGzCvpjubtIfUS7VVFAoaKNchlCw/MXsZP1qz0IeMdFygTbN1LD6su3th5f+X50S6s7djwtGWif8F95ybD2Ci1HP3cf48a9js6in4UHfYlRKRtrYeIRhw30rIDwm557l1Ib0GBbdenypUe0wim0hD0CZIEzDxZLJtyamxmg0RDd+r+QMgIcfKl3clbxbZuzIA3htHsQuQGcJtdMT6pR17L43ab1M3tZ4aKPU9UFH8vddh1iCTTOmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(15650500001)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(6666004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5B9+YOLeDJp5arFXL+T9XwnaplwGLBdlDDfTnK6+/J1vysL/dmPHpggV8KYS?=
 =?us-ascii?Q?Y4iaeB2JJa4Ae7PqqInawyE4MqpsxnSfj/klD32Hj2lWABQA4YA+kwCV0Mty?=
 =?us-ascii?Q?tnmmDgDLeh9909ig+xopV2xx+pjVzU0Zg5uzOFKt6uGCqBOayTDnD7TNKpdY?=
 =?us-ascii?Q?KJZ1Nb+7s+ZZQkj86a2Kmb/vqhuZScRQMMo6/69gJSrKR6jeeWsAN6eozZNH?=
 =?us-ascii?Q?25lDLg5hBFovq9ffHDq1ABZwdEcYXRb02TVj/p9An7OJ7+7lAiKnTkjoTELu?=
 =?us-ascii?Q?jrkjqpHeUvlAaHHgqe+7I+I+uioj3ifxnZA/f1dzGiLl4LE5C01dMU+063Lw?=
 =?us-ascii?Q?vgtmln0+QcuLIMjXNFHNiDidD/tMSP177X90eAx/1ChShz6g19NkVNgG6FbG?=
 =?us-ascii?Q?speQdWiWFRXTS2YJlnSB3bJBgC5MGaW+CJRgVN105RYOr1kD1+DViuvn2F9W?=
 =?us-ascii?Q?mrEjFdfj+HT7jy/kxchhbDqr4IZd2LsPly1qo0xn/HbeB0HBVCjeKOatxM+O?=
 =?us-ascii?Q?srbZPEQLIH79yyLbILDhvNCZmtl61mGvvtaBxfeX39+ILmJe6OFclfX+gnND?=
 =?us-ascii?Q?DyS3CjH9ZtCHSV38qD+T4RPd0Qzdi8tDdxafcYd581pxANEwDEw7Qje2lH5r?=
 =?us-ascii?Q?O84DtzCA91eFwcSJw2DWsfRHyE3Bvx9SqOpJYMfJJrMzdgtfDDCc8/zmmzwO?=
 =?us-ascii?Q?KV/v5Wne5YBRg3DSTGw2ObCAx44juFLgKu+Y0WTvk1rAkIQ8kNiMbGeyGi75?=
 =?us-ascii?Q?IZLmi9hA1NDb7nQfc+wZxWo2cf+eswdWhNyYgn92IbuVPQK87j9f4CH+00Sp?=
 =?us-ascii?Q?0hZ5BwHA7A9A07bY3mpgvMXSGP6di1I9bW1NNxTOovU6NzE22OfCet1ujMnZ?=
 =?us-ascii?Q?iLATsOLrYT7Dt0JlfXPa6PL5PX+Wg4O0gFr5q94F/djC6s06p4xEWRVVELEF?=
 =?us-ascii?Q?QQ0tEb433A8ZkWWfIrcLOo8YGd9W5pSdAzdU3DLbBb9WvcufbWYmG9QuyePw?=
 =?us-ascii?Q?25AhSgJIMGFN+wU43wCPUrZh6TB7mVncHfm10wTYx+s9PGCJillEx7ivjeI6?=
 =?us-ascii?Q?Lgtw5r6i6MxieIERYZm5XF1TLSkV7Ehxh71F3e+P+QCdwqdeylDZLSFPBlG3?=
 =?us-ascii?Q?EMAFyXX+1XwINB+hnK/WDfks8u2jMG/gdcT3kaN4CwfJx0kkVb0Rw9rAOrKh?=
 =?us-ascii?Q?CZKYeRUOOhrVTu1jH9vjtEkHwGiUJqTolj31GGjos3RQwG4qQB3yFrJ0zwvk?=
 =?us-ascii?Q?iHX1Rzt9tQNU5KAn8GNGSL2cA35EXtpWPZPPqHZ8EAncT74jO8CaeHQpD5OU?=
 =?us-ascii?Q?vk5AhYSWylALMg4ubXjCySC+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6adb851-c2d6-49b0-69c1-08d963ee2313
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:09.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+7+wvmqb+HEC4TAo7BBYxlDlke+i1MyDgLInni1nqNhvUa5Kl33RYToZYm8UL/iXwDAgpGx0aTuik2P+OhANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
 arch/x86/kernel/sev.c             | 165 ++++++++++++++++++++++++++++++
 arch/x86/mm/pat/set_memory.c      |  15 +++
 5 files changed, 210 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 37aa77565726..3388db814fd0 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -74,6 +74,8 @@
 enum psc_op {
 	SNP_PAGE_STATE_PRIVATE = 1,
 	SNP_PAGE_STATE_SHARED,
+	SNP_PAGE_STATE_PSMASH,
+	SNP_PAGE_STATE_UNSMASH,
 };
 
 #define GHCB_MSR_PSC_REQ		0x014
@@ -99,6 +101,28 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 
+/* SNP Page State Change NAE event */
+#define VMGEXIT_PSC_MAX_ENTRY		253
+
+struct psc_hdr {
+	u16 cur_entry;
+	u16 end_entry;
+	u32 reserved;
+} __packed;
+
+struct psc_entry {
+	u64	cur_page	: 12,
+		gfn		: 40,
+		operation	: 4,
+		pagesize	: 1,
+		reserved	: 7;
+} __packed;
+
+struct snp_psc_desc {
+	struct psc_hdr hdr;
+	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
+} __packed;
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ecd8cd8c5908..005f230d0406 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -109,6 +109,8 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned int npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
+void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -121,6 +123,8 @@ early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index b0ad00f4c1e1..0dcdb6e0c913 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_PSC				0x80000010
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
@@ -219,6 +220,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0ddc032fd252..106b4aaddfde 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -693,6 +693,171 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
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
+			 "SEV-SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2)) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backward.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(hdr->end_entry > end_entry || cur_entry > hdr->cur_entry,
+			 "SEV-SNP:  PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, hdr->end_entry, cur_entry, hdr->cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (WARN(hdr->reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
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
+	if (vmgexit_psc(data))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
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
+		panic("SEV-SNP: failed to alloc memory for PSC descriptor\n");
+
+	while (vaddr < vaddr_end) {
+		/*
+		 * Calculate the last vaddr that can be fit in one
+		 * struct snp_psc_desc.
+		 */
+		next_vaddr = min_t(unsigned long, vaddr_end,
+				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
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
index ad8a5c586a35..8e6952d626ec 100644
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

