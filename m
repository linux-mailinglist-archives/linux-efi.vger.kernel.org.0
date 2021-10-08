Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B5427048
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbhJHSJL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:09:11 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:39264
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241703AbhJHSIC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVkPbeHNoiptEXl4i+dS8qeT3qwBADcpzhnpxxyRDFCJOVqWcAoXrULjMGv6aG7VWF4o2HRnDvtej0iWmnr3RW0T3ppeYr5a34tqZHSnaTA36NyqBF5oQJfnzjXVPe/ICaamRWh5Rctqj21Vn2z4bq73E2UhXwAeG4vMVj0scw1BNl7CksmkWaDzba5FxuMz1w8uXgOpCa40ArjZaBSRfPB1cD8fKTWJNP0qaCyhmjQxzDWoLk7bIxCtiMjc+U+rojF8RkUumumz5SUiw+d+OoA0Rb+A8oza77b6IimyhbySE0GOqvVclDsKWdj/WmrRorGJwQYVMouFwbf3OIt52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZC1ELFT5sLbu2sH3g1K5XG4as5f6VW2VApG8NVi2wk=;
 b=Mla61apAQTxAt5aQhF7lLLaFPap5YAalWI9uoT+eDKtkODK0KyfAifcg5qQREjOsfe9LHSSq0Zm5LOjf7y/K14u9HDj8F5a/LGsUDg8x8/1HlEVSg8etoG+KcyrCKXwK1qVpnc7Z71gDDGCt+3nMnAoubgN0/lnO4tLaVhm/wcsK62OpujwyVjwsLhfAaTg4z0269QGgkrOkbGFlDlcXYDtV2R9+ErSwPv+YSOY93lr7UWIVp2RlBv5MkUKO0zNKDpx/ZUbmqka8rFhhYBM3G+1NMHINTu8e8LnhLdIkJtI9pJqPCnoq8GjSh+0oHYWEdLNZeTJOVbIRe6JNPtGTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZC1ELFT5sLbu2sH3g1K5XG4as5f6VW2VApG8NVi2wk=;
 b=enYyUE+pney8CpfHvC/HYFMhS77QYaOfvw8bpqn4EwTz9WRf2M2ieRstoZ0fSKanmCjf8NtFC7PmA9mPX9V9XP7CFX+0zfr+iH6LarA4b3zJhKh1zn/azc+Z4otA/sOp3s+hNrkO5sNUC/jj+GFl2T/tyJv1boeSWs3WBIymurs=
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by BN6PR12MB1202.namprd12.prod.outlook.com (2603:10b6:404:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:57 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::4a) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:57 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:54 -0500
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
Subject: [PATCH v6 26/42] x86/sev: move MSR-based VMGEXITs for CPUID to helper
Date:   Fri, 8 Oct 2021 13:04:37 -0500
Message-ID: <20211008180453.462291-27-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff95202d-840a-4b6f-b792-08d98a864740
X-MS-TrafficTypeDiagnostic: BN6PR12MB1202:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1202166E5727EDAC4DA57BFAE5B29@BN6PR12MB1202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdFrzmvkmdQLsH+F+Wr0Kc6hAP2v6cCh7ErBWLGy6s4WRUd75eXjfEch7/P/6mquCe0ktSwDpO+zqBmv4ilJLD/eDN9KcO3aa2BKw67JKbkrToN0DvxmxGAOIMCdEUGp3m+gVGav5Ap8ODZF15AZKTGaJoTzHmFfunwf8xGATuiZfaDSSpCCQCCKeblR0u736DRh9jek/mVO5YgJGwM+OUWZur+7MIUc3Uitb8pl8448qCIN0qCmFx0Z2yONYVkgezxCqvDQEU6tBy23nJoRUOrXbxWOjOPT7uwnuIw+LnxWox+v1Y1W3m59c/IBcDD93TqCVITJtsQSuujvd3g501jdciIC6Al5T3V6YwBRB4FSEXiMEMgBdmMDke+hCmvVCR98N0OZxNSIVFjNal+VpiZHd8l/+og0WrETtDAzP1uwjorlXJeI9Vb6r+9C1k6GNySUN+YNbHJz3OgV5c6e+/GBN6yWoZlbVQhHKVXXtEkkhAgthhW5OajRL4z+fl4fE6LP/F8+P3/yVYmeGSW2Rfnc73w/8OkOeRCHR83i4HON3AXSph6VmZYS9HtrwOvCIRhO1cTG2Gx12CNiAASVcc2dBneRrkCRp/EWhtyvuCICjaD9aRaaB12Mp5gdaAF74LdtnnJoFo/LKJGjXvGEd7IdT94K8KbpmrrbBJERnzH8i19/C8dVDtrxljb/gUGJ4XmsOW9F28yO7ACxnHIg5YZfqeRJhvuggNdrqhAkmu+P/S5OgH/3gbPT30lJtFqb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(83380400001)(7696005)(6666004)(2906002)(508600001)(8676002)(36756003)(7406005)(7416002)(4326008)(16526019)(186003)(1076003)(8936002)(81166007)(82310400003)(26005)(47076005)(110136005)(36860700001)(54906003)(44832011)(86362001)(70586007)(426003)(316002)(336012)(356005)(70206006)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:57.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff95202d-840a-4b6f-b792-08d98a864740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1202
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
index 2b53b622108f..402b19f1c75d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -193,6 +193,58 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	return ret;
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
@@ -201,7 +253,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
+	u32 eax, ebx, ecx, edx;
 
 	/* Only CPUID is supported via MSR protocol */
 	if (exit_code != SVM_EXIT_CPUID)
@@ -221,33 +273,13 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		sev_status = (hi << 32) | lo;
 	}
 
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

