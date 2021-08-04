Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A73E04FA
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHDPxo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:44 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239693AbhHDPxh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnpQUdBZtzaiC4ln3vlHDkC0r1S8fXw2Iy+udUDTDmc+teLF1Y+QLi9MzNtuK2STx13dKR1Q4CuA3dpaBM3h4zobKhwAQA8tSGYuipNQZRAzepYk0auY2+P05IHxMGvytEM0vzgLX8kKagMLOANcUvoMAvjZQ99yexQ6bR6OAS2y3+nRloc3LAOb6TjAYIEANjGswRq46EaF0te4WITISma2TziMuwVE6EqVE5eZhmTv+z9ThzfrpMawFUIuUKAk6ljJERvP2L4qEgczuWFGZnyLEw8YAHWQhXT8tPQ6uPTElcXswgEFwF+xRFMofY8cwvGuaHMRz5TV63nUbrBevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5c8TFRJoxKgaZcY7eK1KPeB8RnRqqNBzVRmNevhv9U=;
 b=AvKofbai+qB+72exFRhkHz8V0O6NQsskb21v7zS/g//s7TZHJfPIgXeHsZPNcb563mnyRbnZd6HqF4K8r2L7SevYhFpWwadJZgGqiE587OA3kyjqtuTdaQBkJWpm/lqJT0C4QUg0nVzE2nIrsxPUQVS7VB8Sq1KKzUAbavvlI+SgASgd0U7d/BGPRmdbKI6zQmh1nl+1K8xsdwvyfVwez74e2YofYEjgI3y4UVYvrZk3CY30gJvc2vBR9G6e11xxG3LdXYDfOWsq2h9KEG/2B2J1DKXKHtXwwvGtDbE052ZlAIoaXkXK7Xgi4Xg1WmPu8rp/Tf37DP4F+I+rqohDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5c8TFRJoxKgaZcY7eK1KPeB8RnRqqNBzVRmNevhv9U=;
 b=fqyuJv2msX4KcoEfk08FiP73pD+DblrFKinXGni/NLUPimM8kMK23/0zNb8HgOx4BqdYGMRmr9kimG40h7dKSoxmhqZvRzzhVhGQHkhySEaflkzqUMwEmKPtU75La40ra1PW6Wu7KWk5XztQF0pVuV2Tpyme5vDhwhzLqR+jeW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:13 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 4/5] arm64: efi: Export screen_info
Date:   Wed,  4 Aug 2021 08:52:38 -0700
Message-Id: <1628092359-61351-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a3ebf57-d84d-4f01-4d2a-08d9575ff76e
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB109476953132950E89F34A4AD7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMvG73IEz4sIWY50MSLj0XDb7tVTlJyeSBiZavjeMp82RhovjoBn/dI351IlN2MHQejph8B4SF4CuymZ76XJJnTsfiAtz/8n48inhw5H4g0O7OCw+C1521wasTkVKHJsv64MllcpTHF2BOjxU5fX19IgBTBK9XcfHpjp7liHKW3d4JrZHURZy19m8ZPj9Zj6iS3vzHqv57x8qt3fEbDyiV4EXcUCtg8X2Nv31pueqvfY866/MB7Fx8hzIS/Lnius39+RPShNCMWTTVagYyOtK/6aKZcuKpm+zUPJEWMiU+zIfACOVKe3+2HQW+bxd9WvA1be9/0nYYbIjFNRJncePG73KDJQ0owc0fs+qW7Ym6CynoWrkwZvXwh2nM4+p6PTn88UBGpQ+wnamZa3d1vfm/IZrb0TPGFtotPiiXDqvHIttsoDbaGVU47LBJxbaHOiuKEiV+G2MiHYF9KuTJrv+ipMgf70mQ+0TCCi4cSydrkjGRSSNyr3Pk+6OsUPwAcO64aElM5Xrsbt8+zl3ID0GS5Pqnh2sIBAwXiJgz24QykNXhOV3oYK2pTMxQPjlkOvBY0RJIyVeQ5tC8hWrVyLYaVhtezluxJwnPYPop80Zk67Al6PAPNkI3R5KBCsBOdeL/ykOV6t7QtEIl9NjUOOGTzdxHfFCNIiqSzldfsD0ZduOHvfTZNq9FWDYA4KficrEz2fg4jem8nmshZw56eBeQqBVPehXMDIuBnuDXej4HE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(4744005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y693cCRMzWM2+N61+BDaKSkHRB0LvOO5nEtAZek8Uxt3hIh9rOvZqN3InOdC?=
 =?us-ascii?Q?bjiisPWk5Y/Xbk0hDcbGdKLakHl802zzf2ssDNf4mRGHEwG1NUl/pOaangIx?=
 =?us-ascii?Q?9yG4dl058lkzFVHHFmOZB1fcYOuaIEkOPQqBOagbovyveldvm8hJ7Cu4Kyxe?=
 =?us-ascii?Q?zUnnKSgj0C38te80Xwx+iOk+MTXej2x9V+EtzCltthCfN5O1ypDbQt7/aMsp?=
 =?us-ascii?Q?BAO4B2IVFkaEU6aHkyvS2HxvH43vNETa+NqD0C6gB34X40fvZJJUgdQdzaXq?=
 =?us-ascii?Q?EH1pntcAu+3Mlmt6fmGdSp5FtaP0GjyNFXlErFKb4IZO0Uj3RF+2+HoXHcL/?=
 =?us-ascii?Q?gmB3/09SQ757LxBvarq8D3ayufKHNT/CaMQ4rnDj/mc2swjcJW+zarqzMapX?=
 =?us-ascii?Q?2ZdGXsDAr//N5iC5gOvQGULNuc1W6q9NG1T5c041iptLfsWq3mHpzrUaBT0l?=
 =?us-ascii?Q?wQcCQswSW5dJ5YoAw35Uo+n1zXJK+MIuyHZt1AspIxKiiEwFHSBj3/fjhbLE?=
 =?us-ascii?Q?txhFn9WYlwGPairQfn3TYdSOT2ZX9z2PTesw/0c1HCiKm66m7qUdYp2wdC6D?=
 =?us-ascii?Q?w5prvsZemrdnxhD4n+CN9VjpgH+PGcEc7XNVecZLJcIfiVVjv4EsurSJZevH?=
 =?us-ascii?Q?S2Yd/RC1e6+3idA1vffjEqIJPaZpyMB9BExWv8sVroAphXtCG74x6WnwlGJD?=
 =?us-ascii?Q?POnU+NKYjXX1aAqwElSuxquHTVEB2lWcC3tGcaEjPpAdctfV3Qwlpr5m1lQU?=
 =?us-ascii?Q?kjX9weUKQMVOz6wBS0PjosG0ABOfOq7ug61W24qQVSC8S2ZBvK4uiFGSyPkk?=
 =?us-ascii?Q?n/uZmqDUenly9HuOUC5+diJL3gvkukSNfsKjlW0pXcVjzqBRxZsmavYvsYwk?=
 =?us-ascii?Q?b0X/2V7kGlFH41YRmGJloPmdwhwgbcMcwMEtgegMd8wcSqxDyq+uxUZJgCnV?=
 =?us-ascii?Q?PTI4BqxErMMVcwEYJ84Y5ELdkGNZOWYpEnVagy4j5V0DXeBVqUWHKe0aXTOO?=
 =?us-ascii?Q?3d9Jr7zGhAh1zH4G/TcjHgKVXFsUdFFh7J8ihwy3gowJUnki1Ov4XV2MJTb1?=
 =?us-ascii?Q?ClI2dpaMW5DpmCA0V7clKShAasyD9Fbf7N46b5L39zvbvFjRJFZwHT29VkZY?=
 =?us-ascii?Q?I9yeimIy0wfvyFkWTfSEPv4C6o7VFINtYp5hKUgh/vfK3LG6ZxSH/4I4kUHH?=
 =?us-ascii?Q?YPjhHmUQBtkqKrUoS6w8Df41k2IHnZAtW/plu/JKYIDxDZDsWbOvPx6OpCQX?=
 =?us-ascii?Q?8ZTXp4jWRbGvMWPglAlmOCAWxkTZtuEKtA6h7fgZBMkwM6EM4QqKhl7ExTp7?=
 =?us-ascii?Q?3lVPHfYUdZhMVrcVVcwNWbUJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3ebf57-d84d-4f01-4d2a-08d9575ff76e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:13.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZudPyQPQyQIOrr6IhywZ+fXrTKOuw/JDFDpGo8MvchuZBTDfS5XdxMMGYUBWVeDE730qBD4f5Tt3ShkY9/BkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>

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

