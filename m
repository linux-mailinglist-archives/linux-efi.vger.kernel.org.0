Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C3F4C329C
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiBXQ7n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBXQ73 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8586F4A7;
        Thu, 24 Feb 2022 08:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmoG7asGPGWlUvGgEMpbETqXheOpfJiB2TnJXS7eEGgaJEBlJGelpkXEFj/sFoghcoEi+e+x+/vBTsN79h5W0MF/LSqlALlTXEyKoPcggSQdqKpTdN1Qs/Ks1+rL4RNAqV1nkxYschFyfGBq25WNb1xV97atlBudhfapXGdIo2MNcF+ZwBvod0bnL8Is9WF0ig2SMKyA0uslBXMBNxsyGo//slMnLPQfk0Z5lpzSL3IucTtXJEOagOtNohrjAeqbE1EO1n0N+W99BiexKAcQtE/CO/kEaWzqG4TUBgSX7jcJfp8NY+QqQ8PhV3+SbF29aVcnnbWsM1RLfX9kdh89Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IeNR3dE235Aur/W4uNaSSGW5/OsmrS029NUXjkxG0A=;
 b=oUf63aMZP4WQqR/+JJWwxiD+Tdh+PpbTxdLZqO/MrE5eoq2BXT3Lwqkxeu9wujdJS5pg8gQl8mFOEiF1otwafM15SwwseIKRb7f93iK3w3VgNBYFnm/+K/sRyYoDXxOFTLiHs3oI43lOEt6+ijDXOnzxuyTpLzg+FFjrSjNqhLSFMZAO1dwV6r8lKgodPZGjp3GecrO3AnaKNjIfcXnbZFuZzQbQoC20A4+67vw/d8F2SZPU2NU7zqi+qPkIvY/RP3tdb5V8ktLfwBrzB1MzC6dAQUJleygoMRZonR7ZbcYZmV2Ft09nV5ikqOnJcOGvglweY6g23I9n9AXi/ghyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IeNR3dE235Aur/W4uNaSSGW5/OsmrS029NUXjkxG0A=;
 b=ZnUkltlANaKeN1G9sL13TE2VuV7etW+D67gDbuHSMd4jXehh8en1aRNTELVRQ4+D9gN0tLsIwpO2woTYoaWoRWa6gufqtu02iclL60/NIlgdfpbrq69WHMrEwlkg3mVokwKeUWFivU6cBiLnmYErvIMlP5r17b4GVtDC2lpC1+8=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by BN8PR12MB4978.namprd12.prod.outlook.com (2603:10b6:408:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:58:28 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::5a) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:27 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:21 -0600
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
Subject: [PATCH v11 17/45] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Thu, 24 Feb 2022 10:55:57 -0600
Message-ID: <20220224165625.2175020-18-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63c50f8-82d8-40be-25a0-08d9f7b6e0c5
X-MS-TrafficTypeDiagnostic: BN8PR12MB4978:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4978E5C043C853FE20174D79E53D9@BN8PR12MB4978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uXyGwgUyJsZ/zi5tTzxW1LfTxAqI7p9P5xhfTlQa5qm3KpHHU3G7IU+1ie/woMGbPGDMwZRcS5qBlwtGNXHFaYgJboLurpSxTOaR+3CyNOlLOFb1B+GUzMnT6VjxQfFghTBEg98RbLPcpnBY6f3IgO6ogENVMP6vWmCfAc8O+bUhUHnQhtS7f623YNGg4nZy24KL1glEBf0EVRbhS/l92cEbwurJ/VT2vsjsSWe8c3s3DGAZWQN9+CAzqUiiT0xdBdSZj5XJpoS1uReWFBCijtufAx5mcsrrjFLfF2DrUH4ZdnDDG1OGoTHLYB8wlqUC4CWJh2MUWqM8ece4Z5jQu768OJkcyZEBVNH9yUlQqBDDnRvpx8hsyJT1QPyPfUK/vGj3PxIpGFhG5YhCRC40CHWFcIcWphyJycnhHfjLQNyc2wva9pxjgdl0c9B+kIISPPrmyo/6MPAa9XWvVQ2kBXIXZmyz6D4U+AgG+1e/3RT1qIcVGvYgOe5zczBDq9s5hrcfe1C8TjqrGTvO+8wwPBDiBN6iOuDdIIjCwgS3M7u3twRNIM+I6AfTiVRlQpnldUtH0B7eySfz5DyIeKsov18Ah67uYGiQvLNzkMZP3vkBX+8jvs0ChR2UK/dg+xLNoJq7PHRf8fEpG4x2MtiINKN7EiV3P7nJL2UVvo4ZHT3GJBLL7voXW0SwrVBy8fZJc065GVzGqUoqcrvWD7GaM6aKBAcMU1dVelBsNO//0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(316002)(86362001)(81166007)(82310400004)(40460700003)(356005)(70206006)(70586007)(8676002)(4326008)(54906003)(110136005)(8936002)(7416002)(7406005)(2906002)(16526019)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(47076005)(6666004)(83380400001)(5660300002)(508600001)(44832011)(26005)(186003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:27.5667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c50f8-82d8-40be-25a0-08d9f7b6e0c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4978
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

