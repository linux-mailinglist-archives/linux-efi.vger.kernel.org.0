Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67144CBB5
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhKJWLj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:39 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:6752
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233780AbhKJWLL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln+0mr/JBodBBLWSNe0uyBVQAFqNvwrvCWFrrdhMiYZCuDh8+QpowqYpVV6jk9TiH0JBrI3APTF6LbepccUNs3nw7GsidU5knr3E2vNFBp1O4WgrCTKxXdjZwJlArwme9noqvm4s8LDdZVjkuqHFabCTdMlmXM3Noe8vylNyqME3Nyieqsr6MXlWqoe/hwaTrZaGXzS3KUEVr46Fqmf9tlrGpi6B4rQLOcBodYeXFJDnoY734J3dBrdVwB5Y6xcToP2qQ613RfHA9lojlJtulmPLulT54jqmD5lX6cca/9fX0ctcn5ZDVrb4prsb2UD4H8Qii4Qa98hXm0peV1wOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONtu6WMNqJ8mScSjnIMn4JhER/6gQBui0BmaTMX7qmQ=;
 b=ePTkKzj7gr8JQ1opnHjml0/aPkaprsiqFjED/EEy8UiM8sOt87HsodY1pUxGpPIgo3lHjEByhmPMah9f6kMaIBbKGPFxFJ+sElaumYWvJ3b8uxY9e+QXvKrbE7pGDRxvd8kj4bhj7DYLo89y/KgVIWVk5JT/fFJb7ho0mLALJARnFjf5QHkxkkyeDmIjeI54Nu2U2YT9MvGJmum366yugWXRFkh+uFozlbiEoRjE4lOjWYbuP//LIxhA7OUxbJDHZv0P1feRpqoZ5o+dlYJsKfL2PiO19lsVdUNicLNEPTHl53nC2PaBrpDjgNkhUxE4dojYYZpkQIjs0PYjc5Omzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONtu6WMNqJ8mScSjnIMn4JhER/6gQBui0BmaTMX7qmQ=;
 b=ZjUSmOJi2YZYfkGDOio4GSp6Vtfut85kInUCWvUkhkNM04ZaX2ccYVB4tzaMehe+cXHVtrsZtKqri8tHBnZ3njEbEbSg6H/psFztgXcpttvkZYHvkfapCoKHQaXYFPcFixk3xD9pc0WpCNKXhA6noKbsOvptvTf6fV3OgkAFsEE=
Received: from DM5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:3:23::34) by
 MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:17 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::e1) by DM5PR13CA0024.outlook.office365.com
 (2603:10b6:3:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:16 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:07 -0600
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
Subject: [PATCH v7 10/45] x86/sev: Add support for hypervisor feature VMGEXIT
Date:   Wed, 10 Nov 2021 16:06:56 -0600
Message-ID: <20211110220731.2396491-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36a3b0b-deeb-4bb4-b530-08d9a4969914
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0160:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01607247D7C61CD479D1C38FE5939@MWHPR1201MB0160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QGM6aKFv1ry3awWEdnyNJVYLD9fE764S+Q+dK2l7+2wwGXc1kontWb/BXNsD4HmNbEGTsuY3kajrHyMkiqi9rr9egw9J93FxZs8Vit+ElY+jm03XP4dES8TMHJqfff4f/mvkOgxH+Cv9RI1eQGuKQMI8ccHvsBOoisHWflM6ZHwyOvt3ZF0vNeBV4tavMfdPpZBNuVYNXs/X7RyintZl0NwjgLLVhF36tgpJDDjnkW9Z19uozzAeY4z6iPA/Scxb84VKPbOOVmXR5mdCG9T45yAg3eqeVJT8C4SUI1EZWKEXOM8CIx8RC3ySj58lP5EILYGfoTA7gawBCgIJcVkqlNPzL1N4MbWxr/9e8IAKnGn96evuvYDf+JIC7MWQCpt2KdZEfOtX4vEucMprcOH+SQyZ3IZGiyqd8YshG75zGvxZZfI9jjRv8GwUiTnxwIDUGcUgayL7CKczN67YMjqUMF55dFxyywZzonfILg0/4/1vmb3M8pbjgVzmAdhgClxhhcI1Nfez3fcwVRXhkeQtBNpGrenKp/4koo3mRQUUAY9Wtcdjy84rwtgmjzGxvFRzBeuoYk+gFThThBIEYkCLjYaLKqR7VPxgaRBArwupnucMVyQSFJrEFc6GzGTMhx3K3F6uhtUk87Oyh9fIukgUsm5JLp8JIIr+LnuxnfJa54DTfx/YCziM+vd+g7uGJOzS1LBgy19IIklKhr8TFZMCJyxMAwtIte9diJ0GonlMEhIV5vs3OFMzJ48TrblSTOW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(7406005)(2616005)(6666004)(82310400003)(16526019)(4326008)(336012)(26005)(47076005)(8936002)(8676002)(316002)(86362001)(36860700001)(1076003)(508600001)(426003)(70586007)(83380400001)(70206006)(110136005)(54906003)(36756003)(7416002)(7696005)(81166007)(356005)(2906002)(5660300002)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:16.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a3b0b-deeb-4bb4-b530-08d9a4969914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Version 2 of GHCB specification introduced advertisement of a features
that are supported by the hypervisor. Add support to query the HV
features on boot.

Version 2 of GHCB specification adds several new NAEs, most of them are
optional except the hypervisor feature. Now that hypervisor feature NAE
is implemented, so bump the GHCB maximum support protocol version.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h |  3 +++
 arch/x86/include/asm/sev.h        |  2 +-
 arch/x86/include/uapi/asm/svm.h   |  2 ++
 arch/x86/kernel/sev-shared.c      | 30 ++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 3278ee578937..891569c07ed7 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -60,6 +60,9 @@
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
+#define GHCB_MSR_HV_FT_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9b9c190e8c3b..17b75f6ee11a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,7 @@
 #include <asm/sev-common.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
-#define GHCB_PROTOCOL_MAX	1ULL
+#define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index efa969325ede..b0ad00f4c1e1 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -108,6 +108,7 @@
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
+#define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
@@ -218,6 +219,7 @@
 	{ SVM_VMGEXIT_NMI_COMPLETE,	"vmgexit_nmi_complete" }, \
 	{ SVM_VMGEXIT_AP_HLT_LOOP,	"vmgexit_ap_hlt_loop" }, \
 	{ SVM_VMGEXIT_AP_JUMP_TABLE,	"vmgexit_ap_jump_table" }, \
+	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 91105f5a02a8..85b549f3ee1a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,9 @@
  */
 static u16 ghcb_version __ro_after_init;
 
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 sev_hv_features __ro_after_init;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -48,6 +51,30 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+/*
+ * The hypervisor features are available from GHCB version 2 onward.
+ */
+static bool get_hv_features(void)
+{
+	u64 val;
+
+	sev_hv_features = 0;
+
+	if (ghcb_version < 2)
+		return false;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return false;
+
+	sev_hv_features = GHCB_MSR_HV_FT_RESP_VAL(val);
+
+	return true;
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
@@ -66,6 +93,9 @@ static bool sev_es_negotiate_protocol(void)
 
 	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
 
+	if (!get_hv_features())
+		return false;
+
 	return true;
 }
 
-- 
2.25.1

