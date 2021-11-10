Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA544CBA3
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhKJWLC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:02 -0500
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:21920
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233592AbhKJWKx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7W7w69U1nnJIU43om0KMLjBo9JavYIfWo0l2eIc1AOoGteJqWuwtr7LvuyxPfBa+VHbnFFtJvK/rWhU5Mh+8g9CkhO8vJIka0ZtRSmKGENAdeCoXKmFrevUyxA5LYAicnGLEu2ka3vP8dFPX87XQHNfZvXrKNZUmRMEYbAknPWwfvp0GCGagoHCr/ce4fzXZvSSvOtxHxEyl65DJuSlismGlNGWp1J4gA+cGHEYbu3PwDjHI+HlBhB1t81FqPW6D926yaTDBr58GMmB0PohPauB3q9bl5fs8lu8ECw0r9bZ0oDsgna3FxnY6hodD19OyrgPrjL8EuaQ/92rIbt6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j+qK2q5w0RYZchzZROMnIvIi0Oc7+QfDvEAR9a+BoU=;
 b=lISyewayvHWEQ4hYsO4UgsyjjOnSXhRAIYHfCRZTpoDHwk2oM6wP5ercDaX9Ps9iyBTMf8ja9jXRVTQJcK3ohgZLtgyH4OJlm35rAWAFI9yRrDPm2/X5GBQo/XqKOsbGRptDqGfb+ulXDz1tdPiWPgSRJcrvIRmQjXV6x4HfXafZVYThdKhl/f/nf/5jSUOCRWSDp3HLsRXMADO1sMiffeEAYvArGn7rK9fz8zKHJWBnwEw2UKf5HYpM5BnND8hIwT59ussmBr/VIFCdI9dcF6cpWI7G0CcRjWL2P0v4pjfQgFdWXQvj6x60kv36c1JvabdjcrIEx2osa85fHWxJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j+qK2q5w0RYZchzZROMnIvIi0Oc7+QfDvEAR9a+BoU=;
 b=Y9amqIJHUeHjM7GLyp4p3ZoUkKfGsZqdXgIeZIMKrrt009oT9DNRNQ47fXQPi0EK/CUgzr3XND4kJb+powtuGTSSsbLkefXzzdsJZLLo7p/8vxC5589OLK4HWSzVBwzX1IgMAtAsTKeVIZLs0zWGfqSS5WDg9dQZCRBttZccv+U=
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:00 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::f8) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:07:59 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:07:57 -0600
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
Subject: [PATCH v7 04/45] x86/sev: Shorten GHCB terminate macro names
Date:   Wed, 10 Nov 2021 16:06:50 -0600
Message-ID: <20211110220731.2396491-5-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a692e087-6ea7-4702-971a-08d9a4968efb
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571B089035142ADD471F0A7E5939@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvqajCaF1cWCsC5pcf+1uWo3G8uO2UKRDuzlj9fXhf1YdaBAUnlA9xVSSClJnkL/ePjvgOhyaGddk/iswxaFY+xqti9aPaWTLn4wbxJnA8/O7O22qtg/JNP13LWrpYIGVFQxIZ0hh7fhzDPuz9G3ueKq31dUFea448EJkJ7T3ZbAy4JG4qws5mxZZBmOf/Yu4i7juoFTzl4aVbyAp5yx24cZXbCFk1ScDmhu+iwKd+J6844JSGv1m6LdGo/cxbDLhnH56qDwZXCdT88N2U28MNQAWJI4CKnDPbzB/xkbHqulQxVzPx13ZlXQw40BMx9RFJKYMx6fHFyxodcgiOWFMfUjIZdXVlxut1VZQbKGEMn6aPQZKxf7XrlZI30xaWY0Ma+R3XZqSmlXDHYnvNVCj1FalZap/DVKQoZlgZB7lQW6EhanvBxRbcDeCUVswyUeEWckFz89s3wrTtHzKoZExcgKPIkKKMrVbT7+Gz5CadvV6cR9atov3mh8KTbTGgDtieyt1lNFWb5TsHV2h+p9pQcna8ZLa+k/bsDF+kBEyWJnLkeYPvCax7VvHwQNpC6jPIRaRSP1Pp5x8Uo+wH5Ss+WtNyyD+YRiBYv/mRlJXW3nPcNYAf2zlGKH1of4bUl7+wMZQ49FaZ16GSyEFcGLeYu7ktj3ytE9CHGnZ2LNClnos6Hd3pCbbEAaqpbMGaxv3ywa2tUONaFKoIOg6sssl5lY6c+sXVVON3mAu9FXr9LL4wKnHhxFQDzoADkaswSW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(186003)(7406005)(2906002)(26005)(47076005)(508600001)(8676002)(7696005)(4326008)(83380400001)(5660300002)(86362001)(36756003)(70586007)(16526019)(356005)(70206006)(81166007)(110136005)(8936002)(36860700001)(6666004)(426003)(44832011)(54906003)(2616005)(316002)(82310400003)(336012)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:07:59.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a692e087-6ea7-4702-971a-08d9a4968efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Shorten macro names for improved readability.

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
index c91ad835b78e..8c6410014d22 100644
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
@@ -202,7 +202,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static inline u64 rd_sev_status_msr(void)
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
index 787dc5f568b5..ce987688bbc0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -221,7 +221,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 74f0ec955384..0a6c82e060e0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1411,7 +1411,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1459,7 +1459,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.25.1

