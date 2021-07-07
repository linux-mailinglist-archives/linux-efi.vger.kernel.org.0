Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE03BEE30
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGGSTn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:43 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:46944
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232035AbhGGSTY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmvPCbmUwu5znVAyNdzCvt0612Ps9R7c16S6DAXM3e24hT1St25ckX2H9MUxxBQEA7B2yrYlP0PXd6zEwcQ2evLCn1DOii73XE1qynun+/hRbuIVSEC1gESg2RmRsKVmlu6aCl5T20i9cbA8BAcf3vwWpnJwWeMnnT6fbaVU5BOdy5t3MZw9oEKvLg9scYE5Trw2bXtdweHfigKnR88T2DVjEUIuIxgq1x+C0kPRvz5z9J89huX7GPtoa0No/UC/3Ff3eCjfU8QqG+ic8C+a+MTfBiMTewUOAF/b3u564yWgAsViILvvXY6OY+S1TR2mCWmT5V7ZVjNTyJCe2elZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIuGp7KBHI64lwmkF6UGH2PkA4+umPxRd0Yii9FMJ5I=;
 b=YD7UzEsCNbFxjUVXM6sQ6SI53KU+FMhcWck4rGwlDlh6Sm4Tb0IYWHfxUUPXXxrDZvUEYQ7zHpDBOfWAdl8laglqepGX4o+5TQ5qpb5P59tjRgMuqU/mKcvlZC/Qc174/z+00PSVuUhyzp6rycx+ihLNvfKxyMiemKpMPuv6erTdSvmIJWjL1cqg3o0UIv0L0QaHpR+CB3Y/QS3lbaOA0lXifg0Ayo4I89F6YPP4lJgmihMv7tzt8EwzkJPK32oNEV6stYpDtLkeKFUX9+ch4/DCwNSO3NEia4mdqaDh1W+HLxuotT2s3i/T4Q2YNx6k2ZmJ1DiSu64HtkkbQjMYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIuGp7KBHI64lwmkF6UGH2PkA4+umPxRd0Yii9FMJ5I=;
 b=x7gPR0Qwv88gMM6gEhFLAiJ5clU0HCcVCCQZGbiyXmERfKnbHPW1SWFlESzEeEk8DNmpBOiG3tFxGyhk6/d89nR2+3pQRQedEw+ydYrYlM5AtxM+U3QALP8edUZOkIRTzw5++BSRVdozN3IzOqR/gQNWNmAezz5Lr8vPzCYyxxk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:40 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:40 +0000
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
Subject: [PATCH Part1 RFC v4 28/36] x86/compressed/64: store Confidential Computing blob address in bootparams
Date:   Wed,  7 Jul 2021 13:14:58 -0500
Message-Id: <20210707181506.30489-29-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6aa2024-a2c1-480e-cea1-08d941735de0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3527A5948DB3C465BAD142EDE51A9@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sewOYFtgPvXw9n2on5DnKOII5sU2GWPCau9usWUPbe5CiEEDVSP6g4texRxQR4HmLVPfUCNn2Hi7mVHL+5qZalc/vt/R7DlbbXjL9UKUgRvt+vIg6hmgwIqT3oL9xxGLaeGtyJPxhoQ8hREoh/U0TgXD1ElLoDijEMhujgiBnLsx99QCxirMTG9R0CozxflW0t9yZ4ZXPkRU4872HypsHcqeO9XrWwTI/sO8YeTStqKk4bCsb873K6X3bgv45G2+L1/Ty0vgpCVUHUq8HXhGBq7z1I2VMNQgkQcFSKtV7mo7yZofw+tJ+GqVNb4149MofrEaJLn03yQWo+I0imuxbFTSKWomIjHShHbDtx9XlnqfUEyQTE9iBrW+SBYADEvMYsplSShOXGFOrlTiHTVfp9N24cMdmpHADYAaWHJuG8/EEMY8/jll5RQUd3ZEDJydwa/I1H1E9gHvnWVwjVkjc49L8HDn36csE8bzSmuhdxg75bhTL5z4n17rQd4INl+evzUDQLLoWSe4Jat5PTXTn8HzWddohDhnkCcfEGh5yW++y+8933MrmRzSlbil35JaJhQ0Ha/iCZgHy9NclxFwaN1/3VVGTIQmUzOGYk8zZBPNEV9l1T56eFhHs/M5emGAj4QvsHBhkcdF1FbfdBPF5vBfDRcB52DdHKDuQZgNpLdmpgsS7XI9q3IRmBkVwX6vvXBam0XH1gyWFZpDM+2zBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(26005)(2616005)(5660300002)(478600001)(316002)(44832011)(6486002)(1076003)(66946007)(66556008)(83380400001)(86362001)(186003)(956004)(66476007)(8936002)(8676002)(52116002)(36756003)(54906003)(2906002)(7696005)(38100700002)(38350700002)(4326008)(6666004)(7406005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GaHpQX1uHGkl5nlH44yp0wW6wsVFSM6CWszinH82RaqUgZIYinulM3SapWF?=
 =?us-ascii?Q?wpeMkctKpDIAS0IMFcYRUdqEkOs1Fyl6Z/92Ni9TXcm2vnMibXUXgQWQ89Fx?=
 =?us-ascii?Q?YMuPuXs6KzKfXSmWQ0Hgh899J6xTkOeZrD91B6dx9WY+U3mz0Nr0VFBnT8hU?=
 =?us-ascii?Q?lknCahjYy8H/UhhhjgXifONcbEkm5RTw7OOhEVPhncwal3faPy0h20xQ/XVr?=
 =?us-ascii?Q?5WZgv6qiZlbzeyph3FtWlm3/UaI9wIu3/FJdU99tEUJjiBmYJdwOAWR6iCT0?=
 =?us-ascii?Q?a2KlJFdxJpzDjrfkQtmjDXLBfE+kF9K4S/A0GbijxTlf9pRnyRfK2aoHpWJA?=
 =?us-ascii?Q?eAk25GXPr0onaWoWMLEIgZSYDRktqMcawFICBzvPidLUzlXds9ySxztoyXjm?=
 =?us-ascii?Q?LBXRRf0Gmi//lyiIffiEkyON8RAwwgtD1+yRDbaKvYksPb2G4H68AoB/ub4J?=
 =?us-ascii?Q?MDdLoBoAXgS26BBftsj85cAfQNVIG/Icps7NZtN9qyq3jrjnSA1pBo7klxeW?=
 =?us-ascii?Q?VKUEb0i9jTWIZYkiBYIxf2ttLcmEi9T9/e42lPoJWH6zB3acmFS94TOkOzit?=
 =?us-ascii?Q?FNilMAs04stMmnb8zA7bS1ZBh5lBjOWNKMhb5wujStnFm1qoBmHSg9tE45rI?=
 =?us-ascii?Q?YS+k0+tcxbINBLrES7IqaNxfiAfluvU+LwEAM5lqq03euylv1FjIurGWT5Uf?=
 =?us-ascii?Q?l1945TWO8HgBdlXONZVCL/lx88fEHl7Y6Wc5vo9gnCU4OfAhP+0wihnnP/Qf?=
 =?us-ascii?Q?k/Y3mGZYH2es8JWcYfZHFeno264jmQe4+r3k/SHdnxDVwXiFKP1SYpcJ5/C/?=
 =?us-ascii?Q?/Z/VJ+7WpReJ+tyCVqJnYI4ckjJh088ElWSmXXwK35ugvADwQRbw1PSKpi0o?=
 =?us-ascii?Q?DDiQjio9NWPwcBEcYaJFVFzaNGV8ECg6NiLyRKV8rkqI8ChL294TvUiDb3DB?=
 =?us-ascii?Q?w7Pv5mDoUtHnV1BPfGcSF8tLPHvtb45DlKd5J01M+U5mFGOZqE4/yGKCmnRe?=
 =?us-ascii?Q?DD9UG7Yyc6flE1QRSJGbHFPfVrtzm+ejAKQ0xlJlHMr86eHMNyL//E+bE4MI?=
 =?us-ascii?Q?fWtZ3Bz/xj7K/acKVcdGwXJ2roeYEHZR10awFCVcxYSQjjxp2fK1LBK2dpJI?=
 =?us-ascii?Q?Qb6BZ+8smeKfEtLtdq/K8GvTM6ES/2RhGhf0sPWOiljjkL7oGEcSIU6wk6l/?=
 =?us-ascii?Q?zXkXh69ZaYNsoNvSjeXzCoXL2zx1rMGERkBfw6eyRG7cYAm+QGqlHRmbjO/i?=
 =?us-ascii?Q?pjnrouHzjP9FrXGD8tshLvJm0djX8QutpD75RSWTZ3xkOmU/LauboxXv7Kdi?=
 =?us-ascii?Q?2nECzWTkkBqG3EpVdszxesBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aa2024-a2c1-480e-cea1-08d941735de0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:40.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lsxl3ONComGNhuhU3ShqtB3UYIWuiuQggRQ29ZBM4sKPMIUzy+uCG7q8gi1E4+fIFyXP9EMbZftPj12z1hgu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

When the Confidential Computing blob is located by the boot/compressed
kernel, store a pointer to it in bootparams->cc_blob_address to avoid
the need for the run-time kernel to rescan the EFI config table to find
it again.

Since this function is also shared by the run-time kernel, this patch
also adds the logic to make use of bootparams->cc_blob_address when it
has been initialized.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/sev-shared.c | 38 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 5e0e8e208a8c..23328727caf4 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -820,7 +820,6 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	return ES_OK;
 }
 
-#ifdef BOOT_COMPRESSED
 static struct setup_data *get_cc_setup_data(struct boot_params *bp)
 {
 	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
@@ -840,6 +839,16 @@ static struct setup_data *get_cc_setup_data(struct boot_params *bp)
  *   1) Search for CC blob in the following order/precedence:
  *      - via linux boot protocol / setup_data entry
  *      - via EFI configuration table
+ *   2) If found, initialize boot_params->cc_blob_address to point to the
+ *      blob so that uncompressed kernel can easily access it during very
+ *      early boot without the need to re-parse EFI config table
+ *   3) Return a pointer to the CC blob, NULL otherwise.
+ *
+ * For run-time/uncompressed kernel:
+ *
+ *   1) Search for CC blob in the following order/precedence:
+ *      - via linux boot protocol / setup_data entry
+ *      - via boot_params->cc_blob_address
  *   2) Return a pointer to the CC blob, NULL otherwise.
  */
 static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
@@ -857,27 +866,34 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
 		goto out_verify;
 	}
 
+#ifdef __BOOT_COMPRESSED
 	/* CC blob isn't in setup_data, see if it's in the EFI config table */
 	(void)efi_bp_find_vendor_table(bp, EFI_CC_BLOB_GUID,
 				       (unsigned long *)&cc_info);
+#else
+	/*
+	 * CC blob isn't in setup_data, see if boot kernel passed it via
+	 * boot_params.
+	 */
+	if (bp->cc_blob_address)
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+#endif
 
 out_verify:
 	/* CC blob should be either valid or not present. Fail otherwise. */
 	if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
 		sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);
 
+#ifdef __BOOT_COMPRESSED
+	/*
+	 * Pass run-time kernel a pointer to CC info via boot_params for easier
+	 * access during early boot.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+#endif
+
 	return cc_info;
 }
-#else
-/*
- * Probing for CC blob for run-time kernel will be enabled in a subsequent
- * patch. For now we need to stub this out.
- */
-static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
-{
-	return NULL;
-}
-#endif
 
 /*
  * Initial set up of CPUID table when running identity-mapped.
-- 
2.17.1

