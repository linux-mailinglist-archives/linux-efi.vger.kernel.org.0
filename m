Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748FE4C3285
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiBXQ6i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiBXQ6g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:58:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBED5D677;
        Thu, 24 Feb 2022 08:58:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwNExDj+RyDKAutmidwMhds4sdeoeD2kjY1CsjFUsy4NTm/FaKmh08FtOPkv/PyXNbtW8HYxPQIUetqvPoSiP4QUc2wVkDEEYuopW5ub2rtOsM7W77MQHwyEcY51sdBsihCBA59hBK8JgkGvM3FpRTaQD02qbxERBCwhQEgw4HZRuvj0FE5K0zp+l6wY9RDzWTiaeshX5yEXRGmYmqVWNHuUJ+x1drmksiAhmvCEfuqA5/do7/Yc8nykfGhndvuhto2Dmm6UYGUY/0QAWEZxrlBdassJgfaH1+F67JM6PiYf/xvDQ/iamSaSd9baAjmzyYHLjl3YLl9sSJW780gX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMPf/F0BVYKen5v2UIcIBJslo+MwG3tU9jGuazT1lTw=;
 b=cIv4MQH2HSzVe9VBCmntPvsA+3wpTwZMJQFmqWDFdMdhZHluJPI01UnIX4I5XOQtR3YAGh5U2oAsxvmrA4NdKqs+eNpgqiR0mgENdJqCYQtwWQKAbR4uBlUlUC+scwHAHDUpvBW7ituoV+bmAMx0Y67SusNbgaMT84JUOKzIll75Al/r84BNVamui4LlT3UysHrWxDGnCuHHdBHvyxSYomwomfd7RvNkRdUMV59HSLwShviVD043f+oFVYAu+3Fx1Pr1E4z/ZOqZx4F6QfWeEFJrLKjSckVq3LW5IwyIRyUMm5PIHHxwHZHkhEHjVzzsgui3CJU5pWZLgAWWhQ/X2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMPf/F0BVYKen5v2UIcIBJslo+MwG3tU9jGuazT1lTw=;
 b=Std+bb5Q9CuSETUzZr4WWuHm6eaKYhkcfRnGvlxT8cSRGaSnqfV1gLR9cLCK8thtsSsSODvk5yygn4QVdfKsUHgR3QT5b/dA2JsTH6mxlwEMC/c/6kldyJZiUhYhKbZtyOxWi6SswE04FdPJuwVeCrO3uN3vKCX2SGx2SBIzIjc=
Received: from DM3PR12CA0094.namprd12.prod.outlook.com (2603:10b6:0:55::14) by
 BN6PR12MB1348.namprd12.prod.outlook.com (2603:10b6:404:1f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Thu, 24 Feb 2022 16:58:01 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::2e) by DM3PR12CA0094.outlook.office365.com
 (2603:10b6:0:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:01 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:57:58 -0600
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
Subject: [PATCH v11 04/45] KVM: SVM: Update the SEV-ES save area mapping
Date:   Thu, 24 Feb 2022 10:55:44 -0600
Message-ID: <20220224165625.2175020-5-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224165625.2175020-1-brijesh.singh@amd.com>
References: <20220224165625.2175020-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b10d7ce-6b89-49d6-f52d-08d9f7b6d109
X-MS-TrafficTypeDiagnostic: BN6PR12MB1348:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB134855C7A6DAE8AF79E22A89E53D9@BN6PR12MB1348.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0T9aMsppWHsOQVaQC06rlNMFPUoqRpxmhNRkOdSgttO9H/cIDzMnVzZX4+MZ+w+71Tu+P7HbEwjWnvzu0ETZzRuNkFSQclUoSd5s79Cc1nAfWS8wjq6NaS2hPrLBZs8uANK2YyxUPZL73F22YDphvezzT+PY+eMODFhoHSI8moWOuOvClXu9jrMngFxhvmk3NQQve2poO6qoqdIrUm6eai6TvNhjpOZOQBvHIrI1WJzFhVJ1mskesOJIFsyNmeYB0fcnx1bV5wIS6euazKx92Yckm5cK8msiq511bUkEUwsHS16hynpzqSFjMvVhHU1IXRmeURVFY9BDrwkU6nIuCIGDBY0K4uiMOSUQLI3IkPXePQbig77lcbcvrUC8AkDdVRwaH2LuEomYNTIx8HVSZtyb03zBiK1uw5NURcWJttnWo1C4N0U5OF07tD7IvhVvBfyEma4IQEbdhJmlvwFnmAjI9BQ9D5E8FQai1dqGDdz36Fzw/oKmzjeqhjSnXg3DUib/j6MFgPxYezyCQy3r/W/yjBYCMCAO9Dd3ZJshuB9nVrYGn6O2izPTvCLqqQxXK6NJWLS9b3KoXVVwUKun54zef1Vbo9pfBRo8tDIQ5MwI8FMSqLYaKjWl8YfixHPDtTRNoy+Yc4Aw2/hiO+S6QAVjHYcrPPvuK4WXopetsd8D1VpC1gy1UmooJYaPQZmCGbgxHhH7gpug0hiNxp1BBGimgcIQr33tMTgaCZjSKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(16526019)(70586007)(2616005)(1076003)(4326008)(70206006)(8676002)(110136005)(26005)(54906003)(336012)(426003)(186003)(7696005)(6666004)(83380400001)(2906002)(40460700003)(36756003)(36860700001)(44832011)(5660300002)(508600001)(86362001)(7406005)(8936002)(316002)(81166007)(356005)(15650500001)(7416002)(82310400004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:01.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b10d7ce-6b89-49d6-f52d-08d9f7b6d109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1348
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

This is the final step in defining the multiple save areas to keep them
separate and ensuring proper operation amongst the different types of
guests. Update the SEV-ES/SEV-SNP save area to match the APM. This save
area will be used for the upcoming SEV-SNP AP Creation NAE event support.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 66 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index eae5c7ab9c6c..7ab508fd8c4c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -326,7 +326,13 @@ struct sev_es_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u64 vmpl0_ssp;
+	u64 vmpl1_ssp;
+	u64 vmpl2_ssp;
+	u64 vmpl3_ssp;
+	u64 u_cet;
+	u8 reserved_1[2];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -339,9 +345,19 @@ struct sev_es_save_area {
 	u64 dr6;
 	u64 rflags;
 	u64 rip;
-	u8 reserved_4[88];
+	u64 dr0;
+	u64 dr1;
+	u64 dr2;
+	u64 dr3;
+	u64 dr0_addr_mask;
+	u64 dr1_addr_mask;
+	u64 dr2_addr_mask;
+	u64 dr3_addr_mask;
+	u8 reserved_4[24];
 	u64 rsp;
-	u8 reserved_5[24];
+	u64 s_cet;
+	u64 ssp;
+	u64 isst_addr;
 	u64 rax;
 	u64 star;
 	u64 lstar;
@@ -352,7 +368,7 @@ struct sev_es_save_area {
 	u64 sysenter_esp;
 	u64 sysenter_eip;
 	u64 cr2;
-	u8 reserved_6[32];
+	u8 reserved_5[32];
 	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
@@ -361,12 +377,12 @@ struct sev_es_save_area {
 	u64 last_excp_to;
 	u8 reserved_7[80];
 	u32 pkru;
-	u8 reserved_9[20];
-	u64 reserved_10;	/* rax already available at 0x01f8 */
+	u8 reserved_8[20];
+	u64 reserved_9;		/* rax already available at 0x01f8 */
 	u64 rcx;
 	u64 rdx;
 	u64 rbx;
-	u64 reserved_11;	/* rsp already available at 0x01d8 */
+	u64 reserved_10;	/* rsp already available at 0x01d8 */
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
@@ -378,16 +394,34 @@ struct sev_es_save_area {
 	u64 r13;
 	u64 r14;
 	u64 r15;
-	u8 reserved_12[16];
-	u64 sw_exit_code;
-	u64 sw_exit_info_1;
-	u64 sw_exit_info_2;
-	u64 sw_scratch;
+	u8 reserved_11[16];
+	u64 guest_exit_info_1;
+	u64 guest_exit_info_2;
+	u64 guest_exit_int_info;
+	u64 guest_nrip;
 	u64 sev_features;
-	u8 reserved_13[48];
+	u64 vintr_ctrl;
+	u64 guest_exit_code;
+	u64 virtual_tom;
+	u64 tlb_id;
+	u64 pcpu_id;
+	u64 event_inj;
 	u64 xcr0;
-	u8 valid_bitmap[16];
-	u64 x87_state_gpa;
+	u8 reserved_12[16];
+
+	/* Floating point area */
+	u64 x87_dp;
+	u32 mxcsr;
+	u16 x87_ftw;
+	u16 x87_fsw;
+	u16 x87_fcw;
+	u16 x87_fop;
+	u16 x87_ds;
+	u16 x87_cs;
+	u64 x87_rip;
+	u8 fpreg_x87[80];
+	u8 fpreg_xmm[256];
+	u8 fpreg_ymm[256];
 } __packed;
 
 struct ghcb_save_area {
@@ -446,7 +480,7 @@ struct ghcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
-- 
2.25.1

