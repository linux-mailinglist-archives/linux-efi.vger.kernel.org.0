Return-Path: <linux-efi+bounces-4677-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D489BB42947
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F1C1BC499F
	for <lists+linux-efi@lfdr.de>; Wed,  3 Sep 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76136998D;
	Wed,  3 Sep 2025 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHGxQC1Q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61636997A;
	Wed,  3 Sep 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925981; cv=none; b=u7pYaUZmcncigXJtMTwzZxQiY/KESpdpgdf9XpuuAsmAcNNrZIy0fL2IIEkQDHO79XtfA9iXpraDIeeGosqfJOLMXgK67BfxfH/nzz1Nijbxq4OUFbiLnwfyOmK1HYN3/z9HeRI2H1mOQSL8fGxR+g4VFa0vq6ArPySXM7V70xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925981; c=relaxed/simple;
	bh=tDJPTP0lhO5ivDTkZpNt7Rd4fQWnznv9kl6iZmQUTXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxv841Ru1z1D1+aipUUg3z5NhleYjAEWnSskKs94n0+NuOTSQocwlCPr95vPgNWIXqJ3ldmYE7USXx8HVwkRcSzlDvdP9yVgJxtBj7X4a7ObgHK8bV2GnynXXmk3Gbmn1bhwQpCvsT4jTsOn+XTUuwFDZF17EPxRZVrUvUB2gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHGxQC1Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b2de2e427so2176565ad.2;
        Wed, 03 Sep 2025 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925979; x=1757530779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wz/bZSqqVx6pRJeL2TZzvIUdrr6/vXiyt+C/9X3zJM=;
        b=mHGxQC1QnchszG0tFQ5r0hrjrgRv47IbCMa5fXoT/kKzpGrhQ3Gtvnp2/p/zZPGE+/
         Lgix8s6VD7vGmMVTj5up26I8wTJIseg7rSZ3GtA7v+ExRB9Qf77WdZjODT0ByefzRhC5
         0/g8MbtXyoey/bhmFPAaK57xaW6MuteGLeUOVA21Jzsts64raiukZBqc3PIKgExqfFeI
         smKCEDFT4MOhjUGsBJJvleB+S7l2ZqLaooORTwp1PZYmcD+12GUMMzSreD+e986JO6Mx
         ALg7WvUegoPwUJFYezATXZp60iV+RrZ9dY/eLelFDgCgXaOoOw3fOUrrbTuOn3RUsJm2
         AVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925979; x=1757530779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wz/bZSqqVx6pRJeL2TZzvIUdrr6/vXiyt+C/9X3zJM=;
        b=cFtMEIIgL9Be1nSASiPMVLl6TlJJbsMokMJY/WTgzQ/xxOy01OBOOUN2kp8ksYGvk0
         znOUvdkIIVoCR7rmX8r0VxQHg5IRSnwjy27yJc30T9Ddk8KLu2xcgNzel3fzq2+UkdMY
         1g+tnJswqOtZzNeMRz7ucM7bwVWcBtfWSpfM9sKHZLxxgbTKu7Qj2nJBalOmRWCJyJ5b
         IRppzBE5S/3lbyuSueMgQJgJ01zAg8IAkN3KU8R1qjhptajxB5Ct80O9NG747F2vDwS9
         BtnfhmASfTbAC5ADygkFe8JHU3GZJuoeQwfyKsC2Mw9h1i1iibGqJCerI4tg7UQ08xlP
         QeiA==
X-Forwarded-Encrypted: i=1; AJvYcCUEK+mXq0HhGSz9UFuA/LzlgAulY4ewG/XrrQVLSZgfAdC76GIkVH1dQVXeVuE+TRLeD64kBB37O0Kk@vger.kernel.org, AJvYcCXBssZrXc4woeUmZMhVd56V4uJCTSnhn2OTpbHkZJbmUcV0u6ZSqK7oTSL+OCaWiYo5qDcTDxMRH4lplg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NSirHN4IKNG+buVYBLakVLt/1q9yGdWRBO08wmAUXiRgPNfG
	8E1Faa+woDgqg54UlW+fcSn7AK0+xecXIUHEEX/vPf5gSQh0kpBGf/Bl
X-Gm-Gg: ASbGncsMLWUgUhsE2WO5HBIEy97rc9bu/zEtg+C2KpuJamFAbJtoiR1r9g8kIvEK4Kw
	X8LcTcGi2fx8f1mobvnAWI/zaq4Caob8fL0uCZclnpdisZgEyfI5mqQXudiQgRPoAAuzLV4Mwfy
	UvcH2jM1iJ2GgKKABnfFZA7++KWaEllpd1MZKh5kIftajYyaR0BPmgvkfEw3T2X+MUCsKOEtzYN
	SKN79kbeNx4y2iWARpN0wCOAZbyb0oxzvb58cKJLg/WKolmM7DL7nb7mgUZQyNsfvf5gxxuq/C/
	BLxrPIifCFtXIPiGDboHUpmTkqM6SMeRSypHGneS6RpAesyXFOE9ZPhb9dVxTolcBLxeC+/Yf5p
	c9fBfxQD39YPGn+quNydniCK+fXmpd15hJqUBxmHBMO/uxKqYSwwcWQ==
X-Google-Smtp-Source: AGHT+IFLYxGq/uXWczWSmoJ4dYmB1R4jOWZAcKlvb1pf3KqvOH6hTCxx8eQlFrsP54M7TPt133nTbQ==
X-Received: by 2002:a17:902:f789:b0:246:d383:3964 with SMTP id d9443c01a7336-249448ac3c8mr239306545ad.18.1756925979423;
        Wed, 03 Sep 2025 11:59:39 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:38 -0700 (PDT)
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:17 -0700
Message-ID: <20250903185921.1785167-4-vishal.moola@gmail.com>
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/init_64.c          | 2 +-
 arch/x86/platform/efi/memmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..0e4270e20fad 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 	}
 }
 
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 061b8ecc71a1..023697c88910 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 		struct page *p = pfn_to_page(PHYS_PFN(phys));
 		unsigned int order = get_order(size);
 
-		free_pages((unsigned long) page_address(p), order);
+		__free_pages(p, order);
 	}
 }
 
-- 
2.51.0


