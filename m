Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C94AF921
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiBISLm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiBISLl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3CC05CB90;
        Wed,  9 Feb 2022 10:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPs8IOWEit6uOAfgm0vuVWP/goFAgMDvYIzHxsqyewCJgY+2te/Tg54Tt/e+dT+liRyv3FigV75rO+IFyZa5jLFVpBNaGamoyxRLk9hAF/zxatDC+BKm9m6FgYG+NAfR+VVtr48BWQSw7BGSMgl/j2as5PrlnSN4R09nEhOk4NW9b8GcOaXpqf3SomxHoY/9vBRJt22TMasSQ6XefLUt55YqjCucaHhok/cVYMTpo7dBfMh7LZVpFiHIHb4Msfw9LXWXixoR8Kn88z7OqM4kzO26ryjYj80IvQz5XrvZ9QXy2C6Wsf1vnO6dgR40iuOFDIFjy3bjeEt4cTw/zpXqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeU2V0w6Nz9qgWA1HpE9sJhUD0bvSli5PX0rh34aFqA=;
 b=PldDFNSkdA9my1rzNXwObardLSDu2jo6+LqXQukHv2+qQVU5cLnMtDXr/0Yi9X1Y4ge5PbcaXUyGz9XCbEbEaGsbTH0HPfzQTBfDf6VL5yhSSlt5iMcYLGDnOF3v/SHvFmSh0scFu0FSQTb91/6ciEmD/bjM6WhMFpMwRT83C8tT9baKzcvWDdlb2njocNcLRLvvcfdtK2z3SQbaUNytZGCvEi40Oo4GVBoRRKi944A/WqdZWAT30nvEL22nj2prvJCZiqO/q3hYEBs3hbZU6GztVxQimoBrL/Xvg73gk3ryRo0XSd2sReB6bgyqglvag6EV570tbnF0H4K+LBHlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeU2V0w6Nz9qgWA1HpE9sJhUD0bvSli5PX0rh34aFqA=;
 b=kHpSurTEzQEyYWrcXwl/8zjGCVB4zaPrrhDNVca2vzuPIpXu6ckzU/UKwsirEgiXMC/Cn3KXjXQNYS/jpqladm/7RsvOyNCWd82P73fxGC1XVStzTCl/uUfD6C5zkrs2jcxDph6bHHZMidiPi/9Q9Jskxp+CkLLoWbtbcl3eKeQ=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by BN8PR12MB3267.namprd12.prod.outlook.com (2603:10b6:408:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:11:40 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::ab) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:38 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v10 08/45] x86/sev: Detect/setup SEV/SME features earlier in boot
Date:   Wed, 9 Feb 2022 12:10:02 -0600
Message-ID: <20220209181039.1262882-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a918750-c348-423d-9a98-08d9ebf79f00
X-MS-TrafficTypeDiagnostic: BN8PR12MB3267:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32678FA8CFC95D1B15D44215E52E9@BN8PR12MB3267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0+xAtLC9z0aLyZg6BZXmn3G1B8a+Q9ax7d2wPmbXb35Gj0ntzddPOuGTIfSwdLyyuxqi/va5nnN2ch0Z9VNGesJW5mhArq9NG0w3W24xZCoeXwBEIgZ4f0Mzf4mkypcEz7RFcbSbAdbgXFeic99szMDw8Ld8td2g2YFcD50zJOYUaoquy9rAj77K3bg1IwjAX9sbEagt6cfqOmETJ54Hu2bJPDzk29rH5l7trwW3GabAo0YCT3Yp7Q42ofrr3xVkeZART7xxRnUFjw+eK0xRB2S8Egrk2Ubkvr8zjFh4hCPIwoxf9QM27NbG5B22PsaxAOeUBdMn7fnkOUJdHrBVTV1+4guqcVQwZJyGNwK9k+tBUc0ePnKEvl+vuVH+PN97GgfGLV9l0XPAu2DYllVcttZ0FQXMFOH5jm1KBw9JTW9xGLa3+z/P4YBZaeR8rj4onw2H/1e5btIQNBxoKQBomDMz9wTF4IpsUSeVSWvaOmm+9hWSlY0X94LnHOnWoMd/gWbiVzproL51jeqtll4gglpzlaU4hy12J8uASZ79zZplzzAD/Wg+Qf3SnoA5gi8KHVxxHt+DNo7E/fIkxwwRkj2eY7YfEdSV/nzL8dtedSecxDgJbP4Zf0IDNYhNP2ieUZAKfV5E9PeQ6glGdWUFlqJMeyupFvjDwZ2n0mh5UEx+Xg0joH1TkjcEkWxkX9MEQPV/U6ckHzvw8gmwqtzQx8uS99Bz5hfYtP68zkPN3Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(82310400004)(6666004)(5660300002)(1076003)(16526019)(8676002)(36756003)(7696005)(8936002)(2906002)(186003)(26005)(336012)(40460700003)(7416002)(7406005)(83380400001)(36860700001)(86362001)(44832011)(356005)(4326008)(316002)(508600001)(47076005)(2616005)(110136005)(54906003)(81166007)(426003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:40.6077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a918750-c348-423d-9a98-08d9ebf79f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3267
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

sme_enable() handles feature detection for both SEV and SME. Future
patches will also use it for SEV-SNP feature detection/setup, which
will need to be done immediately after the first #VC handler is set up.
Move it now in preparation.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c  |  3 ---
 arch/x86/kernel/head_64.S | 13 +++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de563db9cdcd..66363f51a3ad 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -192,9 +192,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (load_delta & ~PMD_PAGE_MASK)
 		for (;;);
 
-	/* Activate Secure Memory Encryption (SME) if supported and enabled */
-	sme_enable(bp);
-
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9c63fc5988cd..9c2c3aff5ee4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -69,6 +69,19 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
+	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
+	 * which needs to be done before any CPUID instructions are executed in
+	 * subsequent code.
+	 */
+	movq	%rsi, %rdi
+	pushq	%rsi
+	call	sme_enable
+	popq	%rsi
+#endif
+
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
 	leaq	.Lon_kernel_cs(%rip), %rax
-- 
2.25.1

