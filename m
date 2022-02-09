Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECD4AF92D
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiBISLj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiBISLg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:36 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5CC05CB82;
        Wed,  9 Feb 2022 10:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNhqBThTUQyeubL7zxh1tO6y/TG7PcKuMxcx5g6IkBFdI82+PGT/lSvTNFmQM1ddTWkEKf6VMyncaFPpWVrhuciLcktk5oVptfxXH9+QqFsISq+n7IuMS0jKQhcoKLcACwmV8p0KrEL72v8QXg8wp+J0ZBIqSuDtTMzat303PmiNMARhVM+QSHwXmQqh39k6s5MBa9Nvc5f3INK7a3aVeW7/XLRrSrq+pa2QTVBwgC4npP43JPP0KRKcxN70MkHp2fj15SH33ki/wPEZX4SBympvttGWgn7w6mJqQpoVMPjOaFZprOd2jkFHcrnDwCo3lUJe1AS73T+gco+Q13j66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=itXf1Pc1WU6vHYY0s/ffkvqwxtUuSoSrLJTTQaFx2mpSZ7DsnUTBuEnS9OzZOZ/OZRPUjVLoYoFZr/tQ7lZwP6davDTu1C+TUb3o4lO4YFosg04MpkMLAR7ln+2/e/cKuwrpOoO4cXXDTt5IRThviJf42QBN0u9aTNHsOhDoWvWWP6aGp+3r6DtZDsK/Focb4nboGTbPavdWdjJn8QHZqN88OsZ2NZgaIH6Pnurx8IyitbvxN+XUea6p4pFb9xWc7ROuQ9x1JorAccx9dwjQO8MZGplrWCw/wEMkY8n5eKar73Sp6ZqJOSXscPX3XUIwE4zmAkd4gcikgD3jRP7KZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aRp96xJYoJkUtJqh/6AVXRPkQBSGiHUk12Gp42+tkg=;
 b=bTf3Mb9Vh//lvieZGdvsnjTcSi4uALSWm0NwdhnYvwQRz0Xjt3l2iJWHvbKVfZxvj9UGPwdINuGi2qu9XU1LcoKbvZ65huFlr7LCnFqZAWqonFuzJNAm79jOPAO5yXkO8hTlZbCXgkIQRWnAfGRYzYvt+eu0bJWnJ8s3jtkVaFA=
Received: from BN6PR16CA0014.namprd16.prod.outlook.com (2603:10b6:404:f5::24)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 18:11:37 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::b2) by BN6PR16CA0014.outlook.office365.com
 (2603:10b6:404:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:36 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:34 -0600
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
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v10 06/45] x86/boot: Use MSR read/write helpers instead of inline assembly
Date:   Wed, 9 Feb 2022 12:10:00 -0600
Message-ID: <20220209181039.1262882-7-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31d42137-c277-4fe3-6556-08d9ebf79ccc
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974435E3699690B9A57C9E0E52E9@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jO1S9TpgpPCucXACB+H1Kri70T0fZbnIhcLxCpe/CYoOOTWky7f2IxdeidOt53whjQprQOZSXNJh3h0FQwsxuHzIxk1xv58UcwDrl4mAtep1gaWDBvtRa1ebkCOLd7L4KUdQvOUzmdhYYfD6WNVNMz3K48VN6J4aZYwJ/dXyT9ER+e0KsJzgUw7TGuAsY8LcwJL+H/9glXP6xlGujM/GNy9gDIRsTGyhuSwDYPutqAM3AnCXME7t7vg6pm13r/uaD0O+ryQmSw5jl8S5zel/9f285ZcBIZWorxznW+aS8bc5Ts4WsofYAg8hR81vHzFjd3T+UX07JF7Vai6686amGmsv/zFnKpfYwDocrJZ7QyVwcw9zFZs5xbTGYNMZIxc9/H5U1ggmkj8Zo9YDbcX154XN2D0HgJOXwusuDKuwIUVaHzAiypNDLyERKTxndz7MIDm6bJvZ4Emu0FwwElTJeUTsIFv79S/WWPdenXDCzw/wdm763WfDMSeJzz/H5cb6X7ABNHCpD2sHj9ZcMMq9w8GKaCc5z9hiUPEPVTyg9AxfsXiDSjIBBFwTmJjV3YfD1ndhwpnA0z7/oLw+nhWSj2tJpU1tSZ7bjYSbWjkdTyl8qqX8A8buNooEqXKlN2PAqreKTiExMIxtI9pMUTVU6zdAhbjK5h/pR0vuzyyTeZTkbfGGim5IIRa1l1DSiLjFP6+Q9LFQN72mB/nGv6Pxcqh5g9u/e3odTzKhSuJPYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7406005)(82310400004)(7696005)(5660300002)(186003)(70586007)(1076003)(54906003)(110136005)(47076005)(36756003)(8936002)(7416002)(70206006)(26005)(16526019)(86362001)(316002)(83380400001)(4326008)(6666004)(8676002)(2906002)(508600001)(44832011)(40460700003)(336012)(2616005)(426003)(356005)(36860700001)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:36.8945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d42137-c277-4fe3-6556-08d9ebf79ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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

