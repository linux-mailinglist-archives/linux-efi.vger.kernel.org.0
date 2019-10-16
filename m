Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C753BD8B71
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 10:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfJPIlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 04:41:31 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:55610 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391790AbfJPIlb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 04:41:31 -0400
Received: by mail-wm1-f73.google.com with SMTP id r21so663984wme.5
        for <linux-efi@vger.kernel.org>; Wed, 16 Oct 2019 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3fadaJNY8io0I9mSUJYjT11edd0e7dEg1D1vHmOcbCo=;
        b=ksjY6JoOjWytq2TYC/oK0zOAvtvo/2GZK/Z9GhwZkoNMbj2PHesiqjczqeQSE93/xV
         d1/f7nTpc6/nK3QCd2xeAv1p0Fx1ajnVjstMeHMLFBuC6uQbJAwemlBBjU3oU1TFLBuE
         SBmFMKIpFZJOw2ZF62H3KudIp5W2+fPpliass6KydtEhjgmTAEehW63jvcvWbCw1q76T
         TLTLYky1Cf0TvkOzNgvfbV21+/XriWkdMzCzYEEYXsmJ1EI0wrZyJ3D2vG6ya7+Plx7Q
         VM87OGh1AysuXviPUsLPUpvjrhr6o3F5Xn2gIuqaagrendd9yK8vP8tzRMQbht2sdQ0A
         7hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3fadaJNY8io0I9mSUJYjT11edd0e7dEg1D1vHmOcbCo=;
        b=se1hp9++fkqoe2+HZ2owcqUqFQtQlPK8s6ArzPV8RyMoie/sz2nVeCzXIfEPs+ClM7
         1qOnFqFJRdGxLg0SfT67YcyTvEMHOpc4D/c0hAuttr2JKnG+zjmwUmKIVHJ6c7e4+X9O
         /x+DluzgtE7KP1gbZkF3y/EvZb7CHTdLuh4+EDrTzIKz/YvMCmu8/LfsXidsJODYUs5e
         eHBQYSfhX1KW4wx5QOTDpDkk7sKbz0lfoQr00Czf8Wy8r9uE89u78AaVw13qlGtEkn9H
         AIo9tO9ZEXUtZpV6GuD9r3stuTKxJgafcU3myuy3gVJcUc2nT1U+qwja4Yvil3i3cANZ
         MoZg==
X-Gm-Message-State: APjAAAWUZ08Bp7A7juMNvG+fxu7arKJQgEzsU+o4ZlcGzvbrvOfBzm1M
        kR9el2mqE2iFOpF/cqdR4OD/gEsTDg==
X-Google-Smtp-Source: APXvYqypr+HPLvhOtdsheCx+wQ0BYIkOxw9wyADGYOJwPaqWSPto7foE9n4zDfuLs80RRl0nOD7b2URExA==
X-Received: by 2002:adf:e688:: with SMTP id r8mr1726076wrm.342.1571215287907;
 Wed, 16 Oct 2019 01:41:27 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:57 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-7-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 6/8] asm-generic, kcsan: Add KCSAN instrumentation for bitops
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
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add explicit KCSAN checks for bitops.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/bitops-instrumented.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
index ddd1c6d9d8db..5767debd4b52 100644
--- a/include/asm-generic/bitops-instrumented.h
+++ b/include/asm-generic/bitops-instrumented.h
@@ -12,6 +12,7 @@
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -26,6 +27,7 @@
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	arch_set_bit(nr, addr);
 }
 
@@ -41,6 +43,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	arch___set_bit(nr, addr);
 }
 
@@ -54,6 +57,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	arch_clear_bit(nr, addr);
 }
 
@@ -69,6 +73,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	arch___clear_bit(nr, addr);
 }
 
@@ -82,6 +87,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -97,6 +103,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -113,6 +120,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	arch_change_bit(nr, addr);
 }
 
@@ -128,6 +136,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	arch___change_bit(nr, addr);
 }
 
@@ -141,6 +150,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -155,6 +165,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -170,6 +181,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -183,6 +195,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -197,6 +210,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -210,6 +224,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch_test_and_change_bit(nr, addr);
 }
 
@@ -224,6 +239,7 @@ static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_access(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -235,6 +251,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
 	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), false);
 	return arch_test_bit(nr, addr);
 }
 
@@ -254,6 +271,7 @@ static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
 	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	kcsan_check_atomic(addr + BIT_WORD(nr), sizeof(long), true);
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
-- 
2.23.0.700.g56cf767bdb-goog

