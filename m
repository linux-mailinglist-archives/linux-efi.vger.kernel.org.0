Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04402426FEF
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbhJHSHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:36 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:61857
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239930AbhJHSHX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfTvIky/Oj8to2CmYy8v1eo94nJuloArgPgsTnFUBWrxN/tdTaNogdjN2WBrFeuFn4ywxInO1Db4uGVX215NEPWNalQ+sQALLhq+XMv9p5ZZiGVN8pBtuhq5nlqiM5XG+oMZBTGKygizFmFkwZ2dX8hprGedf0bsWYmWFHkxOO3unpG/4eU7qHJFqaX39DIlNlZ0BY1oEaHcDwOa8OHqqK1jBPb6mMPSHn1/WUBdi93T6LZTuQlEmHH6euDjHNTZSylQsEuZkRbP1lT014k88A25Ln43Wtkz+2gF7eh+aoTejz8pvLPxcV/nuj6ibN7VxeSzo9QXd0FbFHCSVHradg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7hqYym14jCTQCE9llMenIJO8RDokIYa7nBBnCX8aGA=;
 b=FQ6784AHhMRM5ZEmrc9JRoQ48b4+QeWjFyXfmcJ/WA+yXR2iErL95KeAQBb1GiprgcRCoE52JFfm7Ya1IhmgznTTs5dNh9SYDu+N/j6+6oIeHIoTZySs/EBEGtUlip9cUmcXcuXGVLfs9m7M/K8kaod8YPM8mbcTbqq6ITXn9TE4UNZ3HJXgKuhbnWpZJQ4Q0ThXBalYI/hQx2G2yUZdkhj2TTxd775G6EVFyXfWvfo6saSX6QIMgOKo7zmJTUUJlCIeVFAfOcW8MHpmdK+GxZpuETJlsJSKkctJgKP54/ywHJWVdfjdgNWWhmbN6dBl9oVEB4TABiZuguKkxHEPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7hqYym14jCTQCE9llMenIJO8RDokIYa7nBBnCX8aGA=;
 b=vqHRNZeEDkRLzFU5uQZLOwbuk5TuCACyNQKM3n3Ff586fMiNTeLNCx524Haj3oI8ONbHS7cj3PGhfTTufeAs3u1cxSQwd2eeFghaK+T4kYpUWF/ol22cSVmXGNynuL1zO4OmNXeS74DFPiGlmTb61M8q5prLq23nwPS4svV5K94=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 18:05:23 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::cc) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:23 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:20 -0500
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
Subject: [PATCH v6 06/42] x86/sev: Save the negotiated GHCB version
Date:   Fri, 8 Oct 2021 13:04:17 -0500
Message-ID: <20211008180453.462291-7-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10ea1a30-7b69-4ee4-753c-08d98a8632cc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2774:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2774C374B989856CC62FCEE1E5B29@BYAPR12MB2774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXD2g9+FejMW02FPgmDB+F5T3GkR1BC0+iWVsRqVHtmvb/eeBXw85M1ewyM6G9+LsGQ4TaGr0wG14yE5ZGcSrrvPNUKCTHOrI4jF0pFq/WQBzDCuA2CSfbDLcmOdwP2WNsmssgJJaa0sh4szW5ASuzgDpSjqJfIGLchV/QFHD9VFSzXQCYmdRWidbsBboqvtYvxfarwYUwHC6raDL4fmPxNtWKHFoqlm5x0eiLsuLRHkLvzy9tySA+99uCDClQabDyBGOIVRu/WUdG8qU025K78cGobVY3AX7NzNzDfirOZItYv3dHvPtRK1IwsqrYpCPgiX8QyiKtR7fZLN0nup7Ro5/UbePMqtcq63oNHhCaOcXria8TCPMsZU7xlak3HLduMTGK+gZMLnrI+mKg6v/CHGQr6Zh0rRyic439MIHaZmT5zTYQAr/E6iW8NbRbsMdowYPAciW5h1R5eurq3vleaK8CbQvwRY+/TAzE0B0AvzEBhOBcNjYRbbY2/K4cG0IoSZF8KHuaxOpLIMZLIGTlH8tayXiFhx9ZVj26L2f8WpuqZMfK95RIJF0QRcAiFX6yaY/oKKhTLJ5kKYcATw2VELjnnJ8clSYzZUsDjnWl+ZOJZSANRNyphhRyrWvT2rS53Tp1FNxT4M1xcd5zINVAr1yMlp8k7ayHvWOjrw6eLiykt3JCGiIXq0z3i5w7HPUVrNAcwZnDhM3YOGDTwuXV5y8+ojgIP2+hrfq6Uxy5/p+uSfCwf29E2H2NHwNZgC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(426003)(7416002)(8676002)(44832011)(2616005)(1076003)(82310400003)(54906003)(47076005)(36756003)(7696005)(83380400001)(4326008)(70206006)(70586007)(316002)(110136005)(8936002)(7406005)(36860700001)(2906002)(81166007)(508600001)(26005)(5660300002)(356005)(16526019)(6666004)(186003)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:23.0657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea1a30-7b69-4ee4-753c-08d98a8632cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
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
index fa5cd05d3b5b..7ec91b1359df 100644
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
index a010d6b41a04..0eb22528ec87 100644
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
+static u16 __ro_after_init ghcb_version;
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
 
@@ -99,7 +110,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	enum es_result ret;
 
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.25.1

