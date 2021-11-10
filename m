Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A835644CC39
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhKJWN4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:56 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:34496
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234067AbhKJWLy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2RIOpwBs3ZB21kz33V8slLJQ3Pjdlmo5SL1pVgnU5Ni3DlW4ItQCNEGrmviMuOvDdGGtF5zxrjV5bAq9XFS7ebHzLkXqQBBSJR0wUABFW+tv005ENQW+/iBFVEBRoPi81gPnsWr7Gw1ttMo3QFgwZQyr0vOwhSTM513EjRJmJNEEXaehADS3tWQVl413FKN3GpSYKKelLQUGEyXUstOAcHOsFDeo8kU90nCxZV/u027AQkGmAAozTuoe9vEaqNoj5q9bHwqhSoS9VN+8XIJVIjXFFD8ORkZjknA00XnEOA2evBz/QV84Uq4UtSDD474leVn+0jVv7LU0WlYHUSYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9Bse2ejUzK0NZdyG199nN44MKridxZqZQcGVhRMZYs=;
 b=X6J9z637+MlfBgW5hRXHmPnhpSXEnuVJS7wSR/J53wPZrBSHjzMurF09aYbkex2AmQtT64KEX9Y95Memda/Sn3aKMeTQER9n/eVxenxkLToHOQ/aBTrf3NyebTG/3rJZKFttQQ8rJm9tJAGSL0PYCpNZ1QH0dDHYYzWsjBAlQQVVAolWnf283Pc+O3UCrzZGxYn+XN1gHYj5KwhDtg/M3+KPauZFrQU/VYz4IyQ5eZGYmDl9D77O3/FqRoWhn5wsIililsA8Tc27+ArVQf6TQW3M3XWxvvrUpHWstbKQBrjjjKvSw+pY5hhaAJ6QJTpsflfX1/C1fBNG4qP8IvTpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9Bse2ejUzK0NZdyG199nN44MKridxZqZQcGVhRMZYs=;
 b=0PtAQNxT+YyDhbl/k/3pWdx6kpa1xlUUe5Udpz2l0aLxbfLlhEukYfjscwag4F4UpbDO1dXdVP5XVU09eBFuU/n6oXJRT/djxF0/NfoRWmSkyYJQDFfl7isB5oIUO/BiBQun8Rsyef+Q+DzvvPLuO6XyDSzTBM+c8IWyhV4iyX8=
Received: from DM5PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:4:16::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Wed, 10 Nov
 2021 22:08:58 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::59) by DM5PR2001CA0004.outlook.office365.com
 (2603:10b6:4:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:51 -0600
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
Subject: [PATCH v7 36/45] x86/compressed: add SEV-SNP feature detection/setup
Date:   Wed, 10 Nov 2021 16:07:22 -0600
Message-ID: <20211110220731.2396491-37-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01f5cfde-b3dc-4880-5075-08d9a496b1b3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-Microsoft-Antispam-PRVS: <BY5PR12MB43060F7F6B9C8806F50D6DE0E5939@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfIlXglE9HRPA5O0US2U6BGjA6C8dVlkNX9Z8bKDWnc+rlImHqlS2iMYiXXhF7NCwaaf8Vk+WNS145f3hthi4qgWJ3mtyb53FU598XwuscfzJF02E6ekjLDBMBQdu/U8eYV433U0NJbPS2qLfwAF7Me63al+q/RtZVXzJC5o6u95xkU3tgbfhTGtGZqWlfuV5lEum1rOdhPWdVbVijJUaLf8O53CJmhHE6mwOWxGLdSIzO960m87lOPGbjFBjG+HPn5XrGqLWM5Br2a8KpiPOduj03nNFiQvL/9XzvQvba7Wl6DuWDoqV3DZsWdVd/f1zDhKOA9Are6nF8SNri+5xvbYvJlNrZXRmWOJBZ4IA84Q5NSZ/Cw3pBRb9AgmTgxETWMKcdqC7/i1B4BKvZg+Vc9Io1cRiMO1I7+BeZ6NoTQxn49uTMXMA73tQPNDNRE1e8+GAblIw/sSIJZhg66U62KsgZc3X0MQ9FMy+OKRu9JzlVT3YkNw2X8646mmWzR87MmPGJAZz4kdxhZQS6dHNWRX7SpJafpGgbhxphIdHzmKHP+GD/cthys89Y+c94Z7/BhKT03Y+ul63bXWUTLd5/cgY0Q3ej558NKsOG2tyCl5m26vNvqeNybEWm/jPFm7HHeBFCe27VSinYl95KO97OO7w/QyO6LTWOxkgdfP7oG6l8dt8gefEHPFQRqxiN/iLNzTFhvIVodrgOEFBh8HSjk72PfQ0ZKHWzmvM4YSjcNoV4ogbSRk2wkyujMBaP6t
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(26005)(1076003)(82310400003)(316002)(70586007)(2616005)(6666004)(508600001)(86362001)(426003)(8676002)(186003)(336012)(83380400001)(16526019)(44832011)(5660300002)(36860700001)(2906002)(7696005)(4326008)(36756003)(8936002)(81166007)(54906003)(47076005)(110136005)(7406005)(7416002)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:58.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f5cfde-b3dc-4880-5075-08d9a496b1b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Initial/preliminary detection of SEV-SNP is done via the Confidential
Computing blob. Check for it prior to the normal SEV/SME feature
initialization, and add some sanity checks to confirm it agrees with
SEV-SNP CPUID/MSR bits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 90 +++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h     | 13 +++++
 arch/x86/kernel/sev-shared.c   | 34 +++++++++++++
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 2d9db9dc149b..a41e7d29f328 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -305,6 +305,13 @@ static inline u64 rd_sev_status_msr(void)
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
+	bool snp;
+
+	/*
+	 * Setup/preliminary detection of SEV-SNP. This will be sanity-checked
+	 * against CPUID/MSR values later.
+	 */
+	snp = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
@@ -325,14 +332,95 @@ void sev_enable(struct boot_params *bp)
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
-	if (!(eax & BIT(1)))
+	if (!(eax & BIT(1))) {
+		if (snp)
+			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
+	}
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status   = rd_sev_status_msr();
 
 	if (!(sev_status & MSR_AMD64_SEV_ENABLED))
 		error("SEV support indicated by CPUID, but not SEV status MSR.");
+	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
 	sme_me_mask = 1UL << (ebx & 0x3f);
 }
+
+/* Search for Confidential Computing blob in the EFI config table. */
+static struct cc_blob_sev_info *snp_find_cc_blob_efi(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+	unsigned long conf_table_pa;
+	unsigned int conf_table_len;
+	bool efi_64;
+	int ret;
+
+	ret = efi_get_conf_table(bp, &conf_table_pa, &conf_table_len, &efi_64);
+	if (ret)
+		return NULL;
+
+	ret = efi_find_vendor_table(conf_table_pa, conf_table_len,
+				    EFI_CC_BLOB_GUID, efi_64,
+				    (unsigned long *)&cc_info);
+	if (ret)
+		return NULL;
+
+	return cc_info;
+}
+
+/*
+ * Initial set up of SEV-SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+struct cc_blob_sev_info *snp_find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	cc_info = snp_find_cc_blob_efi(bp);
+	if (cc_info)
+		goto found_cc_info;
+
+	cc_info = snp_find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(0, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+bool snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = snp_find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	/*
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	/*
+	 * Indicate SEV-SNP based on presence of SEV-SNP-specific CC blob.
+	 * Subsequent checks will verify SEV-SNP CPUID/MSR bits.
+	 */
+	return true;
+}
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f42fbe3c332f..cd189c20bcc4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <asm/insn.h>
 #include <asm/sev-common.h>
+#include <asm/bootparam.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	2ULL
@@ -145,6 +146,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
+bool snp_init(struct boot_params *bp);
+/*
+ * TODO: These are exported only temporarily while boot/compressed/sev.c is
+ * the only user. This is to avoid unused function warnings for kernel/sev.c
+ * during the build of kernel proper.
+ *
+ * Once the code is added to consume these in kernel proper these functions
+ * can be moved back to being statically-scoped to units that pull in
+ * sev-shared.c via #include and these declarations can be dropped.
+ */
+struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -162,6 +174,7 @@ static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz,
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
+static inline bool snp_init(struct boot_params *bp) { return false; }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b1ed5a1b1a90..05cb88fa1437 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -944,3 +944,37 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 
 	return ES_OK;
 }
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+static struct cc_setup_data *get_cc_setup_data(struct boot_params *bp)
+{
+	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB)
+			return (struct cc_setup_data *)hdr;
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+struct cc_blob_sev_info *
+snp_find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd;
+
+	sd = get_cc_setup_data(bp);
+	if (!sd)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+}
-- 
2.25.1

