Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E74D096F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbiCGVfd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbiCGVfW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52206D96A;
        Mon,  7 Mar 2022 13:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z84hknV8FT00dPFfLTLms5Nk5z+lW+DbtquW+3fEx/RFC/cLmhuCrGkwEiTIYiZ7iKl+/P4o4qLgSzkjHEgf7cHF7Fne8tSb5Hg/2fx0bF+cs2KQCF+UcpwxVvxf5eLgB8lRnqwcyq6DHiTZa6AO2Iq36kHNOYF1lVqwodCdhRdf0Gav4ojWpBKIy25eGOIcdywcU6Zs/V7RGV4663nUzZNvEEbCO9P3Zg3BzXW0HUnZIaZYrCOr9joTzl1wzCSLgCyuhZelUZfsxX7ZJwbz7BkM6RoBuM3O7l6CUETSpOsgV7ikKXS+ukJc4TJLQikySglihQ57k74M/dKW1v1Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpty5kmwM2i/MklGipgcFQvhXKgpuuRpXZ2Y2DaVX5w=;
 b=L7Sw6Ctt6qtVUdb+HjVccL7B2SA0Qxd9dZWzPVqY+Q+0AtMoRA/fzkKvg/SrDmH4XuuU+ZOQDR8FfK0T6ZGopzJrVgCZOTg5AdDRMgIRxCYOKxs0QaJPauqy9T6yTkzR9Qumhni93jwV05qHro3QwNiBibuIisFum8oPl6Ax1I5OtoMgmPIwVacBu3hD/aNpxcU+y7Y6DAAbNj+gIZuIy+ONYHw8q4t8ajRY2ZucxKyVoEA5rOpvDiNlo/13kGkAzNQoJ2YKiVOa8tIc93Ux6hWJIAJhcmVWzeRTXUbvJzOQ6Ftb7QhZKNC6hzK0dQoEZe2ek/hfRgNDy1ZGDLp9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpty5kmwM2i/MklGipgcFQvhXKgpuuRpXZ2Y2DaVX5w=;
 b=Rx784Kag86UfoihtWypEyovKaAhiISAS0BSL51y6URu4Tkt3pk1adehyrbRugTj3MdNQxs67n8N8lMwAH7wFHxLYfL9KWMQDJ0Mg/HGnlO/rcffNc2niQPP8L7ycX6kcjUmlA0UKWYCgOgkHYyJu+5VGZRw5HgHCHjGuigVNkSc=
Received: from BN6PR1401CA0014.namprd14.prod.outlook.com
 (2603:10b6:405:4b::24) by BN9PR12MB5034.namprd12.prod.outlook.com
 (2603:10b6:408:104::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:25 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::27) by BN6PR1401CA0014.outlook.office365.com
 (2603:10b6:405:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:22 -0600
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
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 03/46] KVM: SVM: Create a separate mapping for the GHCB save area
Date:   Mon, 7 Mar 2022 15:33:13 -0600
Message-ID: <20220307213356.2797205-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a88d78-07fe-4444-c49d-08da00823ff8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5034DF523958799FD54589FEE5089@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aQ7Ax6748x6kDt74UoPzS2heZCZZA6Q6tTRKQLFsmHinPu5MaFcDSKqgV1f5kTW5k8VbS5nnA/aHrhYn4xW9r6C7RbMG61VKTtRt8mfksFUfhnUWN/yg9/gFOdBI4R5GJWvFkYdMbPFP0po8o3sstP3q8hHbCTZhoLg+GGpSvNjgnAQo7RgwY0Zi6CT9b9IFHOGpgNHQgJDiaCvD9dsK7C15RpkwMwQnhJ/GOwz9ObRDOtGVc9BEBi/XpOUGeAsgv+bAHvNWX5CJL0y8EnihvIRnGdhvi+RYrnnG857zBlQEvpUP3RhXowA2r6kAYJbQa/yF9Q5Js6rB33NO4Q8o0Hckl+rlVajNs/qvFxrOLFNaD1jefKfmrg3WaT9FHvkwFDmcKO+5hOK0X5vCE+KqRTbNyKdIydpok6xBnwF+ie2yIqUleKXFX0UqTNSsSOouh4zsERalL4qMd9IQiXM9FjNv2ssSWKpS2gTX2fctyOSVzSBtLrdCER/F+CqwPOQMzjA3DOa+zw+ayruJcb5YjBpFoQgwbAmqSYc/6d47pZMvuRmx8iM2qMMje4UJPSfocCs199wpx2nZbxyHFNXNmJjgkclOsfPbDLt9YHFgEj90ceqAFEYM42Lm5NZhLviU/Kyg2OWUM7EhKButiQWhKxYSI2czpIDa7U9PyG8CUB+HkeO60X779bRSQMHkrHMiR4xU63MvJYlrqb84dCRfJPY5U/e9XVJG/EQ7jCuZeQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(356005)(82310400004)(81166007)(7696005)(36860700001)(2616005)(86362001)(70206006)(316002)(47076005)(70586007)(508600001)(110136005)(8676002)(4326008)(6666004)(16526019)(336012)(26005)(8936002)(426003)(5660300002)(186003)(83380400001)(36756003)(40460700003)(7416002)(7406005)(54906003)(1076003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:24.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a88d78-07fe-4444-c49d-08da00823ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index e748aa33c355..eae5c7ab9c6c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -390,11 +390,51 @@ struct sev_es_save_area {
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
 
@@ -405,6 +445,7 @@ struct ghcb {
 
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
+#define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
@@ -412,6 +453,7 @@ struct ghcb {
 static inline void __unused_size_checks(void)
 {
 	BUILD_BUG_ON(sizeof(struct vmcb_save_area)	!= EXPECTED_VMCB_SAVE_AREA_SIZE);
+	BUILD_BUG_ON(sizeof(struct ghcb_save_area)	!= EXPECTED_GHCB_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct sev_es_save_area)	!= EXPECTED_SEV_ES_SAVE_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
@@ -482,7 +524,7 @@ struct vmcb {
 /* GHCB Accessor functions */
 
 #define GHCB_BITMAP_IDX(field)							\
-	(offsetof(struct sev_es_save_area, field) / sizeof(u64))
+	(offsetof(struct ghcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
 	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
-- 
2.25.1

