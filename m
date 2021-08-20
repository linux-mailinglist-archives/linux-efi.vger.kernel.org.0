Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02B3F2F13
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbhHTPW5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:22:57 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:58049
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241303AbhHTPWU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD66gOf1vXgMH5h2zGmoeOGQqFKGj037xPKCtLHC+TTp5IvHGBPnT+ueC/9YI1HvGuaorAKER7Qrzw6PZu6noPP1C1XSHUbQ/XJ0NtFjMxlfB/dlsHbdvofphd7Q8s+3oJscJThM3B7i2IGwrUI2HFzs+H5l8XnX6uOjoKpPLuoXKeOh7I0HZRu5b3Jx8aofId2v2b2FaF+ftwqY1lKNpJTkzCTyBQdx3YCpsCTTS+M7BqW0FA6iTgs7aPm9cbTdQbU8EROd6LnZj72fX8KiRBOrDF15MpUc7621cRtRfWfr362+70O0L7Zh1UbuPWiCLxt0LTvNxZWCFSztHLqE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GAj0n/mh4HxIHmd8pu1nVhyIj/Ean9oCwoFOmBwMJ4=;
 b=NIZC4QxH2dftZb8G6+PBVZI7gh92m8RkiOy15B29DVKfVSRXuvZbaUu17ggWRKHG1aXjLl9ZrYue77p93f9WU17ePlnHvj56Q2vVEzP0M13rPRDLDPd6dMw8qEGFL9CBx/6ktuO/R8XL/1b55bszOTJyV778LRnysXtWQxAXs9py3vsre0mb8LIjaArzFC8dwr5WtBfRVk3fVYFdt/zDJoQLlool0A3pDa2YoptlQyDzV2nlFEnI9y5JCu/Vx8qKpcel/mv2UVIBsWdSEDlmRM9Q+7T/vGo5dtkCLwJfJ8fR3Jip59QsxPTO+JmVjT69IzcglNh/O0Gh7beSBQVUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GAj0n/mh4HxIHmd8pu1nVhyIj/Ean9oCwoFOmBwMJ4=;
 b=xbszn9ayIDU8VXJUH/Jot6tCMZiqM2BENpd6vaRUKMcnybvD7qdCGBlkYK8C8YSPybGeH2ElOEAVbVWUcLcdTay6KBl+PFSWfgndJboopk48WE6GM1+4IsMM+rj5EzBp77EynUjVXTWDg6lAdWtYPN74CbOAI0yj5qpFHbcVAeE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2446.namprd12.prod.outlook.com (2603:10b6:802:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 15:21:08 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:08 +0000
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
Subject: [PATCH Part1 v5 16/38] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Fri, 20 Aug 2021 10:19:11 -0500
Message-Id: <20210820151933.22401-17-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e8c95a-7068-4cfa-d868-08d963ee223c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2446499D541B396F4B4A29A4E5C19@SN1PR12MB2446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+qy+TXfWVdcPFNCtljsM8jNEqZpJaE+I0VjM/dQ4gKdrF8fdHmJvc/VvIqMF1Onhn1pt/eFgDXQArBufs7T3GomegnRjXvwxoFzBvRqbnez6MDu1dt0BeqvFFnJQzYveDpEmkqM0sErmjf8//oskhrZbdc9K7UVtS2yPrQ6kxLlhVHBsUS/3fl7bTSgFCYMBp6GNWzEqNvIoeOkuoSvYS5hY41uUg4gdID/FIUQsix50iXD+o9+gVBsk1/8rwMVu5WNR/aawWhzz/g8La2aPG69Ebl7DE4PH7H2GmmZZeAyKZDGrwjzZSXqMrguxprb490cOT4smVihyi8vNGcMVWXpDdcO0y63q1nDeEsppsY3cXIKacZgKquh4glBbfV8e/H98+ym6XkUMWkrRv4j17wNCc3CW075nEgPY6LoYwUGzMJDxei3dM2BiLkaNz8qoNN/9yhnszmadPbbl2D/B5xiUioifGcWaO9X2hcge1Dn8HzZLQg52wCIwx4NXIJ7qGCmmLirPrKDmIulvRW/Yzzsz4etWHhjl6Qtnmhr57COxPxXnsmcUIcQarrOJEt1z0PuE6ee22EosQu/IcF5YQdNqTwhhh4I3B9TcFjzTONDjIgWO81b2vIbs6SSTs0B9oUVAjt2Alkrh+7t5a7K6WCYNOPRNg9LUPcCJYM9bHImUyk9vmT05lYwTLIEqYvqW0hVGPX5Vu36HV+BOivrIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(478600001)(54906003)(4326008)(1076003)(6486002)(7416002)(38350700002)(52116002)(83380400001)(2616005)(7696005)(38100700002)(8676002)(26005)(8936002)(15650500001)(2906002)(316002)(66946007)(86362001)(66476007)(44832011)(36756003)(956004)(6666004)(5660300002)(7406005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrV06unxxeCp2w2dMfodb5qIkg3iua4Xa4VFbeWZyFU4H+6yF3S2iJc6ghip?=
 =?us-ascii?Q?YLW0wRmtv3VV5Q5Lvspc/TWNk6Zb2ThZ0wcEKSgFomKYlp4LTfIypkxtS5Tl?=
 =?us-ascii?Q?5ecbHQt6yBDzw6tsAqCQwdP0oIo0GXMg/nQagp9RZIwYvvs33oXQ8P/X2he8?=
 =?us-ascii?Q?zne1jH9XydRXygpXQI8X9Nwj/dgPZBj6J/KRhILmkWkzjalck6q715LtD4Ni?=
 =?us-ascii?Q?IHGOHAFi5uVXjg5gM8KtRPt+FJqBXYU5Opa9yp3jsggBA0h+KF7wJsax30El?=
 =?us-ascii?Q?Dq8HOT6vvX7+z3f/KKHfKg2l2LU58TOsUQ243lGY2smFYdUAgxAv9qVeYVwT?=
 =?us-ascii?Q?7k6NDVyySbZTU+vSt55/jl9sqZpKsVX8GYr6AGvbpLd38pyA365gsrn/8twW?=
 =?us-ascii?Q?mQq3A/RQ7Ao4vMiVduCLzwRnvYYxulIQqHtZdRbfmSPNjzSY/FPmQ4dVslLl?=
 =?us-ascii?Q?cy0/iUONV7zpMp61aFq8rDFd9SSGPa5x5UD6WzClS+8qQA0ECuh0cbbPHd9k?=
 =?us-ascii?Q?med3OUcw/R/7H5FH6Qq7oeCuI5zCV8ww7YnteEytJnOKkwNyy+kMI+fhdiBg?=
 =?us-ascii?Q?of4K8J2320jd/niJ5fp2Bm3ckxRJNXt+u874o6xgHJx/SqT9PXzysJ8m+WjS?=
 =?us-ascii?Q?gWY6lngmpky+Rc+0q1sdL/WR/bO8144N1BeoGYg9KyQ+W4KGLNTnmMNtrjGr?=
 =?us-ascii?Q?RJpFF5u6/CHe4By3ccMLZMX7HVPHCs4qYSZz8v0woUVQQOZUCH6PqjMF4OxX?=
 =?us-ascii?Q?ob1Z4Gjz+IfWkKD0keSrY6g0L1hnlYgOm6bvZ9phZzTdGXJJUVT/labDqO5f?=
 =?us-ascii?Q?4/AIQ909UWa8ji1HEb8BnrogtiNMKsZAr4zH8AdpAihdiyqN88Wm+7d0TNi0?=
 =?us-ascii?Q?JcHoJdyOiXJhxQvUUhJSsRcLRGZi3NHdAcy0B/zn3S8puoFRYdLCWnkrQSc/?=
 =?us-ascii?Q?df9GtrcCYuHqC/WSWtsPIcZcG5lg662Ye/Ce4efUGFGT3Gsato6eekJve399?=
 =?us-ascii?Q?ZvpyLU+ubTqsonH0zxWcARz9z+NJ1gfHnJUeN1FUD2LV///VIRdsOQ9RAD7w?=
 =?us-ascii?Q?Q35zEr5HCPlW0YZoy3neB63kzUmx450sG5AyiFKCdLEEUG68CpitwDpABVKM?=
 =?us-ascii?Q?94qa3SRNz6Gme6ar8MEtRYYwg+/jSw96g0aS9fb1TZu4pIFoKkU2VRbb3CoB?=
 =?us-ascii?Q?H8ECkN19mqfXVJZuAcaMMfQUcnRv/yzEnZjgxs1i3swEwpaPucbIJE1da+Ue?=
 =?us-ascii?Q?jf28fjB4zL5BoqYR0eQN32z5xNIO7V9VY09BLG+3N8VcjCc4a2kQW84037Ro?=
 =?us-ascii?Q?A3KugPsOJSx+VvrE6ayndHKi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e8c95a-7068-4cfa-d868-08d963ee223c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:08.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eE46G4bXuZceEBXoa3S1YrVxiuVmMkaKofODuZ0M939hAoLmJKWBwGkp24g+JMNBVLKaJA9jewvOKQI0QwaBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
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
index 9e1def3744f2..9c09df86d167 100644
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
+			SNP_PAGE_STATE_PRIVATE);
+
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
-- 
2.17.1

