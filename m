Return-Path: <linux-efi+bounces-3669-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F419AB449F
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A6C462E08
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC429A33B;
	Mon, 12 May 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JfW20Y2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7229A330
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077124; cv=none; b=bjNYcYfTxbl18+4qsU9ArltkNm3DBoDQjRUSjSx2XGQJup8oHMsjXGee7fRQnpzC7JcIFSwY+m+Rvd1/srr+dCvHrwYzpoXalYCFJmKrrdmzIKgFoktapjVZRBtfhpUle2YOjdwhR9+KBjF/OAIbA34dZ7bMyE6i1gvpSjlxDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077124; c=relaxed/simple;
	bh=1Hjpnh9dda2ORviudkcMn1du7RIYbpCSvA6mjNRuDvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RFXwysXaMIzVONq2qh5GNN5CFAXbY98gMkia/WQbnhy0M0RUEe3cVn93FXqqti5jKQhjlkVNpOqrdEnZpvp4+eBLDWH6BLRxiHk8NT6H3ZoFmjmGNesxl25PrKzRV2YEw7yxmHo/lHaybBp37O4s4GkzKSiDB9AvRZNE61dAd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JfW20Y2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so20618265e9.2
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077121; x=1747681921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bY9IzSlLGQPC+pLUaE7gEvrg/6v4J3wqpLjIKooAt2g=;
        b=0JfW20Y2nlUWjvNVB+qh1BnvYYQI6vAzArQg2A01V++o0nrZrhHs8HA8QCvtX/PPgR
         VnTLdNVTaytiLQlFPt6BDshIxxxL8uVEhiuQJt7yh2oeHCDxMhH4DdrBgIa4XZV5flHf
         s7D3WI5Zi21KWfwfAN2BLU6t1/dXNLdvOrQXZPu6aai+dOelg+05ru3I+Da8NiTkGTka
         VuOzGwvjM/ewYU9l6peD7LZmUQvM1/extqbI6bPmpjPMdIi0TObF3ihgFSas57OlheS9
         oncuQQbrx29k2yYjkd1tPmLDmapy18VxucNZYSekIirGdCCOa0sXbQTGmQA1kd7cfTGi
         EN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077121; x=1747681921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY9IzSlLGQPC+pLUaE7gEvrg/6v4J3wqpLjIKooAt2g=;
        b=HKJPXzla1RyIYILb/DyLHyA5lzx9kjbCGuHww15btsD4ZDtS3C1Km1ydGG1SiurpCG
         iH8DdcW7zowUxPtukVv5JlkExrfS68YYe18B9+0NFXoq74jiNq/TkrFy2wk34Y7MRSRe
         xYAfE/kym6UJRGGvf5UqtTETPYO51m6p3JAsa1whGbjw/X9QA7Y2JadYnNn+3xt64WBw
         977CRKBqjl4Rndv3m3tu2C7zgx0Zs8qUJk2sf/Uim/qHYNinHVBf6EmZkzmmQCUlp+FJ
         w3edy2NKE03zqrZqXNPPaOcdYkM7wZoU/ldWgasAW6uh12BjnsHfY0rQBqAhgv2elMcz
         IUjw==
X-Gm-Message-State: AOJu0YxbfkWnJDYRV2zNxnj6BKveNI8rBvFpdMJogxRzptWXrDIgpRHr
	FhdZ9OqPXBL++74zZReejNYrkPcgeafbyQQJ5UJje52VVGRp5ZxuSi0ASj5W2sGjimbUWA==
X-Google-Smtp-Source: AGHT+IG6r7Gg70bdS7tcnW+62zSzZoWqv+6NsK7xaxabAud3Z8dqLNSZsfNkRAZ44imeWrkOrJ7kMKGs
X-Received: from wmbej7.prod.google.com ([2002:a05:600c:3e87:b0:43d:1873:dbaf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:450a:b0:441:d437:ed19
 with SMTP id 5b1f17b1804b1-442d6d448afmr102359415e9.11.1747077121291; Mon, 12
 May 2025 12:12:01 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:49 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=ardb@kernel.org;
 h=from:subject; bh=Dg3l458uD80s7OT/oBv3zq8dwv/NJq7U/qhuTc4s+G0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3V+2sWte77OvKbdeR09ZJzFxtt2D7waXneIrVtyOf
 L5G+RNvRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIXyWG/7W3S2ctnjy94q7+
 kv+v7ly8ZbBuib1KP8Mht+4reROUBDIY/heJhQnbyH2Q45iyMf7tz7V3bFsW6efZid77nD25YMe aA9wA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-37-ardb+git@google.com>
Subject: [RFT PATCH v3 14/21] x86/boot: Provide PIC aliases for 5-level paging
 related constants
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

For the time being, provide PIC aliases for the global variables related
to 5-level paging. Some or all of these are in the process of being
removed, but currently, they are still assigned by the startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 510fb41f55fc..8c69cea84297 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -53,10 +53,13 @@ pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
+SYM_PIC_ALIAS(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
+SYM_PIC_ALIAS(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
+SYM_PIC_ALIAS(ptrs_per_p4d);
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
-- 
2.49.0.1045.g170613ef41-goog


