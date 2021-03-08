Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8E3317ED
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhCHT6S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:18 -0500
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:46817
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231486AbhCHT6N (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C368pA6WkRSVkEFU2OflGPf72IjljJSPmZd8blNjIUiCuQEA62/8VQDmIAaXz0Ltc4a/Renvm0YfptgipXmVLY79qM82UDbeSA7LuB5ljY3TXwPElUZGzTprYPBkzYLGgsn3kLQia+XendeQQqguWjWabr/SbS2JFkDkIBEmX2zcyczzzGKG8evcgqSOUKr3ZmreQTPqvoXPd/ASDaEPoIOQ3At37a/BmI2+mXgo1+utaCyf+VeLEOwjLtzJBMoZNWjRmMYMoosg71eWsJsEf4BmqhovoYmGIx+heQNPHZzXmqUvr34FPx7cIYKQRD/USPqmukwpMqBkWshT4IfoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOt6quckwKZHyyyERwRobYF7Kwt1TbHjEmKP8+rLMm4=;
 b=AwYH46UKaSavWm2YboRcrApczw3m0NozPvV85vpjC5+K2sTGydLhZ+jMmizWa3KMfC8ja/kB1DSsmcWhu0y+ztPwT7z1qPaEm7CS1h/j/oAPjG5vSQOJFl5HomZ9xSgFhyLCxpgylcXGBjmXqI2ay51fSTF0JXF3AiBGNoBbyaRxxr7yPyeUp9UmlfCHV1jUIzqCcx++gYKQIXTdTf5TZhGhHePBpW14ae77zNrRemF5YLFFUbthiuWs+jF5rRlcMu9dKSpUI7idRCag1J740oDekcHQO2iVp/kNVoUqndTD/Mp120DbTb3yROdQPAyhAZ+TccLO77JPNmBpWFkBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOt6quckwKZHyyyERwRobYF7Kwt1TbHjEmKP8+rLMm4=;
 b=JfrTHniY4e4a8Yf7U+4cXhW77TtZLkib8qIcuPg06kZgCIOHDgSPHWgl79bMaOBlGV0d9Cmq1QuMs7CVjFJpO4OqxS8r+VFYQsG7c80sP0C3DN4EY6q08ED/GZRKbaeQdn9iaJH+ust8PZReSMjuYIFfa2Z5lZzKnZfBuR+WCFI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:11 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 7/7] Drivers: hv: Enable Hyper-V code to be built on ARM64
Date:   Mon,  8 Mar 2021 11:57:19 -0800
Message-Id: <1615233439-23346-8-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 449ccb24-94ee-47af-65e2-08d8e26c808a
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB17978139DE23220899E8B73ED7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVi6PpRcbTykATeQuHoKvRrd5r+uGtGuPEJRi+nV9DAnbS7BJo1+kDscMz1w/VepfK80KTpJIeUYc1bYF1oL3HDOWK9rDekNJun6eGg1+WoFqPjD0+Ys2p4Hk7AP4XDWsq1uiFkdl3Ty3FtNvsB3pb24hEOn0YeGrWKOHx/bLXUI5Z0VPvKw0eoB7Gt+fcaAYf37O7mP+/B0R0gJWywNqxHK4/ft7XUXb0RCGmXzrYbHwP7IJBe8PZFJ0kSOQFdpWdW/Klk45+gws2HrjwoPR7zS9CDTRq7NCqxoz4e0yZgLwSDq8i1kQZrs7TJqiai5BiygQa13tpy3jxwWUnY/Ji6RLa+FeL4IW5UZzSSwa9KuW3X6EvemZAxbu09e9lkJfliIDBaUJjc6ASwPgcwxC51GQsrcZuC0otiXQ2aUiiEs+GWVZ5aEgyDO9mSbFEumCotZTwxtUKlih6HuMoNJQZ/rFGUUhVXgXt7y+boQBb0K/XYhMTcyQB4FkeZw7trmowpvtfSSv7cUrqka+tcTIsxXi0baNqkJBcI2Gg8lUn7wjBdLmY85lvoXY7BaR8DIpa+0nLKlhULeQMJIJIck58ogdOvoETeVlR6uz2dJgaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(4744005)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w5OJP256vXShaPfDTF94Z4+EUqFwdsNOWIi1qhY053LDQjRcyxAbVTcA5ttU?=
 =?us-ascii?Q?Cp9e/G9/zYsLQsNJ47x5IckaL+gV/8Z0tHlV0hXRBk0wWJb3v7gFvRq9TRR9?=
 =?us-ascii?Q?9iBrtpBP/SRaZnEyfxykukP5SphzNDx2itZ0Hcp4O4pgkoomx2Zw5r5zDnGl?=
 =?us-ascii?Q?jiQrvdXIbwE1VzKB6LdDmQeoGm5BaFSM4m5R4+ULjwSxY+fAMtbPqZZEMk5M?=
 =?us-ascii?Q?mYeS71n99cfq4XkxZKvnr0Tiu50ENvPWsV4QUIIGUgKA3QrvsGd2I8+294NN?=
 =?us-ascii?Q?lCVMKsVkJKTzEDhlwJ2/RpkBJsDxlgov/WNShbM5qJbHAeUW0t7x951Ic0FC?=
 =?us-ascii?Q?a5Hd+/Gnh8nfgEDwEjZON5DDGSz33N9S8Hso3ng46TnSjAlanEuTk2HT+sbq?=
 =?us-ascii?Q?xl/S+J/efc4ciYlbieef58kHaDQz1XUn7uFLwpgqv+BaOU1woR6/9MzNsfBi?=
 =?us-ascii?Q?xHS3UCqFuwm3aTBRBXuwxVTIzkmD+B9J1s15a17GZRU2MT/FoGr7YQFMG1oX?=
 =?us-ascii?Q?QDLA2B69qX6vLrNOIX3L5fHBR6dn4WxLxuFEm/qDB5NKNqk/UBFbtP9Fk/f2?=
 =?us-ascii?Q?Ja3ZYGwxhZDOEMUKKbGHLrs74NQb4zv++Lfqi96G/Jdh8utHhtaKsX8bwTQT?=
 =?us-ascii?Q?TMk69h6Ou2V8gtaJsls5cD58RH6JCsnLwIdvUOBFALRmZMwtsE9AfolNoNLv?=
 =?us-ascii?Q?p6KxSWInyMFTuGnom20R6CtScAcnaJ7/iAvWFmmw3ud0nUyURfp1m+BvDvgZ?=
 =?us-ascii?Q?EOh0OuncMweA9UH/KHZ0M9Gt5KgqzoEvzvDhGOjWaWaTRJq3kVMLnx9UWFQd?=
 =?us-ascii?Q?AKlHVMZHXw69Ce8vmI9fQ/FXxktrq18/ZWgnrnr+OXlBWKFjVOVbVfsdTJoM?=
 =?us-ascii?Q?IJHdNW8yer4SMZJaDuBJNzzJbbO30yIvmcAgmPptABbtGtlKzLmgtYyqnp/r?=
 =?us-ascii?Q?edDaS5nWL0HZ0j0ZlMGEJnGcUmdnMrxAkWjVEZx4yh0JT1u6VOqCgPG8usOY?=
 =?us-ascii?Q?u697YPGaPm7XvQpamoFovAeflrJAMxcPJl6QWCrsGNYwYDpD/eM1euVzVouk?=
 =?us-ascii?Q?uUXbx79sCXlJctt1a/NIG9BdyyGquDQl5F9sJY5TxtNj5X9UWiKBQptwP9AH?=
 =?us-ascii?Q?TFsIJR8IuxAteKgy9vMqJ/6NyD7vztFc76DESUaERn8dPvCsOilTrMqYknaP?=
 =?us-ascii?Q?1Ue4OZH7oJBbmChexDJj21I7Lep+f3O2m3e77BYe2TBDayXi0VW3iTluPmBr?=
 =?us-ascii?Q?C6mrrYsuBpBjUz6Z7SwFWO2vRcDqq+srNpnKoDBHUoSG353Y7RJidr8X3j1S?=
 =?us-ascii?Q?ppIw8ZBMPQ3B294oeWm/lMgd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449ccb24-94ee-47af-65e2-08d8e26c808a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:11.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS9jvMDihAFs+17+esu40S282jQVVdzAyeM7YxwCS7LaCwT9YvExtCTfg8upYBH94/ijDRdyTMqasr+nWWCh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
ARM64, causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 79e5356..d492682 100644
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
-- 
1.8.3.1

