Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6E44CC17
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhKJWN0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:26 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:61463
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233616AbhKJWLt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPSOsPGk9WLjuuGh6Bxjq3cFta0RbaE3cAIr43vVnk6tNAsCFmqeAR3glVYhZDCp9EU1bkxk9RB1IzvwIu8RSu4v5E3jNkdQ8Tol0XP4jzvJG2IyLQDGqgqYouwKK6BZYuFL8exLojPjRypJvEf22IQWyylf7qbJu5P/pURAsjM6vXvnoPBDhxMAVxNNsDgesFXsCc+6JZjwipHm2j/NrG/zGT37vaiSBrwB3OdGjXfQND/0ieD9quIFunblqaNrAt5aKw8UL+xfeK0y9O+2XahFgaQeOVjIdI8GsRDcIp1U9v/hJN4FIP7hrzty1LmoWLWRo13jGycpLlpX7ZPdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2pwycZP9b2d+FvQ7L8TI58tPo+uaBz3aik/iBD1qXg=;
 b=aRDOTdLVNbQ+Fc5huo56514o7OeuzPu3vOLQH+i/3nYHMMtJYbz4XoZzaU14dIb0iG67H7PJOIHtJtguYyWPklabVa1ILOMvgmCRh8xgoR6XzLxbZrRtw8ICBA/7tX6G4blhdVRJYQq7XnBAW3FyhCVpOhj4hShF8mgarfTglsUn3ExN6Tg96iwtGPfECtIJoSvGllVZwfj7tEZWEwGZ9S+AH4LYiodj1MpKCbk4/9K+hRlcJmV3konMPJZCYrFw35aCnIvsNkNaKzpWvD+czt04rE6OhIsIrbpbTnWK80xTU08MV6XMAgAz98gppdOneZnjg0/jVw71fk9y+dZ+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2pwycZP9b2d+FvQ7L8TI58tPo+uaBz3aik/iBD1qXg=;
 b=OcXgQpa2uemeiXhWUja/ba/tJ9HqZWj3b2iyXwJTPMZ4oLXVh3ps1Jgfxv1NfOdabDSNQuItNmRgDyclQ+MIEFpX2SostRUmgu06p9DJqwXhtDab+X0UhRDkU+xcr2Uarb/M5vUisCIXo22NRmPbRkyXTEdoHO/hkfORj8xjtJM=
Received: from DM5PR2001CA0020.namprd20.prod.outlook.com (2603:10b6:4:16::30)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 22:09:00 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::e2) by DM5PR2001CA0020.outlook.office365.com
 (2603:10b6:4:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:57 -0600
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
Subject: [PATCH v7 40/45] x86/sev: use firmware-validated CPUID for SEV-SNP guests
Date:   Wed, 10 Nov 2021 16:07:26 -0600
Message-ID: <20211110220731.2396491-41-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5aaa125-6c4f-4d44-7cf7-08d9a496b2a5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1316CC5F8DB209DE9D8B4FA3E5939@BN6PR12MB1316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjCVvM5ku7ca7a5Uot3xGUUaD639dbyDuId1ICEM4oLoqu0jZ/M8tN3ykLQFJLyxVxADQlApU0gtrhglPnZVSyn51FXsBxe3PiHqM62dQuHiNbBJkqe046Xx5APeWcob75rbwBpfYVRj7n4uAzXGLlkJeiedlY6due6stGeGzRRlBbudf4cVT15yuFTmCKplqPTcMYBZB1mNZJH2CAVLcZG+Auj224dpBEQGKKTvKOX/THlBLptVS28+hqad2UR07g78yWWb225dNmdS8YglBizP4Pq7KyHGZqQYC/H9B226zhT+WJLORlYYP6wFJUTmb46Cozr1G2xRyJfIHlz0ShQ6mwjgiywuPMx1AM8w7jIt8YkIQqGJhe2bJlRYrzkt4QyHWRm7WiPz6wW42o4lWZhGJ7ttjY3KD+OMR9pfExVh3GnHIl2Uat2iPTRXi5jF1GNKFkem8sKKaCG+8praN1d876EevTWvJPxZPRnXmJD6zBoEuQ/xRA8HtDudig8mktzJ3dq+oDXWvH3XNyuJf/IglRX5Qcb8GIonJqjdFFeBbytrgYcruppU9gqRITQLVKAqZQYzZtd0Km+H0Rt6mp3Cq8tUJL1AKJH+Y9g+RWeUPRf2Hzg2DCdKgytP5SXk4vJRKgqi4UK85VwmKaOso06hcJiwyrHFU+38dMzwm/ZQycAkLEqaqJFohcuTpmstV8sAYPXcgFS62pc09Q3WMTjEz4YWmgrjyoMhoSiydynPaTfRZcnWvpIPaKe25TOZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(2906002)(5660300002)(8676002)(110136005)(336012)(16526019)(15650500001)(26005)(36756003)(4326008)(54906003)(6666004)(70586007)(186003)(70206006)(47076005)(356005)(82310400003)(8936002)(7696005)(83380400001)(44832011)(316002)(2616005)(426003)(81166007)(86362001)(1076003)(7406005)(7416002)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:59.7965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aaa125-6c4f-4d44-7cf7-08d9a496b2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets' and
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the run-time kernel either through bootparams field that
was initialized by the boot/compressed kernel, or via a setup_data
structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
run-time kernel will use when servicing cpuid instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   | 10 ----------
 arch/x86/kernel/sev-shared.c |  2 +-
 arch/x86/kernel/sev.c        | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2c382533aeea..76a208fd451b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -148,16 +148,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
-/*
- * TODO: These are exported only temporarily while boot/compressed/sev.c is
- * the only user. This is to avoid unused function warnings for kernel/sev.c
- * during the build of kernel proper.
- *
- * Once the code is added to consume these in kernel proper these functions
- * can be moved back to being statically-scoped to units that pull in
- * sev-shared.c via #include and these declarations can be dropped.
- */
-void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index d91b61061b1d..ce06cb7c8ed0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1010,7 +1010,7 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
+static void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b794606c7ab2..5d17f665124a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2062,6 +2062,12 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	snp_cpuid_info_create(cc_info);
+
+	/* SEV-SNP CPUID table is set up now. Do some sanity checks. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
@@ -2075,3 +2081,34 @@ void __init snp_abort(void)
 {
 	sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
 }
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it. So
+ * do it here, and while at it, go ahead and re-verify that nothing strange has
+ * happened between early boot and now.
+ */
+static int __init snp_cpuid_check_status(void)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP)) {
+		/* Firmware should not have advertised the feature. */
+		if (snp_cpuid_active())
+			panic("Invalid use of SEV-SNP CPUID table.");
+		return 0;
+	}
+
+	/* CPUID table should always be available when SEV-SNP is enabled. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	pr_info("Using SEV-SNP CPUID table, %d entries present.\n",
+		cpuid_info->count);
+
+	return 0;
+}
+
+arch_initcall(snp_cpuid_check_status);
-- 
2.25.1

