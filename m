Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E949FEF6
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbiA1RSx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:53 -0500
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com ([40.107.102.44]:17465
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350572AbiA1RSl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/oJ3Lugnpz81YQNt2hsxFWUQGX6daaJYmnPSKTKFvpWUHT0GSjEs4Ytf0PlyLk7CAn2s7vIy4v45kQv5W8DPiPU7/EdShNBj7UNLFZkE66IVuqaxL2PK1qT0QWs4evopG8kVn5Tf7i+zgjLH+V4SOvSHUEHmfJ0Z4S56NpSkOwRzWjbS2PqgEcWyFZJDXDys0EOGrrzXe0fTUEI1JVz0Y34q8ity0uVvV6tBpHplyko5UGtv0EkumaoTmO5gBnCD/fqXy4tmdfdWq4++EVXr0KU72b0nJSqlkXsKplN2ZOzusJX6Em3QsHVmMJar2Ry8VzNokBrT6D12YFOUHt9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ug7ScgmGtziEmqK0ra9hGJlh/T8ac1AxsKzOVuCG9g=;
 b=kkz+KwafBvPJLhPK741F1sBJRFjY1GvA4TJ7N9KEEpZEPT6y6tHhGnTw/8WS1Z6J6wonqP9WVvXh2u7jebVWXLEPYoyJzIVAx4hONuAiWKCo53UqWzR0XuWGU5QGajcV+WLMKhPhwnlRH2BKHEkDf4keKalX3841f9twv/cpL3R1E/URlLYIxGR7QqWEkj/qOMpuowXnOX/gL2WfFqFytRoMOMq1rOKcpFLShKzUaTcCOGKdw7AfPQp+2qP6kcSKE3bQBQIXMe5hnpMjEHPhy3AV+KOVRbzoOHrkmW40po1odpo/T7YXJplVnGrfwK978dxgcjxEquXniatu5okVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ug7ScgmGtziEmqK0ra9hGJlh/T8ac1AxsKzOVuCG9g=;
 b=swlPDjnTawKPuAmXObp7+Q0SVyfpHOm8dZlQrY3wHUsvJ5hyvESibS63gcTpFnf3bWXaV24VxzvalRV7/sdwwiUZOgIONe9UDTEzZbfYueMXREzCs2xpXXTT5+TN2QukC8Y9wmfbfT6bpmkt2EUZsmlZP6cWyT01lh9CP8OO8o4=
Received: from DM5PR21CA0019.namprd21.prod.outlook.com (2603:10b6:3:ac::29) by
 DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.19; Fri, 28 Jan 2022 17:18:39 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::44) by DM5PR21CA0019.outlook.office365.com
 (2603:10b6:3:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.7 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:39 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:36 -0600
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
Subject: [PATCH v9 12/43] x86/sev: Check the vmpl level
Date:   Fri, 28 Jan 2022 11:17:33 -0600
Message-ID: <20220128171804.569796-13-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5a35b08-fe53-4e00-24d1-08d9e28239be
X-MS-TrafficTypeDiagnostic: DM5PR12MB2551:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2551DB0B62B5D0702FFA436AE5229@DM5PR12MB2551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDRNSVwcOhdiCZsJxRjWh8g9oZfaMAuvsU0H/s/gjriW7lrvuGTn9Nf3J4id9GUSBQN9/9k7IhFtC8ViX0FJQ8uzvAcNJRXWbha3YL/8OH2nBRF7CiYsQ/zUnTxN4qFZ5sq2dx6uo5+PSKhZQF/LNGV9OuNt6RMmVnughF6vI/2K4NTzPK6lei62von43jNE+dYcPw2Tv/mZ+PMrtydxAN6j3da0WzsufNHqbbPjLZGg3A70BO9rpthdOEX9+ORMgc6L0UARPmqp/ry0DEWfj0XLLWIYR0Y1xAyXi2HlCObBadPYLzFqsVvFrKzZ0gDTNllHiawH8pOHViI3XrDfo9I3VWPEec5iLN3gUyxeu7VqEYaZy/cQkQ9onHDQVfvalT+ZZ2EgfwH6KL+fhhObalWQNuYcjJpJBMfM3HHV1yoij2trTOmAwuqJ4UvZwMPT+IEOqZPJDsm3H9lqZk6abqhU/TIrc99QnTppEIXwSZINBkOWNM1DxwnZnKTaHcBkqcoDLZHs5RsR2RqjyLBje6/vaMJFPueUI4kqnK9bjt6d6iPfBuEZUT0nQ6sTYpXQX46zQDG2xwBFE4y9m0LV62P9wkGZqpJCwzwsjbKzBt3MlUMvF9izwYPoYYdteODkrpbKOVkNQz/aEk4rexkhAXgSSoPBNUwL6LOPBZ+1cKGvfZSdeUMtciX42fTwXq/7Y/mQRHCzYtxVWN97VYVeIyp8+DVwJRaJquvPhQXE94E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(7416002)(7406005)(8936002)(44832011)(70206006)(36756003)(47076005)(70586007)(54906003)(316002)(110136005)(4326008)(5660300002)(82310400004)(6666004)(16526019)(356005)(36860700001)(7696005)(2906002)(83380400001)(81166007)(508600001)(86362001)(40460700003)(426003)(2616005)(26005)(186003)(1076003)(336012)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:39.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a35b08-fe53-4e00-24d1-08d9e28239be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2551
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP architecture
allows a guest VM to divide its address space into four levels. The level
can be used to provide the hardware isolated abstraction layers with a VM.
The VMPL0 is the highest privilege, and VMPL3 is the least privilege.
Certain operations must be done by the VMPL0 software, such as:

* Validate or invalidate memory range (PVALIDATE instruction)
* Allocate VMSA page (RMPADJUST instruction when VMSA=1)

The initial SEV-SNP support requires that the guest kernel is running on
VMPL0. Add a check to make sure that kernel is running at VMPL0 before
continuing the boot. There is no easy method to query the current VMPL
level, so use the RMPADJUST instruction to determine whether the guest is
running at the VMPL0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 30 +++++++++++++++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 ++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 745b418866ea..adfec1d43a77 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -212,6 +212,26 @@ static inline u64 rd_sev_status_msr(void)
 	return ((high << 32) | low);
 }
 
+static void enforce_vmpl0(void)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+	 * GHCB page. If the guest is not running at VMPL0, this will fail.
+	 *
+	 * If the guest is running at VMPL0, it will succeed. Even if that operation
+	 * modifies permission bits, it is still ok to do currently because Linux
+	 * SEV-SNP guests are supported only on VMPL0 so VMPL1 or higher permission
+	 * masks changing is a don't-care.
+	 */
+	attrs = 1;
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -252,10 +272,14 @@ void sev_enable(struct boot_params *bp)
 	/*
 	 * SEV-SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
-	 * the SEV-SNP features.
+	 * the SEV-SNP features and is launched at VMPL0 level.
 	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		enforce_vmpl0();
+	}
 
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6f037c29a46e..f2b6da96f79b 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -89,6 +89,7 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SEV-SNP guest is not running at VMPL-0 */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4ee98976aed8..e37451849165 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -63,6 +63,9 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -90,6 +93,18 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
+{
+	int rc;
+
+	/* "rmpadjust" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF3,0x0F,0x01,0xFE\n\t"
+		     : "=a"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(attrs)
+		     : "memory", "cc");
+
+	return rc;
+}
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 {
 	bool no_rmpupdate;
@@ -114,6 +129,7 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
+static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 #endif
 
 #endif
-- 
2.25.1

