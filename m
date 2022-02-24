Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E24C32C0
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiBXQ6g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiBXQ6c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 11:58:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879354348D;
        Thu, 24 Feb 2022 08:57:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZFpyzT46nrHv3xWcrVQHsH2lzQWRR4EV1VkEKvMB9ahdjEBZSQuGoxUHJvsHHw/+PawGKKhY93cLmw4zNFdP7sjWDL8uTie/sJsC5OkPmxv2BGIFg5H1UxH5nEEK3CgBXvIxw5+xNVzGgqbhs85WAizBN8INuEnzsD+zoA/473j0KGYXV0xM8o0P/RhDa9AKcPgnbWfwZrbautO1XLT6X81sonlrUqr+I1ePoOz0fakQwX4wICZPw7sKnmKQdHE+tNp9nDJpAtcSU4MEjyYbSyQCqfbhtGGf8FPzVu/iY5DCuRj9QzYnDiiJCx3JeoBjJE7fsvegxMSHxWWzYGP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUkgNM+wreAcokn/etoOTTtLMfyqTY/FFQ4ipnArfzw=;
 b=Cd0o7IgAEGv3Dl/3DbfBPPytY9S8S06KwO0dD0BJt9eN/AT+bf/bMe7CPX1HVHOxwVVM4WpuO27Wx9/3mTL7wtOnoJW5CKfokoh5BtGtrYtWR2ZI5gMqoyRMNJBo86gB7hA+Eecxq8YrXyl7S1GtfZCmb9Hr2U2mOBTQAo5Cn6GzFmarAtZ1QX82YhOVIMuiR13ssOpryh3mEqmYlNEWpD16dYBuPLVVUOlY8pQ+tMeSKKa6JVrkXf0mk24BzD05YQ3WV5AGEFWMXh+gOrzp/G/Zz4tMd/uo+XonA/1vKyyJRfJi/wwB0hIVT+oGkxtF1eltADZ1wG5C2dR4NA9eRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUkgNM+wreAcokn/etoOTTtLMfyqTY/FFQ4ipnArfzw=;
 b=VkKQ+NCdPm3nd0J78LRikWTxLLkFGQ7WsE821cDv/Fqnnia8fGxXx/SPinknbzU57+Az5cAFHfcx1RU2OcQvi5FmSgpM8IPabxNVUlZvnAWWxM2hdZXujF6Kp42+1EbLjsiZ6sbAb7Sb9Ia5U8SFBFcl8oTx+4gkUIYTg4Ep1YU=
Received: from DM3PR11CA0012.namprd11.prod.outlook.com (2603:10b6:0:54::22) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 16:57:56 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::1b) by DM3PR11CA0012.outlook.office365.com
 (2603:10b6:0:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 16:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:57:55 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:57:53 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v11 01/45] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Thu, 24 Feb 2022 10:55:41 -0600
Message-ID: <20220224165625.2175020-2-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4495a072-71f5-4195-d837-08d9f7b6cdae
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49152762FF5E95FA2D7FC680E53D9@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX1MLq1M0qgs/xOyxSTTMWqYBNxgOnP6SWLrWO3cHtx97lj0i23uAwZfLKYvc2Un0HclF7uM2GDvPbqGQRPsxYPhil3VO5TagTc/q4ZRvtiwaAmPTUT4ja/TBFuNP6BcRdfWGRxYoDNRyLH71n6FU4Gpp9RoW/es02U8KAaLRC5sIFPmYghk2TI/ZcqJAEKQ1K7WxcPa2Fi+EsGU3LVFNbD69Aqm0T4d0wzbifZIRadT1qPpeu4GJJ5feor1sFgbXRJigYlywtSFtlVrcSbTOmpEIdC8peCKHAqrYU+zz8jQp4zC4ujx7E2FHi+/XFouG0Jy3Ce7NHultFfact6bex5EyPX6DfS4qLhjMW58IpRV9rWRsmbIm+yRNk4GQeIZspJd4ZmyO1oQ41ThjC+xhB908pGWojQ0GFQRfW51FjSayJ7kFpV9ycR5DVpq2sw85fafCydRePHP4pnW5fB5d1hTPvuPhGxaQzlXqbd1QagJJY335UGqmBP/tYyPt1egFRnLFl99Fra6SWnN6C0KzXYEYP9n8D22tgyoCWjN/4iSwEFtN6N07nsOVMj667MA7LoMq+FKgDnQBOUxvTLocjniyUO3OJm65M+zqOvP5kEFxhQf+PGiNd6pnUy9yBmXdPdI11ttvdQLdZTI+4NAweKhOXE+YAzzzWoaobu5VUGv0P0W1tB7deIsFJq3dr7ql5ETwlCQa1GxIjc8wINTmPaUFXJpa2Hv6IOMMJYtMsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(26005)(16526019)(2906002)(8676002)(186003)(426003)(336012)(70206006)(81166007)(70586007)(83380400001)(8936002)(7406005)(44832011)(5660300002)(356005)(36756003)(7416002)(47076005)(54906003)(82310400004)(110136005)(36860700001)(316002)(508600001)(6666004)(2616005)(86362001)(40460700003)(7696005)(1076003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:57:55.5438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4495a072-71f5-4195-d837-08d9f7b6cdae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The hypervisor uses the sev_features field (offset 3B0h) in the Save State
Area to control the SEV-SNP guest features such as SNPActive, vTOM,
ReflectVC etc. An SEV-SNP guest can read the SEV_FEATURES fields through
the SEV_STATUS MSR.

While at it, update the dump_vmcb() to log the VMPL level.

See APM2 Table 15-34 and B-4 for more details.

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/svm.h | 6 ++++--
 arch/x86/kvm/svm/svm.c     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index bb2fb78523ce..b25b4e5ae6f9 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -274,7 +274,8 @@ struct vmcb_save_area {
 	struct vmcb_seg ldtr;
 	struct vmcb_seg idtr;
 	struct vmcb_seg tr;
-	u8 reserved_1[43];
+	u8 reserved_1[42];
+	u8 vmpl;
 	u8 cpl;
 	u8 reserved_2[4];
 	u64 efer;
@@ -339,7 +340,8 @@ struct vmcb_save_area {
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
index 821edf664e7a..b7d7b9c7a24a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3103,8 +3103,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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

