Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB049FEEB
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiA1RSo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:44 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:24481
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350523AbiA1RSf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je6cRalxEvbVfh0orBg9EMzRUYomtvJZAsGOO+/ZtdCWLQqXvFtzX1MBXNK7FusswG4Fg59ARvjYyn2I4H75ul5cMERPm6TaUeT+YU51St1h08CfzPfCZZFkkUpPMCeVLDwsEqte9KKJBBKEwJ2tykEdejwqyB2SYkMwBbJQnW79rutOKuet447BTaCIdTlgYUiHWNi8TTOj4BYvD9k3hVGcMfWAUIOs1gKwOgUd+NZXW+dqgeCWp5whh3/3Lv6asFwF4HtX7V5C+IVqfZQNZ4FW+C32F7fq8kRzlBgrZbSw/rexJXhAv4IEsRLIBRjCLlF/sJKsQeiu7ZecRf6vgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=420QpYRUB1Sk7zOn85KXlbS+VD3smAUlYqdhJDAyQf8=;
 b=RV6wUU9bRWY6mGH0pkecjT/joNu9AXZT56fG3XtKiafVfihgqKgO96sZkKp0vCh2FXgv6AoygTDIYevuouJSMNIgOh1Um9MZC+AsEGbrDRmlr0q++67SbJre8zmgj9sX1R7Nr5PLVVNBjKjS3P4owNHtDW7bPY0RJwxWcecifKT/t8L1y8SvU/Y8GzgLfwDsFN0Dgv1KcFuuXCnGvnP006+nnkct+Q08dBmh0CbH6pbXpvK6OE1jC9K5UWQ84D4aiAM3kc4UQpkgNwDa+TT+OfW26mWiyJU6GSHcas1S3309qaL5di7WCiHs+valYHTPmPpy1Rsqe+WT+Wa6WnJBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=420QpYRUB1Sk7zOn85KXlbS+VD3smAUlYqdhJDAyQf8=;
 b=wCdoUaL3ycZXeOOefEyIzDHeimwZo4Q3Impp/mtNJjH8qN6u+HikYrAreCqeJeMBU/s3nxZS8SmtdLxOSclqkX3P440rKKF36fU50ziXNcEicsMM89vsZ5KUH5s0ZgaySKDjIhWD1dryH3igyHUaCBANmrO5Lz/3oT0qNd0AXp4=
Received: from DS7PR05CA0063.namprd05.prod.outlook.com (2603:10b6:8:57::19) by
 MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Fri, 28 Jan 2022 17:18:33 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a) by DS7PR05CA0063.outlook.office365.com
 (2603:10b6:8:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:32 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:30 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v9 08/43] x86/sev: Define the Linux specific guest termination reasons
Date:   Fri, 28 Jan 2022 11:17:29 -0600
Message-ID: <20220128171804.569796-9-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bcef172-38ab-4e6e-2e63-08d9e28235c9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1583:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1583DA55B1BDAD7D634ADEC4E5229@MWHPR12MB1583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrQvo2di7Yu9Ske9K0l19rHzq6km5W+q5mTJli/jL7UBxyOMrlIJd6obK8X1VYb9PrcH5ommhJX/knLLUS1Me/DrVdtOKhKQZ39smvryyDl94sFwvOTBy2tbEiv2jIUMp48Ot266PoF/5ur202nnCGKbexnBzpdujyUTjQ4qNeZ/X6Ry3Fvd3LBHKx8lGMX/QaJ2xukgsv9rQWAyaUwze9eqG+WIyH3ajuC+NT8GQFVpLIGnJem4JLSyo4Sc55OxZHysQbbUDzb4x/rITcsm+cCJqXB5pThrr/FHnFk9ziYURwL+Ju0E+zRoeM065gV/azWf2kGla8A8IZR0ddamjK+91ZNIQYZSYb0nQWfULtueyXaMItAWvIYDrtLWQX7oYjOscdcp3EDShzyUXLbolMqysztdeUk8vOfXrDna2sFeNSiXjWreCqtTobFBzhj111YKbgX8d5cDZhoKRGTpgB09J1PBA6Lb55I351+IBEWshGjMn8mjwvg5QIOBd/J+nIN4cRXV2ZiXiM96UXCRrpemSBRRZBiL1YE1XNyT06QJSrhTMk6MoxAvYjNIisUeCYChBUZsqkhEZsEznOb7/mZuiQNYIAbtqQPMVuaI+x3YIM8hAZhYW7O8woRc3YcHZlkNW6ITj4heVcN4TQGpkJPVZnO5d/KcgYBp5n4LfdCVXsls+O6zgtOu/wQS33x9Z9MHkZ33feCXvr/Qj6rpjq7Vo/JWdOV9ALzPV5LbMpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(81166007)(356005)(2906002)(426003)(36756003)(83380400001)(36860700001)(336012)(47076005)(70586007)(1076003)(70206006)(26005)(82310400004)(316002)(2616005)(16526019)(7416002)(7406005)(186003)(86362001)(7696005)(508600001)(54906003)(4326008)(8676002)(8936002)(40460700003)(5660300002)(110136005)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:32.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcef172-38ab-4e6e-2e63-08d9e28235c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GHCB specification defines the reason code for reason set 0. The reason
codes defined in the set 0 do not cover all possible causes for a guest
to request termination.

The reason sets 1 to 255 are reserved for the vendor-specific codes.
Reserve the reason set 1 for the Linux guest. Define the error codes for
reason set 1 so that one can have meaningful termination reasons and thus
better guest failure diagnosis.

While at it, change the sev_es_terminate() to accept the reason set
parameter.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  6 +++---
 arch/x86/include/asm/sev-common.h |  8 ++++++++
 arch/x86/kernel/sev-shared.c      | 11 ++++-------
 arch/x86/kernel/sev.c             |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c88d7e17a71a..06416113af22 100644
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
@@ -202,7 +202,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 static inline u64 rd_sev_status_msr(void)
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1b2fd32b42fe..94f0ea574049 100644
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
 
 /*
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ce987688bbc0..2abf8a7d75e5 100644
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
@@ -221,7 +218,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e6d316a01fdd..19ad09712902 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1337,7 +1337,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1385,7 +1385,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.25.1

