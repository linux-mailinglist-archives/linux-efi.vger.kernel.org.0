Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58CC4704CB
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhLJPuc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:32 -0500
Received: from mail-bn1nam07on2042.outbound.protection.outlook.com ([40.107.212.42]:12775
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243199AbhLJPrn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j31xwdi32Oz3TEJF+qyMl3rW4aq1vUTMhOf3R5fuZr8bxL5C8OtW3pEwE24MYPmtj9Ar0d8uofo9DKWyEh371HEdXicFTe9XR40POgLxuR2Fo2dLsxnLOTQYFFktSnyIB4wKk6+dPfu75Iou9qUY557a1IeZAv1jS62Fe4pjSbb6XCHVMrl+tEGMt8+bpXFvnZNB9Nf0Frml+CZsvKUfpYRpcnVmiA3hTfqjppb1LtKszxSmGkWycjE+nEGsHDcv3kO4WcekPfyqzrLGc18q0ms6tPCOjYbr3KKSlPRU59Jg3fGdMCWmufP5Y6jIYwgh4FJwzovebvtpZ+QMW8StAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTVF+9INwXu2z6IrRfSvsUg30zVuSnG1qdTzQNLzDSM=;
 b=exLcox0qL6xh/1Rt18YAkKJDOl/gPs7bL3htMp9qat3OqVU3Ee0m6GXAkpYwpQcd/a9hl80/969/ce12TcsuO82R2O2C6RN9CjbkZbOqFuGwtix56MNN09eQIU4BUtt3dWYe/+PDgzh26gDNV9k7iyglopt+YMFcVaRILsgY1QgSECKVPoQH6YuY4cfwaiTukivXINhfxaL5pIy0hsbdATzPyZQZbPO+FzGyRnbkWKwUJQfe+UPanz/cuEejZYjhCThYtcIoV4o/bvW0xMbKvAxdhr5wjzLGrDj+sgfuWv2KtdSpvkK986NkQID9hF0vy/QntwwPTDYymn+JJTZaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTVF+9INwXu2z6IrRfSvsUg30zVuSnG1qdTzQNLzDSM=;
 b=PWh56UgeJGM2uqX1f/l1/tUp7vcBk7Ckjq92UxLxobqOZgGoIlVWbfYyRGtO4/XQLz0KLnsT8rJq4P7jrAQxvyFIaoamO58J6M5d53ZJ+eBi5seuqwMz8x4DcYW5r/a0SnWjgrThwYHMknH3/piEBe9ByA23g26eZrKNk3AmcNg=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Fri, 10 Dec
 2021 15:44:05 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::a3) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:05 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:02 -0600
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
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v8 10/40] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Fri, 10 Dec 2021 09:43:02 -0600
Message-ID: <20211210154332.11526-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0012379f-c4bb-45e2-2dcf-08d9bbf3e5bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513CB2A7F08027A7F0478A3E5719@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLk+ue66h0jAQ+vo3V0yB+n+7jFCrzZkLySjYHwnyeOk0AiG6zRY+xSNnUrguvPH4cNifITPCs3wcdPN7NMmtPYywoKKoJk9Xc39MpURq6lpxCLwYNZk163/EVZO6iNqOdeIZk5qUwrkLXtowrgLiuhpD5Wso5B3qwIDgwDnaNuUvstegFuklVsNZjU6+DQsbsOoSAe282/jM0tnzlDRV7jzA2j3fSkBgaFbNYKGfK+Rxg0TXZnuquRhkKdOiUB1nisyJnTXXvu5/1ZxoFS4FduMCYsWmQLGftOxvOGaS0JvSIybZcoKbnp1p+ybHZ+mb4n9EAyCDBnAszja2gdNr1ZKN3BGSuZHxBNC3wAG/a4XA6zo6qW/OAx/MXufJrNWWOqVasLgUKzsYTixG46jOzcIfV6mgjZATsc4lYYCEGA/wThFi2gdw6ORuNy9gk5bSwdEDQyVJXiLB8DyhIYCGAoKxWv2FciAVTdZUCxedGRxD5owPGkUp/wWhMN8j90W4cNzU4dTRXr5lKrebDtNoD6zN06+UWUDYij3vyuiyKuB9xmwi9HahLCGEDNbWCon67y/3lbV9KMv+izZx2khCFy20kQWcNkjUi9CpRw+i60AGBNYx5ZZeCOLAt7CuFYDi4/AqCDPnhGJ2TNtUwkbHvyftI9ID8hOw/4Hf/wm8ybJh4uFmnFOb759JmzbLNUmmCD3sbqVmOUcg9O1iXUQNv5hkXUiAPsxMEHUzyl8ps2mItu/l5xWicwpeo5RTdPh5/1NPIVxuBDH4eUKp7NO0rfljRGIAA4kjJl8AM9rEC8m4hT6J6UJCdn/+Cj5Q16P
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(2906002)(81166007)(7406005)(426003)(7416002)(316002)(8676002)(336012)(36860700001)(5660300002)(186003)(7696005)(40460700001)(8936002)(36756003)(70586007)(4326008)(86362001)(70206006)(82310400004)(26005)(1076003)(2616005)(16526019)(54906003)(47076005)(110136005)(508600001)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:05.4929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0012379f-c4bb-45e2-2dcf-08d9bbf3e5bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 12a93acc94ba..348f7711c3ea 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -178,6 +178,10 @@ static bool early_setup_ghcb(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index a2f956cfafba..6dc27963690e 100644
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

