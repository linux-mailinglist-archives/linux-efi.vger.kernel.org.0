Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B349A3BEDDE
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhGGSS1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:27 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231441AbhGGSSY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeOBhNNxA9S+Qw2LL6APrms+CQFCOEyDByiGvBXwCQiq72kLOCw4We4iHOgz4lXczK68qBzgKCQkNbjt8wcPK38Jn75j6DMRDUJfNLbfJWCJmwqhDOzkP1NdvJyt3ep4QyGneWGUGBtK9jqvhEW6Fo8wAbX0dOVcDRA5fv+hVc6y2QUrDnEE+Rx2hrphG6E8dL4rT5Qg2blFd0Alllggf1us1GpfvRNZi5eGZqfGvmpaaOcNmiTmCkgMvJ68Adtjv383GStCunSk/lp2o9f3U/BjwL53FnGGTdXuEd3k8wd6O2MjN8cl9SKb+puN4Z1Z/+Hnc9H81u4Ew+4jJsYwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEw7I2/UqGVZJYfjEijRiGlJViEJd73Y5IVmOCMH3GE=;
 b=eTKJBxLTcTGMHjyRwke4rYK6ud5218Wpnox+WU8SFDljpoDrKDCl/zUz3jwNsKjIO/q13K67xu8cjOTA4oMmAISvGYt3i5yrrk0seOLrCke6wMpvG5xJNbvI62MtGBKuyQljHVKz29thnDRP8dFDvC+V3/ezjkqNfWxsI6vcpbwxK95LGPusnLqCaPPKJRLSF1JTtnB7Be15NTGCQ3P3j9N8pnE9eeEpHUn4DXrAd1HoH7R8xwpf6C7mLt1BNlt9+2Cpeav0loRbyFD6lRBDvTCEJPT9B1Qgzk4W2xpjYcubKRRMWmtWQJr5QhltVeODaiXETqhxi7TqRly1odbZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEw7I2/UqGVZJYfjEijRiGlJViEJd73Y5IVmOCMH3GE=;
 b=P2s3ltLAEzzitrQV5rhv//CR6Iu1d4wYsDo7Ap4oVQQgLh/OVi8/ryKmY5hhAlAIL8+1BU6CGq+cKlXmDsP6V5XYzny/Bn64YDjpMigcbSdY4gx8oZ/+u0UUtAgza6uz0RJ97oiafDzP9ehIfe13d9xF4RAUg+xLeYYQ2CSpqLE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:39 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:38 +0000
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
Subject: [PATCH Part1 RFC v4 05/36] x86/sev: Define the Linux specific guest termination reasons
Date:   Wed,  7 Jul 2021 13:14:35 -0500
Message-Id: <20210707181506.30489-6-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9680dac4-7a4c-4fb2-81f3-08d94173392f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3939769A017361113C940B27E51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 984wuGON4hl3At0xMj4JIJUB4DAR85Tl6h53Ablv/L0kduUKZV0Kbn6rGyKxQOLUVOunI/Jsp63L5cPYAqShJEHM20Cijv3sI1Go4YOBHUdpgl8MdbqIZ1lLvjypv3DDA0v8uqghyE+8kX1AwmJLoOmxCSfLHSuK2jBgl9WQKZzIw74EZ0PApHFMguGL8SjNi+hy3AHd+uGiijiF7z+PwkuuArZZzSq0waz3X3mLc2YVS1zJ5++WkjaRQcTODWNZKs5yIM9fOeLU366FI/cL5obSEDgmSoXpDM43M3CFZpZ4pWGOq8lR48PesUlfSwSHzDDJ5Gjk3f3HYXQlHUQ89ewGMicpByMPLOs3hf5/VLS9GfhQ4QsLvpNq5mqNWMvs+SdirjI1sx39ssf+4KqMsqGoVK4UF1ZyDYXQdlL1dAO29icDhvvKm789QpgwCvWAufmRb+/tNQmoX+7sZeiwYq7Jw6BNW8MDY3Um6XgYsTOFrEV8az9uDSyaWfBSFP5iZguYxvNKPDVlT7NjrIF7zqdSxr38GbIzd/7fW9kpHDpanV00R+qRWyIo+NtQfhut6zRNkv0q81LStYhVGUL80i+w4IUuFhBAtbIDgWXT6VGSIgQPz7r9f4aALubvgmbzlGu/1s0II/HxaO7K0RRUI87jhcau7li206rRqsFZq8+GSh/2GfWPoOwCCTUFsfTBVWZBbkpaHThfaDJs6bI8Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHWNsu9UvDjScKlVBGBNaa77Q1t5ljkGINhEdNxUghGVy/S2GHlGYr4/RK4p?=
 =?us-ascii?Q?QQfmJVgFjyAPxXhAH9u1iwdWaiGFEyK5YQsVzv2aBuldsaN6pkIzAQhQM8Gr?=
 =?us-ascii?Q?BdfdVSq9t4/2BkzWWi5IPs8K0L05iB74PoVx1qjzlg8YMDYDvkxhJJyz0BMi?=
 =?us-ascii?Q?WJGn6M2qHYHgU/da9eBm4PJQUhyUdIpAZEYRxnPIEjwHPzbO7k5ZgSXiyQzj?=
 =?us-ascii?Q?Fffe9vERqmoxka1+6mVbomz9WclC+O/P0gqWg2fa/oUPMA6AWdzWq3p963VI?=
 =?us-ascii?Q?xK9deS1j0lCyCOpWVIYZgzdoKSrXWfBxiiBehgaIsrfli5Pr4R/I63th6SC9?=
 =?us-ascii?Q?PrfGRnk1VUsiuoj5FDSTE3heTpJTeErZdNHEavFfWJvECcLllR8IBdvh3eMO?=
 =?us-ascii?Q?ZfJLpFkTdZPAlyyYI35wKacmi5g33YrA3oFVqpLvU4hdvVI9VYC9MbeFHpm5?=
 =?us-ascii?Q?MTmxbj/cXI1TGLHd2y2P4WVt8zR76nZd6wVS6q63oLhCbSgy415/TiRuosaT?=
 =?us-ascii?Q?djYPXfTxvjg+nNIzRLP63T46HKn4c5MCkgWbalfLZ6ZHSmMOmhzn6oy4OmKc?=
 =?us-ascii?Q?/tSbV/B+EnmCK0xdK/VqscjK5LF1XinP2Voj6AK8r+sgGvIgJ4LRwf2G7YRE?=
 =?us-ascii?Q?jnqrGNTpSiBH1RenvP4xRJsgAcwRm0Xr26jpI1Y6g0OUAytgkCL7Y9fZfENm?=
 =?us-ascii?Q?jh0TL5ifSsbOxyOREv0eVR1et4oMBCDv6paGd9kuU7m4SvhU9pwb4INEeIt0?=
 =?us-ascii?Q?ZezU2a7olbKrsyYWNV3SRI6Q3Wu0z/+z4G78ayVq7sikBP5nbX2OWdOQcY/N?=
 =?us-ascii?Q?Mj9BlEh+MwYuvVjfMTYhEkpl2IRSDf1Y57d5BgObOGORUQU9lY3hQ4gVGtEX?=
 =?us-ascii?Q?nTOzFMSyzuwhqaKMLbdplKIonLa9lOEjFVDinOaqb9o8ewCnuOYmAeBzp13i?=
 =?us-ascii?Q?pN4hrVJJGLS1NrYeqEHqFZkkkqdcSOa0tAYOGSTKEfkJlVFExz+JGK3RiD1R?=
 =?us-ascii?Q?Rl4f/t4gq1VRQX7LA6s8PwV538kapWz0E+/+Fjkkor8PssQzqbL/sorXnGLL?=
 =?us-ascii?Q?/0ijcd7g3rpS4/kHNtTlqub9f1tUjFqB/nfutX91M5m+CLoDU5rmUSvrKr/e?=
 =?us-ascii?Q?uNWeWFui4NXJ/MGv2gMtUuGlWu27dclHTUF+czanF/xS460laux1eywkSvKD?=
 =?us-ascii?Q?oi2VfqGEOJkL2b6Yd/5L5xGKxX+RhhLHdqe+MKVrC0cSLrxkEm+xNhKdqJDE?=
 =?us-ascii?Q?s46VuvsZ4Bb8DGWWuPnO89PK4biHgkHcszF8yxmCPdmNXNa40oPrZNVl9raW?=
 =?us-ascii?Q?xJDnJmEPs0WqD1eGsGtapdHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9680dac4-7a4c-4fb2-81f3-08d94173392f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:38.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOiPTPWu8GXnPMDSgsUhZadwClfb/YtbtLk/FA8/KnRJ2RXRyrVL3N0s68AAwnb1gsqfN9+sAfq9I5Wc11D8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

GHCB specification defines the reason code for reason set 0. The reason
codes defined in the set 0 do not cover all possible causes for a guest
to request termination.

The reason set 1 to 255 is reserved for the vendor-specific codes.
Reseve the reason set 1 for the Linux guest. Define an error codes for
reason set 1.

While at it, change the sev_es_terminate() to accept the reason set
parameter.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  6 +++---
 arch/x86/include/asm/sev-common.h |  8 ++++++++
 arch/x86/kernel/sev-shared.c      | 11 ++++-------
 arch/x86/kernel/sev.c             |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 28bcf04c022e..7760959fe96d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -122,7 +122,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_PROT_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
 		return false;
@@ -175,7 +175,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -202,5 +202,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 23929a3010df..e75e29c05f59 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -63,9 +63,17 @@
 	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
 	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
 
+/* Error code from reason set 0 */
+#define SEV_TERM_SET_GEN		0
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
+/* Linux specific reason codes (used with reason set 1) */
+#define SEV_TERM_SET_LINUX		1
+#define GHCB_TERM_REGISTER		0	/* GHCB GPA registration failure */
+#define GHCB_TERM_PSC			1	/* Page State Change failure */
+#define GHCB_TERM_PVALIDATE		2	/* Pvalidate failure */
+
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 34821da5f05e..c54be2698df0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -36,15 +36,12 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int reason)
+static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
-	/*
-	 * Tell the hypervisor what went wrong - only reason-set 0 is
-	 * currently supported.
-	 */
-	val |= GHCB_SEV_TERM_REASON(0, reason);
+	/* Tell the hypervisor what went wrong. */
+	val |= GHCB_SEV_TERM_REASON(set, reason);
 
 	/* Request Guest Termination from Hypvervisor */
 	sev_es_wr_ghcb_msr(val);
@@ -242,7 +239,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 540b81ac54c9..0245fe986615 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1432,7 +1432,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1480,7 +1480,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	/* Do initial setup or terminate the guest */
 	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-- 
2.17.1

