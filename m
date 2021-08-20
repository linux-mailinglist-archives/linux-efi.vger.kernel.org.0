Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29CA3F2F3C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbhHTPYC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:24:02 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:18017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241475AbhHTPW5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl7InRnriP4I7uNPiyvK5QQ0cn+tJ5WyPySw1cn8V3jzZbR73bWvNwTEXzod8nRNTYIJD6rZ2scszBQXYAyhKHw9AexJLcKx7jgvSJS+BBncxFfTN5Jbd+DbKDLSuZREM5++jdH5bJYp+eAI+1+7WJI5aLj/7Gu0tF2UC/UfLE5LcUS7yr3iEqOH6J7W4whOnwcl5GsvVoB2Ckcg+htxlSrSAUhfYUA1vPwMJXSXBVhYXzyW8kehZwlmuxEOLroA79Q5nEeq3yRK7jyvFxU3ry6dEZGclBUZ2RJJSlDPSAk7TiAAF4wbhSK7NDaxwB+UUoVKgwUcJaLRb726kM5QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkU/foi/ZGV71ZkywRRN3v/j5D2IBhlBMTCjHQgFerI=;
 b=WfgfmILtID+WTw3i55QuuQfQCAbWBiOq7vCBZ9fd1ISj85tRzL0P3izaMNssiUR6hwVVJYjAayHGdKWGfTGPnZBxh8UGsk2Fl9KvqFdUscphOpll283Ev4YNr0RyGuPk+nuAyqHWQC/l/YYvNEJ13vhFf/NH9SU0uZGBIyY0fO5lkdyzB6EsgP2u6LoomTSihRiVv3u392UImLq95zZ2aomb/z7RzDaOTe51S7ksnbG7+yB3QOuiCNPDUX8oy51DiZ3nnUV8zcer+WZtzZpYtCJM5JGsumLd46Sa8SA9PIQgKMT7TULfD+Mp3UAkTKBdOPUORD/Wrrgz1r3GWtSo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkU/foi/ZGV71ZkywRRN3v/j5D2IBhlBMTCjHQgFerI=;
 b=a9yOsTBEm1Jg13xklWAm/tZffNyod9jrPO7Z2mB2qkPSgoAzi4xk8D5mGx8WVkeM1W0QG138rf5grgEbgCVdCR/XW6k1b5s8x/e9Z1D7x0lHE87C/KILx+nzC6fQJcfAIK7YFclqkmN0V37etOD+3xovAT3gnd6MAtEFpY0djec=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:26 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:25 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 29/38] x86/boot: add a pointer to Confidential Computing blob in bootparams
Date:   Fri, 20 Aug 2021 10:19:24 -0500
Message-Id: <20210820151933.22401-30-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5928fc55-154c-46bc-1a32-08d963ee2c79
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2638A0FA9834EFB633C1D3D6E5C19@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7y9KZKNQyHjA3X+12KYfPl7eW++JRPQlW31tiF51YfrNMtPv3NoraNTlEqrD/QUXJTbqxyk6MerETe+XluS2HlgBsjYSZuXpQEY2xRcCCMa4+4RoACUFrVzOreUSha+tPp7eHTtNYQGATAQV1+9ge7/lutgk2JebzH1pjrgD+CvmsoiFcQxwUbaCr8F1fxYJNFuGDoWOyibw2pOr3iV8QZVnKqqImkh4fw27ueTqA/55SegXON1iPM4bq3UPUkPhbAGTVg+jpF5t+vBFq3o7KaS0kDHdNf6FaI7qf7QMnJ8Tt/S5HaA43RZp/ylXPdi4t19gI2Idbg0FRw117aDaggm87s0tKQeeTCKMibt+BKlJjabL6f2zeCJfnqg7j14W8/5EeEaWfO82F5U2UXfx7Cpx2842AQEhSRUrMXbGuU4Skse5q6YcbiuTP7nUzsKLRUX3HgVSHkpn/gjfX+552S+2TAMh47k767rtL0smtXMz96fenErjHvoCUsQL/WIzh8Md92TMHEAvbLyFsxcjoddpHt9GkhyUuk7E29J6VTkiFjJc12AP08mDmgH1cd/EOOUqkSWKJDemV8fuGEDgXouSWs6QdKMCL1GX9wkYrHKtHaBLXiUomreTRHzK5FEsFpPOsk1B8N0c1Qk/A43ONMSy0Fe3ZWm22aH2+4aW9m8iFj7qVSHmwp6LUbQs1bF4goveL4YxsQF96rei5q//pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8676002)(8936002)(86362001)(83380400001)(316002)(54906003)(1076003)(478600001)(2616005)(44832011)(2906002)(4326008)(7406005)(956004)(66556008)(7416002)(66476007)(186003)(66946007)(26005)(5660300002)(36756003)(7696005)(52116002)(38100700002)(6486002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l58GRwdNcrUjlwXXxJs/G7sA3soMs91xsYBl9XD4R60jcEoWBZ/u8gc6ccmY?=
 =?us-ascii?Q?xoyVk52BNbBWZnI8zGdSpASXTw0ZMoWNeNx2hNlEWkbhAICE+cROW9FtjlbM?=
 =?us-ascii?Q?bPTESWu+Zr/K76Bjc1PiZ7j9UDCsw6lzkqiSK1WKA7vXr76NJtWTh42f/A/q?=
 =?us-ascii?Q?qAFYUtlPRfYwcoNiA/NZ5cLfVATmTXo5vdVAVB7YysKd6i4OBDpdyvQ3QRlg?=
 =?us-ascii?Q?Now7jsUrnrBvOZdhNrQgiywmeWPYwYRLSg6zYJ7ap6hyYuD4ldZNI43xVqpT?=
 =?us-ascii?Q?u/pJ5S+b0/ReHhWdnTsZ2389gQPpcHJu23/ekdZ9Ddefx5j8bCp27VoHguiq?=
 =?us-ascii?Q?/QOo68H1HSmfyh4EqrqZi7bEAG5XIaXU7Y1b0oFq/QpMAhTV+ZUC63ND5AEr?=
 =?us-ascii?Q?ipXEM2S3YJKa9f+G1n9NbxS8951202gKnWg+ecYVUc+ZMW43S/L9q4YWZ95T?=
 =?us-ascii?Q?eMHZ5o8WHfdzRK1IcolUCiYcskI+X9EcTa/tyDosYQCIwe17onyFTyH3I3Ia?=
 =?us-ascii?Q?1molK3vs9F843yn577QgGUvWxCQlaLvnWRn610xBeg1MQjiU6Kk7gTwNllb3?=
 =?us-ascii?Q?mAsvrPOoBoQK0ognatDUlrkIOvnWuOWwXpU5AGYsCtVoxcnuxhlEkC6ZwISY?=
 =?us-ascii?Q?Oz+UAWSSZQC02IOySC6Fs/4GqZFjqdcIHW37RLLt+W4qNRkHdqy8DPLxPM2d?=
 =?us-ascii?Q?SypPgxmPS3NRpLGy+G+xEKDsVWqQk5obWEKBQweqbJco1NvbdSQTcjKKx7R8?=
 =?us-ascii?Q?kJ+ehNPgQfCOgq/wQLJ6kA+j5z1HjWPc9yq+/H41LdWBt+geyxK9c1sBWrKO?=
 =?us-ascii?Q?W2a3YuKJ7kMVEibrKMb+8wQwsRFN9Zrrrq0oILOKlutot7E2vBUfKwMNf1pB?=
 =?us-ascii?Q?Xa/J9hryACP5OjvjekNUv9GIjE9k0NWpGaD8K6l9lk1xhazR42s6Af9QUA9s?=
 =?us-ascii?Q?KUuOaEfYGYCeyCTkz4VVlkUwEZOASEGY6nCPZa+017KHS4gAsbwG+msBnU9v?=
 =?us-ascii?Q?O5YBJGYHibtHhnqQFlKzQEUPF6z868OSkbOVMKn/h4NfHAfKX9ntwSkGwDRs?=
 =?us-ascii?Q?O3LHv9MoxANuM7h63sZROMKDY7nkq1pgYgNQCfy2b01jSflmiI1gIn4TqhND?=
 =?us-ascii?Q?0XqiWkcZgDmzOszVeiDFVbbXN6gvdfvRnLHZA2YHG8HqAN2JFLeM0Vvd1oYc?=
 =?us-ascii?Q?myxZQ6+eKgmEORkXLrnjEKQjyYSiDcZLx+YTaY4voQox5QDsorAekLD3pDEw?=
 =?us-ascii?Q?1NyH6Yw/UK4ZiZt/txeHRxjNJ83sxVvS8yiTYexMRqL51lb2iXsia3IaU2+C?=
 =?us-ascii?Q?7imk2p4RgwNDQyvZPoTBQlYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928fc55-154c-46bc-1a32-08d963ee2c79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:25.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xuj5trPMNK8zh6LRvLa195ymbSx8zecrN5+yJsmaYqvl/+T/gd39C4WJj+JH3dHn8jsUHB2BeiCw84WV+MrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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

This is much of an issue for accessing setup_data, and the EFI config
table helper code currently used in boot/compressed *could* be used in
this case as well since they both rely on identity-mapping. However, it
has some reliance on EFI helpers/string constants that would need to be
accessed via fixup_pointer(), and fixing it up while making it
shareable between boot/compressed and run-time kernel is fragile and
introduces a good bit of uglyness.

Instead, this patch adds a boot_params->cc_blob_address pointer that
boot/compressed can initialize so that the run-time kernel can access
the prelocated CC blob that way instead.

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
2.17.1

