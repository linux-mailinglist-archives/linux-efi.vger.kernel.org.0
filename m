Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D2427017
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbhJHSIO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:14 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:4960
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241004AbhJHSHr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVcUkU9bApeMV6IbZnID5WFc/pwQWmX+sx7Az7dhq1rmJ7Xz0zWwHPFqjxl2dcP8YbO22uVSpFWO+SwTGxIEHZbGa/XoaIpe8ArRRFJ5zoUT30UwukTwgG7QsgZADjU6nulF5J5AJlf5DwpNE+XFPrcNRruv7mkxp1p66CIMA0CRFHiQLtKdApalsBZSyvxs992KroUtWZ8UgVB+uFqUomcSwmBfMVhcb+X17v2rOxirhorZmcfehC0xngGa+Lt5EvPCEjKwHT8+S/0pPb5HJdjqqczSnPFEekNBfrTc/dOcZjEJ/Xc+SxGZ16Y3bujyyxmC11MxsUeDzgc3oURXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzqyfeIQKvaCyCHhE5/NF6Vcpt/OgAPPBNjEgx0/Pkg=;
 b=fBPx5whiJ5f0gT8p1wz39Mr/Ew0Prmu9F9dHtv9rNfmVhHN3fDTjB81pNSX5rqUNX9bEJBXrTxyVz+Cis2waCcIW7Y36UeUsyDwseummfxliReUxHXLPkZMey1WwpYpd4qcypEXnQ7Yf/Has9RtDE2/T0qZ1FCs0B6NUu1Bt069gyQV27sphhWJFYmFqXxrze5K22IaDcTQwMFA0l7gcJPO/Hp1scnZlIHr5bWF1pL6gPxvhyoXPuzmadIplbVUt1vgkxtoPL5mUSWuAvwuUIM6TvJ8GMiALpcbzdDeZIJLlJ1M76qCkSzgtAsqTkBa6VOXVKWotKPNbeYBV1c0sOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzqyfeIQKvaCyCHhE5/NF6Vcpt/OgAPPBNjEgx0/Pkg=;
 b=GkZiEOHs0l03sa/zkWE1stcWCfK7zCtfDOISdWO2bpqdNnzvwlT0BZNUFdd9YpQIH0hXcm3WKdTi+zNImsNHnADkXbbQPvG4CMXe3iRxJ3bcVF/QveuNZHFVxymMD1pLts5snpAh7iIwCAtkektkbnVB6nggvPDox49emCQ+0+k=
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 18:05:47 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::d9) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:46 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:44 -0500
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
Subject: [PATCH v6 20/42] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Fri, 8 Oct 2021 13:04:31 -0500
Message-ID: <20211008180453.462291-21-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57da81fe-7204-43b5-510f-08d98a8640dd
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5503:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB550307C0FF4C20491153CD3AE5B29@SJ0PR12MB5503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QyIvTMhR2QSCIKeubuPeFyboEk83ny6w/4JlbPP17a1LLF5jK1cYmlGRbzQ5FxHv10abW93hzuRZR+yJpy3PzY2t0vDsY3TqYU5XKb8ywkzcEY7t756h8+63qysOjdo351+1Ys4CFMuvq9A0NHgGo++DBPHucHOpiPaAysnLFOQHp/P1ZIUzG1ENltBBE3jd7+LxdkyaG7OAnrwEpnRkwpIuG6einQQoT110n/mfQQjpBaNpNyGwN39nA4H+O9yT+z6MSwvCdn2FuslTFgv7g+h/6rbGPfXA1sPR9KgvkiiFw9nJz3ozb4YA6AyuuBEnfq5FMPyoo78SWCm0/wd1jvIdkYfPg19efnzq14raRo1zsFGTXICF5IuAQCMF7qpsu7TXeBfmyDf0ZFgn8Pv1UwcmonAViqVsN1vE4SEn6BpSKzmvds0N341mORbZz65MmFZP0PGB01Pyx25MGimePynulxWypV+ZFpigZrHI+0MipEajZ8VIPAH8W25j1yFaHwXSSfFhWo/eGynq+J1v5RtLAjJuAgTOYax2ryMNBoHDakmOL2R/cd0xn95PuQMPtgGMp2B5IUoGP6+uKz3fMUpyLNzLbaynkYem6a6pSSrP4VrVY0fU8JcS+/rFsCaDmhNKAltRBzQoHM1RFdm4ygJ0f8x5crour/sLHisWTkbfajnuN2CWZ+tQsDKfeb760Uyq1R77e4GDBPJHABJJzxBXBanplErqyq2w4WPqRqBDcd1RBDgtkyjRxgqh3o9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(8676002)(26005)(54906003)(4326008)(5660300002)(8936002)(7696005)(2616005)(110136005)(6666004)(82310400003)(70206006)(508600001)(83380400001)(70586007)(336012)(47076005)(1076003)(36860700001)(316002)(36756003)(81166007)(2906002)(86362001)(186003)(356005)(7406005)(16526019)(7416002)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:46.6503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57da81fe-7204-43b5-510f-08d98a8640dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hypervisor uses the sev_features field (offset 3B0h) in the Save State
Area to control the SEV-SNP guest features such as SNPActive, vTOM,
ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
the SEV_STATUS MSR.

While at it, update the dump_vmcb() to log the VMPL level.

See APM2 Table 15-34 and B-4 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 6 ++++--
 arch/x86/kvm/svm/svm.c     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index b00dbc5fac2b..7c9cf4f3c164 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -238,7 +238,8 @@ struct vmcb_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u8 reserved_1[42];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -303,7 +304,8 @@ struct vmcb_save_area {
 	u64 sw_exit_info_1;
 	u64 sw_exit_info_2;
 	u64 sw_scratch;
-	u8 reserved_11[56];
+	u64 sev_features;
+	u8 reserved_11[48];
 	u64 xcr0;
 	u8 valid_bitmap[16];
 	u64 x87_state_gpa;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index aa4828274557..2b932e074256 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3210,8 +3210,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "tr:",
 	       save01->tr.selector, save01->tr.attrib,
 	       save01->tr.limit, save01->tr.base);
-	pr_err("cpl:            %d                efer:         %016llx\n",
-		save->cpl, save->efer);
+	pr_err("vmpl: %d   cpl:  %d               efer:          %016llx\n",
+	       save->vmpl, save->cpl, save->efer);
 	pr_err("%-15s %016llx %-13s %016llx\n",
 	       "cr0:", save->cr0, "cr2:", save->cr2);
 	pr_err("%-15s %016llx %-13s %016llx\n",
-- 
2.25.1

