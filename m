Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780E923BA85
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHDMlf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDMlf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C0C061756
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so42930666ybm.13
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EW4ws3cnCq+yc75UdLo6m+LVSSHzgz4WkI84lcOYn3g=;
        b=qRIWjL/aEST9Bgmmx1TReXVYXWMihOsuP+mAYj0qjuyBiTphgrU8vG2kDlWWLDxxZc
         Jg/LIbVqWQjdvN5QE8h4YxR5/B9yyZrsWE8c8qZW41jeLrHYTrlw9Cgi5XREl8IxDRfC
         co///64tOPGz+FN54l2XLrTcKdQjbLgUiQfL0z3QjR2C4z46DUpqY7w/AgukOpoxYc3p
         CD9+UVlpekMWPXavUVNf5FWgoZzMzg5BltVr5+w/viNnAaKQBsKSXLhBzBu/rH/ShMam
         93k5taOEn8vzxT+jZUIfKqfUVPR7WK1vFT7PcRQ0StCmtlNMT8Nh+075v3BYofndZUtW
         VoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EW4ws3cnCq+yc75UdLo6m+LVSSHzgz4WkI84lcOYn3g=;
        b=Jl81q8FuhzJkwWHlOEyMpKERqVPdItLakDv5dPmSpTuPFO8N6kdDlKFIoLiRl3iZYZ
         YYRCBhXuVyIhq5V2tc1cz/1DWdAjG4uiKmcQSZFeoefcYYwpQl7YwenHXvq8TSkCK7Yw
         VbYEke2eufoJ2Tl6yYbtSef3N0VUhWqI6H6zjsJeilHaRWh9JYB2wb1rNHiFXf4PyeOV
         rVpF7HAgzfQHIc8s9ohUtZfP1mbgLVsHMiKp90T7culxMuXYqY9XZCGFr+/SOOz0ge66
         Afnf1fP24v8RHBjHuKFJnjvIhCUjU2EYDShrCqXCSX2u/eWC5MVZCk/bCrTeg88T7WOx
         qvvg==
X-Gm-Message-State: AOAM530H9K696E1IqtIACsXCgXCwUf5XpcnnYBcvIZGltbN7rJmu8MDG
        Vtq/jf21E1vCtaSqMx/yNa/gkjZknMmRe2yF
X-Google-Smtp-Source: ABdhPJzh3yXfnlrh952yFi751mKOqrTYGBJNP8FaBO9bCdmzHWrwFtNMq9Jua++VtvKtWW7vV9nXY4rjJmmS8ewv
X-Received: by 2002:a25:cc07:: with SMTP id l7mr33304214ybf.440.1596544893505;
 Tue, 04 Aug 2020 05:41:33 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:23 +0200
Message-Id: <cover.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 0/5] kasan: support stack instrumentation for tag-based mode
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

This goes on top of Walter's patch titled "kasan: fix KASAN unit tests
for tag-based KASAN" (already in mm tree).

Bugzilla link: https://bugzilla.kernel.org/show_bug.cgi?id=203497

Thanks to Walter Wu for debugging and testing.

Changes v1 -> v2:
- Add efi patch to undefined reference to `efi_enter_virtual_mode'.
- Reorder attributes for start_kernel().

Andrey Konovalov (5):
  kasan: don't tag stacks allocated with pagealloc
  efi: provide empty efi_enter_virtual_mode implementation
  kasan, arm64: don't instrument functions that enable kasan
  kasan: allow enabling stack tagging for tag-based mode
  kasan: adjust kasan_stack_oob for tag-based mode

 arch/arm64/kernel/setup.c | 2 +-
 include/linux/efi.h       | 4 ++++
 init/main.c               | 2 +-
 kernel/fork.c             | 3 ++-
 lib/test_kasan.c          | 2 +-
 scripts/Makefile.kasan    | 3 ++-
 6 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

