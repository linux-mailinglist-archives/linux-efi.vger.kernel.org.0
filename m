Return-Path: <linux-efi+bounces-4460-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A9B0D969
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530AA7A900C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB62E1C61;
	Tue, 22 Jul 2025 12:19:45 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021085.outbound.protection.outlook.com [40.107.51.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5755241131;
	Tue, 22 Jul 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186785; cv=fail; b=aTuy17wv6t/rtiONAhckXrBOtD0FOrkmdKfcf2QcCn/wwAJ4Vpf/teTMk/+4vkDW8H57u2UNNldSXyqKRXLxxVIdySkq+xvJF4di0IzCy2z6IrwfQNxCsMZ0Imxe2DtXnvncswmiMnD0HgDeUVdY1sIWkAshqncGvlCjiym8jV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186785; c=relaxed/simple;
	bh=SfgnuxIVS++AAi+y9TF23nsvWYKp/daePXGhsGuN3Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nWCi6KJDA8zyj+NLzlepmZiclkCmCOHJLygQm4MkG1r73VnJobv1XnCSVbCAtYaZXUmyl2qKUdYYYVoggND+DapSBNQxtO6AZSOlVDwTAPh27SFwnItOHjjz+QNEyVvDtWJINjxcFfsYFIfGUpGk70MP9f5C+r7iRW5UmYc33o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com; spf=fail smtp.mailfrom=siqol.com; arc=fail smtp.client-ip=40.107.51.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siqol.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=siqol.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/X+23z1BIJdx+jfPYJ9J9/MMC7efJjheS5ZWH1vIRMdLb5MY3VQydVXl8SjOMgI8GupKt1Rb7LknqEz9s+K5V3sEYiSOLUYblkRUHV6xS00i5Ho/mwdm7CHeb5+1ArGyqRBE5ZdX3CDjqoo5CB5FUemaWVTVD/KaFADx9XtMc6X0NR+ifbrJ8uJbSUmtp/dxHv09TWvFWIY39o11BOkYvlKu55LkhCQv/ro0/Edi5WaemWAyvZcqz17GBeVYEE/sH3LDjK2qc7LIPkUf6m9XIGXw4w/ycfdYKuZh+Ng7DtvpZlSiIA8qG0vTiNB59PjQvcbAvoHu+/Z0oZBYcDz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BbP2jxnFw5lOVZdtvkLlj86FCoXYvQlSnrmf9uld/4=;
 b=cJGt2H3TEOBcmLxOppBKk/LSYeauysX2ZM13zsxEDi++HNBLHUbvUNBBNFfMYKPuuWOXlxDezELgJCE0tp5mbvJLxosAODO/1UbYRXL9HMpXRHcxhnOJSmwGvMhfsGbfCEZkGMJJyI1uHY0wrwbxGj9+9symKnXY6QCh7aEPqjHBymoXw8VjeGUwjvNCF17mKoDUM4XZF1iK4hDlLW68QJX3KCuc0iEKfxnUBgqSO4ulv8d6/GYvv03aMLiQWgagZOkWhXHgL8Pb5Jq8nzUrf6K7UUSupwOxbxX2Kx1oz/jj1RpizcW+iyq5bd7Fo4viVty5MW5kei+zaOzXWAx59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siqol.com; dmarc=pass action=none header.from=siqol.com;
 dkim=pass header.d=siqol.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siqol.com;
Received: from PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::ac)
 by PN2PPFD76E1DA34.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::14e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 12:19:38 +0000
Received: from PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 ([fe80::dbab:5ea2:1e63:5fe9]) by PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 ([fe80::dbab:5ea2:1e63:5fe9%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 12:19:37 +0000
From: Dishank Jogi <dishank.jogi@siqol.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jens Axboe <axboe@kernel.dk>,
	linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dishank Jogi <dishank.jogi@siqol.com>,
	Manish Narani <manish.narani@siqol.com>
Subject: [PATCH] Fixed several coding style issues in the efi driver as reported by checkpatch.pl:
Date: Tue, 22 Jul 2025 17:49:27 +0530
Message-Id: <20250722121927.780623-1-dishank.jogi@siqol.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::ac)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF6710BA041:EE_|PN2PPFD76E1DA34:EE_
X-MS-Office365-Filtering-Correlation-Id: abfe4043-be99-4da9-4cd6-08ddc91a06c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|52116014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cjQ0AHyAFMleMSruiQS/FyVlwyvcFceFmO4+nKRpAElUfSpJNKzNdgLrifiS?=
 =?us-ascii?Q?PdBFjDrgEcAEa8uVLHo3MbXrWz16HOi4YaQ92XoklHzOZob1Af6e9a5TFsNk?=
 =?us-ascii?Q?YsPeWe0Rcc9hF+hf08aJZ4iL15EYfySxSKdAwMeWFjGllQy6TO4gZhPAvRmd?=
 =?us-ascii?Q?h2qW6Oo3eNry2metMjDcjYd6iHWyQtmG/ut3Jhs3SyohyTW8/57PtqyJxLQQ?=
 =?us-ascii?Q?toWOuZfv07DFA7FebRXF94PMv+IOhdy7pt6TWjMzGFOCSY4djftBvt94o/B9?=
 =?us-ascii?Q?PalVmE2Qv1d8EPcW7pqzRj3j4O99gF4yfaDbTcYSn33QYeWguDGtNOe9/kaD?=
 =?us-ascii?Q?4eB1sjpix1WcKyExpNhNNtkdmab4l/86V9TtDJZLu4MO6zIGuLYhmA3ns+9S?=
 =?us-ascii?Q?gsHK/O9RhsWW6Cg0dBoR9O9xgmSWCV+7BKzsnyFq4124H3P1Uy7edp8fCnxY?=
 =?us-ascii?Q?OWHCvw7WNVO//svWjke6RPOblMD/Z+mFF2BIrPow4bPMjN8//tQ2hCg9tHvk?=
 =?us-ascii?Q?elv1Y7phejSVzh4vPaQFdtqtXx1s+MMb21XPb1g3r3a+Nht9Q0bFHkql5VMX?=
 =?us-ascii?Q?iVDPfPTlQCNckbtRlJC2RTEKqF9cZZ2g23c3TuP99HBINvJz9UE6q0gpLy4S?=
 =?us-ascii?Q?jGiDv7uFpb4B+IQqROd1BcTrPS5B3jwPripGEjEPPXQ++wEOazrtLjjW8rgC?=
 =?us-ascii?Q?/EomECoClB11kutNGy39WXj0SJRkV0uTR67GnudI26ozE99bLNXCz3a0VCHn?=
 =?us-ascii?Q?pDRIJ51I1S4jKwuRuQ2RAN2k9ATSQ3EUOMZtInSBUNqJH/yMzDvJ0YjBFk2n?=
 =?us-ascii?Q?7vCuR5SEitVHkVyK8h6WONoAvcThF/Yv/0VJXmJwKpw62yb6+KGRVRUMHLRn?=
 =?us-ascii?Q?Df2fGRT8lyyKjnYgKnLssakRYPkNy4F4PZNhU9s8YF7cLXHGgNAPtlaFUZ5o?=
 =?us-ascii?Q?HyHoZhbo4pKCaPDgYPiR11wHnIFdLPnQL6dxB+OjbptxrhzTMu8ogSTiR79M?=
 =?us-ascii?Q?z9XddsWpDWe1T3sOAvC4vqGI6wnXTebDQ6eL+fYquGEA1D6LPATis4c+ZI5L?=
 =?us-ascii?Q?hIaZ7D42GnfuQF+gRnTHoQAA3S4a99rbpwI1NM78er6agDZq+8tQ31Ur59aH?=
 =?us-ascii?Q?fixAd+M/NVt+9k+0t/rsUa9qForeDYPkU06NwD9O3xzP97XQcVMXcNTE4mX5?=
 =?us-ascii?Q?6DDPDuHabjaeM1KTOLBv9zz8LEsJYFQCgx9abue6fLowJ30mJxiwk7G6e2PT?=
 =?us-ascii?Q?A0VUb08hA9AIfdLWxlKnYQZaRNA1VjkZOdeyu7GTM+hJ+dhS9pWLZ/HA0nvz?=
 =?us-ascii?Q?pDoRV3oPwAd7vWEbrzxw8XV1VEO0KtPo8t5EzFvZ372wGbX2ijCCRXNzzMte?=
 =?us-ascii?Q?vYSg7AekIKAwWSYrilSRWEb7pRg6ipIoq4MjU9zayfu/lyLdYhFs7CAs5xgV?=
 =?us-ascii?Q?mEsxc/QJyVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(52116014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZBm85jQwqRL3IPd/vwFsOXFh4h0kEJi0krO7AL049BuW7HWeBpPt5DJ02Xq?=
 =?us-ascii?Q?TXtqLpFWc0B6EOnNfusrxMh2hSOnVDb/1/IQprLbWZbsGt8qXZLpA8i29I8Z?=
 =?us-ascii?Q?MsVZh29gsGMzPMCyqmABPn61QFtbzbFniKpnTMmFhLlm9qUgdbymJBsKSP/C?=
 =?us-ascii?Q?RgK4s+mdq4cPpmYZ0YeRgrji4cUU5mg7C7bsZMM73gXUPiJYqPFTqZ1miW4z?=
 =?us-ascii?Q?uD6xfYAKgG+NzHyhqf4f6wkzyUnMMPdS0F7beWupO2AlMaSQiS/TU+SPE1Ov?=
 =?us-ascii?Q?58b5Zmvu5GBZS69dKT3ozvgY0oulEWiAwNyV14atE7ZckpLAiRgtEqVR5akM?=
 =?us-ascii?Q?rwSSsZI0ytVVEQBGpUf53cKgrDxFcWaHWXYieCeyjKvE8XaYtamG1EkYNsdS?=
 =?us-ascii?Q?4oIEFkmK+BbV0sQegY/r68hGr3jLMwuL/uBUJ1m23OvnJAC+PHDpE55q0gKv?=
 =?us-ascii?Q?OJwyPXGlBPe1Tm0PUWAKYi2awC39eYarGNyp+F4Wmop6ukzcqmBz/McUKD78?=
 =?us-ascii?Q?b5nuAlWvRJb/wbQxYAKIxZ0idP7nEdgU1zCAPTSpSSGpApUtASdDjjb26LvH?=
 =?us-ascii?Q?rtsZ30Nm/bAEp49SIX485h6aHsFNMMUGAflsYHKcsmDtVvJhXBWYDNleK630?=
 =?us-ascii?Q?4nZ2qTDW+0gKkS01grQruODyrvzk8CA63z6ABOM6CSOkhqD+S7KuoZxJ9kmy?=
 =?us-ascii?Q?leq3cQHB7cPd4eYByYPIF9BVy+V9nU51cIIr8ulpU6+J6z9Sb2POMu6NH+61?=
 =?us-ascii?Q?NCrusDKQGqUxqmgR1rju7CBDQxT3bIKpDLUusDNyehIIkLYeleWT8hpBy95P?=
 =?us-ascii?Q?tOtOJNSiHM3UbPGZMzR6ivoweLNFNj75uP3LhH3EWMvp3+cDX4GtLHCdyVWR?=
 =?us-ascii?Q?dfZ2E/KxLm5n4oQaZcW7dq3Z+lYrHfWANrm8weAMn9Lyz7syA6sh97+8FjMj?=
 =?us-ascii?Q?4h7V0DXh0MKTKnzaFJBrGQHzZeEWlxO9phKhMCnPqcAkilMZa9qHt7tMnI2B?=
 =?us-ascii?Q?Y8c4X5QwdQUtovb8dXz8U7fUJNpV3uS3YD3XvyYbLAPVDVlWE8YDP9nBjVPs?=
 =?us-ascii?Q?sZC7ct3aMS0rBvmQv11SuE+O55V3QTv3GMSD6gnTFPZi9+9ApXPAIF8i4wCy?=
 =?us-ascii?Q?Uh0C3kxoS/gevDgDOp5lTpdu1eIUBDWu8XzPr3UwYcaHDCobiwk0RhcsJQh6?=
 =?us-ascii?Q?sqVQxMYxdcvzbDoM1zwyLsqFg7Ap58IVxmshXXMYMU6Fp9WLyPlLP8TyKdP8?=
 =?us-ascii?Q?2Xxa838zQ2jTc/9DvMVig/qNPO+5MTrz7b2ut2gfO5fzjdmyvlJBeKKTJGXv?=
 =?us-ascii?Q?IXTBdj83gCHIqrH9e8UGyC0uem2dJ1U0uOVm+/Z6jnka/M3KHWShWewkMeTQ?=
 =?us-ascii?Q?KHNp/QQ3CXDEA8Kdnd412Gwex1AH3tv070W32RHxE/9e6+k+S4yizE3i0SpF?=
 =?us-ascii?Q?oqFJcqP0E/gr0tBFjy61YZKgU5pQE71ksKvJqhf0q5PMgys5PG/HmyMGMyb0?=
 =?us-ascii?Q?u+naMFjIlygJO4xGGn1OUd0dzovu72V9ccY+IL6lva5JhX/jYxkWYA55Rzze?=
 =?us-ascii?Q?JaZ8+ixBM2CMKyHjA7WtjRBPCpRtDNXUXbcmyn9CUk/Mnyps6rGeZVc53CHS?=
 =?us-ascii?Q?T/f++83UcLviYtUaosMcFDHZcTPLze+3p0yEUSzH5H2z?=
X-OriginatorOrg: siqol.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe4043-be99-4da9-4cd6-08ddc91a06c3
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF6710BA041.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:19:37.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e93cdbe6-5a59-4d5d-8570-7b6ea0400c3e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHOkSxOL0Yp+lFJGPi2dZufxFTGxmZuOhM/OBv1O86KvKhXQi26xO/mlRmSw4K46etr0jNfBHcvX1vg5tsR/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFD76E1DA34

- Moved assignments out of 'if' conditions.
- Removed trailing whitespaces.
- Fixed indentation and spacing inconsistencies.
- Replaced 'unsigned' with 'unsigned int'.

These changes improve readability and follow kernel coding style guidelines.

Reviewed-by: Manish Narani <manish.narani@siqol.com>

Signed-off-by: Dishank Jogi <dishank.jogi@siqol.com>
---
 block/partitions/efi.c | 153 +++++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 73 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 7acba66eed48..c821ad07a80c 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -23,7 +23,7 @@
  * - Ported to 2.5.7-pre1 and 2.5.7-dj2
  * - Applied patch to avoid fault in alternate header handling
  * - cleaned up find_valid_gpt
- * - On-disk structure and copy in memory is *always* LE now - 
+ * - On-disk structure and copy in memory is *always* LE now -
  *   swab fields as needed
  * - remove print_gpt_header()
  * - only use first max_p partition entries, to keep the kernel minor number
@@ -40,7 +40,7 @@
  * - moved le_efi_guid_to_cpus() back into this file.  GPT is the only
  *   thing that keeps EFI GUIDs on disk.
  * - Changed gpt structure names and members to be simpler and more Linux-like.
- * 
+ *
  * Wed Oct 17 2001 Matt Domsch <Matt_Domsch@dell.com>
  * - Removed CONFIG_DEVFS_VOLUMES_UUID code entirely per Martin Wilck
  *
@@ -65,7 +65,7 @@
  *
  * Wed Jun  6 2001 Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
  * - added devfs volume UUID support (/dev/volumes/uuids) for
- *   mounting file systems by the partition GUID. 
+ *   mounting file systems by the partition GUID.
  *
  * Tue Dec  5 2000 Matt Domsch <Matt_Domsch@dell.com>
  * - Moved crc32() to linux/lib, added efi_crc32().
@@ -110,7 +110,7 @@ __setup("gpt", force_gpt_fn);
  * @len: length of buf
  *
  * Description: Returns EFI-style CRC32 value for @buf
- * 
+ *
  * This function uses the little endian Ethernet polynomial
  * but seeds the function with ~0, and xor's with ~0 at the end.
  * Note, the EFI Specification, v1.02, has a reference to
@@ -125,7 +125,7 @@ efi_crc32(const void *buf, unsigned long len)
 /**
  * last_lba(): return number of last logical block of device
  * @disk: block device
- * 
+ *
  * Description: Returns last LBA value on success, 0 on error.
  * This is stored (by sd and ide-geometry) in
  *  the part[0] entry for this disk, and is the number of
@@ -240,12 +240,13 @@ static size_t read_lba(struct parsed_partitions *state,
 		(queue_logical_block_size(state->disk->queue) / 512);
 
 	if (!buffer || lba > last_lba(state->disk))
-                return 0;
+		return 0;
 
 	while (count) {
 		int copied = 512;
 		Sector sect;
 		unsigned char *data = read_part_sector(state, n++, &sect);
+
 		if (!data)
 			break;
 		if (copied > count)
@@ -253,7 +254,7 @@ static size_t read_lba(struct parsed_partitions *state,
 		memcpy(buffer, data, copied);
 		put_dev_sector(sect);
 		buffer += copied;
-		totalreadcount +=copied;
+		totalreadcount += copied;
 		count -= copied;
 	}
 	return totalreadcount;
@@ -263,7 +264,7 @@ static size_t read_lba(struct parsed_partitions *state,
  * alloc_read_gpt_entries(): reads partition entries from disk
  * @state: disk parsed partitions
  * @gpt: GPT header
- * 
+ *
  * Description: Returns ptes on success,  NULL on error.
  * Allocates space for PTEs based on information found in @gpt.
  * Notes: remember to free pte when you're done!
@@ -278,7 +279,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 		return NULL;
 
 	count = (size_t)le32_to_cpu(gpt->num_partition_entries) *
-                le32_to_cpu(gpt->sizeof_partition_entry);
+		le32_to_cpu(gpt->sizeof_partition_entry);
 	if (!count)
 		return NULL;
 	pte = kmalloc(count, GFP_KERNEL);
@@ -288,7 +289,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
 	if (read_lba(state, le64_to_cpu(gpt->partition_entry_lba),
 			(u8 *) pte, count) < count) {
 		kfree(pte);
-                pte=NULL;
+		pte = NULL;
 		return NULL;
 	}
 	return pte;
@@ -298,7 +299,7 @@ static gpt_entry *alloc_read_gpt_entries(struct parsed_partitions *state,
  * alloc_read_gpt_header(): Allocates GPT header, reads into it from disk
  * @state: disk parsed partitions
  * @lba: the Logical Block Address of the partition table
- * 
+ *
  * Description: returns GPT header on success, NULL on error.   Allocates
  * and fills a GPT header starting at @ from @state->disk.
  * Note: remember to free gpt when finished with it.
@@ -307,7 +308,7 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 					 u64 lba)
 {
 	gpt_header *gpt;
-	unsigned ssz = queue_logical_block_size(state->disk->queue);
+	unsigned int ssz = queue_logical_block_size(state->disk->queue);
 
 	gpt = kmalloc(ssz, GFP_KERNEL);
 	if (!gpt)
@@ -315,7 +316,7 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 
 	if (read_lba(state, lba, (u8 *) gpt, ssz) < ssz) {
 		kfree(gpt);
-                gpt=NULL;
+		gpt = NULL;
 		return NULL;
 	}
 
@@ -340,7 +341,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 
 	if (!ptes)
 		return 0;
-	if (!(*gpt = alloc_read_gpt_header(state, lba)))
+	*gpt = alloc_read_gpt_header(state, lba);
+	if (!*gpt)
 		return 0;
 
 	/* Check the GUID Partition Table signature */
@@ -427,7 +429,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		goto fail;
 	}
 
-	if (!(*ptes = alloc_read_gpt_entries(state, *gpt)))
+	*ptes = alloc_read_gpt_entries(state, *gpt);
+	if (!*ptes)
 		goto fail;
 
 	/* Check the GUID Partition Entry Array CRC */
@@ -475,69 +478,74 @@ is_pte_valid(const gpt_entry *pte, const u64 lastlba)
  *
  * Description: Returns nothing.  Sanity checks pgpt and agpt fields
  * and prints warnings on discrepancies.
- * 
+ *
  */
 static void
 compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 {
 	int error_found = 0;
+
 	if (!pgpt || !agpt)
 		return;
+
 	if (le64_to_cpu(pgpt->my_lba) != le64_to_cpu(agpt->alternate_lba)) {
 		pr_warn("GPT:Primary header LBA != Alt. header alternate_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->my_lba),
-                       (unsigned long long)le64_to_cpu(agpt->alternate_lba));
+			(unsigned long long)le64_to_cpu(pgpt->my_lba),
+			(unsigned long long)le64_to_cpu(agpt->alternate_lba));
 		error_found++;
 	}
 	if (le64_to_cpu(pgpt->alternate_lba) != le64_to_cpu(agpt->my_lba)) {
 		pr_warn("GPT:Primary header alternate_lba != Alt. header my_lba\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->alternate_lba),
-                       (unsigned long long)le64_to_cpu(agpt->my_lba));
+			(unsigned long long)le64_to_cpu(pgpt->alternate_lba),
+			(unsigned long long)le64_to_cpu(agpt->my_lba));
 		error_found++;
 	}
+
 	if (le64_to_cpu(pgpt->first_usable_lba) !=
-            le64_to_cpu(agpt->first_usable_lba)) {
+		le64_to_cpu(agpt->first_usable_lba)) {
 		pr_warn("GPT:first_usable_lbas don't match.\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->first_usable_lba));
+			(unsigned long long)le64_to_cpu(pgpt->first_usable_lba),
+			(unsigned long long)le64_to_cpu(agpt->first_usable_lba));
 		error_found++;
 	}
+
 	if (le64_to_cpu(pgpt->last_usable_lba) !=
-            le64_to_cpu(agpt->last_usable_lba)) {
+		le64_to_cpu(agpt->last_usable_lba)) {
 		pr_warn("GPT:last_usable_lbas don't match.\n");
 		pr_warn("GPT:%lld != %lld\n",
-		       (unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
-                       (unsigned long long)le64_to_cpu(agpt->last_usable_lba));
+		(unsigned long long)le64_to_cpu(pgpt->last_usable_lba),
+		(unsigned long long)le64_to_cpu(agpt->last_usable_lba));
 		error_found++;
 	}
 	if (efi_guidcmp(pgpt->disk_guid, agpt->disk_guid)) {
 		pr_warn("GPT:disk_guids don't match.\n");
 		error_found++;
 	}
-	if (le32_to_cpu(pgpt->num_partition_entries) !=
-            le32_to_cpu(agpt->num_partition_entries)) {
+	if (le32_to_cpu(pgpt->num_partition_entries)
+			!= le32_to_cpu(agpt->num_partition_entries)) {
 		pr_warn("GPT:num_partition_entries don't match: "
-		       "0x%x != 0x%x\n",
-		       le32_to_cpu(pgpt->num_partition_entries),
-		       le32_to_cpu(agpt->num_partition_entries));
+		"0x%x != 0x%x\n",
+		le32_to_cpu(pgpt->num_partition_entries),
+		le32_to_cpu(agpt->num_partition_entries));
 		error_found++;
 	}
+
 	if (le32_to_cpu(pgpt->sizeof_partition_entry) !=
-            le32_to_cpu(agpt->sizeof_partition_entry)) {
-		pr_warn("GPT:sizeof_partition_entry values don't match: "
+			le32_to_cpu(agpt->sizeof_partition_entry)) {
+			pr_warn("GPT:sizeof_partition_entry values don't match: "
 		       "0x%x != 0x%x\n",
-                       le32_to_cpu(pgpt->sizeof_partition_entry),
+		       le32_to_cpu(pgpt->sizeof_partition_entry),
 		       le32_to_cpu(agpt->sizeof_partition_entry));
 		error_found++;
 	}
 	if (le32_to_cpu(pgpt->partition_entry_array_crc32) !=
-            le32_to_cpu(agpt->partition_entry_array_crc32)) {
+			le32_to_cpu(agpt->partition_entry_array_crc32)) {
 		pr_warn("GPT:partition_entry_array_crc32 values don't match: "
 		       "0x%x != 0x%x\n",
-                       le32_to_cpu(pgpt->partition_entry_array_crc32),
+		       le32_to_cpu(pgpt->partition_entry_array_crc32),
 		       le32_to_cpu(agpt->partition_entry_array_crc32));
 		error_found++;
 	}
@@ -559,7 +567,6 @@ compare_gpts(gpt_header *pgpt, gpt_header *agpt, u64 lastlba)
 
 	if (error_found)
 		pr_warn("GPT: Use GNU Parted to correct GPT errors.\n");
-	return;
 }
 
 /**
@@ -594,8 +601,8 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 		return 0;
 
 	lastlba = last_lba(state->disk);
-        if (!force_gpt) {
-		/* This will be added to the EFI Spec. per Intel after v1.02. */
+	if (!force_gpt) {
+	/* This will be added to the EFI Spec. per Intel after v1.02. */
 		legacymbr = kzalloc(sizeof(*legacymbr), GFP_KERNEL);
 		if (!legacymbr)
 			goto fail;
@@ -614,12 +621,13 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 
 	good_pgpt = is_gpt_valid(state, GPT_PRIMARY_PARTITION_TABLE_LBA,
 				 &pgpt, &pptes);
-        if (good_pgpt)
+	if (good_pgpt)
 		good_agpt = is_gpt_valid(state,
-					 le64_to_cpu(pgpt->alternate_lba),
-					 &agpt, &aptes);
-        if (!good_agpt && force_gpt)
-                good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
+					le64_to_cpu(pgpt->alternate_lba),
+					&agpt, &aptes);
+
+	if (!good_agpt && force_gpt)
+		good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
 
 	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
 		sector_t agpt_sector;
@@ -631,39 +639,38 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 						 &agpt, &aptes);
 	}
 
-        /* The obviously unsuccessful case */
-        if (!good_pgpt && !good_agpt)
-                goto fail;
+	/* The obviously unsuccessful case */
+	if (!good_pgpt && !good_agpt)
+		goto fail;
 
-        compare_gpts(pgpt, agpt, lastlba);
+	compare_gpts(pgpt, agpt, lastlba);
 
-        /* The good cases */
-        if (good_pgpt) {
-                *gpt  = pgpt;
-                *ptes = pptes;
-                kfree(agpt);
-                kfree(aptes);
+	/* The good cases */
+	if (good_pgpt) {
+		*gpt  = pgpt;
+		*ptes = pptes;
+		kfree(agpt);
+		kfree(aptes);
 		if (!good_agpt)
-                        pr_warn("Alternate GPT is invalid, using primary GPT.\n");
-                return 1;
-        }
-        else if (good_agpt) {
-                *gpt  = agpt;
-                *ptes = aptes;
-                kfree(pgpt);
-                kfree(pptes);
+			pr_warn("Alternate GPT is invalid, using primary GPT.\n");
+		return 1;
+	} else if (good_agpt) {
+		*gpt  = agpt;
+		*ptes = aptes;
+		kfree(pgpt);
+		kfree(pptes);
 		pr_warn("Primary GPT is invalid, using alternate GPT.\n");
-                return 1;
-        }
+		return 1;
+	}
 
  fail:
-        kfree(pgpt);
-        kfree(agpt);
-        kfree(pptes);
-        kfree(aptes);
-        *gpt = NULL;
-        *ptes = NULL;
-        return 0;
+	kfree(pgpt);
+	kfree(agpt);
+	kfree(pptes);
+	kfree(aptes);
+	*gpt = NULL;
+	*ptes = NULL;
+	return 0;
 }
 
 /**
@@ -715,7 +722,7 @@ int efi_partition(struct parsed_partitions *state)
 	gpt_header *gpt = NULL;
 	gpt_entry *ptes = NULL;
 	u32 i;
-	unsigned ssz = queue_logical_block_size(state->disk->queue) / 512;
+	unsigned int ssz = queue_logical_block_size(state->disk->queue) / 512;
 
 	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
 		kfree(gpt);
@@ -727,7 +734,7 @@ int efi_partition(struct parsed_partitions *state)
 
 	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
 		struct partition_meta_info *info;
-		unsigned label_max;
+		unsigned int label_max;
 		u64 start = le64_to_cpu(ptes[i].starting_lba);
 		u64 size = le64_to_cpu(ptes[i].ending_lba) -
 			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
-- 
2.25.1


