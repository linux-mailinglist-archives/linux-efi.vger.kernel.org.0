Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B433D427004
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhJHSHy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:54 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:59521
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240452AbhJHSHe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0VtxrepnswAZBp2RRXVchSsaD8wqyB8id5TZdB8Atk+7o50AqkHLuIpdIRmjoRWSHf6uhn4H/CfITui+uNXo4DseZggyTtSCHGSrzMUO6zKcLzxBa/tkUbVd7kGZ/Vq8AQkCf3QexQxaLgicIs+q+i/ITq36gpZZxOSElIdoaymV5tCvyAf0MqFpnAU7p0Ylc1zsFtUCAgXa8HL2b88NXhd2MWeGePQJT4zI8/6q8NTzRoPD3kyeGxyV+0m6jQrjPmnUosQ9T+LmnPQVveEZWgTeUbKW4aqM63ktaEeJLvBcoB0TetZo5PMmczC3zuC/ndYf6iv0xI320E6Ncr8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzoM49ApRDTVHBdvp0qrAbsYGN3GmceloQE57UUepyQ=;
 b=oFF3g/2HrPJzcnujfzJgxgACfUCZ+aXzasLb5vAReRrHew6Yc9AYEWUi8WuzQJ70Pk+UemdmhdkVR1Inx3n9ZLYSum1KRpW0JDFRgr9i/EjUkxnUPo8ijHJHgIuz9GUygC/tCVQhVq7P3JMkcjNjUEhPMAV/mGhfFPHl+dUDfvxSiajmeBYAzUZ3rERzZ609lFhqjLtn7uEQghlzapOmlL8MTA7hfURWrp+TCnFQuBwuM495G49AeVtzPzw+ctCEwgmynA/gbeDP7HTX8XnxOfxlfa+IICUyP43JvveV6hvmHua2O7hqbDHhSyDgOicK/ANbKSMota1BgndXaQQExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzoM49ApRDTVHBdvp0qrAbsYGN3GmceloQE57UUepyQ=;
 b=JrpB3V6tYxmWTowhBHv/DyMsPty37mbaFbrz7KoaizyUtMoczocYpHI45B+Ypgyd3VL5TrVgyEikvn2TNlwoq6jZA1nqzi75u56N/0o/+64GZRxoMDwa1SNLCDComVdRPbdeO+XAj4b8Zm/tik9gaG8vfrMlO6wNPpCky3ywroo=
Received: from MWHPR15CA0072.namprd15.prod.outlook.com (2603:10b6:301:4c::34)
 by BY5PR12MB3668.namprd12.prod.outlook.com (2603:10b6:a03:194::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:05:35 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::52) by MWHPR15CA0072.outlook.office365.com
 (2603:10b6:301:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:34 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:27 -0500
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
Subject: [PATCH v6 10/42] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Fri, 8 Oct 2021 13:04:21 -0500
Message-ID: <20211008180453.462291-11-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e40c6e2-dd18-4162-82df-08d98a8639b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR12MB366826B43BC52992B124585CE5B29@BY5PR12MB3668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uxe+LrwrUTTh5hbf0DpP3+c/Ey/vV+xUKu+HoXTrV7yqoHhKJFdooa6Vx53+0SWQyGgu7dAlWnv2xxzfTCu+KYCXiTf8+V6+pKgq93h+GvN20X3QwgovddwPTE7+Iz8LdT8xRodNACIFjCSX0f801WLy1SPQHv43CXnXmxX64PDXkJxO5RhtcYJJE8PvYfapzGCTWCcENoAU5DkBgV0SYPAZEQFda+dbiF6QdD3sxZPh5K1WfuhTXNqk3BUcZlMVPtUsdSwnSVvSEKKyRX3dIgg/M8bDrco3CSK0hUmhVKD8WvkCR7gD1dNwfJRzRQ4porgYfjX/KODXGceali8N0OZFz6SvwaZUoq74S4IpqnI24wtqJLKJqNS2g/Aj6CHEVmG0bdEi4bbDdfd4WMYMAsoa/LqPyzuMrDUb3YkmiMlaY2/Qlykv6llryUfyMD2/6GVKIz+7WnJAaKwF3RntFn/nNom5VrCuaUetRv+FRHCrrjQKguT9+1wGNrjsK5x07Oexaroy/PoCat3tnd+qERmNP71wpd3r++a62OMDVSo/Jv9/pe1ez/rg1unwi3fk7j/ydMTjPHZ+QFEJ3An8Hx1r0MVvLPFISh6qhy/0hf3lvYZ+d//NpypO9k6YLYUcnbwUvblUWZrEfaGaoVAs72+FYDbCTqKKOSlx+2wHz3mdnX//SLH+lzOifB8PFjMFANchgvGMo6cZ7vwuPj3XuS/s2W3Oq8p8PIHMOZ0Bad4UW3lj6VsvPIYJy2WO2582
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(81166007)(2906002)(356005)(70586007)(36756003)(7696005)(54906003)(5660300002)(1076003)(316002)(6666004)(83380400001)(44832011)(508600001)(7416002)(4326008)(47076005)(82310400003)(36860700001)(2616005)(336012)(86362001)(186003)(16526019)(26005)(8676002)(110136005)(426003)(8936002)(7406005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:34.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e40c6e2-dd18-4162-82df-08d98a8639b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3668
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

An SNP-active guest uses the PVALIDATE instruction to validate or
rescind the validation of a guest page’s RMP entry. Upon completion,
a return code is stored in EAX and rFLAGS bits are set based on the
return code. If the instruction completed successfully, the CF
indicates if the content of the RMP were changed or not.

See AMD APM Volume 3 for additional details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 134a7c9d91b6..b308815a2c01 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -59,6 +59,9 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* Software defined (when rFlags.CF = 1) */
+#define PVALIDATE_FAIL_NOUPDATE		255
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
@@ -81,12 +84,30 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
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

