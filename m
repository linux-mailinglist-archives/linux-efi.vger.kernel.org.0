Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5415E3F2F24
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhHTPXc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:23:32 -0400
Received: from mail-bn1nam07on2078.outbound.protection.outlook.com ([40.107.212.78]:42963
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241379AbhHTPWj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Baqv0uSDBin+SeHzykkDi8gh27Cax8Ts7bnB6JQJcYGFF2aO/s4cysmdEe5GwdXzOtISWEyoWVPszR9tcW2V2wUns1Ppl7icl91lES+vYr0kXbPDshntLnoNmlf20VLBQriTshdFX0F2yzX5DaMA8RHTAx1P4yFNTxpNHVksi0PDaLMiMvSQsvlsoYC3gmaW/vPYvxIPFdWHnXJYf2w6RtCgCRSymkOnSKToPR9x3pB1nuPSVuVACBurLMNWXk+1QxkrlmXLVm5rHgpiyAycuZHJ/DQ/P1MucwI7gqc+x1aQG+AznbOejvgQfIvJuQGecvpC9wxzeOSZhopCyOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avLF6Udb91bbGGtykJCdLRsOgYGd8bNxvuZiGtuAHm8=;
 b=DyZONSZ9Svw1yu1ERK42IQPGFVHxPjIsTMR8s4E3LYNJkahadmhoyO4iQjn7QjGG5iLK9SrsDogifLd3gGJFMb9izNh4Aits2PAtMUwzLPx56dzxTVDaYSRoc0G8sqH4TqnMXlIIg1EFly3N4UJTg1xyPr5w3RrRUxNlinLg+JJ2esV3sg9x9sPa2vsgP4kna0Hpgj9MFqqBLZfAKkg+0kozo4MzqnyFpdbhSo0sU9K9w5B9FhRtPu1sH7d9MyGrUpIdj3usJndAO2eNc1fYNC0Yiq0jhudJ8IZ313jJOpDQRvJIrkRh1ldY8Av3q5Nuw4/g1aQq0kDv+SGay7f8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avLF6Udb91bbGGtykJCdLRsOgYGd8bNxvuZiGtuAHm8=;
 b=nRQ3pHcDV/jGvTAV9eqMHvODGhRjVZ17389JWRtMF8zyiBBe3Plaau3BVN2GL0wbb70Wvc0xtN8RZWCsoiZ/duk+zzKPTfSWKg4uxemplIEuPIrUZ4B87FknkX48jShSSEug8j80bEJCvijIVMhmsFy3knTvBSXgK+erfxGjRo0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 15:21:58 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:58 +0000
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
Subject: [PATCH Part1 v5 30/38] x86/compressed/64: store Confidential Computing blob address in bootparams
Date:   Fri, 20 Aug 2021 10:19:25 -0500
Message-Id: <20210820151933.22401-31-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8cafd1-d7e9-47e1-309a-08d963ee2d63
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4592039A179F3824619B6A70E5C19@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32bI4iIsadWKzq408pzfPklxLjlVA0kSBL5QhBpO0kdeToOVU5r7lEgN3MATeBjLpcBSfVPh14n7K60SaZ1Dnlb3HpH2KuOgBz/nYVKBi1agDWfpwsOYVZDbdYpDWk3/xojFuRf0fPlxAf/TmH1eX+WEKcujQ+9xQKWxkNwp2RqtGQ+NYSwP7iMws1rlKbK9SaP7ToFvc+Gbztui1iHGdvBOm5/1fVngB/VoZOkCqLeYOrXAI8OwathAFSkv2lxaSOHvdz6daRdEAXGcdbtxwyrgX0JqLjFRZcM+V+u9ZReqAdYMi+CmFcMIX0/NXZ4pi12eYfO51gEDHSZtwHmLpMHWlf7jJa37mdDSHr1bo9GpiB0Rs/DNLDID9is1HLohliE2DY8o+3cY2x0gTh49Fy+T8CPOyud0WezoFBIiGDDT0KbzYPnh6wssPQUZ/L1mtIa98LJ9KJ+8680DDnIshk0zqtJrJaE1cDiHLuhl2fhtzaLp2cijtvYPRdaNiVcwWBnLzB3xz7eqZBVYd76PHSkkwCBLimL80yWQrZc/5yfKgbB05kZ/tNEag1xQjhPYOq9FKlLLVUT1DMGE5TmBI5U4FjEqp9kDaZ5Q6m5Jkqzh8SLTLGB+Z01Q0jjym+y5bAOKW7LaAb5qsqG1K9In7tcSurw+yTrSiCK0NNJl9o2hNhxmUAJsPEXDVJ5eAXkWiCjxzMxX4fdnyLG4y5wfHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66556008)(6486002)(54906003)(66946007)(1076003)(66476007)(316002)(38100700002)(7406005)(7416002)(38350700002)(8676002)(4326008)(956004)(2616005)(8936002)(26005)(36756003)(44832011)(86362001)(186003)(5660300002)(52116002)(83380400001)(2906002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wv8xktt9t2W8zIhcO9A0MrtRksclycPmi2sxp3DdEhFsq32fIzlyRbY+613?=
 =?us-ascii?Q?SQgv8dLOH2a+/U835ZUPMyfNiZT8LMkq47Nk5ABZR0sewi7Xu1/t2pVfKL5L?=
 =?us-ascii?Q?wqOJBj7gDd5HzakimxC7kcRSbL1Eqf3bsYdptLcgSd4gU0ngvG0/G86qTz1Q?=
 =?us-ascii?Q?WV6hwspbMAH19L4xws9tkB9xPzk3ZyNyxSEs8xz5kHTgMbn1oWbhvBh16+nG?=
 =?us-ascii?Q?xjpvUzcoz9EjKiCW42t8H2jikRv84G/EnvoBcgnfwDivfMN5lTCzoIuxh84Y?=
 =?us-ascii?Q?kSRTcYiqKK6FoFlg+6wpWfVboy9g7Pqtrlamfooc6xZz0Gk5ErONq0fhuy1D?=
 =?us-ascii?Q?uBKwJigQn/D0ZCTOGMASjJXssbjwq1makAZak61WpF0BLbA/R4QKQlqaHER7?=
 =?us-ascii?Q?8C7tU4H7DmPGg5KcIj1tX1BK0xClIBRpbL1TF9g42e5woXY0MkJjn/dAs/CX?=
 =?us-ascii?Q?0gvPMVs6ZI/BmrpqgLXvnhlWFan5dzhvvaV7BiY3eWYLeKgoowd8JN/BaGUV?=
 =?us-ascii?Q?rWuB6cISPl6naBSonth4pgE8mcZPcGf+xpRot6uuQX+ZUkACbzvzmBAOI+9+?=
 =?us-ascii?Q?S2nXmzO8MB7y4H2PMemeKjcQ304Ilwk3OHczx+cXQd4AM5xKmXN3UO17XDHI?=
 =?us-ascii?Q?tcx9iOahDh9bi1ad4uxjWDIiCfOo0IAz/eldW2k/EFxGo3Sn+G3GGq+klUGp?=
 =?us-ascii?Q?JAPkv3gk2bvO1DsFBSzllkZ89zmSIAWm4k4BuRLo2l/jwytKcsdT09Df9CII?=
 =?us-ascii?Q?4Tej7uPoWrHWcAoOm+ge8tvqZaE1oUb8/1D/x+tdJ4WnduUGu8ZZ9+Ryq3mI?=
 =?us-ascii?Q?xL1YybVxUDBQdDJ6kYFIMcp4P0QpAiIN5SUirfUHfLZtKQdPQ7IQM7zzoUnc?=
 =?us-ascii?Q?NTcUmE+X7M3wGLmMgzq1bkAIpim+83tySKm1/YjCwkWnGR8s3/LPDnyFUmKm?=
 =?us-ascii?Q?We5zHRMhVl0wjCH00/Z2XSoF9QNd3NPqvp/Vbr2relXcWH/ynbFU6wl1g8gP?=
 =?us-ascii?Q?chIsZV1zCi42EWQ1pFhm5jkRqQKiYMk4cNrv+H6Vr0lFWd0zpgTRBPJskPww?=
 =?us-ascii?Q?x8wH4t30hYM3h86y0ovg65M3Y/qMo2CR/jShjXyC5AOCBcyKktuRq20hmy0Z?=
 =?us-ascii?Q?RdJohqqZz2b5wf4squfFrnSe+fv487zMQVavH552A19PM6mEO/bjlHCpkZ0l?=
 =?us-ascii?Q?Yq9XZmIAqxiSUEC4MmbrDv3CuitazKC107FEoDSoECyKWlbfqCqet+dFu1vi?=
 =?us-ascii?Q?jihVdwRp0Kn7FLSbQsZMZGF/6tDZKOgpTZB9xYVE5FfjSBa9IiBqxjF37RTY?=
 =?us-ascii?Q?mPYMekvY6FIqpPQZomqojYCl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8cafd1-d7e9-47e1-309a-08d963ee2d63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:26.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLhalUd0y6j0oBaPiHrCRGSXUqCeArOsRgF6/sos9F9+q+g5uywnq1M5JAcM/vzDeNc//HD73plt5HBhFHPB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
 arch/x86/kernel/sev-shared.c | 40 ++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 651980ddbd65..6f70ba293c5e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -868,7 +868,6 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	return ES_OK;
 }
 
-#ifdef BOOT_COMPRESSED
 static struct setup_data *get_cc_setup_data(struct boot_params *bp)
 {
 	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
@@ -888,6 +887,16 @@ static struct setup_data *get_cc_setup_data(struct boot_params *bp)
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
@@ -897,9 +906,11 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
 		struct setup_data header;
 		u32 cc_blob_address;
 	} *sd;
+#ifdef __BOOT_COMPRESSED
 	unsigned long conf_table_pa;
 	unsigned int conf_table_len;
 	bool efi_64;
+#endif
 
 	/* Try to get CC blob via setup_data */
 	sd = (struct setup_data_cc *)get_cc_setup_data(bp);
@@ -908,29 +919,36 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
 		goto out_verify;
 	}
 
+#ifdef __BOOT_COMPRESSED
 	/* CC blob isn't in setup_data, see if it's in the EFI config table */
 	if (!efi_get_conf_table(bp, &conf_table_pa, &conf_table_len, &efi_64))
 		(void)efi_find_vendor_table(conf_table_pa, conf_table_len,
 					    EFI_CC_BLOB_GUID, efi_64,
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

