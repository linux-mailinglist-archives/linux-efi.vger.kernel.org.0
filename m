Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543164D09F3
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiCGVj5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiCGVhu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38C8B6C4;
        Mon,  7 Mar 2022 13:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYfPwc2OTVi5cDqm1U/TN+BsBWd9UDl0yAzN1JZWSBlXo+o6jeiDQqKp9u0/FF42NChXwVPsErz1rE9J6hYFbjj8nqVIiVwepfOely8CeyOOyyyEH0At+qkRcYRvYShIP0fH8CJAM/Gwj27B+k/mSHOQoCUifing88Zb5a5ekV3vGZhNgsS5VUEgBakGTjiAxPMZgmJqYY7gXaaz5Bt5A+FJ0x5JUheIgAU7Bq4mRN6C7iptnqSVsl8g/cLgjys4KM9syNdd8yIazWu+xQERJyQvATW6HM58huN9k1EYn0nnM0O2CTRja2YSujN75uR+ivx38Vy49GqXwpzK7IHPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbYtPu/R4hZSC0fOc8BmZk5t0+Odd/LLecFlmc4pxCo=;
 b=f2+EOjJ/QPwFjN7KSMffSEbNpJ83UUqFPuSQNckREkygtShPrYGDFWqeNz/OvbWM1XIRCOaxqp/3sHORjC5zC/TDiqTma9R7J7iN1VILaD6NuK3+TwlLV0reqe3SEt24EJtGFGxlgEKVl7CGImJY+ysUGFZfxzpPnbaSDQ6Pux3nmhA6vAKzklrFABZEPg3TceopLGESGhC5uIdOSixPEBggHiC195N8o2IDvtv7RYk5OfVxTK4K2kD2MJzZkwARr3dwFkGnzEikFFpTwhHn979uNGESsPUNbQgxP3E6QD02lZQUuOolfFVGLpIrkSulFE6i86QmnqQ7CcPchqBaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbYtPu/R4hZSC0fOc8BmZk5t0+Odd/LLecFlmc4pxCo=;
 b=uoBIUFiZIxJuNDC5IhVzkWpWdqRxmD3GCsQWMczWdl2JRxUdbuMmi146HrJnYTVjfi+QH8KmsPg/gnuBZ6kOjJodp7fuVU/nZvGv8FE1Ag17thvLZR76swOhnMCLAxJ1AbXUZltxlLQXsMrmXV22Odju9Xj9T/SVfI3lvDAh9Tc=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:24 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::57) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:18 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 35/46] x86/compressed: Use firmware-validated CPUID leaves for SEV-SNP guests
Date:   Mon, 7 Mar 2022 15:33:45 -0600
Message-ID: <20220307213356.2797205-36-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cce0c59b-1a89-45c5-a63f-08da0082638e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1433D58830DDBBD4CB5D877AE5089@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD0UhYngMyrTyhoVnHCrC2WZUlYRq8JMEqZZ7yYe8TR5/sOCJdB0metYvu6U3HgAc6XOUX/lr7v2CaV0yQh3AR1PXJiboz9N2afnlF+hiRHhprB6IotW+3U82evP9MJMTsW8yI9LEmIgCPG/CQdpK1JsjpioAVLO2Av2XCeywsZyrtbipaRCb7NbTIhu7RoJVIkWLudjh39yvecygrbLt1FZqveumCTTYwiEO3uSf4oGmS7kvDexTgPaGPCOCp2Ih8UJaQ6Le89HChvxS5CfcYRad2pqRQsOcqHvtsdGX743blnV3Hl0BhQBrfVcDGVuKhnJvkv1Wz75NSr7TjRr9JGOWeN4HT0V1m0u8VE+i7wDahDtBY8LrS5hK/rMnf+MAbrdNeIWFuUzge4nSykjKTguh5dtKCmhR/Mmhv/RxmEtQbRstvOmFYghV5i5ThCQLH1LxeM0OqtDIYTspaiyz8s6H+34xAfZutNarfYgIp7lFQRjEF5wgsQfQ8SMlUNfeSCTvASHtdcL2kqOhTXPqC0xLMNDDGaQ5/d4crZzKS9tXLy9zipQX2zB13fAz6mthlQQK5wfRCrU0JJVWWuglTaV/bhxow7x4ioeGKeDmhgmixVFSzvrYn9+1KMw2m80fBcnQJ4ekCNpV3TWqQ9wJmlFJvIDHTppiMpFd6TnkH2frX5b4TQkoFIh2TyvW6GJzU/SRX+nmJVZnrmhELZBr28Nn0WJnoX6X92JYwPhsHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(2906002)(82310400004)(81166007)(7696005)(36860700001)(2616005)(86362001)(316002)(47076005)(70586007)(508600001)(70206006)(1076003)(8676002)(4326008)(6666004)(15650500001)(16526019)(336012)(26005)(8936002)(5660300002)(186003)(83380400001)(110136005)(36756003)(426003)(40460700003)(7416002)(7406005)(54906003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:24.1763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce0c59b-1a89-45c5-a63f-08da0082638e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

SEV-SNP guests will be provided the location of special 'secrets'
'CPUID' pages via the Confidential Computing blob. This blob is
provided to the boot kernel either through an EFI config table entry,
or via a setup_data structure as defined by the Linux Boot Protocol.

Locate the Confidential Computing from these sources and, if found,
use the provided CPUID page/table address to create a copy that the
boot kernel will use when servicing cpuid instructions via a #VC CPUID
handler.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 9e281e89037a..42cc41c9cd86 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -408,6 +408,43 @@ static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+/*
+ * Initialize the kernel's copy of the SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SNP CPUID table used by firmware would
+ * be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+static void setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
+	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table = snp_cpuid_get_table();
+	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
+
+	/* Initialize CPUID ranges for range-checking. */
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x0)
+			cpuid_std_range_max = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			cpuid_hyp_range_max = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			cpuid_ext_range_max = fn->eax;
+	}
+}
+
 /*
  * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
  * will verify the SNP CPUID/MSR bits.
@@ -423,6 +460,15 @@ bool snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	/*
+	 * If a SNP-specific Confidential Computing blob is present, then
+	 * firmware/bootloader have indicated SNP support. Verifying this
+	 * involves CPUID checks which will be more reliable if the SNP
+	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
+	 * more details.
+	 */
+	setup_cpuid_table(cc_info);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
-- 
2.25.1

