Return-Path: <linux-efi+bounces-4675-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB2B42938
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 20:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF8541716
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED6369337;
	Wed,  3 Sep 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdDmabG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79675369320;
	Wed,  3 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925977; cv=none; b=AOKo1snXsNjgfrl3JU7pVSmXq4IP7Kw2MAcXvnyABBemR+iNlFYOo/OQDYG6fayO57wCGRMTVgWTRdD/oA0C3Vfi54rCJpzQT1pTU0amY+vryUP+6A79BIfAJPM1TWHZqBwVzuPzc9ES6Duw4JMwsAYkQwV7s+qUacr7DnEOPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925977; c=relaxed/simple;
	bh=LTLVF+hMZyPv1dZXihuaUEnmBeqbcuLCGvLuGg2qrsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IenNKbZziH56MQQdcAqpkcTwzWzPL/J9lraILOjB9+tI2NB57WqU5e8YvEJHgiXPkOHEcYEAzHhMsxUZMBPv2d9tFkutLXS0oe145qhUa2aRSJRXenx5J9UsVSNAJ3yPv5cP/8xxOs/oZ0l891odqNw78Y3m17GO5Lmyrkcs/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUdDmabG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b28de798cso2143785ad.0;
        Wed, 03 Sep 2025 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925976; x=1757530776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg3vWTOesz5aa5s3lECf1v2j8z5ZoWgWQOpdmwDONGE=;
        b=FUdDmabGPE+tniO/0FSqPMFzk6UhnldQNdPj+iTXRFlwHhghyCoXBWtQiKzDZuNqdS
         fTBUHXWXDOWYMegwMDajmhI0o9OXkpPlYqDg6ZgzflUhwht1gHTnPYA6Qw7CvkTW0my6
         uZ8CQXtzq3TQrKW+u0EXCgpJ0QOh8NB+H9NDaabmXKORNDic0fatcciAeMHqGVVZpiJr
         8XzEO1kN48+RQwJmDZY21Gj4VKeBfOdZBkxewMF9M8iHaLOFX7DtAk+eu800sCNdIwTq
         Z2xRPPaiOmxdwpnP/8WfnuqoK8TqRAUqNVshyfsRPK5x3lXy8EGKyH8A1Ug/f1vCBQCB
         vCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925976; x=1757530776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg3vWTOesz5aa5s3lECf1v2j8z5ZoWgWQOpdmwDONGE=;
        b=eCSg7I0JWCVZFO6ISp5AIct5XfMyBGZAN8yNDXuKUcjFHloVsGnDEwH4aEkrYOj30L
         NU1FxiWMreenl0QK8nX5xoC2uubP4m4F1AUnfQcKiYlUkRFuA1pkdBqg9zP6KE1+TGSo
         LkPtG7/8OK7TCebTtyLQEadr8kPfoNN0MBQFdW3TEqhFzY1XV3N+NaN9AaG2XD39V9CA
         jhyoO9gtT270YhPZmze03vnopoUEuRrcXmPL9vCxSEalfenUe4pvZdEGuuXtrNwa47bm
         mkaDzN3iTgCNzPjz1F8T0GqvaJPFJlkbS2Dlo5epk98jRJ4iTWdrYtVbE+uJrlha192j
         RpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sA/WYIQ0OOl3U2zCUGEGfN+IqJebkgA+0QZEutgGlj3VK+5LwpY2yCxkmjt9L3vJlBpLyt6gyTeX@vger.kernel.org, AJvYcCUMugDiufO9KE+ClDdNiVuGQx/wS6o8GNiHxNdbwX/w9aowtXIGN1iXSdia0BEP2RqbpmT+ABCRrtInxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEq3eLFXIv+J3eaImlFie0gUsa0KH9l9ndT2/ahxIaZNDUDUY
	K3ASBg7SncCj2VCHmLcrQur/8ICu1G0ADeFgITrFAyDm5vGrYYPA/LLu
X-Gm-Gg: ASbGncsPjSpD103QuuBd5YnbodMLSA5lKPqmNQISjVv4iFMiYxA1D8fjYLV/M8gApbm
	WOGAgr85ohhd4fNsH2gsRlw9GBeGa1nmZbB1InOTd2OIip9vDzFQd4jkNYbhmj8ZkTsev0dq9Fs
	tHidHh2EteFoWo0AP2VgHTdX/DSq+JidXrVAqFiIX49wm+RmWFJM7RplTPI7OqCgL4ZhB7SUp/3
	VkjoUfqAIbgchkl9kpQ8tDfNJYtKrjF9W8qLuQOo4XfEqruHhkhXqfOpP8Hn2oFRDkYITKHbb/H
	nlTg/LJrxahjSa1qVp0CF1s015uDpgIHfhHjUC1T9UIm5iW6VQTUITUG/d3QjFGS22+DgTsTXp1
	OvGK6nbJDKZ50wIhnZIs3D2BOroEAPISXdDawzdAL5yPqEe7oMafBww==
X-Google-Smtp-Source: AGHT+IEDGbdRM9mEhaV+2ag53MUmou+Up6hgUY2vpYZIptsrNmf4dFU9V5zvfqRBlRBpWDsd4n9KQA==
X-Received: by 2002:a17:902:d552:b0:248:fbc1:daf6 with SMTP id d9443c01a7336-24944ad55a3mr207897875ad.43.1756925975667;
        Wed, 03 Sep 2025 11:59:35 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:35 -0700 (PDT)
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Date: Wed,  3 Sep 2025 11:59:15 -0700
Message-ID: <20250903185921.1785167-2-vishal.moola@gmail.com>
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

Add kernel-docs to free_pages(). This will help callers understand when
to use it instead of __free_pages().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c2a254d877f8..0277b86b62ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5269,6 +5269,15 @@ void free_pages_nolock(struct page *page, unsigned int order)
 	___free_pages(page, order, FPI_TRYLOCK);
 }
 
+/**
+ * free_pages - Free pages allocated with __get_free_pages().
+ * @addr: The virtual address tied to a page returned from __get_free_pages().
+ * @order: The order of the allocation.
+ *
+ * This function behaves the same as __free_pages(). Use this function
+ * to free pages when you only have a valid virtual address. If you have
+ * the page, call __free_pages() instead.
+ */
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.51.0


