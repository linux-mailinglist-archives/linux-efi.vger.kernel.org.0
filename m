Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC6344CBF7
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhKJWMX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:23 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:51144
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233804AbhKJWLO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ6FgPxMkSQk8ErCMHVJcqSYsgfj5JzYEEkD2BUoOrce1B51N6/HBCfKP0enGH9+J8qa6gWZuwlGbTd3bKDMjLjLw0ZfgGwgyMmsli1x1iAvlN7YHzyIIHhgSyRVVNM3Ym+Zq3o4TuzfkPbExf/o28cK7hGVipoc/lA5i8EKQ7VVbv1yHkbEPEzzoXDY/NMERFoV9gSrpWZ9PoyBACrHBgouQmfRgDPqo0ghqMk0qJgfGMJ3uUSaVyWuJTRPaktDbxVmIV6xyV8uqqExJS1MdW5zdcX25QJtser5cNdgfzxImK0JmqAi76FPrp8BsQtHo0/VIO8Cpb7AS+gV7wm6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyk08+0ehRaL57bz7C9Tkb/TwiR7gObGOsVLY/9Y9Dc=;
 b=g7rRb/24Jta8GI4pBze41sSnZKnzJsN2O4cY/TYeN239i0w5O3nTtQ7Yb9x36gqj7xKUys2vrb/thQJegDmI4qKuo2N+VHZyUq+6qAcuzeHMAW4jbalyPymmKelMGp3wi/0nCfhzkT4c/w4UHZqTU1Uy4BjacgDOZLnWS5u12jmFdoD+c1V0FjLVCXDA3WX4mZeos7NEAm50hSC9ptr47te/cvDZF7DjHLBIGYQ8fkGbwcxmt+TOaVlFG8k+rt+L789z5VzDV+pBXyxD6bIoAeq2vEL+b8Wky2JB/GZu2JnovXuOy9/5w6Uc3OPoLtXpmsnmBaenEeeg8WQ/FCPJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyk08+0ehRaL57bz7C9Tkb/TwiR7gObGOsVLY/9Y9Dc=;
 b=eTZz47DFBnifu+OsR3FBZSYMQqrrIbvpKG1nXyXuEn5PcKKp/fNdGsaW2ZFPrJ+KK4YkGeiYZ/BaCf91UCz6szxv7F+SX9myUd7i0bgYUQRnSST86ToZDibdvksxibStoi6isltUdFWeDUL/dXg+H2/QL7Ord/R/wuQfN1D2evc=
Received: from DM6PR07CA0112.namprd07.prod.outlook.com (2603:10b6:5:330::27)
 by CY4PR1201MB2500.namprd12.prod.outlook.com (2603:10b6:903:d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:20 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::70) by DM6PR07CA0112.outlook.office365.com
 (2603:10b6:5:330::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:12 -0600
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
Subject: [PATCH v7 13/45] x86/sev: Check the vmpl level
Date:   Wed, 10 Nov 2021 16:06:59 -0600
Message-ID: <20211110220731.2396491-14-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bad18c0e-4334-4c51-2eac-08d9a4969b50
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2500:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25006A5619CEDD0CC9E80A3AE5939@CY4PR1201MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1t8l7e6uP+8r3IyEMjyY6jE1FlorZHOROytdDg9qOcT2vuf+5ihkWu5HZB5alQLIlAzoKeJIuUEb5aRj2DCRKlwP5pxtiG9WFktwjwhOPZa77D29UevD35lvbTmfzBJARSjbutXYIKl0QKUIoAtmz+etb3ktdMeWbEjXP+59FasHw1siFA/IKapsaCRs3qFjT6dLBIgHZi17YNmAuxvPz7pFzOwpXMKQczypHbmsnVEcql7WYBhVyobtDGRpCqNz41Glaju58fE63rGnS2TnpD/kDieCVpKx1IJv/EY0EW0laqSsY1yvkd6LldoIeL1w7vhue08WjUQ9xj1RoMstwkQGKQPyL08H3aQBnWX/U3Cs4KVSMDmWshmRRX3+KaV44Pi0TKmBQ9x5bsjn5ymeG9EJrCtt5XWQLDuXvgzXrHlkmqPHAetsPlsCFmK/JpGrmUN8Fsm7fl9nYra2sPEDNirgRep9Kt+BeZty4SdYMoK0nvw4uZAHNj9pVFmbgK/CLytFdEIA9MNkZXZcIjQJuCCTdiEgk3FMdJSaPDiSHE2Y+kgwxJdR+FHNnexAIPfgVLtcv/J+0U9/7XCDvGi6BSkAlG4ryyruzUOAn23AaTnDGWWJPxyhLj9qytg9AcIlsg1u55xm07IdhVSr+9iFmtw90X/ozyvrA8VhifqD4jPMnxQ5dKytE2YtJqEHEp04DFV7svNYYAsywMMOZEyXtxrfAqPcDgWZxRTFiN555Xr4j4dvVIHfjHeJ/Tui++0e
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(86362001)(110136005)(82310400003)(36756003)(6666004)(316002)(336012)(16526019)(8936002)(70586007)(2906002)(70206006)(4326008)(1076003)(5660300002)(8676002)(186003)(2616005)(81166007)(26005)(7696005)(44832011)(7406005)(36860700001)(47076005)(356005)(426003)(7416002)(83380400001)(508600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:20.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad18c0e-4334-4c51-2eac-08d9a4969b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2500
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Virtual Machine Privilege Level (VMPL) is an optional feature in the
SEV-SNP architecture, which allows a guest VM to divide its address space
into four levels. The level can be used to provide the hardware isolated
abstraction layers with a VM. The VMPL0 is the highest privilege, and
VMPL3 is the least privilege. Certain operations must be done by the VMPL0
software, such as:

* Validate or invalidate memory range (PVALIDATE instruction)
* Allocate VMSA page (RMPADJUST instruction when VMSA=1)

The initial SEV-SNP support assumes that the guest kernel is running on
VMPL0. Let's add a check to make sure that kernel is running at VMPL0
before continuing the boot. There is no easy method to query the current
VMPL level, so use the RMPADJUST instruction to determine whether its
booted at the VMPL0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 +++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index e525fa74a551..21feb7f4f76f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -124,6 +124,29 @@ static inline bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+static bool is_vmpl0(void)
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
+	 * The boot_ghcb_page is page aligned memory, so lets use for the test.
+	 */
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		return false;
+
+	return true;
+}
+
 static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
@@ -132,10 +155,15 @@ static bool do_early_sev_setup(void)
 	/*
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features. If SEV-SNP is enabled, then check if the hypervisor supports
-	 * the SEV-SNP features.
+	 * the SEV-SNP features and is launched at VMPL-0 level.
 	 */
-	if (sev_snp_enabled() && !(sev_hv_features & GHCB_HV_FT_SNP))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	if (sev_snp_enabled()) {
+		if (!(sev_hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		if (!is_vmpl0())
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+	}
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index f80a3cde2086..d426c30ae7b4 100644
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

