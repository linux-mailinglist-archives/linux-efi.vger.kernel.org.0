Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97944C326D
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiBXQ7t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiBXQ7R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:59:17 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC646E56A;
        Thu, 24 Feb 2022 08:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZULw7i/fHgdcdT69TZlXsDVPcSgq3GV6i4/0FJmy4XDkKN+/2FktkL+64845wZrQDhHJHErlnEF4IUpVO8lUAnl6BDiaq63G2pPb8/ftbjwSaIhcWP4xbH/UPU6ee1GBk9shhkAWUIvO1Wg6klzwvdcAgu601M2fymMTmZlMtP8/kdNrLVCuggz6KvCg9AVW5TV1wSg9H12w1eyNS7sisJfrTzrYcGFl3Pcs1Ycpt7noBBT/zO7P7Liq9bZxFbbMKu8P+gvhysbligmJ367HDSwsyU3SDi9rxKNoKNrt4zfjpWxhabfPXvm2AC87rZuF6iwX6HIZFnlHOhR4hsOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=F79TP5NnLCQGTGDSwqRy8s6kjtd7FwGOCgrFJkMjuao76NcOI8t6RiSk34F2lPFWuVbg3/2qh+EussLSR9sxMXUjvrMVMPd9X5pL9oNqY0fuGjmdMEWiCoChM2cE7naSwP2LoqTjwNB3sbYy3pnfzBw7pIYdirAKpOzG2DjeTtvUPM+3klPouTgkZnO6zm0FNMEQ7iEmyxICvSX0NB5CKtQkl4X+QtLBMMeN9SbGNH0jxj5bbZkb1Hs2B7xx4B6jhvSmRTrp8ft589AMteIRsPlc6c1q7ld6HJ/b70Cad9jdTB1CirEno0lfpt4nZzscZAxUKw49ZUnPnSFuR+AoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=YYesPDLtT8QL4RsJhJu3jYpJXuMGWrjsvP4dcK3OCFR4ERqW+XYWGiAkvd8L8zf0rOq/+krB/M4pBOChtZqRcQrBmhW7xYHl+T98PEZs4nqpAhNY7vtYSCGNmMY1ce4LAXkZNFzByRBrPngdMb1MCdQJdItj/EybjAjl0dn7eoI=
Received: from DM5PR13CA0046.namprd13.prod.outlook.com (2603:10b6:3:7b::32) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Thu, 24 Feb 2022 16:58:25 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::6f) by DM5PR13CA0046.outlook.office365.com
 (2603:10b6:3:7b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:14 -0600
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
Subject: [PATCH v11 13/45] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Thu, 24 Feb 2022 10:55:53 -0600
Message-ID: <20220224165625.2175020-14-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19ea9ab0-af96-4298-3aa6-08d9f7b6df2e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803A4BD1B73B457A243680EE53D9@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCvmEelXzUlxpkZtkLnXzrUCijIzO2NxblrwEXY2xSXyQZqRGKBX+7FleE6Jc0Wci9wc18yROaUIbm6uBtfIx60JqBiqvw4Sk1lqWTI+78/FzMwlbFThLKdgMilBxSOQVujUGZYBn+MGWj7xrblTO0EkZLUqy/B77QWkip7AT3R4bzDWN9dCo1Z6UKPJv1l3lG6RajY4sAOMNvBfPOWxQ1sjUozkEGf9X20CJ2ac/0NSoqCA0S3Ig40kMjkHsWmxsF1fTFkc+le2HYsu5M1LaManc/Mv66QYKCuHO2GBSt/EOeZ5kveL9iqct4LlA57UeKnAC/j5zyNv1qltb3l7XKEEmsM8IlZTWuIx14+brXEePFvIqdozfcoO6KRTHfFD8JhmnkncZXB27jMbJO0uY/iBDaZRMI06brwPW+iG3GZvrOS49UcIYUzIw7eBonyplxigEwPjmyT/0+n7er5u7tWJtyd93L3vVza4D0n/dMIyfCQW+/im/7IMNbXc6GVfcwJQ8yi4nOsNxKO+co1Zv7HNGkJHX5mjTNwj9fPqLouICGiNVfab/e8X0fwco+thLZWwyuXk6XiWqAFxdps9KVfrgUeZuGXav2jhz5oCe8WjEeS5YZBhFYY/4Ao1Z/s1uf9awaqrI4m6fg1uUCHr/h1kVT0aK58DDTgs7OoLiCSp4eW0Gx2n9guhpFgq6HUi9lb3ohlBelAhW4w6bOMD7DaMuACOLfiKC50UbB2Nck0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(8936002)(356005)(82310400004)(7696005)(110136005)(316002)(54906003)(40460700003)(2906002)(5660300002)(26005)(186003)(16526019)(336012)(426003)(47076005)(508600001)(1076003)(36860700001)(7416002)(7406005)(36756003)(70586007)(70206006)(81166007)(4326008)(2616005)(8676002)(44832011)(86362001)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:24.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ea9ab0-af96-4298-3aa6-08d9f7b6df2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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

