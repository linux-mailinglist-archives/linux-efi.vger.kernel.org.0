Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DC44CBC8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhKJWLx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:11:53 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:21377
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233863AbhKJWLY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwFINR0a1/Fe6BHsRPAePqMDYlVv7qJgjzTFDBxQJQ3uyNfXHvX7zuK1OLG5KMWZfsig4Y3MJGNXNRsbiK2ZPOFva5OvrKnbU7gIB/xgDigdxPDFEWoU322tJg4gkYBMBvCrViysaBXgs3VBRkoJ4Ggdjuxtcm+m2LwKk6Rz6Swz9ddDogd/aqbmldhSseZXRnO5DDziWlc4cB+/jpO/IC7bL7mGvkCTqIviTYAHOMx8d6nYc1OShjgD6dUULo6AnxmuGBYN/NicqnfGkzVTqMOX0hEFc9U9CB7D/GmVdm0dEUzbGuq9euPc0x2c/RbmFtQGmrTPeuiww0NRdsBdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWdTGxes1QVQwa15EBnHEnXYqoT2r+wHLhrsR9xj5z4=;
 b=DoKE3dlxy6WjLen61P+p2W6+SVrDuaPyjAImHzt3oDP0LznUiOMUCjLcLbJzb6goJDkP9pEMZJS3V1s1rqrBY/LbBZQIxOiEudugCKRXliS7rfBKRAYbvWnb0SN29qnGAi5Lmsa5Gb50LJV0jNFsFcb31BeMzpl8m4M9XGdHJLaGUI6y6BzwMwIgTJQo/RoPY8UKJZhV6hHxX5w6aNMJCExfBzuOhTNu06/zf4DbrD8b63i/rlDJrNUBvq/MvE0WnC/7BIhf5TNEMtzlLRfDw2CQto52+vmOYmJ4dqGHDfAIZjDhqko2jolu1cd3HuSJ/cMqreh+l1Vr6StbizEycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWdTGxes1QVQwa15EBnHEnXYqoT2r+wHLhrsR9xj5z4=;
 b=LCp6Jgs4KS/fMMw6W6S0CzZbw+MKIjAAXxTfxFU1E5SOBYRqz9WhM3QBphsNemgUkNSux1Bq4QTlAzFD4Cct0L94iY6tBo6Qy+0JUSa7wrsjzZBqvlsodVIJ4dsCJnZ0IY8yUyKsB52UKwpR/aM5nnxG7N+IUc2KgvX9wNxBDFo=
Received: from DM6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:5:134::16)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 22:08:31 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::a1) by DM6PR13CA0039.outlook.office365.com
 (2603:10b6:5:134::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:31 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:29 -0600
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
Subject: [PATCH v7 23/45] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Wed, 10 Nov 2021 16:07:09 -0600
Message-ID: <20211110220731.2396491-24-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110220731.2396491-1-brijesh.singh@amd.com>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 569c21b0-87ee-4ff0-5221-08d9a496a1b2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4889:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48891A2638D459841E78CA6DE5939@CH2PR12MB4889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msRWp58dIjmZ/U0N395IR85FT7xl+eOAu74esulBPKcPYqxb9vbP5SS5ZLnumL2/Che5Bj8f/jX5UJ/rpzoTUy9RoJR7YZU72Qd1zhOdRtYl0z1fyDCB6kuflbywVmrbxjG0c9o2wdxpoI1tdhr4C3K02jMBcmWk3rlVw+bLk3RQWnz0XUa/yR922JahmdqfdwE/rl2qTmLxoUv8mKyMqxsh35Dp5GxVKYBJ0K+DAWdgMWNDx78B5kKzTFlQwKwjj3cMoxofGrj4gHz4BuZESLleLka2UAEt0hGKGIrvwE752a/WbfFL/Y5GPgRHDpbt3TJz3YIPnO89HTp5mQt2NnFNdxezGySOBl6g7YWx+5RHpcPRpt3+A7tLaFvX80M2VJLce3rrWzHFvDr7zRWTqR+L0eWYWL7o16A7Repfw51MVo18RMDYVHd+ksZb3oIRl3zy22NWmMSlhBlrBHJtvXbn61A6IihWlgQEIW1/8pDnshXIGL/GhpfUJ3Rkmbf26WFy4BU4hdS3/g3HE+ZeUpA/TTCDsgoABwxL4ip5NNr9/OjCALTf9q3p48mEARA2SJ59GI5Lckv50btSvIPeJZ5xmYf80GPKCdW7BQ5U4wmFWzgDVNPY0hT4ypzn8USGZNFbMhBswzxGXHO7dN3P6219hH9JArQIucFu+FFoVbgMaAsiCM/EpMAgdEOTLt0c+yfOvJolEh3x1V5J/IDu2oV0UdmL57IWPcvTNZ3EFNurjTI01NYzQeWlEL8GiLTN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(110136005)(47076005)(2906002)(26005)(54906003)(316002)(356005)(7696005)(8676002)(5660300002)(44832011)(82310400003)(6666004)(36860700001)(508600001)(86362001)(81166007)(70206006)(336012)(16526019)(2616005)(7416002)(83380400001)(186003)(7406005)(1076003)(8936002)(70586007)(36756003)(4326008)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:31.3774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569c21b0-87ee-4ff0-5221-08d9a496a1b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
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

