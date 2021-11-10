Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2944CBD5
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhKJWMI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:08 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:52064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233875AbhKJWL3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMXwSLGf22puvNL0vEFh4bmF/zGafM4QtU/yOL7PRVT9lEfs76RCSDyjfl4QZYdYoJO9YiI7u7aLjK/ppdRO0t76B5H6Ye/Ca59+jAqKxIh4/QI6D1eePyPX3EH0DJRahelYpiJeJaaAYrkGesRrppZeTaw2dAfajNUpK+apB8yZPA0oehhG0YohX21CawkYf85VEVbUy+4W9UlF4eHKXo4xnnU0Q5O/R3LU2iNAPuOsgFYdICB4mRoux/gsOXtozhOgNzJm2N2LRxuc95VcTzCw11V1r8z2Huc5IJGjKHmQkvZdSQ6twXPgkxvIQcIZJWo1Mo9nhSzcYxsFvolIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX/uLxFmHfHhAKWnUUZ1FNvj6iFFuCAqBK28YmOJ2xY=;
 b=g5ZQL7BdMxdehGjRWgNhEUt7zCAfCToXY7dK3aK3PpHHXvtOoIKzOIRqtSptM5jq8M/QEpeYf9D5W7tA+qsMZlC+8FJ0YW2t46/lfninFn/7ZkdyZg9931vQjgkAteS4zOLoDzRis8zrYDYP4FxYAs5/gfnm8tzZPrGxT2pHytxrUIDDPuBbsnEDS2ORB5GsQZ7I2LWbAjP6MOJb1TyXD1V/rAq7/OtMT+j05ng5ZnQgJtEhm9KWXpR1FsUkS18FfoWq46q9kHwaIagMdKbxhq+LqyMHfiLdMB7SwZLl3YMRavb7A77OtvsbWDjLu9/y9Q0kab470dLVazbf2RWH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX/uLxFmHfHhAKWnUUZ1FNvj6iFFuCAqBK28YmOJ2xY=;
 b=Yfjd9CYZv3TmBnE7QV3HsNvBI0YEMXZcmiBHdJsvqQ1HpEoVZ+iMuwxmI1XXLypJeZQWM6vwSK5SIllygupdYEujq/tjT9AjZcjpoOMxu/emdnn0YZRhS5yfhjbFcgx8k/c57P3Yn3wx4vxLiyGErBpITljXp4wqxUeRDtC8Fhc=
Received: from DM6PR11CA0033.namprd11.prod.outlook.com (2603:10b6:5:190::46)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 10 Nov
 2021 22:08:39 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ee) by DM6PR11CA0033.outlook.office365.com
 (2603:10b6:5:190::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:36 -0600
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
Subject: [PATCH v7 27/45] x86/sev: move MSR-based VMGEXITs for CPUID to helper
Date:   Wed, 10 Nov 2021 16:07:13 -0600
Message-ID: <20211110220731.2396491-28-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ac7d9bf-ee75-4486-bab0-08d9a496a678
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4040432D1E26F8D34939EECCE5939@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuM07X5hnRRgW4OrDd0pbicKavH/4fxtUvVqOzn7I3pXvtyxabzkFIqdH/MNQdPPoy1yBZw2W5sRIdBsg8UPDsQROsaDBuX//ABXIARmbvH2xyP06Mc8TLYT0V/9Um4wxQpqsSaAjc+1vw5QSLNBK5x0qHDPwo/yHQDESHA9T50LfNxhXBKsanXpSKE3ssdE9gRNoyQsFiVurM3+aNdeHzmJkWS//WBQdJ6jjr4D5iKPfM8qnIQe0YE4x8rg7lf+avY2D8ugrbkGu88tXVTClTlgQeRYDHNWU0FemhwHc1aQpOaBvOaxqgzcskz9ko8APLkCSH7oht9NtaJvxBxmjWOiLqz3QgGEyvx9isauqT9VC45zpXUx1wFmW4RPgyk0tLTTSm/5e6CWMxqBR1p0oazrOD4NxSCkmTkNiXRaoUpPceOMO4CyVrdWtW09C0v/pi2iCSuDB1k+gyC3zoQytDqWpH+WDncX7X3Z3McBPEN0sAp+W+ajjlGrunV3FuN+GOyOrRrvlvnQEmrFd2X0rqEnHl37lQ1u8CLDXm1mqTr6+uSkvKtUSzosdEDsrUoiyicaRYsxvH2DWp6Ah0JV23CGBlwdL6hcCYnoXkgsRSSIhYTZR2jOpVUr39wqoYGRZD+sowiGAtnaSTqpWyzEVrXhn9zF/v/s1hhR972HWOS9o8xV3eRvWCfyG+DcFgDnJowvW/YyVuMrIXZ2VGOUBOrY/tBgKC5U72RNy9oq7atRr6UK7jIiw2BEe2lbWIy3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(83380400001)(36756003)(356005)(16526019)(426003)(86362001)(82310400003)(44832011)(47076005)(70206006)(70586007)(36860700001)(7696005)(81166007)(8676002)(26005)(508600001)(7416002)(186003)(1076003)(7406005)(4326008)(5660300002)(6666004)(2906002)(54906003)(110136005)(336012)(316002)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:39.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac7d9bf-ee75-4486-bab0-08d9a496a678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

This code will also be used later for SEV-SNP-validated CPUID code in
some cases, so move it to a common helper.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b0ed64fc6520..9f81d78ab061 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -204,6 +204,58 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
 	return verify_exception_info(ghcb, ctxt);
 }
 
+static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
+			u32 *ecx, u32 *edx)
+{
+	u64 val;
+
+	if (eax) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*eax = (val >> 32);
+	}
+
+	if (ebx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ebx = (val >> 32);
+	}
+
+	if (ecx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*ecx = (val >> 32);
+	}
+
+	if (edx) {
+		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
+		VMGEXIT();
+		val = sev_es_rd_ghcb_msr();
+
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+			return -EIO;
+
+		*edx = (val >> 32);
+	}
+
+	return 0;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -212,39 +264,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
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
+	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
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

