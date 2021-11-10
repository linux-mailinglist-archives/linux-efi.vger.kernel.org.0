Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2606944CBE3
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhKJWMP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:12:15 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:45537
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233642AbhKJWLX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2qtmt2iinmnw7In48ANL+UHuCTScXriegO8r2O5fRN6KFbjXEZ5lxBZN7OdtT1ve0oeqD5+dT5ELg41XZrcwA+xZkfyBBBAk5l72dWIDbyPZJcsicV5nQEnkufqhpli7pBHnDFoFtT41SGQsrV2dSkOPHxHTFKzTecXcqYUGFHmXKxQ337jdMCJ82riZmplmW6MKQU4WcF/egojD5URe26p7htiHaxtp9B/sCvY5bjn3R00Gp4XzzVmgV8rGoYgDl2vxTxjiIx7Z/+irVfRhOovEoVObAUZsC7VkMyTI7i848a/gvIImcmk3rR56+P0PJmObvIlFNEkoulrjSKB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ6s0GrQJcyhzH74IlU2KVFjl/bI1UhonvAzv2d3+oM=;
 b=Bta7NbmmsLaO13/tKE3kdONgzzPlV3ytESCSlYDTX0ZzP6GOija1bKEKUc+ZE40rf7rH7nADXzchPJzqVg6RHCMyfDCDt4Y7kimr60BRloMj6im/PceuwaceXgwx722xqeg5M/bvfksmu+TE8ZXkTQQY34y4mBffIae8jn0Mfrkg1rqBLC0ne7GPMDoyEWm0u80cXW53icEu1nIks9O8R2jS0p3W6Iykj4c/7W1rZBH6SCBrxpuho0FePAhHXMB2dwTxCNndqFsOcclA4FUBHEzbF3MPV3k+4tCrBr6DhxjcFFdzx9Gocn+iMqpbwOtKgYuZX8n/b62JO8eyT0lzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ6s0GrQJcyhzH74IlU2KVFjl/bI1UhonvAzv2d3+oM=;
 b=SJERSO6rTCqUTcCiXPCkHaWH7du/ImUqZmCira6geDwzoXOYIJsD2vXRKM8cuWEtshc4KwEd2ept5B2mOevp/SxI+cpF+7OytKuep8mCgPJI7cg7fjInpt25VzjLZOuo/mvsfIADkbDz22SfC82xaJEC4VDJmhP/p3VLMqDm8aI=
Received: from DM5PR21CA0010.namprd21.prod.outlook.com (2603:10b6:3:ac::20) by
 MW2PR12MB2425.namprd12.prod.outlook.com (2603:10b6:907:f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 22:08:28 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::69) by DM5PR21CA0010.outlook.office365.com
 (2603:10b6:3:ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:28 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:25 -0600
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
Subject: [PATCH v7 21/45] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Wed, 10 Nov 2021 16:07:07 -0600
Message-ID: <20211110220731.2396491-22-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f47cdc39-aa64-468a-12c1-08d9a4969fb9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2425:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2425C9AAB3981D0673060EF9E5939@MW2PR12MB2425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSl5L+zIri5ZX9ntY2JrBHbaIwvQqI2l62xfi1HCaiDUpH4IG1ImbhbZJub3t/sWc3OO71ivbDawypccElbuPL09KSzSVFMfgcDhOHxeMYQE6XnhmzQtCZZB8T5bQDaZ5fMtdSkKFHDafiyz7bQsNF5sXESalnRiV9nkOOrHVKR4HXHV9B1WXFK9o9lOuuEPl0x6OKgCqUTuLhE+pZ/L1bRfsSXlDsZYxxhN9OFZMHlgFKV04EfslXsGlvF6oe/d6c44wqrSbIpx5PTwXD1VxcJ3OCGA0IyD+D4aBvRMlCqZFUUichmAM4i6SD0noonTE6a5y4JSY1YpgIfYksaSogjtRnjsZ3BTI1HYqnMb1V/NDdGci88AJMgwtyX045hYOzD2s7RREXkoyuEfFNmTaXamKVUWUvfe3l00OgnkbVFJGCbZRzlI7qjwNKsXuBO4cN4/JaZ5iL9xH6sOXnR4UmQYYPjdXnL3ys7I6ycyNyIg/SfF7BIY0AYrEUxGlntC5zoDjrE6niYqDiNkFqv3P0g+U55OdV8iKO3MFT9gCix+iOjvLUaHbDfltik5Yn5V1O6EmbD/DPJ8YFe09HeB/LAaXE+qp6AdaKFZTHexZjqO3+g6yCtWZtQVrUbJLFFV+P2ntDfTi4tK5dVv5LxkR24/AT96wk+aBb9wbHANAx+HFiXQ6jV0gnABiujbz5V/nkfpwBBISppax4cSM9NqwNcQ5vdlkme72nxYgJWBsYoHstJrGZblXYZKp4KHo1bC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(36756003)(5660300002)(16526019)(110136005)(54906003)(1076003)(7416002)(47076005)(186003)(356005)(2616005)(36860700001)(426003)(316002)(86362001)(83380400001)(7696005)(336012)(6666004)(7406005)(8676002)(508600001)(70206006)(44832011)(82310400003)(70586007)(4326008)(81166007)(8936002)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:28.0602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47cdc39-aa64-468a-12c1-08d9a4969fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2425
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
index 226482daa6eb..6d2d3f024f5d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3211,8 +3211,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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

