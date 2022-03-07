Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2BB4D09A0
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiCGVgi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245642AbiCGVgX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1A85BFC;
        Mon,  7 Mar 2022 13:34:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW0x0Al6GrmWFvsmu+FydZb/rGGG+bGXRRXid6kxF3+nURCOM2TJTANZSh9fuaFJrAehWcI/z8c5b/eAR5kbYSpbhR3tOE/cG6waxbhqqm/4FH7o5rMz+4U7lek7hP/OosoEYSMB2K8w37HlRvykjYlxPLoEtICoskx4JAm3UOo6cV7cJ5gEKEOY7HdLUNDNhi35yxBkLG+dAr6ieO3lxliS6zIA1K3tRATMsgwHWZF83Mku7tsjExQmOdeefWicENp7uM3LLa0aDvzxBFIPn4SK9F/JJa6rUXbqDCDet3RtVoyb9UpxfwxpA2XGhqAlKhobkCyjFs3H34Na6+JLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYEFd5SZqARollFkWwFFp4AQ6u7WJFaK5fjHK1gVJxI=;
 b=IGa5ftllqqOt0xIN7gtkIKtkcqAM9pHSbrmszKeOesR2Zoad2W6ZgLoaJSb/WYJqEUgoaeahscbunh7aYn4FBDcOvAzZE1AgGoiSNWSyNI9KjVZoc6/I+jIf/ZwSOQnG/CJC265ZTlNiN8RzqEmw6ux/TjuZqm1hSOzRqvx0Rae8euWBxzDxN79FiAffcGr/rI1EQy82LMB8bCZJVnnBYszbeydaWGuUT7PJORHGFAAaneBL1w7qqSCdB3s9sDXqKS8xHjjrZMc5LEIV2NsHOEt5/YBA6IAQZ2xDGdDIYdio9TD7TuJPkXj023FAnx/M1CZ9w1iOwGhqNHtrz/CPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEFd5SZqARollFkWwFFp4AQ6u7WJFaK5fjHK1gVJxI=;
 b=BxPixNhL7FSUe38mZp6hhwYkTmQ07bs+yALecW43R3exKhMNadAC67Gf7ig35rOwjYiFWVNsPrWv7VRxYY6ymco5OZmq3j7Hr3aHPPpfC0WSMvmMRh5RDWNhOA385z0w9rmn7pOfyMwkq4Y1Xfj5jzua9IVH5QzfV7OdWhmKXtA=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Mon, 7 Mar
 2022 21:34:54 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143::4) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:54 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:41 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 14/46] x86/sev: Check the vmpl level
Date:   Mon, 7 Mar 2022 15:33:24 -0600
Message-ID: <20220307213356.2797205-15-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1513ce9e-f5af-43a0-8f2c-08da008251a2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1288987CD4F0F953A3276FFDE5089@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3QB1eiQV1dQPYDNgu1lZtiy0e6DOQX+2xC8VDmYY9agMXHObD8p2A+CSclZ17eUrQ2QbVImvzrZ6Av4NKRrNdYKJmSeumWCF10QK4nEJ3IuXrSfNVkYUC8WL0POB9GzmJY4TOMvzSzdhaVlHWj5/IvIXb2pjRauLvZsg3Nx+Jfl6TJkko2jDpXn4FtzxEdkNa2k10T7x4cWtz/FAp8kX1sCRv+JorEfFXXaQ3vnbatrUxTlMe0z2YioPv/9hZFdCA7eS5ntSrcepZMuFb9F4VRSbt1Q7XetzKyspG+vPGKt0DFIJ/RzsV2/F624J2XZnCPUnQQ1hhirdJVr5fkE2Q4ENqkgqG9E3mQ+/LWVl/C9GNMqdxK85NOkqU0FIBAsbTMdES+iIqcptnleFhi7tE9GvFzt5M3wRVJvILpQnWwZeuRSyEDzYvJMnbHbl3CIJfg1Sr5RHN7IPkat5Q7RDnvZd3hawUU/G3lWUMPMKHs2VyRCG8I1YzbSAZsNhqXKT8rp2Pt2wfhCifjMuiWIH28c2EDkwf/gO9+RlkUUkMNt/jXTNFcg6pF7cip1vpiEjuz6UnUApx8WFUa1ogUDOtZqCTrxoh7uvXzmZE9/iWH3KSljW/qaAdhaCkUEbiKEln59BDAGkdK9t2rjZuKzMURSYXcd9bJEYsNW2VwXFNZwUxuSiw3y4AczBf5wXXZyYzyjvTld0IozMRNRYhNY57aTwYfBvfVLr83E0Om0d64=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(8936002)(4326008)(316002)(7406005)(7416002)(5660300002)(44832011)(8676002)(110136005)(70206006)(54906003)(36756003)(7696005)(6666004)(508600001)(70586007)(26005)(86362001)(16526019)(186003)(2616005)(1076003)(36860700001)(47076005)(40460700003)(83380400001)(356005)(81166007)(426003)(82310400004)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:54.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513ce9e-f5af-43a0-8f2c-08da008251a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/boot/compressed/sev.c    | 28 ++++++++++++++++++++++++++--
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/include/asm/sev.h        | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5b389310be87..84e7d45afa9e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -199,6 +199,26 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
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
+	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
+	 * changing is a don't-care.
+	 */
+	attrs = 1;
+	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -242,8 +262,12 @@ void sev_enable(struct boot_params *bp)
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features.
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

