Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085084D0A09
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbiCGVj4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343613AbiCGVhs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:37:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F675E6C;
        Mon,  7 Mar 2022 13:35:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdEkVjqBJ5ARV6ABcj6gHLedWlsvKxqyBx0GjK0C0mqILLmz8+z/N2vqL7mhxnuQbw0Gt5ttvBYq2y+RsNZLEcglhf8x9eFyCb04rfZbzL3bgx/jwU/23B9VpycemssxAocuujhlQgcqnRt8O7PIOzjcPNoAEChEVdcUTNSWEQHV5NQW025haiF6CorJ5/FHeOtDDduemZ0vPHyvyfasPZYsdzDC2tYaSubr45cgj5G2A50QM5kpUzHtCYNaPXFQtDw4uMfEJGY1BTJIRVbSsffq79EAXJHhNP1NtmBrPZ4woCvv1F7VDGvG92I06b/K0GLXe++3Fp09Vlb8F+5fcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=BtaJ+QACa6Igm2C8TWRpruT8DRS4+2i3W14fzb4ae3WdKGNmOSNM1Rw9qYiIICLLOEUjHWxSR5ZhkNoV1foejH3lhs9Bnv7nbQD4ds4QyxYdKKcRMoUI8O+48cxUFiRhN0VjXwTTq6bt8iMd3NMkAG75MtD1dRXPZKok+yGJKMBChtk5XHmr8yaoXu1NPIDvN40fcD8kat4MNyYG3+2GiUmJ/8yhQb/hBpuMQ+OJj26b51dzQhkOVkfMkFvFXQJUmGWZu4nImvB3Y1QwR8h3boFaZfcWYj2Q/KNSXfwyUUzEVuYg+8oneIYUt/Isj+64UGmtKoCMnzP+4AQue/guwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROVC6Dlv5LcS0CSnBzw22q0dJBQB7GHMlyI2WLNxpUE=;
 b=PRBmLG9fcy4Rv9UiteRUs+n/7e4JuAKgILgD+ydwhTGMheA1AK/dJGXweiPZku5+SLj8g1B9kUOSWtb/KF7aCwx+ulAEgFAuX0dAj1sJT2Dupuwahli4GKRBfHubS7YCUifTqgAh217ToMJa465EGNQeyrPdWUjdrkpxivGV3t8=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:22 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::82) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:22 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:15 -0600
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
Subject: [PATCH v12 33/46] x86/boot: Add a pointer to Confidential Computing blob in bootparams
Date:   Mon, 7 Mar 2022 15:33:43 -0600
Message-ID: <20220307213356.2797205-34-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bca2664-5d24-4fe8-e17b-08da0082625f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2674F845D6FCE04A26EEEF3EE5089@BN7PR12MB2674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCbetWe49F6DInvGg3BkhfRbjnqwM9Z/m51QEfNVaayE5ztXut/jfTWICBFRb4erJwQIUYOmOVtf4emVZzY4O9PJAP9Eqjv32PDnxfMnu1Vk4nmm+HW1LpCixNMXHIH8kqFL1uqL+bkykSSnth4pKckHNiB9pt5m8kAcYWanDkj4zZWADRoD1Fvut1dyl8r9jrKfuyoRcVGmnJOncc9rCfIA2LLh5fGxP4ivHlEwRa4vXd+8CmJtBY8CiLPzcBWg79j95aqAinuwQ7tryM8oB2igx/NHijnVHjz8ZEKEDJqIMwANPBUpGFC6LvRpfxxfhFyeNOwHjDOzBeM1KHOjqhCP0kzpUDz+GzEXzq7Thm5wyMFb0cmgC5nWzOzEwns+epGAaB5WPzgAb16TUnrK6O+jZNZ8avVCtdnPoqTwkmC3LGa8znfdvvn9f86B6fKmvo+sAcYGy1sH9FjyrcAD2Qslcvc3u9RBDupJophW3Xz3S9Hvi2+RPJZmqyXvbqmNglBkMKT015Ju19BW2yCE9yIpoIWKCCjA4UjomJ0QFYFBrPfVVUmUBm4Ln8/R08buGsNtMDIK2YSbjz1AnbRYN0kkAGQC9ndlKSJd/5/e7Mr3wsIPXJbAljAG6ZHF8J4U2CdSyXpmuzTpJg0rkVRcSlKpws06j7bvtLUkPNM/mGBTP9MR3BrjU0fA2/QMgmIAruk1CKEZYmmk2+eCxF9z+EuuvikRrxK3AtqLL/t74nM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(7406005)(7416002)(2906002)(44832011)(36756003)(508600001)(36860700001)(6666004)(7696005)(426003)(336012)(5660300002)(26005)(8936002)(186003)(81166007)(16526019)(86362001)(356005)(70206006)(4326008)(8676002)(1076003)(70586007)(2616005)(110136005)(54906003)(316002)(47076005)(82310400004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:22.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bca2664-5d24-4fe8-e17b-08da0082625f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
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

