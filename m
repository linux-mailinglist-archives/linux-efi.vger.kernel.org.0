Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D437EB4C
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhELTYH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:24:07 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:63366
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348934AbhELRjq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip1J2j39eXS9ABkVN6/OKQjHbbzyTcTL3zHv479K08pv7NotVMdUpTqje2MOD3CGE67NwSnRkvUoD/L2iktKjpNY5WP4bOtg+y9rvJUMUyOygg/YmQ84RQAQOnV61lWKfJBp5gHKchpy3NWdMmjzzcT7x8owDu3uNsjsYMWo6RMYbEOmpGWw83JcYnzqXf0+H+pUHGVMqyuH/kp6UlDvk4dzfnr2I+oTYFArGJ9cKQGziLzKGC+k0ueWsff8+vURsXB87Ikg7X85MdqBAuER8t9UUzIAMe5iAFIk28k3+Sy9dYVECncDwvDqElZqkvK3U3XqjklzSJSdsgSJ8QPr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=WXfEhK7k7JcqPSKfttbbP3zJODBIGWLu5cLPHn0EK96Q14ihv2/+PO2NBJCVkQwaZDXhJ7DrJnONNbsYek91xjW79RjRpbXfzXUhZXDVpZ6fbTRf+7oRiZXZP77qjZeDttIriwoWGiwcNkOoq3wfZTtXNrxC1/27NaBbtGcEhUt1Mxa4V2kRfC0G9kENz2qts2BlfUK8CY1zEcDzOIPnDu/0N5E8jiUxI6oF8emyHHE90eIIDNlraH9qR0IuSjanIIPwd6eWE1YMXgXqIjb9h45YbDz4BzLWUPVNETmghlF0GgMO8C31vohDWcU6K4qqZy8KlB4axw8DK9g7jxHvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=cU07z+f/Eg/boEdjcakZRjy7h6E+HzQyABFiUr0h0E0Jl1UUszq/9w3Sx2H+moQC399TEhH4WfICtTZgj0IRMdxIEvH1gj3ezui/RkM7Vn3nHfaA/CPDEL6LDCrOT/o+gsfkmNj85qXOP2LjaoPATND3WIlm8YjciEu3iYgJtzI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:33 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 6/7] arm64: efi: Export screen_info
Date:   Wed, 12 May 2021 10:37:46 -0700
Message-Id: <1620841067-46606-7-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
References: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.1.144]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b3e410-3a5d-45a9-3562-08d9156cc3af
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB14832CA8B85773E11820DD88D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tngt5jj9o2F2kGYl6+fFZDQZHhvkQE9FBb6tL1P2rpW0/ac4MO9w2YHzk1meJA6ElljRfDwhiGpOFZHOKFf7EdQP1nOr7zEHmfXwrvDUdammDQFPRu2ShPP4NZltjArf060EmgGFYYQbnm5pTQ/+W1t7ODJ9CvTFHceM0aEpORoiW/4P14yZVfT7Y98RCYu7STe9kch6/s+rRhDUlXVkokazOckGw/GaKN1J8f0fwC7sYAtxqdwM3VLxDowTZxgO9DpmArQIk4h9Y12VwaTzmqhFWemBxwJehPcntJauy7rqdirj8wzuta2VgC8Sgso6/yikzz/9wiiSqkhtG/8Cqg9ftKMH1r/Yt9nUsPzx6zuBNcYxihunuK7jHDzSITy8onYR9LSIXbafZ1c9ji3wuraPh3ONgNOnwtilR3JOF1WsSfC6cry9KkQp/Gtyma1i0hubx7Sm+RUtjobh+v+AAL6dK1l7A+2PfXjTG2BcdM8BtwPDM2teWY+18MRXZF4R7TOjh466QHWTPz1KQjLoTCwLe8H0o0xKryCDdyX4wEbRtJ4pJWh17QJuYRI8mnPQqVPvN9O05paacWB4A3GYf/YTB1yN0rXLQ7jhUbHp1ufH2wVatpGzSQM17pglNAaDqPz3vHRaxusVFgpe/wSy0KpwTZnieeqHtGPMwx6elDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(4744005)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wokl38XeL4w3jDxW6ca0u0eQxu0AGFh4XRQiU9RYWRQhOfcbha0iWEYUVJ9a?=
 =?us-ascii?Q?yalqhg99vfbcQylQNAo8tOUTikZsXMUZAaNuTfl382AWF8MpzBA84Y1rRi7+?=
 =?us-ascii?Q?ibxpnapwfe+O7Z1CNDOhQOUaR8t8uBs1VJXu9Lg5dPJRzAgfuGCZLzelexDI?=
 =?us-ascii?Q?IWH9dr3L5cPxC8iR24dCq7D78kOIZOm2k/+uWyd9QAKQQfsdjHn6vBEveOQT?=
 =?us-ascii?Q?Va6cC/uqrW9MMhs8DMxE8A3XE9X+c7RnfyQP/DOnbdceKPI/8rkki4t8iRA5?=
 =?us-ascii?Q?nLWeySu0cUPuutdMsi9PMM8gfn5S1DtQ06OzfCevF3E3HfSWQITmypy+hnKa?=
 =?us-ascii?Q?dAvmyEXSm8GiUOyWsBTgzxCSSEDjFZibua8ZcPEct2myS5cAmZFnohVhzDiD?=
 =?us-ascii?Q?eQ2qoNdMvwB8xw2WEzGrKuhjxogcx++hf7F3bfsE9VeB3yGKXd8phb/D/E6w?=
 =?us-ascii?Q?eP5lIAowhFlWvWibZdmD2uzrEYgVxcWxOSu1XMIdmyDBtQ8hg0yJPRyMbxlf?=
 =?us-ascii?Q?AL9QsER7PTHYTFxlaO3nGNDTNSrYhsMw8gbdhbPDuNyVbxpoY6mIkz6mNAtr?=
 =?us-ascii?Q?c4UcnG+Gr6h8SyOHsf8JfNc5Zgmv0k8SZIvNs2Y5TGcu8ORFDB6qu+Kri9h2?=
 =?us-ascii?Q?z3LiIwMVe1otGV48pjm/YE8zczxFNP+JLSRytyI7ICSWs0JeyaBTM4dRFAly?=
 =?us-ascii?Q?lAjNefZGzrvbEDDOD+cfJATylTHhflkoV4pZhB81RwOebH0MGcqupjFXyldr?=
 =?us-ascii?Q?hRBKZ/Kx4VB2wsVKAoEwrHIUj+zMZRP3do7sN3df+lgi0L4JOMwjRYG8QWg8?=
 =?us-ascii?Q?Ue8vvMZtgQlDqdU4DGQKrK4UM4y2Li8SczRHdnJasMnmHUZtFpuJZeqtMzxx?=
 =?us-ascii?Q?UTHWe8RMLsjUKsU51nW+NZYzqJ8gtLv8RkJ/K4s7XQ9Y6d8vAzqh9x7vzC0h?=
 =?us-ascii?Q?AbZNTlZYwCTE+X4xgoAL7aiZ9ODa3ggBEhGL5Uh/?=
X-MS-Exchange-AntiSpam-MessageData-1: S1UK2EBYoQwUyDA3kI85kdCT4Brs/7Vbw5rzCIVfbCkGWLPhAvYkJuM9/aROuMUlmk6OHs/GDs2qO4zHSszYEfpsH2Lsiey58tWzAskkJPuE8uwtRbr9D2USMtkRfoeiaTn5o9aUKo6XoVLOvwoiFi9YiS7dYONoCU1R2F3TIKMjpUrolV7U9U23dhxnZ9UfPhUHB9mwJpA5AKzHL0ax9GKX2OuYR358nBF4Ri3bcH0NImz+mvPHysem91iGWSzdHAmcbucN9RQXBsqe0l88NnheltLbZhhSxXvoxLqX6h/WzYL/XL4GhLeC9NC0i8ebYZ+cppyplMX7NdZxIcGjJtHG
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b3e410-3a5d-45a9-3562-08d9156cc3af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:33.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqdVY+B8wJ5o1CsxQKew2fLjn+rOP4LNodVhdmoADEazOlZzEewxMF8q8Sg8EQdozgF020hyy7dOniCgk7+R+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fa02efb..e1be6c4 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL(screen_info);
 
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
-- 
1.8.3.1

