Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E825EE26D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 15:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfKDO3O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 09:29:14 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34150 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfKDO3L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 09:29:11 -0500
Received: by mail-vs1-f74.google.com with SMTP id z20so2797648vsf.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Nov 2019 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sQU0jAVefneuTdQpIgbUF6GdSN4TcMOiQRxRVI16Vls=;
        b=FhPDq8Y8jgh3GaqH19Ri5l4th6SIgrfB5k6uYp6Qe1zCUALU5Q1h777JkPDXGoqtF+
         rUVB4HT5dCMdMd/+svGvi1KkuFsbojwRCgfaJkdh2DPMBB53CrCa1TeF/tRilzh/U2Vv
         rC8CcHxh3PrEaKH9Qc4nO5dN6oULNuw2D+ebZe/2C78pc5pykjiO0Bg4leEG7yFIFNxI
         lT1Onq8IrfB98Hhn323WbkEF/3JHPJUZwZzMucC6nWXt4j1r7WLeMRYJuLt6zhN4vW9Q
         0cZ7MGwIvE1QsZGodu2uWGo2OqoLsx5v5yIqO4x8fyNCQ7jT/uIEts0ZzNEU0DdB7OYH
         Ef0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sQU0jAVefneuTdQpIgbUF6GdSN4TcMOiQRxRVI16Vls=;
        b=ZgiIIpjevffQ1tzFuNBk0G14zLC4Dgrqe0U946UM+etxM1Dic2sFNIo5l1LjMikBWE
         zKCWkQQ/qVcd9kHnzF+pfzdXDhE/Rfe6O6euWxplH5Rmp1DnsJMKMX6i11Q+IMe2E7aG
         FCSMtroaAtpUzanPCcX2WW+32plFWLpggxNIXMLWS58mdFptp/yUleczhwWCZK82Qx80
         P70oVqYT0+4y2HnoN3C4BQXc6DZV7cO0phMJwaNKktsB3qKU+6IOTxm9zmsuun2eUuPm
         gPwAe2lDL0b2R8OtYzrd7TYyTsBQ+Kdq2wR8mX88qeKS5JCXrl1vDO8BL/UwAeXNHP8o
         aIhA==
X-Gm-Message-State: APjAAAWHKDiOlX0evV9O8JKS4kAtNB5aObplsmbu65jEQWjAXmfoN14Y
        4yN74sDo9lJRoNo/bMmslXaVImaO1g==
X-Google-Smtp-Source: APXvYqxZ17ci8UfBwQliZ986Aa6FaGmsNO4/Ie/63JBd/SxBBgXy0wxlK6hBzj3ifIPGT1Jnqi5jP2CEFw==
X-Received: by 2002:a05:6122:2c7:: with SMTP id k7mr10982783vki.97.1572877749135;
 Mon, 04 Nov 2019 06:29:09 -0800 (PST)
Date:   Mon,  4 Nov 2019 15:27:42 +0100
In-Reply-To: <20191104142745.14722-1-elver@google.com>
Message-Id: <20191104142745.14722-7-elver@google.com>
Mime-Version: 1.0
References: <20191104142745.14722-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3 6/9] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
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
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch proposes to require marked atomic accesses surrounding
raw_write_seqcount_barrier. We reason that otherwise there is no way to
guarantee propagation nor atomicity of writes before/after the barrier
[1]. For example, consider the compiler tears stores either before or
after the barrier; in this case, readers may observe a partial value,
and because readers are unaware that writes are going on (writes are not
in a seq-writer critical section), will complete the seq-reader critical
section while having observed some partial state.
[1] https://lwn.net/Articles/793253/

This came up when designing and implementing KCSAN, because KCSAN would
flag these accesses as data-races. After careful analysis, our reasoning
as above led us to conclude that the best thing to do is to propose an
amendment to the raw_seqcount_barrier usage.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Add missing comment that was in preceding seqlock patch.
---
 include/linux/seqlock.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 61232bc223fd..f52c91be8939 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -265,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
@@ -284,11 +291,11 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  *      void write(void)
  *      {
- *              Y = true;
+ *              WRITE_ONCE(Y, true);
  *
  *              raw_write_seqcount_barrier(seq);
  *
- *              X = false;
+ *              WRITE_ONCE(X, false);
  *      }
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

