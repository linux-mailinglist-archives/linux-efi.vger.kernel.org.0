Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82767FCC9E
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 19:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKNSEP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 13:04:15 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:51614 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKNSEM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 13:04:12 -0500
Received: by mail-wm1-f74.google.com with SMTP id f191so4391611wme.1
        for <linux-efi@vger.kernel.org>; Thu, 14 Nov 2019 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yMaGIqlKjXUqwbUrtjSqf1Asst/iuXZBTZYaUH3mnUk=;
        b=VRI7kx/kQa1bxtHhmGo3GcSsuURWiNJPJTSqjyxjWnaQhrmJjUarWDCTjBJ1UO9p1d
         BCrzK2drh1ms4Wy6zG+pz0l83lVSSmaJ2QS6e6qVnpWQ216IIFcjB24GrCCRXQWHhQvK
         rkbcAxgp2a+unX7q6vWoYB/sxObwZ1E6gxz5BGduYlOmlfyHI040gcOkXwiaQy71IUgR
         bV3iaXbAeYIIk199/bU6jP8nFYKbr2/2Bom4kutSGzf1lgtYu5auv7jbhW4nEnJ91hO9
         nTU0pVGQxZ7iAAuFNJzrIJAKqQU0N6nHduMy81Sf0Yfu78coO/unTbAO8Gb+qg7b8QKi
         jzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yMaGIqlKjXUqwbUrtjSqf1Asst/iuXZBTZYaUH3mnUk=;
        b=X8/nt1MduAyifL+uwYAmmR9WqmxICaRT7B/j1nAPQzh49gnZWFjQPISjU4b55wYnlc
         ac/shrGaSGxQNX8IVI+ezO8/vGYC/CG5AakLfrUlvCbzbgib5yUgYr+6lYRAUgyeOSCc
         VEUCtPHeKVsUlCtWodaJyo0xNbHThIng3MMRR5hXeY9gGBnBEulHpHo+LDjAGvYsErX7
         RZjqulcJ7CSaa6T07sXGpewDlaSWmBgVlp9hK5u7d2GWl3kPLHCDaTx2zz1EMDdf6/K4
         9+pr7hDV9RPyyxIudGYxvPdcFj3y0KYQTsp2ytBItH2mjxNgI7tK7pKBZ5nOc/xXsGkv
         t1rQ==
X-Gm-Message-State: APjAAAXecMAlkpqjKFv4JAWOdgD6LFO8dYOSyTu88c92MdPNocD+37sP
        5KGQfu9tfS/Z6cSrBTX7J+gSxaXs5Q==
X-Google-Smtp-Source: APXvYqyspOQpVtiEwHHRTBFpggwt2BjVGksS/Z0SK5UoLcbkvLbrVwozbQHYvHUI0Ye76E0xz4YUUbqqyw==
X-Received: by 2002:adf:db92:: with SMTP id u18mr9202786wri.1.1573754650237;
 Thu, 14 Nov 2019 10:04:10 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:02:57 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-5-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 04/10] objtool, kcsan: Add KCSAN runtime functions to whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds KCSAN runtime functions to the objtool whitelist.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
v3:
* Add missing instrumentation functions.
* Use new function names of refactored core runtime.
---
 tools/objtool/check.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3cb247..e022a9a00ca1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -466,6 +466,24 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store4_noabort",
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
+	/* KCSAN */
+	"kcsan_found_watchpoint",
+	"kcsan_setup_watchpoint",
+	/* KCSAN/TSAN */
+	"__tsan_func_entry",
+	"__tsan_func_exit",
+	"__tsan_read_range",
+	"__tsan_write_range",
+	"__tsan_read1",
+	"__tsan_read2",
+	"__tsan_read4",
+	"__tsan_read8",
+	"__tsan_read16",
+	"__tsan_write1",
+	"__tsan_write2",
+	"__tsan_write4",
+	"__tsan_write8",
+	"__tsan_write16",
 	/* KCOV */
 	"write_comp_data",
 	"__sanitizer_cov_trace_pc",
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

