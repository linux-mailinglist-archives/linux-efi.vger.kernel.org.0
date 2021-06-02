Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAD398B70
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFBOGb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:06:31 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230204AbhFBOG3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYovAfl/TNxk5UhMueoqrDpa5MGEYYiXTQZN66633GgFWT/P97aSNEapBj2t8u9HxRm8C8Pix0rkfSshOQEHt+EKw9S2nCiLr23tCEpKnC2TuKqZlu6itG1uEApnQ9zjs9q0ZX3WJeqe2VSj1/uw9ZxUmWFkff+God15+S5x8zwtQX0Ze80QXKMxH0ICFZSqr/iAmqoXtasmCDPX4eKKNIxF/z8iYTA49d1pwbZ1J0cowqhF6zwtMIHRLi7pqBuopdmaGCdVCJWpqg7piGp0lfRYkN1RsNPojDWyfQJCLuJkNHEtFr8XR9j6Zz6UIBEwAEBgJtWoI9spYFHxf0Rh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUi8IKlfPuatJ3taYQHxLzfjzCX7c4pWwH07mgJYwMU=;
 b=VWG1JF2b85LRy43HvT4gPqtek7cL7lxhaPUQo2Yuo/0qkkCKC27hpTUtQywkx1wDIY7DrM/DDdDg7RIQO9zSgLNYx8tUTU1m61KlHDfZiO/o/Iq7MGs23orjJUSyl8R8hwozID6+9vamMJkq8WmG9j5pwQA9iK8evkbPSTPxv5jD1VF7tghepKtT5yo2PkUH127DzohWRRkyzcV78oliavgiAZzqR22NToBneG71nhRoRe3GbjaoyD3ipb7p7jSIJMoAOuc9W0pbN3+ZQhh2j59nyAhjxh79cuGa0l3kk8I31M6S1YBreExzfP+5Ag/Y1IXYqCBszXxihRTFzlKu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUi8IKlfPuatJ3taYQHxLzfjzCX7c4pWwH07mgJYwMU=;
 b=Wf3UyiaE5mXmHSwO7wq/4DvSOr0ohGbj2rtWavYSk+FxfDUIycUgQqXFhCQ//LEveP0ESzRJmmgsPc7ede+oKprPuAK4N32kVI+mp5nRnArxfZ2NTHzqEtvfrwdfNT9nQVB2viAybrJyR5yNacQiSXL/bXWfQhqufzfbWQ4A8AE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 14:04:43 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:04:43 +0000
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 RFC v3 03/22] x86/sev: Save the negotiated GHCB version
Date:   Wed,  2 Jun 2021 09:03:57 -0500
Message-Id: <20210602140416.23573-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d64f8b2e-a7d9-456c-137b-08d925cf5f0a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4512FD475353FE6D36BB25FDE53D9@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK7iSoj/CyjlGkwegZfe+Ek9cX10aeaEoKtHrMZHR9crqOHH5RxDYWxwrpX2L30XWRBMTux9uxKdIt4AFPZWVd3evRo3JZK6OxLPiF437V4JAf2Q91IbzNhOmVdMsuk7BFBJoA7EXJU3O18KNnTPwQjXfoV+gRyP8+/Awr0T36PTKPBO/zxga7EsSmV078fSBbyynFpXTZR79QOIFBiAvaE4TcWgbMMfbNzBCW5RVkpK44X4HRakMzmaxj2LhVPMJAF8Gf5gMWOMEahkN1v/iI+SOd5jJnvwh2pRjoQaFGSFUFlRfS8G8bSnOBMlm11UMeiUqGFtHR4b5VSHUnSrwybtrg6NWEHAv2+PLJxcB2+xJTAhPXIdOAOwTSZQHEOiBZKf764Jrl0G9WF7uhQfJEb7voxiVunk/d6affdDu1bJ3INwjiSBUhmqT3UirLQDiTvceyFN49Gsyr66vQLVSYUrWJNPBloPLa0hl8XESApJcVtmvs1x++AuFYaXmAjqokJWyUV+cRFeAOrMQnIDCm/+PfFrl8bdFmqrq8L67bNJUbQGiBTF2MUwoyOIiPT/aIyU88V16i+es0pz9zv0RpXIwGHcjAhoirUa7S178fRH8FkmxLMplfLIKlW++Knlmhxf7EbXRJKW1m1McLSrpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6666004)(44832011)(7416002)(26005)(2906002)(8676002)(6486002)(7696005)(52116002)(38100700002)(478600001)(956004)(66556008)(186003)(1076003)(36756003)(8936002)(16526019)(66946007)(83380400001)(38350700002)(5660300002)(2616005)(54906003)(4326008)(86362001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dKUKgl+z0P1DuHLAn4MxfsoHptYek5gBChtvAOJLRMXcWzjXHBV4UOpEZplp?=
 =?us-ascii?Q?4r5tYni/bV3OXEGnFbzSecqjAQC4ySQ4v0pJ4hXKjfCuzZfr7OFdilWbrRsY?=
 =?us-ascii?Q?DdV3SPF1p2Vowi6tBeeQSm99zn6uR2rugSoFs71SUGV4iNieZ+fR9sYt1CWL?=
 =?us-ascii?Q?Sxedg5q7V0V2NW+2M39x0tXSyANEvc+vRt5lxOgmIg8emtNdtk5CejYcilfl?=
 =?us-ascii?Q?fWRN4W/PpBy3a7rJXutOGCAUNe0zzXoD0PP0O2crAx9F8TJCktUsBCVgvRCd?=
 =?us-ascii?Q?s9nAO0yszHua7rAuIXnnhKkUPo9DfIB/GJ/dQNqycCNJUE9rlU5gsscdWh//?=
 =?us-ascii?Q?/nRnGUZHcXzPCNFgRTyvSL6moM1ncAZKBzrG81+Xj4dHGtNB2H5DI9yc0Jz/?=
 =?us-ascii?Q?HbKSFPsxzzoxuN0duFH3SO4Y+s8UMjhGhLhYUA5DWSyGpf4dj6HrmJ+XaPMh?=
 =?us-ascii?Q?fBBbh2TcNS23lHYCGvzP4LtmIU9tp8Z9voKW4OED0nZXaXKkz/LJ2xJGgVyg?=
 =?us-ascii?Q?nw3JMbd0VJQQyVpZmORFmWtM0aJODWvtQlJwStyA+MrVQ94uAa+IhhhQIhSX?=
 =?us-ascii?Q?2Pvg8ZhlEvqivByFFoCkmRVAHfb6a99mqVCUCh8EY/wXhGMddWneOO09NgWV?=
 =?us-ascii?Q?zbpNfPRzL+3lQ1yPXxcRTh+hwMdDgIzuQldzt1n4SP9Fn0/SWaPnoLGxF0Oq?=
 =?us-ascii?Q?TWAy2EX1RZpQDvzzW76yjUbn/Pwm3qrL7LlukTZE+c3FOnxSIdsfFrEJebTk?=
 =?us-ascii?Q?w2SGudfuc2NFtpIw6F348rk1fZwjXoPraG3MNcPZAVwnKNxeVslaSAxoOwS0?=
 =?us-ascii?Q?Ymj689UvQ8IL5eJdasEJ8ap6vX2ws0yZQnG8LeUHYC+nzRNbAQ6LfWjQBxxF?=
 =?us-ascii?Q?RqA1Hm1UPAMwca4RK2Tr4eghWP0p3SZGrXtVPFNGWO32j/MUgXF72lqRUj1l?=
 =?us-ascii?Q?5WsiNvrtsBWkp4cJvXLMHXwoj08gxuZQ4t8Hf7VmgMaTrQc5AkF8JsM0rofI?=
 =?us-ascii?Q?RFsiGej9+rwYd4DfYoDHlJXMpSkNcYdVN9O0qAMNs75G9a2cUiTXAPKriHqE?=
 =?us-ascii?Q?ozw7hlqmF2Mew/3ZuIklrzQMz6sXNvyjXo+Kkbwlor3ww8h2BIPdoChd02FL?=
 =?us-ascii?Q?D7mJMyoBLZMdjMQu42IVXseYg9Y+/BS9ZdS0Vq9vl4559frB+FTnyIooS/vg?=
 =?us-ascii?Q?Ib0NPc2Ayt7CoKkrsnRcBwnTL1qmgMndoZkb/UCwqZCCBV/ZJ2aYqZyFw0tx?=
 =?us-ascii?Q?pbWRGtfZtKjX36eXB6rg4W4eNbo+8rVqGPw2OUyGPx4hfjVbmL6W3oKX8ufu?=
 =?us-ascii?Q?F78xtNwHlgrSdHfqWezwJsT2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64f8b2e-a7d9-456c-137b-08d925cf5f0a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:04:43.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEotlSw9bs5m6GdWwc1NY6lOa849Rb5aoGKH9Pp6VOZFz3iz8n3qaeaeiHKmZbSt/Al/RSUJhEQ5lMPvE7TywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 +-
 arch/x86/kernel/sev-shared.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa5cd05d3b5b..7ec91b1359df 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -12,7 +12,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 
-#define GHCB_PROTO_OUR		0x0001UL
+#define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	1ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index de0e7e6c52b8..70f181f20d92 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,13 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ */
+static u16 ghcb_version __section(".data");
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -54,10 +61,12 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
 		return false;
 
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
 	return true;
 }
 
@@ -101,7 +110,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	enum es_result ret;
 
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.17.1

