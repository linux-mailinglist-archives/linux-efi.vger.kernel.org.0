Return-Path: <linux-efi+bounces-882-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405E88BF24
	for <lists+linux-efi@lfdr.de>; Tue, 26 Mar 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461011C3B3A6
	for <lists+linux-efi@lfdr.de>; Tue, 26 Mar 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1954BF0;
	Tue, 26 Mar 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aj6Sv1cY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6E54916
	for <linux-efi@vger.kernel.org>; Tue, 26 Mar 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448341; cv=none; b=eUDYmhEGJOU11DU5PA8sxzgCssTOeZ4QDIBmhnoDtD0vbGN+RyLiSd0VzToSZAKHU7JRx7U8k7uT8jj640ACcINhJh6V9Aptnz3cQDyDNWDnZIauZgMjBx2CxfwkKi9Xnw8NSE4oa6KKgs6lyCrAoNWN8Gi6Iy6O6+vSSsgzxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448341; c=relaxed/simple;
	bh=oULyshDxEufutFb3x7JgsNjS+oHXl5TJLKQUqi0sDrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BJxkJyyr/wrmIwFgTAPsRoQItzOQjoqob8x5tl90Abt4+cSkUqyI/UvGdLA/vdFJAjPTqe9kkSrOjrdNW1fynardCLh0BQ2hTAPlSRDUN88DCPCJGCPn3QZttd2chVXkMtypUuv4hSRE7EWGZjI/56X6CTJGkpk/cf2mIFDWEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aj6Sv1cY; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33ece03ca5dso3789387f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 26 Mar 2024 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711448338; x=1712053138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aSka93kJTnOgAP03M/h64YmhtrdMXWpUCiZ0EiI90eU=;
        b=aj6Sv1cYG4sPVXYCZd6ieNRHWJhHTQbTwRkWWX/J5GQsKkOqC4c3RVYZKq2yBB3NKX
         kuejrbNYts43IVu8fE6/QjeojVtF6sGFvtPbronC+OfP9c8vGTqHmXF6gryYfRtjk/nE
         eVcXr93xxVKodgO3qVJeoeJGOuhTp+5B61leRGtKBueVJTnu7whl0/qbq5WvSUdy4ZF+
         +qJOMQJVrtu2CeuFDkHTkndjCvi0Rz2dWrLR5pntNWZWfoNDqzwpqkDePcEPn3i0Qb32
         aaRf2yLXuK82C9cxAYSJjWooL5WOQa6ws+tj253qa5K/40nG3VUk9qp3OLmPdyQXekdX
         STvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448338; x=1712053138;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSka93kJTnOgAP03M/h64YmhtrdMXWpUCiZ0EiI90eU=;
        b=GC7jHDCub5ba+B04qIXP6ykCPG7dagGrRiVHIbqicFTxgLZMV9QIDPl0J6z7ocKoyT
         VLry9Vvg0n0C8q4gk31GirKSFJVrhykfNSu1I0QnXiR8FRygaFGPi36Q6cGKT6gwRdNJ
         ftIt8HfpjHuLT6nEnA0J9kTcEN/pM29GOrw+exGhD7EkxWmCfKEsbhkqstY7tzs51Kta
         rm23PyGtDBrJb3DfHYe/YUzOPnaSOTJoC4IgNnq0/rwW1yUK/+z7AdeCjUiE0mslzBr1
         rzhe/5dbRAFGXQD70PTTCKIFjWHhkJKfm9/wNXlqIvZsjZsD4suZr7H7Lzi6F66L6ar1
         5e3w==
X-Gm-Message-State: AOJu0YwYuQQs+TJbFl25rwOynHHq6TiOtkXV0nC1dE+p17N+Q854m8GQ
	+KbwGcX5reXnXAF4ka5K7icU4/DN7a6+owhbDJOwchSztOazVCIYiicrBaqnV+DzDi0eKv7ZNsU
	+IcLIulyMakAkFMbtFVaAn/ap+bN0bKhp/v0L+KJb/Z2mwwvxOibfl9P+Jc3SsvAHKm1TZ4tdPV
	wuv0abgW4EudLfjigBYxis10jTeg==
X-Google-Smtp-Source: AGHT+IHCX3ldgn3vkVGsmTlC28iPE3tIgnAvBTl7427Kl53dqwVmiz5ikSTzIxeQ9AR+/DlkcD3Td8So
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:f687:0:b0:33e:c639:6828 with SMTP id
 v7-20020adff687000000b0033ec6396828mr29614wrp.2.1711448338345; Tue, 26 Mar
 2024 03:18:58 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=ardb@kernel.org;
 h=from:subject; bh=uXppyG3XL3zkmpmppLdK1fymc0lLkWkINhDxHaRKqYE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY1pIfe94tfri4MFtdzDjt/g/11kNvW66LTZPdoHz9ZuV
 zLWLOfrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOp2snwP/fzix2ftZbWLza8
 HS47Yyq7SW1D/d5JbHFfOuYLJmhdUGL4Z7gkzCa37onf49qvGeoZ8yvFcu5yP81bavHmx8drzkl SPAA=
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326101850.914032-2-ardb+git@google.com>
Subject: [PATCH] efi/libstub: Cast away type warning in use of max()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: kazuma-kondo@nec.com, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add a missing (u64) cast to alloc_min, which is passed into
efi_random_alloc() as unsigned long, while efi_physical_addr_t is u64.

Fixes: 3cb4a4827596abc82e ("efi/libstub: fix efi_random_alloc() ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 7e1852859550..fa81528150fe 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			continue;
 		}
 
-		target = round_up(max(md->phys_addr, alloc_min), align) + target_slot * align;
+		target = round_up(max(md->phys_addr, (u64)alloc_min), align) + target_slot * align;
 		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-- 
2.44.0.396.g6e790dbe36-goog


