Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBF427081
	for <lists+linux-efi@lfdr.de>; Fri,  8 Oct 2021 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbhJHSKK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Oct 2021 14:10:10 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:53208
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240328AbhJHSIQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Oct 2021 14:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRC0mpMw6xfgwH1wtLKvAyYgHO3UZgIbSft6NM7Ci08MJY04UHPprU5ZjUbSPCjUPSkJJ95PA3GclqYVb45Qo04IwTDem+JI05O3/nHW2ubsNSf6aDXQy45JeMEz5Fm8MWoDck1nzIELR22Da0OlH5ZvP/I1nAq9oqTbSnQBIO4Svf67eGUtyEpfuV/Vt90vslOi45X3iAlh/LExjx7Te0VHaKE4yllVpVWOkiv+mTTXu3W91CFYrSlwY1XdHm7PtDH6LNmSSQAK05hYMGO0VWI2XVSEt+kSjUvibvrZnpVOSLjzzgNuA+mlXjv7rwrLUgxdRgkuC0o6S6m3vFFHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=mLRGYMeCyy5h8+uHQTI58IWMY2dmb0oPXQVUB6g7MaeYMXR7qiyKXn0vybBh5eL1n/oRXsbjVHf5TV4t75dKWITlN/nWzTDS5kN2Ja437k6KoYzK+sml3p0D8aCn8UkpfNUl8ia0ahteCJ8eIHxnsZOH2b20qEL1OPsRb75W07y1nDDToYDKpLOEDtw/W8SJh6+oUkBWo2ZZUrcFkxSCF4cVwmaqOQZDvq0ZlxHxIPEF4eW/R+O7EOblZTlFRo25UrcSQkjVsbqs8ue6wj1BLfYNPpol3I8f+iZJarYKuJ7B7GpV8Wjf5LPhINAJGQnrTJ4z2bHJh1QtYeC7xXM1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=wDFwnxf4T7Uk6VAVw/tc26CiRnJobWGsuvafRDEW4ihMZyDFa9e2tQGeEopAhQ9tULA+JzcUQmQPRcEc3D7KUPPPL/JHEOjwRgX1Cf44y5g6Ciy0WI18ANpnswmNTdHDqjfcoRmmesVr6tRDDiKJ0NkZ065Mr6+6LgxDL3EAikw=
Received: from MWHPR20CA0033.namprd20.prod.outlook.com (2603:10b6:300:ed::19)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Fri, 8 Oct 2021 18:06:17 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::46) by MWHPR20CA0033.outlook.office365.com
 (2603:10b6:300:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 18:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 18:06:17 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 13:06:08 -0500
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
Subject: [PATCH v6 34/42] x86/boot: add a pointer to Confidential Computing blob in bootparams
Date:   Fri, 8 Oct 2021 13:04:45 -0500
Message-ID: <20211008180453.462291-35-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008180453.462291-1-brijesh.singh@amd.com>
References: <20211008180453.462291-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914c8814-9c8c-47f7-8d81-08d98a86532c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5430:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5430D998181942125C4EF4F4E5B29@DM8PR12MB5430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssHDQhHk67gXk7OVD4/x+tH18SmGKfY4BMx9pZWvthOa9gMkxm59YfGtU07pCwpF0Ck52sKjNMtonR7jqo6p5JYvBTgxawFk5K1bgOvA29DmskVxXli0otIJq23RG7btJLQDL/jmQd714DfGfzdKCSTKaCui1mfMj3O3L+uZD0BG2IKZneF9IQJtqNaSryoqCfiz2EAXZgfPPkX+KdLRl6GYR68rcae8NN7JQltcWtR2nJZY3vGw09sjJ3iQJ0qUnVgqKMJZXaPO9lZjmssShMULtdR3/T9HwmKjEO1O8z1hEPUklQv2WCTqnpaAsas4K8UGLDV80sRo92UyIyd9lK1znM1SxCVIlpU19P3wLLThdyMjaVDpqsEPhYnS42sMj6ikoSlTiBHN/H4neu56OisN82hkwpr45uoWCsRFx7SHqB84JE9xA0VKuUnJmuLP3fj7H1X8UTqxpYCWvGalMxattoh7cF1fhQOEUN0IxCXq9zXx9oKqV/nzC4RzTR9GKdd9l4BEeAUZK+7mg3SP1WnUKoPmsdIiB2nMMTIuCzx9X3pQMK1pKit8QqfjfJrrVRTS3HGg0ZWFHGgNq2jpW9/qrpfhcn9Znwk1G6RVGfEMY0YbfjDuUCKg7n+y1ZEHmGUoUAjvv2ww6+J0M1DJZmM02oE80dPYK0pfmXNbKUxnRj0dvkS+6jsKyWxS4ByNvnyFUHYKWu3JOGeU7mGbwTUPearwIGQsQAF/aix+OIQnInKAHC4Kg0RtWJBcYUGs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(7696005)(70586007)(2906002)(70206006)(44832011)(36860700001)(47076005)(110136005)(86362001)(54906003)(36756003)(6666004)(508600001)(186003)(16526019)(26005)(7416002)(7406005)(8936002)(8676002)(336012)(4326008)(426003)(356005)(2616005)(1076003)(83380400001)(5660300002)(81166007)(82310400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:06:17.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914c8814-9c8c-47f7-8d81-08d98a86532c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
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

