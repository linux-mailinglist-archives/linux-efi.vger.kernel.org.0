Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056B544CC23
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhKJWNd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:33 -0500
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:26624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233694AbhKJWLu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9e5b9JBgvWmDh7Cc945xZ8MCcCtQOg5duu4cJd1VPTqMIhhk9HwB5lBhipGLFoHhvA9hT+g26g85Edu4WMJVlTahhrklphI+HVnYr/hdyudBigvLH+1KeRb0Jrr6uUWNk6UOdw5nVqfd6+m4qCYN3lL/ZykuuY6YWab4pjnuANznE1JLM7NXLXcCVlFWSHuGCMGqsGRXMOoY61K1qTERfkTPXSISNCFn+bKx92Y91Khe56eDN5LNYqJeQ3WCQf/lNlI4uXsC2uVcSYX8uON+MiwlGWd+z3dWwSTUik3OofapkYxnJHVVTQm4J/TNeQULHm3iWVjejks+s7A78waIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtfoCMqHR8Dc7HESNfwwMHrC9Iz5WSzTtZmzrjB0Zfs=;
 b=YULzKn/xf1sQIzqIsg/rULI/4lQnYlHiAL5BPHqRDT0voG1+yt+9ACl5oZToa+vKaRMBsEeCfP7xDUrrlVC8zDY90FSPy2cdamQjriUGkdNMysMPDkf2ON9Qopb4CCmPHbhxZ/5vdkL4ASA9fCmdIpumtN9TRIBxYMq27tvUu/6IZgdcrXYUTbrb1XMT31SjpfWjjz4/LoOaPVMNztdPzISOlVEz0zFOzJ+qV0Uqz+3dhueBbClfwHDzJZgDpeX/JXmi8/kJyoI/OLaysKdG3blZElX6Dl5RZ+VKBcAltZDa3oBBohE+MjxablD9cFY47LKksmtOzd9tIRYKmTdfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtfoCMqHR8Dc7HESNfwwMHrC9Iz5WSzTtZmzrjB0Zfs=;
 b=KtDXBjc/tM6Dfn7xStFE7IyxcULjTnOxis6gj1tdsOET0eK3KVmqEw0isrAR7VhkIKgMfB9uEugEE2QAuo7XwiSL7u+51Efhq4bsW2iA2fZVu7Vtbxxz8BAGgNR2uVK9M/wLWn1ZAiwRmF55sp+D6j2CiQkJMZI7cPKyfjtGsS0=
Received: from DM5PR21CA0001.namprd21.prod.outlook.com (2603:10b6:3:ac::11) by
 DM6PR12MB3676.namprd12.prod.outlook.com (2603:10b6:5:1c7::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Wed, 10 Nov 2021 22:08:58 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::58) by DM5PR21CA0001.outlook.office365.com
 (2603:10b6:3:ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:52 -0600
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
Subject: [PATCH v7 37/45] x86/compressed: use firmware-validated CPUID for SEV-SNP guests
Date:   Wed, 10 Nov 2021 16:07:23 -0600
Message-ID: <20211110220731.2396491-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53b9df63-ae6b-4982-9d79-08d9a496b1f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3676:
X-Microsoft-Antispam-PRVS: <DM6PR12MB367664FF9DDF862907780DEFE5939@DM6PR12MB3676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t2KsirGGHwsQKgFe0c31+QMla2tEVgiDqMWhBzXBhtCh/soehQVMPHe18DkOs2oGXWVvLRb/9Ris3Lqzw8xBd4lPHc6w8//qkISAOuVUv24tslnZ0wWgHICQoAORzm2mHLYbSIN/GZsF/zMilgJUMFRmxuZjoNVC0v7qqiktJFRIApFLRfPfDBtJTbdYMz+XWQSygzEpW36zFzo+QVhHITCG+PADhCbSJ8LYaVUvlOmN5VrooteXeITTX/vVhqR0kHuFkf4M7N2mkSwqMNoue7ppBLvLnNZjOm96L5ZHFjvxLTDxluMEYBmxuu78oOyd3FPM5fJuzCH7mZA6LMPCczI7Zgl5Xk7gK6v6nwMJYbPP8qZfvsjITv8E+6/fyH+x1CjCKN9DkoCZtzRmdRutNv9FMJsw0LGOHeJujrzf00ApGDtVaxYrSVYy/9K3AJRyquXIP95H8IbgqHPXqwelhnNEeoB5JKhkrhm/6G7r5iviaeQjgqcKkeCChsFwb2dqkqeUvHCZbtWPI5lk76ZP3RlbgrUrO6PSq32f7ClQdqLAtcPk7JB0j8tzApL9YvaAYwC8SEsgHA68qmFEdmIskG4BDoap1/s0/09VT1sqyPe5jDtPI/lvXXmrkjnptD1ruJi9C9sWW8ViOZX9CnC0w0NaQaiOMXE6O+vwoP7gxmPKB6QtbJ2NOwmHAyyGLP9ZqlyAXcb5CipVoURZMF6Xlj8BVXH/hQvbQu7mwo5rtFYogtZB7hply0vu/ry7nZk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(8676002)(15650500001)(4326008)(8936002)(86362001)(7406005)(83380400001)(7696005)(36860700001)(2616005)(70586007)(1076003)(70206006)(82310400003)(316002)(36756003)(7416002)(47076005)(44832011)(2906002)(54906003)(81166007)(6666004)(186003)(336012)(5660300002)(356005)(16526019)(508600001)(26005)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:58.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b9df63-ae6b-4982-9d79-08d9a496b1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3676
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets'
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the boot kernel either through an EFI config table entry,
or via a setup_data structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
boot kernel will use when servicing cpuid instructions via a #VC
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 13 +++++++++
 arch/x86/include/asm/sev.h     |  1 +
 arch/x86/kernel/sev-shared.c   | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index a41e7d29f328..d109ec982961 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -411,6 +411,19 @@ bool snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	/*
+	 * If SEV-SNP-specific Confidential Computing blob is present, then
+	 * firmware/bootloader have indicated SEV-SNP support. Verifying this
+	 * involves CPUID checks which will be more reliable if the SEV-SNP
+	 * CPUID table is used. See comments for snp_cpuid_info_create() for
+	 * more details.
+	 */
+	snp_cpuid_info_create(cc_info);
+
+	/* SEV-SNP CPUID table should be set up now. */
+	if (!snp_cpuid_active())
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index cd189c20bcc4..b6a97863b71f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -157,6 +157,7 @@ bool snp_init(struct boot_params *bp);
  * sev-shared.c via #include and these declarations can be dropped.
  */
 struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
+void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 05cb88fa1437..4189d2808ff4 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -65,6 +65,11 @@ static u64 sev_hv_features __ro_after_init;
 static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
 static bool snp_cpuid_initialized __ro_after_init;
 
+/* Copy of the SNP firmware's CPUID page. */
+static struct snp_cpuid_info cpuid_info_copy __ro_after_init;
+
+static bool snp_cpuid_initialized __ro_after_init;
+
 /*
  * These will be initialized based on CPUID table so that non-present
  * all-zero leaves (for sparse tables) can be differentiated from
@@ -413,6 +418,23 @@ snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
 	return false;
 }
 
+static void __init snp_cpuid_set_ranges(void)
+{
+	const struct snp_cpuid_info *cpuid_info = snp_cpuid_info_get_ptr();
+	int i;
+
+	for (i = 0; i < cpuid_info->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_info->fn[i];
+
+		if (fn->eax_in == 0x0)
+			cpuid_std_range_max = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			cpuid_hyp_range_max = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			cpuid_ext_range_max = fn->eax;
+	}
+}
+
 static bool snp_cpuid_check_range(u32 func)
 {
 	if (func <= cpuid_std_range_max ||
@@ -978,3 +1000,29 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
 
 	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
 }
+
+/*
+ * Initialize the kernel's copy of the SEV-SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SEV-SNP CPUID table used by firmware
+ * would be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+void __init snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_info *cpuid_info_fw, *cpuid_info;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info_fw = (const struct snp_cpuid_info *)cc_info->cpuid_phys;
+	if (!cpuid_info_fw->count || cpuid_info_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(1, GHCB_TERM_CPUID);
+
+	cpuid_info = snp_cpuid_info_get_ptr();
+	memcpy((void *)cpuid_info, cpuid_info_fw, sizeof(*cpuid_info));
+	snp_cpuid_initialized = true;
+	snp_cpuid_set_ranges();
+}
-- 
2.25.1

