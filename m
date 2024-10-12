Return-Path: <linux-efi+bounces-1949-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4106799B6B8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607161C20FD9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD583CDB;
	Sat, 12 Oct 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lu3sXJkS"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375292F34;
	Sat, 12 Oct 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728760580; cv=fail; b=uy7ZMPf6IabWn7+gIyDiTJWWpUpOyBx0+DQmls6R8ydkHQDe4iQzuEYzWzZoRhaH0H1b8sANo3mhZnNbZvVw9++17ASIOcoQlQXpOOLgbotaJ1vJ2a75xSTKWFAlaLGq+Xqo/HSD9xKBj+bLrITdj/CO+lsjLeymVlStI/lOcv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728760580; c=relaxed/simple;
	bh=hhFRwAeTrN+DyRg7V7VbtBibAlhrgt2/UFxR4m/M2Do=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XijgiYLLm+fyWBJt9Pnf/XqjnMUC7QYoAxcqvWJNmDxswe8nhS4zJI/NaEIeAjcJoxGYaU7QVHE4mEnWPtEA9ZvNlG36jCeU8qRkxy55YMCIkEbURXSQEwjrgu6wPpdGcUYGYb7PHy/TE6XeHLOi54dvKSThJkZNzz00Bjiby6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lu3sXJkS; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXFROlSaFrhbj7wyFAVlvKAdvWWNbH8OLRxx0Le2Pa89DZNz8dHk/OmOrgluP1bqY4uBcAsOUG+gpHWdOGv5FksxrbT5kwAEwa9UuhrBxag+Q7PeMLztLwJUElHzrydRq2Wjx8GLPC3RcobRAMSOpeaOx7dkMmeTsarkh82tCQezC9olDqrrjmgfzM56dElelIZsFZbOHUmMLavN8P0UX7+wx6GG7emm8CFmmanZyQ8DuNPEiBie4Mh4OBFC3RrgEPkr5bl2TzI/XpF+PCuWzNZodFVks8jYZPc7N1OlTmbYpU2c8P3lRmdsiOlmeYjIMKZGJyLNnuUjzdkohwAfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twmcl1Y9Wa56xh4avz0ozBO04biuVxSP2slcDmSrOc4=;
 b=R4BWWi3tRb2FZHnZh21JTi9HaujCROpdZqwgr6ceOw+LGbbvf6VLL8Ee30dF2SNbOKwJeWH3gzVY7c+05sSf1LtoYx4Mr/2VtUFBythL/z2LpjBK/X0l6kv/nkaZgQ6iDE5mFn3MlK4+fr3ysEoOLgI8aQZBHy+EDFg24qPY0BSv1o4XGu9+n2alh0+B0Tep/rHIiavQDzJhjf4sEcmJRKsQ+drxTT3CgmdfJWUQjnEi3eRML+kKa1s1ImFrPFCgL9G/2LASS6BZq8OehfjhdDgpA/lssYosa3+mRsBMPS0aPHURHRj25qbELPKnDJQHh7sEFOKvj+aJjdKlnTIJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twmcl1Y9Wa56xh4avz0ozBO04biuVxSP2slcDmSrOc4=;
 b=lu3sXJkSTc8X5hleGMa+WettjfH5ARwI25MUnFHoB97rM8vYUKpVQeodMGdPEBoUCzZ4spCGk/i3q3nmvnd+R537dn1pH+uisdCYq71rxVYi8usjnLKugHIwlvjNQmpDiF1xuv7ozb9R0t4BVo+eAeynlNqsHdBbUhDHl4gkC7vONZEVH11ZoddNL3z5XwBpSrYSOda5nNJXWlLAqUmfY/cd6/+a7O8zg08WLvn1pqvZwI8pZKsYcaCIj0IIutjDaW86Rplz/0M+qaliy/ghVg460zkO3wYlKjathGvTsa9K2H2X8qViLxDWfnCf1PmUZgX1hnLFgkfFXQiSBx5NLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 19:16:16 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 19:16:15 +0000
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
Subject: [PATCH V8] acpi/prmt: find block with specific type
Date: Sun, 13 Oct 2024 03:16:12 +0800
Message-ID: <20241012191612.3586797-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 764b906a-f2b1-4fdc-4eeb-08dceaf257b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ftIBm2WgmyKmoAfCgS76yFlb7+y9Ifh3jd4+V8dIB/ztfxo1Xjmadi35KD5?=
 =?us-ascii?Q?CBurHQKU3TnbymY8XZjywuwZUbBQdTxt1v2GvS4BkYHrMUOEFjCXt2onWSIu?=
 =?us-ascii?Q?ezXMd7ZSwQjekK7bnyQ1RjSOE1HYKspKuRMhZPHrxaVgWgrL0hOvZsdD2EF1?=
 =?us-ascii?Q?0XmHq2hKu3xIPIVr2YcOb53AUfEvIrniqOB9Vg468fgM2KY4bAYI0PvWsOi0?=
 =?us-ascii?Q?GufVsEouquHJB4LOMjUP0A0HNNcrrOoN+lTQlwQxVdlrYEbJfmBMWCAUtneS?=
 =?us-ascii?Q?T4p4npwFXBlriX1V7Rkgr5N+xoUXFM5eARgg4ZIy0Et9/ueIGVrFA4tocq5D?=
 =?us-ascii?Q?JFoGEdIymQruPVzL20tJ+HQ/2hWX0fj5ilt+EDhHb64NDXPOXqqaIhhuFSR9?=
 =?us-ascii?Q?UI3UCjkun2ymJu5ExtePR3jwOfXseTpwgZFgMgWre7zs10rwSlk2SBAr9Y08?=
 =?us-ascii?Q?QdcSEmxtu5ggKpOoKclpw+Cxn8BokA0IB1rj/WLt4ujTiUc6FmePRuaQoehX?=
 =?us-ascii?Q?hOClo8dg0LHUV9GXVNaoNQdEbKx32tKRoPurVHaKTsohAsUQP0Ui0JhlV4iu?=
 =?us-ascii?Q?wywtIaXkV5yz/B/eJSxsisnm936lz6YM0cZKmC1SQEBONCdyXtsC66c3FSoB?=
 =?us-ascii?Q?EMKEV/pO+s/CHKWhqgiRAYH1i5L8usZCbHkEGOdHRCsKWPIP8Rk8JGUm7jz7?=
 =?us-ascii?Q?lc8D+9/gjx7GIamjY+1dG57UXJXYPP3fkWvZD2prxRo4SSSPb37dm8559ZUb?=
 =?us-ascii?Q?TZo3OvD4CDQi3Zmv5M56+KogskM8zvhTOANjTYNZL+rdEOBW0KK1cMeWHql6?=
 =?us-ascii?Q?bAhx/L6jfiOjEmZ56l7t22rkvl1FhKcxsuiDHhRG6fp+MLrncCBMCUl7phNM?=
 =?us-ascii?Q?i98iFAxXxx03bM43/zEPT5fyR0rAp3d+Zf9Q8CiJu5Av/Tegg14lKJE0Ogwu?=
 =?us-ascii?Q?/AtxeX+pB7kxZrRBIZ63shPmWne4qmp+T15zzPC0kNYfd/Ko0JgCoZ2xWUOc?=
 =?us-ascii?Q?j6GPclhYZdX/xFV4WprodMmj0v2EW9wZOOGf7XBIov0uY+CVygEpxajxCcr6?=
 =?us-ascii?Q?f3rls00rrSK2uIjJdZ+p+gpbcOdKdX7r524h1DpGCtqZzDP52lMylv9lgV3g?=
 =?us-ascii?Q?fxobEnIFm+ykeNaxfoWxvcueVosvukcMw3ousUB2ZDKNOisb8mTSIDTYqyK8?=
 =?us-ascii?Q?vDWaDCffO41Yjjq46xKj5kktDX8gg9KgjNm5ZGH8pU8yECEV2zMuiAkdZLHT?=
 =?us-ascii?Q?LwnOaHNHuD9ZhmEiHUnBKO82/GzmOwZXjL2kaLGl6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+PckpwiqweXGkgr6onhs6+6wvneAR+4pem9Jx6H0Rqf6PGUW/Jn4XfK2gXz?=
 =?us-ascii?Q?V6DKMENOaO/E3Hv0ThA9b8T8/lXS/lFlLgI9/1M2/C+sqG0B55f/rOkdt3ui?=
 =?us-ascii?Q?p290AZqrQVCzdbZCZNQIaNkeGbVNZH3qZh+Pmc4q9m3h302EXr1+EFtHPi7+?=
 =?us-ascii?Q?SKFIKoGcTQqRhdzo69DEWRp/LvxpUE6VZcTKEwTrSplh17yIkIcWhC4FM5Yp?=
 =?us-ascii?Q?pfQpbRF88XNsBvF013ai4IJt6b947RyJHoZHo8DdCAuJalZoJdz8N5Z25SNE?=
 =?us-ascii?Q?lllkB4uDnnFR2WFpWH+3EsX5cJ+rBvt5rV5zrWzaTwl2xd17xgWliHlHjigR?=
 =?us-ascii?Q?CDUTwqLsvitWv6Dp5Nogqen2tFpj3MRmAF1qPFuuQ79yfeDQWuxTBzlq8vff?=
 =?us-ascii?Q?d83Mrldl7L4dHa2tlKqQgFJRFoKHgQm9GVgOXPSoPnq9cLtSnkdL1FxOEiTO?=
 =?us-ascii?Q?10BzZeMCmJEnrnhfvqWs9Ky6fvTiAMfIWgIjUcE9bm/FrZjhgTSWTI9KRu6h?=
 =?us-ascii?Q?68NpgrGBKaLvWoIErhbudxYWhbPrc0hcWgqPatXZE2klTm07bmFdo2SZ1KlO?=
 =?us-ascii?Q?8tS3Rlm7N0xvqGO7/bKkbENQEDCz9qeEwJWcytdRQySTTTsUo3SXy5Ir4VRT?=
 =?us-ascii?Q?LHMWFmZVvHHwNg+flnkhm1TX8cKy8jpqOS/7TAOKeBMcKIvUvEZQKhlP7p0n?=
 =?us-ascii?Q?eAxQSeCPGQFeFaE3Ppt7RlKR7rtXZDTLMtutN5mxoAemk4Q+7IqQn5NMXhow?=
 =?us-ascii?Q?M6GVbablgypRnNg4Fg7YEIUJxy2tDV8SdgxXO6ww7UAkLYmc8gN7OpVG4KSQ?=
 =?us-ascii?Q?SZ91i1oE43M3flCw2Eb12yf7/B87rEMOX3FAHDn0jwMTvjLDevo6g7zC/vPX?=
 =?us-ascii?Q?0NzW1pvcqb7zzTEAv3QW5Kwt2TibCHHSYaXVOv3TGPCY/hyKi8a6QXZ4U9h4?=
 =?us-ascii?Q?ajZbo+NLeLB+uJf+rVvrS5YFHgM251FtUvubf35OZ6liGaFHpGMyC6ECv62W?=
 =?us-ascii?Q?Yk8G+N/gl5Bz+S/UNBzXkGGBSV6phExnkFzbQSew2+IQR0udCsIPAFocitAz?=
 =?us-ascii?Q?O2Sn0dLjEi7dPSY1sgVjut9io+SqgEYPzT8A/T/arRFmiQwwW22QUgQwiZsL?=
 =?us-ascii?Q?+HFFAFK+9OVQWhzKPjqm5CzqQ3w5wnoG6IRgQ0mE87Jj5QiXWtezVkSPx2Sl?=
 =?us-ascii?Q?1/lE4B5xKYuUO1hMLmBc0rz3JTsNlhJTPbmyj7OayXeBkFT63zqpbP4yMoQU?=
 =?us-ascii?Q?dwD/qRHlCCxFCyFOCX0Y6xQNhPy4tHnT1AUDK8WH1eug7BkN/ssE3a6yQYPm?=
 =?us-ascii?Q?Zpg7GiO7rLiZPFTTsQ0bWEFMm/oJdeRyzUEKc/c7mcPFsNT/lyEY6E7aLtT6?=
 =?us-ascii?Q?Pl0cMugd2JIGITI8nE9JoLL/QaRibeYpGv84xV9rWwksG+Zv2aa3oHGmtaYE?=
 =?us-ascii?Q?MLXWhfn+mzjQmEqgmbdD4toBYjzTsex494JlsXyi4z9NsCd51ZZuJMi7Dd4f?=
 =?us-ascii?Q?S7EQpHG5UWlhZKH6Deivo8aD2YrOkXUiVwAXrL0vDTU5iHS+CHkjga4s2cVm?=
 =?us-ascii?Q?m+fqWrKA/5DhJSrud64f432LACmEILWzOL4Pu6DO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764b906a-f2b1-4fdc-4eeb-08dceaf257b5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 19:16:15.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr3lYM1y6DxA0Dma2zJxy3vFHhjo3XLVJ36EbJWEQN5Jw0Y8zBbOXlCiwfE8h5tyjWOeS6EhJxU9FOR7nCHFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

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
---
 drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1cfaa5957ac4..552442bc10fd 100644
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
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, (void *)pa);
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


