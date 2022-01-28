Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9E49FECF
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbiA1RSX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:18:23 -0500
Received: from mail-dm3nam07on2058.outbound.protection.outlook.com ([40.107.95.58]:7520
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235580AbiA1RSW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHgtyHMbkfoCoW5cQT3Rffd1Vz/urQPhhWjw1JG8Tbbr6sHHNangdYN3J6iFQR40vgA+4OvSnugB7hh+ifThPHg8M8mrZg4mxNCgOFCAOWfZaoaNEKQIGGkglZM2lp34kIJjfxzMUNJ2QWGQ/DfeYRn5nlqdg7sG0oyZxfF8Sz1yXZMgvsagRM2YNu5tQV0RYX/cs31PDl52j0Ip2dS1Rz/OUHzMoKAj0i5dbpPzGfb25+wZr99pmy09D49DG4vP6NGL89WC5rH+BenF91VQcurb9onnn6TbO+ooPdfLiE31kTHzTTiguI848WMOKZBIN+dpuNpgX7PM5l1XnkLxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/i1/Ke9KJamDWBefGe0t1EY58OrTtOvYOHqSuR82Hg=;
 b=UcUBIIZRFH42J9BVrbiaiew5LTTYtcHKRyEXD363bXNGRelvgeW+CpwJs6RUWQ7lRb0amWGdzYcAK49uho5wlheUbd58H/8xchL/wc54xk+DCeJinI+JTSxKYBXUsqgrMAIDxUyuKpuN3lUNHschQCnATSaqCj9JOlQhuA0wgVme2ME40Tdd8yCgqSDamURfajTi0wffnAnz/+bwLoub8fdEa1sn8o+7v8P0lbftA+y1Y58HozR/sQIWAq6aTFsgyZnmhSHyToPRQVQw+nkKs2rVike8Y3JW8tzmGsjZqsTTQ+U7AiL0kCtFBmleGBJWCfYnpqI0+PTY0BZT/VZMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/i1/Ke9KJamDWBefGe0t1EY58OrTtOvYOHqSuR82Hg=;
 b=2Tqh64DshEi/Em3Ad2J/4P6kwZITI6t8wZ+vk1iMKCeQ/Gvd8nCzbz+N03JzMNOcYu3UWgMSX7b4GMp6dU0Pv9AM2sNEirj+ih/qxEpudnXrjM+38AD53ntKqt/QjE2hqKnKhVHN4CrPw+/hNdzKxVtToCOflKTd5tpp53htra0=
Received: from DM3PR11CA0010.namprd11.prod.outlook.com (2603:10b6:0:54::20) by
 CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 17:18:21 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::46) by DM3PR11CA0010.outlook.office365.com
 (2603:10b6:0:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 17:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:18:20 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:18:18 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Subject: [PATCH v9 01/43] KVM: SVM: Define sev_features and vmpl field in the VMSA
Date:   Fri, 28 Jan 2022 11:17:22 -0600
Message-ID: <20220128171804.569796-2-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb06bf29-b54d-40b7-86ed-08d9e2822ede
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB184562DB0657EE50C09EF542E5229@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQoYU7YZTBY14KChEaVKjA0/LX+karNe2f1D2w+wm1jZQiZ1MsR5ELuQ3Z2w8gWgHIu9l/MNk38cNHC8v8PxRA6MSIF1GrppuyA6JWahtAkfKoJbEGc1DVEl9A1exP5raBZn4PFKw2bpruSnjqRNvY2I2gTKF8dq/koBzj6ZSyS/qa/QWZLzd7t7Csk9lyjaRKVKB4seaXmctN/2QL6f9mGsbKoxu7nSUdwKgKl8eXFcvfJidHZ8dDVtx3WaElmMvMBv6fPJn1GgM5wNbibRNUrZrl+yER24enhY7bYO5/FSWKIQ42C1TiC/pkqy+C0w2VIybNRfcp8uLuPdsHUgsydawWPMTuVlberUdPGJnppAoeryJe/tv5JQxxk/olsDAQFvY7fW0fSIQ1mFy2Yz4L46NlXKmivgwI71RFGmDSjuzXtb0HXLFzaF4+nAHzlEHWWQGPR9xwkIP7fUv3JZrNZHLdDlKerlQuEc54VKygkXfPY4U8asc4yOzxyvOAVMJ/5h5lnNAALkiIimeEXXsa3yNOqyJgp+wWR+fwYD1hL83NjqSa2nMl6NE1OujWxsxdg70KEyls2cDvU7hijpsuXiZovNwiD9sVfLrZCfEwF60HpHWVdwcR69OAZtwxKVkI/mW8GQPEpkoVA1BimzvNyFD0DfDgo1PmWQU4AGsb7zOG0cBCTRIe4RmymDL8Q2VyULa9Jn5FCjFziCrPdAT85sBjlDjeDB4n/jTGPv6z8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(7416002)(7406005)(44832011)(8936002)(70206006)(36756003)(47076005)(70586007)(54906003)(110136005)(316002)(4326008)(5660300002)(82310400004)(16526019)(356005)(36860700001)(7696005)(2906002)(6666004)(508600001)(83380400001)(81166007)(86362001)(40460700003)(2616005)(426003)(26005)(186003)(1076003)(336012)(36900700001)(2101003)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:18:20.8503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06bf29-b54d-40b7-86ed-08d9e2822ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
index b00dbc5fac2b..7c9cf4f3c164 100644
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
index 2c99b18d76c0..dca191739c34 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3089,8 +3089,8 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
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

