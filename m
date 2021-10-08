Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96249426FE3
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhJHSHR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:17 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:32481
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238780AbhJHSHP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0hXifAr7xr633fHje6oV7hpFPniOI2O0KpOzjc13Bg94L0smIbsja4hclUHuz3g1kjA0x7/J/Iyjhy6Hq/RXADo13qv2m+OQeRBGB/bWvs6zWVuAs41U7aRtP7h2Q21eDpK92MMNnVrAV9iSekIPxHKkzU2C2rYCdzYWwxsTPomtGISMjUKZj0aYUxpyjX/PRq/twKdJ8yxdgR5nVtxCNKdpTZUvD3sT2vyVDrFnHJKwDtSU8gSsMUK+cZ6YoZqxo3aAbTl5nvh1hc9eC3lC8hbSusMqFfpelxM9gd2X6eijE3kjoK69bWTi+R5BvvAJtfr5y643Fx/wHDbGmxyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cta1Fn1G2dYNvWGluLCsPeb+TsLD1MsudLayOwc6114=;
 b=cFfGL51IEz8+tUXdxYmosq3Q8RPRXWWJ6CvNH96pFr5+rsriDRpYv4Q9hBOBeyq5zGhCMDVBDSOJeAy8r1nCG0gLMoxsfgH6kGI3NTGziCf1UOhHSq27FUPi7b6uZYmNHP82tekSsD8poEceOKbrw2lzMGzRsLyJMkmApuvYnN5F9k5D9hKwT9Z77L+GOacJoDk/Qh4kG8to1GCkxX8C+RGLoBwsJfy2LqIRWMVe+fQ64/EGU9dVY7i0GzSPD/HG0TymIGwvRI7EnocGrg2ocnVNsV6hfbmZB2M+IF2jXud1+y0nStSOgQs3CYnsXdScy27uSsfxEJFrkWIRAaD/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cta1Fn1G2dYNvWGluLCsPeb+TsLD1MsudLayOwc6114=;
 b=DaO/LIn65FDzBhSBMMJ2GptGO35qgE9jQLucYaDS4Qv968zioe99EbILYdjJofP8T2X1tGCrsbq5mELwX/6Hl8qlFGkNrnFz6qNXdPIbiyDo30kXI1MNem7/DTUBMOECYsIxG6naWWuTIKe8C5KgA9DDVQUIBnFmGK2I1Ab4wg4=
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by MN2PR12MB3374.namprd12.prod.outlook.com (2603:10b6:208:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:05:15 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8d) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:15 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:13 -0500
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        "Borislav Petkov" <bp@suse.de>
Subject: [PATCH v6 02/42] x86/sev: Shorten GHCB terminate macro names
Date:   Fri, 8 Oct 2021 13:04:13 -0500
Message-ID: <20211008180453.462291-3-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3b1c6f1-87a1-40d0-b44f-08d98a862e46
X-MS-TrafficTypeDiagnostic: MN2PR12MB3374:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3374A3271FDE81346AB3A004E5B29@MN2PR12MB3374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRPZEvmWlBz3/pdVt2GjV3C1J2kdwUn2b6AZUJT2RCBbi8hke3znAPCa7kWkyRKPqxNbHaL+WQRoyBcvWxJS+zeYnnsUguYn/pulum5FqcEOj3CiSYiMk6ldTYNvhMMkpUe3AeAGLwMSXNLekeCdG5qxB2Zr9GJQUTA+xGqjPJOh3lk2WcASbg6vrMfrFUnSEB9qX+uicEHkOrzAz/gt/Q/mncExVAJo78Nsew3o7J9ji3cAMqVT7cDt7wRLLdYIUk8RBw/yBVu0Y6AwM4rmm3yGc4sxaz1VvNIUvxAUgun7ZwXNKXZ6egWhoNCsen7lkT+udd9wYTGW7UXvHxNg4MB/mf7hTTpRFYUZwhzLl/4iuYnUXPVDV1FC1r83O137nsFDLGXkXWjbONcQGn6HdM5uyWZJJ6qRt4Zlybqo1O0ebCCiT1sdSRPsXZEJOk+3165rIrPpfHEks6Yp36hPyjGb9Kx+DaiG0upYOwQXQMtZnKjBZCMkrmssFAHCQHVp1ZVpSvRDdYEugMPhM8D8/AduIRiPYVJRl3WEwjod4ZELiJ8aDyZjApoIOOY6EjIRfenMQTnILVij2Il8w3W4ajCThyBJ38yUCDNk2Zvrv+KPI+fRvQ89t0V5IMyh+hh8ZyvF/xfiOXWLnj96hm1j5fvarNfg885s1sJpGhtl9tKQBSRfo0Ql/jehS3YAW1S36Jp4T4KDR5nnxfFBS/WUhdGDUt8TtR29HhDPNlxqkroOthgS8vKdBZ/r7q8Ni/77
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(110136005)(86362001)(5660300002)(2906002)(316002)(16526019)(82310400003)(2616005)(186003)(426003)(26005)(7416002)(7406005)(336012)(508600001)(1076003)(8676002)(8936002)(7696005)(70206006)(70586007)(4326008)(44832011)(36860700001)(36756003)(356005)(81166007)(47076005)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:15.4853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b1c6f1-87a1-40d0-b44f-08d98a862e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3374
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 6 +++---
 arch/x86/include/asm/sev-common.h | 4 ++--
 arch/x86/kernel/sev-shared.c      | 2 +-
 arch/x86/kernel/sev.c             | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 670e998fe930..28bcf04c022e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
+		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 2cef6c5a52c2..855b0ec9c4e8 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -68,8 +68,8 @@
 	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
 	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
 
-#define GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
-#define GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
+#define GHCB_SEV_ES_GEN_REQ		0
+#define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ff1e82ff52d9..007bc25d265c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -210,7 +210,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4d0d1c2b65e1..9b3b41a7844f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1397,7 +1397,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1445,7 +1445,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.25.1

