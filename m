Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C234023BA94
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHDMmd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgHDMlh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:37 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF66C06174A
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:37 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 89so12586561wrr.15
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FcKp4QRyFHBBCVHpXykl5mFo5C8EtuBz90+P1+03xoY=;
        b=e/emAKRKbJkdBeq2q9WKmzagPJvb8gdtqflMVkfA9U+GObzCW9ZK8iDv+fm06/lNOH
         ajIRbU5BrRbTrBBREu3uaJou2xzNyaOCp+XZbidInFpetFzQFW1x8pTzoRCyj341z+Lk
         wq4m5lWgeLtpP7STH34Cb53cG+ae0e77L4MzJmeQ/HMqzyEcxWEcW0LZlOw/BlZk7uoa
         dO5RcM67ErBDoGmZ9vvLhQ54jnpx36h7CmzrXwZGP0KVeFdh2JE5X6xOlJdqsCGf3JGH
         qx57794JnfkOQH/j1i6yWfIbZmc2qfK2k0FRmQtkn8Nc1oWCF+4s0O93QqCimgEugC/p
         C7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FcKp4QRyFHBBCVHpXykl5mFo5C8EtuBz90+P1+03xoY=;
        b=SZd7UiUw9kJ/BA0hldKDsCHn2utT+SEKV6akCAvfzJiZ3W5ZagKnjm2AdZCXqGD+jb
         v/+7YlH7+0XVNeBcZmrQ7NKYr/9OebEMcor8Wq0Q1rBMoRdkQa+me4XHjfHxIbFENxj5
         gKE/uQIa8hIiz8j6JH6WsU/oqHF66VZErhuk2cktVUw9fobf1cJxtEchMQbCxn42EZOG
         UNAYNezeAHATslcb5M+m18wGtBiQ3V04L3VmwfjRmMqJSbO2BBtOYqDpngtczVZgyPld
         vVaJjMzTptbjRwtCKL0Nckjz0KdfZGIHEjsG4wrkzTBLhk+FYPFrXJhz4+g9gm0oGm60
         BEXQ==
X-Gm-Message-State: AOAM531LyGfHzmLy8iS1iCgguLIc2XJEbrCUhetWp0SpvdT3Rd6uqTAH
        UPoFnGL4M4texIApVjhz0L4Dl8L2kDotrZDw
X-Google-Smtp-Source: ABdhPJysUQ4oDqsJhy6xq9sHQOykVWtKsRJrE3eJ3umL4PptPqQvdYk0j95C1HF2RsOBJ7cfXSW95HsjwlUjMNSy
X-Received: by 2002:a1c:b443:: with SMTP id d64mr4329306wmf.68.1596544895842;
 Tue, 04 Aug 2020 05:41:35 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:24 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <12d8c678869268dd0884b01271ab592f30792abf.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 1/5] kasan: don't tag stacks allocated with pagealloc
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

This patch prepares Software Tag-Based KASAN for stack tagging support.

With Tag-Based KASAN when kernel stacks are allocated via pagealloc
(which happens when CONFIG_VMAP_STACK is not enabled), they get tagged.
KASAN instrumentation doesn't expect the sp register to be tagged, and
this leads to false-positive reports.

Fix by resetting the tag of kernel stack pointers after allocation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index efc5493203ae..75415f5e647c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -261,7 +261,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 					     THREAD_SIZE_ORDER);
 
 	if (likely(page)) {
-		tsk->stack = page_address(page);
+		tsk->stack = kasan_reset_tag(page_address(page));
 		return tsk->stack;
 	}
 	return NULL;
@@ -307,6 +307,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
 {
 	unsigned long *stack;
 	stack = kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
+	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
 	return stack;
 }
-- 
2.28.0.163.g6104cc2f0b6-goog

