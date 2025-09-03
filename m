Return-Path: <linux-efi+bounces-4678-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A85B42951
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7752E683CC9
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101D36C06D;
	Wed,  3 Sep 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ91TEKf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981B369997;
	Wed,  3 Sep 2025 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925983; cv=none; b=JpMvmPGzVLmGW9C1hfx+66N1dKHvXbtxig5kcGTxqUp4qbArbckqFbkDW+oIrYzXUKmjNk7dOWDMe3/XakRsJbV4FAVO2mDPs+96vOEoHwqXkPq3WyqRN/2X/mj9YwxzNJJV9BikGnF26J/euTvCsJ2p29nJmb1HsmuObG8Yduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925983; c=relaxed/simple;
	bh=hMxsFCbfS4FNJ5KpQPQ814MUfYn5DLMes7LkACjORbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV9bG+Cf062mEbqkUeHd9Pb/4yL2VJ/lzO/X1kr3MTcq1yZQW1w4r1HlLULuKgRY1XPhLB7Gv5F1i9uaXbLW8iKBUD0KZn4/y29LcgSeFCGdCyr9+MqYR0YULGWuqzsHNiACq11UmGyGgdd3/nCqYhEGyvc0Qb6+FZClSszC8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQ91TEKf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b2de2e427so2176795ad.2;
        Wed, 03 Sep 2025 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925981; x=1757530781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=fQ91TEKfREvSpboYaze1bALYi46Nf8iBiI9aMo9SPouVlVYMlKily/gFKAhiR+3qOh
         VJmFqI6SJqY5t7yqPn1/sYFBdGT/gRSnXxuO1G/wsjr2KyLt5CIMAD9+0KRhxBk2/edX
         k6LZzg1ELNL03EczVmc0OWP52kcIV9Fe8qiqED2qHiFTTGd4hryG5WjQLBubuUu1MWbM
         fZmAwo6kOxWnfzlxhRJfiD/lYeIgV/QwHvrrzWKFoswA9UUQtvP5D3XPDa+nx1BTg3fF
         d1zfMtcgEknsMQkyqrkc3tMNpKylFCO7P28VSpRVhK5/VWfMwv1X1b8inLxIlNTQdm7J
         KBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925981; x=1757530781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=frb2yk8YMtcmUdDi5Rdruq5XKYKOgbVpTpzPW6DvADtjSzWRCVuiZaK9vlDI0lYfbL
         4ihyDoVoON8rhKnIOO3Je3Ml+zJ3iu8HE/E/E1CJwqAMprAXYSCdjqK7KPw9BiQ+G29b
         TLnln1JwrM4O41/FRl8kpykBZDWXCpsyp9qSASX4bDT6hY4eTUiWu3QtB8lgRVwJaI5b
         ET3IRwqpK+8ONd5cwFy0bsz6+aFhJ4Ejc1pVNsiHGKHOwjLOIeaEmRdbBlYAAM2XR0T9
         53W6/QEgBTtFdZml7vTIuvqqungNcwRINmSN1Z9LRBa7Kb3QRe2gufc201dlLiwGKp6e
         WpJg==
X-Forwarded-Encrypted: i=1; AJvYcCU+YaLxq7xSb2P6tzLhJhEu6Rl8q568FXhAVmVUu3x7XjEPyGh0X/bjyUMJELLbNzNFHA3VtjG6Hzmccg==@vger.kernel.org, AJvYcCWUd1NzWmtgw1AetwLN8RaPyeZbA9OSeupkCwNQevHjwDIaG/LTUl6pMGBdstxYYZ1zTI3EK57kBG6t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bMb0CzCn5EvOgedlHcmRD9w5TsgZ7zMKU3B37wbCd3rAW8Ko
	1tubESGBq5J2VFZIOBC++QdUnIyc4aE/CJ764mvdgsxjOnzTzaFDIqvr
X-Gm-Gg: ASbGncu+Rwo+iab4cuYtdPEyqCLcRSOP5ywLqAQAf6tRvda4zSKg67n4NN55rElvORN
	L8FHB7LAvrOc+Om2+r8WtjT/BYlbrGHwtRgRzxA8+3waZsNtBI1Y2SNoNcFQTclnhM0Zz/3VlKg
	mzB/lYdKx5U+ssGMCrYOE2W6N8jH3eJp3XYDOFwhwifv/JtwU61vkdbeYEJhOJ4a7Kx5Rj1ZRZ7
	bxGjgHBmpLQ/p8sHFvge9rIM8ZWofospuWDaCvkompXGKRfTZdepjoxynLnj4G3Nzw/+4cmyaBS
	Sk/k5g2mM2vqyVPyKioXSkZEHAtNOIDWsMlZW+Km7sHRTW/vpp5e3Lk49ZZVbzWbx7BjkbYXIvN
	ZJ5oa+9GyqCq1C9XQvIpAiokk6w2iDB/kLKSSVoEwWfaKpgPB6w5/peYUSz2BrddH
X-Google-Smtp-Source: AGHT+IFOzZVS9DP4L6Y226muKjeIB1JH5DNA05hxxzbj7ORa/S2amssbHzjMdMYqRSy3xMpxXA++JA==
X-Received: by 2002:a17:902:cecc:b0:24a:aeb6:f1c8 with SMTP id d9443c01a7336-24aaeb6f63bmr166407785ad.43.1756925981346;
        Wed, 03 Sep 2025 11:59:41 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:40 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v3 4/7] riscv: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:18 -0700
Message-ID: <20250903185921.1785167-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5..1056c11d3251 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1624,7 +1624,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
-		free_pages((unsigned long)page_address(page), 0);
+		__free_pages(page, 0);
 	p4d_clear(p4d);
 }
 
@@ -1646,7 +1646,7 @@ static void __meminit free_vmemmap_storage(struct page *page, size_t size,
 		return;
 	}
 
-	free_pages((unsigned long)page_address(page), order);
+	__free_pages(page, order);
 }
 
 static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, unsigned long end,
-- 
2.51.0


