Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8074AF910
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiBISM0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiBISLz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5DEC05CB95;
        Wed,  9 Feb 2022 10:11:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP9zpY7g7jBP39JA0HHoeqeDXJd14zaQAH/Bunsm5hg8NMsWlfCY2iLWsfV/CvLo8RY+Ri/wuLwqRRttcRZJ7+EDmhxqE0sGdfYz/Xfqsgy/akMmZd1OhQ1ouCdcTvD0JZcgu4s/nAM+R3d/oh26w4UW7II1B4C6dovOFAHLbmzwgzIYetPOKQO4J5dQcl8P3AvvJKbQqaRpFuHlSOeqgM78WxI4IPewHZQh5XHBmRNAf1WQiRfw4HoMzz3777ojMCBsPHCMINjaEV7lSAYx8mXP4VuNraQeqhp9oc+xYoPebmE+8X4KiAPIhC9LKD5GRymmN3jA5w2yqZwlPpGUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW12IGctCHQ59PAs+7VbIe+Nhdv+NxvQBr3aNl1R/eU=;
 b=hS6FoyuUh49ALluEK/ZrDYOmrxJbeTnlmkRHRKd5qSmJKgYlFYCldE0aiHahbV79Tm2tgE9E3C2Fc2iWxX1NySGav4SDvv2G3vVNLh9L7bbbCUGmdawHEI4nQ/ry91MxUTdxgthS3+PXl+9p4MNlElBB0CXb4FiwUkyzeEvSfRhWGORv65VYQexv8jtWlw2hGaa7uFAOSXe7ULPwTj4N5LGBM7YVltPe5ov4YBaELu5dLSSpT5ie1r+8n5VFCBzmNzWDMu+wKEiGfcBJeIA797D/Z5HLmtMus0pYpGeeuPZ5Ct3ZvUDhEBysyIXHLaQ3337L1tvBJ4c/1n+RBc99fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW12IGctCHQ59PAs+7VbIe+Nhdv+NxvQBr3aNl1R/eU=;
 b=alCBbpomRq1rJHx91ezH9fqs35ssrLM1MGg9McHclOLosRITobKDvfSA7Vrk1KsRs0IeVoe7oRaCP9WA/r6npl26HO8W+I7HHIsTE9B7OkFpd1tOkOZvXbwjzmhUQBvgNv9hb209p/0u/rnQjyaUsX02aC4lfYL7fts6pBAP94c=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 18:11:46 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::8f) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:45 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:43 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v10 11/45] x86/sev: Save the negotiated GHCB version
Date:   Wed, 9 Feb 2022 12:10:05 -0600
Message-ID: <20220209181039.1262882-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6541c3-d4f8-4515-cba6-08d9ebf7a21e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5915:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5915B658BD3F702C5E74895AE52E9@DM4PR12MB5915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgUoJxfsNJI8j8domNigqCLVfUkfVx1pJXCge3okN7rkEtDiVoZ4dWROySHjWhPv9gdt283iQ4j9Y5OSWqO0dYB1AH6idPQxUzF92RYQLYRnmBBAYzvukfFQoxnxJ70/4bD7viwcglOWMK8SKVGCZGP7CK2lIcOGsKkzEySwlGB91kbF9en/9Ak4/tMlMT28zhH6RJyTTzWCnNP10fNAtUMrvbXFe331FQqBYiTqXhuLBPrji6m1s+QTno6W/2k3UMaiDw/wQk2ZvYKf4mz4fjpTE2NRrQCdgjK6cbVOFHEQLb6fWeyc1jPO6ab0KpiK0gO4D6t1J4/4fuO7ybSJuyIaSgHsaJa1T6+CKy0lB3ndI+PMPjZ/Fi2yRTnAWFWCffPiXm4pfkiyGukYKwEbd5F9y3GpTMtgpJvpPNJWiVRFxkrf6C4zZxq77+f+rTTv5uZpdQjA6iVOzEGVtAxXTJ/QCs/zA9c0NM4W3XhcpH7vM4b7OWqWyXlrCqlsSraubuRF2I+ST8Ej+XbSdsTmWdNf+1/go2DUeY43r8dsbn6q6KCIA+GSdHNtm4xOCj6T8sWcq9k29CCsvx3TzSTHY6AkHP0s4+2IuiR7LTGykefd6cLBAxGu0vgO1+wIK9GiSABQVLSZnX+I0HcTemb9YyDKbuaO6R4iRJE5T2BDRCY2fWp/lXmlA5ki4xWl/UrQOVdBnPs52qs1dBYDdos5qP+gsBWmjvdetTTKf4DHLXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(26005)(47076005)(426003)(186003)(2616005)(4326008)(1076003)(2906002)(336012)(8936002)(8676002)(7406005)(16526019)(82310400004)(70206006)(70586007)(83380400001)(7416002)(44832011)(81166007)(5660300002)(36860700001)(356005)(36756003)(316002)(40460700003)(7696005)(6666004)(110136005)(508600001)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:45.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6541c3-d4f8-4515-cba6-08d9ebf7a21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
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

