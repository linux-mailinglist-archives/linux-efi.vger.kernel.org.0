Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32E823BA8C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHDMmA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgHDMlr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:47 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF141C0617A4
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k35so23773369qtk.9
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OJV+wFsSuBAEdua9Kpud4j6ZGzVdRXqmU9/PZhjVLdc=;
        b=Ea5YjJ7o620kZq8eHnshiekvC4wpoxtU/m2L83KMHr56wGFqcLIiluwTTPIuK6jPtz
         NIbahZxx/kLpiZOWX4LifN1sYL8ve+GY+nJ4uXKX/NwgeJ66FB0oBHFDCJ7CnFI+jXp5
         YfjHAXZMMGH3A1RBkM5ekVG/ygZ56FsWNDeUBLLVL1ABwVsRZPV6DZg8v5EyPdnyI/8q
         u9+woephvoS6hP7AP7QtlnSDcnrQ3oLlLY/jprakwQVQNuaNzYsx0faunrqjJ1Rwi828
         vpjJ63tAJJETQeQAfpWW300WdlbW294wpGLA7b0wjZ0R/4TF1hESmC/l3kgC9ReY8bHQ
         oJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OJV+wFsSuBAEdua9Kpud4j6ZGzVdRXqmU9/PZhjVLdc=;
        b=L0txTXhJC4nnxCQhGFEjC/StDXZl6Iz4nhAIvzzHQ+4nsO6eC8LI+tKQbjsP/Mwg7d
         aV0GSfxvZplL6AZunR6o2A4EOp78cKb4nA/1a3JPGqv2QZyKGIxJZjzQZPe7aX/l9zbv
         ygiQBc8U6nRodcHH4QNs5LE15UaCVAnGYnwdPfWrI1y87c+winM7vTLKB8l7B8j0emSE
         FyALEGXL8u6yv/ibHTYaaiU0UpphIoIjrvYKtrqSL95S7bqbYTHjs6GEtR5+skFm4Wjc
         VyAnlkmwIj3KQ+6xslfWJLyrWMtP6pxqPtEARU5o31N6BKq8Dhu4DSLaD/DT083HLDG3
         FXrQ==
X-Gm-Message-State: AOAM5304MSXpVpShUReB3/SGPvj116M+DHaFt6d6hlO8A7GAz48ewC7F
        y0gH+OZfIEBF8SE3cc/wyQtpikeuAjwXL085
X-Google-Smtp-Source: ABdhPJxMCD1uy5OtH/rfQcGvmBrhxSjZNftrKmDoPQf463mdE8fRrlNv8GbsPVw+FCZ38SV1RL/Err4XbOOp0GEM
X-Received: by 2002:a0c:b604:: with SMTP id f4mr15297001qve.68.1596544904936;
 Tue, 04 Aug 2020 05:41:44 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:28 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <3063ab1411e92bce36061a96e25b651212e70ba6.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 5/5] kasan: adjust kasan_stack_oob for tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use OOB_TAG_OFF as access offset to land the access into the next granule.

Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7674616d0c37..5d3f496893ef 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -488,7 +488,7 @@ static noinline void __init kasan_global_oob(void)
 static noinline void __init kasan_stack_oob(void)
 {
 	char stack_array[10];
-	volatile int i = 0;
+	volatile int i = OOB_TAG_OFF;
 	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
 
 	pr_info("out-of-bounds on stack\n");
-- 
2.28.0.163.g6104cc2f0b6-goog

