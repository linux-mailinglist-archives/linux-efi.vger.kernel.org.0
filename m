Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854749FF0B
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiA1RTa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:19:30 -0500
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:8974
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350672AbiA1RSx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk+WTW7jigYAZ0Oc2v7owZb88O/lpxUpe4ZB04XfUzWtr6uCplMB7gOjm9yREDV0zQmorjVzEvvFst1nxYiLAlXq0BSEGiRKpuDGviZts/XxO+veN1qB4WZ88okrBFfxdVAo/a+7hJDgyGW88vWl3OFwAmxFDwTSDMiQtq1XTNvbDA58pLaA/ZCzOsctVAH+xELb5sih550znTpQfIUKcZkgFzw36+t0giOwU+H9PVLBVlB0+SbA1/XV08DQ7rcCzASS7n20K3Exs0VzkWxDTzCKbNilhYCuM2Tvt20ikjfItsvPXC9VfQM/uZcbhQ9u8GDbhA+mdkfum+BmDPLOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP4P/RpwU79sy4uOAUf4aHX1AAllb7yVF1YZKjo3vE0=;
 b=mEdTFMP/0dqjyXZYHNAflRApl1oIrl78CSZuIIQaP0jRxJj4oRr7dV/huuiyiOG2VXnybBCQ2r7YjMfHFe6Tebl3pK4J32tS3fVHJC3c6UXI4ivhV4EEV0B7OHuNxvT6hpGc8wzdJpdUZKzuqULQ8Splv+GhASsoRCKTgby2Y44l55BmU8kmRUD3RsJ8lG78+HlVwR3ooxmJNYepswU0KN+zOfggqfiy3u6F5vB8jOAx2ujFj5DPvcfsJG5uLqaPBTJsvs0TdwcxS2BHlRbbCY9rLARtufcBwlIausBvBYvpgd46pw3jXI4x1L3a/SzRnG2egVpZZ28F03oq+Mn29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP4P/RpwU79sy4uOAUf4aHX1AAllb7yVF1YZKjo3vE0=;
 b=zjvfo5u2VuUMR309bPWIQaLu8rzxHw+GShWFiZac46fKFZTgKM0nkoqJrbtRolNEmmFAB9x2OhOJUWcuuUtEWB4wlWeMQjv8St6FqMqZOLPsTBPDzonIqKG/19pVEmKRtEYoeFE120ylPlCkr+TNYNxmcjjCGc+R/eJy4MNP1lw=
Received: from DM5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:3:12b::15)
 by BYAPR12MB2694.namprd12.prod.outlook.com (2603:10b6:a03:69::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 17:18:48 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::3f) by DM5PR04CA0029.outlook.office365.com
 (2603:10b6:3:12b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:47 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:41 -0600
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
Subject: [PATCH v9 15/43] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Fri, 28 Jan 2022 11:17:36 -0600
Message-ID: <20220128171804.569796-16-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 057c7232-de99-4071-2de3-08d9e2823eee
X-MS-TrafficTypeDiagnostic: BYAPR12MB2694:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2694AA986F7EF431724DADFBE5229@BYAPR12MB2694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwL9CnjWJMqq3aFrghnooCPGa6Q274qNAAY/lTjwqdnzI57qVsA9p0qtvfZAQqBWJWQr90Sjx1vd3elKRdYcTCKCkeK6vD5+4k3Vg6iOTl9YQ6jhaEDXOWj+3yg2Crmj/G3BEPCZmNERtQoLP0lul7MzFpSMa1ghihZuxArHymF2TYQwfqX5Q5pvEarzFkwlxCri7RTo6/y2BxCrvZ4smuo0J71t25mDfVi2BAWXB8KWJATVdfiGgk31ZI6BnlKiP68IuldSVzAl+OWMz5NAg9OSSe3UeA2vC/Sr1Kw3Wqi+ulb6BOvk8s8LEic7eyLYQM89dNYiJ5+kVqAmweOkTznKJ6TcrPBWWUvBf/ZfEp9nBiomAL0frJBw+ZHRS05QO16DM8ECIoO1UDtFTJIOlpZoTCoAvIMfiZIGfFy416+B9B7UFGGUsw0S/l5cnP4OdWo78WUUuRG+Y1iWZbUOvUKJJrPum8ZlPVNSJzHVnatDCS2H2u6SIo7TE0TRhnu5ee3Vs5BZIpIVFWxExybTMKqeyF1r0X0DD7C/51eO/op+x/TaaCX5IE5DzsjLoPJJGt/wjZiMBKzw9JNl3S6QnaVwBHeADqCXJBh5hcKtbk+5Ra1QUEcHicqW1Ent2m46254LyU8mQi3QBPxK+Ped8pzqxg4LYuVUX9RSVVDg8eyKI4ml5KOw/EmmUB7Jk4vP+d2HiTicDzuvCLtTaMCI2NHXnr/qAmJq3ZlvPJHzdTg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(5660300002)(7406005)(44832011)(82310400004)(8676002)(70586007)(8936002)(86362001)(70206006)(36756003)(4326008)(186003)(26005)(83380400001)(2616005)(426003)(336012)(1076003)(81166007)(2906002)(16526019)(40460700003)(47076005)(36860700001)(356005)(6666004)(7696005)(508600001)(54906003)(316002)(110136005)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:47.7964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057c7232-de99-4071-2de3-08d9e2823eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2694
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
 arch/x86/include/asm/sev.h   |   2 +
 arch/x86/kernel/cpu/common.c |   4 +
 arch/x86/kernel/head64.c     |   4 +-
 arch/x86/kernel/sev-shared.c |   2 +-
 arch/x86/kernel/sev.c        | 145 ++++++++++++++++++++---------------
 5 files changed, 94 insertions(+), 63 deletions(-)

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
index 7b8382c11788..d3c319f2ffd2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/sev.h>
 
 #include "cpu.h"
 
@@ -1988,6 +1989,9 @@ void cpu_init_exception_handling(void)
 
 	load_TR_desc();
 
+	/* GHCB need to be setup to handle #VC. */
+	setup_ghcb();
+
 	/* Finally load the IDT */
 	load_current_idt();
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 66363f51a3ad..8075e91cff2b 100644
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
index 24df739c9c05..b86b48b66a44 100644
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
@@ -161,55 +161,6 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	return ghcb;
-}
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
@@ -483,6 +434,55 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -647,15 +647,40 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-/*
- * This function runs on the first #VC exception after the kernel
- * switched to virtual addresses.
- */
-static bool __init sev_es_setup_ghcb(void)
+static void snp_register_per_cpu_ghcb(void)
+{
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
 {
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
+	 * If SEV-SNP is active, then register the per-CPU GHCB page so
+	 * that runtime exception handler can use it.
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
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1398,10 +1425,6 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
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

