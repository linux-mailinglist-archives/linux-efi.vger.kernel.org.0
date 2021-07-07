Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5541B3BEE77
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhGGSVQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:21:16 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:45792
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232512AbhGGSUZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGjq8o2xRrrrOHKcAoEq2hIIhCZfnbcc9YFfoapOguKPshRXhuOd5PVRroywGEQ2rTbGJmJA1TOqzvDvktflLjT4Ao8HntuoJ/nQhOxeeDA9KXdEQbg4H4vESMxkNug7AKTWJ6Dsn5hJxTTYatqSlcWbhUANOBihOAVSAn3X2a7JgiE/+aNkh9JlhzjDPr0kZ2BFkK2T/B9lp3HIblUZLHGzISIDNuz7KGvoYaBJovEmOwG6U4QEo/F7SSh1YatOeoH6c9W8Ll1od+jdCGUEVMoA2b1DhDhNtjUbu8L/Bx1Sv5k6M/+JjE29Uoy+Xu4A3bThHjQaM63/8VxZ/Ncn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuBnOuaowbP0FR6tF9Xy3nGftIpOT3sN0TZI5ddzKdE=;
 b=S1sNRyQ6hptH3LJLEIBzybTbbrem2g/SwioPvp9pyeru/NVHlD66DHRDrIE0ckrwX+m2sB0EPSrixKdGmY/rPW4W010sJgeGdkRxNp5zZdIbSzaltVbzjnfgoXMyhHQtmVAjdSak1Iwux14sOXAW1ZcTXQQcpJgPuffsqOlbz0JHi1+/DNZA+xcXIjB+L5cwJuTIFPiCWB8U5KkjsJNQm9HsiFLvWO5JkHzf3kkjlifDZDn5Qi+J38E3vzjao6xtC74EyZeTXxHFMJSgfkCfmkQG5BBQFTINZIbbQUzBkJodNh8ZX9IaSSgnJ2s7rFCvedoFu1wuvvyDyDzM+ld3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuBnOuaowbP0FR6tF9Xy3nGftIpOT3sN0TZI5ddzKdE=;
 b=r9/WFUD23NqBGEbATgFPqBWNo9s8NOwJokbIoptpHGZcXBcB8SDAzTaHlCQxE7HNgLvqN7PF+cKgtAjXEvLQHwZw5IxH6KKPgaPfCNlLg8c0ZKgwXFzQrEIRrJPk4y7YNtPljQmuIcd0CdvVSK4flTifD2sIqMInSprTlPqAB5I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:50 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:50 +0000
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
Subject: [PATCH Part1 RFC v4 32/36] x86/sev: Add snp_msg_seqno() helper
Date:   Wed,  7 Jul 2021 13:15:02 -0500
Message-Id: <20210707181506.30489-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05944ca3-7fb5-400c-12af-08d941736410
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB36837B3B6CA6C5334D9F8F4EE51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nN9G3Kfjr5Wy/RpyBVRbW064AJgLKwyv59wAroKGQZ9Wq+x1FZbXoDmGCmKdrA8rytWCA/FuJE/4M+xmszIAJnMmLMYN9Ft51MkmCkOhdX/85EywzDoDdEkYP1X2UEaqWf12cwEsVexaqJ/0ydcgfSpJzTK68Kibi6DJ1ZqOKE5tubDg/xvYAjz6ca0qki98U9g4vUUK+LieCjEDwRWzLu4wTBoNftKDFLhcRN+jt7x42a605ywXZqjvsVOPd8REFfzPj/AeJ7pAWvu3RUGxbwzhlT/UUT0rnelc+0gbPrIb8KagiURb8QQQ2+R2z23jY411skY1yhHEHVCDkZ0I7NVw4W89zpaNHdF56s9o1dArvZIC3lVtRe3LMtTSc7qd4dRa5Fwni0BvOKBtqiUH73mM2johEztcQIL9ywodny2d/k0yjeP6LSJAtKd4IqSY+tnoCXR8r0O4L7BnKRnEGFaiP3Dn2ZjprxGuo2np469+gOknbxMCR3G/YGNAtnvmyaqzVG/Xw8ciVQSmXGKi8S8bYu3+1n7Y/9Ydb29CJ+qYbG2B+LE9p6ETCx3610mAsDUbrUP9Yr48TfAPXRuLOsJmmmIVuw38WxbHy535iYWkCJ/XtQeGOzG37CXTDOzJYIZeFj5MT/nSzXAIwY/iCsP04tpoLB8a9QkYLXOSznr69TBnaGxMHIkzXgl9rGvxWUuI8khf4a8oNQqTjLU/Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oEsm7nG0WjntBrZOKfwsioDyu09eKL+/ohQlBmeRhI3sldFHjIGvwxN1nSea?=
 =?us-ascii?Q?E1MwA0z7CvSF4DoVu+kWMalEEeaFhbBIPmbkm0hlLEMrHJWD5uxSqXx07gDU?=
 =?us-ascii?Q?uhNx9BjQSE+hE1CmiXidRSTOQv7LcwDMLka4KczCV/tLBmAsiM4JnupW8S4w?=
 =?us-ascii?Q?u1DYu15f1w9oYiJAjIXdwR9F0rgJvAeQGAoB7Q2KfjizWAvAn1tqXqLBfLRR?=
 =?us-ascii?Q?Kn2F1wYkYTOCR2m5nRqv2bvZB3XRh4DVlVbvY1cjvAJTfDdA1vVn2q49KlSi?=
 =?us-ascii?Q?ZV52UpnC+xShuwzcLA0Yei6qD5KbhHTuniEBiJSCkAYNTWAwIM5jhFPjb1lA?=
 =?us-ascii?Q?byNsN7cDRWRncLEn1RN9rsVtHdJ+nVb7PfTzeQnkERIwfYknhZ9h0kDaAmSr?=
 =?us-ascii?Q?EXgpIrzI0Ff1GIOZbKe8JTjQM4/X4wPDEFW64rJAUM7xtu/RP5cxsKvCYNO8?=
 =?us-ascii?Q?TkK4xUSsRxQyfyja7QCCnCLSgq0XXhSdiUzWcAdlmKWnPah/Ot3kb5Tm0RJ5?=
 =?us-ascii?Q?JOyo3a0Udac6wgnbYySnHUFxRAsUdHr8ncG1efToZXmLfKaAHmYpJr/KtlzA?=
 =?us-ascii?Q?FLwyvLD6D2ShUPK4HclHslVaEApBjA0bf6ZPuTkfpM0xx7hFz4JpEECJ7CT6?=
 =?us-ascii?Q?1cFMQ2JJnUTB/XC8oj3az2RSBW46mjfB2elgdCi/WxiFEpSsqIfU9pV9cjv0?=
 =?us-ascii?Q?4qxnljtwZojh5gC6EiwtAsewNdOWApfW8vo691o5QcsPoyIrT/Uf5zmu5eFQ?=
 =?us-ascii?Q?MAFSRxag8k0KWuLYK1VCaKH1CKhhq5Wy8ootxypjjrhEqRtyODSdItDT8zPn?=
 =?us-ascii?Q?Rnywkz/BlSdbaJUWn6a0YnCu6WZBx03tuf7s2b9/MF0QmyIrPv7wSbLeJ8sw?=
 =?us-ascii?Q?Hzh7iMKqlT1JPaXE3lk4X3FsBsa/Bz3fbgvZJ75sB6tFeGC8CT8CS1kM28nA?=
 =?us-ascii?Q?1ohqVdciyHysSv6h8PUwGIKOPz0xuv5yE36d4z5T5KGazrD7Wha1iPWfIqLQ?=
 =?us-ascii?Q?WPlQcOoGmjZJma60H5YFHQMBRaVriNAx/nV04eQb2hTK9TdA3J2TuVv5F+iA?=
 =?us-ascii?Q?dwWxw0KE/PjGF8RLyrjE8Z4doxboRqMLkB+Cq0Y7cqmv4VJKwnK809a5RH3r?=
 =?us-ascii?Q?1tcwBh8kG6udHrONu1Q07kMnIvwFo2Mv3aU7w6TmjtEUrpSdpqrPfjE06MzZ?=
 =?us-ascii?Q?bW+gC0eB0VdM4bgW72erdONk6uqhwL0iBo4zYZYLryNDkxL/s1NTCg1RZDP2?=
 =?us-ascii?Q?92AR5FWqPTEotVWvCJ5ghOcV9iPiy1fkadCmkXo1fRRb3Z7bt6hJQJjh4+WX?=
 =?us-ascii?Q?3gjuHGrE3qRXujZVsRYrmqEM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05944ca3-7fb5-400c-12af-08d941736410
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:50.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8X9pa5JxUsHEABhzvctuGvpr+bOYGxc5n6WeyvG2rrX85qIbQQlYcE8+nMvREjJGniETMaOeG9XPNebWvD8LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SNP guest request message header contains a message count. The
message count is used while building the IV. The PSP firmware increments
the message count by 1, and expects that next message will be using the
incremented count. The snp_msg_seqno() helper will be used by driver to
get and message sequence counter used in the request message header,
and it will be automatically incremented after the
snp_issue_guest_request() is successful. The incremented value is saved
in the secrets page so that the kexec'ed kernel knows from where to
begin.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
 include/linux/sev-guest.h | 37 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b85cab838372..663cfe96c186 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+static u64 snp_secrets_phys;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -2026,6 +2028,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 		halt();
 }
 
+static struct snp_secrets_page_layout *snp_map_secrets_page(void)
+{
+	u16 __iomem *secrets;
+
+	if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
+		return NULL;
+
+	secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
+	if (!secrets)
+		return NULL;
+
+	return (struct snp_secrets_page_layout *)secrets;
+}
+
+static inline u64 snp_read_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (layout == NULL)
+		return 0;
+
+	/* Read the current message sequence counter from secrets pages */
+	count = readl(&layout->os_area.msg_seqno_0);
+
+	iounmap(layout);
+
+	/* The sequence counter must begin with 1 */
+	if (!count)
+		return 1;
+
+	return count + 1;
+}
+
+u64 snp_msg_seqno(void)
+{
+	u64 count = snp_read_msg_seqno();
+
+	if (unlikely(!count))
+		return 0;
+
+	/*
+	 * The message sequence counter for the SNP guest request is a
+	 * 64-bit value but the version 2 of GHCB specification defines a
+	 * 32-bit storage for the it.
+	 */
+	if (count >= UINT_MAX)
+		return 0;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(snp_msg_seqno);
+
+static void snp_gen_msg_seqno(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 count;
+
+	layout = snp_map_secrets_page();
+	if (layout == NULL)
+		return;
+
+	/*
+	 * The counter is also incremented by the PSP, so increment it by 2
+	 * and save in secrets page.
+	 */
+	count = readl(&layout->os_area.msg_seqno_0);
+	count += 2;
+
+	writel(count, &layout->os_area.msg_seqno_0);
+	iounmap(layout);
+}
+
 int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
 {
 	struct ghcb_state state;
@@ -2074,6 +2150,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
 		goto e_put;
 	}
 
+	/* The command was successful, increment the sequence counter */
+	snp_gen_msg_seqno();
+
 e_put:
 	__sev_put_ghcb(&state);
 	local_irq_restore(flags);
diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
index 24dd17507789..5f6c4d634e1f 100644
--- a/include/linux/sev-guest.h
+++ b/include/linux/sev-guest.h
@@ -20,6 +20,41 @@ enum vmgexit_type {
 	GUEST_REQUEST_MAX
 };
 
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPL level.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec secrets page layout section for the structure */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imiEn	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
 /*
  * The error code when the data_npages is too small. The error code
  * is defined in the GHCB specification.
@@ -36,6 +71,7 @@ struct snp_guest_request_data {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
 			    unsigned long *fw_err);
+u64 snp_msg_seqno(void);
 #else
 
 static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
@@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
 {
 	return -ENODEV;
 }
+static inline u64 snp_msg_seqno(void) { return 0; }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 #endif /* __LINUX_SEV_GUEST_H__ */
-- 
2.17.1

