Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1344CBA0
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhKJWLA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:00 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:39137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233587AbhKJWKx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/8fpYGZHJ4bwCdYZhIKfXqvzrX1gII33PuTTFkl0PXy9osIXFNLxiwSGiGumYo3CEduLwk/NS0j3lnDLK8FbaHT1GhL+Xr/SCKayKEqT2A0EkIuOOgpXZ7ucnayMZAQCZpdFBhJUtk0RxEe+MaXQu0VHIVtaeeXtJsaEtn0AiQaHS9cDOvk98gf3U0T/s5dZmTdPDQbMxIejL7C2l2oo5jlX+HEHP2FFDg43x0sJrR9FOnDw1oWrctI84zBdLYF+LFG3qm8FzRelGHa0AvfvS6yTb9fcyj02FSblTXDlO9rJHVr9NuT/uOWlgkAKqrv9UQzyLWtiebgv82UL+MrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVGM99tOhFLmtPKPQKktQ8adUrxRzdV5p82RiVwNUy8=;
 b=GpUkxbIKVlAZrAhRigB5aiDlpJoXooB2tcNW+0JThseimIP9QP8ESQb98ay88UY/XiGQbaic6zYMaZ0Jv3sdIf258yTkItCEp+lB83Fut5nQtW6Rlwd1tDKV6Uch49NjJDKP1Fewv1pHbhLvi51g5GlYusGvuVkIrbcvBK3iPoWuvYAr/2UQDcliDqZqo2TRH8OuaCPNkgrBe/+5hr5pGJbpkrCAU1rvqItVHxrrSI7AXegDH0S5fT1KORbI3DTx0e3OzDIO52mYUy/QMUOcMWYkBy/DkPmOYPKe1cTyzbcP0qll0NBG7HqYfqZCprwLG2yQxv7aQWfNKW2UZGakaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVGM99tOhFLmtPKPQKktQ8adUrxRzdV5p82RiVwNUy8=;
 b=CQFPkmTHKNvbIRfvlf4QmCXw80U4AIFq2UfvCfg4etnQdLupsuAeVMUmed0g+ovMZVhyppLKwkmSKTjZXzUSieVIgDkBdP+EXRIpZv8KxuILzy2NhueA803z+1UA9P7A/xFC5XY+1V1snKyEUwKZIAgOLplnx54X3qLzR9r5ALI=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 22:08:02 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::91) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:02 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:59 -0600
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
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v7 05/45] x86/sev: Get rid of excessive use of defines
Date:   Wed, 10 Nov 2021 16:06:51 -0600
Message-ID: <20211110220731.2396491-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d03d2ee-64f4-4b3c-738b-08d9a4969033
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5107A8B3CFB9FA1283E535D3E5939@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUxW70QD7BHlte3azEFUmUv5ZL9Fu4sSBPMdpliUIhw3cZfNe8a2tHek7qhU7ucGKB/+JHPiWVRIb8dp7X4l8zoePFiYgaLTamahsLjaqfHb2m1GZTgwrNqvkrZ//KNJPjsymun+6V3z+/wGkrgk4vWxFUkjCEN1UkLgDccWWdRkK3x1TqDbR39FumvTqjuwDPf1V8OsNA+YNYL53u8J+Ne17RXjh7Q58igO80hwnaMMnAa8Fw38foQqxvRcGQhO4X+NROOq8ICAhi9u6+5kPzMe7wBcL16+NqPizoPLPHHcgsBTa4q+NM/lUnqo/JwfLqa8fJl6coow9TwP9u/vHPSP36Aw0G5TKxAJ/GmkUVgI4z9aFslybcNJitUBHc6fPLAhrYVY+9OGVcc7ZDu1Yhh1AQhpeiJnlsFr63kGS2n1zOz9Hx4Ite5wDcbyo/xDKFDM+ufY7ldFfTFFBRKhXnjM+KM0kxS7pFuKKpZVGWejnI8sodVX8LpEigvY7YRoLjbrVCmzl0mp5CFbByCgduLAjgRhWbbDzs+96A9yuxZysGXyBiy6XIUKvplSkr1JOC0eFk5iq/kuqbJMqiiVQ8V63U5rS3Ps0skWy7/rr3p9nDc+GzjPtNfPYeQkhx1fi6901QXGYwyPlt2RJFdx36wFwPVjUy9sJRrXoIMW7B8T/ZfpcT1ionqLuu1nve6XU/+xIS9xsXZpzj+dtpjmfFKyBRt3b3W/fTVX2Y/VQwe+Amrugtzc7/fzsaSJErII4ou95jNfvF/w+hKEKqj2BwyeGpX4AcHgSp4YGhFYetw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(186003)(36756003)(83380400001)(26005)(7416002)(316002)(5660300002)(81166007)(86362001)(47076005)(36860700001)(356005)(44832011)(82310400003)(336012)(70206006)(6666004)(7696005)(70586007)(426003)(110136005)(8676002)(2616005)(8936002)(16526019)(7406005)(508600001)(4326008)(1076003)(54906003)(26583001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:02.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d03d2ee-64f4-4b3c-738b-08d9a4969033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Remove all the defines of masks and bit positions for the GHCB MSR
protocol and use comments instead which correspond directly to the spec
so that following those can be a lot easier and straightforward with the
spec opened in parallel to the code.

Aligh vertically while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev-common.h | 51 +++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 855b0ec9c4e8..aac44c3f839c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -18,20 +18,19 @@
 /* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)	\
+	/* GHCBData[63:48] */			\
+	((((_max) & 0xffff) << 48) |		\
+	 /* GHCBData[47:32] */			\
+	 (((_min) & 0xffff) << 32) |		\
+	 /* GHCBData[31:24] */			\
+	 (((_cbit) & 0xff)  << 24) |		\
 	 GHCB_MSR_SEV_INFO_RESP)
+
 #define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
-#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
-#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> 48) & 0xffff)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> 32) & 0xffff)
 
 /* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
@@ -46,27 +45,33 @@
 #define GHCB_CPUID_REQ_EBX		1
 #define GHCB_CPUID_REQ_ECX		2
 #define GHCB_CPUID_REQ_EDX		3
-#define GHCB_CPUID_REQ(fn, reg)		\
-		(GHCB_MSR_CPUID_REQ | \
-		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
-		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+#define GHCB_CPUID_REQ(fn, reg)				\
+	/* GHCBData[11:0] */				\
+	(GHCB_MSR_CPUID_REQ |				\
+	/* GHCBData[31:12] */				\
+	(((unsigned long)(reg) & 0x3) << 30) |		\
+	/* GHCBData[63:32] */				\
+	(((unsigned long)fn) << 32))
 
 /* AP Reset Hold */
-#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
-#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
 /* GHCB Hypervisor Feature Request/Response */
-#define GHCB_MSR_HV_FT_REQ			0x080
-#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_REQ		0x080
+#define GHCB_MSR_HV_FT_RESP		0x081
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
 #define GHCB_MSR_TERM_REASON_POS	16
 #define GHCB_MSR_TERM_REASON_MASK	0xff
-#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
-	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
-	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)	\
+	/* GHCBData[15:12] */				\
+	(((((u64)reason_set) &  0xf) << 12) |		\
+	 /* GHCBData[23:16] */				\
+	((((u64)reason_val) & 0xff) << 16))
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
-- 
2.25.1

