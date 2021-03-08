Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285A13317E8
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHT6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:18 -0500
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:37480
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231472AbhCHT6M (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP5qCxLMoJCvvsz+X8WVsjs4+W61jHtYGLmOeWhJ1xZcWZdT5y/oe7hkewUhJOba8GkxiIsKxMOBDVk3tjzOGwUsffDaUPHQpmiLqD7RwrPKmR8nX/H0Q9lUhE3LsRkgK5dLaDlTNBhtcuXtuhcluYwTPBCcNqS7eWJ0FflEpNpPvuilPsQod5HdlJsH/olM+skbrwu7RpvlyNkcztSP/zruWg+ym3+p05mGEcZZ6GXDi6CvP9LqIwfXlbfI3pGn+KTz2mnQDLN0v/e0QBlnzqs4uxi2E4mgwpd0kynA3/47r81GUYbiLHpRrY4Tn+T16/LMitqWinPy3KK2U32jpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=mbNo0bh70ct/X1jebPRgWQAerx8Z7nv8ZmqOJ8g9tyi4zhVMSzxPbt5O7tUKMDlX1QlEu4Mzkw55VQjAfsScV0ExejX6+9BRHcn8PEKsBPkCh//RGip4GyjF7VJMRb8WSR4TjAoXScWwpsWaIRRms+LZwN6PqiYOHuxjk6iBBt7EcX+G3jFX724Gt85d0aiADLuALN+u7eKowN0CnLHpnr9q7zU+0uMsDjBPZC8E4CZCw9T9MHWJIQZRM5rYRQbtClZMbDx2UQ4Cso53DNe80BLeilv7vTydKu5WP65IzSrAF+8fm3wkG9Yw0resHUJWS2DeKq5fwCYjgBGtrXx2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=j42D40XGvM0coX6wm2DnomZfXC1uZ6pYwJCIF5Yz5kiRXx8JWb2gXw84N8HdtVPj5JpSUT0RQWCsz2sbhSKPM0co/gxYrhhFbtRSB0La/0v7SRW9uAIQGZ/SdQLRDh89UU6DT0k5/J3LmGrOGRiTX5e+YiKVHqq2frohI9hH5fo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 6/7] arm64: efi: Export screen_info
Date:   Mon,  8 Mar 2021 11:57:18 -0800
Message-Id: <1615233439-23346-7-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d05628d3-caec-40be-153b-08d8e26c7fe7
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB179768543C3262353CD54FEBD7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5kaJbesTgMkCnUuTWOiZ9+ajUReswBBEEvBxqo5ZmHndqWg663/ADF2/g72bAzqHUjaaLjJUM8XXsgTxsreo24EhYuVGiSJzG7g5qRBQWT8q+z0VrZ5LamFTho+fJ9rwRHefTO4XhiiEusSUen5NVt3hz7Fs5anq8K86NAo59I+zIRFeyUFQaT2zR9/BYij3NiMe8uaINsoPOacRtRiFpYS0D+lLefz+md01iABMZEMSbpne/UMY1prot8zjlgMHrT8NOoOOMpSI7qjgi5IJ2+/3B/g2vBoIvhVAsf/rEt25jQ9qQvDq2fHLBOqVQWHUkj9apQC1SfLDAr71ojQPtl1AjmiATFsu7MQjfWvbOfrUeO5PFgQa4jCF+lcyekcRrM01SebanR98v1MU5sM2bvzq+NKaxyzj2cMJKQWem4/ulvsxn7NPTZUJjUuTii41DYhI8T9ZqWqxM2wIKBlPRQfT+TxPPqmrCPGyrSiKK9rHRXhjoF4mn1qBvxxN15JLL65zvRQW4pUV+T3j45x5UHG+9wEamnT2vcRJ821JPTH8n3vhKpH+zjXuSd22taRvQZTYt4JZGF51XopxUe2JjqAT9PJRbjU3ddKR60Du78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(4744005)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DpPsTYMHyMN8hjk7E1mR7utdclQLg63eRE7D4jrMMvYUd2OnwCfoIqHEOAUh?=
 =?us-ascii?Q?m/K0rRQgieVimBRShHuFLy4lTpSC8DSCk7HwOiyCUuoniWanhiVM4TeMVkAZ?=
 =?us-ascii?Q?FttHJbdDUd+T4ahmGridqaKdGYo2oodjNxQd1+yni6HrNh7NeJW7lAy8q7KH?=
 =?us-ascii?Q?45wcB976dUPcB2DC49G4v58EarV7J2xMcE9o4L9ddWI8HDPNHoGTiDVAtDKJ?=
 =?us-ascii?Q?f7L88MF6xgk70LSqTFyrOUQ+2A9RLX0r9QGVDX3XuIo5wwVABVs6jRazAjaz?=
 =?us-ascii?Q?rHynjencfubS5/tQigvx7/MKkBWySBS/R1d59vntkIuSw6eHsGOCm3TDbs1p?=
 =?us-ascii?Q?xHmbwRFczX8O2f488uIJ/b2ZZKoDa/7f3+nVvEdNQRwUJLNno7a+X/YjLa4C?=
 =?us-ascii?Q?nc37cdwhqV7EeBvPsFKMC4fgKfHPoHkHgDYJ441BkKdegAr19lVGIRicW5QE?=
 =?us-ascii?Q?CkYj5SBI/41tAM9TbemrFClXK5nyANLMe1cOtP/ue0j2xisNSmRZry/2af9q?=
 =?us-ascii?Q?YyEWpDKXfqRDUdJa79KBt7d9IbbhxNOR4HXqJmQg8zbwXm7hvbB2U/LERErx?=
 =?us-ascii?Q?U9zot3NBY1GBGArdhBMp7U5WBqkZaR3GOAcrIJxEXtRPsJqu2fXWz2hNjRd5?=
 =?us-ascii?Q?8KsQb2q3gA8eRzObOLYPzEwXK/2PfjXqrlt8W99bIqRscnuRXkIjenrSNNLJ?=
 =?us-ascii?Q?PteLVeWhTa1ImckQ+CcpdzqSyTt4+cHROu3Z/RkGmuzfmbQqbqr4C3qtLM9X?=
 =?us-ascii?Q?B6CbVskd3Sw4lv+eMvxxU5ADzrtlL3sMW6oKew3puSrug8vJ5bFp/D5K1BBu?=
 =?us-ascii?Q?+NSecB7CSn0RgpXDBm+UAuqDYXdmgWVmhPazdXUwQlx0Jq53r85pVyUVWv1r?=
 =?us-ascii?Q?HMVnXnMbOpGbRE5K0qqlkZh3ly5wByyYnwez8OBJ+85O3WpG4nBrXCn7lAIh?=
 =?us-ascii?Q?53Nzn5AzH3p8PVoqgA55sgFfOo5BUS34SwiOvBFZJj9fvo/UOEqPcNR4lYRe?=
 =?us-ascii?Q?IbhUDSq5ZvgdEI0BKjhYaLKhV2BYJDRzyVYjJl2AsH19vg9YwWYxcVEW9GpN?=
 =?us-ascii?Q?l3YtIWYKnQ356z99axan6d+cJzMtPTbPNdWvY/f0Me5Up+CDgwLOo+R6tRO1?=
 =?us-ascii?Q?ZaRRhdFfQpUXLu5h21vyUISf5Lj9rBv8y6yPfNHbndkCdl0tdlnK5Q0+sUx+?=
 =?us-ascii?Q?A/Iw/Clm3IEpGlDc8jJASW5DeTgAcNDAuWDinHLTiOxeJtbdBZsXP2kE/eZ4?=
 =?us-ascii?Q?peOYA5D9hd1MDKOpt0Z/AGiIXXetLn9Dlm3i4aRlpPq6q9z2jne6tg6imKYs?=
 =?us-ascii?Q?sPoO99SPcdqLHixLIGHGsIvH?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05628d3-caec-40be-153b-08d8e26c7fe7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:10.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYHlpoEJy0gr1VRgF9OZkLENPyaoRxpoXtlGX4mGfvvQ8DaDCHaYIU6YfWyBHPxYMWawrwbHo+8jankXOr/hVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
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

