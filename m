Return-Path: <linux-efi+bounces-1955-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22399B710
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 22:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E011C20F69
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FA14659D;
	Sat, 12 Oct 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYtEAxM3"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46E1B978;
	Sat, 12 Oct 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766220; cv=fail; b=pMIMAloTegSOlFJv8pjTWGyPhZ/xt0cO5xycF9/lJbhV3jwNrtN7qrrObNkTHPctJ/rgIaF3B/jFr79g+3GToJa2rldR4K/WndwZEZ99yrJJln2CCq80UOBj+2e0w75JkfgamlOoOsY865z2wSnTehmkkYleGWbUQ4/eXkj9ZLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766220; c=relaxed/simple;
	bh=7omy1gMeL+nVmhhxCbt1AHni9vbRXYJjoDYQA8PXf8s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NiNo0dZ7JpgYDUEgX+UP6IXyYNfHkIsNuku0O4mDbJUzye2bUBPtbuDENIVFauHHkBOqr3AkcsAugs2ADMgBD17ykYH35ZLTayUqJdIMBswLkTmb9hr5Tpsc1QSv6m9tAf5GCq0JAJgxUQh3WpMjzopSRqAtGo1ZTGpihpGQPHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYtEAxM3; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnGsuZ+vImAjmr0eTXjP58T5JILl7on3IRH0Flg6/ekYjklHBDiGIhPk5+iICCOyZ3UrLV+WL4m19W12hu0y1YZT2hI+cP+eLkDiKMz61jhY4TMscnj6yrQdcHO172v6UjN6U3dJ5cvpK7KrDPzkvXHbgQnmK2Js1ce36nFgND/J2CRkC9NKrZ+PPY1DzE4HryXafX26tc7UyI5JS284ZXJmKiq8SAb+MwJY76M+o6O8XIseyn99xfIOqeS7n5N990+k48lmWqGviajFGwGEF9lH6zorIFGC4vTSJ1D5Mwe0D4JYc3LWyFGI8v+ALylVbtXLkzcD/vPJM1/LOEUH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scd90ZIuNhtwqYY3Z9uEgMfHR0h+F41C2duOZAbyEnk=;
 b=qGjNcO1N33ZKf1hxMPddYY/7eb7DKTlopFERdVsbS1O9cEtMF2b+GNBNOYZcSsGq+ln3/H/OtFlYGnQEQ9QZ9rl9QCcuoYS9TcXC0N+9nOwiE1tTpbFV+f4x1tTo/u84QOJb7Vifhqpk5r1TQqnDGbe6xqAAugyHxUnbg0CTKBFnN4KoheRyBxoKP9CDOFO7DC9/6nQezX9E8CV0wWj/SbxgqnvMwmzFgl2HZFuZ1ybIFRJ02gOTuRBND8HEngrOFva0MUGreWkdC91BdDkTcFnW/wF25iKfA9uMK5WWJEhmBR1iNkXpmqkVK2gxNd+fq4WUUyXBoQzyd7a9RL0dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scd90ZIuNhtwqYY3Z9uEgMfHR0h+F41C2duOZAbyEnk=;
 b=AYtEAxM3Vba61Owkp4vfIO1CyuEI8BqJA9c3yC06vuamJNRv0XCNaa9CuHlgJ6qYZhtrBhQKivCXvnbjeY4BUBvgzGbdXTgCCT2CQKiQel6zgGy3uPQYQsyZ5zD4HTlT6g/PiObD8AuB9YD/gfvasffSVL4J02GXJ7TkeJJS2WVKEHAiSTZgKIbAWlTLy2bRKv5MGTDE5uI8pDcd6XhzZeZ6onv05I9PR7AWzayJ08Sxprfiq12FLUu9UzFZy97a9FrRvHhP0zI9/6fPCdhxf0nPHyP07AzT/ye41lj44FyTqz9SLVZGYTYpAnYLgvI7+Sswr++RWZ4gJHrQgIsaRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 20:50:15 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 20:50:15 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH V10] acpi/prmt: find block with specific type
Date: Sun, 13 Oct 2024 04:50:10 +0800
Message-ID: <20241012205010.4165798-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1f6c7d-2c93-44ff-7b1f-08dceaff78f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8rXwcUx87jnWh2svezm7ltY8hhR3JEqV6KP27uMbhuSrQKfzHY0Y1LnoVXbq?=
 =?us-ascii?Q?t83fcILGJbJmeUkbmjeidhcj6D/xZwmiDgWPuT6e1n9T06kaGanSTruscACQ?=
 =?us-ascii?Q?y3Z1yb50cCgaVbT25pvUJdjVg1Dwl4uTSIKll390FJNs04LNC71z/SyoIY+a?=
 =?us-ascii?Q?3g4yQI7j0xXLT3tVOkF+npib00fWuA7+fzQMCaVcrnKen4OvKjXsgK1sIYvm?=
 =?us-ascii?Q?0uc5B1TBVIaGw9esGnN6wi5+lx7/EUR2xFfvtr7mMyVIPrDq86SMJH+42qrY?=
 =?us-ascii?Q?Vjw+eph2tWltfXgch6R8P0RqSaVDlDVh2YqqiOU/cP7hV6wbkeuszfO/KD0J?=
 =?us-ascii?Q?KE+zJm4nyhZ37exSYaDFBkJeS8AnHWmiF4ruvqo1ezmjsL4JZAboSbixdEfQ?=
 =?us-ascii?Q?jq/N4DS8f6vpu4RKzWxHtB4H21X4u8IK9D+lgyhj0BoPCTIB4GldNVRQKTa5?=
 =?us-ascii?Q?aEQ2OmHFlGZbt9P+zL5yy6iqoP+lu0nzgmdkuc8QqjKxNLcPILyXbP/VZWe8?=
 =?us-ascii?Q?VKPrEWyhEsT8JuFrFEe5RIcvGZp3ER+PHl/rM3+u0MlTNIEhg12VYV43hgu9?=
 =?us-ascii?Q?JM84EFLJJMyQzE8Q8FainNWQAm6V/igFB2NNw7wXKA4z7Ie6pjmd4PJpgAS4?=
 =?us-ascii?Q?XVDyW671PBHBeSH6nrymc8WOlSV9OAegVeOE8pUAggMewMOG8+H74D1fuWh6?=
 =?us-ascii?Q?kOJ4vgNNZaT4Fyqi0xtxA+2t6WgHG9o3Y6efIGZgDfgDJBlqbXyOfxDnuzrM?=
 =?us-ascii?Q?cTr4PRHVmpXY6l9SIVscyHc19h18G2/rSolDHX5UwS1TsgRrngNMYqwpYhRC?=
 =?us-ascii?Q?Of9C+mXH2MvWNr+M+eb54qgoEV83RW0HG3P/bXX0z67KQ8Z0yIGc/qUE5g3/?=
 =?us-ascii?Q?j3lDRfzdPXA1lvnk0XZDqSsGkfzYiSpXmvDhR11FKLCsnwumPeberzXGDyja?=
 =?us-ascii?Q?pJHBAfSL55zoNvRT9iZftGykgr/g4AyehxByB4mgcrN4xSRqp10eSBSDr9Xm?=
 =?us-ascii?Q?exJf6BXxaYhGviOK9gJQUgaXdkRnWz4n2nnf843YZHw2sj4P5OZLhqwb3XyH?=
 =?us-ascii?Q?ziYIkJBjUHsNZ4vEfrCqqB714Ovjgh5k6qB2AmFl68DecefoxDqYz9EkrpLi?=
 =?us-ascii?Q?5CNfVoIBhg2/j0gMKynWCtDoPCU9Ls3vMF2O/MKzEPkwMNYRfbSe/wOpjKiX?=
 =?us-ascii?Q?KGCuqCjYpBQL66HNvElzgMIkppJNwat3kM4KVajhyQnlYPsNZJ27b2X0QDvo?=
 =?us-ascii?Q?lMwh5L0g7H2+JI+qkTCZ3jdolQFIXquqKMmbbINgaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9q2KVv0Sf8e6poLvFQmuIssTAj33JdTxOuAzEUHjrp/ZMDYoXb66lqeJwpXv?=
 =?us-ascii?Q?nq5kideUIwoNRMfrQcq0Dix5aH5UpbQxF1/gsSlmcIPnDmmDgQyY4K+q6YzO?=
 =?us-ascii?Q?PmyGNspoC3/wSi+uQzM4aDxAnNOTOCeNznuVV3pRMpNMGHK97kotIOp+7Ejq?=
 =?us-ascii?Q?K0JunHXTm/VZDAA9UwCsK1B/2CJ7HUQH5eY4lsnrEZPd5ZmWvLzDAz6qM3HE?=
 =?us-ascii?Q?UKB5pZP95xYsBoJVlIFDK4tLnxNTTh5k+F/7aAd2WafkC7WPrn7fM3Bgj2Jv?=
 =?us-ascii?Q?CO4BZ/iaCzKScPdnFKWe+TN/q/NT2uxJ3QLXaPnsVxhlhc5iynbgVTWVZPp5?=
 =?us-ascii?Q?76FSTF4OptOO+AGwK3sSbGuGWmFvv0TA/CIpDaRmhSEPl+6QdimDX4pojobM?=
 =?us-ascii?Q?KTix0bvRs+mCo7hMoaVHe9JjDc2IonrxupUEt0l9g8+ZrM3Iwdbeu+2EIe1T?=
 =?us-ascii?Q?87zjGbp20DZzk8QyQBUVBZDZSP7d7j9DN3t83Bb3XnT4MIstAuSgboPHFfkN?=
 =?us-ascii?Q?FKsNXiAh8vLwYgxow/cOcI4/OQThxLweF9bQ1Bm7GL2oE4oFj6Q50DMiDlvt?=
 =?us-ascii?Q?BM7hf6oCyR2tyc3Bf5s4zffoGv5kMk0F49Pl/3s9dQb9QnxzYtvXYyCs9Ept?=
 =?us-ascii?Q?cR0lTt4zZ0v1PpiN6n0720hnaUj79HMuqL76PhPzigos3v9bF1E38GdMWV6g?=
 =?us-ascii?Q?A53yJRYeqjy4OqRmv54+1rqXELkuMrSCc3hHt67ZO1b7f3AiuKzvWlz7DFYk?=
 =?us-ascii?Q?/Sw2x2R0Qq8qIsP1WT0IiELbn0RFU1iZKJXiYmcFa/SkGzLCXpBm34nyfL8P?=
 =?us-ascii?Q?uzq2a4RJrPSQs5hKDQnoFqZDzcnEMv+6rTo+GkP+1uU9CtvfXWQVx7+SGBSp?=
 =?us-ascii?Q?H/wXyZ5Rk31dRJPoDABGg08GH3w3DNzVFZ3Q41cs4K8JXTMsUDkbHdevIaP4?=
 =?us-ascii?Q?jjTo2djuWf55KOTIkfXshM+0tEudoMQiY5pvjS6tIjYeWTjlhEh1WkuFZ+sh?=
 =?us-ascii?Q?GVxqTMvfw7XHk7Ngw9bmCjVRIITkk0/s5GUwpQSw4FLaI7HfxNoK5mNmyZ6t?=
 =?us-ascii?Q?cMR9X+Hjl2bkes48/mWgYXG8sOE58QVChZ4DG9RylSHqXzk7w5hm2whTY37S?=
 =?us-ascii?Q?3aeU1aMebuUA0DW8YPogeczhSX/9cSxpqao7sQ5NvHqEFB0OR/ugWciAwHC9?=
 =?us-ascii?Q?3Klnv1UArp0vcFj0P5nPv3et01/re4BiUtlIoRrKnMk50wFNFoGj1SCUhQKr?=
 =?us-ascii?Q?mYDhLNAUu1hH4NZEQMReMFzQzI+E7vtWF14z1iHW6RVy9msQyYipEVlDtWlX?=
 =?us-ascii?Q?9F050N3eo4pXn6arwtK4I8zS+yIPjD6ub7OX26U2HnPZIHIuEmu7/9+t+MPx?=
 =?us-ascii?Q?qzuzZKn8LlhHSH3U99LabpreywXPIJirQyBIjIKgP1rzPbnl1+wVv7eKcLbY?=
 =?us-ascii?Q?XgyipikKgJ/TeWcl/hBfNkhiYJRcAyPm+bGFdZlptaikkzloVKMr6if1/IgG?=
 =?us-ascii?Q?DVhMfROPlep8DfnCD5EpWfjaggSL5iyhXfR0Sz/cZbVSuzP5BF4xxLfC1EKz?=
 =?us-ascii?Q?yftsRL97AUcQNG6LJ6B+T6kpkbBFSD4uu4ei9BeZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1f6c7d-2c93-44ff-7b1f-08dceaff78f1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 20:50:14.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jztmPOAf98BEBN6W6wBEfrrHeK4QsZ4kLfas492pZuh04HYEehJ+J8YjNq8vVSyzKkS/c7bYceR6JNrVrpK6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

From: Koba Ko <kobak@nvidia.com>

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

Find a block with specific type to fix this.
PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
If no suitable block is found, a warning message will be prompted
but the procedure continues to manage the next PRM handler.
However, if the PRM handler is actually called without proper allocation,
it would result in a failure during error handling.

By using the correct memory types for runtime services,
ensure that the PRM handler and the context are
properly mapped in the virtual address space during runtime,
preventing the paging request error.

The issue is really that only memory that has been remapped for
runtime by the firmware can be used by the PRM handler, and so the
region needs to have the EFI_MEMORY_RUNTIME attribute.

[1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
cc: stable@vger.kernel.org
Signed-off-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
V2:
1. format the changelog and add more about error handling.
2. replace goto
V3: Warn if parts of handler are missed during va-pa translating.
V4: Fix the 0day
V5: Fix typo and pr_warn warning
V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
patch
V7:
1. refine the codes and commit description as per comments
2. drop goto refacotr
V8: Fix 0day and cc to stable
V9: Describe 0day fix
cast PA as (void *) in pr_warn
V10: use 0x%llx instead for PA in pr_warn
---
 drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1cfaa5957ac4..d59307a76ca3 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -72,17 +72,21 @@ struct prm_module_info {
 	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
-static u64 efi_pa_va_lookup(u64 pa)
+static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+
 	return 0;
 }
 
@@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
-		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
-		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		th->handler_addr =
+			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+
+		th->static_data_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+
+		th->acpi_param_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -277,6 +287,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
+		if (!handler->handler_addr ||
+		    !handler->static_data_buffer_addr ||
+		    !handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
+
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
 		context.reserved = 0x0;
-- 
2.43.0


