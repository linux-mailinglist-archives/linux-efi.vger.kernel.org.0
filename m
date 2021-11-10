Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2644CBF4
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhKJWMW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:22 -0500
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:13274
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233807AbhKJWLO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1dCfAfupv5+bAgtmWDwEu8Y7Uht8XsCJ+jhzbv7ZWEDGeLAvmSs50VoFJTWpIqeW2Rk6qFdABxdxKeCZuMrVNv/3cONkCLfBboc7VdQq5W1z5uUYVcwM+7Fe8az5T8d++u39lGzWy0by2678NRdye88ZzKH5tbCxoUrpUL+A3duj2loQceII/ANu259mSjH9M/1vw0yyjj7+62y+QREYZzFkDtz4h1ifQdit1mShwKnAJ4WyY6MAqmnNA8ytWTFfnBtyMwvTsSbrZCrZjsQd7e8HhZXpOH5G0F1O5vqpZ6ydf8YGBeqEDFjwLtuf3eGM8VX0DZZ9hdXMJKEi20mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvqWQ47dea77mexKn/X89OjupN7xeg4W3twGeZDKhLs=;
 b=YHBTzJ7xZIvOy60Fdu9uLOneDqvLD6nYluRTaxxGrt0iUwS3xIz3DM2GdWxCe0mcZoIcjw5ajywbeQTjLOgWWGicd+JFvlngapPrwXstjFKEHZHfnptM6/UNcBPKBInVH1547joKCsUm3zhFX27JZCNlDdmhxPuNZXXR506AqhvybHhZ4OwFL+otR/bDgP4AzIMShBk+mAsHVSVn0sReUqHDsROggXqdZFcRCKtUDPl94sI7ti/a82tv2b4KYmdU/HKE7Tt9+zFtGFNBaKm5YU2teYsdQldz/w+GNG6O4QnMbpmZlZG9sMlufRVErxIxE7P2XFefV2grDJJyluc9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvqWQ47dea77mexKn/X89OjupN7xeg4W3twGeZDKhLs=;
 b=R5vTXZI39AhKDxZ2iteQSGWIDD7I4fO6Sr5uJK5SaRVsprsBwvy97puwFCjrNURnKDcHCi3o2meSwP5X5gOL1TySj9SeM7qFmNjQILWp1sen/k7yF5EHgpN23c1rxW29dCCyJGPSRh+zrqBZVG7JhXFkY74DizSUuNlzoZ0jePQ=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Wed, 10 Nov
 2021 22:08:21 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::31) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:21 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:17 -0600
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
Subject: [PATCH v7 16/45] x86/sev: Register GHCB memory when SEV-SNP is active
Date:   Wed, 10 Nov 2021 16:07:02 -0600
Message-ID: <20211110220731.2396491-17-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a45f8b7-074b-4df3-c66a-08d9a4969bee
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459A5EDF7C01212C6283D0BE5939@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogCJFZRSMsLcjx3zfi0fdkkZX9OcyCNFoUeEHJQAsbmKOdWU/sEUkDPtJsZpoO0d49Ns5T8c5cmU0WQZJ4LdsDIBb2I+5jhEHDkVmVc/8b/CcgFtFVS8JXpeJ5bSw55c9qHP+PfeSyeB08x1U0/SjYUFlNa1/sBHKxdQppMwOrABvL5V0iNUTYEEYTIfkHcfHPtxfc17RSLfEkcAweeDZLYFvaouwbrIzy04myS74/e3J6ZerYOryCqYPAybPq8rl5wrBFfbcQnjg7MIWWvJiNk9zWumPdew2vW3bzLI06VgZI/PEhPkG9nuIt8yZYp/69dND5welu02WFISTSEB/YUlpzgFu2s48+PxntOtvbdjJruAgShNDavmthgTXPOERaM11VylTLs9UGpGl8b7j+y/KQh5M1sV6iZyYmCerMJlTsXod/DyqFh5ldpPL5gE8ZXYm0pdKMq8EwV86bKBn2JxTpdV5zDrBXU9qcd1OCzisAcmi6HmhNFgPhrIpGtU6WsQJdQHuVpXXYCCYvzXQgKnT4s7qAfAjVzZCb/mlLR29o9Od10lWTD0VhMTioJk1zqp0vaNlyRzbJqRV+SBOoGLYaiFxDMsYSVbtEVhcJaOTsZspok1qF/ZnzEA/DaMGlFRL4BwwRd4dqRhQrbbvjIULtTnhPx9KtFmCJfaK8NMhwwlwyBgDytOUnlhkXyTc2V5VpNtfmHUt/WAZ3Is8Xv0oy7XkZHfz3wgQqeCM7MSO6gd0v2vnyflNc1Dn0QZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(110136005)(36756003)(8676002)(44832011)(4326008)(82310400003)(2906002)(508600001)(7696005)(83380400001)(6666004)(316002)(47076005)(356005)(26005)(16526019)(186003)(81166007)(70586007)(86362001)(8936002)(5660300002)(426003)(2616005)(36860700001)(70206006)(54906003)(7416002)(7406005)(1076003)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:21.6922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45f8b7-074b-4df3-c66a-08d9a4969bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification section GHCB GPA Registration.

During the boot, init_ghcb() allocates a per-cpu GHCB page. On very first
VC exception, the exception handler switch to using the per-cpu GHCB page
allocated during the init_ghcb(). The GHCB page must be registered in
the current vcpu context.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |   2 +
 arch/x86/kernel/cpu/common.c |   5 ++
 arch/x86/kernel/head64.c     |   3 +
 arch/x86/kernel/sev.c        | 116 ++++++++++++++++++++---------------
 4 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e37451849165..0df508374a35 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -122,6 +122,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+void sev_snp_register_ghcb(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -130,6 +131,7 @@ static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
+static inline void sev_snp_register_ghcb(void) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0083464de5e3..16b5667bbfdb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/sev.h>
 
 #include "cpu.h"
 
@@ -1977,6 +1978,10 @@ void cpu_init_exception_handling(void)
 
 	load_TR_desc();
 
+	/* Register the GHCB before taking any VC exception */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		sev_snp_register_ghcb();
+
 	/* Finally load the IDT */
 	load_current_idt();
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 54bf0603002f..968105cec364 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -588,6 +588,9 @@ void early_setup_idt(void)
 
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		sev_snp_register_ghcb();
 }
 
 /*
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 80a41e413cb8..30634e7e5c7b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -158,55 +158,6 @@ void noinstr __sev_es_ist_exit(void)
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
@@ -459,6 +410,55 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
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
@@ -650,6 +650,10 @@ static bool __init setup_ghcb(void)
 	/* Alright - Make the boot-ghcb public */
 	boot_ghcb = &boot_ghcb_page;
 
+	/* SEV-SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
@@ -741,6 +745,20 @@ static void __init init_ghcb(int cpu)
 	data->backup_ghcb_active = false;
 }
 
+void sev_snp_register_ghcb(void)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	if (!cc_platform_has(CC_ATTR_SEV_SNP))
+		return;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	snp_register_ghcb_early(__pa(ghcb));
+}
+
 void __init sev_es_init_vc_handling(void)
 {
 	int cpu;
-- 
2.25.1

