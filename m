Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB55842700F
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbhJHSIC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:08:02 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:1217
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240659AbhJHSHh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BILWQq7ZpbjmCdsC+9r8V62umxF2jrNQx6VSb61GISsyuZa1SAulRTRsKT/YREEWa9/kCCvm/ZxnpAM47Mc8x04p6f7tQaxNqnBCCImNG2q2AFUQNRKZ5zKSOXLuCzXzoHOkEQvjf2DRlNtVJQvFhzjZrBE/w1aR9LjMEFAZBYvjVcnrOhUmHuv4eBX0hYnDvwmFFeQUTyHBS7GAX6jM5gcj4Lh5wtfbCKtk/vzWtUOO17UT70nDi6anRm8YDLolIdxG8pnxWiqW3A3cMvGzWq6fg4KFsY70/l3YOplDiS6M7EL3EWapelsLnKmDICTXbJsoB8GoAho/Nt6i+Sv4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjqxYLr8z/o8I8OrIcdFIwaq8tmStHDdrF+Qrk3F/pw=;
 b=kBg9ydws/pYSXPcU41zLL9WRHFI7bd/vyI9pfAzwvUSy8vyS7LfTA8LlcMPBu8yo5pCVG7uIFJpqhB3CNX6HacL/Fn5NUrhqGWxDyeOiUCp36WvZmjDlKwHq5DRewGHxwR7eEdl2JTV2lRD8bk3md4iWynAVnkSJpJIYU1LSEZMzUUcYdkamzX00MbCs4bWE4XZ1vpWWiPSb0Biw+mihNVW0+ZwDepvn6zq7702kdrApVAH0B5YckkFZ92EQ9cEjyIy5hhRdZeqbexO6cGNurDxm1Ne4GV72wr89oyupzy1OS/EiBwRcgeqdNgmYG65xyXvSyZ4Cffnc/r8ImNMTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjqxYLr8z/o8I8OrIcdFIwaq8tmStHDdrF+Qrk3F/pw=;
 b=jq4b/NHVJ+BVx7mxRfcGdMut2AFlspTkvtFqYI2+JNffrdn2phke8Gjy69v1iH5Ks2TslJjrKlMJj6TFCGhzgQm7FnDZQBNLL7SXblHPKLcvIznlmp2hQ5jqT+FmLKJ7T9szCCN5yELK7sLxUvdvnd2UR9zFwc5CWOKl6+R6tYg=
Received: from MWHPR01CA0047.prod.exchangelabs.com (2603:10b6:300:101::33) by
 BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Fri, 8 Oct 2021 18:05:38 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::dc) by MWHPR01CA0047.outlook.office365.com
 (2603:10b6:300:101::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:37 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:32 -0500
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
Subject: [PATCH v6 13/42] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Fri, 8 Oct 2021 13:04:24 -0500
Message-ID: <20211008180453.462291-14-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 395962ef-770c-4e4f-f92a-08d98a863b3f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2546ACE5B2F00091C827CACFE5B29@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4aH9hABK7SDzIGv0ljydBgqbPePL728Bl7pXvhh/7CefEPyUHuCjlnz/o/H9cB8UtGGmyPkRvTtfn1uvqJv6F0OFE0MoPDx3koMu7Uzjyym2Si54XuaSISKSMfe+f2gFgtEFiNnyVRcvA2tMcyq/fj0IUSCGXBsIsyrVpNiijrSXNJ+RjaLJDQep882FdRDlujaTPTL+6BBzmG9wequIkSTmfaWnEpBmi4561aj99Gupqfb27J7K1IWzE9dbEw+eavmzoKImpdLZHxXk2Q3DvDnXsh9lbeDY6BQcxAT+HFDjAf4aofxFog+bX+Xrcq2I/GCTsLjZlJrYPSTS/jKnQYqHvlIqITvzFnCRxV57b2094OZhohRyGv98wXTFdyhl6gNLsq+VFjEc6KivOnyjnaao4AAmqCGqqt1ByHmzEpDDcKoxT/jq+yA1NT+JoT9yIvMvBsgMBE7VuRyaoy9D5apJPsXDuSdi2z9xme39oSxTnQFm2RhN6PkP+CLVEJuAQe5Sbu0cQxs5/YTadTDmdwgX+WGuIJjojlLXomAT3kpCJ5g1exWK3RkW+l7bKaFRn41IZa5GknIz4XBVqzcHleBU9zXYs/hPvDqLk1EMeBCH3Ivw2H9Yfv7NNlg5sIhnGunq6iMibu2D/p5HHolZJaIKgI0KcR2FeqGqZLrnyPK5TfRfDyzphFT21CzxA2CxPbf1dvxCEMdgIsW7l34vyq4d4MyAmQ1sk4NG/8ddP8xl2gEzJLeJvRTThioTjxa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(2906002)(36860700001)(82310400003)(1076003)(186003)(26005)(16526019)(508600001)(86362001)(8676002)(6666004)(36756003)(7696005)(4326008)(336012)(70206006)(47076005)(2616005)(70586007)(316002)(426003)(7406005)(7416002)(356005)(110136005)(44832011)(5660300002)(54906003)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:37.2397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395962ef-770c-4e4f-f92a-08d98a863b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification.

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c644f260098e..e8308ada610d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -223,6 +223,10 @@ static bool do_early_sev_setup(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1c76b6b775cc..b82fff9d607b 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,19 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* GHCB GPA Register */
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
 /*
  * SNP Page State Change Operation
  *
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2796c524d174..2b53b622108f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -75,6 +75,22 @@ static bool get_hv_features(void)
 	return true;
 }
 
+static void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.25.1

