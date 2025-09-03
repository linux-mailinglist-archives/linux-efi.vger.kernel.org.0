Return-Path: <linux-efi+bounces-4681-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39796B42955
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9397B63A8
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424236CC99;
	Wed,  3 Sep 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH5TZtlt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230C36CC85;
	Wed,  3 Sep 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925989; cv=none; b=uwrLtsAMC/TM+aTl9FD2jKRbaN2valjFztAy1iaJ/Uf5F7WO25S1vvO1hLWMB6ntvrl7r0r7HxO3t9v0YsPPYRMf09V49jlsNiJwJeFAgneH74hSFTOHPyruwdveUe830SKmcdWA6t94g4vI2VBrFAq6JSHfoJ0R5Aey+w1qcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925989; c=relaxed/simple;
	bh=9inLvC2KfY6Q8SKkB8WqxnCMttpVG+lmNs2hVN/EM80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVPC8/yWbQ2cB+pVaJUAflWjGNSGiAam4Spmo5O3rdKI+pnIrIpKEHKoYqDYKLUpkHkIal96VjVUkDWeh5F16pIww3GvAU/Dm5DqD47kz+2KEkEvpe0Bo6QvVGOLSaKg4GYkp17hNgVnyKmPB7wRBHXpfGd8Ko5Y0eB1Md1oRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH5TZtlt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cbd9d9f09so2648685ad.2;
        Wed, 03 Sep 2025 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925987; x=1757530787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xP13CUGWmP4Epf7561SmRsYIMeFmCIW416h7MJfMP4=;
        b=jH5TZtltE3O0HqiVO1QeAg198hhNZjqdEt9nrl5sCyW5GOZGHrnfoPOAbV1rBcQY9r
         o5xxaYyg8TZdOlFsr83oLnDnvaly56yxV0ILpHgGBnoXO7bXKCIONmOfDObvaGrwKZTd
         a9KoUdQwY+ukYQMOq2un2QlLuQ/xZJqzGwyqDGJx4zRI4q9p/68sgKaCeryi9JSoOVz/
         AeM9ksv8h8iNS+i0U/ApNQVJs3c1XHZxhMaRq8Ls9Xh6OSSY2mEkB5kSrXFvscpZeNbX
         XtPR/0O1Y1JzbZcX+xKkUehHJ3P8kZb4jYo1pTxkrpKVQD5kNcMbEIlliFBjUoDo0u7B
         81XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925987; x=1757530787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xP13CUGWmP4Epf7561SmRsYIMeFmCIW416h7MJfMP4=;
        b=KV2G/RTYV2JyCq0027bYSybFrG7F1zGo/T47KAc8xnlFEptfLatiODMhPgB3HrxnmI
         cCQLA3weZrTgH7xVzoJ7NSE6xcuClwwhXWzxIouiRCW++AXPI5Vj2ePeS4DS5T5n30SA
         Rs/2Gz1FuxkOitOBvfLYNqlOXwDPdj+0rWm2hCaPrzpqOYyC1fCkrc+RAn6clIeIxtdc
         AcXrkH0eGUB+yhmU1LlmDeWQiRLwuI/HWY8Em22a9fbzcCdptCBEq3drqwbnt6Egn3ZC
         5JLgoFWW4USx4Tp0335EgBES3py/+10cRvuTKnidTCxVm4Mlbyn2ziH1zGJmT+LYdW2B
         zLIw==
X-Forwarded-Encrypted: i=1; AJvYcCVGJpufZOa5HXPT0DJFqm4fpHSMdwwJecqRTuCL71S5V1yAanPLBQJsXZQDDcMcRSFUk9BuMnw6wdS0@vger.kernel.org, AJvYcCVwOYa8F9p1g6YWs8RO9xWfvErzNUZo2E8yNn4AHXSx+xd7XGCr1NFPZ23SR/e1/83rzeTWWCxZEvA4hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQTE85XYEo2zrXn8uSkoXP+h7H8D8Izi+zCbnyt48nf8Oc2vh
	YY+eujersF4bERWTez/bixPeJTiRZziD28PlNKt7xNoqeS9V/CNhhIwX
X-Gm-Gg: ASbGncuR9KY1bruuFovqn9jFSWdkB3f2L/UyqT6t2XFTV2zkC/ebw7i5QFsv+z1kdpB
	o+b+kGPKGPFiHKM3rC6g14fzAKRby4xtQeIaTuZ/0ZeEj0dxf2o8DO8y8Xvvs+MbJ9dINAq/k7S
	Xxh8dUIt7m3Q3/K+QvRE9r3E5owrCAxJdb9B6rFlWpQB24PiIfoTA4YFfD++ktGpHpRHO9o5WWf
	D9Y84nttKpe6BhS01WHw5jNLVbFyiTtpZ6QdXVAOhpgZhJqPRlrzzG1FiT5aN2JQr5Mn02WNjpC
	8Yr9O491VioE0HuNNfX6Xir3LbFdbIadTHB6hxIumomAyd+NI43wjcaULhLkjWy6QCuVymJuzZV
	ZhQFq7K/pdVWzwltOAsrWYrRi+IHx3oqHN5ZGhpYULyj2WOXRTni73Tr7oYm9gDYK
X-Google-Smtp-Source: AGHT+IGWl2NVhEd4Mf3PXgbO9PNmoIZrvx3puV/+d96WnhVgMh+tacbQQZaHLdVwJGJAzq5ejH+5QQ==
X-Received: by 2002:a17:902:e5d0:b0:24b:1766:cc70 with SMTP id d9443c01a7336-24b1766d2d6mr89341175ad.39.1756925986861;
        Wed, 03 Sep 2025 11:59:46 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:46 -0700 (PDT)
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:21 -0700
Message-ID: <20250903185921.1785167-8-vishal.moola@gmail.com>
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
 drivers/virtio/virtio_balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index eae65136cdfb..7f3fd72678eb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 		page = balloon_page_pop(&vb->free_page_list);
 		if (!page)
 			break;
-		free_pages((unsigned long)page_address(page),
-			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 	vb->num_free_page_blocks -= num_returned;
 	spin_unlock_irq(&vb->free_page_list_lock);
@@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 	if (vq->num_free > 1) {
 		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
 		if (unlikely(err)) {
-			free_pages((unsigned long)p,
-				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 			return err;
 		}
 		virtqueue_kick(vq);
@@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 		 * The vq has no available entry to add this page block, so
 		 * just free it.
 		 */
-		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 
 	return 0;
-- 
2.51.0


