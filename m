Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC044CBB8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhKJWLk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:40 -0500
Received: from mail-dm3nam07on2078.outbound.protection.outlook.com ([40.107.95.78]:45761
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233785AbhKJWLL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1jo8fA6QuR5KM0tVnfn2JBf41wNwCQPZKYfNzmDEsigpp4jfQunHNcAO0dx0UR5U9kCR43Krqh22T5X40Roc7vMgkrj0xG0ICGIxdbMdJt2btne29OKNRZk2WoV9b2VA07+9OdkjYPAWWgNzCT1qzkrEYrqbu8GzPdo/G7c+rwDhlZ+t6unEb40Cudy0pEaeT/aOLDIySGKuA/ex37Ng6j4uaN6QZiBGm38ekhMLbfGWd4sbSuZxZrF+M4K9gt1w9TZFZp7aMaC9dttbo7S0Ybw7imV+sbJ4g4psAfDR3RQi7z5L5JaQ5M1g69OxOG0TPVk+V9bFf0BTGhggUWQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E27CZCHmAjOrojktVJgM8HaiFTkozVXgtHlrxMKFm2U=;
 b=bNCiVXOp8cW+f310ALAFBcQG5+9YRa6BKIgUkpmwzsYE32doZ5/PuY3RVU51jY1kuv28KCVmCtDXy67Q30+z0Yva5gLRhKrg8UNUveDd2fvzqcl/8rTKVZqXVc8kZEIRPDFyxYBjPholoBZZ30FS924QgMk1cI1FNMt0qRV73zZWOIxLrwA3dzXe3ewvHS/dKkJHRbyo3lKwCvZV5tfLqtoMkypYcvkVREWT5nhnrPUP20vQI48PjtHTluDg9hQRCnKqsX9Nq6o5X3WrbKgFPHPycm0Uk5oRWrcQB1G+zsmHlRBRav/yk8yMfUZ7dIf3/g6XhGB7+DftcApT+kLG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E27CZCHmAjOrojktVJgM8HaiFTkozVXgtHlrxMKFm2U=;
 b=Y95wc8kMI+FEYXZcTG/7EB+eD0yNHnE6wKiHYkKMOf0w0/8U6xazc24Co3Wq+3cf9LU2RY3H2HVtBaioiSOPJGaAQhLytSr8uIErobz7Gyqx+lSe0bHgAsKqiIOjI9X7UazoN8GqjymlHDr9fE8WAJYYhP7NqvO/9/UDt4+1/ac=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:20 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::52) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:11 -0600
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
Subject: [PATCH v7 12/45] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Wed, 10 Nov 2021 16:06:58 -0600
Message-ID: <20211110220731.2396491-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a2e8d22-9a47-4248-f715-08d9a4969b11
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42984284B1D1D4A0E8F9A5CAE5939@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KsQP/I+tiddUYpoj5bGqd6Cl0MFvvoJk9quBpWHcClaDqg5kSIDHv32/yg86WY3c6LjOd9QfcBrQpjoou+ebL7ZZnbIKu690v/7HxtfLjE8wpQHoPzbFhT68NHhonWLzEfYjfZDfmdDNSVHWdf2eNAgQE8/oOxEwRa0GVOhTb6CGhv2Fizqj1OTearcSzLkh9t0ss5dTf8hIqhBfolSyQ9j+GBaPPsYMYHhDxnFtzMmceaEPR6cMJOCMsA+a2+A2IGMg4bkdFfLHQCADzKDri3EKlwG8UUzPdWFqFtq0FdfSJQI84TiAbDx6lA2+HpN22YQ9GYyXLVcpsTJ9El6ou6rrRWT2GRNNf8rVfMUh7/1yL/VGQIExkzS6YhBTrDQJgWN64BPVJrpcXCqW4mMNs3XzYzx1ozfCmER84lZq+zp50EH0Ks9zyOfJxF6hwcMpemu4wEWOdsQ7yuYygHk4Exc4LF3288VtJ0IHViNxxE3GDLARKCSLi/mN7qc+K7lvTjAV4+nf13WPhTyCrO/38lkzY5fOsyIywDVNxEP3qKyECT/+WLSNUvemjf7od/S2omI0BPNZCwJvkTNsrGtyAJ61CBXYAVUkU634A45WpkBbAL8gxmEERL8tt6NMy/NXz1HVkLAEOlRrGHYQ64dBAlJeZo3kWK9yFI++UgQKWZ3iYT6YzlEyosoo17W8GM1lmI41FEfUlQywZ49W9mTlFffcRAsDl4V/+Z3TGWRovWdUggrMeu3KqEtOlvwwxsz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7696005)(6666004)(82310400003)(2616005)(316002)(356005)(8936002)(36860700001)(336012)(70206006)(83380400001)(86362001)(426003)(7406005)(36756003)(70586007)(47076005)(186003)(1076003)(4326008)(2906002)(44832011)(16526019)(81166007)(54906003)(110136005)(8676002)(5660300002)(508600001)(26005)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:20.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2e8d22-9a47-4248-f715-08d9a4969b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

