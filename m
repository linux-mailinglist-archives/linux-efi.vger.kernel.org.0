Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016AF426FDD
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhJHSHN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:07:13 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:29056
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231217AbhJHSHN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:07:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwLsx5dXbaAbpgBA/wf9fRgoifz2buezuue6EZBgvdvZIawdNet1S7YtZOga/UKp0fyflcBUizVN2QyP53rON2mog5zXU23lI3mjIrR4rej6Vl65dheUisRsrLCRUR8XOdkNpNe9UYYzWar99Q2+E9fNrcA3j6vdtPce1PWBfe892t2+sqjUk4S3i5FILnN/3CG9A6at87dk0uNhnvF5OomL+Qyp5HbYDfdnMjtF+X0WVV7LA+PIdJD0gvCSHM/p867C2SF3TWll9l78hq66qIyo4RzYD9sEsai86DCBUngXHLUEOUN5palcCvQKAb/f2gDpA4gd1uuNn3rgcPNojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wUqQzuX+kBbOqDPaSYFLxyarHWjRNqYkkO1kYubPAI=;
 b=M2nrvtrfZc34wZjxSTRUfwpGr6NwOmluLLMePCA6KIZ7wYIh/Ijwhl1mAHr8OWYmqSZ558HZG2HUSKs52vEXA5HVv8KuDZJnNoXX9zLvChvullT1gG1jfLbb95/42ETw+8fAJgNxI3Ab4mIFuNUBxRb80D7hlaXDMd3W3bzcAirk3DZFkKNsItY6QxXF5r3qTgNZreEOOe8IVMeBTh9n/rOoHy8T1kGSgl80az7Jkn1SccGk9E3MlIhIJpk7JWh4e3yGyAC4yL20UMGonntksywoRpHTGdCFezUPfFKrICPGrGi4k0yfyNE/nD4LkEIuXb9nPL4KNn1ycfwX8dvv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wUqQzuX+kBbOqDPaSYFLxyarHWjRNqYkkO1kYubPAI=;
 b=ghLCfwB8Z0zOT6OkMJbozaavnUIBxSLVKYwlENThb3ltxqEgh+gtnF877T72dEoACzySutJT6ho77WsWDj3cqvBV/mxZbgzMyxncpu5Ywo/IfM8OJekBGH1Vc/WKu3TuMyyBurHQDrBcSxxWLnsD+EDaDzuz+wGpjZkGMMvWgBY=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 8 Oct
 2021 18:05:14 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::40) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:05:13 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:05:11 -0500
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
Subject: [PATCH v6 01/42] x86/mm: Extend cc_attr to include AMD SEV-SNP
Date:   Fri, 8 Oct 2021 13:04:12 -0500
Message-ID: <20211008180453.462291-2-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f69b822e-3c8f-48ca-ff9f-08d98a862d39
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR12MB412586F293BB7B7E3A57066FE5B29@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0oerZWFtPiW01FNpoJi4zEbzoOdZmDuYowSEE1OkvYzgJMCB8qSJpmCgIgNVi6V6j2cpNCdqdkylHL+X941u4RndZxrfaYDHXLcz1YCilvY3ccy9BEydtWCiZ8l0dvqz2VXD7j4Fm1xVHWJTdsTzhIQdixg5z0MPmtT44kVD++i+CIp2gTteyDkbP1CUkwX+IIE1xYscgmsA2M8yo9VD3VwlBAQQv392yIcvRKuV0sNtNveieBoMLdOysOCTbldS9OrRcnWp90e4U8UAKzudKtRP4QxRvUrAhBA8vfXxa0XfIksRR2dQHn0mCX4OSEN9pfL0p+X7o/9Qk33vZqyUXuKaOwWtrosu1Kk3B7eYhg1BFtQ/5H+fc8sMhl1Hpught/fC416D82okPR7nfLaArwjWWywB84nphiaPJdbYOxJ0mJSHBFXgayjPXn57dDoLLn/pDjN2aCEuSx8r524ctuHNYZqIO5yYoSMp02nkn0oCZg6PMTyG+MfZLIfInxazMVS0wqD2qehhZN1C1Lu0rGgAjwlkYo+Q2Xo956wXhMMmN68RijVCQaqgGa5eimTEdX7Ww0G2lN1ZL3vV4FPxmQFBkvJt7S9NjO04GLTVVHJWchL9ZTgIfE3lG7JMK+0OIDfD1oc/8QxwM9RoIunwN5UhjT/jB2Y0xaO2Cv0T2ggW78GKpIciGcA14YSCSnULEjLAdaYeU9pWqhM1Bj2xhGnPFyDH24T4GZGfghp2Hn0qvcUbh1cCB9LWowNHQgd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(86362001)(47076005)(36860700001)(336012)(82310400003)(54906003)(7696005)(44832011)(2616005)(1076003)(356005)(426003)(81166007)(316002)(4326008)(110136005)(2906002)(5660300002)(26005)(7406005)(186003)(16526019)(8676002)(508600001)(70206006)(70586007)(8936002)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:05:13.7243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69b822e-3c8f-48ca-ff9f-08d98a862d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CC_ATTR_SEV_SNP can be used by the guest to query whether the SNP -
Secure Nested Paging feature is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/kernel/cc_platform.c    | 2 ++
 arch/x86/mm/mem_encrypt.c        | 4 ++++
 include/linux/cc_platform.h      | 8 ++++++++
 4 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..37589da0282e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -481,8 +481,10 @@
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
+#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
+#define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..e05310f5ec2f 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -50,6 +50,8 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_SEV_SNP:
+		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 23d54b810f08..534c2c82fbec 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -433,6 +433,10 @@ static void print_mem_encrypt_feature_info(void)
 	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
+	/* Secure Nested Paging */
+	if (cc_platform_has(CC_ATTR_SEV_SNP))
+		pr_cont(" SEV-SNP");
+
 	pr_cont("\n");
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index a075b70b9a70..ef5e2209c9b8 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,14 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and actively
+	 * using AMD SEV-SNP features.
+	 */
+	CC_ATTR_SEV_SNP = 0x100,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

