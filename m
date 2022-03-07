Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1F4D09C6
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbiCGVhJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245691AbiCGVg2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:28 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2A88B16;
        Mon,  7 Mar 2022 13:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC4nZxNTqCLo9IiunEngGNejLNXql/F6kcmDvSbk/DBRtKpnNLIJ4fUUfz7Gvceallrl/K410ytz59K8Un9kUhJxejZxt2Z0iIeuJt4MfexjFmVh5TKN9bCF3DnKcjNJovF0C+TqmtQQBSVQh0qfD+hAetiCbHS2o/F6nolrklKEwCWANmVfhQJ9u5MoGLEW8f+4+0eFgnHbee8Q9Gpv0+JAXzNO8a/P176Un+wgAGdp611mNuHAB86m9e1do7xm6netBEnEFmCtk33ach++ZL+Lwu4faP03BwXSHfTppRqUNMnP+cJiusCj70/IasZhPfknwQCj+ywtvqok1lD/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IeNR3dE235Aur/W4uNaSSGW5/OsmrS029NUXjkxG0A=;
 b=MIC8SspNj+taq2l+ZqY5rnJxp7NHlCE66TKDuzwTWfay6Ogok5pR0XtTwPf7WhcDBFc3jEYxndGlK6jms9oAXDPMmed/76f30sAyM/VbkVP86vSXYVTtxkwrai01InroRK28ihIoK1iUNTp23AK2RlzaiSa295qe7ZW539OX3froXFLruO4T1tqszaF0m4iFzXTP47Ul9zE6b8oFuJY+n3VIuULTFj6Otvcvw1gLjMjHdVgltMhGHSyb4SOymGCO41M2L4K/IYpALSjwDKz5Raf+oabGrAQAOJKJpPYqXuK6GLv3KPxqzjXKuSAXt0h4NhiA+OwXc4SsCfgeHbOcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IeNR3dE235Aur/W4uNaSSGW5/OsmrS029NUXjkxG0A=;
 b=qlcKtXBvk7nnxN4+E9s7A39L1j/1i/O1ezXwF/ort2zC2E77JAehUgC6ltaqHJjPgpMWJgnILpr80o+QxTPR2Y2csfipkEkKGskyc5+NIZ7suGuEtq4nK5jlIlr6sGQD+43/D8DHckjafP/cFamrvPzpJVJEEXdBJHabO8gogmg=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 7 Mar
 2022 21:34:57 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::93) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:56 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:47 -0600
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
Subject: [PATCH v12 17/46] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Mon, 7 Mar 2022 15:33:27 -0600
Message-ID: <20220307213356.2797205-18-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b305bd5-18f5-4614-512f-08da0082532e
X-MS-TrafficTypeDiagnostic: MW4PR12MB5668:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5668A25A6D7C2317E89D6493E5089@MW4PR12MB5668.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtwUkbo5RiXatxgjUSiztKiwGZ2kCxWSLMLjGZjUuVsbAj6IcQCE1hZwLQPMd97rcVlb4WCbXURm6o6WUVyIs+RlmcxR3VRqVbLIdum+PQ31XI6BWbhbb8PB3VvrWNfzcsZNiby0V3+3JZsH/ClMmGjJ915OJiUhuPkxaLVlWB3C04fcTZBB5px/GYKPpCTdR6MhFfLKmgZpcngSazJsXhpCwARzVpVWUz9syOHqqIgydrtfcAFrXVob0umeM3D1kkGZ5Uc/Pf7lujt1wyOGXxxI2VJ63MxDsK1B8yuCIkid7ZinbDgxb/6sB+A8X023fVLHEwxE5a0HxfCYZdXkfIlZBBPP66IolRzQ9R/c80jqZ2/FdKt4ukSYz4nQhCdY54Z+at7xUdOdaUIs0skwXfr61rjx2YSKFLjaxZp3IXXh+VGxSxi3a5fAdTlHebKbr/tdECLQ+4vPmQ1cTcKUnOT0aBnwN5x6wK43m5sLhCs2NWCcwtXglUZeWIuQnETqN/42P441TtkE0gKWTw7lvkUKcLK9JSxPZaTz7qphat64F8BReSSMxnIYsLWFuBswmn5r7CIr0qnSnfQdxst2tQGnHJ5DqywERyThFoGJQDUn5WL4dcGrgo247RqAdslsKgYxffTMtjnShkUSRPxFIPIn/qPJqfrWFh0e7y1FRvzI3Xtn2uk3gnRTILSTHq93qNoPle/zI3YOZ5oGBvaH6xPkdX5ZKtcyf2oO8zSVt5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(40460700003)(8936002)(356005)(81166007)(82310400004)(5660300002)(7406005)(7416002)(36860700001)(70586007)(16526019)(47076005)(70206006)(44832011)(4326008)(83380400001)(8676002)(86362001)(36756003)(26005)(316002)(186003)(54906003)(6666004)(7696005)(1076003)(110136005)(2616005)(2906002)(508600001)(426003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:56.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b305bd5-18f5-4614-512f-08da0082532e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest use a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 ++
 arch/x86/kernel/cpu/common.c |  4 +++
 arch/x86/kernel/head64.c     |  4 ++-
 arch/x86/kernel/sev-shared.c |  2 +-
 arch/x86/kernel/sev.c        | 47 +++++++++++++++++++++++++++---------
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e37451849165..48df02713ee0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -122,6 +122,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void setup_ghcb(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -130,6 +131,7 @@ static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
+static inline void setup_ghcb(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 64deb7727d00..2e0dd7f4018e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/sev.h>
 
 #include "cpu.h"
 
@@ -2067,6 +2068,9 @@ void cpu_init_exception_handling(void)
 
 	load_TR_desc();
 
+	/* GHCB need to be setup to handle #VC. */
+	setup_ghcb();
+
 	/* Finally load the IDT */
 	load_current_idt();
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index cbc285ddc4ac..83514b9827e6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -597,8 +597,10 @@ static void startup_64_load_idt(unsigned long physbase)
 void early_setup_idt(void)
 {
 	/* VMM Communication Exception */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		setup_ghcb();
 		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
+	}
 
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e9ff13cd90b0..3aaef1a18ffe 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,7 +68,7 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
-static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+static void snp_register_ghcb_early(unsigned long paddr)
 {
 	unsigned long pfn = paddr >> PAGE_SHIFT;
 	u64 val;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index cb20fb0c608e..cc382c4f89ef 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -41,7 +41,7 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  * Needs to be in the .data section because we need it NULL before bss is
  * cleared
  */
-static struct ghcb __initdata *boot_ghcb;
+static struct ghcb *boot_ghcb __section(".data");
 
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
@@ -647,15 +647,40 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-/*
- * This function runs on the first #VC exception after the kernel
- * switched to virtual addresses.
- */
-static bool __init sev_es_setup_ghcb(void)
+static void snp_register_per_cpu_ghcb(void)
 {
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	snp_register_ghcb_early(__pa(ghcb));
+}
+
+void setup_ghcb(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
 	/* First make sure the hypervisor talks a supported protocol. */
 	if (!sev_es_negotiate_protocol())
-		return false;
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+	/*
+	 * Check whether the runtime #VC exception handler is active.
+	 * The runtime exception handler uses the per-CPU GHCB page, and
+	 * the GHCB page would be setup by sev_es_init_vc_handling().
+	 *
+	 * If SNP is active, then register the per-CPU GHCB page so that
+	 * the runtime exception handler can use it.
+	 */
+	if (initial_vc_handler == (unsigned long)kernel_exc_vmm_communication) {
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			snp_register_per_cpu_ghcb();
+
+		return;
+	}
 
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
@@ -666,7 +691,9 @@ static bool __init sev_es_setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
-	return true;
+	/* SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1397,10 +1424,6 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
 	vc_ghcb_invalidate(boot_ghcb);
 
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
-- 
2.25.1

