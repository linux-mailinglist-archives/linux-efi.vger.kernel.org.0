Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32AC4704D2
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhLJPul (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:41 -0500
Received: from mail-sn1anam02on2081.outbound.protection.outlook.com ([40.107.96.81]:20186
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243138AbhLJPrk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzix1tfAxTDsabbqIoHz0PK6VCnS4b2JBi1J/6sATL9SHXSJ/BHUpiB+P2FSx6hrFw0ZyvrNJWcp50K1FzYN5kyWFdq1CakUviwv2mc4xqlodPUOzorkNR8Ag6Dv2HqIyQSkvadfWzGDabhqZv7WTVoUkzn3rzOteQ4Z92ij5nt9IKd3k7bHMTsxaYnWgOynPOdW5FfGDqn7+S1fMBz1NBkJmqEKHeYGCMRsuNVvBJW3ORCZZzOiEr6bccBpUPBaRSWD+D+DmW1uLLNXP1t/4XT+6GracZ5vIEtSfkP2Jet+LQyw3k6I7N/0xYU12CrjAYtUTohMxvLHP/g5ZB6Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56Tw3SjleaH3DWBreTAjkg8V/BlMybEBB0IM0kENb6k=;
 b=oOlY4wz8ia1WMwB7ZADXyzWBppwJGo+fB638vcP6SXbPgiv1dqOUWaqIZgV77eVsPFMEQOmPRdPpixZo+gphmvOvb05q4uInUKlavQwCk0nsz3lY7ZXlE3C+8ZYPvREHUtt7HnA2NSt2+Qubk+9UcF7kg9aHLDk+UB4SSwBd/EG/FoSVauXr+RzcB9HdoEzQlW5HOOyL0r7jmRvpO+QQhcoZ6YFpHtaZ/zB/yTlhisTGHCCYg6mV9Yl2wEl60n7FmAPqo2FqbWvRwDn3i5KkbfsAdoydz24FSABtF0l/4cgiiNuJY+SJaSW0noVgYFbP4GJAHAXV4ebA98g4I1wBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Tw3SjleaH3DWBreTAjkg8V/BlMybEBB0IM0kENb6k=;
 b=C7vpoXL/TrSX0cZqrhupjEg2C1c/OJdVlyps9UN+PGWxj/XgNys11yZNFLVzY4qPEHYwmv6TayZo3PGAkkZiDXCr5NuADfBRNscH6xGlbwj+FJ9Dg0ly9WaJU/C6T6YOOxNOhISdiimHTkRw3AflJsbHyV54jmqWI18LvbocECY=
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:44:02 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::49) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:02 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:59 -0600
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
Subject: [PATCH v8 08/40] x86/sev: Check the vmpl level
Date:   Fri, 10 Dec 2021 09:43:00 -0600
Message-ID: <20211210154332.11526-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69d1bff6-1042-4156-9dff-08d9bbf3e3e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB435635538F3AF4A9DE118FB9E5719@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUKc1XnLEjF2wU7iwN+9+PojWUxPxCvHOI1+l8qYnWIS3rFPZvWeQ3BAJq0cSl7twCRRvY9ivZsISgDKAg0MbWwDWZdwlKVA091G5ENuMMvaEOs7f/j0JZCiL0maiaNIaXJBbNfHCqvxeefTBXCdiXaq4sc8m9G5EHeXsgulriDc39e1IWn9Ps5sgc3ZlccHmuncuoQsK3zH2Wmju0ecYR8mc9XbsMtApPH3uvCmwHjhpA2vYhSXCiRNm+YkE8IppCCgODqW4k2Q1am8UGhS+BLBxYDe+deVQBHqYoS5k+CJfzhkujbqZ1gdh7w6TTbt0vZBZM5R9L7JqgnMPQjlkLiuM5OSROrrno4gOipovS5HYqJlJ00cB4k8ahcuo5+ZDkW+eAmZwAKmHDlKbvroijp1Saa34qpxBmByuQ4UUFQhiEEpY66Xz/yxaSjEmmSCazPWx8Ukjh4f8oCpOGM8feP3ZGCQ8C4dHcGzGWuMw/dBfMXOitIZGndRUefriQQmFf7tzhkPX98o7Qw0Kf3j/3qTmDnuHUYdKZhEZiBDQQCgTmXgJb7oZyZ2V1+wY2F0KGRIflahpS5ORmq0il+clwMzB8nKbGpV9gQERpN+lQDet8UUeJu8Gjy+qHyTNwaGdpwNlOznAkRCL51J7X4+CS7kUQQ/RknhdWabwuuxGuJ/qcWRoZ8TlCtvKYy+LBi+CeRdbelrGwSK6oq+29Cxhkzf4FzZqEaM2YVsk/vgE3WNWv2UsGQ67ea/0dGqMudH4g8Z1WrsEylOYYpRQ0M0tAMKaMEuCLIxQOXjfGojFBSYCMAoCKmT//pHzEnF2FeR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(16526019)(8936002)(508600001)(26005)(83380400001)(8676002)(36756003)(316002)(54906003)(81166007)(426003)(110136005)(336012)(6666004)(1076003)(2616005)(44832011)(356005)(5660300002)(2906002)(82310400004)(7696005)(40460700001)(86362001)(7416002)(7406005)(70206006)(4326008)(36860700001)(47076005)(70586007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:02.3999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1bff6-1042-4156-9dff-08d9bbf3e3e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
 arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 +++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index a0708f359a46..9be369f72299 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -212,6 +212,31 @@ static inline u64 rd_sev_status_msr(void)
 	return ((high << 32) | low);
 }
 
+static void enforce_vmpl0(void)
+{
+	u64 attrs;
+	int err;
+
+	/*
+	 * There is no straightforward way to query the current VMPL level. The
+	 * simplest method is to use the RMPADJUST instruction to change a page
+	 * permission to a VMPL level-1, and if the guest kernel is launched at
+	 * a level <= 1, then RMPADJUST instruction will return an error.
+	 */
+	attrs = 1;
+
+	/*
+	 * Any page-aligned virtual address is sufficient to test the VMPL level.
+	 * The boot_ghcb_page is page aligned memory, so use for the test.
+	 *
+	 * The RMPADJUST operation below clears the permission for the boot_ghcb_page
+	 * on VMPL1. If the guest is booted at the VMPL0, then there is no need to
+	 * restore the permissions because VMPL1 permission will be all zero.
+	 */
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -252,11 +277,14 @@ void sev_enable(struct boot_params *bp)
 	/*
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
-	 * the SEV-SNP features.
+	 * the SEV-SNP features and is launched at VMPL0 level.
 	 */
-	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED && !(get_hv_features() & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
+		enforce_vmpl0();
+	}
 
 	sme_me_mask = BIT_ULL(ebx & 0x3f);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 6f037c29a46e..7ac5842e32b6 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -89,6 +89,7 @@
 #define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
 #define GHCB_TERM_PSC			1	/* Page State Change failure */
 #define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+#define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 
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

