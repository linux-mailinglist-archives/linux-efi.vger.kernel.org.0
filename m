Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5FA47043E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbhLJPro (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:44 -0500
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:37601
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239677AbhLJPrg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEb/eRuyR6G/GS6994NLv+GVMWVO9kr/kjPtk4w1+Mu4Xp6lx/WxDRJm8vb4aKbvoQv1OKeqo+d55fDrx4Ubit5asOdWtnMtoKE6Bx+jQaZiBGbvugfyX6jwI52ABQB29+JpFcNgqOTJduXUg8y/5LJs9GHxB+k2bJ5F9szxP3woXu2xtZxenR4/4rGDZOzxSz/22YNTqqBqk03xZInTYOSypIBb7Irvnzi2iAgp/sKhy6ZxpN0iLDx4lB6NLCzbmPKY34BsB5s1qL8XY0I8NGUVkV90vgX8kGNMF+gaHGhMbme2QF0oI0OAJfjO74GdZJTxcS8nFS44J0zxgfJBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZi7OzEEDHI+tB2+hmVlBSnhZxbE2E62O7gfkuX+9es=;
 b=Xl8f/fxdTQ8VzajnjIzqykRsB2F/3YhV3B6RANG31GRZD0ljbJq0Y7I1Sh91f9JMqnUUXfiaqNcz8QY83IB+kbXSjTgNsLUdvHhr2S+L41ZpZu217XW/mpJP95mT2MgZQWJ5R0KT8ZGx6hdn9la0WmvBuAG6YKtbeYts5lkXBiXqrbYS5aerOfqMbrOl8tXWPbT0KynZcHEY437C5pu1M5jSST6ahn3xvXFLvq0hDgDX5DUl2mup4O8Ait+VAB5bp75s6Iu4P6tAXP7pamMJF8npLDlAhq1JCmI+NxzPMZGWzP3vKY48+jI1CW1aN8/zkpFoSsHIBzaXRLYamFua/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZi7OzEEDHI+tB2+hmVlBSnhZxbE2E62O7gfkuX+9es=;
 b=ZP3jXE0BfwHykzlEAZ5mBfd/nRE2ihNEr3Os92AP/+bis7+fsJSYBHJ79qMtSi92/AEvi4+cX18pAkC+GkLy4vfcSsu3jb30QHmmvCGsdmcjjkzF7V79/9bNeW9EGY9iLeu1FedaK71nOnYccPFIM/6NuX8GDts+yIyGUjx/xOQ=
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:43:56 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::66) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 15:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:43:56 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:53 -0600
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
Subject: [PATCH v8 04/40] x86/sev: Define the Linux specific guest termination reasons
Date:   Fri, 10 Dec 2021 09:42:56 -0600
Message-ID: <20211210154332.11526-5-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8bebc922-27ef-4e88-5d86-08d9bbf3e02b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB175049962252B4C1CAD1539BE5719@CY4PR12MB1750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kJPxgw5kGxa5P7MNWHmEowBq1o54o4oW70trQtjzGQiM0jAzv1xisLhjTTw5hTg0+ACzupcTMJ6HCuQ2zDYON6VpVhyR9+hPpdYLpFQLr/VIjqWyqKB+AFhlDEYuPuQwYGnpfIX4HJctq2WjROrFxZzl4VoEe5xHv2bnF3viOE5MXYeFavi0vg1dTRirPih/JA2EHOaPCi+pveHXwcApKsQ3mclDNmdvKU2jFp+Hps7JLkD/7j1mmjoGQ8BybUuKW1yOUAKLmQdF/LHIABLdwS5bhTbkANlJ6JUpENx2xFwwMmVCDr1xU4P1VuTqd3cxAbaBN/0ERi7QSryl1wuJsBhBKqQpm6iN0RlAelLWEJAEagWXqqN+D6tRBY6DB1C1iQ3+9VuB1W/Pi1IYKZjyI5eCylbWEducPrt+hvqrkMQo732h+2w3m2TFbHh1zqe69qKTmf4hWebGSyO+aCNn+5BdsmJA/osBmIY2cnq3ophjjWHoqUCIdfa2zV+KRZk1sOn+VY40WmcCfMiZMqb4nRbqC43owg5sCmemI8WcTY11wa7mUWFCAWNWImhTdjYueSndwSwkP7IXwC4OC0sr8sIkjJiDyOaGEffOvQ3VboEsgAjpHET8w/LTm6Ve9X68pD8+ULp3tpGq3me5w3MpL43VoYvmcomdsF+w46by9pkDTE3tKy1ycRP8pVAHU21mFdOi7trRqQwfQmcCRABndDAc3oXGI3qCe8JQY5kjvcX1o0178PywGz8y9nriMaHbTNhmqx0J9T/dT+nRqDWbxHnk3CS4xbXAyp/jCb/kgoHWX2HEgFEVQhgN0Nvvzur
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(2906002)(7406005)(26005)(44832011)(36756003)(47076005)(2616005)(336012)(83380400001)(7416002)(82310400004)(40460700001)(86362001)(356005)(36860700001)(508600001)(81166007)(7696005)(16526019)(110136005)(5660300002)(70586007)(70206006)(316002)(426003)(4326008)(8936002)(54906003)(186003)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:43:56.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bebc922-27ef-4e88-5d86-08d9bbf3e02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
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
index 8eebdf589a90..0b6cc6402ac1 100644
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

