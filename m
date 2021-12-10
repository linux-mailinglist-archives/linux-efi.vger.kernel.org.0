Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF047044D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhLJPr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 10:47:59 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:8865
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243308AbhLJPry (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 10:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjOHB8IU5ANvB/rA0Ek63lhpKR35LnXB4zdQHBR9QBd/XYXIB/i5B/TkWk/QCOCrMJFF3/6U0bhspALZxoxIxZ4a4beUEx85dYV2GOMw382vWsgr4MPf2Q006xXp/fnMu+F6QQoPYIZcitM8DP9GRSHk5XvZE9kzDvdyF/doMBy3zgRNc3h3wC+XNF6NYpnTH4lIDw6xl12Sk+bVdae11O+tHwMokFDtsn14gCgrXHkLmqTQgnDlalyzDzxCtMD+3iN4xkClGIF+LC54JfnWEL9jzaPJA+5LwpIrYLr7NvVv4tPLyvjcW1jMc0SrT+5Iv5NHZpnksXvwKQx+RGL+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeNASA+TG04fsTidzCMKkcndF1Yoh9n2LAbTCMP3Iqs=;
 b=jEQDBifwOICwhAuR2s3Y12ZCgDS4kKaPLVL2mKT5/OK3UvblDM8zR5A592mLdcv4MfECYdQXuVCqMEOwSuxVHukKcPAuAr3dHNlOJcPOox0df8SMe2HwxHOUhov7oPYtPjUm5HJWotQt29PSBnH/rpA0x5beoiBqY50dgg0oodoEc2SocIfcQFsK9sjgI1dh8QpP3CaFqyEGhE1vOe8tMqqYys3sZMRBcp6rY1IHp54zbSgWPDCZOYz1Bhzy9B1OH/nL9Ba20tw9OBUwDYGnOgy7+JP3gg4uxmEQt5xWpIqWoJIhhR/Mzj8OeSpfDqIWzC2B5mZSEd/BoGVox266qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeNASA+TG04fsTidzCMKkcndF1Yoh9n2LAbTCMP3Iqs=;
 b=oLWGxv+x1VexIIy6JMSOt2o2TD66fPgVLhGDY81TPqOR6pJEl0LzEsZ6KeGyjWZhxY+mmUumUNvDpIE1UmD2/vNdFvuDwuelrZSQm7sXETJgi7NVXCqNVoSGefyPlDWiKJBN8CvjawA8YksTU5jKweNH3I6vxoS2+/1o7GLANNA=
Received: from BN6PR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:405:4c::19) by CY4PR12MB1510.namprd12.prod.outlook.com
 (2603:10b6:910:9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 15:44:16 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::84) by BN6PR1201CA0009.outlook.office365.com
 (2603:10b6:405:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Fri, 10 Dec 2021 15:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:44:16 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:44:12 -0600
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
Subject: [PATCH v8 16/40] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Fri, 10 Dec 2021 09:43:08 -0600
Message-ID: <20211210154332.11526-17-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210154332.11526-1-brijesh.singh@amd.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a421310-b961-4089-fb64-08d9bbf3ec2d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1510:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB151049458BC83CF8BF4FD279E5719@CY4PR12MB1510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9i6qN4M/YthAM1hnZpT5QFXvmwQq0ge/V/O+XWuRn8YxnZMbJP08Uy3hdUgMLUUuI/bEjjQsoTUSh4Yt9PUkph+VA9Gc76TthYyGAGBaWkZX79ozEPPkYhfEx0H0U6XUA9Nb69hWy1mK5Ybh7ETz+L/A4ubOoA3IxxwwpZ+UFB9aV5fIsk3iIp15JLHvKTibujrVaLoxb+hiPz0Au5uwtePVK7t4Pji/iVpTvo+Iija4Kng0vgKYNraYMO5h40v72E3/DOgQwJe+2p7qgOeaNWsOWLlh7nMz5hNQakPiy5rnWlGoJq1yTebB9BCWBKBgRs7wEEN9NipZOft5/DiTXmKl5fi36ZPMqa9Umsc23HbLdQywQG3TgwO7ErXjOSwrawj2LO7v8lNxBgwzCH7v7gsCb9bNLmGR/nxgtl3Uzj+RdPlEcGnXkNZjRaiaReVVEPtb92OtNZOmMsj7TYpwVyk9LlpKJFxsCkWbrmH7rCLDNkbyq7/oKPnNS8acDtyfjxdb3UiQMRHXKDzAvM6VL1cZ//5UaPDc372Ujwnd4Y6MmVVFQXYI/uzgshhWqVsBdjp7vxeiXCk3NSYfGdEa/3wb+qfHwrs90JBgCTpYe97Dd4xik3SS86YO4MxRaRMdPQNxJsZr47jMeteWwqwWH0jHGzrPh84zYRh/aXPmbHuL4pzg/5OEJpW+akAFs1XVe9bNVmYqonzx7ekTOC7v5kNYSLfbVD2QT3cCqltfnREY6BC1GqX3bTsDyHKmFdB3CqafzNGI6+6FyanNhcGr5oO+9CjwPWNlzI4wbl8JmbTxZFUVm0f9FrO/PAxi8Xj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(5660300002)(2616005)(82310400004)(40460700001)(44832011)(36860700001)(336012)(7406005)(26005)(186003)(86362001)(1076003)(7696005)(7416002)(81166007)(316002)(356005)(16526019)(110136005)(8676002)(83380400001)(54906003)(6666004)(70206006)(70586007)(426003)(36756003)(4326008)(47076005)(2906002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:44:16.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a421310-b961-4089-fb64-08d9bbf3ec2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
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
index d3277486a6c0..c3fad5172584 100644
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
index 65707bee208d..d3a6356fa1af 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3290,8 +3290,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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

