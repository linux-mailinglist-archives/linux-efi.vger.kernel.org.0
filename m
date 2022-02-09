Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355C84AF93E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiBISL6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiBISLo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:44 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB220C05CB86;
        Wed,  9 Feb 2022 10:11:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcuFk6c4DMSKqibGuUFYCBNBLmA/J3Cm6803nOwynWaOgSJyqE/cuUkTXAlSnUImX/40S7c9K3qArYmIAg2hn1H1XhpGbMZXCvTKk7w476g24A1hd4EnAzAmwOlJkiPw3/X6/Mac/Vrls07/5bocT1WbpJD1DyFSKoJsVKa2w+sEAjGvji7svFa9Dz4Nyf6ztIrqoYspDQP4fWp1SPAfRHO3YV14Unxp4G2MIapP6V61G8A06iG2z/HHFm5cgYqlds6b5VisP+zacSB1DJbiDi5lojNF+ZiqUZhbAAoJpKtnzVi1XogGa8kxmWTZKQWce5zF616GEU0r5ZmyEbfIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr2T/8s0dUJUESqIixlG4xS0bbbyqCnQ0Jm3Am6Zgpk=;
 b=IlsaP/Isl39dpZ3n1ul6nFVJNnZsUPqyG3jb7tvTkcq3fFsc4QJUs6GygFbmDy6VT4tbupKTZjU997mFOVcq+NfNomeq35LiUfJ7h0xhwWf7xaxBd9SmvldN0qxfcWbZPdf85vmyiEUNhufym0vAbNPeTe0tUooHcSKA4gq6180oqR7lfJozoDFdk0dtyWGJkj2F6lUFFZvIZYbMAmbRhXybEgoAVWUWYxBr/wXwc0ona8C+FubRy3PGOqv1cZsWWo/YSfxxWIJhjlB1jdKUfFpW/F3Q/IHS/tV27m+cc/yEfNWJuoFEfSoH9q4LjPOpCJwFIxLoKv1eplvUO33WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr2T/8s0dUJUESqIixlG4xS0bbbyqCnQ0Jm3Am6Zgpk=;
 b=qnZpCziHdlX904tfRecgrrIjWMQC3O6LCIVDSFvtvVFXWnoog5RsB1yb3KCtm6l4jdIUSdMxd4ZkMta2Df0sQOJrg/12GwOpR8TeAtd/bIzNhQKcaBWnO3+Bn8HBDYY1kRlepqJLiugy0TkFTO0mtF7KAVzJ1AIoWqdAcS2bvMQ=
Received: from BN6PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:404:b4::17) by DM4PR12MB5118.namprd12.prod.outlook.com
 (2603:10b6:5:391::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:44 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::f3) by BN6PR2001CA0007.outlook.office365.com
 (2603:10b6:404:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:44 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:41 -0600
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
Subject: [PATCH v10 10/45] x86/sev: Define the Linux specific guest termination reasons
Date:   Wed, 9 Feb 2022 12:10:04 -0600
Message-ID: <20220209181039.1262882-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ca5188-17c6-46a3-7cc6-08d9ebf7a163
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5118DF3D5D77703F5FA67E5AE52E9@DM4PR12MB5118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hYWzfUc+12FwCHn3bKBDIpSYOyA+j8+0k5wqp30DYDJ05jBrG/XJn29v5+Rjk4LIg/jSpBjHTIanwOeNceXvw0qq8yxxngR5/luhV3OcaHv0YNStJbbwSbYdOJuf45Su+nyzmdcwL2B5KhQ8GSxtStvX0GjQ1tTZhVnZDW60U9sZhhi0lu/hSa4zjo4/zDs7IoI5yxb9TeVeE4O7lvygLtphyFJZZjDtD399HuSqdhDrrnrl10KJ7nLAaK+TkURPIBRccYd60V/5KcjOmn0BQqqMGJQ7866nDhCmsA4Vp2U7MeQmHEzDXe5QLUbxmt0biXzds/XbtGyFgVHLbrj7bb/D4bnd3OZfAFx7LkV6NLEfSHpOjKRU3Bqgk5pXR6ZZgi40t2B7EEyzx9VTDsvXKK4qrXCVhzyPyIGR6d6GN1Nw5kla3ZX8uRxXsKKe34eWKZSdJ4Jlaum+UgHTBPJ1/Lw2IpwFqoHVq4F14pQ5SPatAV6vdh2FQU5+uYiaDl1xvOv1a/BVW0W9r9uc6CUa1FiZp+7mTm1PZN1f97Fax8AXICXchX7j/EeDlIwjoyhfwe7thk3Z82wsHSySJBpCIHWU0nr5cDYjEBLU8QRUxpGnKrFVc+HVHGssIAAkjtbSz8mNdYNtPj9Oi6XeGJhHPPQXFngLFvdDm75o2byrmK+HLWiKkbFj87q8rYZg39im3PadzXDPki0/7HduWTQhbMkTOIB9TBwdKPFZktQjRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7406005)(2906002)(83380400001)(7696005)(16526019)(4326008)(26005)(6666004)(44832011)(2616005)(36756003)(336012)(70586007)(426003)(8936002)(70206006)(7416002)(54906003)(8676002)(186003)(5660300002)(316002)(508600001)(86362001)(1076003)(110136005)(356005)(81166007)(40460700003)(36860700001)(82310400004)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:44.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ca5188-17c6-46a3-7cc6-08d9ebf7a163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 27ccd5a5ff60..56e941d5e092 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,7 +119,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -172,7 +172,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -199,7 +199,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 void sev_enable(struct boot_params *bp)
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

