Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975EC4704D0
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbhLJPum (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:50:42 -0500
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:63072
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239918AbhLJPrh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlYYhgzs4Xk9UuTxgq+RGYYmCZD3yjLHTtb/5BfD2yft+f/3SXr61/SVagaT8ErLHxKYT48qOAf9YNo+QQhar19FRAvKOTlQlK/canStmliBP3/mJ0dSMIevGjPNgSG/gSsZQKH7AKXuy7pKWwK9xyNwV+f2UZnwMUiT6BbTjvnZNbX6+BX6adyA5jnft2kgh2i+J0WdUw6yd+gFajQ4O7FfoYVMel1nLrbRihDd2i3xibbl56BmsziMzbTiqDI0WDnilp0aBBx8PmbbdDokFRSB05RG/L8vH4i2klLgEbc4uZy7R4BWzZaD1Q0ZStOPFMdoUDokKhDaRk4iCR+cWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E27CZCHmAjOrojktVJgM8HaiFTkozVXgtHlrxMKFm2U=;
 b=d1xPtlkUuVPzhPqRrh/IVlit+SxKF1Js3SdMPY6DOvUZaIo6PAU/MFYrR/B2DTHITMXVdE1F9TPnFSkxbkXgiLv0jleDIzV36//jUzhNj7ZoHIiXh1sc+4VsN+1ZIQG84j0f7gt/Vm68nPg4ehesE4wJ2AI1tzc8gBqSEjQrQxGCi82nSr32Dq+xG7d6a9Xp+3bHX0q17vo7suxdPsIqbdSc01Fw1ix+WoIePmH2fsY8Dv2jLRyYha0DUkTVrxNt84J1+FLgL5YoP0L/oT3mjgvE3i2iPOK4Yf5GeAChnPTfTZoqEIsKQA85BLGIazhUZDa2TbarTc+uBmzrMIMLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E27CZCHmAjOrojktVJgM8HaiFTkozVXgtHlrxMKFm2U=;
 b=QsEws0RvUNJPotHybCVGGCMyHBoeGEIv9/Zw5GuahZcEMFbKp9xOZzdRQVGmJupf8kaGZvpNAi0t15AC4Bmap0Vo7/Nk49Hs4W3jle33qrmxD3j10/VIVgxta/8A0+4wpJlu95U0Rh/tBjgz9dR9thdxOoJdNUqZmqwzWfGEqVg=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 10 Dec
 2021 15:44:01 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::6) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:00 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:43:58 -0600
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
Subject: [PATCH v8 07/40] x86/sev: Add a helper for the PVALIDATE instruction
Date:   Fri, 10 Dec 2021 09:42:59 -0600
Message-ID: <20211210154332.11526-8-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62af3dcb-2b5c-4e22-3807-08d9bbf3e2f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3788:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3788C4858392E6AF666F040FE5719@DM6PR12MB3788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5zX6w8SKAC5uhkFQr7l0/jCKBbHgsPokGZrf07IgoyolKjuU21CUAJRDpnsr+Ah9wEgcvByqMw83i0lQ3ul2iAb0KjampkElNCDs9MFuSZHONRlpJfcg27O1cN6KgbDND+aSXSqkzozD9yBOMjr/IQD+A30QW00RNWzqyYyJ2nFctWTZzLa4J1Lys35fYaWlMEFHWvRE8QF6AspDWvwFl0qmAHNzfymuBsWoyCO1egyEqHVOUeKxxSUQDBCT5ZTwPV2wt2hq3uZPDn30xDvSQrP4Bf2dMUy7B+PVBrDzlq/qpjpEN1Ofn4iiG7q94VrxVSVhouxkWFZ2SssAv4NlfPL04oZpm+1oO4/QvuCeIf4Yvh5F0sO4N1O++muNtft9bcuPv9OW19PRjm9/YIw4B6CEydGuOlgOQJRVBa42+E4tcbI4M42cqcNYQev6XTV1g8zZ/xUZ73E2pnugziS49glghtr7Jdyjf0rwEFntRSwXZ9g3Wd6Jmh+P6nKf31+PFxOQCQVZGfio6Ddny03rFBqyRRfa94Yd8/AuFfIRK0PUFQ3P30nDbWlsYJiJ2//m2zB0+ZQPpwFgGIyoky5bJ5gf/Kc1nm6bwStiWX/hghSqlpPsT8aVb0FXuLh5iQdeqKWYxqr2gQx1OnYvcK4rpJgZbgFtbZAwIOyPvI/uq+l5XLywwTr97Vdzqh1R0D7BoSx4sPqY6ZvRa6KZ2dhPTarCQCnzxL4IECLyE/crmVydl6pgIy0nzw+oxAvb8mXrEmfIHAyfEs6usXtUETRnM72joJmIzJ2NbcNAMKWD4xmg+NPe+xRybEkWal5LLg4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(82310400004)(8936002)(26005)(81166007)(8676002)(7696005)(2906002)(508600001)(7406005)(44832011)(70586007)(2616005)(70206006)(7416002)(1076003)(86362001)(356005)(316002)(36860700001)(4326008)(336012)(83380400001)(5660300002)(110136005)(54906003)(426003)(40460700001)(16526019)(186003)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:00.5095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62af3dcb-2b5c-4e22-3807-08d9bbf3e2f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
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

