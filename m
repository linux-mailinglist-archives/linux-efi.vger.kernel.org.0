Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC03BEEE2
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhGGSkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:06 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:59369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231929AbhGGSkB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPweLdMxT3xWE3Vrpjf5Z1HrUh6P3z5nVHeQbGD0YGPj3pAwJ4FE3OcJBmk4OnVm3KeCJ1fNZ81JYBXwmw0vv2YZMBp6lMdSqnPT1YQTBanGKEICIQdqjBLit4b4jZq6fEFdxR7mOV79tyxmX0R8/ua9u/SlH5HpASxWTmrwdNAv4579f5Exi7TxV1pnADgwHFEsziF2Voz5ABKcqfWH63+8zYsWKsBKMIdamNtwCbablkkNYZFfPWEG8HiRvjlXlJvF2Ky45ZDAVAZz1CH/5/Fd2aBX+7uzszy2eEuLr7Z1lbR2CB3EY+dS3kb9/hpkzTB2ZCgoA9mzKWLbK5ag6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W80ii6Z0nMtAWd+/9BHCsTQUA6rncgi2TcW2/sBz9L0=;
 b=B6xJQXFX46iVspkuM8dnp7gXUEejCvlLkXxEVSYbV8M+/5ZNVAQ6+lUs73xgV8xk2TiYRcJJMFOBAOBChv75oPu35xqhIVnOckmNZkKo+fsjxiNBvRHtjaJ3TBsGDpbvAM7vMxe6hWuHFdB2sc2aFF/ZE/yQtw292vrUR1kuFC+PfzRGdrir2xuLdOK4wDCIE4IFy4Oiq9T7xSaI/ssAGec4llbHD3Yo5QQhSbjQeu60K/q6SKuPZ5EbqdQL6+tKG0DXEAjcESrelOD6Fj+d2hRZI3xuUYBRxETMwDlMx46xT/vj7nRD2v6wgrBIXPJk98BAvFrbkqArHdgmJBIzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W80ii6Z0nMtAWd+/9BHCsTQUA6rncgi2TcW2/sBz9L0=;
 b=T45LHDEwlhnuHm+tSgY6fM/HFcmbWMKujZAnMhBB9d0UF//IUSvwYNmhI36vr2aZFk5V7LQYUacSZpH1XhRbsIROhVdml1lwwGfCk743TkYPngu/pJqIFcj+vFBg41rUYWKJBp/JfIn27KbYTwFPwvEV/0020RPS3+k/VnZ4FZo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:37:10 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:10 +0000
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
Subject: [PATCH Part2 RFC v4 06/40] x86/sev: Add helper functions for RMPUPDATE and PSMASH instruction
Date:   Wed,  7 Jul 2021 13:35:42 -0500
Message-Id: <20210707183616.5620-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862d08f3-fa5d-493a-58ce-08d941763abf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB352557BA69F4B39CDC7F74B1E51A9@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhIOT4tEkvT48V+TDEczAryDYu+TxAlqfp+il8MTN/nVtqaFdZhlHpcwr8o58fCVfrzq9/vC0E3L1O9KQ5WMZZuNkAkOxb0Fy2x5ONWPVkbvMKCrUcjZSDEX638DkB/dvLHpyuNMf49AbCrg44qlre7yxgA9ReUqohHrFX6RX9JQhtbhVr08s4PMGXOtWcUV1T65O7153PiVoI1k7qgoErV0LC+kzhVYAJQBxEKsYVC5niIPrwVCoUtqnzkUYwLM1737kPr2SPeZjAgigtfHKGVsrZ3lHrVXwHXR06+ry+RHG4asYlM+/eHlhsKBOBXbIY3OI7R2xHA18cnxVqHk9sVLZjA0NLapVhsUXePPPDNtdIyWTavH8WxiS2ADyBVs+vz9G1jealQ2X7+wC/grhFQAe13wxiXEK5d4bNG9w2f0WPPMDJNDimObwnG3zYZXc1cqY/fvDLz6vlPIQYmYQDl22AhPBlJZ1znDlEuL3C8zLVOo1x8E0Ai9q1Lg4BwxkwaB612/ofTNDA0e9tcI2bOQMIH1hLqGN9tg0FLZBo4omAYjhXa3liG7B8rE7cTzsE2MflZk4aLkZCPrcl/qlhY83ixp1vytIAveRXXwN3UEqz5MMf3BcHzc54ani6WsisfBuCvsLZMZt594eSffGwUZNYQ9GGBIdyv/xSe7BFEqsRfNVsiwCzKgBr0Y6L6dR+GesgjNfYBqPWxjHfTh2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(1076003)(478600001)(4326008)(44832011)(26005)(6666004)(7696005)(54906003)(2906002)(6486002)(52116002)(36756003)(8676002)(186003)(38350700002)(956004)(7416002)(5660300002)(86362001)(38100700002)(66476007)(7406005)(2616005)(66556008)(66946007)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZyoVlid5hgFbQlPBOMWV42uKT8Msl2Ko4+UCvXKwo6fIRr4nnPKi+MD/po/?=
 =?us-ascii?Q?ZMpsliFxKV8FSKkA+ETlwKi+CmT6mpKygS6ykluKSVEKbZJ2/iZVovWavmlh?=
 =?us-ascii?Q?0+FvpYiLFTwyko9CGMK1J9dQMQMu1W3t15Y22u+ioq3nhZwiDqpS0K8Kv3lZ?=
 =?us-ascii?Q?fvEskTznjhsHCStPB9QWaYFTjLRvdRTpsRcwJ18F7q1ZmSRTcMReER5ezEAR?=
 =?us-ascii?Q?zsMxjk2/rNqydc0jRw6x6GGxGnP3o1k0eVYUJoByWhJM3GKZOjMUQPTO/8cp?=
 =?us-ascii?Q?b5xy357xSQmdTqwU3GY/snDm5sDmLrFO88ouJ55kgl1cL+/xvN3YcpHDnZv4?=
 =?us-ascii?Q?3icyf8z1fawsD+j0kXQ1rYGWMwkwmCEPHx9FD9f8zGu6937tdytxCx7tXs2V?=
 =?us-ascii?Q?vVhC4c5MYKNHfnl0h/f9/UDq+BfcCSeSKeNlaTDtkv0GgerCLpVqrZamNMsF?=
 =?us-ascii?Q?FJ+l4GD+W2yryTaoGKWQH3jNtMIp1wx3cJPAhtbFCBfKlP39UwGLuRQG20z/?=
 =?us-ascii?Q?Ygk/ChgMpOD0uTudv/UY3ratvRpMDkdh1FQu5q+9lyd1QIiPBj8Vija/D2A6?=
 =?us-ascii?Q?9KagSMSxgKYk7IHN/zi2SlGu3kMl2QYcFn6QWYv1TOYQI8qrzYwmeocqen7r?=
 =?us-ascii?Q?NJMGg+xsbomx9VKaoULvVT9VWY0XqxrlUCiqV6hNWPBuiJvDE8w7etFItOBx?=
 =?us-ascii?Q?TXI3kNXQqUih3925Ih8O5bmzxTp3knW734qz3L5VwjdXorV5Dm9FedoVigCx?=
 =?us-ascii?Q?2PiLCFEnpBb6SeWNq4jew7M1b/TPT9fFNYP2OJT1in8SjAoqET5uLxz//wPL?=
 =?us-ascii?Q?HyEJhYMC73PBGH07Evd0kezTz7aVL517hqzznHIm4tur7B1WHX2Hs8kcZ5pf?=
 =?us-ascii?Q?CFt3zt9oeISYoRL35wdMekqnZ+OE0VPHAYLXTFFh9M/nwRRJRwOzSp0z8cSe?=
 =?us-ascii?Q?Y0y6kPZprvVf9VqKlmq4frX2OAsJdKELwWL/XAgIAqVahI4X1PIlc6qSoinM?=
 =?us-ascii?Q?oNBrh+B/BNvX430Cje3XQfB/TkxSbKfa/S0GesNa5+6yQMk09kayJb72QFol?=
 =?us-ascii?Q?446BWW/snMN7KXQcERyv0G3/flOES2zECJ442cH6jqvxh1fMFFL/RPNhFWho?=
 =?us-ascii?Q?Kl1hB5RJ8wmkDh4m1ZXWArg6dQbeI7Il58qh2QcGQ6W2FSBBLyOfrVt+Qx/Y?=
 =?us-ascii?Q?l1SS4yFpzoeggkgdZsfIacx+ePt2xjjl8LA9hLlWJyEVB564SmRIob3noLod?=
 =?us-ascii?Q?kiuVSRfAA+UBFzVMnFD9DI+T9vNXsSxxzMrvTTs4ce4wc4ciFedMHbwhAlK5?=
 =?us-ascii?Q?nu1EDPQYwU1vFyFQMddgLQ9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862d08f3-fa5d-493a-58ce-08d941763abf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:09.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XI/vzi5286Nh9iBpMWGrrrv9T2XthYwKZtw7LZcchgjpJGOgY8zgz16hjPnNoi1ooqjDuev23zPOonCWus5wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The RMPUPDATE instruction writes a new RMP entry in the RMP Table. The
hypervisor will use the instruction to add pages to the RMP table. See
APM3 for details on the instruction operations.

The PSMASH instruction expands a 2MB RMP entry into a corresponding set of
contiguous 4KB-Page RMP entries. The hypervisor will use this instruction
to adjust the RMP entry without invalidating the previous RMP entry.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/sev.h   | 20 ++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1aed3d53f59f..949efe530319 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2345,3 +2345,45 @@ struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
 	return entry;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_page_in_rmptable);
+
+int psmash(struct page *page)
+{
+	unsigned long spa = page_to_pfn(page) << PAGE_SHIFT;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENXIO;
+
+	/* Retry if another processor is modifying the RMP entry. */
+	do {
+		/* Binutils version 2.36 supports the PSMASH mnemonic. */
+		asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
+			      : "=a"(ret)
+			      : "a"(spa)
+			      : "memory", "cc");
+	} while (ret == FAIL_INUSE);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psmash);
+
+int rmpupdate(struct page *page, struct rmpupdate *val)
+{
+	unsigned long spa = page_to_pfn(page) << PAGE_SHIFT;
+	int ret;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENXIO;
+
+	/* Retry if another processor is modifying the RMP entry. */
+	do {
+		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
+		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
+			     : "=a"(ret)
+			     : "a"(spa), "c"((unsigned long)val)
+			     : "memory", "cc");
+	} while (ret == FAIL_INUSE);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rmpupdate);
diff --git a/include/linux/sev.h b/include/linux/sev.h
index 83c89e999999..bcd4d75d87c8 100644
--- a/include/linux/sev.h
+++ b/include/linux/sev.h
@@ -39,13 +39,33 @@ struct __packed rmpentry {
 
 #define RMP_TO_X86_PG_LEVEL(level)	(((level) == RMP_PG_SIZE_4K) ? PG_LEVEL_4K : PG_LEVEL_2M)
 
+struct rmpupdate {
+	u64 gpa;
+	u8 assigned;
+	u8 pagesize;
+	u8 immutable;
+	u8 rsvd;
+	u32 asid;
+} __packed;
+
+
+/*
+ * The psmash() and rmpupdate() returns FAIL_INUSE when another processor is
+ * modifying the RMP entry.
+ */
+#define FAIL_INUSE              3
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level);
+int psmash(struct page *page);
+int rmpupdate(struct page *page, struct rmpupdate *e);
 #else
 static inline struct rmpentry *snp_lookup_page_in_rmptable(struct page *page, int *level)
 {
 	return NULL;
 }
+static inline int psmash(struct page *page) { return -ENXIO; }
+static inline int rmpupdate(struct page *page, struct rmpupdate *e) { return -ENXIO; }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 #endif /* __LINUX_SEV_H */
-- 
2.17.1

