Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C834C3288
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiBXQ7f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBXQ7R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:17 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD96E8CE;
        Thu, 24 Feb 2022 08:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN5Sv71KOIv3izGwgkTt0CmcNmmVFme2n04bUEB/7vzfEUGBvswtjDmqH2rJbh84eT/7MeTBCa1ghgM6G1cqOjzGeZyubOcB35mT4jHhOpaRdmhKQGE3NFltWqe3w+gWgy0ddotsgykvfiKQuEqQA+6GA4JBuvXjHIyRFz2VDFfEOqKvwHLGclBS1m+fb7ayFdncvwABEl65Od3UVg1wResS15ertLsyexKXEdhTPGZMvMw7nzUqcn2kRRuCUaxOUfCcgNiaHNzzHkbttyeLVXxBFM5cP00ClqYjwrkSmAozp+31AOOXT26k3MO16yACpUvd00nr/34tVP87IO3b0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ99cfpt0m7da6oqy/rXr/yW8LVwNmJ3ynuO/U1I9WU=;
 b=hFc9zEqBQC51XSRZguG+b1nYUx7SKwz7ka4FnQ3JG+GXTaCol9gp8jvvC2h0EgmBqQevWuRqVesiNIdXrc6Ji6fBRdGPMgxg9EqmPFMengX82bv20B1GmD1Jja25u0NsH8Kb9uwWRogYzQQNdn/jQtBmCNGhxe/z+nYcOpdSytMssHeI0dWvtKNbqj8vP+2LPIteiW7o2pl5uq/qsyFi0KVqaJn1OUuCbcbTbelTrn4aFg3+6SfTsO1TCmyxG+iOmEL5ISYOOIg1Ld2e9/7zZHO6FSNQDQrJuP2Fn66jsdTlWCZuBp03kZkek+sQTao8LlnRrMlz+sMUiNIPPKuuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ99cfpt0m7da6oqy/rXr/yW8LVwNmJ3ynuO/U1I9WU=;
 b=BY2Dsk6a5wpxvQIZIMNDw5qPOFISETJyZZVA4jBSb8fvY7csiPS2BYMhGByaMhQ8WBrYuAe240FldkX+sTdsHyMSS7ZuVtb0KIr/5FtAv58Skpl91fXqphNpoN1PopIddknyjEGAgcwYknzAAzmxgXhb1jpLnxuKu0zgD4c/5II=
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 16:58:27 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::e6) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:26 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:19 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v11 16/45] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Thu, 24 Feb 2022 10:55:56 -0600
Message-ID: <20220224165625.2175020-17-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b3a0eb-cdd1-4d98-2d62-08d9f7b6e049
X-MS-TrafficTypeDiagnostic: SN6PR12MB2702:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27029EDF9510DB4CF177394CE53D9@SN6PR12MB2702.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC8GLbpPSSp/mWmXiCn/+gV+3jx7eq9vfpv6dChQY4kzmCDJm6d3FfTEFT4DTphJlv5twPLisBhhVIJfDEHS3a2RSIVK4el4ha/QOY8bifPJ2ESIaEA5xCWPfslRf4HrortH+B7wvz9MYEJ8NQBe0g3QW/0vpsygxBzA7rUb5y/OiD6Jpk6DU5zP6EBBGvzSd/eJ0q5l/qeeMBjVCrB4YrrrZCnxol1ixvYUELYNHGxPC5rBCQ+HrNQDUe16nEya8b/1+WMBot4p9jjn+j3BFduVASmuglzKE1HLWRKOzvuqMJbwE+oe8Pwoc5WglpfZXYkB3YvYZUk9kBaki2gQhMV2d+7Wt3ke9Ew4ot62qFHrB3Xpwkyx2zwdUvwUUYwaZg2XcXWgK7mmtJ4vHpQXZWYbB+eyJJjvvoMRvJYPjzkNxQMcZES8l2k/3jpwUVt/jL/BZKsFbxdht4wVYqqLqwEcOwHt9n4od6pEzambDmSkV2KURaFau6stJfpuzeU8HcREqHv6dHf8WqlvQ4NTdqR6rphgQ2DNMEn7nToq6aSmkHavQZJCM726Fzj4qIXdOehaVgqn/jG7sWM/uJA9E7PF5iyi9FGHutbH1+71sboQZfO/6G9i9gMtRjTAeKmOGkFRIuVtVOSpnQEGubcZOgbzZqpkJ1OwSuQQo0xQBbUzP65pENLoeZH59oevrmvpp7Q/kDtYMOb82IGO/7SRd+vY21BCR5uUqx21l6xCORU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(6666004)(7696005)(336012)(26005)(86362001)(82310400004)(186003)(426003)(36860700001)(2616005)(1076003)(47076005)(7416002)(36756003)(8936002)(40460700003)(81166007)(356005)(2906002)(110136005)(54906003)(70586007)(70206006)(7406005)(508600001)(8676002)(316002)(5660300002)(44832011)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:26.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b3a0eb-cdd1-4d98-2d62-08d9f7b6e049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest use a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 23978d858297..485410a182b0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -175,6 +175,10 @@ static bool early_setup_ghcb(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index fe7fe16e5fd5..f077a6c95e67 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,19 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* GHCB GPA Register */
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
 /*
  * SNP Page State Change Operation
  *
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 4a876e684f67..e9ff13cd90b0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,6 +68,22 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
+static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.25.1

