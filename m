Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4C493ED2
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jan 2022 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiASRKP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jan 2022 12:10:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243695AbiASRKP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jan 2022 12:10:15 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JGbhnK032613;
        Wed, 19 Jan 2022 17:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=nVndqhoacnhbXwBF9pf4cAFgFP0E88ISYrB3jwZ4y+I=;
 b=FqFKA3voXerD7DI+qB3SQfww7zmP4UdRafeOHKck+LDP6CFKNmO6uaYwgXqZKlpTq0Ee
 mckqbCYXCLwkhnurtyhKViyT79C9hjL6aBMTPSUYvBi7C5uZigmSpnRSUCA4dc4kVZsZ
 ZTIMY0He2OX6dPkH1N5uyq1Nj4QwKY6pA98ZDDTPY12EeO8sDcigQnDk+/F5m+64tBt2
 3shzMaOPygKPK5gmzF1D2RGQfy1Ytuh7lXYh8thBYgVhps5x4fhbdHCsbV2B3CoP60YE
 QkAyJq3h1GIc9sofDeTUZxzISB4Hf8ojiKdTHJxPjZfrzE2bGQnuMJMBerCRSvg225kp 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q5u63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:10:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JH6uxE193098;
        Wed, 19 Jan 2022 17:10:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3dkmae02hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu480p6fGyctGEVNw1tc4lzRPqOk251vIQbU+WTZGAht4/jaOBdxKYRBvkT+2QvFFDWsfuLIfPhQ2cD8A/pvNZ0UnLHzO8brPv8XsrTgTVabd0FiK2GC/a8NSB0bcPpuNAIU3RjTqwZMe1qBMWI9nqb5W8GwlYzAX7DuGgLtGQlLNfLBT5biVLCIYrjaD8DjIItzB+Y7l+MSqkBVaJPJ7qgtD/qz2cmgOYPScx8WeZW8FnSKX+/sBB2om2KFId7jkVKeEIGtHI8ZyPkdDg0zcS/a84VI9DU4BjlQOyfRBhZtCavMRo745yVAMB6r6C2fyuvHlHzArM47AqdM7tB0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVndqhoacnhbXwBF9pf4cAFgFP0E88ISYrB3jwZ4y+I=;
 b=KVXDTXk5VXS35+DDkp1c6r1Lu9nMB/8GFR0YM5Atwybv6FLGExC6fDerLukOlI12UZtw3p/jxieQMDkyAYcNAR6WeZB+zth8qWSz7lvD3zzCSyeQHBRDNk+3oZTDsujvclMspsPB544BYf2xbr3D8m2EWj7JZJ9To3omVfCXmJgXmnv6k1rPDt7Jv6yE2hw2KOeEntJyA4zqVQLsXFiV2RV9cepVHTB4UIS39oCELgiMmj+uvnSeWt/5euQMpGvovcfRCWyei+hXONth8BhqR8fekUf0mhi7XeFNEV6H40un2rC7ixb7KZ4fxGqcGZp1LiLT9FYR9lT9RDt+q2PCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVndqhoacnhbXwBF9pf4cAFgFP0E88ISYrB3jwZ4y+I=;
 b=KapuioueIeNPzrbPGgIbolbQ2+Nd33fNUDPp5Ph8dgiq1Z0QHesMQ4257+iZykOfbayHaoDF0ieax27oa4/ehqnVAIg3h8Cnx0/4QWg21VS7FGi8AgGv+qEMyuJT7EVKJ8B01SK5CjjKAZIlJMA7LtG8KQqlZjiLHA0PLrHYv6Q=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 17:10:08 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::b815:57ec:4994:e5cb]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::b815:57ec:4994:e5cb%9]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 17:10:08 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     ardb@kernel.org
Cc:     mihai.carabas@oracle.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: arm64: Fix image check alignment at entry
Date:   Wed, 19 Jan 2022 18:14:27 +0200
Message-Id: <1642608867-21307-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PH0PR10MB5894.namprd10.prod.outlook.com
 (2603:10b6:510:14b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ab472d-c438-483d-61dc-08d9db6e8b92
X-MS-TrafficTypeDiagnostic: CH0PR10MB5099:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB50992069FBDA79FFD3146A2588599@CH0PR10MB5099.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfRveNuJ1A2N7TQgCwtC9zdjTZ0I1hwXSMYmh8pz7UmAYVJwzTyvdeDRUoTP2FpHDIk3LKaYVed4veAJ0zYIDlJdPKTldye1yUk0B/MoCEE5xvjY8ml5flMr1ct94hTUqD0hs4zZfBVtlpQ/O5E0MkHD0k95pDuG6qQSKCNdUbv228iC5EbbU5W8MomZfh6ahD4s1tuDR1lLuW6LfIxQtTJ6fnVRsv3JByzdN7BK31LS2N+Qh8xNM6xF/AGIs78CiVpgjeXOXowmwVH4BFrhkxuW2FwfAJ9C9D8Dckhg47ytIauXFQw2eQRv6MhQ1lJJl/JyXaCm5PXi7ouglzlQ3RL3nDPvoHdAowZuHhYddQ47U+Uy8/T9FNWWqTLFDDsNy0u+02Z/ZdDrDu+3W19SC4kmOa1xuza3C5s++USl1oJwDo7lyNrIbDkLW6ZpRHoKHETVfMLFPyAyUlqDwnWqGFUQ7Jmv9FpZM8u013B+319F0GgZ4jg9ok3LA54bLjQZvf8gcdJT6b0IpzJoj+SiSKSN/POU2rKVHQJzDURVL+MkZBEOO1LZ6ZxzIJPz0j767BAjpByN/I2MtIJz9OqM716uumQpRhC9Mr49tr7fPdNHcNPrGKRFoN9z9n4zm/G0LmLsWkQuXwI45LQFNwbcKsLXVEHdb2efaje88OmhIPKNYnjX6qBBoODv5mXwcoKKMZTWnpkffubnRVgdfuOluA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5894.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(86362001)(44832011)(6666004)(66476007)(2616005)(186003)(36756003)(26005)(2906002)(8676002)(6506007)(316002)(8936002)(4326008)(6512007)(6916009)(83380400001)(66946007)(508600001)(5660300002)(6486002)(38100700002)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhyLjmyTVLRKMcVcW5B7PkUQMxWfxuW+zCMkT53d8Qm8fYZxZrY1wAVyqQg8?=
 =?us-ascii?Q?LPqrKvCgiF9iZf5M+Sx5a2F9GJ5IYOS/fBa+RSBowwl63q3aFLM5uJacVmo+?=
 =?us-ascii?Q?Ait1ZXe4LTpS5zAbNR58RC436FnxmFiJu4lIcIfxcLoUsWX61pDGTVWSPLGI?=
 =?us-ascii?Q?Bli73LI2bLPoVbNbpC2zO14/HLxhwVSriuYD5RYaztjNJqmd7zkoQjogIClC?=
 =?us-ascii?Q?g1ehb6wywCcZgeq6IATcLxPyu3zr1NuMvdY9jGJQkyvuZMjpdNxHm4nTlzSp?=
 =?us-ascii?Q?q2dH/OmsVzWiIvzl2Y1yTy9p22lPTygwm8WBRE9/LW2MLap6bjuGQ4IElIu5?=
 =?us-ascii?Q?rRH7FmMtiPePUhVao1DiwqiN+VXpm9gUD8LYcJtucN+X1X3uL3LRd3jnuhYw?=
 =?us-ascii?Q?j6BNvlp5PEB68W4kNuTivPeULpPEoD1UN0TMvBWR81jubBbTa4E009rhZ7dd?=
 =?us-ascii?Q?uSXiUWW/lKOi7owMMD13QNSse9Y0lzfthe0CNun1UgQRICM7wAeGKclekpAt?=
 =?us-ascii?Q?vwZJlQLohFcWYDh/olWkGnjzl/wWomJwG7GWE6EsLKyylj5cm/bmRMc763pu?=
 =?us-ascii?Q?vacOfqc9+GiNW3IZhyEaYt3yQgfNSlOKESI2bbCMx+hEltiOX7qUDRt7pZh0?=
 =?us-ascii?Q?+CvhvWDTHyZT12yo8vcPxZxOMRoChEv0VLuIBknxTS9kRWFlhPZXIxUoWh3z?=
 =?us-ascii?Q?f6yEJJ8zdfebrpFfYCpXH057ltZGLVeB5tpTAEZOqzRs27nDld7DbcnrAXw8?=
 =?us-ascii?Q?v2zt761tLoWx6FpHBxq1byn5OwuCd/1zIf/98rxEzMwQ0z8/eXl4gbonXF4h?=
 =?us-ascii?Q?OU6foq8puAz67fwdfsrUkEhHKd6265JRUFJ0RxYm8+qEGpMhTz5fIDVJMYjK?=
 =?us-ascii?Q?OnaaUJFSmS10HnK5ibdubO7yeefeYL9veidkuMHLQMpSRwJ3htVWycf9djQQ?=
 =?us-ascii?Q?nE31tzkv6cZQ5/2Fy0lh0OdZ1emasxy/IQiOFtjs6q52TJpG60eMIYta6ZAt?=
 =?us-ascii?Q?wYFD+lYbDM+U9R+FB/bJ/ooWqvsy4CG1zlfDWSdwFyx+E3Bn5bvEpSgPFoZT?=
 =?us-ascii?Q?1d5M+kR8FnSi/4acCB1JSFfH5NaSElNHS6zFOQAjGXOcUo6Rg4kjiQQkyRuo?=
 =?us-ascii?Q?FojGWhTrS8TOnaBr9mNSVq0EGttlma0cNKwzE9jdqv4QjWSbnAtA8wsJnYfz?=
 =?us-ascii?Q?v+2T74sdRUdItc/tu24nLx0UIapQqzwvsH9Cnm/r2oqsKDY+Rz9Jd6qhwP5/?=
 =?us-ascii?Q?wbL7HPUc6ifTg9PqUXAQKnBMmB9yBGdw1/pvxPt1darNgJbdZb4zClWMCLb+?=
 =?us-ascii?Q?MSCxXH4QIluqYT2yCZqEJljloDs7+ARr3TCIy0mlLDg50MbwjscsMri7KxLo?=
 =?us-ascii?Q?XKm7vbbIWTuYE46xi67ml7aoMtWrdD2HrzsxZj4eMnPlynCxmJ0uZxBAzQRe?=
 =?us-ascii?Q?jicrr/FMIvOmcQZXt2e61X3mOXW4YweKTgojhkfbNF7rEVWsCYX4As7RmF26?=
 =?us-ascii?Q?uap20LcIIGfQAZUNjBla5bAMPcWhjHW8vtum9KsrcJB/0/vqxEmulOSrYNCM?=
 =?us-ascii?Q?Lf5+u3zAywuszKXOaHJLJWp1Cgt5A2d2zWQN8gvH608bHRe7BELsGbAF6mPi?=
 =?us-ascii?Q?9OOrU/zgn5rpp8SUolkul5qUOjdPMp1+M/FksQB5OEXsEqICPOmdHs5tRXrB?=
 =?us-ascii?Q?gPkrPQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ab472d-c438-483d-61dc-08d9db6e8b92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 17:10:08.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOcBiSZMUWzF7Gs4lj0IiVUtattFC70QkiNeWe3Zo4fj+cI4vHTGPu8RtS5emUCel6p3ycYwRoWk7LLgwbu8D+XlbHjGeY+IN4dCOPfF7Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190097
X-Proofpoint-GUID: ozTcPMtgxXl3upv2z5oqzbdr4QAtPYij
X-Proofpoint-ORIG-GUID: ozTcPMtgxXl3upv2z5oqzbdr4QAtPYij
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kernel is aligned at SEGMENT_SIZE and this is the size populated in the PE
headers:

arch/arm64/kernel/efi-header.S: .long   SEGMENT_ALIGN // SectionAlignment

EFI_KIMG_ALIGN is defined as: (SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN :
THREAD_ALIGN)

So it depends on THREAD_ALIGN. On newer builds this message started to appear
even though the loader is taking into account the PE header (which is stating
SEGMENT_ALIGN).

Fixes: c32ac11da3f8 ("efi/libstub: arm64: Double check image alignment at entry")
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 2363fee9211c..9cc556013d08 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -119,9 +119,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	if (image->image_base != _text)
 		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
 
-	if (!IS_ALIGNED((u64)_text, EFI_KIMG_ALIGN))
-		efi_err("FIRMWARE BUG: kernel image not aligned on %ldk boundary\n",
-			EFI_KIMG_ALIGN >> 10);
+	if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
+		efi_err("FIRMWARE BUG: kernel image not aligned on %dk boundary\n",
+			SEGMENT_ALIGN >> 10);
 
 	kernel_size = _edata - _text;
 	kernel_memsize = kernel_size + (_end - _edata);
-- 
1.8.3.1

