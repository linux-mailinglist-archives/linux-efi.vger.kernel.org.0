Return-Path: <linux-efi+bounces-460-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB587847713
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EB21C28ED1
	for <lists+linux-efi@lfdr.de>; Fri,  2 Feb 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD214D45F;
	Fri,  2 Feb 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eIxez5hU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27C14D442
	for <linux-efi@vger.kernel.org>; Fri,  2 Feb 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897237; cv=none; b=SxXuOJsvxmAs/lAzJ91fF8D5SfretftHtVM+WvSNQc7w50SeXJvVNXaYT00e7/ddfHuZvQogk3wiTK6+1uhEp3DaI8W9RkOCn24+8pc7h8VkXzdOywnjecsZAM8R1VRQNpFA1H/DOCDLBV+DJ3ZB2MQLnl6YbbeDBv15sFddkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897237; c=relaxed/simple;
	bh=rOW+QJMgxaki+Zs/59rTQG+pV3s0svR8zftHybnFrCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxI7WMc8ur4HC0RfkI2SN+Xxt78smdTUJbC3hwWp3R5BBoCiP3eBpHe6Eer+3iZENae2UxCfL4jyZDgGK+U/xHDsPv1QqqPfFQiixjwSYa/2VDef0OsdNWAz07n+y7v/GaIAsexoO64MPrUITvihuYa3bY9q6tXUi+Lx40TBMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eIxez5hU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de28744a46so1842889b3a.3
        for <linux-efi@vger.kernel.org>; Fri, 02 Feb 2024 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706897235; x=1707502035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDme6jlnfxJTWCG7qW4Qy8DGvSmakPXAl9L2egvk9Cw=;
        b=eIxez5hUfp9YtpCJbFFsq5rHhz4ETMEgVxD3PyaqapRe+MNvn+FW4F/1PQ3S83IN6Q
         Z6X1KG1LbIVKZ5STLjcROvU40m66iRYZ/9gWL9KI4ECoFyL0zwWc9vHMPxVs9q6sEvLw
         GS/4JaTNu6j6ve5C8MAC5g2cOXUFky2G1F077K1c6RSEaovfRfeW7ruSbqsWaoMiZHhO
         EOHZkoRujQYwUy5aPGvmkT1ux7uVvX1qh0l6n9FjCzakC3z4nXLkew4PqYedL2+aeG4X
         X5r2+awR/z7ZgZoqEz95l/mmLIlRXk+dmWzsK+1/G/U+LbE1acs9GNdTjcYcI6SdlAlX
         DsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897235; x=1707502035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDme6jlnfxJTWCG7qW4Qy8DGvSmakPXAl9L2egvk9Cw=;
        b=CXrtkkyFp5tTykxd5QqpmyD6g9KTN8ldqnImv3u/IGtnXKwn0T2GmBHU14CU8HKVmE
         npXg024Sd37WkUoEebn+WG6rVqzDCVWWQcm7Y/x/YGlwbMueZPUw10C56uBflzfkOzJB
         YR/D6WklIdvMX8CRyuvqvU6j8UhuFmm68AQPBHRiL1f1MBXci/mz2IRgMWdXWLSab3Mb
         BsqZGaJhljIWwWI61I47gGucrn6d3POKCjq00AKo7dTb0sRgp6f9BxKzxFLgTtsHti8N
         a5yKzdR2Vuu288oXp7H+qQAcrOqXMBwO2x3JI0uQHYeXUe54ZKIQ2UfwhdgU5Ripv3C9
         sFbw==
X-Gm-Message-State: AOJu0YzcO3zgCn/K1vnDW7oulY7yuRmSfSI+7UMSAExJlW/w8kQpM9se
	HNlpG06dzTXTveEG8fjpyrFF3T5NDNCd5cfcG2rvnYV3YF8iWxEFa9SqFJFcAisCUbkty/SLAVH
	S
X-Google-Smtp-Source: AGHT+IGApjy1ny5FjS4Gq04ep4ZGH47dxEianIZwB0z+YLgCGzepTGWlWVGFhBvj0Leq9dER0TovMw==
X-Received: by 2002:a05:6a00:2d0b:b0:6de:2f30:9aa5 with SMTP id fa11-20020a056a002d0b00b006de2f309aa5mr10452219pfb.23.1706897235504;
        Fri, 02 Feb 2024 10:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwNs/zU8/SXHjEg5qUkWY+fJgs2JKC5h3bIMxiFY66H4USskIUSM3fOxkdHpyh6sQ4e2yYOdz45C57EARz86REEZiCOCXWbA5Gm0Sypq6v9RBEWN+/mx4GuYvD6I1trxf3wKO1ukvU3hoffX9eTbINn/OcE3cSok4CavXG2l66S+no2C6S9fhUfvsxLFKbFDXcy3TWbq5Aq6sHseHObZF/cMmyc0nLCh8CIDSfRN4magWGtl7jSipLlkKKq5yv2ltHVt83sqeCYfeM
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm1989267pfe.19.2024.02.02.10.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:07:15 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2 2/2] efi: Don't add memblocks for soft-reserved memory
Date: Fri,  2 Feb 2024 10:07:04 -0800
Message-Id: <20240202180704.808766-3-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202180704.808766-1-abrestic@rivosinc.com>
References: <20240202180704.808766-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding memblocks for soft-reserved regions prevents them from later being
hotplugged in by dax_kmem.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v2: only skip adding memblocks for soft-reserved mem
---
 drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index d4987d013080..a00e07b853f2 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -143,15 +143,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
@@ -196,6 +187,16 @@ static __init void reserve_regions(void)
 		size = npages << PAGE_SHIFT;
 
 		if (is_memory(md)) {
+			/*
+			 * Special purpose memory is 'soft reserved', which
+			 * means it is set aside initially. Don't add a memblock
+			 * for it now so that it can be hotplugged back in or
+			 * be assigned to the dax driver after boot.
+			 */
+			if (efi_soft_reserve_enabled() &&
+			    (md->attribute & EFI_MEMORY_SP))
+				continue;
+
 			early_init_dt_add_memory_arch(paddr, size);
 
 			if (!is_usable_memory(md))
-- 
2.34.1


