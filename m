Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCF42700D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhJHSIB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:01 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:14564
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239759AbhJHSHg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LozA+u8/woOzzkqOUTOvoPNDaehV5+ZbPlqCf9bJaRtI17zyz6Yfmo0Eoa2xE9+KMbcB7n4Mrq0V5q3djUjVJDnILQVrEnObCH/IHs6QBisil7R91aDbBq5VSwHYM8sBaRjQOEdY+Ve9ymwDyhkpjbOmI5U6j4FaaylrmFm0Ehxtd+wK4xaXaUHgzcQRRSz0QcUU7Y6STR2Rx1zunYCvKDhrgTBHzCE9fqCDOIcglR+ziVJbVKJpuSjgfASsOtnhHDN1rk9tOzexz3kOKT+RlF3AwvtYTKPpNxfF6REOSVmCwlpnY9DFqn4ubsAy/pkVkUt/V5zxZj8BLV98B7c7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgNu5d1btcCWcIbjjRXmaQsW8YmfiPy72HUc/iPpmbk=;
 b=bbneWJ8DPUtLMPJ9gOkjdtB/rHDqwhrgIvoIOyKlMg9UDb+9BGwow3sPNGd22N6yYfqpCTcggksIGnrhREeCvnl7ZaPpmc3I+l7dHdytL1crKBrXV4RMp474cDUUsUMYLgSp4Ofvu2TWxidBOPg1/EMY4Sw5OkRYSslY4itDydhTGCDf7Z2d2SJ6iJ8kPOl2gv0zrYABgr4xgdImgrVcaEsaDJEpxwyuDE9575RT+J/QOFYeANiMekWpdz8KBdxsZViQu6jk0jZolRvJaNr24Oa9/r6yVM+idQ1tnzAuvTogb+JJH0SxOuxVBPPwcufI2jRJ/hZqQ+yxLM+5hK/WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgNu5d1btcCWcIbjjRXmaQsW8YmfiPy72HUc/iPpmbk=;
 b=hrNaEuY+ub2/khpsV+krqQOEPXO2uC2E+/jntA+Q6+ShQBNnQOXPZ9jss+gphOYGdO9oGh3IbGQrcjFVcy64kwQcbWgyvw2qnTlyNgpn41a8BuWK432e7TheR4zNsd1tK0Ysms1GetI5uXctZoFA9bhMct/pP4/1qwR0moruBzE=
Received: from MWHPR01CA0029.prod.exchangelabs.com (2603:10b6:300:101::15) by
 DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Fri, 8 Oct 2021 18:05:36 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::59) by MWHPR01CA0029.outlook.office365.com
 (2603:10b6:300:101::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:36 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:29 -0500
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
Subject: [PATCH v6 11/42] x86/sev: Check the vmpl level
Date:   Fri, 8 Oct 2021 13:04:22 -0500
Message-ID: <20211008180453.462291-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96049c67-df7a-414c-789f-08d98a863ab3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1705:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1705AC6D2D9B63FAF16FE37DE5B29@DM5PR12MB1705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nE1enjAfYirkB8rIxAC80Nceu7D33dyrweJsHFJ3v8bG4KcAVHFdFJBA9DSBNw206MdFZWdVP3jmj2jxKKE5U5iE6Jo64q2R2IcJFQheo1/FJNIMirOtjq1i+tMltYOGA/YsLet+mcJ40HncnBp4lh7TAGonrkVtc6hC3MaqnQ5aI4ZRPr+bkhcUbZeFct2uUfB5NF3zJfvPAoys3LEvQZ0N/MAkcHe4uW7j1NN5TFh1TjT9rGX8kTd7fboAvZUwwlSilGAsYQL3iLTovSLkGW0e6lDVvR89NjSCHhmaYCfh74nDljJ1CzhUl99D5s50S5nyDEnbkksrsTA52ge7p1dKLx2qDlaOKpt3aIuPX3sZpkICKZ5WAntdFthrHsK+aIPoWc1mH+sjO4isNpXIQrtykyLy7hfLCg+E+vxBy+Lkvv4CDS6yECTO4NyvkGDP7M+wwAkk4mqdVNWVRYyijNJxGFXUtGEHhFn6pRA6BbF3dWnVzJmOUJSvrzfwTT6zlNz53+/lWlOFUsQlavc0hAefULI++FojuFdVFnvDc6X0EJ6G5RLNrTdcmq8Ttog1McdynFXe2WBvqwTYMOev0kUkMGZ7g3w1RgRZ5ROl5EenoBvCYmTuN4PBfDcqVMqsW7mTo3ObxrZ3Lou2BEeTayo4Kdt/PLFh/NenNx/tu4OZ4EVqjmmYU5dMgqALaE+qFd/+ztU0cXudhZon/jVHpZk+xamwodIsbJ7iVlL9igzcQofSJMtKtEuoOnHrEGPb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(47076005)(44832011)(83380400001)(8936002)(36756003)(508600001)(336012)(356005)(70586007)(70206006)(82310400003)(2616005)(36860700001)(26005)(86362001)(8676002)(54906003)(7406005)(7416002)(2906002)(81166007)(16526019)(4326008)(186003)(110136005)(7696005)(316002)(5660300002)(6666004)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:36.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96049c67-df7a-414c-789f-08d98a863ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
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
 arch/x86/boot/compressed/sev.c    | 41 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        |  3 +++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 8b0f892c072b..cf24cc2af40a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -124,6 +124,36 @@ static inline bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+static bool is_vmpl0(void)
+{
+	u64 attrs, va;
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
+	 * Any page aligned virtual address is sufficent to test the VMPL level.
+	 * The boot_ghcb_page is page aligned memory, so lets use for the test.
+	 */
+	va = (u64)&boot_ghcb_page;
+
+	/* Instruction mnemonic supported in binutils versions v2.36 and later */
+	asm volatile (".byte 0xf3,0x0f,0x01,0xfe\n\t"
+		      : "=a" (err)
+		      : "a" (va), "c" (RMP_PG_SIZE_4K), "d" (attrs)
+		      : "memory", "cc");
+	if (err)
+		return false;
+
+	return true;
+}
+
 static bool do_early_sev_setup(void)
 {
 	if (!sev_es_negotiate_protocol())
@@ -131,10 +161,15 @@ static bool do_early_sev_setup(void)
 
 	/*
 	 * If SEV-SNP is enabled, then check if the hypervisor supports the SEV-SNP
-	 * features.
+	 * features and is launched at VMPL-0 level.
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
index b308815a2c01..242af1154e49 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -62,6 +62,9 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
+/* RMP page size */
+#define RMP_PG_SIZE_4K			0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
-- 
2.25.1

