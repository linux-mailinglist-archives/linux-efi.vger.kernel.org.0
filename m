Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCCE23BA90
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHDMmB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgHDMlr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707AC0617A2
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:43 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a186so12254508qke.1
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=al711nch3pGhu0oC1wlPaqYQVlVmmhVzmYHp/7d5LETFi5Rtuy1m2i6Q7VZyHZWzvU
         hgxHf9w/ckVjXi3fhG4d+LBft5K89LkjnHbAbhqXdJQf+gaDGnDI0gAmQvywiJ+Vcfpq
         fXUe1mXmVqZwCTV/bjfqcfsyDvqhOVJmyD48Oj7Db+FICYod8rKgX7Xwry1oDf2wkEup
         RR75P7hQf3YSyhtdZQyTtr0fFU1zbFApwbVSnzym/MadtAc0yGXWKQ+A2mW0MAhYz+R7
         l9TXw52PMyujrl18cxAUf/X+TsTelw+wmXc4IeyF7EmwiAsMBbLJcMRtX980kmLZ8TUT
         wSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r3AVQip2xq9L4iLlC84/aNvGhdtcJ5cWyH3sWORBbtc=;
        b=aKiLOqK8fMXO9wZsmxUcAjYMqqlCcso3XXGotyrx1vVf8jtfNIp7QVWxnxsrH22zeu
         0fK0DM5SjlbEdSIM6qxmtBWMC7zlN6yXBFPQBYPhPfzgZT9jNEhwUa5sYJqXK5GtPV9x
         morSB1JW9j8O5I2v6SNRR1GyNb1ZXoZBHNlcxTdJhkKK9X+WfIfjPiISND/fJkJRCKwj
         beJ4fSv65pCex2SU5qCZBtPwbaFjSfkGMowaWCK2ie1xnlnLDRczmGHcAWJ98pFY3vQN
         5epDqSjmaUaa0VzO+T2slG+Ukj5ZYKPMm9M8nH9k93VOhG4+n8JbyaFG/9EmPhwaCr+m
         eFmg==
X-Gm-Message-State: AOAM533nwVgC+WsW47XeojrYjKft+/+172hQ2OqteqgAvM2zsGu7U2/p
        QIk4LTtP6nvIxcyv1NlHpD3OMOKTdwYthJBe
X-Google-Smtp-Source: ABdhPJxNVNohw+RMFq1uv1gOt0ICKpmDjLXFJp+5X/8n8NGst2h3rqGrz443ENowh4INA9/32k2O/16zVxLTFGJ0
X-Received: by 2002:ad4:438e:: with SMTP id s14mr21419425qvr.18.1596544902628;
 Tue, 04 Aug 2020 05:41:42 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:27 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <99f7d90a4237431bf5988599fb41358e92876eb0.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 4/5] kasan: allow enabling stack tagging for tag-based mode
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

Use CONFIG_KASAN_STACK to enable stack tagging.

Note, that HWASAN short granules [1] are disabled. Supporting those will
require more kernel changes.

[1] https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 scripts/Makefile.kasan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 03757cc60e06..f4beee1b0013 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -44,7 +44,8 @@ else
 endif
 
 CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
-		-mllvm -hwasan-instrument-stack=0 \
+		-mllvm -hwasan-instrument-stack=$(CONFIG_KASAN_STACK) \
+		-mllvm -hwasan-use-short-granules=0 \
 		$(instrumentation_flags)
 
 endif # CONFIG_KASAN_SW_TAGS
-- 
2.28.0.163.g6104cc2f0b6-goog

