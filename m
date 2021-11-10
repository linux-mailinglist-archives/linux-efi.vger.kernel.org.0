Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC1144CB93
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhKJWKt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:10:49 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:17169
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233321AbhKJWKs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoRRdRX2zYp5y32sIZWPtRJXhFM1Sw7QJAJgbukohPEYMcSVfixQO1NiiK/4ZgBv4cwox7a4DOdep+v/yYlsrShspdr+JTwlMr8OQR6l/75/yRgOPNy6WMmiNAfK67ZFIBjkqcW7Qm4zzc8RpnkrLPKw7O2LOUbl/lTY9daOEqpOzQNvEcHX8KNoC8mFSzNCkXJgg6nP2nklLFiQPLwH8J4zbMhv6RKr5OmBTv5jlnNaY3lLIlo/oUcpIIQYqysZ+SAn2gyD83H8E7278Z64QmE3z3v6hdXixvKKpZU//UnC7iiftuUiKS0xyzswaYC1FWJiVy15zh/zXvxFiZ/5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEnsTMHm1Y6h4pPxIHgJNvQJkkF6HCrFo533wM1wLdw=;
 b=gD0aW9w0xp2128rVlqIJgjWmoy/kpYkJ6ZBFKuMZNIvncGxZT79baiJHEdQrZOmHd4l8anNNKoiSWlvlJVfKFG7KPbgwkSo29n64KOBeu+R1eQ4YpCXDfYJYFDaCp9bq9URTNkeoiqXLGB8GAej0y7d0ToAtiP713Fn22uLtDSGTRdr0lMpDdDFYFZ3E3t9WP+hWNrIhvJF4mutSSdzlYex9EVMMQ4vqZU6S14xAnt9/CWFrIHKv0la1YlYr0qr2OsjHtEaJeBq4enxJR0HNAmnBMuZXsX+OzgGV5UvQQlYKPLPxb0uClGPQs/jrj8FhS/7VPbnkCvMsb6oaJc8uqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEnsTMHm1Y6h4pPxIHgJNvQJkkF6HCrFo533wM1wLdw=;
 b=MhfdTLg9+mRB5MN78PbbGrjnnLQTVyPx0p/QbRD7wM62WOFMCJip99WF/WllHu+3bJu0zgN0j8/DR9aH08Pkehn0BrEpVLgz8Aqx/RdiKfNcmfTpqHNka9Gpq1vaotKP5oDk1YSXkqonyQgeKnwtMFGsUe/e4VtCy0fASA6sNFQ=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 22:07:57 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:07:57 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:54 -0600
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
Subject: [PATCH v7 02/45] x86/sev: detect/setup SEV/SME features earlier in boot
Date:   Wed, 10 Nov 2021 16:06:48 -0600
Message-ID: <20211110220731.2396491-3-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95d1b8ed-1d40-4a07-b506-08d9a4968d5d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2624:
X-Microsoft-Antispam-PRVS: <SN6PR12MB262410A7C13E57A66323C047E5939@SN6PR12MB2624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22MDMREAd2+wgb3hO4CemIq5HJSEOhc1g2GiCFSvpZIQFMmAV8jmIwTlO3VrqpAEVauhfSHqn26EDPt7UzJTkuMTT6H/etVogl9jFQ/zPU0uL+voTx99lX6Ydd7ue8wIXCzTXixxZpzZ90xbadgDdnFLCSRr+XY15VndNYtCs0uuyouvjCc7JDBG/MMWYXi9RQbNqUM2rpY4prELz7Uck26npfBZPAO2cQVL0FxDMV036FzKxViTnzgWA5GJbDy7jD77etch2pt32IkdMjpyeGMAqtdsZrgt1qm/Gx8u8UXJVqWAqnAaIsBlmNLfQ50JHfdDA5lZR++bTiH1zXPIFStNZyqRKsUA+1xF7Fbm3CsmhE3L3Dm3q0xtwzph2276KG1VpsoGEoLjZ0h6mGV1+DLHQdWV3h4QYrJVyfow18XasiTRK73/m5sPAkMsmYospUnOefZqBbzh8DxOlRpB1Oa1FrnJiPom4tuCnO57qtAzdUo4QAVp09FrQPawSCKRSUSa/PoTIlZ9kKe1gwRuaDzN50dLTh/cG2fF7soY6qjLWCTwqnUwpCP2hSsFYVmFxY+DJHut4ep9AwACOJZATwBQOeTyxeAQyDbwXd4Dq6zAW558dzJLt+AIYLinoaXqXiiGaCtspLlph3m/TjxzYf+XZaeH0/w16HdblFZ/TIy0Bg2ZP1GA1ajctNoMg7HpT+8Ov0kxryMpMUlDC+o9S0eLA7f4MkF3MzfaHlj/B2rV4nevuZED/5/7efIu7CFF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(5660300002)(2906002)(70206006)(8676002)(36756003)(110136005)(36860700001)(54906003)(336012)(44832011)(508600001)(47076005)(186003)(26005)(81166007)(16526019)(6666004)(8936002)(7406005)(82310400003)(316002)(86362001)(83380400001)(7416002)(356005)(1076003)(7696005)(70586007)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:07:57.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d1b8ed-1d40-4a07-b506-08d9a4968d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

sme_enable() handles feature detection for both SEV and SME. Future
patches will also use it for SEV-SNP feature detection/setup, which
will need to be done immediately after the first #VC handler is set up.
Move it now in preparation.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a7a8d4..cee1e816fdcd 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,7 +50,7 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
-extern void startup_64_setup_env(unsigned long physbase);
+extern void startup_64_setup_env(unsigned long physbase, struct boot_params *bp);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fc5371a7e9d1..4eb83ae7ceb8 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -163,9 +163,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (load_delta & ~PMD_PAGE_MASK)
 		for (;;);
 
-	/* Activate Secure Memory Encryption (SME) if supported and enabled */
-	sme_enable(bp);
-
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
@@ -594,7 +591,7 @@ void early_setup_idt(void)
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_env(unsigned long physbase, struct boot_params *bp)
 {
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
@@ -606,4 +603,7 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
 	startup_64_load_idt(physbase);
+
+	/* Activate SEV/SME memory encryption if supported/enabled. */
+	sme_enable(bp);
 }
-- 
2.25.1

