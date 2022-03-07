Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF04D099C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiCGVg2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbiCGVgE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:36:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3E76662;
        Mon,  7 Mar 2022 13:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwTNhgsxDhw4CC0F9441JfSeiXRujHYBR0cj+JqiGFRx7nkGXMRjeXYB1LEhn4bsajkCJMIT9DK2U0qfWNB5e5BxH5YURZGlQcyCLZttKWotT6Y/5KRejHwMRsVj1tQBVt3WUzKAUg2QyC4929TdCK24mVtGm0ixfP+6GCYqYOvpId4xZHCVN8k8uVupRXaEYLajf27aN+KYEF+/L4A7kfbVWomOlDDqXehYBg7ZSryezc0FuX+1QiglnavB2fssm4olwHyyZf4f2cc3x+XcVkiCFPd1Nt+8SCk0IbrnhbKbpLinSCXuLGGBuG8RXtlygFIt8OlK2KePI4dDkZ58+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=JWXIdBqeBic2XAYukZeO3psXRbqlFlIWfNfjr/eE0HxOCnAnkMgVKFOi3xeBxQvkCS6pFnL0UKtRFKLUqHbwVXc+hyRcQAuMb4H9vQ+7DLaYIzGNM5l7H1F3AhfyZLM5CWlF059UWE/w+/8+fAm79fXGZ0/4uMN/z5qcTt+dUXQz1UQQewq608g7UiWbGkE0VS0a5kKY6ZM56wrc0pzcjmeoIEfOzuI74rMHClG37VkTaj12SQX1mrxnjo8vO3TOErAmNDZWYgl+ZU+/wu5bIPL5oxwrej7ITyxc8ZXqht1cYVnv80DVbwB5IzFVq4J1zaQ7B4EdxQxUVUsa5V+Iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=lefrBL3cYJsy1/U7mCt+Ya18TMhgvWpklkvCKrrYpatwn3eB+MfEXp8nJazZEf5TfNbmMx5JEW3wE9NDOpj25/j0jwzAsjcqhZfiDHamKE/oJgdnR/sDG9A6hpfu2t2cRYnpQ02Li6GOgvSVqJfN4mpfl/kTN1kjsEz5eKNx5hE=
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:50 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::a4) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:49 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:39 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v12 13/46] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Mon, 7 Mar 2022 15:33:23 -0600
Message-ID: <20220307213356.2797205-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326d79aa-2202-4d2a-b9d3-08da00824ed9
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5612:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB56125D023ACBD2ACBB0D5AABE5089@SJ0PR12MB5612.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8KgShcnf19nnYv/45+dbrIbuXiLyqJasQqGWz9xGyzcq2+GBWFeMiI66MJwftThRjUBnGdqJqvtau1+n5lMQzd+S2tQ76W8sUtQBOJnjDYPh6QSV7FGRiDYebgvQy5X852fMVUZ/YcQ/hj7CWdfjAymvh7d/j9bPSZ0oXg47uTEQGWbfGLY6aqTENJ5BU0F+oIlXGcl0vGcHUcAQRqC+56IqkelkWUze+2ExceCGka9qHYbOQhYPYTK8T7V3cbwaWMTvcBguQlv5foEWSk1v+A8hf8GUHpAOX4rc/Nwee8cmEV5Rjh2SzuLqTQq/z7U2I3GVODHauV66mmZBHJpn3K4XfY52d5vEaOxx4se7Ag0OC5UbmE35J5abB3FVYGRt3yQ1KTgPH8jBL8fO9gPT1CP2qME3YbX1V/hAy0dZr5qZ+mHhY5XMNsCN5pQuO/tsu18xeagBQLoeTTNxnBdzUs/J6oEXwmIJ2n9w9tq0YRTgdLafIW1YRErLHCJVqk8DrN7eoPL2y/65dVz+j2qhaxOvAitB+RUASyD7/oCBW6vyNrGbijcpXVd3sv4OijrL6sHVfP0F9QcA+ZrHy/SwtngBqSN6yi38LtWUNvAdr+Jgtl8wMKpW+QXdtSqPIyS6glaZVYB7bqtmoU8pBmD2BDdUmsGT6A0rnPNgX0+KXBJOJU+ART4trZLnAUtsLQduBCvaX2coWXSkm2INc7IgQd+aDVAily8X4gdec+PlaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(4326008)(8676002)(6666004)(508600001)(356005)(316002)(36860700001)(54906003)(70206006)(36756003)(110136005)(70586007)(2616005)(47076005)(7416002)(82310400004)(8936002)(5660300002)(1076003)(86362001)(7406005)(2906002)(16526019)(26005)(7696005)(44832011)(186003)(336012)(40460700003)(426003)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:49.4361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326d79aa-2202-4d2a-b9d3-08da00824ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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

