Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0F49FEF7
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiA1RSy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:54 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:27552
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350570AbiA1RSl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYiG+GRqpU7EWbpSOzGlYuHO+1Ku4V2I+kfU9EiMcKrLEzr7sUTiqwkHlcnqlinMxrNBszlXSDT09MxwEBf/lzY7rPWo9JUlKV+HrwmCMsA3kPOyTh0cLx7j/S3aU/8hSH34V2PAQj+YuR3pm19aY6uDJ+77yauDHB2v7trVyQgj5H25nCe9BiUImBpOk5DCawyvf89TZPir0FJSai1RinD8GYPVnS7N8aJAMG+Lpda89LcAKSPazWttYvy0/E+u4Am9Z/S2xBXLYdHMSewFokUQAiz4SaleuZ0nU5sKpl4uxIk0GN4iXPFK4yZvJWo7IxtuHecg5Ey1p1YrdQkMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=NfI1jK4tg6nMAJqVVTSDS6WaJkaiRmfSo5y7zkTDMuEa2HtnwmSYbJZIA+YgYnyFiwrFMrqdNTIfd6zQPchNaWZvPqvLXQCPKVjEuO622vf8sPlhZftx4THxY/LaOnR19UFxsyyaxdwlWr4mbTZlMC5lj+B3JQNKLDojZspR4YgsfAOo2SGzWwdyLt/2v6qT3KH8FhtQzGTVC867b8DzmAQs27D/QJX5vgSGwjecOkKY1hg4w90AvVEX4W2UDWFEWJeJxgHxnxLVEcRAirA/qc6S5suYkR30PEwxNQZO5HcGnohf5tiyPWhoolrZWlNpyq/fv5KeR/gdIq+haWQgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EdzBUimbYpu405EBQX1PwY6/2qORlwxpE2Jsb5Fnd4=;
 b=jnhsS8FuzKGGWOypapzTtmB4sixuzLrWM7ZtBxFyJJlGsAUq+xyso33UZXFrl7sivoFb2/6hcTYFVxmyZP/Ly/YAN9TYbsGdgicY4UqibfSSZeJee6KdqCpy+TEo1S9evmFprN8u7qHv+d7+yN4z8n7a700nTR8gV48Z/AXhpxM=
Received: from DM6PR02CA0105.namprd02.prod.outlook.com (2603:10b6:5:1f4::46)
 by MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 17:18:37 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::17) by DM6PR02CA0105.outlook.office365.com
 (2603:10b6:5:1f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:35 -0600
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
Subject: [PATCH v9 11/43] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Fri, 28 Jan 2022 11:17:32 -0600
Message-ID: <20220128171804.569796-12-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504a7f1f-cd85-4e15-5fbc-08d9e28238c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3167:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31676F9E77D98571E8373E47E5229@MN2PR12MB3167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3z41JAvh1N3L/4NOKOW8TAN3Le9hwB2ya9xhSfqMelRbjVyFovW7deGLP+BIfckCTCGErrlSLg5zDJYGviyJ7xxxi7RkO8D+/ISKhjfQruwe2eF8M6gkdqYLuSzYwldWbTgJBig6xDSeoOupduqasyZGDg5BfdnXQhKp+R9B0dWPVRuoDmQtzrT/TjYWs5w458v6ThyIQ54GcrmBCKlNRe6/Hd7nl33jh5Xfd21Zzb+On0i/It/41BW6aav/kixjON7lHj6HSPlVuW0S1zG5GcUyYnk6QwbuhvWRGoGEgnfTGQzUFrvRrgsTXqZO1xdIB2R61d8f2E/kMM8Ub4mq6i9l+EB87Zs31q2WGx2Dg8etym3DccUnsZ6SAziO07GDyDWlSyr0FP0TPy6HkhZSA2LebXCK4G/GWenOKNlxdsaCLcIRDFMa73hbo52DF0scAjYv5XDObK5BNzJGdURCur8Av174mobHkJkG2dseowmLP78z7hkHqpX8P4Aa+nDSLcK6JVA4VnBEusISkDSoD3z24cGYDueLiErbZ1hjDpYBVQJpWpj69ka62s/rkLMWSU7OohX4sdQnuDRoe4o94hCtjt435LfJfUb3DTXGWrFqxRM4RInINFJIjn1oMKedHwdPglY6Tgz3yOZLtMT7MialiR+P/HwI3/wMSa4G7y9yZP2l7JrFqXcjzUse3r5UKyIGgR5z47wn3mamQde2f+W702GL5OXQxKRNoP/YnQGOabtiZsRUdNdGjeTkyQVQp1rQ+KSwAkke5VmfpVMkE/TnH4qAUl8WokNyFDCzqwJ98f5mTj1y3x+eLZHqs5V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(47076005)(16526019)(426003)(83380400001)(7696005)(4326008)(508600001)(6666004)(7416002)(26005)(186003)(2616005)(110136005)(86362001)(5660300002)(8936002)(54906003)(36860700001)(70586007)(70206006)(44832011)(336012)(316002)(81166007)(356005)(1076003)(8676002)(36756003)(40460700003)(7406005)(82310400004)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:37.4823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504a7f1f-cd85-4e15-5fbc-08d9e28238c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
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

