Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB72D4AF940
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiBISMm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiBISMZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:12:25 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF25C05CBA5;
        Wed,  9 Feb 2022 10:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTK4MfKSxIpXLWxqMVxPXm3WGgz8ouiLNTrFGM0QsPRPOxcL6m0awsEzmTePbzAiPMvsWkpSG+ozuq6gF1LnYNfgr4a5yeW8Mx4mZ7RaIU2iLZko8S8JpWVxl5ms83Kp3nLhEyHgb6DaB7IFZKGfKPXI5KZ25ioZpjGLsue+hry/XyLeiO4uXgSgSHGD3KuOQ8sOjIsaYKRNXP8z9kphZx4kvBXYarFskcOX9TTo+SSrbq7RPAdCrbyiIFUWTmX7PgsldDKaXp7CDr7a2iMRPd0WVUNvubcTldN3+rIZC6wB8HGge/FF3wfDtm4QbVAzZJlnPhQ//hPE2VqzD3ENvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=Wg6sdcu2a6ziyGKprVrjjtrvhqdbHzePZgLASu2GBwUHVl5Wa6le1yQW76Eo5/m9igkccdOcLqKaV+3PB475vo0gpF/JdA+EnFywd3QDPcIxUYxzP+KiorsGE3xhv+2LWxobnhzhFRyGqKvzI/TjFc6/ul6PqCaYM2A8v3hQBJs4zP6xKRlx2NjaLhoX7c8t+4GUdhJryL9HS7fO7ZPPI8yzjvWGI+OdE7GnTg5LSyYlgJMuVhrKmVKSmlFPPUGrrFK24ui4elqQnxivLuoL/7r4NtWGKuTWbEz2gMc0WDPc9xggxRqPEGgwtU8kJk9vxBGkWCw7WEe/sxDPtCdT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=wDaC1W4Hi+pCHM/PUajKpLV2z06zevaUmAFKawNuqkW3vlXIOvQThOSow+VUJD+ZaTDLgP+Q0zdeLxA2zWlUtZdlmeZHIKUp82hOlBnJWo73pbCCAFT8/UZbPRFKfJnJ4S/xpRj8OODIQJ72xV4fXXvKT1cAddnx7HxPGUp0FcE=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:50 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::a3) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:49 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:47 -0600
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
Subject: [PATCH v10 13/45] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Wed, 9 Feb 2022 12:10:07 -0600
Message-ID: <20220209181039.1262882-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ec3cd1-fe9f-4920-130e-08d9ebf7a438
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35762420AC5AC266A6279256E52E9@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMP25WQMfF/qlza76jc6ZMLMtiTSI5w3b+P5PyExmc8VuaUdn3Q2+LbYsfkadqYOlkTYkhK9xdRIAIL11aFITyf5YV1M0M8wznSPgFnUysFWjoC6wJH/e8PJxaZKdU/oiwKasTqi1Q0ONBrCtn2JBZG6TMJ7AA/DRucYMt3IKh8bHlQEQ9cPCRe009FqVAvNwYX/J1zD/83Cfho36JNJgKC5P5ja3kL06OvHg1GNEWUiqqzA/N2gHpbBSeGPHbMZlctTekb8hHYZykzvd1e2Z6aoix2pVHwYhvpyswUA1ON1hFJx/YWYyIHnR1Xc6oJdoxu2ku6yIGt2g/8XXNFiUiRUbt14oZFy1DgXAYwqDYQBTPrGf/twDUwAhqSnQRXU7lVf4lFHYkcv+snaK87TeMB2Ftcgftij39YaO0qyjV2J1K0DPWkRHEVqhtVSHVyBYBIQ8+C8O/7obt2Lh3YrmFH2Sizsqebsq/CcqwT/SuiXQlI6PIJP3SnLjIRGNi4THcYuRXSPe7XKazNnmSZEiM+XgG7lK+dEYVNihKpZOHbXm2xhSvd2DpW/HUvCq4HIEaHs0IilVHEA7dgPDG4BkMlDgPr1J3TczX6A0CDyhh9bPLDQG9lbDNX8HRZGJ+89O8vHhWGh88nU06E7SZIVZYwMqHRr4mOg9f8whU+W/yURKrsQQ0rO4f4RYCkVAbiv2HaNNtl1+ML8/wG0icSAh6g/w0qZ0sXwaax0VQqLXcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(16526019)(83380400001)(36860700001)(316002)(44832011)(2906002)(336012)(86362001)(426003)(26005)(186003)(1076003)(54906003)(110136005)(47076005)(7696005)(508600001)(70206006)(6666004)(70586007)(40460700003)(8676002)(36756003)(4326008)(2616005)(356005)(82310400004)(8936002)(7416002)(7406005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:49.3442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ec3cd1-fe9f-4920-130e-08d9ebf7a438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

An SNP-active guest uses the PVALIDATE instruction to validate or
rescind the validation of a guest page’s RMP entry. Upon completion,
a return code is stored in EAX and rFLAGS bits are set based on the
return code. If the instruction completed successfully, the CF
indicates if the content of the RMP were changed or not.

See AMD APM Volume 3 for additional details.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 17b75f6ee11a..4ee98976aed8 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -60,6 +60,9 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* Software defined (when rFlags.CF = 1) */
+#define PVALIDATE_FAIL_NOUPDATE		255
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -87,12 +90,30 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
+{
+	bool no_rmpupdate;
+	int rc;
+
+	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
+		     CC_SET(c)
+		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
+		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
+		     : "memory", "cc");
+
+	if (no_rmpupdate)
+		return PVALIDATE_FAIL_NOUPDATE;
+
+	return rc;
+}
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 #endif
 
 #endif
-- 
2.25.1

