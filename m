Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276523BEE74
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhGGSVO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:21:14 -0400
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com ([40.107.100.46]:38144
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232296AbhGGSUZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYmibSsd1an9rpJ6i4zVE993/QAMWrSPzesCwJwajqWIp/P+ngu9F8HfSHELFQ70usKMkm/jgKHsK1af9+WaRo+l9yTX0gBxObso6qkfQIvh2tm9ACh1AoOJmOfnY31TAI9prF1eYd7lnJNba+NgaEPK6iggusO7NOdI8+nzSpWmChNdnLVVFdu4n1yxkOFznoD3gj4YWxyJWwjS5cbBZFQ31zvGrOHnFrNLDn7QnXCof0nTGuO+Y/J1EXI6NuGYTv5wKAKg3AnkC+cZgS5cErrUNWvAl+4IJOyrufMnTsmrZXUqcbMIpGuZ/bE8aOI+QsKVcq78XVe5bnW2KVKzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B6FiFCaDmM5RZo5rPzgiexy2y5sO1Pr34P5srvJpVg=;
 b=Xj1nyMCylZAkTyO79kq2fphqMros1v4rapVAh08xZ2ujP1SHSmiR6+tPBVZ9GrrTeXnXGwRNIVWE3lT/eNVYvwbo/UwMgZbQXGp//uaLejRtQDEyJymZHOo4KQ7bp2To4BybEFILosB/f5hTr7Vipncr7Yzd3RnoGRPazNllGBM5d+QTKOS7JBDqITnD3hGEQPbt8Qy6szJQtpFyr8fLmiihy3U6wY/BVqmWo828s9JsQE/cxmoE5vuQK50ihWBETLokRT8kkuVqbPKVdPpRjRrOepK8MBxLR4a+T6e1WizXK1jnYSWC1ggNirMKtZMyqNhxKeaO1XApL5IiFagR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B6FiFCaDmM5RZo5rPzgiexy2y5sO1Pr34P5srvJpVg=;
 b=uuSpKkHMX2zlER3mgpcXzAh7KoI+YNnygi/zEQyOj62ouJnAKisTmp8eWFwrOG/SH2k6+bWjylzqpKZCPo1XI3t4xmVYPRNUVx6GNyB068b4zvZUuqm6bYjg5Zl7uJCg5j74OBXPbfmIP7cyIvU6nP6a99X37+h1WidXJoXhioc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:48 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:48 +0000
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
Subject: [PATCH Part1 RFC v4 31/36] x86/sev: Provide support for SNP guest request NAEs
Date:   Wed,  7 Jul 2021 13:15:01 -0500
Message-Id: <20210707181506.30489-32-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c1362f-5533-4479-f492-08d941736294
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB36835A9E1EB36DF9FBA1311BE51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyjYEU5u4AjayshIni8i0raGxh4dY4Sea/xwOo6jRcYsWxl6AV4qo91NQeP5VmioGElgpw/fI63gWd5ekrAhaEvRSsDaTpQhrqAC7sJLCAolEkHNM/TltuFkTRadvxa2luF1BImyWbdDP+3hnAUSazmdDMxUADQI9vgGd9Sh3scK7U+moDXomyLpAnM2825XatAUMbxsQVbu0QzCEZqevaZPc6r3FvCcI73NlJtro7TEe4c0+kKx03kXfKOLVixMy2HpMzq3pHeIlmWhUdBT/d2znH5yDUKM4z2rYtp/gVR3HScMqUx2kgejv8GCCU9/V+EhXZLuQ4mkMkQi828WlxLCnb/hg/FtVklnCs/WbApdv+LpSlm9P19MpYlz3s5ZLOzCl5yPX+sWT9JwC0SeCPfALF4GP45aempSz6ZMGOhzL9snVbI94iXl8ki+0vYYjw+DVafRkv2mOjGeBlBkp8qcVQwUlbNTgZG0fyZZypb2OVeVmqgZVB+uCwwb0740aLuyFnVV7HL24ON299/O6CErRmS96sc37oe/9DXXGqCkYtEYxih5q9lUcycujyuRIO3Co7Ch7xQLY8yrygLwjQjRhn+TKQHaT9pGA2cs2xwN40AdTt1rflrJT4wtgcnf+8z80iABO4osNklauWbB1TdpsR2sGV1YpYLZOWPhL/T2AOXNhU0Vn5aZnV60OjomZq5jUE6K+GwVScmxbpomXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sEiQH5zWHPUb4BKoyI9e9/07O3Oc1gzzD4+AMFTi9jfnUXPcO0+rFCogAVL?=
 =?us-ascii?Q?21aJUebMFF8DkU6QmYz8ycHHNApVj1q+qifzZpJlgwjnCOdkaVujvYh1AO3g?=
 =?us-ascii?Q?U+km/Qna7MJ+czWL/rdfKiacBJNFC7tNZsZB9p5bbVcMXFEYmaODQY/Pmh03?=
 =?us-ascii?Q?R5PaB+hVYzKjQuJUpOfMVTrGvT8x3o4NwVTIqvYsyMpv+bkRLxUPy8/H3FtL?=
 =?us-ascii?Q?u0ztkoMIeyb4vgiIJCEV9a3CtaRUpcAlrggPDocHr8eQb/TD0vqTGlWVzAW9?=
 =?us-ascii?Q?HSGGa2F3jNqyWiHZumX1aBAmIWk/oaTVhBOdqiEpUu4LHNUtbudpw+8t0mwb?=
 =?us-ascii?Q?kObpNxByUGhZCk/4yibIu0ByGU4hWUcZF96at0CfQDiANRyTNf0f/NyigPCv?=
 =?us-ascii?Q?jyabBNlRn5F9iB7XSifGMXXKiQXbyusMeIWgBn8tMtf7YSPrBgnUUrUgtu4V?=
 =?us-ascii?Q?15oDoJd7Us3pAUEeTRXWC2TdHjlCXouH/GZ3RYGj9AhtL0lS3wV/NkChBvav?=
 =?us-ascii?Q?W8wznJcatMHNtQiLVHfIWbmk222KR+STthXCZSYYt31JBD6EVwulULscMFd8?=
 =?us-ascii?Q?w6ooq9iKHvd8rbQ8ccWE42jL6by6QLv+2aw5mDLgOwVtKBj/QJIWJhlebQT2?=
 =?us-ascii?Q?ppLj4cJixK9yt2UrCuW1YH1sIR1ypQ+p9THc2pey9Xc441umsUqgdPbzoln0?=
 =?us-ascii?Q?a1jwT3pV7iGRB1xE1BoUU7BPt4PKcv9zMrO10+O03kBvGmz8FdgTBmcW+uf3?=
 =?us-ascii?Q?Inmmr/ATql1HtL/SKTNIAHneavIA6bMhPRm3/y3o8+BQeQIy2h6TZ5qVOMRM?=
 =?us-ascii?Q?YU5ivsdhjY0wso6XWtVuDbUCIqakzOY2aoiqVVQxka5fXJq297kft4pbyImi?=
 =?us-ascii?Q?3uaY1fCwBVsKjBlV72Q7iE/RI22l/HKmnlWKD7ZN0bRApjIaHK+jRpedPMrM?=
 =?us-ascii?Q?3dU2PVxgvK903mKl8QT+eCLPT7UVsQaEOI1Lg3JaH9HArzNrSv9M1lsQKC8i?=
 =?us-ascii?Q?vwNhtVPVRuYG1b7/G4V5EfsImRmSOKTv2a8FtBJrNCcIzoUlaxYhPymT9LhZ?=
 =?us-ascii?Q?IVrz+ytAzfd/KN3RJystfL2Nvj3XaMohdZ5h8FFm4EI0efj99pm5wXx2F5fY?=
 =?us-ascii?Q?cxst1lrT425o5TnZYpQrtX/rfL6INYMSYeZoM75r4zS0rAvpghlYHoYx5bMc?=
 =?us-ascii?Q?p237qxTct7weT9vqz6Y+a/Ws080vsxOSBV9zEkWYthbVnhzApnt4eaRkcudM?=
 =?us-ascii?Q?rxOAaLSRacPCedQqK1d6G4mPaSYct4giCl8lbljnZXffxzRupMuxY/cYh16T?=
 =?us-ascii?Q?2SofXJsuaT7iBmYwosJX5GPD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c1362f-5533-4479-f492-08d941736294
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:48.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO+JN6d5AuR/WVWKlDC2OmzZh+FkGHHRJRBwJY0IVE2mgkvtWVhslo+dy1kuzNPGMiO6wYtVMnwIrCnO3eauKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
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
index 997918f0a89a..9aaf0ab386ef 100644
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
@@ -221,6 +223,8 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
+	{ SVM_VMGEXIT_EXT_GUEST_REQUEST,	"vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_PSC,	"vmgexit_page_state_change" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
 	{ SVM_VMGEXIT_HYPERVISOR_FEATURES,	"vmgexit_hypervisor_feature" }, \
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 04ef5e79fa12..b85cab838372 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/log2.h>
 #include <linux/efi.h>
+#include <linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2024,3 +2025,59 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
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
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb)
+		return -ENODEV;
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
+
+	ret = sev_es_ghcb_hv_call(ghcb, NULL, id, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	if (ghcb->save.sw_exit_info_2) {
+
+		/* Number of expected pages are returned in RBX */
+		if (id == EXT_GUEST_REQUEST)
+			input->data_npages = ghcb_get_rbx(ghcb);
+
+		if (fw_err)
+			*fw_err = ghcb->save.sw_exit_info_2;
+
+		ret = -EIO;
+		goto e_put;
+	}
+
+e_put:
+	__sev_put_ghcb(&state);
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

