Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD83BEEDD
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhGGSkB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:01 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231814AbhGGSjx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcKjeEEQ8V/WeBeJo2TWp6BuUGxji7N1CQ/VxbbQOH+T4PXG7MDixzlT8mxOZw+V3s+hd7BdCnkd2j9YPwIV6/iSZEYuaCZm/RxiqvtUW+uBIO+IcolyEG/SscVAU944gN/0UEovB0eOi+Er4a0jgQkiZl5iCwA+Ev5OjxRJv1sS5Z+xYb8N0Qp+uaG3XjZJODqUcK6osUcz/E2hWDa75A954FLfGRcE8mkHtDgh6P1qzLpK1lx7jiD4i1Ikw4SEH+bTwWKV195PfW3gDwVPCL2GUpzd9TbPivLwMfGd7/8UR73NACtV0mPCu+M+ree0rQrHCh/pOEDVIyJBNDn6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIK5NxvpLy6Q3nwQprtrA00YculYMgdKCHPSPXm9k9c=;
 b=T9CSj7cdZe4MAH1qFOgjpPOoEFpx7yZxtuAtDLEiAeaBlvMkbcEUby6PM8hzI/MVrjoMMKJRSXm1lhy09Fllz6C9OZbWpwaTA0h79uDG2ZiryObClwKWcP0FqNTiu6QrR19QSygvLL7HwwC+k73sqt9YcthTbiOS/OqZbdOUGCaFgfaaKaCFJN1WpRZd3v8XBU/RPk/xh+5Cu5ZA1/A3SiKWEEArCgFpLhdSmJPHsNmZ9xT0zGu6qrY97pXG/+s3riMP57y2SSknR/7JBLi+NTal7jRtey/ZpjZs9CuEEXU5mgGMGV9OTUi54FK7ld3SraC8we0pc76zTVvXpz+6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIK5NxvpLy6Q3nwQprtrA00YculYMgdKCHPSPXm9k9c=;
 b=KWXzT1Bxz5WQVD0KOmY5TAlokANKBslvayHGErRiA4Fe+FeH3T5wf5+ePSMkPaCKckGpTqDIn/AIhofgaBEJEx7X7x6+SQalecLzw7M/n/7x6tRZA4V7KDT9loLTAQ6h4DT1KXYLmZsgtKkWJLfI8z34kFN87OABgyvQHifsIdE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:37:07 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:07 +0000
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
Subject: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
Date:   Wed,  7 Jul 2021 13:35:41 -0500
Message-Id: <20210707183616.5620-6-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 414641ca-6a05-4a0a-117b-08d941763922
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35256F65A82A7573F3325BC7E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvkTcRWJgOuT6f6gWSBGn8/LDaXfldX4qff4C64Xjlvb5jeWORwVGfmYXD+hXlPHk4Bc2ESWR7x/gFoum8cXfTQnCwaJFJWdM5i/igWMbGLu9/7Dujld5M5dwROM1+gsIrUE0o3U20iQ58ZC7paYR/EXltEXSAFWjHcnXFpHme8v1f9f73ewSNIPrGFUIo4P8pTdpTMBrCrZ97CXhu3NH4rQXTV/C3YN9p5C4nYmSP/2NcjfJW5BrgnPtDWcJhWzBXJTkY39qNfonR6hmxfQ+Sajo5n1s6LEFEsWTPcGRoGD0E93aG6LHtqs25Qzq/Ykluaz6i+4Yo3wo/D87WEDy4g/5APOu0TZaQFFV8J2ogizD+udA8AWvheuJLnTCnYVQX27DzBYIElQazvvjlVufTaVTPxiSie4QbVtDUtevbFl3FAVnmIWycKlR5q0rvqYMZuE21O9IRE5ypiY20/Sbz4TfyZfSshvZmhTrrUQd5mHL7N5F9YFzVfjVFjsR0t77uwcuPA6ks//n8tpbtHfY7DWU0sgQYJTiBGnRi1sQUw02NCQxSRV8CmtWHSDVETnuWkSicnah/NH6clVhX0tiSRKoROaZtz/ArlJECqu1n6hsri5EMSysMuv3IhtG23YWQxEXUbRR1JNHL1yMpexvoEQEUHQFHRma57AvxXdleHAEPnlpDvvME0Kl+cmj1ID92PL4302rw8ngl1n7kIQTgIa+krrBO43Ean9zSXxq76jalDBtv4mKredMZGB3OL987aPX1iQlqgIyQzJP2L/OxY/gLdXnGEc/UuXgtKaL0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(83380400001)(1076003)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(966005)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyH3ODAUj7SvR3Aa7CYcgTeTgAbZcj1GXaWX6+wj69F/yIWC7pNsCUWxdcmz?=
 =?us-ascii?Q?jFUaW/GTN2k0UuHWwO49o3YVZixMFGH+AFAHgAda7++7tEuUcZiiBzyvbra9?=
 =?us-ascii?Q?TSeCYZpdUNIPetplcupwqglFbirzq/GQ+yMj/1knAaDyLLI5ELfW9E7DIJlG?=
 =?us-ascii?Q?GqbvlASrNilwSkVCSxzdOtm+67mvMUV4T06/5yZWE9Omjv7pZ0RNbmO4ywiQ?=
 =?us-ascii?Q?D85WbHzxGJgoC2pCFRNOCMOFojiuKCSFcZmFeV5vQ0l8I5j7P0mPjTRNVMHq?=
 =?us-ascii?Q?ZqPIm9WXbfGZNYERDgkvHPtfhcmW/Y8il4PI0RTCgjZfnP+C4vKmtLvifZV9?=
 =?us-ascii?Q?g9R+f0iy3mR+RjnR+MOgOGZ5a3aTTr9vtXX10dFYPmV4pLQOWBI+yGKadxhj?=
 =?us-ascii?Q?SQwWEeCyet1md3adNtplMHcid070cHp3VaYDWkZI76I2jMi+30kdJ1bJRW/d?=
 =?us-ascii?Q?OzU3y/EUdMSfnk6nnzhxRmyE6doN4EFgDcaMRnQtb/9mr2YizyueiGkzIgBx?=
 =?us-ascii?Q?Dy88shGaU69VT5+QlWJ/SLUE+oSmvn5KaoQpF3BT6MZ4y31DeLq8Wfk8YmTd?=
 =?us-ascii?Q?ySvaSY/yiwqM/DKvavFzRxSjs3SzFI5sH5gda/GkzzrYiNFxUDlhzrJwR5yO?=
 =?us-ascii?Q?N1Z8aWnQToCaNWERZC10oksqWB16evGNV3YYGpujIp0PUXbCrkkYAGUmWXV0?=
 =?us-ascii?Q?05esSbZ5zBXbXxiyMo8LZlTeva9Zg2VseKAV0yDfR5Bh9DL4+7zkJDTl+lr+?=
 =?us-ascii?Q?FUoqnKZ8mTbIj8QEBzMYctvLNOIvMDSjvLmX0aJRMhvvTxSnQdHlwny8JViV?=
 =?us-ascii?Q?oAyqNW/3bFGZhBDV98cuwE6DMUkAed/68441WP0F8n+GhqubWi2sAP4IGHj8?=
 =?us-ascii?Q?50UnA5PDEhtqbfmZR0fNGJck0lFUJP9zXup40thyhxPCJo0xcpcqYRFrAqwq?=
 =?us-ascii?Q?16LDG519DqNnHMSl5rWSg5vBAi98QkaFd83n9QpH7i+D03CJTI9AqXaCe++Y?=
 =?us-ascii?Q?2fzkv+DYFVRwyXo8yxHoS8m+42+UnMEDpaHfKOJMBypJPlGnyOYk5o8Vu8nI?=
 =?us-ascii?Q?NK99cLJK3Xk+H8P7kFznUnNCe9UdtyUF7UwIv7Hy2I9qu5Kr5xQ0/GdXiCUk?=
 =?us-ascii?Q?hSXedEUntbSX0FHzlKFsGF4xOnha0ToydS0i/xHl+vkg/CMYR78fqW03OWiK?=
 =?us-ascii?Q?KxLqa/7RckLPB54Qn2isiIb2iXttqvzm+u3jD3n1Vh654mPP80xRSvTWX330?=
 =?us-ascii?Q?dQYpiM/AtXdCgWtrS4ldzGluhIHTeWAnZW2bw8/G51KWQlRA2Se1wLeXKBPz?=
 =?us-ascii?Q?wR0kiIge1Ky8/WRTrIDoLJlN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414641ca-6a05-4a0a-117b-08d941763922
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:07.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oibqZ0+Enb3YT8fZMxG3Lc5BtO67HxOP1C+giUzPls2mIAax/gFOc3hBqlgy8TGLuvzF5nePdWmHxsWCr2THCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The snp_lookup_page_in_rmptable() can be used by the host to read the RMP
entry for a given page. The RMP entry format is documented in AMD PPR, see
https://bugzilla.kernel.org/attachment.cgi?id=296015.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h |  4 +--
 arch/x86/kernel/sev.c      | 26 +++++++++++++++++++
 include/linux/sev.h        | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/sev.h

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 6c23e694a109..9e7e7e737f55 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -9,6 +9,7 @@
 #define __ASM_ENCRYPTED_STATE_H
 
 #include <linux/types.h>
+#include <linux/sev.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 #include <asm/bootparam.h>
@@ -75,9 +76,6 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
-/* RMP page size */
-#define RMP_PG_SIZE_4K			0
-
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f9d813d498fa..1aed3d53f59f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -49,6 +49,8 @@
 #define DR7_RESET_VALUE        0x400
 
 #define RMPTABLE_ENTRIES_OFFSET        0x4000
+#define RMPENTRY_SHIFT			8
+#define rmptable_page_offset(x)	(RMPTABLE_ENTRIES_OFFSET + (((unsigned long)x) >> RMPENTRY_SHIFT))
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
@@ -2319,3 +2321,27 @@ static int __init snp_rmptable_init(void)
  * passthough state, and it is available after subsys_initcall().
  */
 fs_initcall(snp_rmptable_init);
+
+struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
+{
+	unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
+	struct rmpentry *entry, *large_entry;
+	unsigned long vaddr;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return NULL;
+
+	vaddr = rmptable_start + rmptable_page_offset(phys);
+	if (unlikely(vaddr > rmptable_end))
+		return NULL;
+
+	entry = (struct rmpentry *)vaddr;
+
+	/* Read a large RMP entry to get the correct page level used in RMP entry. */
+	vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
+	large_entry = (struct rmpentry *)vaddr;
+	*level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));
+
+	return entry;
+}
+EXPORT_SYMBOL_GPL(snp_lookup_page_in_rmptable);
diff --git a/include/linux/sev.h b/include/linux/sev.h
new file mode 100644
index 000000000000..83c89e999999
--- /dev/null
+++ b/include/linux/sev.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Secure Encrypted Virtualization
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ */
+
+#ifndef __LINUX_SEV_H
+#define __LINUX_SEV_H
+
+struct __packed rmpentry {
+	union {
+		struct {
+			u64	assigned	: 1,
+				pagesize	: 1,
+				immutable	: 1,
+				rsvd1		: 9,
+				gpa		: 39,
+				asid		: 10,
+				vmsa		: 1,
+				validated	: 1,
+				rsvd2		: 1;
+		} info;
+		u64 low;
+	};
+	u64 high;
+};
+
+#define rmpentry_assigned(x)	((x)->info.assigned)
+#define rmpentry_pagesize(x)	((x)->info.pagesize)
+#define rmpentry_vmsa(x)	((x)->info.vmsa)
+#define rmpentry_asid(x)	((x)->info.asid)
+#define rmpentry_validated(x)	((x)->info.validated)
+#define rmpentry_gpa(x)		((unsigned long)(x)->info.gpa)
+#define rmpentry_immutable(x)	((x)->info.immutable)
+
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
+#define RMP_TO_X86_PG_LEVEL(level)	(((level) == RMP_PG_SIZE_4K) ? PG_LEVEL_4K : PG_LEVEL_2M)
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level);
+#else
+static inline struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+#endif /* __LINUX_SEV_H */
-- 
2.17.1

