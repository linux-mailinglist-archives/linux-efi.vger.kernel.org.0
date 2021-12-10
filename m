Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEB4704BA
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbhLJPuJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:09 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:41056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243571AbhLJPsW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlD1qhUXzkopopPl++bKnSJoDWEx0RHjFG5dBawPWQ070ll8sI4wO8xGfGKGssv5p1yOSNIq2eb7wTcD9dHVY99gImPY7HDEgJSstn/F1jWlOahLyRRXxV2TtxBq55CrJHOSdI9QlHrQDbWF9R5zldxKLqnReJnRQXiR4CP85prb082xC5O2o5r0kAHf1lLsVtaPeF3CgeAZnqu6C6G2NDS7ljxXqkPRB1ZmHo7C9/w9CmKRSV/m8vJzvvfuGoscEOZOPWuO3PKw2fVRlMdsNWfNEV0nVM/XBpbfkIdOqAVotlC6Rds6N/5hF6G+5EtZ2h4hNsTLQNH5royXvnDhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCMtUj7gAK3a2O6JUjlQ+fa4iaAGMlIgIZ7wm1T/dWU=;
 b=JAxFO55/3JRpzg71wfVg75/ESlaJZxWsr57kIPUOIgGyYNsVgWD+PumdlSj5to7668Qbbap2zu/yaKbXtNgTA4BxomospnyOledY5SduozG4TfLdYJStGJFvl5suWTd4U3rgJmEOesk1OIStegv8hmDW3OBUb3oZfJgOaTcdbACmKE377Xpl2ge2YMYchiW9ilbMNSxIKg38EsBYn0WR4R5xrmmGaVJepmvW9+HxA1+EBdoUjQ7pHNgKyLMiOP1byC+2J+t85HUymzcgf1E045sS01PwkHNw4uqg+KwZbLYUC0UcCt65qaeCdLo6jHOn2nJV+t2tGwhS0bpB0En8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCMtUj7gAK3a2O6JUjlQ+fa4iaAGMlIgIZ7wm1T/dWU=;
 b=OYtQhnWxtY1elQsWm28g65LPO1x88RjhpFcGRPnbuqQaachf+dM53yqs9quvBs8N3UGfYoac7ofIa7fyuyroxBrrUkKcHixuEEVE7U+6mjjRoR0wyIqdt9MXBMEgTqO+3wbPX37Ecq21nn8xk8oweNZHLqXkZZW4Xf22VS4EWSc=
Received: from BN6PR14CA0022.namprd14.prod.outlook.com (2603:10b6:404:79::32)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:44:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::f2) by BN6PR14CA0022.outlook.office365.com
 (2603:10b6:404:79::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:41 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:38 -0600
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
Subject: [PATCH v8 32/40] x86/compressed: use firmware-validated CPUID for SEV-SNP guests
Date:   Fri, 10 Dec 2021 09:43:24 -0600
Message-ID: <20211210154332.11526-33-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63aaba1-02f7-4783-78b2-08d9bbf3fb72
X-MS-TrafficTypeDiagnostic: MW3PR12MB4476:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB447658A78AFC652E5DB31B57E5719@MW3PR12MB4476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slKf12fDhd3BxfL2WL9T7lNlQ/oCo4Br7CVw5DcS3TDyXq+6G1e7y7pLwFA8WvIL5vm4/ru+zKPD9hdu2BO6ge1geojjzrD09g2gFzMsVbRDwmdW7HM3RfjHvRqTC7MQCfQp0+mWM9UwLP2qCoGBE4jeFUyRkp6K79I/o/mkd/MunfRtKdLczA1uJ9VLR94jt2pH7zJ8PoP0LMzjGV3D5+XH8xdFyIkSYqyplXgjN8rQIvW6FX9mosonC+iN59AhuPCB8EX3HfiSRycmKKxb5rMphXsuOjJejd6u9+512QpW3E9k/uuhxI7fTxhbcTy5YFWqbiaVungWjXcKMUeaiwZIVahQP2YFDlNROedTy44R8ssJF1sSKvqeuq7c8EKarhIIBZMAVkE1tU51jg9pZWx8G/wRsY9kz1gEA/omBp+qmhOrgurdnNfDF8OsmfG+1CFyETXHCGGsURPa2WEU7QSWbnvtQefk2BkA/fiavkPtMLKlroJ3xsyVJn570xDZVng1j9E4tuCzdggmLzzgOi3RUi3jkOnx3f3bBsGac9ZR5X3JZJ2s9S7BGC+HFtB3tzNN2PsTHlr0yaK3HSAg1aNVClyqG3hCTl41ty+x7wPkFLUs5NLIFy0AvhtFsgc/OmIqcY3wPssQ9M4jtRnoyuxiRqV/Bcdahk0k8wxYRCq4g8XYJUZerXZIVhG8VD4WQugje6sX9PWM5yZqTaLCzMsUYkFk8pVKMVyXFjoKtgIY/MrR+QxiURBOPNEh0dVGsmYHGvtJi7t1ZxZYK1YStNn+V5AmqZB/wXI1prx17Hylxe6gXxPzkocBBm3TKqnz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(47076005)(40460700001)(16526019)(15650500001)(7696005)(8676002)(83380400001)(1076003)(186003)(110136005)(81166007)(356005)(54906003)(36860700001)(8936002)(7406005)(7416002)(336012)(86362001)(426003)(70206006)(44832011)(6666004)(4326008)(2616005)(82310400004)(508600001)(5660300002)(2906002)(26005)(70586007)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:41.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63aaba1-02f7-4783-78b2-08d9bbf3fb72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
 arch/x86/boot/compressed/sev.c | 13 ++++++++++
 arch/x86/include/asm/sev.h     |  1 +
 arch/x86/kernel/sev-shared.c   | 43 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 93e125da12cf..29dfb34b5907 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -415,6 +415,19 @@ bool snp_init(struct boot_params *bp)
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
index cd189c20bcc4..4fa7ca20d7c9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -157,6 +157,7 @@ bool snp_init(struct boot_params *bp);
  * sev-shared.c via #include and these declarations can be dropped.
  */
 struct cc_blob_sev_info *snp_find_cc_blob_setup_data(struct boot_params *bp);
+void snp_cpuid_info_create(const struct cc_blob_sev_info *cc_info);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index bd58a4ce29c8..5cb8f87df4b3 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -403,6 +403,23 @@ snp_cpuid_find_validated_func(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
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
@@ -968,3 +985,29 @@ snp_find_cc_blob_setup_data(struct boot_params *bp)
 
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

