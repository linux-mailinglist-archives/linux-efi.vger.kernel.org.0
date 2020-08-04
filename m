Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE523BA93
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHDMmc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgHDMlj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:39 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD5C06179E
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:38 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z10so5136754qvm.0
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MkWKUi7xJlcxy+e8OWBoJNl1OXW3h1d9K35k1It603c=;
        b=El9eCMgZto7hrv7PDOK8sz2wSLBcDVP89TfYWUHfgVCBju0bnGiOsMLl6XBn8jPSjh
         qrgdXGRXN4HlmL1fOGf8voLbPZt1X18PEjYdDjjXTh3PKpwhCwvxfdH77PmSuIH6bHjH
         IzHWS/61LABdVG/cl9nv7tSaT02sva1I2t9kU4CCxKn2Fuq5zAhsavQCtRi26JwEs+Dl
         9fQdx9ceg+7jPTrfJr2H/RPbendmsnMPAjmTuZXHQ5z0+weqjI1akX4ATVsuIjOK4K4K
         9i8R5X/OYsJ9UZwUQgh+6iCBRktsvnPbggGzIRvclgIctl5ElMdM+aNZB9sDbsroXJJs
         M9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MkWKUi7xJlcxy+e8OWBoJNl1OXW3h1d9K35k1It603c=;
        b=Lnmew3suIoZSKd9wfoxaU0xR19QWl7VlB+09gT/fDJK+Lfvz/LR1JpOngrZn+O1KFb
         b69ttL86x0QUbinT1vfnlSbF0LXiBXGFDp1GLy5Q2Dyulejka9857sD9cP8Cu8pMI/5y
         qVnMohrVmIwmGlXg3cKUBWtToYHrLGOfxVjid7Al+/++vHphtvOV/vKFr8jbsd1FyNSd
         lCP7/Q1F2mxiCAxMHAIy4t54yvCdYv97Ii7551vwzkRSAT7f6rudaHq19LlKf4WV7IS2
         VlGWHmkeB04Tmy0i9v49ZzRNSQO5hu4NG1e5ZMEaJxAUhSY046NyAyWN7B6E/CVnE9HT
         JDKQ==
X-Gm-Message-State: AOAM5310tNXLq8d9IJRPhkNa0J6JdA48hk3MAUE4E+qiFduMoCkKopJN
        sZlXsFeZBqCACxSwcMb4Bc40kObDSLWQgB4L
X-Google-Smtp-Source: ABdhPJwC+zlXBovbZ5yMemFd6n1F3dx7E2v/1/0xLypGVzYOL4r1AHzTFwqN6hvHO5BmR1xUzcpuB+Tj4Xl/elq0
X-Received: by 2002:ad4:4152:: with SMTP id z18mr22181844qvp.42.1596544898043;
 Tue, 04 Aug 2020 05:41:38 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:25 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <6514652d3a32d3ed33d6eb5c91d0af63bf0d1a0c.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 2/5] efi: provide empty efi_enter_virtual_mode implementation
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
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When CONFIG_EFI is not enabled, we might get an undefined reference
to efi_enter_virtual_mode() error, if this efi_enabled() call isn't
inlined into start_kernel(). This happens in particular, if start_kernel()
is annodated with __no_sanitize_address.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/efi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 05c47f857383..73db1ae04cef 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -606,7 +606,11 @@ extern void *efi_get_pal_addr (void);
 extern void efi_map_pal_code (void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
+#ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
+#else
+static inline void efi_enter_virtual_mode (void) {}
+#endif
 #ifdef CONFIG_X86
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
-- 
2.28.0.163.g6104cc2f0b6-goog

