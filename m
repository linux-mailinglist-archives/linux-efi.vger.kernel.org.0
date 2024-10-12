Return-Path: <linux-efi+bounces-1952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32C99B6C9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B741C20923
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B35156F2B;
	Sat, 12 Oct 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AryEQAXE"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA04EB38;
	Sat, 12 Oct 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762138; cv=fail; b=SSeF/8o6BMBXO8o3omeYYfIDIrbuLt5xxWG7AU85qMfYq6B0WcpHfYbm0HEAdlOqCosRw+vzb0+ywnbB8nmrJeRe3ZLM5Am/qfXmN4RJaD9Q6aoCUccndkb3O8k4chXfX40iCjCNCSuGB3agmeMGaNH/jVx4nSEXAiMaVyeNeQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762138; c=relaxed/simple;
	bh=WGbA2XSfxxenLJ5piZkahC7GTdiJy42uVBMbOf3Z/kU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BLPqBfhuriAg/crgBxkxwmQh8quXg33xwGghhwTIggl9U0ZZwtiAWZtS7JxfcMUpK8ar/OQ5cGsQw86K/0Zm2JsluRn5SnMi2zkVq2zH+N9TmFMO+S3KdQ1yTV9fmVgT7Muv4oNUIIE1ylMpD8Kc2OEiCi5u4oJHDQfh+8CK7YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AryEQAXE; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hjl0wS90dXhK9bKAFX9wfNBvW4qpUpn+f6NKp+045kkfLQc6WAq8jbk6pFGrlgU9oHUCW/UUsI/pV/gdgVD5TSLbGFfLcoodJeaDWP4pVWv82bEItJk246AO/JV64ta9du4RaXDsx1BVvv2kZMG5Wmv7qIEFlZkhLJ3qDGfng6EVtet5kFrHsxa/OsRCuKk/ZL/3n5hjF9I+as4uOaN+wUzwmtzhKsl6gNBgPTJaZldzDude8WK8/v6jxqzmCZV9wI0s2m6olnUi00KLvjqexFb8fqrsNnBX0yAXKWhhlJG2VSAzHKkCVcIqDvwfu4kHCbCmLCxQ/e5U6e5+rCDFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT+bjhA9/w4oUhNM3bRPM1TnQ1dv4SG5M/4D12A8RgQ=;
 b=Tzjjyuj3YYfEJPiOPxle2UgFCuL01+HsL2V0jBcyJsmaz+rfbL18Vn8LT9J+RYhNfAj3zC/h6M18Tpv6Xeku7dt72UXfOi2QKMM8HcCgrutqr33KZcoZkqKMT6ys+Yc755uSD5sztkZZNbwm8Dr/DnTDWy6S/PmMmkK8GAxApBpzEYWi1E6Nz0NRbEGyqtRyhZ+uQtMNLlD0CDPF8yh9WWI9bF9gwC7x4X+ZcmT0bzEuKMD2akZEQ+BOfy0FUifxB8lmidUR37CXHyohde2cEc9owqj7g13QjiuzLStQ1vx29EW5dy9dbx6DvkAMyItoEoXcb+yrAl4OIVXwSkzATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT+bjhA9/w4oUhNM3bRPM1TnQ1dv4SG5M/4D12A8RgQ=;
 b=AryEQAXEJE5VmCIdzvBbwkJgrsFNGIDEKhRZybuihyZXZrxBPDBcgSm9lURBW8vKY047Yijm0qaOPLva4sCrD1fxHDruEVFW86m3jLVQuwlIF85v2QW1HbDNFtIgqwuIiDkFWyZpXId8ajHxFjH7C9LRn9a+cf/HkJCDsTM+pYXKS1zxceynni/G3g3vJJrkF2Pgy1L5sbyEDaTt/huF4ZSC0g7Au0J42KBca5mmSgUQi1xmO8dEjNvekSi18jCAI1b0yLss/4PRXz5WVWE/dbU2/S2mCcuLko3BxEDz2Axi2tJ/Ouo3EZ07yqdFlyupyq8TsLO6WREPAg6kS5UVWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.21; Sat, 12 Oct 2024 19:42:14 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 19:42:13 +0000
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
Subject: [PATCH V9] acpi/prmt: find block with specific type
Date: Sun, 13 Oct 2024 03:42:10 +0800
Message-ID: <20241012194210.3588557-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4bc4fc-25fa-4ae1-860a-08dceaf5f84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIS6FdrFMRz+iOSzE7DhZG8Xu9jtJAWpuFSCW9DP/34/u9LC2UnBz+2NTq0U?=
 =?us-ascii?Q?hsz//9FUSd2yYrgLdYLue9HfgT1Xz3x6i4wovVci05w2YcQtfR3Y+M8Qpw9y?=
 =?us-ascii?Q?m9JyHRwCrSU7sY9R8Fuez0XteTPKavVijoUkCIVRLJBC57YUIN5eHLXy8hpO?=
 =?us-ascii?Q?zp3Iyl1o9ZA2NSKOcjD1ODa1X9esd1y+wVJ/8QBIM6AiCp7RiASL09QI7rzV?=
 =?us-ascii?Q?+OLLlkLj9wRt8gH+E8g9PV26oZfYxmt9uFAw7OrAfVm2EwUXteidsm4rJGkJ?=
 =?us-ascii?Q?FpXLVu4JHKHUWgv7NfySfiKS8LZl1SuJuKEoKuXlcVqPKQnNEyI5sghWMngB?=
 =?us-ascii?Q?A3u38WtaFbqbgnLWKXHgz5FH/LMQWaObAMUSmUSRqYNIXmeW8SltNTPDSO8I?=
 =?us-ascii?Q?xtFj2AhsSsV0T8wL1UcAOdAN2E95tf7y2RJiGl09dM6g19dFM2I4BfYUR4xL?=
 =?us-ascii?Q?B2KrwQ9Flb984EFUSYh+9BIyd14bh3e4ijnND0WmV2hmP2P9eE4BHjNjpM4r?=
 =?us-ascii?Q?jhSz6SkQsiSZ7FkfsVuZR2NfYiohItmwXBy/Qihba0z3gbVnYQ9HBPo6eYam?=
 =?us-ascii?Q?Fsf6LMWSUvcLDsizbut5C/bWr1wTWMgrGanKX5fE56WWsESt1+kcC35e4nFY?=
 =?us-ascii?Q?dCDhA3EKSU5w+zlByT4M8TxnWP6c4j5VyqBSIua9APKNR4HzacvBQFqjqVAU?=
 =?us-ascii?Q?iuCH9YvbGt7SVJeOciJEHiG604XB9LUMz0V6YGwhk+hwAhzN+qBKoIzINygK?=
 =?us-ascii?Q?yXWm8mN0bk7osV9bCcNgqDzkZA236vut6n/cKd/o7WW/OnsyHQY7Jo9bL58c?=
 =?us-ascii?Q?coactPeWipg1BjVkdRjvp24tPWQPWtAVcIjHalbWAz/oQQEVaUEmPqHeV3nd?=
 =?us-ascii?Q?uuljsW8xRRQ1hlI3c7q2NZ6ISPzzJFjfVv6iUGsXC4Iddm3lcYmDzUkUGKA9?=
 =?us-ascii?Q?gOyILp+Io3jAvL/BJhEckytyZjSza/RuLfLFCkR1MA+09oilAFRh5xt7rkv5?=
 =?us-ascii?Q?njC+Ef+punC9h4Wfwd+nVQQc8S+7xwL0Zqr+H1LKj/HwODD8nxwQSThp3OI0?=
 =?us-ascii?Q?q9F3gXxFr3rNvD729vT/URcymswV/WJJ4Sg4ONCKXgMGdURWpdPDywoo9Pp6?=
 =?us-ascii?Q?CWKQOArLzj8GB5nE401FT9sVbz8U9EOo2YUQ3V99QeUdZ19SHbo195TdI6L2?=
 =?us-ascii?Q?eXgPRDwlIa/rClBKBhUPf9TMgj3/kBZkbhiya2ciTVNKS+0KGGlsCqBJEDSc?=
 =?us-ascii?Q?niopfeb39XGERkI7hajCUGpgaDkJTeuyExsvpb5BXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dvg0YNXg6sXJVO3BS6DrKTaZ/MrgG+9dz/tE/180qpRxN8xnLWfX0iJYPjQ?=
 =?us-ascii?Q?P3j7sfPCtSftjOsYrM8gcEb/XtgBW3XmQDgaY/Mn7nWqC7I7ShOaOcXIzkUv?=
 =?us-ascii?Q?2NiAoaI1OUnStlfzS63Yq3SY2VwpSOGLN2iML/otzEiWl9F2EZqx/HSNzoJi?=
 =?us-ascii?Q?RW1owUwr9ylq2K2Y5AM4k4tg665JyESckSxHAVSBPjfEBGP19UcY81IYm77n?=
 =?us-ascii?Q?R6b8jJ2lZ/kKCaA2/khQVxwvONF/b3xzfhre+2hHqDgV1QLTBYs/fBYXWgjI?=
 =?us-ascii?Q?6mjkD8HXsr5a8PZgl7trkhuKJYdneYThq/Ry+PgS1Sj2OLHV7dRxH2BHJQMT?=
 =?us-ascii?Q?q1p6rzco7TiS2uRXCZDLWNSb97Cc8AMGcw5mWk9XhsiINzAGtCuBQd7FAZ8I?=
 =?us-ascii?Q?HnpoV/IuP8t5fQUhGtrGTZrLFJBljUXMpLFyU4Om6DXM+mwBjDlhwKg2beDF?=
 =?us-ascii?Q?8V9kPXEWXk4LZFVQw525iN7ICvwUZsESuhJMjQ8kO4P3vF2WT+KG1dKDNA9O?=
 =?us-ascii?Q?PwrVMUfMNsBMJvafTcN02KE3jFjZgJZX6CIFjLNIH58IhGqgRPqBUIwjLsE9?=
 =?us-ascii?Q?b5EKFHSFgz2GlPtlcSA7LxEKQRShyckN2ETn1DClYuBwSaJRxz9QBwYQ++ml?=
 =?us-ascii?Q?fsUUvbi25yjQ3W0ZHOCwUgQhfcfhStSm2FtYCD4FzFucHhwGRplWntvICkGQ?=
 =?us-ascii?Q?H14N/p9UI1Tk6Hh2S8dXXR/ZMd++DjJ97792ilvcfMnrs/iTZX1GWkPO6LQY?=
 =?us-ascii?Q?2gD2EydI+RD2H4d0BBhmFBUFmVvfa2De2SxAyig9ZmtwR+UQIDheyVDwEawu?=
 =?us-ascii?Q?L9PPep1pUVVEdrrD39CAw3BKax8vyZHZpWvDjQYW5BZBEaEftug8YcpdC3pe?=
 =?us-ascii?Q?OadRLVbdsm3760sl2wjKfXX72/V6JL6J2ELlLRl3sDnL2Yv3AILMg9F92te/?=
 =?us-ascii?Q?mGE6hztj4Su4/EUpxw/7T05bB2rUT3KtFhycTJ/YQjsBaMbRjqKK7JiudlHe?=
 =?us-ascii?Q?ub+KS8Z465mwwwh14f/V7msbY5KzWSvblQi/OBbExVKr3xt6qjt28tClERvh?=
 =?us-ascii?Q?iIa8QpW5ByczV/X97qO006Y5EZFu84z9UZxedeGu/PFaZZJasCA/4V54/ayU?=
 =?us-ascii?Q?OtuhWRgsO1ragh+wveyGE/6Le7mFRvF+GDpiJKBsoG97N02bUJ+MfGv9yh3e?=
 =?us-ascii?Q?PMaOy9qOFOAJiBMLfWEX8/9VSpubv1cQJgHEerN+qGnQsOd9ZgEsMCFWxDpt?=
 =?us-ascii?Q?EY7tKbNmGyZ9geQh1bmA0d2hHs51eWfy1Xg5pPV/ZSxV2UqeaIlZSDGjCgb9?=
 =?us-ascii?Q?sCnQoLWLGq8k7F1LdUtvh2SC8NICtHcXnk65hkIC3d6mz/vgtB3WwQSU7up7?=
 =?us-ascii?Q?fYSLaPz6FLfCHglmltx3luJl0VrGBC5bmi69zJ+4m03IQblMFp++InhQ2Y/1?=
 =?us-ascii?Q?9YmfOtxVaM/dBADmI7YRQMVYUouNPTzTVpwssq6VOgwVCC6uPu6rRcG/7O0o?=
 =?us-ascii?Q?lj0VKmdiQP/v578AJRkR7E6b27b6H5T8FM3x2M7sKe2S5G8TU2MTYv8blpVe?=
 =?us-ascii?Q?Lk5RvGpWL5FXpxHynhO4hVB3OYefcjUHsmYnI1He?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4bc4fc-25fa-4ae1-860a-08dceaf5f84f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 19:42:13.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6Kz2i+v0Oayllfc3pVw5S52tz5QJyBbPMZdq0lrx92FU/dNmRS2c60cm8K3/9NwVTMimt9AqybXg1AjQL0CAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

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


