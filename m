Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5844C32E5
	for <lists+linux-efi@lfdr.de>; Thu, 24 Feb 2022 18:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiBXRBr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Feb 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiBXRBO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Feb 2022 12:01:14 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2081.outbound.protection.outlook.com [40.107.96.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03263BF0;
        Thu, 24 Feb 2022 08:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQWxskXTemblwQQ2pKl1wCFOPw9UHTVwu3K53gLlnKUxRzpLowtGoMf2VTaLzOKJTRbtXK9RNtltryhwWRu8htvfrldWXwpmaMqYdTPFWC2RZv2UiDGeYNUoZgIryZBmGKXTkki65glktgnmlRt7mfspBjLM9GZI71emjV/oz3eg+5KBY1Je7exa2fIyltfLsDuT98ZfN5CkV7KF5gJI1wiyYbCiNt0rm2uFF2/eg3m6uEcXhKzYCfqYHBQxVRmPnZ6pBPWtI7L/XRzlAZdPh0beiPvDiyKsDrVPaCoPu2ywJ9cv2SM7uNOO1lkovfrdqfCrT0Vj2V42N5Y1X6z3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=iy3pHr919XmfnzVRl25/BhZaLLj288FXfeTrdO0aUahho3pSunmuTWfWdxnJkBSMe2Rv9nqA0FpiTJuWJDJChiMpwXTgwgqrlRz2Why56vVUFk0LHGmxu7uZ7A4kRnG+9Wlf7LRIJqNIlzbXcRdiixGloT/88gfs01k7UcaxmAdXaAmLun2tGVaRIn2cAxc7z7l/FRj0H4Y3h4ATf6swLMs+Yje9ZsynrMRcBOw2ezHN2kDrec8xWkxTdhaOcMtkQq/2aSk1cI888rSP0YEQ3u4g/0B+vC4/hOnhw2oeGDwNphGC6k+MfVWgIDR/zGkym/+mxlETCAWefc4BE68jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=J3mrX5QDNsVsCK8bk+7kvZD9fxy90bvifFgMDdlHaUj2ipdrZhc4UsC+4XGJ0NtHUTFcfSfhUi/2WGjU+ldT2bcew6VWg4WLv2QZY5mvAsHjlYVdTBjgrIFAaQx2JZU8Ks/gIxyDbYF+hymDeaNGCQeRKfCCMvKk4lwJw1WbcO8=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 16:58:58 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::17) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 16:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 16:58:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 10:58:50 -0600
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
Subject: [PATCH v11 33/45] x86/boot: Add a pointer to Confidential Computing blob in bootparams
Date:   Thu, 24 Feb 2022 10:56:13 -0600
Message-ID: <20220224165625.2175020-34-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 756420a6-e4f1-4964-5a5a-08d9f7b6f2f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4145952DF817892E8B1D4B2CE53D9@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tzr+lrg8D53VlccZvIyN24/u+FD88/EhThGnBkTPLcRMBiCCFSw9Eyt/pvLMGisfZywxtvzWzr19JYlpdPmUVOjj63zF9QE5uXEs+hAtwPbK2jHERkHV3hL89B+acfZqQhkquW6eXbp5gM2jDz6MeU0DX9m0uRvdflBcee/JbgZkDqJ9otqD3mKPnNB5FUzxkyhQTr9BsmFQgMYojXl+biEPEww9YxJsnsosjFKZ//eHefDapHGe1Z9m/GfKv9wD1PuK5eNUs6jgsquqfSJRoi7Ni8sipcPiCfP5m6o9+BBUNHoE5xQrwtQyN2DVO28ilLAF8QUuZBlCJsNf0Ag8VJbHGhPLqno9kbnpwBtJCNxBRvv2Ec5oBfrbrjY9d1e5L4N65ugymf8BkwgUprIpD95ZcjJbpmMLiyPdD84wjQ3PUutYtbF8Sf3HFKnnJBFeLgPQtFzm2+csy9temdPw9VbmtOb80UyMlj6XvYJ35oc6CxNNgUmiZmrPyLD/8gyDoyAmdU2jA+VNEmCz1TmrAZQhW2DtbTPR5VxG1Z5VcqOWfG1y6R1ShZzq5anRId5JCVlsGYysA6Wug50VOq0VswNm7M4OhrAhtzCA15azwx8pmG4/U80T7VaxuAy4HU6ksYaq8SGwzEQxRRv0hpYPRpsYXr0gLKHOQvQ3lrlyF00bgTajnAOv1+gmPK/ZgU/JakLNIZUa2xIjTiOhoaSBjggeSPo4jjQy0pYeGAmbhPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(186003)(40460700003)(83380400001)(47076005)(16526019)(1076003)(2616005)(426003)(336012)(7406005)(2906002)(36756003)(44832011)(86362001)(36860700001)(7416002)(8936002)(316002)(54906003)(81166007)(110136005)(356005)(70586007)(70206006)(8676002)(82310400004)(4326008)(5660300002)(508600001)(7696005)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 16:58:58.1013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756420a6-e4f1-4964-5a5a-08d9f7b6f2f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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

The previously defined Confidential Computing blob is provided to the
kernel via a setup_data structure or EFI config table entry. Currently
these are both checked for by boot/compressed kernel to access the
CPUID table address within it for use with SEV-SNP CPUID enforcement.

To also enable SEV-SNP CPUID enforcement for the run-time kernel,
similar early access to the CPUID table is needed early on while it's
still using the identity-mapped page table set up by boot/compressed,
where global pointers need to be accessed via fixup_pointer().

This isn't much of an issue for accessing setup_data, and the EFI
config table helper code currently used in boot/compressed *could* be
used in this case as well since they both rely on identity-mapping.
However, it has some reliance on EFI helpers/string constants that
would need to be accessed via fixup_pointer(), and fixing it up while
making it shareable between boot/compressed and run-time kernel is
fragile and introduces a good bit of uglyness.

Instead, add a boot_params->cc_blob_address pointer that the
boot/compressed kernel can initialize so that the run-time kernel can
access the CC blob from there instead of re-scanning the EFI config
table.

Also document these in Documentation/x86/zero-page.rst. While there,
add missing documentation for the acpi_rsdp_addr field, which serves a
similar purpose in providing the run-time kernel a pointer to the ACPI
RSDP table so that it does not need to [re-]scan the EFI configuration
table.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/x86/zero-page.rst        | 2 ++
 arch/x86/include/asm/bootparam_utils.h | 1 +
 arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f5881666..45aa9cceb4f1 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -19,6 +19,7 @@ Offset/Size	Proto	Name			Meaning
 058/008		ALL	tboot_addr      	Physical address of tboot shared page
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
+070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
@@ -27,6 +28,7 @@ Offset/Size	Proto	Name			Meaning
 0C0/004		ALL	ext_ramdisk_image	ramdisk_image high 32bits
 0C4/004		ALL	ext_ramdisk_size	ramdisk_size high 32bits
 0C8/004		ALL	ext_cmd_line_ptr	cmd_line_ptr high 32bits
+13C/004		ALL	cc_blob_address		Physical address of Confidential Computing blob
 140/080		ALL	edid_info		Video mode setup (struct edid_info)
 1C0/020		ALL	efi_info		EFI 32 information (struct efi_info)
 1E0/004		ALL	alt_mem_k		Alternative mem check, in KB
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 981fe923a59f..53e9b0620d96 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
+			BOOT_PARAM_PRESERVE(cc_blob_address),
 		};
 
 		memset(&scratch, 0, sizeof(scratch));
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 1ac5acca72ce..bea5cdcdf532 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -188,7 +188,8 @@ struct boot_params {
 	__u32 ext_ramdisk_image;			/* 0x0c0 */
 	__u32 ext_ramdisk_size;				/* 0x0c4 */
 	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
-	__u8  _pad4[116];				/* 0x0cc */
+	__u8  _pad4[112];				/* 0x0cc */
+	__u32 cc_blob_address;				/* 0x13c */
 	struct edid_info edid_info;			/* 0x140 */
 	struct efi_info efi_info;			/* 0x1c0 */
 	__u32 alt_mem_k;				/* 0x1e0 */
-- 
2.25.1

