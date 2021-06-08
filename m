Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96F939FE95
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhFHSIN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:08:13 -0400
Received: from mail-dm6nam08on2050.outbound.protection.outlook.com ([40.107.102.50]:36833
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233996AbhFHSIM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpAO0QT39p+77zMrggkj423NPPFKM1DoK9HbKzrP2KotyOKeppujxq4kmyvnUTYUwyA2tkU/CdTh96pARXfBP2Zki2p5T6x5FLA0a/6jUhD38tGXvVXRgbEc/rQ780cwOZQe7sg2emdHs3zGRrca8Py0NvMI+660JlgdOY84T+MfvqCIovjbM40HDE2Y2kiDTZNgYYnH0Ag+apbuIMu+sO0LFBeUPd7F4Q8gf47k3H8i/iQbemhxm1Wcp+wHfGo9Hn5WY5vVnvj8un0bQTgLVjt8B7MXUFwjsXMjIkvZpM3fONN9R5Lta/Fh9fG9wlnBK+YCa2Cr5LrQPmBK4OJHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El3whwmkdfWMns+nsJ2zA7g76wDB9Lbs38DDSo8Hy5k=;
 b=kQ+yruKgKyt5+c/np6ldVlrwBFoTg8cBBc9vyCa2QiHJTVU5LBCVhaMU8c/Ix4HwHs5B2TUnl+hi77R/lSQgrvMByh78KuLuh2Nl2o2F/RS9T3GIfm23/PConL/X/NO+Mzr9VTQqhp/F5j5JagUmnJSUkNQKKE06s0mYVQBEvm4rmx+xofNj+WeQS9iv5fGaPV6jLaNDtPuoTZ/VKJksyhU/hXOWQK8t5kvtxEKHd4V/8l1rm29ayH0NOjuFKZMSibdHEWg56tjN0uqpBhzGFVPA9bcHkMfJkwpAOk4w5nCQ6RTd43VVLZTdSBSHydFkULrKEBj37AVsM+0zsXBcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El3whwmkdfWMns+nsJ2zA7g76wDB9Lbs38DDSo8Hy5k=;
 b=xFC+0gPaEa496spy1eU+dZGNSarS11eOcEGvm6RvfKh7ow/U/mVhqI0VMUbyWpYzPof1RddU48sAYc5GTFZmVUIxMD6wUjUVxvcCGjNd0oTxxzIbqIPutVRCOvyyFgL6AK1MOo5pBnHv34P8GyE1PAeS6dqRGwjNCUypZV3p1v0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BYAPR12MB2936.namprd12.prod.outlook.com (2603:10b6:a03:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 18:06:17 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:06:17 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 2/5] KVM: x86: invert KVM_HYPERCALL to default to VMMCALL
Date:   Tue,  8 Jun 2021 18:06:04 +0000
Message-Id: <f45c503fad62c899473b5a6fd0f2085208d6dfaf.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623174621.git.ashish.kalra@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:806:d0::21) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 18:06:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a73a46d5-8516-4c3c-cbf7-08d92aa81c4a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29362974BBC5808668C856658E379@BYAPR12MB2936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xKU1DH87gf9QnTSFBMUuwXniqZHuVxQaqWMc8J1VTTFTJDSHdXy9RFvGNY3ZnXAgHz5kXuCr7LJs/tgAtVty+Hi8gswS4k1300mnwzEy4pe4/PYlPTMvyf3L7JRr/EC2XINDn6Y60Oq6xD+fixSWnqq0oBwOfgJhYrp6y9nQtyR7Wa8N1RYxdgTbJ6GXW0at/sP9ye7nwJ6fhnhhm3iExub00TsA31SXdSX4dLkDgjGhHxHuLabzDUaYl90jCSMfu9A7G4XdiHwI2qOUZM4h9ayXlaTHXQZJgu+jrEiadPZMZ18V7zi8pbqSIfORp0n9G4G2ajsj2lBiw5vG8HYwGfV/gr4CcGyEwHnVZoRhfx2ekZWv7l+4gL0wfX44+CBnd4NxUWBhp+nLZ4/a6CCN3jleLKdWSX1SD4yZJ9Nd3AZD/C5sg19tAJ0IT2maYQEGV84yhJqRWoV7ngRd0pScmfS8A1vHZpWzpEWE7IZM2SiFSGt5pkuw6etSvYO7699tBk0CpE+A4B+wq3pbOG01swWFsy/08L02RyBm2DI90EluFdOecyd3b7Uc/a820YRkj/OtB4wnGWO5DbWCLjSQtetS/FzBpz7TPWS+v7sjl6gyhIdRPjBMcHqcZMJ9npfU+3QGEl2wSKxacPaDvCZGzxoiT2eGQ7YCMta9WBBmK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(478600001)(36756003)(38100700002)(38350700002)(16526019)(2616005)(316002)(186003)(956004)(7416002)(5660300002)(8676002)(6486002)(26005)(4326008)(83380400001)(52116002)(8936002)(7696005)(6916009)(66946007)(6666004)(66556008)(66476007)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFW3aI07L/t0EmRhuZBTz8QcZxUkuZgohDhIh1HqCQQjgMTNkiazNP+qy24e?=
 =?us-ascii?Q?0JB2SuGiSP6+eAvVvOT0bkgH7Gs6zBO7qZ+sRNQvnjGUv54kB7k2ZZ2Q+pmj?=
 =?us-ascii?Q?+DiLqb/jyDVU+H8lgKKV1Kl5kGpi0aM6LW/HEFKWnhLogOhG+ALAEE/jhMDW?=
 =?us-ascii?Q?Ijigc+RP2dZU9cMi8ORAncAhs/m2FI63a6UQ2aSABHpzrIJEGkeTb+xdGNXO?=
 =?us-ascii?Q?4vUa3O7Q4+OZXMa25NGBF3ELJ08tDhLnmq35CRjqz91WaWK1eGrqwVqP935J?=
 =?us-ascii?Q?JcwqEEoiHvsYWMkADVUgIxLhmt3hjj9lbvmlWPIoprWi8Jy1jJOAPW6M/NMD?=
 =?us-ascii?Q?PZ9fbIM7irysO+VKVS66gY0obWR27WeDn4tcSaQL3gDkR9CE3YgFk9msHZPV?=
 =?us-ascii?Q?TgDHioLeUGVXKsIoYTDwIgXhbaCTYSfFIR8Vc33LCpCA+AGm9HIeCA6cCivU?=
 =?us-ascii?Q?geuMiKX0Tv9pgZ+HgudQD0/OYqBK6fbhips5uYK2nVkcbTrCmJOAlXNeB/Zd?=
 =?us-ascii?Q?LttuELx6bctT+C0wm3SGJGz3wbs+BMJJIgcyPbaL3LxJVxV3/XngVjr3kCdB?=
 =?us-ascii?Q?jAQthqzT/7biqxOIaz9TeRAVhqm6/7vT/XmoNKSoat93pCdyHVqLLLLIV69k?=
 =?us-ascii?Q?voy5urpkXyHXJgIAVGRIcFzs0SMLop5RytoXSpywyas09v0jwLCltI13m5j4?=
 =?us-ascii?Q?LKswfSCGX2QqiJbIpMCPpORt6bPBoqh2js+6kb9zHsFrid42td5m1UmvDxMm?=
 =?us-ascii?Q?w4f/+yV0nxM5FGvDm382KgzNnLOUfzNIgEJiv9z+n/Rj0G4NwLtvKX4jQO9K?=
 =?us-ascii?Q?yHFU8kiSvTwSYHoEpZIDm49GTgu0UYJ+oQyQN3N1kQO7hNje0erAyry1tqcO?=
 =?us-ascii?Q?KiwkrBflQRfxl4+JjVIdZhvsveFM50WVbCkeQ/LiFTtVgOwVmzkZFhk0TjJZ?=
 =?us-ascii?Q?EO3jrmeacdmgs0mh4T1Z2GloLJ0v8cdT1SbiEsJ9gtFS5YS+Pnea4NFt9okI?=
 =?us-ascii?Q?CoQQnSgvKjFvPkoma8Wdi7NLr3CllPj9yTQJWothO5qZikld7CSzUsC8ZukX?=
 =?us-ascii?Q?4DpYwapgMTV9SyDon8WQm7+NpDoWtI27ODX9w2+GxTUNqBPCJhwka97re5lW?=
 =?us-ascii?Q?Gee7wUAWbKDzYoxoaT/BKf5CKvvQ7vRBLRUweFbiyawQtuHvz4vdYW++QQOS?=
 =?us-ascii?Q?2i2w0PAISJ1EI6hvq8MKowEou9ItsPH2nj1+6Hf3q9dYbn5iUNT84K/vyPlW?=
 =?us-ascii?Q?53FD6UvLRPAXPC3WyZkF/zK3EvPWjPEz6krlyUjhksZLtlp1sm0CFlC+Dd+l?=
 =?us-ascii?Q?Xmm34ZYTNnkOg0UxRphr/keZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a46d5-8516-4c3c-cbf7-08d92aa81c4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:06:16.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvrHb27/jwJN9KWRtI7nwcwz+sjfmFlPSabC3DeW5qProWfiq2N2DayFdc7VCjNJAg7H4zA5XxlFkZfClN+V/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

KVM hypercall framework relies on alternative framework to patch the
VMCALL -> VMMCALL on AMD platform. If a hypercall is made before
apply_alternative() is called then it defaults to VMCALL. The approach
works fine on non SEV guest. A VMCALL would causes #UD, and hypervisor
will be able to decode the instruction and do the right things. But
when SEV is active, guest memory is encrypted with guest key and
hypervisor will not be able to decode the instruction bytes.

So invert KVM_HYPERCALL and X86_FEATURE_VMMCALL to default to VMMCALL
and opt into VMCALL.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/kvm_para.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 69299878b200..0267bebb0b0f 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -17,7 +17,7 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 #endif /* CONFIG_KVM_GUEST */
 
 #define KVM_HYPERCALL \
-        ALTERNATIVE("vmcall", "vmmcall", X86_FEATURE_VMMCALL)
+	ALTERNATIVE("vmmcall", "vmcall", X86_FEATURE_VMCALL)
 
 /* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
  * instruction.  The hypervisor may replace it with something else but only the
-- 
2.17.1

