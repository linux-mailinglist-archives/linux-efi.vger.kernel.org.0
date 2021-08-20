Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F13F2ED0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhHTPVj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:39 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:8352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241066AbhHTPVd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJW1kpx8kknzH8cNYIofVXLGJ+zhibzxJWfl9+b5aYtaNTSJzixQX6NNR0qTuRiUd/USwkVSYKTMzhi9DyvOCLrgzgv8BMbKVVmO4MeUalFVxwMYonNdtS2bufHs/tqhHmmC4Wc7KEAIWa9EIHq0tvVLjja4mVxh2cMgmiqDaRolmgQc43XPGmw/Gmyh2SWTwhENn2kgmab7kJMGgdwhisbQ1nX3qgdwqGpvj9Yk5RopHsgzSaxUFkgN6kqqmhwblwOYEwJZqWf12lwCReOZJEuyRawe3/f6k7giMhLa/4tnzfJgSGibF8kz7oYEBhF55w4Sb+yEib5AdkIOQvvSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR9f5Xjt+Wy+OrimmL0RD9IF1Qe9yBktnGHvL6u1gpk=;
 b=CLLM70owTiNxodSncAtyNTBkE6Qrjc347BunxNqCsVeV4DA/VBRaYFYSgeRxxKN0Gawzr2mPJ4901jB2IetRuXrx5v7QTYuMAcMg1qBBT9fx3TbgcM6tYyCrvp6oDy6grXPg5gdWwDCOImsZLlTyBnSYs7IE4jK28GbQpqjIQq+OfgS/yHDs1ZmnosDvMUhllz6ZMHC4BrH6qdqZAUd2b0Xby3tkl8+xMdiB7ojTxZjy4lnmcq2s60APocgpvQwOw911AFKSN1AkeZqEVV2kQwN8D5U1FCtL1mdW7U3pQ16/h2PF+DzTr217XyXrQ1RcfVlB3DKn5Okf1qDGVG5VXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR9f5Xjt+Wy+OrimmL0RD9IF1Qe9yBktnGHvL6u1gpk=;
 b=QLd1YS9T96YbIP6LQrAr+QubJSHV2Ks1GPJ+WZIOZNc50uWZMNcU5c/VXjnqfwR/ffB/XLSK4NVauLEkeFnQ0YtNFw20a8PJMfVnLkU+Efs4MZ/BFuebk6a47q8c+dNy1ybeCfQkwVvif4eXFIU5GbXv5cWVtvGI6ArdUKnBlII=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:20:50 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:20:50 +0000
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
        Borislav Petkov <bp@suse.de>
Subject: [PATCH Part1 v5 03/38] x86/sev: Get rid of excessive use of defines
Date:   Fri, 20 Aug 2021 10:18:58 -0500
Message-Id: <20210820151933.22401-4-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c58e7343-e2ea-4d91-d2f3-08d963ee178e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719CBF2CB8C8901E85C8565E5C19@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScqjWuLqlzTP1Y63UQisuTHaERuMFy1KK+uOlXJSR/l0t7BimCdGHJfZVv5R6gNYGR/qCld8885K0i2wZ8Y83ymOU4LdyJrIT7ccIbncLY0Bs/gAh0kiDPxqssIjeHtefwlOTqfNEZp/oUet+q4l6K6TDFujzBBnRqekv6WfdQPx296ePllgEXbXqqb8GYSvhy9ab+0RtOGjG7rFx6sbFWhUjfEPIebA/0qnr4ODxsliGdCmtBD7Ao+9vaXSGvd5swhtc7jgfKRGRnPHf2A7PtCsVBThWkVk/dZ8Gt1xVrSi4wdq/DMT4b0RqQTVrSC5m2cLa/8QegxyH46knRKtDbhZYiOmdc1/zfSyP8zYoF1yNQmBbN+O4adbu1UnfhTzIJN+vwNxT/kmAn4720vQq3+N4/ioC5+HsxlFl2Mr6kzP/aCi+MBMyIpG0Exc2ftSbU3I2N4sLikCWsMr2R5dDpucpqUlyCezUSFUCP74WGdt+8vTzOxUcS2JcN/u3Mr7FTCQO7wIZo9W1/FcpCh7KGix4F2y4lEyYknAN/HX3AEHlZPWQZuUGDA22YXqIbMVZlBXj/cjCFoiHx4YXcZOPsAZX+FY/hWEbsXyI7otfR6QvCKJcSskt1QAQgTTACpEDYEXhbYHlF4S1R2VhF3R1kfvTTDJ/DpEW9OE7yUR6zSCtLp7NOKU/SY+2wsltgkTZ6a+niwVSDxP72mdLlYQ2rYPVVhLfJexpIHNC800kgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(956004)(38100700002)(38350700002)(8936002)(52116002)(6486002)(478600001)(8676002)(44832011)(2616005)(66476007)(7416002)(66556008)(7406005)(2906002)(83380400001)(66946007)(5660300002)(54906003)(316002)(86362001)(6666004)(26005)(4326008)(186003)(7696005)(36756003)(1076003)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUM86UKPI/dQoUsOLezqdjlgEBIBKwcfS2lO7Z2rjipOl+lxkJUXGlN30OHQ?=
 =?us-ascii?Q?kJnQah8AH0GZh+yWUZPmOvhCjNIe49liUXsc49fwf7FvKID0/WwwPUnazbdE?=
 =?us-ascii?Q?PCu8D4OesBl/+qgeqkLPBzQGFZLlRGVgVxZ7COOz3fQy++n4NYR6WHIRAHKD?=
 =?us-ascii?Q?N0kLJxoIwy5eGVqCX0sW0P/PklTMzgdnvHy8OhT0SNfi4/n7tZqr1CrHLEl5?=
 =?us-ascii?Q?I+A2iO86KqyLTOTO3V0X4nboJcEgMSGFpD6oEtNU7d5CB+TKh926J1KSwWGe?=
 =?us-ascii?Q?ahfZRCwXv91HgSFcE0+vVwLi6l5UAIESSuvwbegMMxCW7KVbUHL55PeTLCqk?=
 =?us-ascii?Q?v7UHdqomyrIUoZJ582DpQHQnV8dU9RlNGTBtIg4KExpJA6glT1eY3DtkKxVZ?=
 =?us-ascii?Q?4zoygk53Nhn8ynQ7fSAmUQ+5K6oxQSSvqGxvfd0wCoWmW4i5C9jrWtYSLKu1?=
 =?us-ascii?Q?qwSYlo3baJX+tk9FQymoWECc6CGfe2RNwqHT47LvuYvy+rIQXzUfbl1DEDO0?=
 =?us-ascii?Q?5Bg5WZ/Gwe4HjF/8QSFlXw03jMRX9k748C4Ed1r9/xXkF8WjJf/MwaNJYoGI?=
 =?us-ascii?Q?yTkQ3noVGnzERoSjBnn/1dDL3s1SzQLSp1G8yB+P754fpmJVRJKSFvGwBCI2?=
 =?us-ascii?Q?dwOHS7rWEHApRYE4wOK9jTvppIF5SN1frDgbeWEfbbMZhPQQ29Qjz15d/sCw?=
 =?us-ascii?Q?y5efbnJQzi3MMbdIi4vJMAC2RWJjf8uE8pMKmDVFzyu2tEraotc+i+WGh9Xp?=
 =?us-ascii?Q?zq0zM1Y4w/OTYdHrXBZ5bAs4VSP+XuY14iCDwQU9ioILhHeMqGLlcTlQRbpD?=
 =?us-ascii?Q?8p+5HTsl4fDBGYOaTwAi5jFIphULUoo0v4lFy2DI/w672f0a/NSG7ap2uv0l?=
 =?us-ascii?Q?OdFRHaTpuy738wzOgKzOkiV793TSC5U6YZr2mPZd158NRd8KH4VC9JK8JQIr?=
 =?us-ascii?Q?Mtn3+OLmFh2x1hYC0KRazjx/F4UaHFcBpkxtzyBPuVmc24+/pMeHNXdOgVcn?=
 =?us-ascii?Q?r3UW6M1rngVdblQ/bmOgrIL08c4ra9T1XqSb2UXNi9QCjv10ir7ulU2ynKAS?=
 =?us-ascii?Q?4ZW6RkD/INE4jj5G9Ej6HBLh2KzUshMb/w9t57QRyYKsx2kUjlSBS0pEVTvD?=
 =?us-ascii?Q?XVfvE75qwqiOwoyxE/tfP16fGZlEfAT3mAvpyK7aTWi1/Lt7ktxZaR/7DDWD?=
 =?us-ascii?Q?n7Z1QceqsYTIC9dm70tRnFySnVW2nMMqAJfa6PgHdQEz7+XD+GVo1SiYrYDO?=
 =?us-ascii?Q?Fez3msrmvhyet9BTtwEzVrdVFM4SeIGyfs5ow+CqHrqYarYrjWHqqGO2Vi6I?=
 =?us-ascii?Q?NQGSLuDsfkUSO7t91NP6AQ5X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58e7343-e2ea-4d91-d2f3-08d963ee178e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:20:50.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+sdBf6p5Yh+iRWq6zKESKcqG7O5KwQ7/EeveqgmEl2GlD/gOya4JZa0mX84XocEy6x93MH1gV2hfjlebOW3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Remove all the defines of masks and bit positions for the GHCB MSR
protocol and use comments instead which correspond directly to the spec
so that following those can be a lot easier and straightforward with the
spec opened in parallel to the code.

Aligh vertically while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/sev-common.h | 51 +++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 855b0ec9c4e8..aac44c3f839c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -18,20 +18,19 @@
 /* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)	\
+	/* GHCBData[63:48] */			\
+	((((_max) & 0xffff) << 48) |		\
+	 /* GHCBData[47:32] */			\
+	 (((_min) & 0xffff) << 32) |		\
+	 /* GHCBData[31:24] */			\
+	 (((_cbit) & 0xff)  << 24) |		\
 	 GHCB_MSR_SEV_INFO_RESP)
+
 #define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
-#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
-#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> 48) & 0xffff)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> 32) & 0xffff)
 
 /* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
@@ -46,27 +45,33 @@
 #define GHCB_CPUID_REQ_EBX		1
 #define GHCB_CPUID_REQ_ECX		2
 #define GHCB_CPUID_REQ_EDX		3
-#define GHCB_CPUID_REQ(fn, reg)		\
-		(GHCB_MSR_CPUID_REQ | \
-		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
-		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+#define GHCB_CPUID_REQ(fn, reg)				\
+	/* GHCBData[11:0] */				\
+	(GHCB_MSR_CPUID_REQ |				\
+	/* GHCBData[31:12] */				\
+	(((unsigned long)(reg) & 0x3) << 30) |		\
+	/* GHCBData[63:32] */				\
+	(((unsigned long)fn) << 32))
 
 /* AP Reset Hold */
-#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
-#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
 /* GHCB Hypervisor Feature Request/Response */
-#define GHCB_MSR_HV_FT_REQ			0x080
-#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_REQ		0x080
+#define GHCB_MSR_HV_FT_RESP		0x081
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
 #define GHCB_MSR_TERM_REASON_POS	16
 #define GHCB_MSR_TERM_REASON_MASK	0xff
-#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
-	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
-	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)	\
+	/* GHCBData[15:12] */				\
+	(((((u64)reason_set) &  0xf) << 12) |		\
+	 /* GHCBData[23:16] */				\
+	((((u64)reason_val) & 0xff) << 16))
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
-- 
2.17.1

