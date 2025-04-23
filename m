Return-Path: <linux-efi+bounces-3427-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E8A984DA
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF802162389
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C2264A97;
	Wed, 23 Apr 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="mACXAwmz"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84A2641F8;
	Wed, 23 Apr 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399134; cv=none; b=FFNIB+qYlaTr/2TjAw6/YmBmfR2GZPwtXVtJ50lehlgXy9aGHx94ohhtOhMqtWNgd/l+QHIA9wIivbRda4T03EcWtVeJ9mnlUu5UfSabBivuzsQZo01raCuSGg2sld2q4q36zdSkXTxTn4zHtKKfipAUCJiEygdp3QNpmlrdBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399134; c=relaxed/simple;
	bh=5LRmniywZxMxDlI5Oxe49VfAgh8CxFPg1n4DHapt+9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mmjsEVGMh6Dvewu0hPnF7RewXbl67ZJ4MRyvF0KLlGXegnkK/tZSjQ8IlM3+BpKzrmOGzg0yRMPpZtbtKWKVA5DvHwmE5qGO3YROIabGIGn2FIYEa+SpeYdoeqovNhibkQkEMfbvQg3knlH5w2p4NvT5wRmYlwFe4ciBKTh73xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=mACXAwmz; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1745399133; x=1776935133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXlYnAZ24E+gP3h3vZ2maJPRoNj+Qo4OgFh+v0oTL4I=;
  b=mACXAwmzEBH62QT+7z1HtAKbTm4ra2yq33Mo0i9kqETCCSafu2IOjg3a
   qgXUN6WJfxXD6XpVdN3UkoxM9ybCQvUyhXFzOG8J11nyuHRp50wQO+S7y
   uC98lIpmZIcd4X9F3lY+qTA88lsKJNdsY90HtNVreQyvUP04QDZtTZuPx
   c=;
X-IronPort-AV: E=Sophos;i="6.15,233,1739836800"; 
   d="scan'208";a="818324122"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:05:27 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:2286]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.178:2525] with esmtp (Farcaster)
 id e508e646-c623-42bd-acdb-51aeea751e1c; Wed, 23 Apr 2025 09:05:26 +0000 (UTC)
X-Farcaster-Flow-ID: e508e646-c623-42bd-acdb-51aeea751e1c
Received: from EX19D029EUC001.ant.amazon.com (10.252.61.252) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 09:05:25 +0000
Received: from dev-dsk-bsz-1b-e2c65f5d.eu-west-1.amazon.com (10.13.227.240) by
 EX19D029EUC001.ant.amazon.com (10.252.61.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 09:05:23 +0000
From: Bartosz Szczepanek <bsz@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <nh-open-source@amazon.com>, Bartosz Szczepanek <bsz@amazon.de>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] efi: Improve logging around memmap init
Date: Wed, 23 Apr 2025 09:05:16 +0000
Message-ID: <20250423090517.47049-1-bsz@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D029EUC001.ant.amazon.com (10.252.61.252)

Be more informative if memremap fails, and print out physical address
together with size. This change intends to make investigations of such
early failures slightly easier.

Signed-off-by: Bartosz Szczepanek <bsz@amazon.de>
---
 drivers/firmware/efi/memmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 34109fd86c55..f1c04d7cfd71 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -31,31 +31,32 @@
  * Returns: zero on success, a negative error code on failure.
  */
 int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
 
 	phys_map = data->phys_map;
 
 	if (data->flags & EFI_MEMMAP_LATE)
 		map.map = memremap(phys_map, data->size, MEMREMAP_WB);
 	else
 		map.map = early_memremap(phys_map, data->size);
 
 	if (!map.map) {
-		pr_err("Could not map the memory map!\n");
+		pr_err("Could not map the memory map! phys_map=%pa, size=0x%lx\n",
+			&phys_map, data->size);
 		return -ENOMEM;
 	}
 
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
 
 	map.desc_version = data->desc_version;
 	map.desc_size = data->desc_size;
 	map.flags = data->flags;
 
 	set_bit(EFI_MEMMAP, &efi.flags);
 
 	efi.memmap = map;
 
-- 
2.47.1


