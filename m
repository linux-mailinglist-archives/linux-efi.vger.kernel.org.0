Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F704C32BE
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiBXQ7O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBXQ7D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0A62121;
        Thu, 24 Feb 2022 08:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeMf19EUZ9ARmiV1JQIu6p92FGootq/OWJWZASpXrGf4jfM71o1JuHi8+JH9KeNXRqaOYuBm8vD6dd4Jbzks9kX8wSF+hKOL498bwrr538SiA9eFmPctn0HKx5mfD+ex6+cBy/mMGSkQBaMG103fd+9JKNR+moiG1FR/0UChLRqFf5bZgUhKMIUrf1Pd3nL58/WtFuPAI8YiUdLk0KGDDD1bHfo2JRKBEcV0i8SdO0ID6OvMKC/PBQS7W1/G2J7fPomR6dwjK7jwdYWf4VXuoaNOGHnBcZ5EkJw8YVy2WG057bLh0nHwHQUfdpPB+vjlfcgR0jjA7Rqma3n68J9NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=kKiakOnzY+5eXdG5mAMxEm9ChiHlWDsjZLwC3cLyChUHpk7pwqz0FoJyL6/dk8sTAa5RpFORiyaXXBtqeKmDXh544/HXgVwc3+JApxjZDjoZz3vljVWhg+eUcKSxG7TNbe5emdTwWMUgXac+ywS+YHNWtLg67LhVccWWVrsJzTzJNR2Q9KDIYRl5XUMreJ+0JhEMq9hd7k16DeL5pwJydV4JMLG4SYUgz1woWKA46RDXzZzIbPNeHIJAUbqK59A1IJid3SwhGm7SMy/01vI/jW+gXhPiMd3pCyz0PYtYkdK2K8foN7h6F5bW9Cl9nIQRbnuEAZtVuemaN7gckV3H4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=d3a3yCOLHLNTacjAGZa20ywwifwjMAqZZV/h0W/uaXn6TPcEzQt2aYqEOjPRtZ5RBHUSohc9Rkfr4z9pgYrvIl0AYDiCYhfWweXOUMo7dFxOoanLAnJvIxgUVSZODJkXwpc+QU6RaekYhpxQ7LsGsCh7yeY10ej5ttOB7MIyCQQ=
Received: from DM5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:3:d4::34) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 16:58:06 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::e1) by DM5PR05CA0024.outlook.office365.com
 (2603:10b6:3:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:05 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:02 -0600
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
Subject: [PATCH v11 06/45] x86/boot: Use MSR read/write helpers instead of inline assembly
Date:   Thu, 24 Feb 2022 10:55:46 -0600
Message-ID: <20220224165625.2175020-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a471bd17-0564-4b82-b4fa-08d9f7b6d3ca
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB434563C764790C89DA8FB772E53D9@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enlSqu4MpV6cBALJ+e2bEV1wdFLcDZFU8MKVVR7y1IpHuL0n/Qo+/8l+22aMWoDqTmqi2f31MKO8NV8DPrTVinpdEG6Xq1/87UNZb8ohu19ErxKy3X+Z18QsPPytndcWWb6gw1q9BIZJ3GG+Y5qaewO64FYh9HlBc2QvQ+rv69j6UifthtsqHBHXdCSXp57p7o12eyaALSyai+lxbm1sWy6S0zwn9YJLFnyL9FVsNNvByQug4WG7ouptOYXFSRNNOmcV6Su/ukpUk551NnOTp6eGDz/sq/WnzrGdmP0NhCoYfb1/Fx/0gVV5u2mVnhQOD5wKKBM8Vu5fVho3DsSIgSIq8/Eii4aBewxPwehwhmiza4Tjnpv9LJZFFPDJCoyJ6Xj92QWlUrxKmTkbk830kAMD2DBs5kdymEAcB9kkMjRJj/4Aqcnwe2AKkidW/9VShEvap67E/evtOTHM5I9tNBf8VmcSW8kwejqY/AP4Ce7E/ZGee0ybF3AvoCA09Me8RwCLoYGDbekj8DMi6cQCrm0ZpwJ7m0Ew6cKRXSrj+1S6e4oT87QMDP9FT5Paflx2jqJSorRNdTQJBCG5bPDzeEAWdYWcqQNzilBL8TqpQNnVUPxzM3oQNOCiUW/RnJ0LGsJIkQwHWrEoZqdagYHnUl46knEEwf8FD9qOSPNRSKYz826OiYjH7o6GGNw6T3MNHiemvVtpCEGHuyPd8l/G40mvzmal+V/B2hXTS6QfMOI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(44832011)(8936002)(1076003)(2616005)(426003)(336012)(47076005)(36860700001)(186003)(7696005)(26005)(16526019)(8676002)(356005)(4326008)(54906003)(110136005)(508600001)(316002)(36756003)(6666004)(81166007)(83380400001)(7416002)(5660300002)(40460700003)(7406005)(70206006)(86362001)(70586007)(82310400004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:05.7927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a471bd17-0564-4b82-b4fa-08d9f7b6d3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

