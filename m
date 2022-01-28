Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4949FEDC
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbiA1RSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:34 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:19671
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343585AbiA1RS1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi18NmtwBEht8Xs30PimkBM+bTsOnaji3s4zu7WclbDVKKRXIDaOu0AubPLIlLhNrT4rZccxtIS97yILdNnMs3NtC5M1fjEC8vikUpgwsIEkjQgEg3Tq7WYDxusSeEupVP01plWD3J9NT1arRPz0I+9sVq7vYPTKxsZnlJB1sDjXTXCoZzB80zJn6AYUVW3LlyJ37atNwFl8dbKNw/Mkr6nNy2kCqYXtQXCZUtWc2v+EFARw64f5V2v/wol8yaWhzLNO6rylcflpi+u4WTraMEN7CUTBBvmC4txjmQW1+7CzPS64yNYAHv+Z6pfAMT6GFKOAN/D1TJ5nYBQoApjaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmXVTRy6UQm1WoPAcgkt9HTG92DGrjYJGd7ZkLbvCRA=;
 b=EUHo/u6+gR8/zF5AALX35atUmoZpjQxUR09E1OYlMSmiGRieqt3OmadfM2hc5wCxZ7hqX4Go5Qi+PTZ7fSojqBtjth1Pu5j7h2J3i87GZ1rys6LHK5TvurQu/rAaUAHq4Bw9kiS4ZJQlLT+SgqRTMMch2ZuBCcUsFlPFnlQrKjjvPESCOWpAM9Hv61vQjAK8Kctv4Yx9/YzYNe7w2J+wM9lsqcUvJ3rS2YN5mQpb9QbPyAq3AY2I7S/V7qQM/8VIJN+MCqveb4lBscFzYqiLeep0vSZzabiA/dRasHXVRMvBBjslGGpCMtIzr1HBseniDWD+iqqDj0nAIncEeDdYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmXVTRy6UQm1WoPAcgkt9HTG92DGrjYJGd7ZkLbvCRA=;
 b=LcQnDzRuedZuU39OpkFbFCN20+mB+EA+2GHxqQQpErviKqhX3G3R2x9ojifNxx3dQ0vbS7Al3zTwmWKLVlEyXRGxx5ahK0uvYjTh86Q45jMtqVbbKpIzlcgMyrMTvrpiUGp8mgEb0nOTGl8zTCa4/29S4qe6ueysJ04lI3SSSWo=
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 17:18:24 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::dc) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:23 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:21 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v9 03/43] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Fri, 28 Jan 2022 11:17:24 -0600
Message-ID: <20220128171804.569796-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128171804.569796-1-brijesh.singh@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f289dbd-1f1e-4b3f-f529-08d9e28230bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3255:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3255010DC84056B90C147B58E5229@BYAPR12MB3255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvhfYTStoPSp0bAnCTrXa5cU9GAY3ehNfkvLODE0VMROWppFw/pYG3gQV5sbqoveNqHw9tVSYQVmTeK/v5yG5zt4mFvjopnN08jpFktH8uOx0FyywkPP8LHslayWUp5uHTR+ZDMjtDOGC7SitY1pSwQJZ3LMIKYGUkS8RNVOpRm4NND6NNwYVigLVU6wdrkgdflJXBkplLvDOzQ9HnKA6A0zbdH97Ph3NzantUaur1YkOezEynxppJfL6YjrCMUkTclisJ12ZyZPuFskS/wezbiwNJA4Lor+j9aJBmqA+FkhcY+5wpKrzZKaIo7hepVZUhuwY9Iu9uTeellOKAYtPLSUxVro8F1BbhVBfwE0NuPOeXm8kzCP2VrbRfEBFc17n3v57aNPAL5uCTe6WYu1QsWb2FlGSxaW0uKKkelpoJjczTy5hiGw/bRxYQcE4pk+mHFiwB5aXEnI+HRJ4+Xw6YDzljTLNkWBfbpfp7FiDpOgL/RljB7MuvxhOF3MSTz3Tuggb72uPrDY9M5B9kLgPqifgWm7LxdeGmRYBIChfhsh7oxhsDgDisqKEnFT200EHnut8r9cqxRwPRz1PYlIz8vC/isu/8h2/T7lSKeoWjbRCmTTuq2HZc7KWvr2SBUL63SuuTerLVJjeKJyaWx109RJ/TxKAB0EHWRRjOJ7MwsXptvGqEIPnF9cLrykEHIUBurjgB9gZ6xdx25lvcn1V1c/zrXMAWyXLlGi/h86DrI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(82310400004)(356005)(81166007)(40460700003)(110136005)(2906002)(70586007)(316002)(54906003)(8936002)(8676002)(70206006)(4326008)(44832011)(36860700001)(1076003)(7416002)(7406005)(5660300002)(83380400001)(336012)(16526019)(426003)(186003)(47076005)(26005)(508600001)(2616005)(7696005)(36756003)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:23.9923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f289dbd-1f1e-4b3f-f529-08d9e28230bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3255
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

The initial implementation of the GHCB spec was based on trying to keep
the register state offsets the same relative to the VM save area. However,
the save area for SEV-ES has changed within the hardware causing the
relation between the SEV-ES save area to change relative to the GHCB save
area.

This is the second step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Create a GHCB save area that matches the GHCB specification.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 48 +++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 3ce2e575a2de..5ff1fa364a31 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -354,11 +354,51 @@ struct sev_es_save_area {
 	u64 x87_state_gpa;
 } __packed;
 
+struct ghcb_save_area {
+	u8 reserved_1[203];
+	u8 cpl;
+	u8 reserved_2[116];
+	u64 xss;
+	u8 reserved_3[24];
+	u64 dr7;
+	u8 reserved_4[16];
+	u64 rip;
+	u8 reserved_5[88];
+	u64 rsp;
+	u8 reserved_6[24];
+	u64 rax;
+	u8 reserved_7[264];
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u8 reserved_8[8];
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_9[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u8 reserved_10[56];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
+} __packed;
+
 #define GHCB_SHARED_BUF_SIZE	2032
 
 struct ghcb {
-	struct sev_es_save_area save;
-	u8 reserved_save[2048 - sizeof(struct sev_es_save_area)];
+	struct ghcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct ghcb_save_area)];
 
 	u8 shared_buffer[GHCB_SHARED_BUF_SIZE];
 
@@ -369,6 +409,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -376,6 +417,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -446,7 +488,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.25.1

