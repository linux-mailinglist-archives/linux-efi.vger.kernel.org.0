Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72EB44CC19
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhKJWN1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 17:13:27 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:28576
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234025AbhKJWLt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 17:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqM5uLcz6sXiQyWUvfSzOcwUa7tz1/DJAOBli+N2COL14mrdGg3JgfO+ru6CPLeNkfXnhsBjG04MXijOlw73e20568i/6GSgB5PAJT5S2JfTqyxVOuSFfOD1jdFdGsoLkEnbDvvajed1MBbchS9uMWDOZzaKAbHBt5nk0GrXdDEfo3+M7rNmmtKiga2qW9YEe0teZQRKcf22hp6Ppg9laDVGIP+8fg5x+h5cM7RULmWoi2x1koqLEegGj8LHItKYSpJCz5pVYLKPSlTE32THKJEP2Dy4KKS4H1AE2sB8D5sPT7IhuxrPZEM/FnchjnOa+nSduFQEzhkfV02NgsLjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=PSYMYsvnB8y4W66xaKWN+Ft+041MHdXd2/WGnXIN8Vs765m/fIChftDuprRSPSggR/zi9QvN/SRYeR+gPLXUEquZVViZr8aQtdHlML9AB/v3dE+f/9POorfOK2znRAhYfh597WfOAOserru6NRa5flGD6zd99ljUK3bYnpxluOT0a4eguhFHdnjRzIKd3Bjv9AuNYtGPGZ0O6gpm1/ntp9xGhwclmcptPWXWpVZA9jYErfG4WGS4lKrvqhG3wFtvSERjXmKUGHl5TCvlziaDWdQWw9CRbcH+gRbsZt4uj81rpZihdcCzrD8ZwnVhd/sE2W/TFVUt3KFsvAE9QI2amA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1VNSm+N6O8ORnpmAnlesmcUQ4BAIFMvgZy/+83ObY=;
 b=lrR78xdrGnCZ9NBjqDUfY931VlLx/Mah23OkFwt3/b+yqSOKRVi7nxKf/1KFVcDiTp6/y75HLDkXmHM1aTehAYe1PwrIz2tQACMnBiy3ocp2qly7qPBs/QB4X56Bpc29tIsB4z1jlwxEeguUTSRTNI+ADkC2jpFkQmA6VhEOEZE=
Received: from DM5PR21CA0002.namprd21.prod.outlook.com (2603:10b6:3:ac::12) by
 MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 22:08:58 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::23) by DM5PR21CA0002.outlook.office365.com
 (2603:10b6:3:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.4 via Frontend
 Transport; Wed, 10 Nov 2021 22:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 22:08:58 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 16:08:49 -0600
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
Subject: [PATCH v7 35/45] x86/boot: add a pointer to Confidential Computing blob in bootparams
Date:   Wed, 10 Nov 2021 16:07:21 -0600
Message-ID: <20211110220731.2396491-36-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 491af4ec-d0af-49ba-cb80-08d9a496b195
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4288158DB4AA7467EB2C3B26E5939@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCykVpSWVBSuj+U1/VyyNXXDc/Owo0DsjDGhcLznFCjJoQaesN+OwnRPW3tho0miUWck+GhfvD5wQ0OPTEhEXlrUw6bjyiVl2J/fSYFeDyXiK11fHm05138qnLLOKp4CtXW0lGN/XWYfChZKCcEyrEOnZdXJviEQjZ4bVJFNkRQPLUapZbBOMhDuqK2xb13ZshwP5B89R4E/iSAz/+SX+4XRxnSUZQvevqoV7HNXiWzFYjXW6EPalroxuANyRPGr39zZbBZw7C+HisrGFCSrSwwlFx86+P441WHO1+GioNfrC3PdgRIqzG3jDKDyssrWGXA3dqDLQDyGiKeVqEteuvuJqKU802uD8Gv6xjRKUXmeFwYx4m45WKz+AU719DgF7dE5YTFXSwcn76ogCj1uXfw610D5j9qEuN9vACfkG/a2OzcVQIIjpB0I3vaWCo5UY1AjowbDkkRSKT0dxH8uoUIiXikbnW00aE4fR0sRzCvKdgJRh42lHXDCNdJnl4jFGTM64xVinMKdp6AcqzESmkRzSY61u/b4H+2mhugU7qVYY9WcR7hwM61ePHUNONFFubDFUVi6l7gRidKTB84tRfOvBA1+uT3Wye9hbZGRKzwmUsMGLK/YVCRDRZuT80CQfOEem0xi7oLf0bg//LK4lvn9pRi2fTy88dB9cHx9hbO32jHuVn7WCdf+B5TCyy5BtvCAlSvt2F9WB4yk7bSAfwA8vcgS2MYe+oql4ekOu3cwrmkwmWfa+F2oDsV8oMsO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(8936002)(83380400001)(47076005)(36860700001)(426003)(54906003)(16526019)(356005)(8676002)(186003)(81166007)(316002)(44832011)(5660300002)(6666004)(7696005)(36756003)(2616005)(508600001)(86362001)(110136005)(7416002)(82310400003)(70586007)(7406005)(4326008)(2906002)(336012)(1076003)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:08:58.0280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491af4ec-d0af-49ba-cb80-08d9a496b195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

