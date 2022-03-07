Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD84D0980
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbiCGVfs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbiCGVfm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667A26D97F;
        Mon,  7 Mar 2022 13:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLibb+aBNzix0uGZfSdn2zEJZAKOZTSaZ2V+uu47xY46w6hI8nh3DZN1uie5K2J+yPNQDemvT5kv03PVlbKp6Hi/g5LAqtfH0txLcVp5z5ZKvX2tXcAWCmkVtI/jSm0zttcZ+QHNTu/qc0YdPXgj8nGuWw8LKuFz2TfJ8xjiT1R3Vt5Oxfl57R/EdnbJcg2eL//RZ0Q8Ye3drMmpxoPa6ztOQOBN4CGoXgTRkL6/lElBVhtubgBCYvqiBevRPfNY1woKgbs+4nxUmiFIpM14mQzvZc4QNUNPTlBBbS3i6Xb491GFj3lz7Qh/FND5U4ozBdvVmozYngsvIJIJkJsWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=IFzE1hnLf5HiapqZdamdBuQr6unVB5CNIcqVg/9dxMe+/Wu4QUbDSBoQQcIXPE6ceNd3l4zKqKH/OzLzg0277iXnlmQKDWhoc50xkxexBXCbFys/czMgtGiIZr6e7nugl4lFIobXi6cOxRbzE0WSIRBxBaDlgCX9GXFQ6gVqmUfUyYEYUCveEQAC0kl7TSya//r/wbZ2ScskvawWVNgg48zagBFA23HpexKGXlsaiO4nQ63p5ZKKeuReEtyhdL0fdw6nJYl33ZGAi+7ZMBeOjmOimiYd+uIgIYhtxnRl2VnGObSUmYTXL9a5B6vc/BPVFovxk0+L4X4v73JjxQw5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=rLC0XGBlRAq0Qx1aBLW+4wLDoBKCkFSkKuWSgGQCejbznnR77LNFbmhzRuXiSk82FgYD4a+KgDgh6fygW2yFrvTafRlValmhn1Zy3IiH1m0JGzY25JrzeHDOT2zx/hhZSNWJr6kqzyFZlVe0D2A6Qq0zzeSRKgRfNq8tHP1bFBU=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 21:34:37 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::c6) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:27 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 06/46] x86/boot: Use MSR read/write helpers instead of inline assembly
Date:   Mon, 7 Mar 2022 15:33:16 -0600
Message-ID: <20220307213356.2797205-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad314e80-fb07-49a8-1423-08da0082479c
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5634:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5634C2E7275863C374CDDBABE5089@SJ0PR12MB5634.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5dQYazEsqr58sEQ0GdznEH7vyRXF6Mr5ItlSk1WsoAPcL23RI2KqvwHUeeB8wq7vtTa6pg0KUOr09Yg4NKqQVZbo/IUAaNgSXHzp0+luoG6Xwztl/meXXf1k/w/lPLxL6kET6y+8BPKlKXw7t7A2oyfLr+xJkoZzllOMUUhfbn6XQmhUctXmR5Y6wz0jOGAtt+AzT2JKrVlRUxXTMgFUt9M2jI7gcWPcClXj2GM98dvD+2buEvLre1cT0BHNoAjN9EgdwoMVEyGJBAYVQmrNewy2znefD5Tpgyf6DxYDiqt9wEQL6VVOz5PN2HjqvTHPDb8NVnUEfLzGGM4YyOMRQj0/Hrr2LCQ6ZP7MKj9H8RojftrRSIfaGE421+8dxlb8mfiMkZuRiw4gT4u0qAM4TXULiab+rmizzyAy4UQtFkvuqt92YMK99ZTKSzInNDKb2TKgkRYmYTUpINaQA5zsTiomZNsV9VgZkwPKuMTyEP2XEpqolK2L+y4Kg/5wN63uzcGIsxYQ7+0YAVX4uVIw5vfbTAqDfyRJfjpgajHajKiRL/xeklkdELr2W44NA+ygxOeCpdwiIFsNPaqtZU3aEYjnE4Nm7Ta9JAFdYSUl5QJO0lk2aDVzRY7XCFHmXthij1e1XAYy2cJgU9sYwH2wNQsyPm5P1mgMfU7J/K/SBnLia55V6cMHQ2eBaYMbc+54D15+gxAzFtXlyrERoS6E8XC0k4y2ZdIBMvc7n1mCYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(186003)(356005)(336012)(16526019)(426003)(2616005)(1076003)(26005)(81166007)(82310400004)(7696005)(6666004)(5660300002)(47076005)(2906002)(36860700001)(4326008)(8676002)(40460700003)(70206006)(70586007)(83380400001)(36756003)(316002)(110136005)(54906003)(7416002)(8936002)(7406005)(44832011)(508600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:37.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad314e80-fb07-49a8-1423-08da0082479c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Update all C code to use the new boot_rdmsr()/boot_wrmsr() helpers
instead of relying on inline assembly.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/boot/compressed/sev.c | 17 +++++++----------
 arch/x86/boot/cpucheck.c       | 30 +++++++++++++++---------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..4e82101b7d13 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -22,6 +22,7 @@
 #include <asm/svm.h>
 
 #include "error.h"
+#include "../msr.h"
 
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
@@ -56,23 +57,19 @@ static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
-	unsigned long low, high;
+	struct msr m;
 
-	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
-			"c" (MSR_AMD64_SEV_ES_GHCB));
+	boot_rdmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 
-	return ((high << 32) | low);
+	return m.q;
 }
 
 static inline void sev_es_wr_ghcb_msr(u64 val)
 {
-	u32 low, high;
+	struct msr m;
 
-	low  = val & 0xffffffffUL;
-	high = val >> 32;
-
-	asm volatile("wrmsr" : : "c" (MSR_AMD64_SEV_ES_GHCB),
-			"a"(low), "d" (high) : "memory");
+	m.q = val;
+	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 }
 
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index e1478d32de1a..fed8d13ce252 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -27,6 +27,7 @@
 #include <asm/required-features.h>
 #include <asm/msr-index.h>
 #include "string.h"
+#include "msr.h"
 
 static u32 err_flags[NCAPINTS];
 
@@ -130,12 +131,11 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 		/* If this is an AMD and we're only missing SSE+SSE2, try to
 		   turn them on */
 
-		u32 ecx = MSR_K7_HWCR;
-		u32 eax, edx;
+		struct msr m;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		eax &= ~(1 << 15);
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_rdmsr(MSR_K7_HWCR, &m);
+		m.l &= ~(1 << 15);
+		boot_wrmsr(MSR_K7_HWCR, &m);
 
 		get_cpuflags();	/* Make sure it really did something */
 		err = check_cpuflags();
@@ -145,28 +145,28 @@ int check_cpu(int *cpu_level_ptr, int *req_level_ptr, u32 **err_flags_ptr)
 		/* If this is a VIA C3, we might have to enable CX8
 		   explicitly */
 
-		u32 ecx = MSR_VIA_FCR;
-		u32 eax, edx;
+		struct msr m;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		eax |= (1<<1)|(1<<7);
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_rdmsr(MSR_VIA_FCR, &m);
+		m.l |= (1 << 1) | (1 << 7);
+		boot_wrmsr(MSR_VIA_FCR, &m);
 
 		set_bit(X86_FEATURE_CX8, cpu.flags);
 		err = check_cpuflags();
 	} else if (err == 0x01 && is_transmeta()) {
 		/* Transmeta might have masked feature bits in word 0 */
 
-		u32 ecx = 0x80860004;
-		u32 eax, edx;
+		struct msr m, m_tmp;
 		u32 level = 1;
 
-		asm("rdmsr" : "=a" (eax), "=d" (edx) : "c" (ecx));
-		asm("wrmsr" : : "a" (~0), "d" (edx), "c" (ecx));
+		boot_rdmsr(0x80860004, &m);
+		m_tmp = m;
+		m_tmp.l = ~0;
+		boot_wrmsr(0x80860004, &m_tmp);
 		asm("cpuid"
 		    : "+a" (level), "=d" (cpu.flags[0])
 		    : : "ecx", "ebx");
-		asm("wrmsr" : : "a" (eax), "d" (edx), "c" (ecx));
+		boot_wrmsr(0x80860004, &m);
 
 		err = check_cpuflags();
 	} else if (err == 0x01 &&
-- 
2.25.1

