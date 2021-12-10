Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F61470464
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbhLJPs1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:48:27 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:4705
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243406AbhLJPsD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQTB7QY2sIrU3NFO9PWCaq+0Vg9qpGePlF6esr++GBkERxGTXiUIYvPyqIf+DYoyNunkwuzeKb5pK45ofKgaMjRJMdcmkoy4dkBKs5nz3hQA7d29UVPTrD6Zy5C3R8q+ZI5AX89xM35hsuYnEELr6f33Ne2Mf5Z5NcfjzN0WZ3tDb1DMtEWaQWFAV+4VoEDNTF5NWYxp5VcEED3pDOxK/G9hvMhBbMuRcp1CPeywrIe5F+xFpTXWRyDSf4OUEsKAUXdPECNkjks29xVMIxe9iDIaNs1gpmhqLFMqqa6aXpWhw5629HbWFAbAe3VnzTI34Op27s50GimihbJTu0Lxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xraPFmllC/O3C/25e30Dn9ff2mhMGBxJlAxJgg7nWvA=;
 b=DitQ3knLsKwP1lTn95Nkyb3Uir0xJ2UhrVRmO3GVgp7rjEVDTYalpuUD1FqXMRnmOJYsb/5/1b+gYJHSewi2RNrE10vZj6KXHBkzCfOFPDsp7b3YC9lNkZLDfp9ZIY7k7U8c4dVI/zn8EDl62rNN8UcoulZTgrumY4ALBTFqDoytqMTtNGzeoRaCQyx/ti7R8v21N88I239iOQDQDwPLfnHYk6PUQkFYlt4htZulLrU+H8JMoUdGndPPNeL6OiEw+m5PlipFRDbna5+lFcKdF0wrQFMpJdw47McQHFHd7+mTXLvqgYCGFXAQ22obcUdzwDcWjwY3f3OQNyF8bOCCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xraPFmllC/O3C/25e30Dn9ff2mhMGBxJlAxJgg7nWvA=;
 b=QWnra8v+3r56vWItUKds/zgfyeUP3hb8cJKS0Psp2AVGnlmugqN6xgp6oDtABtFBXbnpzv3IIrNKdbAs8FckJGpLRmZhKNRMW4zuXh3ojphqvE+bWolComM5g0e/P+sWrgI/vbrFqwsAIUgjx2fcWPQ9R235a7TO+/Uvrz7Ie8o=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by CY4PR1201MB2487.namprd12.prod.outlook.com (2603:10b6:903:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:24 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::78) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:22 -0600
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
Subject: [PATCH v8 22/40] x86/sev: move MSR-based VMGEXITs for CPUID to helper
Date:   Fri, 10 Dec 2021 09:43:14 -0600
Message-ID: <20211210154332.11526-23-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81c40b6f-b04a-4854-1641-08d9bbf3f12c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2487:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24876AAB3963020B6FD5FA95E5719@CY4PR1201MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgFhKeQt4Zp69UT2D40OXiPQpF/BBdWAgfvVBWr3XHD0YsLCI5S5LeTWaye6G9F9n5RkMJALaibih+GMbMmLIWPBPBKaEE7SS+un37fE7PDrN3RhE99ydPK3IS5dq5cowpDzU1fUIWRf22x3s5BhESLniYpOMU/Ny5UMAlejOTONbFRqNI8XXp7VbcS5qL9yF3I7J+7rWguihSghnkLaq2Gq+Q7HMvMUyEJyCgH2wW9lmyxFFx581Zh6Xcv1ScoTfc0Ody439SSokFzUt4+rplY9H37BLJ2ko26cx9H0eJV6kZJI4l11opSE6OOl37rmUSxXmmtayRszQjNVcxMg8QYrIU32uF8izIUVvdqBXyBXwu2NydduYzdCD/JuAcLfv4bzpZlWF7cfuGmYopYcnTkcQCtlauXn2wXZ56svqbKS1L5iAkz9m6SQGRn0w4Q9fy55V0rznPhr72WGjiENlwEHE8l8R7PeHqYlN7IgdFHcxjpssxGs1xcCr0wHfR0V0Znf5s/nNBI01VQptzsT326X9qnXKYdsUGGpAs6obSPh1qzf0rbUr85kDcZPd1pK62GgoheYJm0vZiwbV1UiggUoGZPwBw55BmjUgOXA6SUQBShfD67FOvNJYBF6gSWRIHeLQ7kbQBOUSkWeyObMJ/BoR35rdbJMEa1EOToZ2Q83m8Ij2hf5w+dNhUZVOnYAFSq9DfdHdcUwQ/BdZZHDz9c3IeA+DoDgQoaPRmS4wsu/xKngAl2cYqveXE8K6zy9CuTtefVTr7RRCHKuBADq9n1iSVlbyo20kK7hqLmFCscwOvlLSwonyX8Ivclqbawn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(6666004)(508600001)(82310400004)(110136005)(2906002)(54906003)(316002)(40460700001)(186003)(16526019)(356005)(36756003)(47076005)(5660300002)(26005)(4326008)(44832011)(1076003)(83380400001)(336012)(7406005)(2616005)(7416002)(426003)(7696005)(70206006)(70586007)(8936002)(8676002)(86362001)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:24.6500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c40b6f-b04a-4854-1641-08d9bbf3f12c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2487
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
index 3aaef1a18ffe..d89481b31022 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -194,6 +194,58 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
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
@@ -202,39 +254,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
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

