Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2363F2F06
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhHTPWk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:40 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:8352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241029AbhHTPVp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6Cu6L0IbpxoLhrWe36MTteHCJ25DcoBkvD0c7LbYVUbBi99MXiYes6itFqd01b0iqkG9nMHY2Hu96NaQgOFtWJ9e4PTMMm1K4XaFJfRUcy6Kr921iKz3+14T/uHK8DvJQtrtFU+91rPs+WWelJ2kpYNaffa2PECnRbDB3m/P3abNQVPk9C1Y/BxiQl2d6e8ivCi+Qvr8OIwPK6CXvDPOTIC4WYb+2zuV+jk1vahOZh0CLIk9Boe2jeXzEhFNuGTqlvtoeep1ynNdA2FFVIoZA5uYhVditjRF9rf1crRrkwse8DBsfxujLzK1AyBbfsWLzgPHAxJ6XAvPLOvVDul/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsZWwoB/TNIyhU/a3IVzCQpCz29XTt8vd4SB2+Rsd8Y=;
 b=bEd3uY6BINEMCBTxsSBZvMuXVxPdWThvP/pHPAgdPFAmWO319KgZ34Lp4KEIJqFFT9rbolERZrtei13kMaLK4fgpDFsJudc+XiQwNasLctksrN0new42MxmtXrXTP9/UH713dFqbLdqmSkz9eifUr/23a292bY7AbEdK14bPpE0epmtJdAEX4oghXdBNwKZLCXqHINczkxzp8X446ktnTi/+AqzSn++Ec1w7guLndAJh7VwENpoHqegdZJ+RsKSFNsn/R1Ov0mm+mLzl6Hmx+IwLZlnD0EMfwR5ArrVGUW02B6mPwsRQRWiIkzKsRNEtCDLgRP+5GsGvBMRiCzp5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsZWwoB/TNIyhU/a3IVzCQpCz29XTt8vd4SB2+Rsd8Y=;
 b=1xj4RPlQC7yn1jG6AXhatMQ04cUHU34pt1rjWScuKbvdoZYGXlsClyh2q7/7iyFPLg4ziX5WEB5lrTJAsDgSn7r71haVlR+w4CyHky0iq5xks9mIFtZs+3iBDnb1fFXieoHiQPK2D4WnEnQyqro8w6s1Vn8tEIiEfod2IXJfg1c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:54 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:54 +0000
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
Subject: [PATCH Part1 v5 06/38] x86/sev: Save the negotiated GHCB version
Date:   Fri, 20 Aug 2021 10:19:01 -0500
Message-Id: <20210820151933.22401-7-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3c9c33-01b2-4bb4-31bd-08d963ee1a38
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27199320A7D263B24E968CD0E5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnPdq9yMl90DA7G16Oqv14SfoZ4kTVwzLAVKT/4oWM2CGwRFIHXDIQE0V6jH+85v3cc2tFbwCtDHsReTFYgtWeVFMgCq7R5krW5UckiHmedCT37h3e4cPqpwdrJvlkGEz7de+QL47Kvm8opFY6Pa+ZTuRay6wsLqz8zdmsuIja05SKTZh2qs/hu8PbBlny0eG5pFu1VZTqBfJmLjId00LLw17jAXNyuRHcHZd1sLWmcS1pkenETPVthWG9NKXGdc0XaVYwqV5gjBfFFoeXLoNdi9EVIfcFuZlqOIjlE3wbfhRAWtFIaMuH7+Y82qK5yjPnLa5BUaWd1+MJ/M3T2PbDzptuD+HYso5guBZb0czCllDJgSOIF6eruYw5CBVB0Vj17gwlfJ4B56J2us98Ewk3ccq2bRXaL+O99vA+4LIF9qXXnZuUrm27se/+qxveuv6EYSPzTRzcH6Ot6/orzwUmC/7F3mE+TmXnD0Vm8waT6XEyhJEAVSbmBexAUUt7yXKr/twVmA5vQ8WX8IyNr1wgy8WoIPi7R+G7VHuqN0CvmwboUrx1Y30fXl23Gh1o39fh2kuGG2FNp8UkcswdM4LWYmWvvzz+u415gXvjT2b6Xh2CWaI0NfXTypObr5KPQjfcuavpK59738MZ5PTif78i92IXz5Tx+6VA8I+UK/yRatQJltXhQWDSOSca7d0Irv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGcYLI6yjt4ckrsf+gNPkah2FFNDOwNyOJMCgoGCc2wyYHRWCHuvk+mTE3DD?=
 =?us-ascii?Q?c2t0Hszx3YMcv0zLSPQGsynZ2KnOF4hYwqe2hyU9p0s0FNHicRHhvNBJgDVi?=
 =?us-ascii?Q?qAFsQTfH4gOBLNXv2JpbHdHSd9tf1IBEz5AqPnjJ+WPkZW0Xi7IVT5Xw2KTP?=
 =?us-ascii?Q?7Atml+KdHKOC/WITgpUhQ3jEAanDuoB5NxJNVbQnJVAoyQt0LzVgrrf2ewUj?=
 =?us-ascii?Q?zie9gfoOIVinHoXmtRhc4sXr1HR7KyA78fSqfXcIeTHTOYLzkVn9xWDVt1K5?=
 =?us-ascii?Q?KjMR87nUyj3yOTRbVhTM3/AoOYHCdpgTxMac6SdnBXeGDqd4KVRM8Lm8kZPU?=
 =?us-ascii?Q?UYapBxETywJNV3xpZZFWrQKQhQdDxLePCco/djZZ2+bTFK032wwt4TpbC5Uc?=
 =?us-ascii?Q?Hk3aDSXyhPSYP8zpoFhbm18lpkMnWRuqa43kaifZe3b/caSHaGwMirJJl0Wm?=
 =?us-ascii?Q?hFCcU4gV+aGKw41lCyEdUfSi/EKbiPU0x/z2v02gOxz4fKpNz4vWYMLCR3ft?=
 =?us-ascii?Q?6LBWBMdyJ+CvRW9LdTb8LYh3LbkGL56dxkPv2ojg3y5MbNu34zeQboI7RKlP?=
 =?us-ascii?Q?rFjJfikkBXdsa2rrLfgJs0JRDcHQdUGmBydj8XV3fnL5tGEhPYztuH/N/1Ya?=
 =?us-ascii?Q?ZAOTW5XNqW80pVrXjGhRUzi7ixX6W4CGclrT1JeB7i2HoaKN1wZDdpUH3cvI?=
 =?us-ascii?Q?CUl0B1SioGZYefXPuLu8VMQacRDRsoghk8Suf6PaT7I7CULrAIsNEFUWiDwN?=
 =?us-ascii?Q?rnP7BlEc0vOkkaZjfHikMEMlCadrq+0DJ8OeDPYz2nQn8UeLCuEWd0bm3g3B?=
 =?us-ascii?Q?bnnC3+XrjkWpW3XPPZ0GrNz4v3DfZA9rcl2Wv/TSfp4Ub93KjHqdoR/6t1Zf?=
 =?us-ascii?Q?zZ/nCuMUyQEFKrtN2H4/PNnT8K9Ma6ACkce96Oly1Tbv3s3JLLyf9adqTAzM?=
 =?us-ascii?Q?yXcVamAG5oqnaSikjozS8LIVpRlgp4nYU4PWSWCpYQRWnuESoWvrCLWLcCJ8?=
 =?us-ascii?Q?tnLqaPeFEBZ1+uxbT8HlS1d/NNAA1gvbOlAm3gR4Qwq1noTI8Sp5g3DrvxMJ?=
 =?us-ascii?Q?MPumQB8aFxKuxHo53Rcj+xJ7bo8MW9npErBgK2xn2C4xWcdvIykgKyngfYMy?=
 =?us-ascii?Q?rgPpjeC9+OVARmC+qkavYBUx1f5iotYfyqiU7Q/p+GCbQ3euxJ6u25iFiSfb?=
 =?us-ascii?Q?KstYmZ6AwB22D2rFakHLcMIEE5o2tz70+YVThb95DwxMnLkBVuwM0iQEAsC9?=
 =?us-ascii?Q?kPEV6/X7/ogo04UKnsXmH5O1iQoLSPKZOoV4KNP87RX+nb5Nrg8GXEGOLFCv?=
 =?us-ascii?Q?TtDUGKSdzdNiAI4cVGQq2w1p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3c9c33-01b2-4bb4-31bd-08d963ee1a38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:54.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u75MQwAS85bMf/VZO4PfvzUKp4cnO9boxRhkLH+eu6/KLLlLcNUueoSe50DNvQIZFdyC4FDAV511apjSDd20cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 +-
 arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

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
index dab73fec74ec..58a6efb1f327 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,15 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+static u16 __ro_after_init ghcb_version;
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -51,10 +60,12 @@ static bool sev_es_negotiate_protocol(void)
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
 
@@ -99,7 +110,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	enum es_result ret;
 
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.17.1

