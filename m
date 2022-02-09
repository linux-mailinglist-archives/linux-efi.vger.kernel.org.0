Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0E4AF991
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiBISPA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiBISO3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131AEC03326D;
        Wed,  9 Feb 2022 10:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTMn/1mls6nn+gZnoGJEyNzZ3aOb4Nbcz9fOu7vY5oj0/M8TNuzyGA5ryjuArlWL+M9pBmXzOlMZfNxC8QIKZm6WLKCMPj+j64sbux/y+knHrk0OcsiQ7vQl1Dz/9yKGdhR+dD1DTeyjHrbOxKUxX9K6LrjNCjlaiuZbnkakbgJhp3RNmPKplRLkgiDXYOguPHqQCXrwztGL0Ved05OEXe3iO8/jdT8eMegdshqrbPhdADiA6oKyaLheWui8yA4MQxrEbGTH/d2S7TXuQl7dIhfwkdrGiyAZFrvMQoVQijsNTstRxIBq+Q68EVTFqAV0a4jRufH9qAtNiU+ls1/O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=MTeVHvzqMs2N6c1fw+e7FMX1huVHeb9IWJW+ks/VCSLkSgcAJoM6yQNyh1roCpKRcwMUPmviNS/JXpn+kXKCeJV/1VmWTnFGuYpcn+zJBHmfwmpGOpqJyp/om1d0AmDryHxY1a8vY1iqioTZWfjw4xhN78Uffw8CvDJQbvXa5dnBmWveUJnfWQZxW4qdCYwRKT+skC0rh4okjFj+O4F2UUlfAca1x99XL0OmnMYIWkmWKbyh+SmRwl6KjZD10TtwNmpaTvsFm+sYABrRXm1o/CjbLfhBw1w2Q/GZS0THUF/J1EkW/QysbCCXIZ8zBwfcyGu5Fx8r8CClHs9as1owbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=Fs09M7vLs3pkHMWOEQpz4BEgI0LeLKUsnRu+Z5D3PPMKtIXgfF4DCc/NKsvqkAcyM/Ku5qBK4hAKLT1Va96fU1wWxhHQJ9fqamdBA2KnPSWcH8HSx/HiSNagvgCWtFnoi1O5l7/JHWFHkbCKuFq3DJnAVag++D/kZOFqPdUcxVA=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by MWHPR12MB1935.namprd12.prod.outlook.com (2603:10b6:300:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 18:12:24 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::82) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:24 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:22 -0600
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
Subject: [PATCH v10 33/45] x86/boot: Add a pointer to Confidential Computing blob in bootparams
Date:   Wed, 9 Feb 2022 12:10:27 -0600
Message-ID: <20220209181039.1262882-34-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6b6305a-a3ec-4a04-8745-08d9ebf7b938
X-MS-TrafficTypeDiagnostic: MWHPR12MB1935:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1935D1BE8BED21994D1180F3E52E9@MWHPR12MB1935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+kF9334jq313Dez9odu/fat/WqFzYwmgSqOqwlP2NI8zQI9jmma8IxhNtfHRDJ++c01k89HRb5hH0xA6JR2TwaRiVerHCKVXywbR+r245S+ICGLRBh4S/4t3Yhe0i9v+n9JATh+mAozhHTfcwh2qHk3YW/2wWdkQ0ABmKKr8VaQ1MaWpci+cfryF8uOQRv6DypMVlcJYinX6Z/9K3fYXT+biEKbq6umTkLJQl5Y8Os8tS2Y+TQeeVqkzz+o7TIUbGSZAbxHKAbTuAQ6VKa0et9WSeLllgdNjn+Aj2ItvXPL08aEddYL/QygwqR2fI+0hpynBw8xyyr4kYzWBiF2agxng2mNmcS9psyxVnN8m4bY1/lkWuy1gGbnhVP6UnOuPANokKaLjSHvikhEAXKzXdWQXKFPu0A6vKkxFDA9425OLzy7EFI2Y7tLalmZUa4GzazBjrxlFx8s2vy2jg4dE8Rr4crcbqlrqnlzyfaCMCdn5er9eRCxwXf4GdvdscYkIIiClQmzxXihWKBiizB8vZdP0BVYaaNquTb9wnEhVt6MS1Fos3nnrAfMMnekFQqEQ7AeV4NmpRxczMlK3nW8v6QYdS6ILbfjWw4jJAar6A0swy29/K2Epu6Mf6VdVsf2g0outY6+97Am0hrVCBmwn+GEPHLxWe7iqViHbqP4VwD0EJdE/AV58D+iMfkNWRcdFwZGFnZTb1YoTUDLmFyp1vbiHD8jVGZgbSfdjOYjo1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(7406005)(86362001)(356005)(110136005)(54906003)(426003)(7416002)(5660300002)(40460700003)(336012)(4326008)(44832011)(81166007)(16526019)(26005)(47076005)(82310400004)(8676002)(186003)(316002)(70586007)(1076003)(83380400001)(2616005)(8936002)(508600001)(2906002)(70206006)(7696005)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:24.5793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6305a-a3ec-4a04-8745-08d9ebf7b938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1935
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

