Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29C749FF27
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiA1RUD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:03 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:54625
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350731AbiA1RTA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVnPA1bxuYuk/Ngx9Bl0PPLIfyvgDXe0G6NBlQ6QRVRAYRu8tnqxkiS9wtDm5WlKphPjSE/tBV/uSop41TpRQUyj2bRwor2xrmLi1qxVUV5voJVI3HE00mop6PC7q0heGaCE+zrKy9WpUnWs3BjUAKS2CTe4JTINvcqhP6aPpSMZevZBN9K/igf9UnZ2r+nATvehThMRTDNArdpswH1JklWoVvcKNWqsnvGyddc9kwQMl9NEid9fYn1rwUJa0Al0Llnu1KfFcGkRWx/9cKhpeFefw2S5sokvH2XQJJOHS9v0ZlcPGQPrs76dlLC6FwlwR1P16CVcgyuKlaw/VSmevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuqlwZR5LE7Ao+EsfRonG8EJ3C7xAl9simKpYVA7S58=;
 b=KNFxwDJc333nyqSMgXvhVGHJ/pLm9CXHA3jNQB/ZZzYJgxTdOUds9nHCFWfBLABRdzAdU6ISsykQxPYq8JhIaWfkehJRH07MIJlHBtrzAZtKDd2Wn+A3wAh2Oj93wP82d6bGDJn4MYMXDf/+LnMg8GzM6nDcUMa6gdVzuX1Dh72rWOvoWXrxHPq9m7BIdrcn72fQnV/KKAHzwzVb0yv1VEumOKzUv4mVfpWOyyWLYiD2Z5MTDqle1lgr62xVn6wNnxijZMELbAyBSl6fzgJ8jOuLg5Xiv9jJQUdvYV3BAibMg+AaR49gn3/Evl3pdtLge9a4957ngK1xNs6lg/ZKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuqlwZR5LE7Ao+EsfRonG8EJ3C7xAl9simKpYVA7S58=;
 b=wH0oMo/YSwR1HFK3R9BYMvP1iZaID34auX8Xb66B8nFVDpDfnHoaRXEdV7xwO2gE50vtm+gxQqYRtm14Wftf2ZkQUxHT++JfPqjMjf8EkBYcRWaSk/xGgqZtiFRbFrz6nXyrLBiJ2ycf4b6dnbxUmRgrksz+W2u6z4545VBHNEU=
Received: from DM5PR17CA0068.namprd17.prod.outlook.com (2603:10b6:3:13f::30)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 17:18:56 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::3d) by DM5PR17CA0068.outlook.office365.com
 (2603:10b6:3:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:55 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:53 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 22/43] x86/sev: Move MSR-based VMGEXITs for CPUID to helper
Date:   Fri, 28 Jan 2022 11:17:43 -0600
Message-ID: <20220128171804.569796-23-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0244a2f-c6ea-4382-6aca-08d9e28243b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB290415EDDD7B6306E6E46395E5229@BYAPR12MB2904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6RDmDIlPIzGY4QWddHew2QCvmnTn5w50mEMNjJb8Bg1zwxiT6/BBdv8Yu88oQFpMWCw3gkDJubGBzsoGX29J9+RLh/GliVjjnnml2wlqvAK3aQ1ffVITphhkVTkqMgmNpixJU28DgpZF3MCv0SbZ+fxVbUMKOQoDuAWN6ME8rH3ebEpErEPjeClB2nvTWfT68Eosd1c0P4usDcg1lQIpT38UJY0bCYz4qzveDCWKmW2J8G1e9YJyuK0yUVrKuO3nnCpE5FHqa8gvjaIGjZM/tCCYwdlGB8vSIhPIlfC1gZfrsRnxBOpglweelxzeUH09gaDxGlOouAdyaG10eWW3Ih86rioBX8sjRXMzURW2HF1TNTWtj08PvR8B92KT1lS6IY5JPtjEK9o+yJOc0hvgLlSUrtFdcl+wcS6ascubK7n1Xk1yhVUwberVNr06d5XA+vb3MqUhIoymG7N6x1O2YaCd/hsXVZHaI3kxD0M6quUPhyNMTBJOd18PcpVq+ODxRUemDFXnRcwa/7M+5xRLH04YM7+rsWlP+sbxbdb0u2N1E0djGhtwJ8k3nqvoO0iR8nlCh6Q/dW421yG03tvGW6+bskntnDfbv/kOXVM7TgveKItdV8oZ+w4mRKlP1fCW7paWTn8yJGbipiHNRro8b/4sRNVlakvwJBtvlTFCCHjF4dcdHcHXgFIkZOcSB0LUCxLI9ImYyUX/zkyIHq43KMVurae19uo+83EwFcVVUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(2616005)(47076005)(2906002)(7696005)(36756003)(4326008)(8676002)(86362001)(40460700003)(316002)(70586007)(8936002)(110136005)(54906003)(70206006)(426003)(336012)(356005)(82310400004)(26005)(44832011)(81166007)(36860700001)(7406005)(7416002)(16526019)(1076003)(186003)(83380400001)(6666004)(508600001)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:55.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0244a2f-c6ea-4382-6aca-08d9e28243b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 62 +++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3aaef1a18ffe..633f1f93b6e1 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -194,6 +194,36 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 	return verify_exception_info(ghcb, ctxt);
 }
 
+static int __sev_cpuid_hv(u32 func, int reg_idx, u32 *reg)
+{
+	u64 val;
+
+	if (!reg)
+		return 0;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, reg_idx));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+		return -EIO;
+
+	*reg = (val >> 32);
+
+	return 0;
+}
+
+static int sev_cpuid_hv(u32 func, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+{
+	int ret;
+
+	ret = __sev_cpuid_hv(func, GHCB_CPUID_REQ_EAX, eax);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EBX, ebx);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_ECX, ecx);
+	ret = ret ? : __sev_cpuid_hv(func, GHCB_CPUID_REQ_EDX, edx);
+
+	return ret;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -202,39 +232,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	u32 eax, ebx, ecx, edx;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+	if (sev_cpuid_hv(fn, &eax, &ebx, &ecx, &edx))
 		goto fail;
-	regs->ax = val >> 32;
 
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->cx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
+	regs->ax = eax;
+	regs->bx = ebx;
+	regs->cx = ecx;
+	regs->dx = edx;
 
 	/*
 	 * This is a VC handler and the #VC is only raised when SEV-ES is
-- 
2.25.1

