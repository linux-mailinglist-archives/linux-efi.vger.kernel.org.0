Return-Path: <linux-efi+bounces-5616-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37250C7153B
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E29CF2F9E3
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DE320A10;
	Wed, 19 Nov 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="GkUoEl0B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E2330B14;
	Wed, 19 Nov 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592171; cv=none; b=rpTVZHUugwAWTSZydNYyjPtD5yanw93Z3aDSftD5wz9H8Y4BcXPZNZXDQJJrAsMGRopFS69zUnw7kTzlUATt1n2hJzWRmmNlE3McTVdiZRjzcUcVokImjowlugNx3REljSXBX6vhuVtDa2hMQlroZZPP9qu1gHFibvgHxg0wCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592171; c=relaxed/simple;
	bh=ZZNNuTRuiX53llVmFMgKwGGhIW58g3kFCa2xIK5PUCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0t7jY0T/rfF1FRueCZ8ZlJOzV4HTFTUawUbteJ/pjagJuTKHfpY7qt1ckTkctFLzRz6OOoUjho8wZn5F4COJ21WHRaitzHKEcx9wK/+ramk8ew+OtjBe2BZ2BCA0b3WfwDyZFjS9F9s4r9QkCzvQUEMTkMw7Y/IzHeqeyOnv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=GkUoEl0B; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsw-006kvx-LU; Wed, 19 Nov 2025 23:42:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=Vhn8/vbnFTBTrLe40in1hyrWt+hwUetOS1daXHrGJRI=; b=GkUoEl0BxUcro5HrumgEhz6q7S
	ABk1zCOGPsPuJyp1ZRIagRRuwzkOCh0X4FJqoA+gb+WH43yS/9/fELw+4L+cMrKm286TWzaluczUD
	kmvzWGSBWmdHpO3mEp3toCKbeQ86UNgVPKKUiwQwfOpMaXOExV5xSOVtSklsVRJBUezKxOfJMeT5C
	Sy5jmu2eU1AXBMVmKlNkEb7n13V9qpNc3vRdyP0HdznRtS/x6QzaRGq2rxSzIN9g297yPBdk2jDtM
	WqrenPTlhBjHV2g2szbJ7y0zTVdf/yAXs98gfKaSlJ8/75ShkB42ktGPXLIyvMDkVFbRCGxyhEJ0O
	faXr9lTA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsw-00085q-81; Wed, 19 Nov 2025 23:42:46 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsa-00Fos6-9U; Wed, 19 Nov 2025 23:42:24 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 12/44] block: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:08 +0000
Message-Id: <20251119224140.8616-13-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

(Similarly for max_t() and clamp_t().)

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 block/blk-iocost.c     | 6 ++----
 block/blk-settings.c   | 2 +-
 block/partitions/efi.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..a0416927d33d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2334,10 +2334,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 			else
 				usage_dur = max_t(u64, now.now - ioc->period_at, 1);
 
-			usage = clamp_t(u32,
-				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
-						   usage_dur),
-				1, WEIGHT_ONE);
+			usage = clamp(DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE, usage_dur),
+				      1, WEIGHT_ONE);
 
 			/*
 			 * Already donating or accumulated enough to start.
diff --git a/block/blk-settings.c b/block/blk-settings.c
index d74b13ec8e54..4e0c23e68fac 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -472,7 +472,7 @@ int blk_validate_limits(struct queue_limits *lim)
 		seg_size = lim->max_segment_size;
 	else
 		seg_size = lim->seg_boundary_mask + 1;
-	lim->min_segment_size = min_t(unsigned int, seg_size, PAGE_SIZE);
+	lim->min_segment_size = min(seg_size, PAGE_SIZE);
 
 	/*
 	 * We require drivers to at least do logical block aligned I/O, but
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 7acba66eed48..638261e9f2fb 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -215,8 +215,7 @@ static int is_pmbr_valid(legacy_mbr *mbr, sector_t total_sectors)
 		sz = le32_to_cpu(mbr->partition_record[part].size_in_lba);
 		if (sz != (uint32_t) total_sectors - 1 && sz != 0xFFFFFFFF)
 			pr_debug("GPT: mbr size in lba (%u) different than whole disk (%u).\n",
-				 sz, min_t(uint32_t,
-					   total_sectors - 1, 0xFFFFFFFF));
+				 sz, (uint32_t)min(total_sectors - 1, 0xFFFFFFFF));
 	}
 done:
 	return ret;
-- 
2.39.5


