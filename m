Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F54AF98B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiBISPP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiBISOs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B3C05CB98;
        Wed,  9 Feb 2022 10:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV/bXaJLuhusO7smL4ixwoJkkceqLVqLkgZK793fu6TotACF/hrLahHaqUB2L2KKAgl48OI3p6NZDvheBj/T4kIfxMS3ZyF1ipEMJLd8J/8p6dNQUadYcx4BX9gf0TglP/ZRRRzU44qxMiLe4pnnH7o66bObllVZohaTbVrzeZQh8jcmsbiCAoXPhIgJRbQr9VWvlTtzLwla3wzS9n0umsmSyQxaoCW46BDkpA87tAmcHV3MVItIHcIkVoDHkCNM8wCmy4o9TYOoV7xKcKWqGXvGAMZkRB4TFeXMxol4k34wRRm+y9LYS5k6u+5SbjVIzDxRSKG7Pu6+ZFp05l0DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=GNT1JlXw/CNsd5Ak7GP5uFwoGI62fUWnrqgf7FyK3qkH1y8ag9bXjCCwlGGPgDnC3ef+IjdH4wSEQdNF6MkrL9ZCpIThY3uMa5NW9mTq8fw05D3p7iLo2wDQuzzgKFWcFnfqx/1Rdbxzmi5S9BOINq7hclgxEPoI+BSJCS7llqCJ3/iG4Rm449WvKnPf9vo4x0FQy8JNli79LqqzoAPQIwn2JD/YqdGhgw7zQuxCsq5ERyseeDY4tTZ7vtHrxnLKd40NES4VO5aNvwT7zkeSQKcz0MMatWLkrdSk6iy8RG63Boqn0NBwRC1p4iz4mQTjaERRyweF6pXURllBGfh9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbenN1LpxLpo95p6OplkLT0LTZukBi/3ahTKSZ4gJW8=;
 b=fQOGTx+KS+OGGZa5U1PhR9YPEK4PdwEGn3TKyUDMOBLtJzOHfynXXAjzJ/l2vKXsgiBXCn+pmlH6g5PGho9ZlZfi+8sSv/Or5r/3NIMewBEnoNROPdOPAj0aj2p98faObdKA1VJjH6DHCxCqpbkhJ+EYnf5AQysDC/Yh4HmgbcY=
Received: from BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::20)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 18:12:32 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::26) by BN9P221CA0015.outlook.office365.com
 (2603:10b6:408:10a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:32 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:29 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v10 37/45] x86/compressed/64: Add identity mapping for Confidential Computing blob
Date:   Wed, 9 Feb 2022 12:10:31 -0600
Message-ID: <20220209181039.1262882-38-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8b4f35a-b363-437a-83bf-08d9ebf7bdba
X-MS-TrafficTypeDiagnostic: BY5PR12MB4100:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4100B339815707D78039D824E52E9@BY5PR12MB4100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lroJYFggPorqcpuIraphS3Ft9a2nouRXEB+xJLCtLVYHbW4zLJh4HO3sv6jGN+ysBIrWiIBR/ATK1MZyqxi+EESf9yh8eo9NvFetbh6zMRgvTWxDOQt2c8JSpGGVhM4o2zLjBLxX12wpPIDiGrEkIMNLMPeqXPtthalpSdlo3GyFMq/1vagpvuvPCl2QulewaIhIH5R7Qby6UuDK2R3IW0Rkh8OMqnpgeCQuNG/6xF/Ugl1Nl1hE4yPElAD2XGtsWVNFcHaECU5MH8s1i2cqrt/9Py1xh2HLbJ6pmJ5XNe9DCSjlbGOSJpRLOhMn8CzLsUvv/KHJBXT41BrtI4xFSdY62++8Kjur+11NNbnq9x0w/Efxlgjc/gY8XSkahE92wxEmtvHZcBkeXVkB5d6s44xPXJO3c8wkrEaK4nvKy9da2iUT0nXoFog/mdZVXZLoBjQz021e2UdwFfrcM+9nG0IS/PijezwUK+wEmKARA3ElQ2eTOEE8CFNxUEbbzhhFSQRMTrVWgeRkabXZv9aCb2UZu2PRmcdq7L1AhM5XvpnJUvQp/ZbejjDh4uDgj1l3kanT8AnHeLOPIFZ3iprw+0hRYw81SYRnfRPbssEYp95kiCTpAGks0WbtONH1ws8LA6AQctFGWyZRNiL8+mmq5sEnrbssgvcTGZm2aNcWjnnI8D5XX9oa7eC5MDwfFRha5aV6X89TTo7L7LdZxoDxV40wr5WnSn70cQLLAZVRsEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(6666004)(7696005)(40460700003)(2906002)(70206006)(8936002)(70586007)(8676002)(7416002)(54906003)(36756003)(508600001)(82310400004)(7406005)(44832011)(2616005)(26005)(5660300002)(81166007)(83380400001)(16526019)(4326008)(1076003)(426003)(336012)(186003)(36860700001)(356005)(110136005)(86362001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:32.1421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b4f35a-b363-437a-83bf-08d9ebf7bdba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

The run-time kernel will need to access the Confidential Computing
blob very early in boot to access the CPUID table it points to. At
that stage of boot it will be relying on the identity-mapped page table
set up by boot/compressed kernel, so make sure the blob and the CPUID
table it points to are mapped in advance.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/ident_map_64.c |  3 ++-
 arch/x86/boot/compressed/misc.h         |  2 ++
 arch/x86/boot/compressed/sev.c          | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 7975680f521f..e4b093a0862d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -163,8 +163,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps(top_level_pgt);
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index aae2722c6e9a..75d284ec763f 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -127,6 +127,7 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+void sev_prep_identity_maps(unsigned long top_level_pgt);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -136,6 +137,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline void sev_prep_identity_maps(unsigned long top_level_pgt) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 42cc41c9cd86..2a48f3a3f372 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -478,3 +478,24 @@ bool snp_init(struct boot_params *bp)
 
 	return true;
 }
+
+void sev_prep_identity_maps(unsigned long top_level_pgt)
+{
+	/*
+	 * The Confidential Computing blob is used very early in uncompressed
+	 * kernel to find the in-memory cpuid table to handle cpuid
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		struct cc_blob_sev_info *cc_info;
+
+		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
+
+		cc_info = (struct cc_blob_sev_info *)cc_info_pa;
+		kernel_add_identity_map(cc_info->cpuid_phys, cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
+	sev_verify_cbit(top_level_pgt);
+}
-- 
2.25.1

