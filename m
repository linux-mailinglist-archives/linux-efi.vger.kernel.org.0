Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128F13F2ED5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhHTPVp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:45 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:8352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241098AbhHTPVi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6RCI+NjDkDZvZUetkpfBHRPS3hL+telr+ZReMS6tQq17x63/umqdT6OAbFtXmeOCOqli9dEwPnLG+FSypsmVr+9EMa19ANZZjZ88t85wKc6O39DO790CJlcG60IITzZEa5rbdh+5+2YJAjzdoDWgrJd65JD6lVkbeAS0+Z6aDAVlb0zFaND4fnTG0S/Jy+LfdqvLjybKyzi+tsci2bsJlD1s/FMY7pOZbXIxth/mP/XQ61y6amvcCvLVJki/QYqLYkmVCKIV1eXlkXTW5YgF7oXnxsKX/rT3ZzGFJG/oQaoP5qX8YSLcITD83z7Gyuw6FC5omoztjdq8fBDn6TXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O53RC6xCYBCyMigfVXo2AAFoY09o8JBPMgb0GE4DwFs=;
 b=cqw7LJOURvvo7zm5abjKvDyWlW1i4d7601EHT/sWWhnr1Vm6/8Xpckz42vbuwQDQ7Vnwx0cRpX9OmLlTUf/y78AEGV798eu2fRjEwKVS9wLL2SKz90BGwKuby+d/XoPoCBg2jn9lnGYANbYg9p4UAfu4Vx8fC1p92nkgwLJpobLDfmg0tNICVxFZd03278HnecGB+ofWM1lGlyVQkOMUqVjJVU/msAYEtt/AymmE4siDokur66kKDCM0E9CIDokgjbxxTMkVxwJmP5+y4SBsqWGad2kYLytX4sjZJdTWYBSqkxkuMbhYaIzPZqQtnLH4pWMzR21aN3aOINvqBvET5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O53RC6xCYBCyMigfVXo2AAFoY09o8JBPMgb0GE4DwFs=;
 b=C+aN4aMcsdDBDmwFY23Lls/e/G1ViOHNcppvhVV+CUZzJqrKFm5FmrxV9cQqqD5zoZ94fQYTRY2OYbwTfQdYYIOFox0a2dyV7OGG3LT8+SfQj+DZDAZwQ7ziKe1dPXuRSG8ddT1qZo1ZnCWgLNepu+UB20ux0JpLcTdKBKM6ByU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:51 +0000
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
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 04/38] x86/head64: Carve out the guest encryption postprocessing into a helper
Date:   Fri, 20 Aug 2021 10:18:59 -0500
Message-Id: <20210820151933.22401-5-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3339c5e6-e0d2-4127-a62f-08d963ee1859
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB271995BC76967AB73523621DE5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfucO/a3auTEK674qk2LJsoav4AmZ0ZBRLCY32DEPnNca0KUmNLl7/QOElmQ2/Z5bbZjMWPdbJ0qkJ/+DX1mnNOMETOMUQclqEL5MnxTmhXh6QMgDXVr7VTCZkf3m1zy2kgHOMoBhv1fJdvM0eaFMl9ZDnbP7Lwrzfhx01qohmafsVw5dJATB8zpLGt77SyW5l7zMiP9PVlhF/krs/vGmCHJ68mr/tBPhenREcP+aDplnW/cuvKXZB8ojeXX53OgUlVfYF1kEQFCTGUknvjVUZHafroAaiw6nAAtp8Un+KPi2TksyMXFRT9CK/mCSjystSe9T27eySIvPUCg0FFJOtr+5cbeDKccaHREVvPbco5qyoduAoiy7wqRl749qQ9qfSEI/ukOMIkUTymFsT2auBxiAJIRpXtVswo0cngjcLu2dyaqjs44R8gt+hhez0j+Z8RXbkYOi3emgkhc7eyonqpi0kaX6YqcbIhT5U8GQPuLSdFUFY4Y1cmGwlBNtnWCFYPDihQW6g9tr2M4uMflcdVit4FE7IwUrR2NwRuLTn6I99exGrpsG0X/hGBS/HB65+HnDR0DWFZg9ziHZNr5390qvU4e9NzfQ9LTJEhKH7a7tIDVScM4mQTVIDCsZteQYGwibo8EDlwAKkdQcqJeewGko43DRewTGMGVd17HnB0lUAE6Bj5W+Uzc4MM/v9kKPdxLQ5G7qXNMELx/3T0Oqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7OPjL2vy3gpeMVaQCKtLAzMvsXrIm+oHkYr0SgFvK4s8rStRJ5J54KWcGD1w?=
 =?us-ascii?Q?MK7niWutShU0+8xpQJLEJA7cO4ZMzRT/OkCIgrjbiBMLaPDMTwEmHePqTq+5?=
 =?us-ascii?Q?ZbV0sFOMs5IF1D8ZAhlq9wcSkdDtIMQMR/hAjHcwG12Q1NZAQML6QLKkHeuq?=
 =?us-ascii?Q?kDjs5TUZjGRQmvu1T17N/WT+FPS/0zhMuxWblOeWurqZR5DmmCbOV0JMiLtV?=
 =?us-ascii?Q?DQH/5yBJRyBKMLK0hX6Au0Vp5VWhaOG3/dE303GT3/kWvvKAtbGJdOhs5N0s?=
 =?us-ascii?Q?gDwsW5ZqXz3E9toWD/jhHmhCHnVHBI9N5zNlAdMSbyhAdDR1FrAZcTNTyXT6?=
 =?us-ascii?Q?H4NNiLEAPvylfDFOu1e7hGvhTEOmLn4TS2T0J4KFvXyZLNnzvuq9ELrwPOwn?=
 =?us-ascii?Q?0gupXLJ5fdJTmR6vQ30IEeu0yd3f7uavAqhdZcktsf/6W6uByka7IStFfpnH?=
 =?us-ascii?Q?be8gTBEFwBENCgBCxcOKNlWP2quCZSxdYbA2+WrXifmvFuY1ArDhEkagX8yJ?=
 =?us-ascii?Q?bpTqOuOKj9eG+kqcNK915+pzvnqxAKRnTPYaIY0+sBuivA60kgA9H3dqoN1J?=
 =?us-ascii?Q?ZVB+e+ei+M3tgsIoIt/uCUnwfoqMJ163CovD5lolEHe+By3eZJh90ejfgYWG?=
 =?us-ascii?Q?qP4OljkABPUDYN/33LIIPzxu2ZfQegHjmgGgyCeITuv4WQ+xeFd1VS/D/M75?=
 =?us-ascii?Q?LkBtfM1tFgSGz+m7cFBa0Ef83OAuzfgq2B0VwGn40d/Nv1oaU7KSGCT0T3Pk?=
 =?us-ascii?Q?yGdVRK03Gngdo8r7oubJaSs0n2CiAwkqhZ0lNjNlo7MehHD1pcErxd6auLP9?=
 =?us-ascii?Q?v0SfYtq7cO1eT0rtaYXXYriNqNNw5BhvUYqNYY/fvboHSSawAz3vmtaLLA/g?=
 =?us-ascii?Q?4ZC9ER9ilhFoWz8fyhfQmbLbZjqnIRUx4kkY4E/wKsQv67iWse0TJVoU4L6P?=
 =?us-ascii?Q?QzkuoVwdFCeMY4UC64SDB0LCEV1vZebhGGRKdAWCWXfIV+0D2nb5c9pcD5id?=
 =?us-ascii?Q?5GZyAzc34/pk46FiZzP1cjWaTPBLtsSKNzggjBgzklI5xop+726i6cRRoVpA?=
 =?us-ascii?Q?yTa9McvdtpIC30Ex4luo1U/a2ngdrXJC0zLsaUInHTcvTb9kQfLeVH+56YPs?=
 =?us-ascii?Q?DAolIVMp+F5DYXDz7hoTfyIpm0XxSCO3HaFoEmhnfSQ19Sp9QNT2gSyMLMwD?=
 =?us-ascii?Q?NCsoE50NHP0t+LDU1oV1aprJM9QML4Xkt8fLf9kNIRgBtV3aS3Q/JM1StoW0?=
 =?us-ascii?Q?/5e9aG02M5LBUPKGj6/ld7lZxxoz8u0afPYNULNWidfc6WOICbofi6aLuYdm?=
 =?us-ascii?Q?YAU2lnsChV2iuYvFXhchlx0j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3339c5e6-e0d2-4127-a62f-08d963ee1859
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:51.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tWYtVn9Fw4IbJ6Ctsv6JQ0uJAz/cR9DJSRR4nGD/sZz3UkPY9MvwF9tqToFFZLGPSBVopGWUGfMNdwI6ifPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve it out so that it is abstracted out of the main boot path. All
other encrypted guest-relevant processing should be placed in there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/head64.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..eee24b427237 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,6 +126,36 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
 /* Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
@@ -135,7 +165,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -276,29 +305,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 */
-	if (mem_encrypt_active()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
+	return sme_postprocess_startup(bp, pmd);
 }
 
 unsigned long __startup_secondary_64(void)
-- 
2.17.1

