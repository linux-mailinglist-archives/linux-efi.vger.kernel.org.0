Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AB4D0966
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbiCGVfT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiCGVfT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:35:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB986D952;
        Mon,  7 Mar 2022 13:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCNVBhT29fMmngy+uvG7FjMtUHwiB+ZIEyZBokGMBNZQ621dUvNgXzcMDXAe4zVsS3zVaa+y5F25AxymKCucB8t1k4e5ybyugu8zOsB1hZmy4ys52oQpUKtQzkSccXr2HIN8X+VkJ7wnbEHhl9iutXGVQ2xrcagN6tyRMQkrkb2urh0vmPayaSapJIZiq6R0om4TsyumQWImjYE8BNl47eKdPXG5bQjZ0M6x/8wPQp6I+pBCg+OwwVxxaqevBTHqWr4069KBVdNj35w+d+gx+aLDDZCi2nPEgUBhtIvpW8mRwPYy3oC57Y6tWE9jTJBUIY//PERxrkfii1v5Fp7jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzMGXQUBI5kqNpqQYV8JzSAxqABXO60VgfPmaqML3Cc=;
 b=lp/FBuo/UmlYBnCtef845cHd7szimOSY+YSIBFQEnC3lBdzJ4WxNYAyRYs9ahBuOSPF/Ru7qX57HKmasCit6dx9/TKcybaSuJbeqWUrx7O7gnzOXUwG6GEdJE5cm3BwJQel6S3rPFh12UclFsiUmZ2yJAE0yt5OWqe4fM2tEAuSmXdh5VCGp0x1TzkITfoz5TCtzVqffhlx2oez+EXPjklHv/4a3m0QtDciI5pT6HsV8t/tL3QEHttRhPLueMsXM5aKCOL4Ikcl79Z5/KRz9pstrMGk1zE7CpQ4/ew3Qr4ToLlEWitV7U0Ra+Q72M/W+2KB4WFy/PYBPeb7k31lSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzMGXQUBI5kqNpqQYV8JzSAxqABXO60VgfPmaqML3Cc=;
 b=mcJA+WPg1nlLitdlqRd7p6koxygcuQHmzBM9ANUOIOvEh7bvNdibgWcXpSMuWfgqFjZMK21Em4J/1fhtSWEifPxhk2MLGztC3bHsM10MfUmkiTMnnH4qVGxE5Ufo5ux2UaxmWiUGhqaE2zKqIj7yyjW8oVOMU6onWeKkHEkrWDE=
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:34:21 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::da) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:34:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:34:18 -0600
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
Subject: [PATCH v12 01/46] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Mon, 7 Mar 2022 15:33:11 -0600
Message-ID: <20220307213356.2797205-2-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 714cea4e-6488-4e95-ee72-08da00823dc8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44511E64CEA119A55D29860BE5089@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoTARZzT0BZUArf3VaqK6pDlf3Ch4hnFpx4g59TpEdIiiHc6GrzI7aTUS1ruPNZ72Yc5Dkb0rxMif7KBya8HOUSZuevF7jpSt0NMax/0h450pjexSYRX+CwXt1vdDdY0BeKzMOVyGLhNaMWbGVd+3dm742eMQ3z5ovXM4zUJzJmoNLBwuEdaYcnLPppzAfB6Pbwwfk4TytZN4hMbYnLQBDbt+Z+MGIyjzJeCnZOl+WOlgvTHOiXVi8Vxs2Egc3n1ShURaBwut+F/jDthlyET5hs93qdSAeXXHO1034epwWF1HbxBvBZdC7Y8z3ASrt4cdWuDV3GDZZITvEGb5q8Tv6Ooo97wGKlUcuI+PzbztUf6oIlr46x7WzuQYegUNdYQaPzCl7ZSZyTLu5K26wfbhrF6C0OnrWq/EeIelFX9EqWjzD83yCxHm5XA5oxsiJ+PKrrTrNp5z76SF7Ck+4qVKylSE0M3Pn1ugAhqcpTpaqxBHFEC9xWOfTa1SJYyd/C4K+CcgjLysc32ZlMyWlijkrGq89POOuo0hIJa8zzJPkzExci+yktl+D+ShznWD9Ba+Z9jrhZbuXquUeuMktRg8tPJ+Z3SPqhFg8PwLuudnmapELRnznoXv2OWS34CmLRD1St2/2dQBkTcbMGjG3/jiP+zoQDsp42yK1zBYuOlyD325jz5jo9ucY1PXucfJAoD68tNF9YSvzWKEe0Mut0taeofoAOaEBD7VpBgENYrYYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(2906002)(40460700003)(86362001)(186003)(16526019)(426003)(336012)(8676002)(83380400001)(7696005)(47076005)(70586007)(70206006)(1076003)(316002)(36756003)(54906003)(8936002)(2616005)(508600001)(110136005)(26005)(36860700001)(6666004)(356005)(81166007)(82310400004)(5660300002)(7416002)(7406005)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:34:20.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714cea4e-6488-4e95-ee72-08da00823dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
index fd3a00c892c7..fd92af40c280 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3118,8 +3118,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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

