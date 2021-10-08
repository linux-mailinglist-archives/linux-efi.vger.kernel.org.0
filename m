Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52818426FFD
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbhJHSHr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:47 -0400
Received: from mail-sn1anam02on2040.outbound.protection.outlook.com ([40.107.96.40]:8705
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240159AbhJHSH0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5b9OytHeiJ9twg3KzQV9hQXwIAAP4H6MHfj7/BFZ+K8450DPEHVhBxOotVlSO6ITj1AUOlpbinlWeSuJ+OU5C/4zZS/rYrori7E6IAXG07ab1e2CQBMxHqZJTl4ZAnq44WgAnmiR9H4HmSXHfcSzS/5zmptpDeH/CrKITM5bGcm3Y3cpgnjKwcd0PuocYyih/83VnHRQIP5MZzN+g/Vwf4xf53tMdIrMzalliIBUg4B7/ksvpDM9lD+Y0wmUgmZ1yRRcTChQrNz/WN8K9EebfrGgn0xousjN3BtZIKo3dDBPsxuZv3PZtkFoN0TQLVv3YqGTKmviMXWNiIqhOyrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz2VXvg4Nrl5H7oHp37nvNURGsmq7u5DooAtxMsCTZI=;
 b=GxI1fyWkPMFkmRESzHpp+H0CUPmvE0EdZJiy5dcUTis3zUkvFk8sbo4Qh8060Q9rU87/0mRYmyEagAZ2hwt7I8eQulMSE3s6b0Pz57wX2ZYkFF4njBFexibXhlDrmlMxnDQkwL5KFnQAGWHQsuT28oUnRX6DmoU89hGJhsE5AWGtaiAhKs6RG0Ynja9AtdIv1nIbajZkWuLFTI/ZYDmwOAq3tPu6SPYdok2Kq/Whu6jwSZ784FKCt0UETT7XcjvHtiZLrb1nsa3/vM5vsC8oRVskjs/kkSqiBVfrBfEOUaIqjdcuHqixwF7R5UQgDydxXGHeTmI+t7sibswld68Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz2VXvg4Nrl5H7oHp37nvNURGsmq7u5DooAtxMsCTZI=;
 b=nqow43rQTifqGv85goG/dpnVwktLK3Q8hDqlzX/1cmbsbR/H1WCSIacP0F0Wq3mYVAIGZ3uoDgxVOhYCwf1iRNe/sCahBVcPHLMB4chXGI4vkxihOpn/mD24quZfjlQgDqADuRHc6pOrGrFs61fOwCW5j0B9vSCxwu/OAAaW+Kw=
Received: from MWHPR15CA0059.namprd15.prod.outlook.com (2603:10b6:301:4c::21)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 18:05:25 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::db) by MWHPR15CA0059.outlook.office365.com
 (2603:10b6:301:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:25 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:22 -0500
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
Subject: [PATCH v6 07/42] x86/sev: Add support for hypervisor feature VMGEXIT
Date:   Fri, 8 Oct 2021 13:04:18 -0500
Message-ID: <20211008180453.462291-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a6dc50-805c-402c-aa17-08d98a863417
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31011941996C13E6FCD21DC3E5B29@MN2PR12MB3101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITiSXKgSygPMjaXP0E6okn6zY8mjdfVrKUKpI4kFXFDUejqpvvdOIJdzs+AgDmTcJINjFhIG+BDOI4AWcc9czP4RNAF0cX3XJFgvXI92lpYPkuguBKFfegc+DNEsN2DeFnue6f1usF0bX4YYJ6GktWsgK8F/qyVwG0WPWVjBGDzuckXlRzKd3Tk/AttraD9FA4ioyplT68ZXCXW6wxyBKrcfDzZB0bCwd4jiNT9utdE0IukJGOAAZEG7aZ5w0rM3LwnEBODxHH5oPicjBDfKTNkqvPz4laRy1J0gHBcjVxexlXfJdNK8MQ41aSbyT5pldiHOr5c8DMVKce+snXpebPgpW8PSysp0zkW39/OmU1ABWg3VlGTYuMD2HoojX1ycZTwMX0Ovd0l95KPF+7/uIQnMMlUratUEo+dkfIeH/8oqxNB3634uzoAW9wH3bZRfhJCKtStecOtE292XhBQZMc2ICJKAF/jGt4ZpCZLlnbRA7xjdbfbhEYeIcETt3o1F+o1clq9NeIkjtLZBrCYd8bwVxenBfVmBpvlQsvEw4yBKk79yFbQKBTNfyN76OZHd3PGJ/69xI+nHwa/jQfAQvTrIt61Jj+lpvMUTLuuwN+gB8pwAqVThEzoYrRMeA3nylLD21IYwonePA3EUk8q7RxGMPm/9qr4IVbTL4mXVmfTH0fyLrFVvuqLePrZltny6eD7RhHswBxcpZ1kYAGtY/2MUMF2XmJzgwyzSrPOLFpPlfXNPi8pzw8BO6LfHN2Da
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(44832011)(54906003)(82310400003)(336012)(7416002)(8936002)(2616005)(508600001)(7406005)(4326008)(1076003)(426003)(36756003)(5660300002)(36860700001)(6666004)(110136005)(7696005)(86362001)(81166007)(70206006)(186003)(26005)(47076005)(16526019)(70586007)(2906002)(356005)(83380400001)(8676002)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:25.2213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a6dc50-805c-402c-aa17-08d98a863417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
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
index 7ec91b1359df..134a7c9d91b6 100644
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
index 0eb22528ec87..8ee27d07c1cd 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,9 @@
  */
 static u16 __ro_after_init ghcb_version;
 
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 __ro_after_init sev_hv_features;
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

