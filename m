Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288EA426FF4
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhJHSHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:37 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:63553
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240000AbhJHSHY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRe+pvqwsyyDnRtMt3RROOkjPuDzMEKRgkYvtsEcSGn/V+iuNAn4SjcP0V6ni8186Xm3yx0gwd3LIbzLizpsTLixKIRNxUII0SpJKjy1FllIWbQBjSQjXis35bIxWITR+N7WgcfZRklWzmVsEVHNezykCuzNaw14BmoRSSLsUnXcF+m0TL3nosCVBk8WIubuCA008aKyVfYfyjTFpmCLexWquDcA/i7ZYnDgfUjNxHBuks0DTL/5YU5u01mfyGTVvS9kR5+tYN6KSxqX0x67/ZbBwVEzGfsIW0G3eXedeJZVOgbwCM2hEG0vVMASot5QzHh1hE+knDUKkx1ok/U3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaaqkM4lgL7Esve0BEb/StBrhPYTXZw5tyafWAwKLtI=;
 b=PXfQMPoRD2lOwKF09xXPJbY0kAoK7DAQ8ETQagOD5IaFgIfGBIc9Kd9lBQ3667PcTa2FIi5+aBIDHToBp9EEhsKE6ZS5PTTp4a4uyynr6dWwmPd7zgGKikGLqGW8h7rabMj67KDrwUukbxtbgq84AhXzLdQ33jRaiRFd7yX3B4f0EQNNHF8zH/0ltw5JvPVHKJZ7loK2PVurAZ16maYmxxVYIe0AdaD1SCVKIy6Vv08bLBxo3F8WKGbKgmVdYx0mfP5n1lV3d4CWacWf3tHS0rBkAyu7VNlVxJds/YMsSA/yTt1eLOdvs+h73LlnWWAJVw8NVot8OrIA7lAAokenhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaaqkM4lgL7Esve0BEb/StBrhPYTXZw5tyafWAwKLtI=;
 b=pck95LE0Vzxs0kF1Y8m5OIKsHc04B3lr+Flmr7hQyJun04jPPOPYusGuhvx8aANNRn8fpmx9x1b+GXD+S21QXBlSaBdFZPmyKGKUuGnhxl1v14MIm3gSWz+FAswSugbfbs8TN00zzPHwdPWs5QAVryWKBcKmtotOSEXC9WrhB7M=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 8 Oct
 2021 18:05:19 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e0) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:19 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:16 -0500
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
Subject: [PATCH v6 04/42] x86/head64: Carve out the guest encryption postprocessing into a helper
Date:   Fri, 8 Oct 2021 13:04:15 -0500
Message-ID: <20211008180453.462291-5-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a51d2e90-7c2b-4d66-66a4-08d98a86307c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3535230E1AF9216DEC7F2B84E5B29@MN2PR12MB3535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY4XK6v8CxPo2OpCraQ4Uo4iGRZDbMG5koLM57oQEXlLVgkAiejpuN+DUSsLWD3Rtg/UWaaOQgB66hcDPIMiz0t1xymFUnK2Vy8bEBFQzbB77TJXA44tbbaTp5tcu9oY//I27sxLBhZzKM/Ezfb2d64zU847DvfnYxOmIgefxshZ+4F99Ww1BIpOBByVUUiOJPu39rGC8F82ckwEzyiiruYh5NqAfhw04saT4SSV7M4kxcRM+tFm/344jNEtCRO06nGcH5LJez6ePVt+pkZIo8Zn9btJl7E1DRWFW02TI5aW2waIX3tVXik4YBkskjtC8nA0Jf/KLtvrJ0CzrJ7m/KKRqI12BcMKm8DQoiNKdGqoRQh1/oWdtjCCQKdBl0pol9kezvkMLCIXTycJePAHA2MHUf+YN2dKKDCh1TyLVOJI6L8zGo4uuSrrO/wDu+m+PxX1sQWKLAfXyFy4pKm9f2uTwlH0Vh3Pc533g6uXqOLnqPo+VADA9O/lPcKWDct8Hn52jljtFimh1K7GJAg1yDOjyzw2bADy7pd26prCEAe7Tvd0l8f0Su7AxynRy0g5cVKq43ZO7UbU+HsbxPzqj8ONUsazAKKTXamTzsvguW+9Ng/zF5ZGqTsHLz6ziECBEHtKkvu7FhR12D4Lkv2ZzRklzQp/CnmPZLCJfv4UQqmxdgpnE5dAPTFc3Ul5OJBEt+tcp3xLCXe41TfVyvpd60pEIgDkk0nQITxfx/W7n87Xus5lV/05lo4UYtfcMsDT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(2616005)(47076005)(2906002)(110136005)(54906003)(81166007)(82310400003)(426003)(1076003)(5660300002)(356005)(36756003)(336012)(316002)(4326008)(508600001)(70206006)(36860700001)(8936002)(86362001)(70586007)(26005)(83380400001)(44832011)(7696005)(7416002)(16526019)(186003)(7406005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:19.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51d2e90-7c2b-4d66-66a4-08d98a86307c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve it out so that it is abstracted out of the main boot path. All
other encrypted guest-relevant processing should be placed in there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fc5371a7e9d1..3be9dd213dad 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,6 +126,36 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
 /* Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
@@ -135,7 +165,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -276,34 +305,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 *
-	 * This is early code, use an open coded check for SME instead of
-	 * using cc_platform_has(). This eliminates worries about removing
-	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
-	 * function.
-	 */
-	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
+	return sme_postprocess_startup(bp, pmd);
 }
 
 unsigned long __startup_secondary_64(void)
-- 
2.25.1

