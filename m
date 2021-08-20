Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A03F2F5A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbhHTPZd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:25:33 -0400
Received: from mail-bn1nam07on2084.outbound.protection.outlook.com ([40.107.212.84]:42222
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241472AbhHTPYE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlngQJj+3SyjR40+livYMKqs36cU64W1BZPfTboNEFUsSF/5cnQvFhNDRQeaqSyiTtUH3GeovPzQjWt5jEP0nEcd9ngcxGbkXvqaAziA7lB4j2hFKReTyRY82wrfP8AEMVi5oS35nKGNk/qHUrBvydRLJMkw7FXwyxqA4dzPuKadP75HiMX6PFaZbagEhJJZZBIpHm8n12UsCqu+beWUjZZaJkjJv1Om2/k8N4+xFr/9pnWEdOuzcw+IlmUd4+GjQhd02LFN683k35eu8IWwcNyrR3KL6gQo6/TqSsjMGKET163f/PY8FBWOiI3AmoEYzDjWzQYCOAcZMOEVn7VX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjHh2LVvLyq1yt+1cUn+Sn07eJ+T/tunvQHm0q2LW7c=;
 b=CH7qNwjnRffILLXgFHK+v0snv9VFNiFRQr0Sqer4AXUlxMkghkNdddYFlVaUauo4x7sKEvu7J6yKoHddRXABO6QbjFvJ4RAyBUVoCnbe0yWMmHgxeCvkOhFwvgGYMbeuMuLQOQlVfnRp0JpreqykA/SeOC3pZd/WPjoTd+6I9vU60fVPkfBZQN0/iEPaEM4hfSTfmCcyhoiGIru7s3DmLD5cKS84U7FMH0EFngZCMM6I6NXBW/0hkXTMiB/2NzneXBXGkeWQihWU1p02JFVUYYVhTBlNwm3/vlOo+8pHOtk+Q5LgJnnQ1qJnVhcOQcJPIrgwtrylebFMTmY64EnyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjHh2LVvLyq1yt+1cUn+Sn07eJ+T/tunvQHm0q2LW7c=;
 b=sHGBiWKLc3rfbksZcT7/wU324Oa1Zt+8Q/soAjTm/BGpScZQ3gKqKcJ8oroL/Uryubioy4UENKP+T9pH8I169gyVQ9u2oR+rXMpnz0pGV4DWRZ4mciwbApbFa9xg9ACw3jvgxJnyH6WQ5F9hL9WoOsk+O+FEcnmxpys0tz18b6A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 15:21:59 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:59 +0000
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
Subject: [PATCH Part1 v5 33/38] x86/sev: Provide support for SNP guest request NAEs
Date:   Fri, 20 Aug 2021 10:19:28 -0500
Message-Id: <20210820151933.22401-34-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ec3b5e-e405-44da-cce9-08d963ee2fc5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45929BB909C8B1FABB05AEB1E5C19@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Rj6Je+B6gVXdlS56gK5c/6G/rI2QyFfyCS80EGttKh3c8lJ4CLtWFmssMVASPBtEUmnNlEv/VQ6ToYLVPO7kX5U3E1orz1kYjyj0vUiS1+bG1iGs36xltN78PL+jHUdiQFvo17NKRLFihyp17W4TIz5LBIabt3AGU4cYOXOz2xqrKfmh++lOP1Qpv+h95/zbvsfPTVjFAtDTF4cGb3Am0m3W0l9zgpnuR/uUN0krLiJ/vNCFH6cfH2nZoo/RDAmS7F2+vMe8K3ia0HKdArO4+S/2rDiORO4GpILiYQmQdWaAE35HCQ3s8AX2cH2u0FC8aUiMZrX3S7YQyVu2sFGfvTMUQWM5uemlRR/KC1WGElHLnGqQh8kSfoub2dlV5t/y89qMKIUnjviqjimfyL7h+eWa2ih37LWixI2L9BJ4qVfzqlxKIFMtMLTF5nsfAjkPAu24Z1iek0ekILSy89gUI3VYxVDvcPXSH9/EvfSnA/Onko9E8DbbVyYV3EnTtE+lhf2VB39jsIsz82O+fNtFC6g8BVudILm9wdxlf6WdWuqvAbQXBY9m0AW21x8KtHNCgc6TMUiN+Ql06eEgDbH+mr7DlTgUOa1o4lD/yU8xQYknag76bhY+olTgxahzdHc5jKdAL8TNJJdXVP97kedq0xsF/uOkM7aP3um8MgK+Z890Bvlxit6xp/t6g98wV7N8sfhhYniglGFB05cuwN5LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66556008)(6486002)(54906003)(66946007)(1076003)(66476007)(316002)(38100700002)(7406005)(7416002)(38350700002)(8676002)(4326008)(956004)(2616005)(8936002)(26005)(36756003)(44832011)(86362001)(186003)(5660300002)(52116002)(83380400001)(2906002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V//6ThvtQucLQX8n8H0MaKB/WwIUab5XSgYH8X3AJGiVNjiYGtRq3mKULR98?=
 =?us-ascii?Q?rywaYocKmUGOxsLLsOmmEzQlLIYgkQiyYs0IbTJt8VmNpCosELYDUxhKIDs6?=
 =?us-ascii?Q?A/FOMdfXTwfXgK/yAGzSgqTmwbF91HKAs2fygL3dRv+/8cbavE4fnzq211hC?=
 =?us-ascii?Q?gs6srnjNmimEqUdANRFK89PtClCGsm2D1bVUqNYfs4h0667qeuWfMsoKxYZr?=
 =?us-ascii?Q?xLZzSyJPSQwuOZ9KCNsERrEYwYP8j2z8XFs2rsYUT0/O3azOK/zGvZbPmXY/?=
 =?us-ascii?Q?bOR6U6AtoN0CB1oaXTACxWZpW6qIdiGPnizO/4JP/EeDfnY6YAcscDC2kZwG?=
 =?us-ascii?Q?vG47+UQ6EeEX1kBg+mCffYhe0PruhQXRogM90ZxJe9wSvBwh5QuV6oi4HfAm?=
 =?us-ascii?Q?zTRdcbaTyFN1yUN4n/XGuUE42kStfoY0i6ulRBY5HwTjVEJ5e4wifSgKDM1H?=
 =?us-ascii?Q?xfxpiDdCLcxdEI10r+Ie0BLA0OxolU0ZHgU7LXHHZbPt0cg/YFQISj6UlD/F?=
 =?us-ascii?Q?IKHZVbtBp8H+WN+XqP2d7Da+tPqSipVEuoPBjYBzK0K77gro3uab6Zmc50DC?=
 =?us-ascii?Q?WtjQTqAw2Dwg4Vy2oU50DsOnQCpHwvhouvsWRC9nnqLYqr2QQ3TL4dZBfIFd?=
 =?us-ascii?Q?rGUqc3C/lVk44rUMJk29YjiEGcSkOg3rgzIxvSC0HBoA+Uc5FGZuXqXbrIi6?=
 =?us-ascii?Q?STHC62UJNyaNXtqnteCKxHmQTLpw2w4ilh4uiExrxGnD6BqT4fTIlfLlM8N1?=
 =?us-ascii?Q?IC0SNywGhRFClKsVaDNMj3srk84XOuKg5iNigWMvzjDcxnaz7X1vm2YnzAqU?=
 =?us-ascii?Q?bG4ERVNPXkfCkG+kljJfFksVvGiBnUu+3+J8emw/0/OZJZKh/zJckbj0iwQA?=
 =?us-ascii?Q?ag7gRc1RSfRZxPZ/aqrkdnE7WxdghksJFrYGjbPXVh9iQemHxB4cGKuh7EgR?=
 =?us-ascii?Q?sJkSls32xJMuD5E65T/z8uXuNGxFikXRJzE0YqfyRNySz3/2XQarGRUeK3pK?=
 =?us-ascii?Q?8xjvUpcrgZJNyAhdtaMhYBiFQvRCebECwsh7QpphVpvZ0UMMLLLBLUhL1Psz?=
 =?us-ascii?Q?zhiCs/wlei/hVlnC8yBmiHrRVrfZ1spHr2CqWM5clIjKqwom89ctwDctdiGP?=
 =?us-ascii?Q?F+Uoyz04nUtlYF1AV7ruBj1n0Ulj+muewVpNd4QdvynRMm33Y7c9mLALAq4t?=
 =?us-ascii?Q?NBZQyHhegnxnR/F8veW6HxFF4L0lDqvSourYujfHJRUXkWGD5FTHSYdJDlWw?=
 =?us-ascii?Q?iwPBG/JdtRX9vaB2Pqbp144JRtNzWWPs05m4Bpg/Djmt2JpRb59clyE3130l?=
 =?us-ascii?Q?dgrhy/DCyiOPLBnWK/TJ9eyx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ec3b5e-e405-44da-cce9-08d963ee2fc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:30.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvFwSaghD71D/yq/IbLRqOANznqWMYHK/FTA4/55Ua2i99ISSBPGG9K0asoTD3+wP9Z03KXo4bpXvpMkr3vQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification provides SNP_GUEST_REQUEST and
SNP_EXT_GUEST_REQUEST NAE that can be used by the SNP guest to communicate
with the PSP.

While at it, add a snp_issue_guest_request() helper that can be used by
driver or other subsystem to issue the request to PSP.

See SEV-SNP and GHCB spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  4 +++
 arch/x86/kernel/sev.c           | 57 +++++++++++++++++++++++++++++++++
 include/linux/sev-guest.h       | 48 +++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 include/linux/sev-guest.h

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 8b4c57baec52..5b8bc2b65a5e 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -109,6 +109,8 @@
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_PSC				0x80000010
+#define SVM_VMGEXIT_GUEST_REQUEST		0x80000011
+#define SVM_VMGEXIT_EXT_GUEST_REQUEST		0x80000012
 #define SVM_VMGEXIT_AP_CREATION			0x80000013
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
@@ -225,6 +227,8 @@
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
+	{ SVM_VMGEXIT_GUEST_REQUEST,		"vmgexit_guest_request" }, \
+	{ SVM_VMGEXIT_EXT_GUEST_REQUEST,	"vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d7b6f7420551..319a40fc57ce 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/log2.h>
 #include <linux/efi.h>
+#include <linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2028,3 +2029,59 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
+{
+	struct ghcb_state state;
+	unsigned long id, flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	if (!sev_feature_enabled(SEV_SNP))
+		return -ENODEV;
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb) {
+		ret = -EIO;
+		goto e_restore_irq;
+	}
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (type == GUEST_REQUEST) {
+		id = SVM_VMGEXIT_GUEST_REQUEST;
+	} else if (type == EXT_GUEST_REQUEST) {
+		id = SVM_VMGEXIT_EXT_GUEST_REQUEST;
+		ghcb_set_rax(ghcb, input->data_gpa);
+		ghcb_set_rbx(ghcb, input->data_npages);
+	} else {
+		ret = -EINVAL;
+		goto e_put;
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	if (ghcb->save.sw_exit_info_2) {
+		/* Number of expected pages are returned in RBX */
+		if (id == EXT_GUEST_REQUEST &&
+		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
+			input->data_npages = ghcb_get_rbx(ghcb);
+
+		if (fw_err)
+			*fw_err = ghcb->save.sw_exit_info_2;
+
+		ret = -EIO;
+	}
+
+e_put:
+	__sev_put_ghcb(&state);
+e_restore_irq:
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_guest_request);
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
new file mode 100644
index 000000000000..24dd17507789
--- /dev/null
+++ b/include/linux/sev-guest.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Secure Encrypted Virtualization (SEV) guest driver interface
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ */
+
+#ifndef __LINUX_SEV_GUEST_H_
+#define __LINUX_SEV_GUEST_H_
+
+#include <linux/types.h>
+
+enum vmgexit_type {
+	GUEST_REQUEST,
+	EXT_GUEST_REQUEST,
+
+	GUEST_REQUEST_MAX
+};
+
+/*
+ * The error code when the data_npages is too small. The error code
+ * is defined in the GHCB specification.
+ */
+#define SNP_GUEST_REQ_INVALID_LEN	0x100000000ULL
+
+struct snp_guest_request_data {
+	unsigned long req_gpa;
+	unsigned long resp_gpa;
+	unsigned long data_gpa;
+	unsigned int data_npages;
+};
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
+			    unsigned long *fw_err);
+#else
+
+static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
+					  unsigned long *fw_err)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+#endif /* __LINUX_SEV_GUEST_H__ */
-- 
2.17.1

