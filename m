Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A6398BBB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jun 2021 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFBOJF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Jun 2021 10:09:05 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:36984
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230377AbhFBOHv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Jun 2021 10:07:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/mBHPiurMftLFKfySTyalzs0PEBTKqClLubMhvtohk7hmKjG0c0vFzPqa+gPdBLZp3NJy8NTLwdcu4WMgkbAZjLf//LOpJt9aa5Dq4oZFVh4t54s1jsVRGG7lgTF4RQYC3zzTCXzT5Zf3PNLeeDNhXQAE5Kp+2F+WIgyPaOhYKnSFAoyeI2XHi0eJKTAnBXSamyVpzLE7Oiy+wshyfzpj7fy3qIFAvYQ4US9te7vXbflK4AKX5HpJMwYptnm/i1iDImo8cosxTXtsD/X6weWCqFOXdL7K4/i/jOQ80WhptToXUwg7goksb5DRXtYp6b0KQyudtWuGuLlqdjcLgLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBYwKWM1e2f6h3Bx093S/ZsTxx9S/8/Wr0mKLor3GzE=;
 b=Yb5f6xVHNfroGTC9sVwdhBb17Ai6u9gqVMF4DweX2sLM4mXEZmoNS8TavY4STJZRiccgyvlAlseUmXkfuJIhp35QMl6+ACEDHY3YLRj18BwM7xpBMUkqNf9EpJ6ZE1wd6jsX5CbwQYMi/+5MO5CLBX1r9Cifmml7iPIIB9av7rMbT0D128+1aBUuHL87is1+MUshcc2O+4+fLLe3yEWFsbZ/+GrSbZXF/OaDc+pHZEJHgiWBoJ/qvPTs9lXy9uuZBKnSiH3ADpnS4RobB7DJXgH/PHjPqQxbg9phYmjjVn5c2zEeYpREZ/Z8cHOTMWfi+d89szUfInX9Mw/6jaOhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBYwKWM1e2f6h3Bx093S/ZsTxx9S/8/Wr0mKLor3GzE=;
 b=cF8nLsfPWGx/jbtiqAGO2Pbkrs/4xMxo/frF7b/+JCxNz6HDb3k2qVUu1NKprOigiO4GdlyIPTaPz+nXWmFPKYiTiWQXT8QOEXDAsEykqIzxXsxW6Rv5mS6FmHhPMKNGrHrs7Fcn8QOCurxEvYnH1TzJZutuSjLMuUoxiKA8O7E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 14:05:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:05:00 +0000
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
Subject: [PATCH Part1 RFC v3 13/22] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Wed,  2 Jun 2021 09:04:07 -0500
Message-Id: <20210602140416.23573-14-brijesh.singh@amd.com>
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
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 14:04:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7bd03a4-6a6b-4711-f548-08d925cf68dc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766CB46FB3C4448408C00F4E53D9@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ts37rTnYNg1nyIuRjqFKaG6HCJPdV5cqH/WSR1o/q0DchoER6eNkcxsvh1CI8/YHukm9urdE0uz7VdINMGRDS+m1Odhs2y/1YshwegpJBXTRxQacX5YBdFPNanVq7MFMSW89oOf1cYUFzHfmDJeDVj0Id+bfd0PhPGyC3NeHhNJcBp2X8MXdTB/4ODlIpgnEYmvd6NPt+ZXkeLSPXn1QsFH1tjM5b2qzJVhFDplkA8jxNAjygVufIYDyVgoagMU6vXYpPwOApyPns+pgsa0QGjHVSYQH/x2yf+HggePx6ahWcTMgk0AKLdrNFeuh2THUr4YhYZDOEMS+o1ItRSMdToOxudyrZ8nfQZqXW5gpWi4iVE9PLuQXXigpnNVRfKxFLxQEvPjmrAIZgf11vM4dV/H2rxk7c/LbsKgAgyJxrjXkrdHMc/EZdxW3Im663/VALLsJWyY8Eer7FLNiYexrORLJVHoSvIPYyuN+STznpGCa80QuOofKYB2Q89TkRh9kpxkY/l2j4q8fKXQehYiRcEXPwvZNN29I17s8h/qJtPUDzHLexwfPyTOFmFuBLNq1jkFBuREJUHAqJhngkJtVsBZfsne+4Kwi9t5DURizHaEBNrNuP73Sq0basQf9SQbP++shjGjbGE/9SBgNMop3cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6486002)(38350700002)(86362001)(66946007)(38100700002)(44832011)(52116002)(36756003)(8676002)(83380400001)(7416002)(26005)(4326008)(2616005)(1076003)(186003)(956004)(16526019)(2906002)(316002)(54906003)(6666004)(66476007)(15650500001)(478600001)(5660300002)(7696005)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XzlLhSQV+R6HHd1W8+cMp1U2Wm63s6SO//gMAWJYnDHtb8n3uhLGpENnTUaa?=
 =?us-ascii?Q?mVCrTI6cuZUtAgsAiLPtvHFP2qACmP+4+4EIxnKlNOMGyjv8mGytqJsf0qON?=
 =?us-ascii?Q?RvkbsIqznNYKAoZDoUs8fPMXwv9mCKPolppK+7WEHNRvuT4R/QaNgql2DBxf?=
 =?us-ascii?Q?f6/MWsqSqG6u40svy7njiugwXxq+dmc99ubRRka5j8oF2ZgiHK8hDun/Dyfi?=
 =?us-ascii?Q?86MhAtaI78iJtaVWkpTS428e6eTRcHf8hMxSrCS1fJvthrh2UBzbd1jgd2Oz?=
 =?us-ascii?Q?Mz7Si2U9/nFluXhml9M4liu68BHu5jZa5tK313GzjvatupxRvmwla5SaHcWi?=
 =?us-ascii?Q?AQjg+A+ju6UcnDh2om+jF65rnkaK2kULDBaXKZEGwU3VYk7Slnkof/ITyoPH?=
 =?us-ascii?Q?UwubB+U0sK/7DH2b+sOVfcWjtPKZUHajplr9rfNV90xHNIrebbSw7RnHPbVc?=
 =?us-ascii?Q?CVc1ronQPSa1XOes0zestZ5FpoQZuTkpajm0rIreDDirplPJlguwFYh7TctC?=
 =?us-ascii?Q?GKNK7AjgZ/pezE3csYbk0zmOD7HNnsOTsFf8TMwRPGzhQXWPq2+JZ61g1e4h?=
 =?us-ascii?Q?yikTT3jUvtJ6pKNUwwR7iaS9JboI91hcTj7rd0P/hOH65HgTkXTtLmZwlTJ/?=
 =?us-ascii?Q?4qoyaC6xKnyxq/xrdFboIVPUGJ7HndFQ/4+1aaAZOHJEUUYdEy/30BEFYusF?=
 =?us-ascii?Q?ElzY8lxISOQFRJ6V9S65qyp2cQWAGcdi8HMc271Lci7av5424NdEyxOl+DkW?=
 =?us-ascii?Q?yuOF5ywxnfUIaAqulOO16U7RK/usjmwFGDVaJKXTxXNX+DXIQKWBNXCW5Xo/?=
 =?us-ascii?Q?kpZQJ7V4MqOKpNZeouZIaig6+rfycUwqfWF6Vm2SetpztToo4a4s1VghZs7h?=
 =?us-ascii?Q?KczRP5JmLDkVyzhzbeLoS0UDB+jGWrHDB9bUIOKhxsrQcl0V5MB3bHKrSOtd?=
 =?us-ascii?Q?vQP1UxwZWE8n3MTUe7ilvOtMKFwO6yiBzZRf/hMY7jbNs2bkGMSP9uRGot6D?=
 =?us-ascii?Q?uKmeoxfVpit+dw8UfbNjrQ4/knXwe7+idB4U9+Ilg+Nfm2wlkDlSLLxI/x9k?=
 =?us-ascii?Q?REqWFgnsHI8+okRgCYnMC1aFoGirAfGOLtdcVAfJbH3SFWxqRwJBhEUuwYLS?=
 =?us-ascii?Q?o5TOOcEqMNSqZr40AqZ185/JCPGNn9nLugxHmmQSi0Zixk21PfZK9E7ri/zU?=
 =?us-ascii?Q?W5wZeJHoRQe2kzJmxdZyMcXONApMIUY0gA1ru7sM2GrQ6pPOVQXkeDsQja0i?=
 =?us-ascii?Q?gzPWowGf60PIaei1lI3FJXFTA+h6tsznRa9CCCOPBK/zHRza6MJd4qxCbDYj?=
 =?us-ascii?Q?7c62I3yJm5s3R71fX7mt2Q/p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd03a4-6a6b-4711-f548-08d925cf68dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:05:00.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoNWDRdWWMdR1Czh7wk0I5F8SAFcC4tHTUDP7mcAfeZmLsTbiMsocUZylB+giNA8Yw2nGQKZBQ5HAc7Ukw/4sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The probe_roms() access the memory range (0xc0000 - 0x10000) to probe
various ROMs. The memory range is not part of the E820 system RAM
range. The memory range is mapped as private (i.e encrypted) in page
table.

When SEV-SNP is active, all the private memory must be validated before
the access. The ROM range was not part of E820 map, so the guest BIOS
did not validate it. An access to invalidated memory will cause a VC
exception. The guest does not support handling not-validated VC exception
yet, so validate the ROM memory regions before it is accessed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kernel/probe_roms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 9e1def3744f2..04b59ee77e42 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/setup_arch.h>
+#include <asm/sev.h>
 
 static struct resource system_rom_resource = {
 	.name	= "System ROM",
@@ -197,11 +198,21 @@ static int __init romchecksum(const unsigned char *rom, unsigned long length)
 
 void __init probe_roms(void)
 {
-	const unsigned char *rom;
 	unsigned long start, length, upper;
+	const unsigned char *rom;
 	unsigned char c;
 	int i;
 
+	/*
+	 * The ROM memory is not part of the E820 system RAM and is not pre-validated
+	 * by the BIOS. The kernel page table maps the ROM region as encrypted memory,
+	 * the SEV-SNP requires the encrypted memory must be validated before the
+	 * access. Validate the ROM before accessing it.
+	 */
+	snp_prep_memory(video_rom_resource.start,
+			((system_rom_resource.end + 1) - video_rom_resource.start),
+			MEMORY_PRIVATE);
+
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
-- 
2.17.1

