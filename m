Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AB4AF91B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiBISLe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiBISLd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:11:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003AC05CB89;
        Wed,  9 Feb 2022 10:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDuJP09ANPS9A5RGUIeIdOXFc65jthRIYeHPkYGRk4ulZcW5CXf66qKm/PPVvwJEad3lkf3/G+B6xdV9czKueeoXuIXMt5JXXOkN89biarpBUX65NlsM3FKgbonhxi+EO+zGg4GvXUBzLx4aC7+6pLloLozNpWQCoqEO68+CPuNVyIhIU4DC9hcKEooDq6XLtcihgYlIj1sJHD+rHT04ubx3NAnDyIKG/uCvMBTpED3onMDk8BcdmQFt6IuV6uabEt2bZ6UwrvIpKqyYvU5jwZA3BKOTHzDAum6z1CnCBQXVpKoNr7yLADab80iu9Hksl6lXj8BrhaB+mGk50ohWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibnvmqw1NFAfG7gMDyxXZLLhlEbSaN9em3nNJOmCJ5E=;
 b=eVceqjbyqVzOFLzy7xB0Jf5LX4ZfAWXEZ0BDadG8Wv/RqCdnHJABmksbOvxwEFJI9US7BZV2VCwKiTFacnhxakJ9FBKYMNBDR8ZI6RlAsWTctukiBVUNXcxpMFlMt5cb0lAnTe/TbMDfjjdD8Vmknq5ZxdbyoXRsFadb2Yf8CZhP4gDiDFxjy6ubu5jRo0KfQ18myfdkDPZ4Ir4PRa1O2bEmV5th7fi0GtreI5oiSX/MyZmh1PaXR86yujII8Pm+IjxxM3rn5rhd1X1tDL+I8eJoQaFLwNpsbEnRsdbWxMF9GIyEus/WExxOvw7NT73nFHj+hLoxE3CdNh6BY3AzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibnvmqw1NFAfG7gMDyxXZLLhlEbSaN9em3nNJOmCJ5E=;
 b=fIpYpiAx0DvU2eSKP6yzQqEosy2hX6tRJl0bcPiFNirMifyvLCymVEMTqtx8+J8Hh+cKWBPwZNgM2VPMr+zSFgaPSDLvhZoQwuOfKKAfa83U+23JN/2sHoPwazAgPxF8OVFYbwwWoSkfIz1/K8wkkUxpF4LTi+oO7rzcMoKvvVA=
Received: from BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:11:34 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::b1) by BN9PR03CA0460.outlook.office365.com
 (2603:10b6:408:139::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:11:33 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:11:31 -0600
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
Subject: [PATCH v10 04/45] KVM: SVM: Update the SEV-ES save area mapping
Date:   Wed, 9 Feb 2022 12:09:58 -0600
Message-ID: <20220209181039.1262882-5-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 523cd575-167d-41bb-970e-08d9ebf79aca
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00618131CD681F2F0554C9B0E52E9@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HarVbBKXReMfxOUmzIufKjtjb9S+ySqkqnWnHF2wb5m9nBEpSeRWbabKI7YaK5YtxzYbBxFykk2zv/4oXIH1+VSVoiOwrM8QqCWr9caky4PwZKRW+1Qqbuux7hgLun04sSFoIN5Zfg9E1ar8/1jUC4AQKdu7a6QUBbo850nbdTQJU66wFdUSlRJ541Plu9JwCieJgsAVAV3tez4jAQGjJPXUyCwLqpMVPOdnO0ah5YyF425dk7CqfJStWm/pnBNBMK1zwztI+tGzQKlSrhXkGo5YBeuWNWFPRcownRC+PzIlapvYMrQv9YqlBJadiUh5PtHNkJPk2smO1n9odUiCILYhfsgu+1rUgFheBESgo+DRu30JoLYWWhCZeI3f5z9Wd4vdZv672jiO5axCj7UhBE79uphUrpcL9blxFAdCDa15hon3JusBdeLKZ5hokoaTkFtkxDCN1T8iQcRBoIUTF2DdOLdQd/R4OczjunhyDNXQ2kOcSsAevWRVl6oD0EjAfUOiZ8kcdc1iApJLOJf82tmYwHLdU9FZcBNafZZQ27Jre64oJ+UWmTH7U9tGqC35kXD0BeQOsrVtLesYMLyx/v/iH30LfwX5av2nE2SuopVR3xvK1d5EAME1wHXsbltG81NcpNprSZedwUoEo9I+1gAUPX5ZuD39bKprsRgTwh4ThXele6Jh2WfG0bemZfEZYhVsY1ckAmkllYqfOJRzDHNpy3h2CEY/vXLHlZh6sK0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(26005)(82310400004)(36860700001)(186003)(16526019)(86362001)(15650500001)(316002)(7406005)(47076005)(336012)(426003)(7416002)(2616005)(44832011)(2906002)(40460700003)(4326008)(81166007)(36756003)(356005)(5660300002)(508600001)(6666004)(8676002)(70586007)(70206006)(8936002)(54906003)(110136005)(83380400001)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:11:33.5272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523cd575-167d-41bb-970e-08d9ebf79aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
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
index 5ff1fa364a31..7d90321e7775 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -290,7 +290,13 @@ struct sev_es_save_area {
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
@@ -303,9 +309,19 @@ struct sev_es_save_area {
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
@@ -316,7 +332,7 @@ struct sev_es_save_area {
 	u64 sysenter_esp;
 	u64 sysenter_eip;
 	u64 cr2;
-	u8 reserved_6[32];
+	u8 reserved_5[32];
 	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
@@ -325,12 +341,12 @@ struct sev_es_save_area {
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
@@ -342,16 +358,34 @@ struct sev_es_save_area {
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
@@ -410,7 +444,7 @@ struct ghcb {
 
 #define EXPECTED_VMCB_SAVE_AREA_SIZE		740
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1032
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
-- 
2.25.1

