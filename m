Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B549FF40
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiA1RUS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 12:20:18 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:14944
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350847AbiA1RTP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPCPyChG/5OcejA8wC8ek28i7M16Z9GkaE4VSCaLwWCv8464Ao64I2g7c2jT/BUpTOPike8p1Xlund3Oi/S8cH1jtusQAnxKDfWoyElJGYrpsDQGjI1noloNdqBwFl08zjppIkcqaaeI+ERim+kQYuZ6CYa+JWdBDWUWye98PiCvteW8kvH5+SG3ctMVAwnb/ffG94s+uM/VIRr2QBzlDjZ882bS4h+Bl3P10D1RTB6UVlFKeEDlEpPrJ7aAkWaBJjXCBG5/4KW8USpx38r/BEDhPeceO/XKEnaZisP55xS5MwiMuiisGW2TIZXVwUI9slL3dgwS05FZLfYVJc3bRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=n6GzQcercoKoalc3oqXt5bT1dskgbQo7w4S5J5hEPzVa4E96zMeRUrqvXGAU3ddTnOn9U66PiW6u1waGk5bCYKO6oNRVH1WLEWiDhspOhJUljTEf1xMkZfLU9/bjBkBz4VINzeVy8N/bfM0v7RJ+zf51jl4GbQ9EEYPjeFcgjzcJU92kz7pykpNNnZoOf4TbB5+CQtISuwhvtObnd49mIwqfWdNDQ0CHzLYSDHAqEYr9duc32pPjYksVq4i6pfSEMye60YKbnCr8lJipBLCWlg63hDf/OyyZnqyKVU9iMjYZkzPQ4d5rL/bvXNIGaV8SC1g8iIeQO7v6bRkHtHNikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=ycgHo+30LyToYmEre5LstYnWVzbgXpu0dVR4OnkWl0ZCNOMEiOnoB0BDLqxBUaPwvEW5kCRJn/6eW5DrIJyccwf33I/jvyZgKMsK6iiSmG3PUXXAj8nj/GeO8nYEMVRgznQiDEPtu0OajAHg7tGXFnb9a2OSe7bjFheAiYoYCI0=
Received: from DM5PR1401CA0014.namprd14.prod.outlook.com (2603:10b6:4:4a::24)
 by BN8PR12MB3187.namprd12.prod.outlook.com (2603:10b6:408:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:19:12 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::27) by DM5PR1401CA0014.outlook.office365.com
 (2603:10b6:4:4a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19 via Frontend
 Transport; Fri, 28 Jan 2022 17:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 17:19:12 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 11:19:09 -0600
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
Subject: [PATCH v9 32/43] x86/boot: Add a pointer to Confidential Computing blob in bootparams
Date:   Fri, 28 Jan 2022 11:17:53 -0600
Message-ID: <20220128171804.569796-33-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93e7616b-1c93-449a-b69d-08d9e2824d65
X-MS-TrafficTypeDiagnostic: BN8PR12MB3187:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3187A7BFEEBCB1C5F6480723E5229@BN8PR12MB3187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mh2JVl8r60oBOQL0ZvP48gOS0WiANEVYkHwFQ3iWQ9ZCNwbsm9LHJr91wLalWGwOPvi4JI1GhJvdjiC4bKGsybQP3pdY9I0UO3pZLjsKw18QPvVlV+Cqsd8x6G583D/Dfdor1yqOEZYq2ue79cU2Xbo53YFAyn24xIoDhwiVelODnapxe0mJpgMC+jQkUfyhciQxnMZ78q1UI0gPofUpu3o2NtHjC3ajFBZelSd+JUGvx0LHBbYDP/aEBS/XWlsdTzKh5QOPORyi+GjAUBciJlnK4w5XlCSS63qxnqwU/hApFmGjuqBDsY6ogurE6BgEy6Ua3P56HqWAnEqYRqY4s0HdkOtu7WL34biWr34LqzPgP4VQeDDzCLKwABBHGSwn8675CQ+vdAStG1UD3/kQqTvMAC6eh0a5rllh6MIALVk1QEqWbBubgfkyfrphTdlADCq6OqNSdtxRaLMD+9GKVnXA9S+iX1MKqZh8peRwaKnfu2l66O9XDLYLNYyr4B8ZPI6CuNmtwiSjqGF84dLkveJ6OsufyyNtNJpVY/Igq/1qpqy+PJiJ0Pie6TDGmkhO6jBbHrJ6Q5j/3VQZbB4EPWPvOSkhZ86McWUrOdL/GmiBrBG6m4229qX5Y51lxORibLih89L3pT3Vu7Pu1lc8qYa75mzEBQRIIXCsr1yrGuvh2mI/shyNw4knaAp15VvwFWCgRQnFVihYzYuqQ9SiVcSoKLbpx6prgcNsQ2fwozE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(47076005)(1076003)(36860700001)(82310400004)(336012)(26005)(110136005)(54906003)(83380400001)(316002)(426003)(4326008)(8676002)(70586007)(356005)(70206006)(81166007)(40460700003)(8936002)(7416002)(2906002)(86362001)(44832011)(36756003)(7406005)(5660300002)(6666004)(7696005)(2616005)(508600001)(2101003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:19:12.0679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e7616b-1c93-449a-b69d-08d9e2824d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3187
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/bootparam_utils.h | 1 +
 arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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

