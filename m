Return-Path: <linux-efi+bounces-1925-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32B996006
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5428B23B99
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1417ADE8;
	Wed,  9 Oct 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mb8oSsw+"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E57173326;
	Wed,  9 Oct 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456328; cv=fail; b=hFg1xzi993adyQBMB0pKMiwwF1QP2OpgX5/3yGcDP3Yiq1dMoCpXcDk62NYmQygqA7YkVFWBJ0c6/qCDyk3sDYcXvoLZfq6r4fPrLmgGNiWOGueVm7dKv2Kq30y3EpSlYv7wV1ZtyaNpEoTwHqb9csYrMIK+bgHwgwHVFhEbeeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456328; c=relaxed/simple;
	bh=UNzRL/6vHHWcYLG7MGdYAYaixyR3tnpzMJYcxjWujQk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ickqIALaRNNupCRfu+xImTNdfxoBAzrzQRjH8nS68ZKPjxSLKF7JMatLRX7YMDBKNPGMRRPukyIr2FHZlM05RsjKGL3TPZyfViwOWSjVpP/8+z57+hHoJ9YYQAtKVZ3M4gpEMlsf5bHDvVRBFls3av19t6l7oVC9GEXufo4uDMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mb8oSsw+; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/mb0hjUDUcET4+/IYt7L1Cd08U3Vw7EqzIaFVkWSCzTv8s6Jlbcc4ZQT1kE+t4jM5jvR+rQzOUWiq6MkBa1zDyaBWEWYSl+SOYDW14mHEVSrg+DXAc5EPeZLCtxw3xvSFmI57Zkhp4HxJBsG5X0oUrbTX40Rn3RhKg8X62P0YcWvo5Ph0/RHV+K3YeqYy8gixEPrt4jp+0k5e/G1flAd9EjQWpsufrL3qKAJoBcMG/wijAb35NZEOFsV4hircHqID4GLx5JniE2hUhAsO3ewFbvt4pv1alXfyQAsWSJI2lE88mq/iR6gaj3RMuvu7W6c4fbqJ/sCcvXVRWpL5RPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cljH/MZQv4hk/oDtJIRmhwOFmglVC/UKcK2FjDTLHAM=;
 b=piSKVR3ImwrgA0G4ezXz+v4ppKWivXMzkc19st5l+XYCQ9ueo0xg1frSz8dUx4MXiVI6mYLWwcL06FYJQF4iNHwdkrxfNUvs9VKIY2VHqVI47m9OP6ZlJshFq27Mx1YbehiQiez5rF21w12PL59Cw+FwBBixxjW/1+fO2BR9eMm716xz4CZjIog6Z9ObvqXSmiIctGqex6/EyJSxAMl2LzKbgRNd3eM1Wx9qHJxVkQ1RsnNQ57bEv7vj7ps365x0C5cqLwNEzLiFnkmglDDFK3zebrrYib074IuC7MrZgL1k7oBufFkw5BFQyIEgciRaXOuT17VzJxUxtyqQHGFzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cljH/MZQv4hk/oDtJIRmhwOFmglVC/UKcK2FjDTLHAM=;
 b=mb8oSsw++hVQdq4bA8eOMZqlCl4t2nmS/obiQs9tpfz9hDtR+xl/TOudAQ47RwDlyQhzbF0/20HTBsc3tMYCnHDnpzhHiItoBhVrTK6n6oXgbPwA8qtLJiiTAYXwCOeJMyu9kXn5a9eXWCevNEJYevbjBQW33EeUQOjTb+AnhDb8ejtzU1NPDx0A1TtMMncsA5ZHErc6qfWucdk/hlCVITweLbkM800UGdQ9AJ8EDEZjOpb+VMbECBmEUw8lAbIykt870cMohVzANxTNAqsbilo/Odzqbck7Dq3AmckIZKqSPOWFEl1FEOSakNYwjhVMQZUODS+ee6CTeeQ8SAon7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:45:22 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:45:21 +0000
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
Subject: [PATCH V7] acpi/prmt: find block with specific type
Date: Wed,  9 Oct 2024 14:45:17 +0800
Message-ID: <20241009064517.2678456-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 179ff31e-ec85-4e53-17a9-08dce82df20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCRsm9SVFTtmzBbU4UJaW8dMJoo5zL5u9RCFEMSJzcEVMTwEtgeWfZaXdDYg?=
 =?us-ascii?Q?d8Zw8KqkBIxwPWd+Zr9nYFssgOVBzr9Z+xph+5akoPhfk/paj6YqpVTsUZok?=
 =?us-ascii?Q?lCT9NcdRfMfac2jsd7E4WU54QYXphRXhMFZgmWMxWYUU/CUi3L6/3uSFwXCA?=
 =?us-ascii?Q?ZZca22G1y3sF2zVxOwzvhrQCES62Pi7LemZJJEXHQrL1tprIcvjsQLr5pkx4?=
 =?us-ascii?Q?JQ8Zrvj0K/jTWCBIG2Bxbo4pIyM9VKH11jbJxkNgP3GLj1DTTmLx4OV6xnYc?=
 =?us-ascii?Q?9+R94GmiWGcFaDz2l/UCp1znqyM+jQdvD47fZUYy7ehjaquKIKqcLdLlTPaD?=
 =?us-ascii?Q?ENTdL4rf9dOmRiPE7zHAUYbfoutnEDk5PpfuCIyxOQ9xCNiWODrUhAL4qLqc?=
 =?us-ascii?Q?1DNJsDADj0+5pJbVucrBh+1+YotTJGyn/jc27f2S10lCiv+xokPq83PpqWCt?=
 =?us-ascii?Q?v7Hd61ayv8gBr9fNa7ydtHfa8B+zCtCkfH/GcpNX2A4Su+015iBSCE31c952?=
 =?us-ascii?Q?6yMykYNMtqlGjfKA4Zm5tep184KhF8eo43Aot6Doa9ABseZilVbri02s0dpo?=
 =?us-ascii?Q?LocNmJK0LrxOa+JXSsORPAfiJb5hBNwdqlY/9xTOldYyN1jh4CwuMqoXHhRJ?=
 =?us-ascii?Q?nAPfUS6JhDXnaeU0ZU6K+VP08oJAKEr6VAq7qmYdYx7GQtI8ahD61ARlnbal?=
 =?us-ascii?Q?FYm5r3Wwe7NCA6vq7VQ7NEpZcntRam2gJqPnE+XioHxYXi7FE7wT1bACeDyy?=
 =?us-ascii?Q?ByiVXt+NuANjkjWkFcHbDSkW49OOIwU4NaA/eB5UXgfJuRfnV/RRl7PNBdyA?=
 =?us-ascii?Q?7LB+aAGH/aUsp+1XhKS6i6ZN3yeeJOpUcfYy3HeVLQV4n8O9pgNkPL7ddqL0?=
 =?us-ascii?Q?wXxI1x2ihg3Cr5Xs3A449lSykLVmKO00JUSk9HsncI4hlC9bRWeiZck43Kex?=
 =?us-ascii?Q?RFPIPRfw8H9HRQxTfVwOrI77PsJZwn4Ie1PgeIQ0SevLyhzilQOWhVGSdc7S?=
 =?us-ascii?Q?ZsDrcJ1PBcZOU4s9bFGWLfEgQrkRRwXcqyPHi5g1BlLvXyvpqOOLAi/zUoFT?=
 =?us-ascii?Q?NGb4tLSktNKVEle4kV+jeQxeDUqW0jTTSdRikGSUFfZRjZAU3Ahca5U9jQyp?=
 =?us-ascii?Q?rt2fGQ611QoRUHUhDx0ePr1I89UAKqFiry/czzGaGe+uFFO9qq0jN/KdhmF5?=
 =?us-ascii?Q?XyV9szvWQj+gIQNJdoPPBEKiHnMws/EUKIITJmPHqSPEd98xDToeeRCZ62i4?=
 =?us-ascii?Q?0qMUqPmCdPlemkDBZRVDGBsFTHWVWrkNH4l8n2RIYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UF4LQ1KGa8Tvl/b+izr+W00Mh51DKvv+6luN9Z/uUtYqnrlANkxpBcsEGt5+?=
 =?us-ascii?Q?Bg1NFOxxnYNHscBBdR9l8AICZ9/yIqrWUXIN753eaxO4vN+FdrAb6NT2hudl?=
 =?us-ascii?Q?rJYf1sbyfqpBDStOf12CpQFwzMxCXzg01WJHx9IkylBwSefWMgVXZNWwTTlg?=
 =?us-ascii?Q?ow/dhDlSodmfPI01m0GEp8zOVF/hKDHdtGfqrlrTOCqB4CNKy+mn7LckIYah?=
 =?us-ascii?Q?OcotEtiGQC1zLP/wpHra32IuUfy8PsNNPk+Mtu+dLxfyOL7r/OgFUszNNNd9?=
 =?us-ascii?Q?CCSC5FNr/oSPa8ybwWDllLbiEtf0K4RLtkWrGaw8ded5/XvtwSLrToeKN7yn?=
 =?us-ascii?Q?cw4UI2hgtxJqfpnw7toE0dgd3BM89dpuTtuzJ4eTJBAckiG12gLMJLh5S8Qe?=
 =?us-ascii?Q?pcmIJjQ0JZCnTHnQWNRFfS9lyyVeIwj60HGE6xFxP8ajSbHNBcTSPO8NUHYc?=
 =?us-ascii?Q?i7DNTFqjjTL6EV37w9gNvkUZTx6+v8rGIy5env8qwv4s93htzcU5tSbWe1H8?=
 =?us-ascii?Q?iPmFjlCrz0lmHYjOqZm25oO+LX/UKaxR4ts28wMUi60hy89+14zA3hfyuBKb?=
 =?us-ascii?Q?/HzPr1WK5Y3zoF8zELr60EKjyJniiALDvIjH+r5NjKV2SK+66Ej+Z9rlmr8E?=
 =?us-ascii?Q?dD9iRXdU+W/CabM8qh20i5LkZk9XY1PlrsLy2Sx6yUdp5zCMpVUlDZSXmRu/?=
 =?us-ascii?Q?fRX1nOsQGBethjfgHsbf3MCl4BZQ8ZQfrpouNe49c6aLCV01ZHuVEa09KmHg?=
 =?us-ascii?Q?PWxBKWOvsIuCL0CD847nFyApP2SQGjQdu41NIUiHfHNEyy+163pczJIMlR4q?=
 =?us-ascii?Q?q1sa7dwOl5gxoV8h529veShwyXp11RThBxETjwaIt9h/4Nj8oe5eCjaH7UCU?=
 =?us-ascii?Q?Wks1J5+otKevtEx84f/LnwZNrzP3LsY2DPhhv6TMvf6Exe+d4hsStjr5DwYn?=
 =?us-ascii?Q?nC9M4TddEz8jSaFW0dkTy4V3d25+pmYOpYKDlWVTzZDn4f6Hfnjn2e5iamkZ?=
 =?us-ascii?Q?+oahB38rkV4fyo+OWpnHQ7NGRWCdrhaSpVqn56Cm5JKGW0R0SYKfv6Vkpcm5?=
 =?us-ascii?Q?lV1oTX1v7qsJHxjQAAyvM50QeAJFy9UNXAefyuf3tOGlVoSovaR8fCaqnzy1?=
 =?us-ascii?Q?zdQIa8RiwlUkwiqDuodVExb80wZkfcylgciyu2rAZ2WPZSeLDgRFswFg0p0D?=
 =?us-ascii?Q?E3+7GjBO3zE9DbQrPURjobnqljPHbf0ZWavYrpCzS8+nCXZ/p3DE4XaHAPiE?=
 =?us-ascii?Q?UPYwJay4WrchxizmPx+cR5y9UfwrXGI19JHVtzyyOdsMcISNYapra0tmzQsG?=
 =?us-ascii?Q?m60xTLmeXWDA8OS/7g6umuyH1YmnAFJBNAW30/213M9H65UnSm2p0scKW7ck?=
 =?us-ascii?Q?UXrn+DrSN45tLUXd9MTD/5S/DM4sORyI6p7/UMIfAP6pdp5PVGCYbJ2S187j?=
 =?us-ascii?Q?4Uowe1C4z/vVQ0f0hva5YjWQDJPGFg8CfFCzetZrj6jmXze/fAtmzXUJB1EU?=
 =?us-ascii?Q?GzX9Bhi+cJGUT85oPZMySTAEEpxb1mKUtpz0eVVSOx9c/pETm1hnYNW644a8?=
 =?us-ascii?Q?p0aM7h8hWAwr5JhMlhwDklFTbACUpqvx0Mr0fOsy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ff31e-ec85-4e53-17a9-08dce82df20e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:45:21.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzsH52nEP4zW9dW5y8tthWAiqg5f6UPPFxeWB5nc6j/Un0HvHVMcQEF8acQlaSjCASeyVbV2O46UzR3S3yIWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

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
Signed-off-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
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
---

 drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1cfaa5957ac4..51f5ae3d4350 100644
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
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
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


