Return-Path: <linux-efi+bounces-2541-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEADA067AF
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 23:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C76188954B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17220468D;
	Wed,  8 Jan 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azup0wEM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95900202C4F;
	Wed,  8 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373624; cv=none; b=QGxkVLJKVHhw1Ojsnmul1/9Zu/RTX8bc1eHAZUyabHG4qKSTvLOTehb//daevP4vVWN0CK3dlkfjlqtKXaqx8YlqGInYQaqcHPrk1pS7iy3T5sG9hLfwLMKI6HJsqwTojE8GRzQzjBy4u68dfssuSbcxiPKwp1B0f96HCVGPY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373624; c=relaxed/simple;
	bh=sKdBUesYFXBXOsJVW+9q5EMZGhE4RhhZbRAFLUGESZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdRuaHFg1aYGgczOuhiv0trxbgn/pLFENOZXiOmsjV6rfftYcipAi+UiDucqnqu1P+vnJu/hJNtmU9w3NC9kofgUs5LQtHX9kNGm8P4uxTpbfVzCIPjeg4urULNqNK368DKMgyQQgRD2zm2Zw4dBzX4E+lybNu6TuWlW9YqrcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azup0wEM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1b895541so5310836d6.0;
        Wed, 08 Jan 2025 14:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373621; x=1736978421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jr6jtY+a/6uK4MIkuZ3gaQWU+DzTIgpKl/TdDtWvr8=;
        b=azup0wEMnp0OULkFuM0rbEyNHZnPlYw4PhN0B2INZtKzwCfMLjpC/zSp1xoJAZ+hUo
         3Oj8hzFeCirzJRu7d5w4SVLBp1FLVZZwAX8xn0+BAS4taO8KD6Ead4/DwRz4zOHvUFgR
         H53GFQ/ZDXAFz1QeyqlYdgCyf2ZbCairUXsk+l1EWM21swZ/DdIukHL0LTcHERoQRktP
         vk87DVSkpqQ7f2Bo27olPDdUHItVlb7GBGsE5CXmL0sseONmE0tMeZxS2RpO1dUywpMH
         C024O8k3sjGSqTrivuWAoLKfDJhTBH1fROz/yfQOPsuvxo6MyjWQo5HbHNfSNImKpqHc
         yDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373621; x=1736978421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jr6jtY+a/6uK4MIkuZ3gaQWU+DzTIgpKl/TdDtWvr8=;
        b=aZuwQeG4YN1IVuG7UWZs/SSNBe9oCo/e2WpQoMFSncV27nfFo7q8YWWHHYO/Sy9jST
         9o8MChvKALgophBG8kk9EQd5tmxjfRMkAmpXckIXK8bm0Lj6Yx/vxlnl3yOfGVSAcHBz
         m69vq3nh+9+VBi8Pg06Q+QdI5+p8jflYEhvR45mQJ/JWn7sI+yviywju28lxuS7nL5dy
         GtWr67YrNfWd2jWrKUfLaN/bf4syAwfcpiFXAX2NDiuuwCyKFSvZDikmwl9G1r118ixV
         ZXLfpAkGE2GapLhDIuSR7sXOIEh9zuVEAYMcLj5TsCJjPDuh8K7UxFx96bG1hxL5psJh
         QAXg==
X-Forwarded-Encrypted: i=1; AJvYcCWGdF90qAYvXnIqRRRSAzbkI5zLmtCiT38vV0y1Vk+RbvAWY89Qun3H6eteDF7YZ/FJ/qCnFvo13fLxCPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/ZG+y9ZZG2LH0FqoZCFoOR5CfnwmMEzkfAvFOsaPKIo4XvFr
	zFbRknRzBEm34tiaRoYWkwVFNm2WUdRdgiykrF2IUkmq0z6ffRHvtx1ldoMO
X-Gm-Gg: ASbGncvmOK/U74rLI3ABLkibu35Lhv7AJh5zseRZAW+vNk7vEdKYgKgA23jgWnAhHzo
	gb6SHFPIJ8bGbUmIsXyPLPvaIctp4ehQnC3QTBC/j5hOKHLEuZkLE9nWEXzHgBSalrv0kt88WPM
	U86YZHnhILbj609kzo7z6LVmOjsJ54sNNFGUhqNaO3s9yGNy7R7cjApigY6BEvO4EQlnBESuyBF
	SDZUrfHsn8dnvCFdP4rM1dvIzkYdvYJyQOpwqJtZbe8TowzfWWJLRQ=
X-Google-Smtp-Source: AGHT+IGYAtV0NWg+g25XA8prhBZQtnI1Wq2npFdzbcYk2MRvl9G6tk69B/IbxPWv68nknyTKZ78xgA==
X-Received: by 2002:ad4:5d61:0:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6df9b28c6aemr74791756d6.34.1736373619641;
        Wed, 08 Jan 2025 14:00:19 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:40::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd3c151877sm165560896d6.127.2025.01.08.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:19 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	hannes@cmpxchg.org,
	dyoung@redhat.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	gourry@gourry.net,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 1/2] efi/memattr: Use desc_size instead of total size to check for corruption
Date: Wed,  8 Jan 2025 21:53:36 +0000
Message-ID: <20250108215957.3437660-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108215957.3437660-1-usamaarif642@gmail.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in [1] introduced a check to see if EFI memory attributes
table was corrupted. It assumed that efi.memmap.nr_map remains
constant, but it changes during late boot.
Hence, the check is valid during cold boot, but not in the subsequent
kexec boot.

This is best explained with an exampled. At cold boot, for a test
machine:
efi.memmap.nr_map=91,
memory_attributes_table->num_entries=48,
desc_size = 48
Hence, the check introduced in [1] where 3x the size of the
entire EFI memory map is a reasonable upper bound for the size of this
table is valid.

In late boot __efi_enter_virtual_mode calls 2 functions that updates
efi.memmap.nr_map:
- efi_map_regions which reduces the `count` of map entries
  (for e.g. if should_map_region returns false) and which is reflected
  in efi.memmap by __efi_memmap_init.
  At this point efi.memmap.nr_map becomes 46 in the test machine.
- efi_free_boot_services which also reduces the number of memory regions
  available (for e.g. if md->type or md->attribute is not the right value).
  At this point efi.memmap.nr_map becomes 9 in the test machine.
Hence when you kexec into a new kernel and pass efi.memmap, the
paramaters that are compared are:
efi.memmap.nr_map=9,
memory_attributes_table->num_entries=48,
desc_size = 48
where the check in [1] is no longer valid with such a low efi.memmap.nr_map
as it was reduced due to efi_map_regions and efi_free_boot_services.

A more appropriate check is to see if the description size reported by
efi and memory attributes table is the same.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/

Fixes: 8fbe4c49c0cc ("efi/memattr: Ignore table if the size is clearly bogus")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 drivers/firmware/efi/memattr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590..d3bc161361fb 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -40,21 +40,17 @@ int __init efi_memattr_init(void)
 		goto unmap;
 	}
 
-
 	/*
-	 * Sanity check: the Memory Attributes Table contains up to 3 entries
-	 * for each entry of type EfiRuntimeServicesCode in the EFI memory map.
-	 * So if the size of the table exceeds 3x the size of the entire EFI
-	 * memory map, there is clearly something wrong, and the table should
-	 * just be ignored altogether.
+	 * Sanity check: the Memory Attributes Table desc_size and
+	 * efi.memmap.desc_size should match.
 	 */
-	size = tbl->num_entries * tbl->desc_size;
-	if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
-		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
-			tbl->version, tbl->desc_size, tbl->num_entries);
+	if (efi.memmap.desc_size != tbl->desc_size) {
+		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, table desc_size == %u, efi.memmap.desc_size == %lu, table num_entries == %u)\n",
+			tbl->version, tbl->desc_size, efi.memmap.desc_size, tbl->num_entries);
 		goto unmap;
 	}
 
+	size = tbl->num_entries * tbl->desc_size;
 	tbl_size = sizeof(*tbl) + size;
 	memblock_reserve(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
-- 
2.43.5


