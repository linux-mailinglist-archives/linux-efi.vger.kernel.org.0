Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECE3BEE39
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhGGSTu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:50 -0400
Received: from mail-bn8nam08on2080.outbound.protection.outlook.com ([40.107.100.80]:33248
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232172AbhGGSTh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doL+zIZ4yEuqpus/jhB9DkXPkxBjrx9eO5XXhb/Z7A6PcR9IOYt92RYifN6LbXAF1iZF7PiY8I0UzosXje2WUhJorfo+c5dY8/VerrCbdueNqg3vyaWYkS0ITfzXA8OlEFB6ieiK6SbnksFSCYBmi8vm3l4Food6e2xcxmtMD+wf3ewXNxSoG6xORMw8S+DGGrbJU0VtyWwEBx8jmBKYH60IBf8xVap+VfyTbvoXf7mjZV3TjFFvTkNnHPfF4FGFwNduf7UByNcG08/CXzf9uj8bdY+9VHPLZTfl8UgjH3Ld9AE5xEIZAmxuYsm8V2ZONqvvaaA6wzdYyAbk+a4ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkU/foi/ZGV71ZkywRRN3v/j5D2IBhlBMTCjHQgFerI=;
 b=P3JSK83rFUt/GTmn8SCAnZRuo0lX7jnkY56VTExVUshk0hG79vb4UfShHukbZ91m6n5f1kB1dudSdAhCxJKTGj2twQ8RDS/snKR0ZZTkYY1MCVCjyrtb5zQOVbIpeMm/ALNk+AwVZIX8cigMC00CSmALqTAUJRCv986SdHN52lxnDTx7y/KjBk9LKn59aOpxAaPyQZt74zM1LEfEoBp3A4VB9aK0TYztXrIfp6BoKyxpAlXUQbk1ME1b6vjcgLox99MtnNtYD8kMPIg1+GqROgeC5FbeXkQNHQehwzKvEtRCT0vPg0e22oWwblkiszyJlug13xT1ND24+bFsSNuGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkU/foi/ZGV71ZkywRRN3v/j5D2IBhlBMTCjHQgFerI=;
 b=pB7AoplmyC8NdNZUATIZufN3Jl9fjnnHd/d8SyMtOZTy+T0LSEGqQ2Esnu2gIblrjH6uV8Iky2ZknuHSQVKP+gBJegEgNZ21POkjt+PlL0Qc2QUsap7aMz13Vmx8w1PUpnwAvPZ+bdnVCiAAM9Mvwi2S6QmyLtduIjkJcnvm2zg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 18:16:38 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:38 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v4 27/36] x86/boot: add a pointer to Confidential Computing blob in bootparams
Date:   Wed,  7 Jul 2021 13:14:57 -0500
Message-Id: <20210707181506.30489-28-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e00a4c-ed46-40e5-f25d-08d941735c59
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB368362BEAF463F8CCD2FF64AE51A9@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc1brqDg3K/vhDGik7BgBdd/BMFcGfvg+Sh9B31fYnQbeYTz3t+/jdUi+W5hDum0+H8DX7uCXGGFrBGYJ/bkWhGf3MB8C2fs636vq6RWZDcN5MRUQOKWk93DnkxAA87uJ+qMqz3tI7YZIdQhk0DhvYqiMVGYZCKwyKtz4V9r193KZiXolGyG20NwQ5iykXcSi0M5AJVIqH+hnUcYQs/aE/U0viukms8Lg57CnB82h/EYOvTtJhtm5p4W8YVlkBPKjg8FUjhVywIj4JBDJmBuOXuoa3DIJQ2ULfcikQZLC/TRiLa9Chxu7Vz4bnQm0EdhUIk5sZ+Aq4/+dhbSR9ZU7DCmTVUsvdPWGyBVSJeVGVjwzHO9HEJsSGcX3/UI6KZiwY/ELmA/3PO+jZt9mYKoi3zePdHwDJ9gRzVWPaxGfKartSC+FP0CR4U71aXP+YclCaEWSR5q3sazBI+VSo85iVjesjjMTwDaz9r4FDGSKAj7Yv1Oacpwno11AMet20om81jqyOGyhNwEZYDOTomkDeZ9FRF+Zdj3zVmBhbQIWC3W8dBJCF+TopoRBgpzzP1wTT5l2AoJ2d5hEEV4fH83v7LMyxwC5Dk+9sR1HbCbb8z4Ijfb9Yu3vp1nRY0lJLb0k5298Uy1P72CLxdip2aGFj2prPAYRXTOwd2wwJ1hKk60wJ2MK1rAXNh+WQ5iulM3yRQjZI9NbMh/n7uM6/1PfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(8936002)(2616005)(44832011)(956004)(38350700002)(26005)(6666004)(7406005)(83380400001)(7416002)(1076003)(66946007)(4326008)(54906003)(66476007)(8676002)(66556008)(2906002)(36756003)(38100700002)(52116002)(186003)(6486002)(7696005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?en15AkyelWFpQkmmfaXqVIMLG5dbhbaKJbdZxiC87GOQX6Y3nNNEfBQQgjtT?=
 =?us-ascii?Q?S5ahZof9NrLgjFL3f5yGjSka1wFo7GDGzLkRadZW+D4eAkErKIUwmn2EXfba?=
 =?us-ascii?Q?1SkCd3ddryJQbYFMKRl4DWB2gPwMtdclAwm2VAjwT9N9WmSvLxZJ7mwUw06b?=
 =?us-ascii?Q?3zLcJE98sfwQwCFS5mKc+7y28ARlgYHQOqNXh6qp3AeygvETo+HG1TOkXQa9?=
 =?us-ascii?Q?K5/wnnAVx+C8cNyFkccvKaXw0IYd2vm8rwFUkg/53/QBLBCbN2lv+bOgD088?=
 =?us-ascii?Q?ru26xHmiqpSg5Xza/hu3dROUsbVbwefOihZzudYRJhuqYFTEbqnZjA5K2LaG?=
 =?us-ascii?Q?6Qv4LBZBWLFpQcW/1goZNs09P8fPGEhXAUzAZYSzYxZmj0f0xlZ+cosBlM1O?=
 =?us-ascii?Q?9GVaxPHVISnARCWBTt5X73irj34X9K2YIBhvN7W0eun4cBN8ZJlDoLio+4bw?=
 =?us-ascii?Q?J5ZtwWmi307WXtZsL9T3Xu6s+W+Z1gG5kxyluewlsQc19aFNqJ91LBlztnjV?=
 =?us-ascii?Q?MGnm+vgvqrqL4ikjGqoFWs+B3Z3mAC5JtdC8tdh9dzBAVDcTCq7mbJt8iXlU?=
 =?us-ascii?Q?D95VoHj4Gjbx097/OM0m3PqUDiNdB8SgN02qLmFvZR5x617yi/PmP/IGp1iw?=
 =?us-ascii?Q?OLH3KX64bllUrLvUAXuH5w1Vtje0z/Pg42IjBieufkogny9i21TnUeYX3zc3?=
 =?us-ascii?Q?n4mKv9iZr0sYLVu6M6hz2OAb03CVD5CJ/4L0IURpAL9tZH0OP1aQz99GXplM?=
 =?us-ascii?Q?R+KPvd6NXOJ7Kz5+LPXzK2fVRWPJLGv69PI9SMqDwHi24iEBzdf689Lj3pEd?=
 =?us-ascii?Q?nXqNp1M6+sanPyiJahJpznYMPhCkrWQdtQ8EGrUoCKfIrbEEHnl5kvkbIo+g?=
 =?us-ascii?Q?meSZAGL2f/OLtPeLWbuX+NfeNXhGT5F+H4wff0P6rwDHKJjEgeihwxkXHyif?=
 =?us-ascii?Q?QzNNt4Yt/YKxBMBjrZ/A3IRZPARAWkxj2meoL8WzYb0AXYncxyfmM+L9jxNC?=
 =?us-ascii?Q?LLJRroUf52vpaufbnY9B0pRomQhLRB9I3mFCKbAmQoyvDVZknxN2ZJhp9eme?=
 =?us-ascii?Q?g9AE6d1yYKnVaS3yfUq2jARs5GncYFlUbY42aAHTUWdgQW1bGoqmuU1f5uU9?=
 =?us-ascii?Q?miI+Msub4/OM+5TTJOmbYfQayqT32hnJzn5evUoUS9EAMMaR0AtaeiM36mIc?=
 =?us-ascii?Q?8vllV/hUTzhFUT1i0aFlvSisoF/fQxXd+DkOqQh09EfgcOL3r9yN59iu9fic?=
 =?us-ascii?Q?nk3mxRLo1Hay7n2wiNLU7dmKe/gl65jx4cgnpwKSIXUrY7xnunM0N0T9EjMX?=
 =?us-ascii?Q?fXFphEO4h/plPTCjhTaJVQA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e00a4c-ed46-40e5-f25d-08d941735c59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:37.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIxn3/bJvwJZw9uUERcLQbtP/jF72HrkXdW8NscQ2yvEcjM7TgORm6wDkA85KW8RuSZKuYONqDtG5t+ZSbFZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
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

