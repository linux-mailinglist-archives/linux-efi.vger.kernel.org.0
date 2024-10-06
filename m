Return-Path: <linux-efi+bounces-1913-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638A991F70
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E81C21734
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64D185947;
	Sun,  6 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSOJNJiV"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFD184555;
	Sun,  6 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228982; cv=fail; b=Pf/UXaO0XsdW6d4hG3fF3fEhRnUad+t5nhVvaGnvJfDWHl4w6kyU3/7vXi2BfN/Gd4WW8rfryDrDpuurY/b742KEZrPO6vxRhSvptSsPt/3s23kNIssC4eW6Dy9yBfH3NGPa1dnGxHeazaKoRWPrZh16oZnEsjuz+wBWY5HOYZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228982; c=relaxed/simple;
	bh=6S5W1Z5vB7i3pR9RbWhm8AD4aUn3qUo61k1KnrV6Xpw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uNHkWS6NSPiypHeXLYV+ZiwoL0M9SLuL3m4/mU480gl5D8CeqUbWj5R7xgQ8MmIFQz2TWNlYst1Ab1AB8ImHkeUOJGQJOz9cN8AIMwMnvI/dTwsZysU8kifYpdVI7VzEok0j538dM0v5NUs1xY+KU/Zm69BZC9We2GC8yMw2GPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSOJNJiV; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz+mPt84Xwq9tyy0IQezbmrB2nZWeHYCusBqsFCxg7GWjvChHd3rwbpIt5E8M4Hpc5RKoE7eLexckX1qCRNf+nvKDxYj/UG1gNqqbxci7Q1fGYoResw/AIVfRgXaz5uAOHhT5lV1nH9YART/AjW3ZJ+t8X/+3RnlOb5QFBNXqIjY+nWXeSYGuHR2SqFOdSVJj7r0GKqR384RG050Pf0wvF+7xtnP8eZ007miV1Ge+vvEZvnWGvmFvXvzOTxT1CbL+4ZSlzAruZuBXvvSFC4aLfFkyEB1gDwHZXfQJ1tO25Gah8KFanzqqi/aELTfGOO4jzR6A0oged4VGJrDOanZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO13Nt8G9M90opNAxhl0r1iGZIFP5/B62sLG5mrkIa8=;
 b=AEURr07zrdLt/nceCe9I0BsU3XGeI7Ql4ZrDvenCfMDZatUn9lU9hRMnSyN2PrXU+fkDUSuC8D8wUPpQu8JEF3eGQLzKeujcaIz3asCYVhmolhKz7ezvq46SVLYkIS6v7QpL+9Qq8OtxE5bC/gONx3OHNssVawaXWf8cUrhqqJ7YMGZrEmTZTKu43gg69r6BV13CPfLpNBIDNNCQhTOuNNiqhUBqP+ajDDaCwczY2g375PX4Kp7SOlNeROf29g4/TIIIZbAfvPCCZAmcx1jiIdq7EIDIaL8UNMco5k3+njg9mDOPuotG35cIKYxLBKAA037lCVDStnQI50IzcXN+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO13Nt8G9M90opNAxhl0r1iGZIFP5/B62sLG5mrkIa8=;
 b=FSOJNJiV4Wu/GotUzQKptRNUc4jiDnwOzn9HpDOLRC9DvGFBgYnqN6KfVyXL2XYgG89wCcGYhT+aLrh0yl2Duy6dP1OXJxxTQotbvDzlC7WHQyRoVGFBpnFd5OWPqCTg0rQbtqYHOt39GHpbXcPN57jcoUNJBqFabfsk1oO+AZA5l6EncnOivRvvdNasNHWAexJTE58XaHh+S4xG8a7kzlSEkodpQcBgLFb5w739R5+kNSb0llsxC1q/0EjHsLHJ6LQWzHjK+qWk33EXdcnU92nwFEQU4trV4Huw3GhuDfFypgjwG15Kp9Iaz+krijkgXYnNXG2j5anW7tfTdcgosw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 15:36:15 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8026.017; Sun, 6 Oct 2024
 15:36:15 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	linux-efi@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 1/2 V6] acpi/prmt: find block with specific type
Date: Sun,  6 Oct 2024 23:36:10 +0800
Message-ID: <20241006153611.1165482-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca56c56-1ba5-4fdd-6e40-08dce61c9d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZVN1q58jx/7LvjWhLpcS5neQGQkguHX+7Mhot2rgneEecGRwfPtwCRROlZP?=
 =?us-ascii?Q?eLuvZguywme60cFfbWAkUkMSSjFPeeLky6tuOWD9sQ6OfME9Vr6xgVhNkqZ3?=
 =?us-ascii?Q?TFopetgSxgf8nzIjlL0NlOU3sySlszOLIYVGxTwG01F/LrALBnYO7OXPebxg?=
 =?us-ascii?Q?3YUEwFVaCHz1324uYb9inrEsiD9ka1IvdlSOxzD4tLaEaC1RQVf5LRRZVBYU?=
 =?us-ascii?Q?Z41ZrAzZ8Qia4I6coCG73tQfdrtIEEuLv2L5Bq2piwTuoNu7qlUfyeRDQXns?=
 =?us-ascii?Q?CVByE7qUiXtqfvk20rb2FeGYn49jbFp6rWz99dkjlK6mP/sexQXfb/6e31wC?=
 =?us-ascii?Q?/xcYQnSqTDCZV3jTWy0zoVf+EAjyDSOZ7g8tBwPFtd84h6oD9NHcPivZHh04?=
 =?us-ascii?Q?PPXxxsyPg/p5ZeBuUs8vAP2h/llWZEUZaCEFTTmDeCXrSIswN99TdcPwc1Ju?=
 =?us-ascii?Q?xFNnI8+Vm7wsF4Qeiid2QIHhynHshnkfHdTso2eMSO0PCtHp75RWrW0gjBDf?=
 =?us-ascii?Q?0EBH2sVVFG0Ioxl0ZYv4Of0nKoZwvaM2PW9N+X7I6KQsxg+AQD6svurubmmN?=
 =?us-ascii?Q?s6Wfum0l21y2gU/dhey0emLVoHXLFmk5/dDptRfN11ht/IXt9EugJOGhf5hP?=
 =?us-ascii?Q?k34Mn+nCvlywxDG3X+bEKLZa3Z4ZvuWvGH3LBjd7vRDSvGlZD3D5jzt2LV9j?=
 =?us-ascii?Q?dQbGdYj8USBI53m8ZxiWqBhDht4/vjppBViDqRTU86YAS2zZ2UOIIq+XN0FR?=
 =?us-ascii?Q?mQTa4f6ph7S3TnVDrj3oZOsybzaANukmNvgrcVfLMZb3xrQPeRaKys4meggu?=
 =?us-ascii?Q?xa506Mm79j3x2LqRuf4c8IefG/lVSLqm71yWWkNVDda3j1gG4eDtnAarBnG+?=
 =?us-ascii?Q?sgO/+QPYjp/tQBVMFyxLmRPOgMKRilef/Phgje4X/iiFADGx1zB8RIif6HG8?=
 =?us-ascii?Q?U90FioJLF7CFyRlY+G7JOODjfTLKCw3m6E6YgYuvmtj05WsyAj0lB5p0LwIK?=
 =?us-ascii?Q?RE3EswM1qhF0IMy3mDsIqnV//LJbI1vFHzbDW84JlF1suEKZSZgVq7sMj1XQ?=
 =?us-ascii?Q?a8m18jszd2nKbRItbU32oG80KQcl0KVXY/rNoxGvIGqGYxPlQCUh4URl+vIk?=
 =?us-ascii?Q?F5QgTQMKYn8/2vDTw7RQrtMl9yUKNhZFvs7o0XLX07l1SbtXYqVRk0eCJDt9?=
 =?us-ascii?Q?TiV9FchAiP+2AppEE8fVVkQfJinI0DvJykEG19I5PB/Wj5gA4GZPj+yEqOtL?=
 =?us-ascii?Q?AsJhpcnygGmx7LyNr7m8QusIBwkdEmHkgdvpvpmYyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tjeTvjgLJZJEoPTfxpWkskXqd6o28P3PadBQSwGruUtw7lKJ9jsneGlm7jv?=
 =?us-ascii?Q?AdS5xnzGv8NFhkaNg1yHx8mnJ3GjmYwDG/dCLR/b6JddyV4slG2R0pfjhA4E?=
 =?us-ascii?Q?xIzVAmOk8x45hWR/OxChfOk3i5oPCv//VL8sNG26PUypG80BybO81HYqbrRI?=
 =?us-ascii?Q?zdOPcfPOMoS9nXB6wzbu9D2RgQpLmKGDsYUC9NlkljMDBie6E7QtX6/BRzUa?=
 =?us-ascii?Q?TIPZoVmj4D0OgqFpHJsF4OGcI4Urm+zqI40ia0lzkGC4eGiL7B8u6YJPOUk4?=
 =?us-ascii?Q?jUkV3ObqnfJYSUKr/RB7MDj5C75Y+aWuybEStFdIdEcXnmoavjq3bXA4CGNX?=
 =?us-ascii?Q?uOm+cNo/bnwVM6fwuBNAhz8TP0ivy8wEH6jMP5EXMgR9iNbjUr84Y7EGxpas?=
 =?us-ascii?Q?Lh8XyzNzyi6UC265sbo61ayJNFTljS5GVww/pRPTaG+Yo+gzejGiSN4nn3VD?=
 =?us-ascii?Q?nXPIJaTDKxLDlRB7Yv6obYrelgeLb2moggmBt044I5B+P9bUg/79qu0i1N/5?=
 =?us-ascii?Q?Xxm+cVKsCPAo8CsceLPg6YMick0Ke+NjH44QOMI+bBpS5m412+SpO/9YiM1k?=
 =?us-ascii?Q?jFm/mHQ98gDis9JAiR2GwFJ+YdIdY8lSm0zCEyi0DTut0cfeowUX0G+poTCm?=
 =?us-ascii?Q?8bWd605GmToEyS7Mf3ULYebHTXhYvnXSRH3wzTR/Y/QbMoEaWUL/bY4X/rQt?=
 =?us-ascii?Q?nZwktYIoZP/gcvFi24396Lz3jGWcjOwCe0ivZ736/CSJKdhb4QG4TZJcU1BU?=
 =?us-ascii?Q?aJtL2/DOmObOA4cSu9tvb/ZG1f6dY4NUfIClANlYdtgSjo2N2Uuejwk52w3k?=
 =?us-ascii?Q?DkA5N7orDZ0C6Yaw+OkcJ08HU6A5W3B36KqINflEb1YWv70klQlLJ0yaDbpu?=
 =?us-ascii?Q?2A7L496uWr7es9d7IBnZL/fWM1Vv1/TmimgJ5Oou7QrDb14xddYELBbVTwB3?=
 =?us-ascii?Q?sEli3z2y/5tY+GLNN/qEM0A9i2QgX8S4QjEivWgtCRgRVa1EIwViX8WvDOW6?=
 =?us-ascii?Q?dFVRS/SK84rjeBcMEPeOTtAP1Ilpf2a+9QoO+ZQsUfZwuLHh8/hQ1gWPoQau?=
 =?us-ascii?Q?dk4KkdYyYCPtAzq6iZi7ONRW9+zozTzNzz4rfz1yYEm8tRsr06BllTzNuBZo?=
 =?us-ascii?Q?4km1dbsIlM/udpUzBef8FRW0wp2tmC28cdyQAjyIt72Xet02VhErxDbe8U92?=
 =?us-ascii?Q?WvxwzvFrct7PiSkLtiMq02Y3kW98cGoDxIfkIRflU0Ei5Qx28yyytdCL28Ne?=
 =?us-ascii?Q?AlTRLpk8Bi5xsSszy7J81iqwiuVaSUXzlVPnHYzPyK4xclw6SYNNWQuTb7Ra?=
 =?us-ascii?Q?0NxGw/M3RuySyLiCr2MM49bNzQp5BMIsS5CDcSD+V9mp8IdmiYtfjfiagN9f?=
 =?us-ascii?Q?Qyw8jSQ2YtXa716LQWqw+T3Kxn6BnGJ1A29j7wp48WGvnNNig4Ts4M2TbFq4?=
 =?us-ascii?Q?oC5m8Hge6d0ZZUdCxFe2k2LEHCE+raW2G2/UzcvZ5drPOVmt3SFzXfbPH+gK?=
 =?us-ascii?Q?GOZFsoUwyQU7rTL3A3TdbshZAIJYz8CPUxRQVZRwVqNlFH8LANApALoB5Frq?=
 =?us-ascii?Q?Y6A03OByfxF+9nzz80QgQ/Tg4OdQ5RCvlih1J/Tb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca56c56-1ba5-4fdd-6e40-08dce61c9d4e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 15:36:15.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IMVD3AK29pdiHQlsa2QRBTPfua9GDifKSvfNIzuNgW2jUJoHHOz3sB+2MeBR+z9Cdg71zZz/juj46tLa34R0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

From: kobak <kobak@nvidia.com>

PRMT needs to find the correct type of block to
translate the PA-VA mapping for EFI runtime services.

The issue arises because the PRMT is finding a block of
type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
runtime services as described in Section 2.2.2 (Runtime
Services) of the UEFI Specification [1]. Since the PRM handler is
a type of runtime service, this causes an exception
when the PRM handler is called.

    [Firmware Bug]: Unable to handle paging request in EFI runtime service
    WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
        __efi_queue_work+0x11c/0x170
    Call trace:
      __efi_queue_work+0x11c/0x170
      efi_call_acpi_prm_handler+0x68/0xd0
      acpi_platformrt_space_handler+0x198/0x258
      acpi_ev_address_space_dispatch+0x144/0x388
      acpi_ex_access_region+0x9c/0x118
      acpi_ex_write_serial_bus+0xc4/0x218
      acpi_ex_write_data_to_field+0x168/0x218
      acpi_ex_store_object_to_node+0x1a8/0x258
      acpi_ex_store+0xec/0x330
      acpi_ex_opcode_1A_1T_1R+0x15c/0x618
      acpi_ds_exec_end_op+0x274/0x548
      acpi_ps_parse_loop+0x10c/0x6b8
      acpi_ps_parse_aml+0x140/0x3b0
      acpi_ps_execute_method+0x12c/0x2a0
      acpi_ns_evaluate+0x210/0x310
      acpi_evaluate_object+0x178/0x358
      acpi_proc_write+0x1a8/0x8a0 [acpi_call]
      proc_reg_write+0xcc/0x150
      vfs_write+0xd8/0x380
      ksys_write+0x70/0x120
      __arm64_sys_write+0x24/0x48
      invoke_syscall.constprop.0+0x80/0xf8
      do_el0_svc+0x50/0x110
      el0_svc+0x48/0x1d0
      el0t_64_sync_handler+0x15c/0x178
      el0t_64_sync+0x1a8/0x1b0

Find a block with specific type to fix this.
prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
If no suitable block is found, a warning message will be prompted
but the procedue continues to manage the next prm handler.
However, if the prm handler is actullay called without proper allocation,
it would result in a failure during error handling.

By using the correct memory types for runtime services,
Ensure that the PRM handler and the context are
properly mapped in the virtual address space during runtime,
preventing the paging request error.

[1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
Signed-off-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
---
V2:
1. format the changelog and add more about error handling.
2. replace goto
V3: Warn if parts of handler are missed during va-pa translating.
V4: Fix the 0day
V5: Fix typo and pr_warn warning
V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
patch
---
 drivers/acpi/prmt.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1cfaa5957ac4..970207bc8f4a 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -79,8 +79,10 @@ static u64 efi_pa_va_lookup(u64 pa)
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
+			(md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
 	return 0;
@@ -149,8 +151,20 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
 		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
+		if (!th->handler_addr)
+			pr_warn("Idx: %llu, failed to find VA for handler_addr(GUID: %pUL, PA: %p)",
+				cur_handler, &th->guid, th->handler_addr);
+
 		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
+		if (!th->static_data_buffer_addr)
+			pr_warn("Idx: %llu, failed to find VA for data_addr(GUID: %pUL, PA: %p)",
+				cur_handler, &th->guid, (void *)th->static_data_buffer_addr);
+
 		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		if (!th->acpi_param_buffer_addr)
+			pr_warn("Idx: %llu, failed to find VA for param_addr(GUID: %pUL, PA: %p)",
+				cur_handler, &th->guid, (void *)th->acpi_param_buffer_addr);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -277,6 +291,12 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
+		if (!handler->handler_addr || !handler->static_data_buffer_addr ||
+			!handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
+
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
 		context.reserved = 0x0;
-- 
2.43.0


