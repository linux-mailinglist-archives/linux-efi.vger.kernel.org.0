Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16EE3BEE10
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhGGSTU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:19:20 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:41568
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231852AbhGGSTI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMpYYW/7hIy1JvaQr/V18OwzkizWzsGSXtbMoj6JUS3zMSQtieOm+yWeOUaP8an8AQTR/fUeH6JAlxx+MUxiZIhBmiZKLiYYnTVwvPLIysIOwzrh1RxQteifxyAHBNtPdikon95E5cvrvLXKdeq7KlcPZ7IhQM3JTSeQJZKjgkHx9vQHgg5oZnhR78mIZl+Gm6gNKn0Hp9i0pnOhFFKDv+LbgnK3nc8ayATYWrs6T3aEfE3hv2b4Pg0+/40TsQBZ6v3t00huGuBh+Zy0IWId5m0rSUbGBlpCq+UzrPzBKL8hSe1/pZH1zcYYPVRooFhxR/odDnIMx/Xx0YrfoZV5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GAj0n/mh4HxIHmd8pu1nVhyIj/Ean9oCwoFOmBwMJ4=;
 b=QZDNAd8tCQjcm/zLruYyjQa24/Bo1wwKs3o2Dy1Cwwa9DyyKiGoIYGYnQMfttvQMZIlycv++4fVqGSo+u8B3TpLX283CK39HC4zYGxaPHcpLSj2lZprWyb8staYcpsbqyx5ox2a66aD1t2jz+nwvkKYUjmaIJjUff+iG1Ak/X890MWnUezF07v7S8Lbs+6Xd88ojmJ/G4j3UzUucK5dTMLAWZ1Jax6Y/YNbmWKuqGKyEvyXLvGY1OH//bfB2tr3/JWQrG9mtKxU8GdNf5xF0RoxdKSYrBn5IUYBZfqcf3UL2UmukAUmg7+33DJBk7XuoToSpQJDY7mE71UvsKKcpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GAj0n/mh4HxIHmd8pu1nVhyIj/Ean9oCwoFOmBwMJ4=;
 b=5RHnVb78UBKrSMlIKp60JbFxI5m0avGO2ETkiNk6cocqafWzILc9vVMufIKvl2Twzgrc2eBG10HSVmITSCAY1T2B/3JNUCOoDUtPJwSymHXOst7DL5ILTTn7rD80IfuXnqbQU9PNr0UNTA4lAlNL/+v/DvLhgKuhWzpSuFV6pAQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:16:03 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:16:02 +0000
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
Subject: [PATCH Part1 RFC v4 14/36] x86/kernel: Validate rom memory before accessing when SEV-SNP is active
Date:   Wed,  7 Jul 2021 13:14:44 -0500
Message-Id: <20210707181506.30489-15-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:16:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6c17605-d6ad-47b6-7608-08d941734783
X-MS-TrafficTypeDiagnostic: BY5PR12MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB50164DE2EF6044E506BFD111E51A9@BY5PR12MB5016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7vv3yFO3nB310cMkrqtD7Tvvoc/7evptrBTo1/FbTeYU+cjI+ctkUAVbPKH6oa2KBiY8UUJGHLNCs6KVcwDadxR7ARF4liJf9PPucoQ3x1movXfYWom6A1y3B+Ed0fst/BYRvPBzuaJssYw8a5z7QWpcODyNd/y63HoUm/xUYMuZWxPC2b5W84AEsUAuBDzzdHdXe8zMIUQStvwIHMAFx/wXLaUj5jSGW8G8mJQagwV72YlozWM79xf0fBe+2d9Jlf9GHSdDey5TSsA9Tz4Lh/+lyOS8zFj0wFprT8SezXMBLEe/WNtR7aY4iPvd0LpRqxsyCV5x3Wm3nlRHOBXpU58oNp1KrG2Sz3O19AMoL1wXAG9ZUA2XeJpE7uLGA2ZW8ctIzy0wX4uwMahd2e4g8NdAWmrVOuaE2OTHYgs34CLSvInw6ykSqnoimuGfeggci+4u/+ChYtSOwfx8YHzyIo5M/vbo1c6i5PxXO9X0/zqibdDG9I2ZHIDdq2euZFpTATjLBgzivsbbRMe+LwwM7+820YfEuhtNbLfrTSpiKBRVVADJ4gly/UVQjGUYs6TGcBXLUQ/hhvcOFqy96gSXMlhpudJ4D938rWckb0HTeGT0QNJi7KHy2SXsS7vbK8GBEbbCwf2h8LdORvnXFAiKjj0VtYxd1fLdjq1WUx+POrCBf/0tPBxLKZagwutpZcVOMDP+13tSKGPCgPLA7So5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(186003)(7416002)(52116002)(15650500001)(86362001)(26005)(956004)(8936002)(478600001)(7406005)(7696005)(8676002)(83380400001)(5660300002)(2616005)(38350700002)(38100700002)(44832011)(2906002)(1076003)(54906003)(6666004)(66946007)(316002)(4326008)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/yRKhMEE+J12SNMMPueZRiIJbxEv/x0HAQl1rVMoKtd8zfyC6eCH7W94qnb?=
 =?us-ascii?Q?RDs7UsBLQ8W5eJCxIxSaA/+ZSjGzfJ8dEsJdP9qVC1byKK29xcGlFwQ9rpp3?=
 =?us-ascii?Q?Zd4Lrnph131b2+GeQDLU9kvB3OvEUr8inIpKB9Q8pNqRQnZSVUNwJ/LPIsJA?=
 =?us-ascii?Q?GypzXGUpFwajfdaDkVvz/sD8IVhmtD/BjY4wp+1PG/n+KdP/IQ7xXqtaP6uD?=
 =?us-ascii?Q?nfEZ4Jth8KupkBS2H9hj3seh8BkAOmYDdyHcJwiUsV4qPq8HtaUko6USv7lI?=
 =?us-ascii?Q?izds4HzGBoZ2pf+ZXgqdrt1/uYSKtOzU6Pv2Y/DGgvJ5Nl4mWsPdGUJO4kVO?=
 =?us-ascii?Q?T+DLg6l9lKESKEYlYe6k7xnkxjp1u/wSfIY5c+N5tglnyrLkJzUlPuLxYLm+?=
 =?us-ascii?Q?viu1PupL3JvFtfgGXyhYmZmx9/AKnP/3m9B9CXAjo3oL/Niqu0s8GgAbqAMg?=
 =?us-ascii?Q?x+Wu42KIr0WTkK7s7SLFhHU+cmXrMHchgzWi9aX4dRuq205iRc03ZFlHsCAx?=
 =?us-ascii?Q?VIwWeeaV8r6ItbO3/9a17T/IzSwvKVlEyLaxIKa17I2Hvvejdn1/6kV9tS8J?=
 =?us-ascii?Q?OholRSMEwSzqyiNL/ZtD0xMXQ9YUpxwgAzwWZQjT2K0U6oKJ+F2M2YPachqz?=
 =?us-ascii?Q?azjc7vJEbZ7qV7BkMIdSpY9JfxSDeAafHoo8nSyb/ttOWFVww0iXXDVkFGnf?=
 =?us-ascii?Q?umossHb1HeS3wyYepu9soR19iGhUtT31VVdjJsAuPfbLaHeZrMMBGeVbk/dd?=
 =?us-ascii?Q?kyxiTwzYEceHIoVS+hmsHutJVRTqDalygD5N3aNmXxk9AJoL5R/16Umfk2+n?=
 =?us-ascii?Q?yhuRjTNlTbU3poscYacFJ643UN1cPaHfXYbueZRfswe09rLgIJu8jyG3ElnN?=
 =?us-ascii?Q?+OJcHEwHX1O+W6VNamkEICuClH06fYLTf6uj15UkDDv6C9+uPTZdrNqYrAWF?=
 =?us-ascii?Q?uwOQExL7F6lPgJlTFdqcVeQ+nQhMufJDPqvKoVUl4KZDOBAHD8ApODjQYfaP?=
 =?us-ascii?Q?odsf3oBQQ7ggosfE2gh3x2xDkt6R10E7CGiUYAAY8hlOdNvzGRUtqZ6uOtsb?=
 =?us-ascii?Q?uxLGG4fglqkQCtq5WWPl7UR3y4csuDpHiOVcBSJne56ucen4B/Kgjv3JP716?=
 =?us-ascii?Q?GOSF3oWfFvSD6H8V/kGrdZ6vIwvRAs0IdzmJKs81z48LIgwvcXx1CaSaEdle?=
 =?us-ascii?Q?GFb8H8hAWGIzlCKSnz0xpOQjXaxtKD5/nKQsBwpnLA4CKG1JUesVcyXtDm+p?=
 =?us-ascii?Q?F6eqYCfzENMmO8iBJnK0thoFjqYVIPvFWIO0QMDlC9WsdHraw0wuu5MTj7ay?=
 =?us-ascii?Q?OLEA+f8B1wAufWYisZbPw6B6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c17605-d6ad-47b6-7608-08d941734783
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:16:02.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTRMRBhlR2P3C9VixrNNYfNEPVCwKtKvR/E+Z1MtOAntDLHJGA34Kfqie/MCJSipK37ub0vfPM877CYW/JsgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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

