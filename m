Return-Path: <linux-efi+bounces-4679-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0079B42957
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A3C685930
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE436C08C;
	Wed,  3 Sep 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je/eXn1s"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2136C079;
	Wed,  3 Sep 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925985; cv=none; b=mUsW3T6Es+cefiS9nnOTxmPxraAQOQCOTpr2fGioPK7bHjC55MPLcy+EeDFBmE21N9jMH20QW/15swI7G0qGcZ4d6x8d6ulHT7ygtIEMMekjXG4fdocCS8rdxSsvjp/MuFhMyEOQspiIEJchPTV6t5l0/VSfrrTMuv0VLL7pUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925985; c=relaxed/simple;
	bh=5/VIQ0YOJj8EBJYFM7fzqfbwO1JII3lxYWLpEwerupo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLwlMnYfmhv3ZxXzl+HN7H6MUecEC2PxIu1TBSp5rfhw9XzSINuV4VZ1lCWflDCLHLZSMKDp0UtH8V30dmb+mYk6UA2V5OpiQEQvIwZueu1Lddy1aAUA4JOAVb/BiwOA9nGo9l6R6V5mf1gKtnp1KDUXAOPg1jTxuzITS/K+LXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je/eXn1s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248d5074ff7so9498375ad.0;
        Wed, 03 Sep 2025 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925983; x=1757530783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXRq4apmEamZdvq2d1xSOZY75J3qH8SSfCfS4DJoIVY=;
        b=Je/eXn1sd7KCB/OSjhKDZCSW5Qi5y2nFFm5S7CrpzGkiMGXjA7uDlXArY+0bZ7pwfu
         iVyClehBrmD1NFxpBGxHKQkMgPDh9ZOY6QJej21b535p9LbsS442/Zm5trUT4k7dK/b3
         ubH/PEzVZ1KCOCmp+lmNEvyWU8j0pRF5blOFuJ91ZDEGKd3GBX4sb26ErAarDQagvdC9
         GEutwmyzsaCXGzg0WTegNDgzaJXqGZKccyEtlyvQi/XamguVPDKVFAuc5/OKugVcWOE0
         5N5i1tSmvtWAIACxyvNQURKWVoJG1XDrXXOK6n6ngQlP6I3M9Bz/JIb5k7H5YxCcQQbD
         zxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925983; x=1757530783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXRq4apmEamZdvq2d1xSOZY75J3qH8SSfCfS4DJoIVY=;
        b=evYDg7mC5g/uLZnnkgHuXcMt3nufsGAf9pd7aaypMmtDw+YPU08B2syQk6bPyscBWr
         UMX+5QxMrNMGdGtYiYp4SntTUFfgcAueQTwLcyGzT5CsGFKS+FAH+RXnSvPkZ/iQPVzo
         hXLmEjAx3pQoR5mrhp5KCA6DZJummcXS+TVN3LUStpAn+xjhVkfswW3P5aRfqZxZ7q9Y
         pm58Xkvqp/2jgQ31DcKIh6t6aKfw9gaMuclLepM8w39wZmxo06wTliqj4ZdK/7EHkt4N
         jXfOeLFZYKulYeNKh3Q4HpSEEoE4+oADtUjnj1BifjRIqQyGgMK1wP6AjYSPHyHS2Ks7
         rIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJ4CG15x11DjMqxREcFQpxWS8RkWUqLO+8TXAValCHtYGucQHlMkRHPAqIaSgh7gok/uyIZ0C6ZbbpQ==@vger.kernel.org, AJvYcCXReZzDaq9bx9KbnbFD0iIHbd3wfNcfFe0zAYAh3NBMWwMyxaYb+1bJ6Zglg4okQcKM+aVLoEUSS1IR@vger.kernel.org
X-Gm-Message-State: AOJu0YzzULMFU84vDIn3Ylp4cV9FIOTe6A1Ty3pEiYwbqrP5pVV7md9d
	+WNXPSS1SAdyG9HrT4p1OI/KKphoc2nqHSwGYSo7ULmmTvxjWy7Ejp3Z
X-Gm-Gg: ASbGncs1SPn4VJEwHU4o99ds2zMDTNH7KzHn292SP2Kixs4MqZiMeXHNC/pLbVm1c6E
	ODdNWn0j4SsDy5oiLBJTljEYjeKSMReKvaYC/vKU0ueyQCmaetO7TU+Yg8hEJGyFa9aP0yAJkSd
	dBH2GIE3OOR1Bhe64ypC57XzhAqZfFI7lHJ0aZVYxeqFk+B89UnaCp6PcvDTT+GaTK8GpdySRQW
	wiACleh0Vi96D+pfUS+j4xUH1o97aU0EAQC+IU4pAg12OLL/vGdHLYtJr1DuY39N02U4fhk22K/
	MXS4vgX1q0UnqrLuRArSVxP9a3If/ut3TAzpijw/VFkRfHksxZnMZk4C8i+1pPUycgg+4iDEKSV
	4ZKY5/ZzP53MBjfusTTXmV2MAq57t2u202ZJOlyCtLScD6wAS8OvODkznRBuBhT+q5c5swxHxl0
	g=
X-Google-Smtp-Source: AGHT+IGnOdoMz4pWaL7qXoMT+R27TwnQ4+tCeRLJ9HFet8fs0efEGIfh6YbGSI9RHeToTjhpbJgt1A==
X-Received: by 2002:a17:902:f688:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-249446d2aa2mr226131105ad.0.1756925983252;
        Wed, 03 Sep 2025 11:59:43 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:42 -0700 (PDT)
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
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 5/7] powerpc: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:19 -0700
Message-ID: <20250903185921.1785167-6-vishal.moola@gmail.com>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index be523e5fe9c5..73977dbabcf2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -780,7 +780,7 @@ static void __meminit free_vmemmap_pages(struct page *page,
 		while (nr_pages--)
 			free_reserved_page(page++);
 	} else
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 }
 
 static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,
-- 
2.51.0


