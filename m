Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401AC3E04F6
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbhHDPxi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:38 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239645AbhHDPxc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PksQ7Qv7KHZcy7bb+p88m5FgFF0is0whlYQG+JlkV5dwZ7HdzAkoJXNzi+QuT17Abs5zTR51MBkC8JitTy/4ERay21SS3edb5iyfxPK+hz+NHqI4VZcmev5qBh0b7kxndEsnsQbpetMDMOq3tHdm/aRkYbCzG07+Nn5dm91Zm8n5G5NasnkYae/VPVJVxsSn/VQSy9YgOA42ekRAGN2nPAFL5bmF1OlvrDbJHdKUqF//7+MiCsGgp4GvofYh+nAJLpEVPK2dg1PiFJichDDUo1v5b0ShBCkS/bZEn5B9UyPq2MlT3EsvT9iD4kpwUfcFeIvbPH24rbnJXHTRUX2eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rpPs3JZVdGzVoLMlyhr9/Esisvt7xpDaBPNqb0B/7E=;
 b=HCvBCkM3LlaN4Gq99NixhTY1ivoTLZsKvU8G2mvcB7lN4TTbsSF4NgY0HgNpDoiPs2s8rQkpMZ+8lUuwQQmm7EzO8cS23DPY/HM0axN1wCIw775UxHvk9Fy1G3KdA9TOgdV3QxvOGO/XpzeoyTcUViok4yHUl50aBSHRQTUQYaS8TlICIG0f5SS/5RU0dpm9NOPIfumgyRkKk5M0pO1JvEpTvkgEgL//UsYU4auF5AqBYCS9qUfE1k+sxVimYPbeJraVq1Bo8US3hFfBwPLLgmNJaZqhHPcE9HdrP2tlluhZ9vyHMPd+48Hg/VyCnjqTXYHiIbIgqTSATMdYkHPxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rpPs3JZVdGzVoLMlyhr9/Esisvt7xpDaBPNqb0B/7E=;
 b=C9FvsZo9s9c4RTfFLDHgjp/e0C5xqm5GvkgjE6sb2yV2fG4r2+u26T1SntqmWQGG0T88g+JBYoeBEuOBbL2IsDkqVYDhe6RXi2tMJ2eDty7vUvQf6/myVJZDsE1Do+kJMi+mDQUqxmFHlkAFqL+oCo+vqW7azEPaKNunYhzrfkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:14 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 5/5] Drivers: hv: Enable Hyper-V code to be built on ARM64
Date:   Wed,  4 Aug 2021 08:52:39 -0700
Message-Id: <1628092359-61351-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83fa7f1f-5c40-449b-e466-08d9575ff7fb
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1094144E260DFDC68573FF73D7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2U/jQyeSt1dDzMvxGSryLsVT8fJFkzdporScZWJKG1Fawt2QCr44ItUUK1wgLTVr0KaQw88E9qS4JR9yQ73gtdiB4Pd3vBE3B5D9GUk6uW96we5jcfUSKanOulT6O5T0RIGWkicFdRnpF7vJVyuLcbk58/CxyLJMCa9y3J7hAsQfND1JG+3NZkH+RFBO6Ldh5MvnhkKWq2KGKtuydUR/bw+QBQcqBXBUY/eaGRZPWGOoxWP0TiLbTm/zYUI+eXNOloP3pAiiER47cdQpE2TvKGLWhk+Z3XBHPohie4gFFiZTtow4NpkhKaN2VY4R/Vn5A08gWnmI3mvKvhq8Vx8Eh1J7Gh/dubJi0fnVLcoQt6Ccoh++cNHePaF7IKRsRFplFF4TM1+Bq/tHRq1PJgTNF6UcXnNCEbJb/VzjW+j2gi6QiY9fP3Ysd7A6elmq6WrL//OV++pxAj5zhi0NtSuYfGRqk16Kq3YncxyiecLWLpC2QQW7pDAQhha/iLVdFps43RaXgC21RsPgYZPAmGXWMrxXB+0yeGw9M6/GsK8b+KA99kI3bZkXFLS6K+fvEqJh9wmTIhi7KxnoEWsTFI09z+U1KSrAi6MRJQ3LXPtp/NX7wkSFNa3kNy7/6ecS8ExUIq2jhRDrUFZkncHXrJKcrb8tJi6IgpAsBsDgFqgUac6dMJLtswpjYr83c9Of9wyhHITP2Gtuc/U6afA0we9eQc5BtQfE/9/6XqvHlv3Q6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qhPBKLldukdxD6Vl/JkAQ/lN72x0OYVV/74wB+t714kijbgt9EKFVBDqsYC?=
 =?us-ascii?Q?1kU4SMb2PucDuo2mgjPtQ32KbtAVbXBQ0TeT8CyjMzc5dAhcRH7qWvgmgQZ1?=
 =?us-ascii?Q?L/gEhkqa4hmqNfm2LQGe4nYIXIDrLsCTLbmvZilQV8U4AvP9MFVfybxUFjtr?=
 =?us-ascii?Q?Iim+xbD1shbB8StYN+hYWndI2+pltdsQ2EXKv5UPTpYI2ht5rj3BqvcmG/gy?=
 =?us-ascii?Q?w/UKjnDiyMxOQdYez8Uu7DNVgwFooNfmWabU40zeSPYa6Pe2hippeh6yyz4U?=
 =?us-ascii?Q?V3lPX7I7WM3Fc/YHox2wEGoy5idLqRTh1dRRf9CGbtRhS2V5tL6r5Vo5QcN6?=
 =?us-ascii?Q?H/l+CLl4BkzMMShnu2oVrNCEolOYV7WU49+Gs/S0nGZx2P6d0DDCqdxmDpOg?=
 =?us-ascii?Q?9quskTSzgPZhZASRkJ5ragqDbFyqdqtz3o4nlXhErlHPfx3oDXOMeVH5thyy?=
 =?us-ascii?Q?C5Gpu5tO3odrQhnZ3qf/xaygJBXetLrc/I10Pil8wCEp9D1DGjliadqhxJqr?=
 =?us-ascii?Q?DzCue0niixQ9PAUW/EFHTIYlJiOMJISZA/bZ8uKgcGIikuJ+qwMp0p0qS13w?=
 =?us-ascii?Q?NjL4sqqeB/7dqDlfPekfUh41QCs+D5AimTDecsUg3XdEYZ63+x6j54Dk+0hf?=
 =?us-ascii?Q?itA9pBuF7PA/U5TbB6XS+b4BjZkcvmyM0KxlGyxS16i37nSVqcvonEGF3oMK?=
 =?us-ascii?Q?/hhe4SAX7Z2qzXm2VqFiiMsArFUsujLhsWbBaXtIFqJy82Bam4P0kyYyxcNn?=
 =?us-ascii?Q?Jwkqk4E74dX+q7nE1t695y1AzPN/4GzgSBCiwa2n233utbiIEjZ3ZT8NOafK?=
 =?us-ascii?Q?+it7x2WMrymn61H2lxl8ik141iQlIKw2/qmzAgNnU85LiOVxZERHvv1S1HJs?=
 =?us-ascii?Q?Tz8SkAu8d+r+c+xMMgM3jXqcKRueGGS8E8KxaPLmkEdntvoYd9X0vhlV+W+I?=
 =?us-ascii?Q?h4f+3lOakYLpaMih3mRYNiCO1ZJ8tzftqUwGYX7RGlXuTwAAsbUnklcShb6c?=
 =?us-ascii?Q?KNvCqcW8ftj/OmLaCb7xy0yAr8MI+h7qIgWV8pa6HJH9DghI3XtiCSTnH1I4?=
 =?us-ascii?Q?Za8QC2XhVkDD5JXUBTfhB4WR74gWvFTQ18dhTOlafEDtHPBKppPkrJ6NXHJ/?=
 =?us-ascii?Q?07SnbQMMoCHTP/4NfVuMEYQGcjbmeNOPkp9ZbaitjJ7sbc26qL7U9uKUTQga?=
 =?us-ascii?Q?yUxbUF6mLlIt69y6SJp+oFd0Qrsou/kz106Ot+vwSvmslgyi+QC8c3EyLeQd?=
 =?us-ascii?Q?tyZolkmYV5mPMEh2GNN9MaDsj9V3Az1bEA51v6dwCNB9Kh+LTrQXotTWK7Z4?=
 =?us-ascii?Q?S9urDhCByDshiwKsdFMt57Gw?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa7f1f-5c40-449b-e466-08d9575ff7fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:14.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScBR/fsOU+6urkB4PD7HWqr0OLsu3v9LPRL6qUL25ZXoTeejpugxdHONhuGBJYxuGat1xR3VXWgLQ5angVLODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
ARM64, causing the Hyper-V specific code to be built. Exclude the
Hyper-V enlightened clocks/timers code from being built for ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 drivers/hv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d..e509d5d 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR
 	help
@@ -12,7 +13,7 @@ config HYPERV
 	  system.
 
 config HYPERV_TIMER
-	def_bool HYPERV
+	def_bool HYPERV && X86
 
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
-- 
1.8.3.1

