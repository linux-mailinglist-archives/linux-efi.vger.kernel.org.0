Return-Path: <linux-efi+bounces-4680-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA4B4294E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A41C547953
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429436CC73;
	Wed,  3 Sep 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGPgWjwY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B336C098;
	Wed,  3 Sep 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925987; cv=none; b=enw19+TjcrPytOxBiUd4BtRzQvX87m7P5CwPCI64d5lO5R8dYRMWtej2sIYEzJHYEvf6qonC4kITxvarFSHM+l9jGayNYwUPgvBGqCYyynZYkSwEHJe4iMlywmINXTlvPCZSnQ4CLbv+YsxnT4wZyWK1S1Y1C5iyrP1494+rMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925987; c=relaxed/simple;
	bh=14eY//0sWN84Y1oOt0zSOd+CM/1+X56WmIombu10NEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkZm9WAe+zRv5issAI+2F0e/Uhfj7Oq3FpGOBcJklf3No/IY1bj8aUyjZfUlH7S89VRxuPO9Z68GJ+aFDMX1DYBtfmgYTeYOt3ipdbN+yVa8hbjlE40BtQraBjoQ/EWtqdqtd6LvR/n3vuV0I6tmxPwgJQ58YF+S7sKN8+Luj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGPgWjwY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7728a8862ccso514504b3a.0;
        Wed, 03 Sep 2025 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925985; x=1757530785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA6weTM8vdilC/EIGooLzDUuRuJzTtRM53Ib1Pd9QnA=;
        b=RGPgWjwYx109SAY3AWLp35vmu0PWnSp0Iw/B6DH6rI6draaNLEfgjzQzzE98LiysrI
         vR3rBPgjG8QQvuLOthtDh+Jy73rIihlic8mAjxd6I4nzL4O2frPabYwFlZDjlefG0JK/
         xmAZwx9DgDSp2TO5nQJU+qn0Lw+OZuGWbBMC3vTQGSCeBAZYENTr0ZukXt2sww3gKjvz
         zS9LNn7yH2ZuVuz70kXJa6HqoPFZNuXydQaTgSyKPAXuH4EbIT67AbnNiUCK8jguO7pa
         +MmcnHtyfg61gwjdEttv+sBNBtQSZLSwyE89s9bHJIRpBxtgdJnwu66gDB/Q4oICnXkR
         yZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925985; x=1757530785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA6weTM8vdilC/EIGooLzDUuRuJzTtRM53Ib1Pd9QnA=;
        b=rWUkDZ1XBJ5LK5cyKSjPRpfiEKxfR5P2Pm8oszSDI0+MiZYZM4I7Kh2nL8HM89Ttr9
         BoNl08CgLZgKGaOr3gxG0oqSOUJ4ena3SSbICnfb42E47F1RVHLyuP/FsIC3X2P/5PvV
         dSRlGofn9J7B+ZAM1g7yQI8fIwdVU64egkXUT4kcejCSwTP1stblmcid2QKz1lLSKR72
         fpsvRYMzXKY+FoW71EIoxJirl3UBbCzik/JDMIEA42nESiKI0g7ePhxGDMPtGDIQ4yZW
         y2D22xL5b8kHvlSFNzOVXFQHrDufDroEmzT8EjaJ+9xFZWeq4Bzp+WCTGX2lASVFbtGj
         7o+w==
X-Forwarded-Encrypted: i=1; AJvYcCX9+rwf7CmoNfe72dglQcQIziSj4nxNTur5ijU0I9OY2tiFHK5F7dKnOXCSl4BOvbDBMPqTAIMVK338@vger.kernel.org, AJvYcCXAaRKgq04jyNExMLfs2F1iAY6OXmmkj2R6XX3qKhefv2yCRMoXmNcrW0Sp2Jzt8baOr/FudG8d0548iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbfPdQzpfqUBz9CzYkmX29oUssnL++6axaaE2zBv3wWY+ifsn
	kZRDg6oXQJpWh7Nh0ivEES9G8IMnR+xsBc1I2HqWjJnN9Nx2j7aal4te0zkcVQ==
X-Gm-Gg: ASbGncso46YcNNojhOYgfjUAgclk/e4pndiZGwplIzmme7ajr8Iq7VSr7hTRhr0K2y+
	egmlbmQfXkooFO4fPHavBpNtFTRRSDNCZcl3aXm7s/zu/aPXWKoeTKic+VnzMA1xuwmG1ECvWue
	/N/9UqhV8wpiU08AaB2pZ/cSfxnzzh2A2ky47+XfAA5wbOrPosmpPyPnK93LQmjgT96+/ElHcII
	4pTujILLDKAukW6Qp0ZEpnjqYdkcMQloEdeEKv/Env+wfr/X3wFf+EFV1Gs8Y+S9G86lqL5dP3G
	EAspLaqPPaEofXeL9Wsk3KS+InANj6QI6tSJS4M1UJm3QeIuxLeDSWFVrVCtAu2Cp6sJkWBXDDC
	EuqAWgTS+e6yENxDA8+rAeMX2Ox/X/wrc3fVthrBMlxGdAiM84WB2frbjAzFpFc+W
X-Google-Smtp-Source: AGHT+IFoYEL3/2HJDWoKxsFsnkPmdjG5vBre6hTTnok3nMNP8kBMsMcFaEho42lHd4bWFQ52X19GJA==
X-Received: by 2002:a17:902:d489:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2493ef50b32mr219143675ad.16.1756925984962;
        Wed, 03 Sep 2025 11:59:44 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:44 -0700 (PDT)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 6/7] arm64: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:20 -0700
Message-ID: <20250903185921.1785167-7-vishal.moola@gmail.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..e14a75d0dbd3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -843,7 +843,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
 	} else {
 		WARN_ON(PageReserved(page));
-		free_pages((unsigned long)page_address(page), get_order(size));
+		__free_pages(page, get_order(size));
 	}
 }
 
-- 
2.51.0


