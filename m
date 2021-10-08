Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80332426FEE
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbhJHSHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:36 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:62689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239831AbhJHSHV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrE6Y9MNIv9QP2wVi7ULyXyLCpOLGpgAhASfOwFEWpoxVA7JIB+ms2zvYM8nUBDC/w8Jq4OYijweAWmSynchBKzSigAf4fyoCHqXYou9xUkvHkD2J5tjieKqiEFcGmzIqeMTt2t8E2VPJfSEvltCtKWRmgqf0zbBnVGwiUGi/i1VotvZx524QGUopcTM5DR6qfdgRqJo/+Jki2esgbQbu1ySBLyzZcfoDu47JpbjvmCqYydiokl2Np/GsTFTfp8mpgGx9SuMzg2o5tEG26EqFmd/hVrah7UfspFDVq3L/fjFZ8HyKAqqoAJ/Ub6PT8fIU7xR9+Z7+cw+Y3byJkhRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y47FG/ATzQbYZbPfzy2kGlefr67D0jCDKrZ4ZUfDKk0=;
 b=I0WdlP/RFX2KWNgLD2nqvWwoWfT9d+GxnnrR3tS+h/qbC8QuGcYYqgIAsJZMOrb9G0LUt8DQAMIA8Q5XrSs6z+O0gGR2iHR5knsw98w42xRhjeS85tZSRX1CQBd0pB9kfF8hiaWTrZ+1C+xd2Gjwol2Qje4ikjEmumyJ9m4OOtB4IHBdmCss6POF7e2DndcTiKN1SySYaMtT9WgBgycUJlMoN6Sy+1JtN4AEHLiYwscmOX7qV7axnWnjXCHgI4fQ1YWjkJiFcO2OVLCUOembPe2VxwKIolybQC9rPWFRCeOT+4FYzvLWTmgMulVGJh9BAx56rD6sOUWn3xpk+NZdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y47FG/ATzQbYZbPfzy2kGlefr67D0jCDKrZ4ZUfDKk0=;
 b=B9Vh8+3LZVEoN/zYXtoD4RotLFbwRXQ7gomXvJhGCxeM2NiLrMwuNGiRh1yD5t5c02LPg4/TDwovBcL18AuGS3A2YD08nseYHr0h5nueX6inX/652i1DJS9lQHSC6jOHjQXCWrYrtMWxWWzxRjlCMACzMyfYeCcGRB5XLvwDQBQ=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by BY5PR12MB3667.namprd12.prod.outlook.com (2603:10b6:a03:1a2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Fri, 8 Oct
 2021 18:05:21 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::32) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:18 -0500
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
Subject: [PATCH v6 05/42] x86/sev: Define the Linux specific guest termination reasons
Date:   Fri, 8 Oct 2021 13:04:16 -0500
Message-ID: <20211008180453.462291-6-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5ef2a0c-9267-4511-dc6c-08d98a863192
X-MS-TrafficTypeDiagnostic: BY5PR12MB3667:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3667DECB067256E32D12462DE5B29@BY5PR12MB3667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mbbceMXCWiBi8p6zpzr2M2LtOWkrGxzBcKYupVImpFmrgyGliR8wERc6eFD8ANyc+m7rlb3FrOfn4CAUyseHjCunpr9DKYKAJ+wdipKsZwIU2bOcBcVQdjZfkmyeJ8SUgLVK6p/9pIPhth3N0lcqP0WpcLkvdApMBtfYbnZ78NudR+fQS1LecmNmqADqd1Kh8flyjOKdiFcoCLwM1WexspHSQ1biOW6sD10nuskcaKaFTEkVbuzGUrcix8+9udlEusFKAMWbeQtQ5EE7P2BWAMCQg/hf32dVQWFVR6m1OLs/n1rMcO3Iri+kB7yLND7y43A1jqi3v8xWDmhNiuTDbCfGxG1wfs0nxH2mwc4w6kawO/q/aKP07HbHizNP3DFw/ONilAxQFFT0Hu/fnUxvLBdc/bG1G54nxIPmdf+Tl2XzE0vMXabTXmtnZ8yCwyxpglUZFWpKi6s7QQEncCkN0JXgil+qYMC/+k1sR3WMffmmqOTyOqvpyxNrokE4ZXAlDxPIV7NdN82rzRu+C7AN35LqHZ7F2EdqsB+xNeuKf8OKnhT32g9V3N6V/2kwFtXNMGH6oPyJYNstclH1VucvuaC9Gs8rEUswbw7Bn5H1z7HoyDpy1QUs81cLE/5kAl2B3On98fApnQrZCDtNSt1zu7MoDCtrvv7/0LnsPcWu68n1hCVMtFJ3WRpzw7+eNe3fDyyS9pmPOks1Ni5r7Su0N8h4ZKfqeSTKNetG/zQujqjMMJysccrLdVgWhkJZHlJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(2906002)(508600001)(4326008)(7416002)(36860700001)(70586007)(82310400003)(47076005)(8936002)(44832011)(356005)(16526019)(186003)(1076003)(81166007)(54906003)(2616005)(110136005)(316002)(26005)(5660300002)(36756003)(8676002)(7696005)(426003)(83380400001)(7406005)(86362001)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:20.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ef2a0c-9267-4511-dc6c-08d98a863192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3667
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GHCB specification defines the reason code for reason set 0. The reason
codes defined in the set 0 do not cover all possible causes for a guest
to request termination.

The reason set 1 to 255 is reserved for the vendor-specific codes.
Reseve the reason set 1 for the Linux guest. Define an error codes for
reason set 1.

While at it, change the sev_es_terminate() to accept the reason set
parameter.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  6 +++---
 arch/x86/include/asm/sev-common.h |  8 ++++++++
 arch/x86/kernel/sev-shared.c      | 11 ++++-------
 arch/x86/kernel/sev.c             |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..7760959fe96d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index aac44c3f839c..3278ee578937 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -73,9 +73,17 @@
 	 /* GHCBData[23:16] */				\
 	((((u64)reason_val) & 0xff) << 16))
 
+/* Error codes from reason set 0 */
+#define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
+/* Linux-specific reason codes (used with reason set 1) */
+#define SEV_TERM_SET_LINUX		1
+#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
+#define GHCB_TERM_PSC			1	/* Page State Change failure */
+#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 007bc25d265c..a010d6b41a04 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -24,15 +24,12 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int reason)
+static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
-	/*
-	 * Tell the hypervisor what went wrong - only reason-set 0 is
-	 * currently supported.
-	 */
-	val |= GHCB_SEV_TERM_REASON(0, reason);
+	/* Tell the hypervisor what went wrong. */
+	val |= GHCB_SEV_TERM_REASON(set, reason);
 
 	/* Request Guest Termination from Hypvervisor */
 	sev_es_wr_ghcb_msr(val);
@@ -210,7 +207,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9b3b41a7844f..427b1c6d08a8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1397,7 +1397,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1445,7 +1445,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.25.1

