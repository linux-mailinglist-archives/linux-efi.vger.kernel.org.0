Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955AD49FF5D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351422AbiA1RVQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:21:16 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:64160
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350557AbiA1RT3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WctFc4YKeLw+9JM1dt+ftXRjLqvP3IiTKERO8WNbTBx+XQlqHpI8WD3uz1U630Soe50IU5gVzVA+ChoaYvuqH/swK7vOuggAjA/IZy6JPV7+Wyjo7MEu7BkIZpOwHsHpbCs+1Unwv0Pm9FunoMxbGoIH+cbJosRWk+fGrDnHu3whwJsmWqD291cNh8KiCDWO6vu7uEQQIhDluNjkATN7esM5WYh3NeCVG4UQem41NNJbPTT3ufSqSCcMT8jV7uiIU2rYt7aWwQj18x5xH7oDEB+infnfoIuE75SZAFiWucA8kr5rlu60vxYDk40s48ltQmJQOUTKWeSJLOEJ9pMFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I8ik+Z8vl3f5lq9t7cECtuKKsV6NVTIzQWtzYw/iv8=;
 b=GhcaQq9x8pwBrSpBmJAkpLY+bwUgp+42s/J19FbEWQg24+koxA9gMSaXE/9nvXBHeoHR6JrxujZDyeXJl3I2bm641kHukSPuTs2U2nsWnE2jEj+kQGvWIjztLrEPSfI04nNxKNrbmCRCo8xR2ghgE55gVOUDCk/Yg1dpUAtVEI7XooAtSrgoUs+HeqVA5fv2LCPQDwxAAyU0BlCpErZlVFwooxiD2yJ3qK5eCoS+gIdYNTcW6cqKxACzC8gX2a/Osx6TeU7er+hCmwoL5RdT6c2R1yXyFm0DhZNpOI1J/kPKUbj/JAUOMiDUziEmjb0Syd61zKA1KE2bIm/2WGwUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I8ik+Z8vl3f5lq9t7cECtuKKsV6NVTIzQWtzYw/iv8=;
 b=ORj9sey+LxHRWqjQbS9tzEsQPErpO3yOew87X/Fwie3XKKiV+LiTG+F9PC1l/3i31QQzYJwe/0JCLVVHjGJ3ksdHRklzt0cwf8OPaXI3mkG6v7p9RcNItMZ+1cWubOFO1VICvg3o4uOMqGS7i8VatKOjxN0ehihg4eRtQZ0wOQk=
Received: from DS7PR03CA0328.namprd03.prod.outlook.com (2603:10b6:8:2b::30) by
 DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.19; Fri, 28 Jan 2022 17:19:27 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::5f) by DS7PR03CA0328.outlook.office365.com
 (2603:10b6:8:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:16 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 36/43] x86/compressed/64: Add identity mapping for Confidential Computing blob
Date:   Fri, 28 Jan 2022 11:17:57 -0600
Message-ID: <20220128171804.569796-37-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a566a7-4c14-4065-d0d5-08d9e2825660
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB46622E3473287AEBAE78DD68E5229@DM5PR12MB4662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqr5SgcvQ+PLhfbNPmHsJTyzhp2OB/jht55rMnym6+GW3GdYjwAyQ9XW7Gse8eF83K7Ycv2ub8dnC2wov72SOE7AcPr0PwQKduWPVlw2jPSy3x9YkU9QZuplxmLf1Xm+Gqk31Y4L3Npx3tOI9oyCpkV2XgIqNuy0tDThOhOB61hF8LWczmBVlx2NN8qRa5xhpGzZJS3LmjmcnbVvwTCWwBgeSAYYms0FQEQxUgR3OkKkNbajAD5PDhOte1ccs3G0563dapg59yL26fcnpuA6blkxKGQZezXk1ufVoobtkQ1XesaHQ8PCfXx3+7nfMAUcvN6IloU7Mq0Ko+RxFOE122xYs5kEDEgZ9WRIvGwsEph0+T6erdCox5N6fxBI9l0MHHpX9YQAxq4yOUQL8ugARqN2L2ubYQDPnp37ruPEEBnfKA6xNWX9rNae0ENZ01Y6wn+Q4oeRLebTSQQ9xcxBUmxGOjA5ErKxWhSHHgCtRJ469MQjhf/+U4cQPY5s73pzSrAI5yuBDCaxiX9j9aQ2lf/wzsN5Ob2+6X4K1ZKg70vCXLVrUbePh0LqwcoIfAXHhK/QEsbNVHeWkWChFNZDirwxTYMTypQJeG74G74MyL24Mmau+ExwfEknXa0VTSOXCEEaykBUXjYjyAOZJKSqzzNIn07MJfDLWjNyc0QvDC50qw7LPMC4chwQh4OZ3I36P3sGXgM2OqDAOQ8OzVrE9byLL2muR10o9Yaey+VfsBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(36860700001)(7696005)(2906002)(6666004)(16526019)(2616005)(426003)(336012)(186003)(26005)(1076003)(40460700003)(86362001)(508600001)(83380400001)(81166007)(44832011)(70586007)(47076005)(54906003)(8676002)(7416002)(7406005)(70206006)(36756003)(8936002)(5660300002)(82310400004)(316002)(110136005)(4326008)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:27.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a566a7-4c14-4065-d0d5-08d9e2825660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At
that stage of boot it will be relying on the identity-mapped page table
set up by boot/compressed kernel, so make sure the blob and the CPUID
table it points to are mapped in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c |  3 ++-
 arch/x86/boot/compressed/misc.h         |  2 ++
 arch/x86/boot/compressed/sev.c          | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 7975680f521f..e4b093a0862d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -163,8 +163,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps(top_level_pgt);
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index cfa0663bf931..72eda6c26c11 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -127,6 +127,7 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+void sev_prep_identity_maps(unsigned long top_level_pgt);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -136,6 +137,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline void sev_prep_identity_maps(unsigned long top_level_pgt) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index e1596bfc13e6..faf432684870 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -496,3 +496,25 @@ bool snp_init(struct boot_params *bp)
 	 */
 	return true;
 }
+
+void sev_prep_identity_maps(unsigned long top_level_pgt)
+{
+	/*
+	 * The ConfidentialComputing blob is used very early in uncompressed
+	 * kernel to find the in-memory cpuid table to handle cpuid
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		struct cc_blob_sev_info *cc_info;
+
+		kernel_add_identity_map(cc_info_pa,
+					cc_info_pa + sizeof(*cc_info));
+		cc_info = (struct cc_blob_sev_info *)cc_info_pa;
+		kernel_add_identity_map((unsigned long)cc_info->cpuid_phys,
+					(unsigned long)cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
+	sev_verify_cbit(top_level_pgt);
+}
-- 
2.25.1

