Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D937444CBF1
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhKJWMV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:21 -0500
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:40240
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233607AbhKJWLP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giID555+XxU8RPx2grGT4YAuYRcwcAA++QbLLR6D+m9TVU677yH1zkDyPyaF+Ikwn7wg9sLlk1JALe+zjF3mK62klkGqIS0k27RFnvGDQxrvefu5UQPisWlUyNkgvFfvOHHJrIZmdxZCAKfcpfXWxChQTzARgv5qmf06D8PCeHJTemIMSgCSA1VVTFaey3Df1ce1fQ+R6OC5RznOJV0S9lLpvsueLCqZ1WLPVbgY5x5Bo1TF//Ll1dRGHWaXHzLxuKcE9ixIy6WRlJ23SrMADV3wAYHxWhl6Q9FlPxdJveHE8gvP3gyPqHV2SaWx96XSL3ZCPY8p1CWqRBf2e/SM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cife7IOICCyiVH7Aa9ZyofIqNelDnpiR2NYgGBKIphc=;
 b=KTPYdzQ5XJ8L2ldlh6UQB5jxJfyK58N+JWxq+YKfnVwawN9nhlfpOGA+/4nTuZyfFLmLUxwPfsggEn8qWZRvpJz1k6eJGJsjE/6o6EKNJrsnn28hlJqj/ka+O/8Dc3QckVy017YUPUQMP4+45jUOuxFA/zIqO0hf1Of5Sq3lztU5M312zUQAxX6JJ2d0gEG8cCmoZ1NnE5KwB10Br6GFd0gdJ1PZIPoWhwfPYH4O9QiMIEkq7a6uxHfNrL5VguELrXPNm+N6IMR1+s2rH8dB/GfBqAdqqLuB9NSEvWG9Qu4st/i6eidDtaWPVSB4KC0VXdTWlO7GalSiKGVeup2+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cife7IOICCyiVH7Aa9ZyofIqNelDnpiR2NYgGBKIphc=;
 b=Z6iEB7WNl/sEhwf3+QkNeEVuXnvpLNkg0Y8Hi0kHVNUFyUb6yJ2rQxnvsrGq3EXLOVQxFhtgdroj//CmmIA/Up2wcyC1UUpXLM3tmd01rpEd41juI/j/SPt4XEYkJmAv9ix2pAN6ROzQrQYcrkSHYRNVbrJDWn9FeAN8f1Ewtmk=
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 MN2PR12MB4029.namprd12.prod.outlook.com (2603:10b6:208:167::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 22:08:16 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::7c) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:15 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:06 -0600
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
Subject: [PATCH v7 09/45] x86/sev: Save the negotiated GHCB version
Date:   Wed, 10 Nov 2021 16:06:55 -0600
Message-ID: <20211110220731.2396491-10-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b50718e0-f891-4022-c09a-08d9a496987b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4029:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4029E8242508C4AB97BF1AC9E5939@MN2PR12MB4029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy0DFeCowOzF09IiQne8I+6x5DC5gyj6aXM9eOWpOQN9LK+G5fesDFl4cahDSV3wimDGPa2WV2CniEWDY+V30/u3utGw3k4vPsQbGCUXNBCIFsZcCr/GZZWXF05DA3bhJtLa4TWlbLxJZsxpFJtPMuZpXnKbcaGHs5GQx76KBoxTWjnNPnBQob/Q++rIznf0d23EKvcNo6riazIlfktIDdkNQJSF+kPFEy1fMVTdI2zFVyHXhlY48Z5TG3JExiDxI85GwAE3+ZMVbk0npUbvtiWNqnrZxol+g5HFB0E5X45QIv/GSoVn1YLwgPGkZ6DC5NRBoN6kHmxjvJz6ItNpe51zi7SzRj+xMGRgSmH2ay0yG8DePX20qjigU6YZywLtVdu/CuC9TvhouRA7Z/UeNnekk1mGgu4skHvfRs8s98s/lid+qB0u9UE0/R4A+goIs4lRsYCuYzcy8bNZ7OIlYyrLVPyZw4yUIaEEt8yYiEyx+NCJds7/1nNTj+BPnKrpYHNFQJ5bcvx/VOzwqtg4GiFFl8UplL04F2CnNCXIzbKhZDJ/uBlsWE1yamuKvsq6VlS5dyJvmrdIzmPAjX7NOxnimALtaOvMeEz/3rAapPTMbnmwq5WSw6nb4H/vj+1MOjJevQ37fFzXKowo2uZEUWjxKQ/P/dgt7gAtGwCTw0BV6Yw2bgKjKyi/+topr1Nmy5qg292U4345om0GcyZLLuXg8jqnJrFT1mY0kZvV5yXsPxoHrbkYEAVeSmp7WXVD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(508600001)(36756003)(4326008)(70206006)(186003)(36860700001)(2906002)(426003)(110136005)(82310400003)(336012)(54906003)(26005)(44832011)(5660300002)(16526019)(86362001)(1076003)(356005)(7696005)(70586007)(316002)(8936002)(81166007)(47076005)(8676002)(83380400001)(7416002)(7406005)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:15.8863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50718e0-f891-4022-c09a-08d9a496987b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 +-
 arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ec060c433589..9b9c190e8c3b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -12,7 +12,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 
-#define GHCB_PROTO_OUR		0x0001UL
+#define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	1ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2abf8a7d75e5..91105f5a02a8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,15 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+static u16 ghcb_version __ro_after_init;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -51,10 +60,12 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
 		return false;
 
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
 	return true;
 }
 
@@ -127,7 +138,7 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 				   u64 exit_info_1, u64 exit_info_2)
 {
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.25.1

