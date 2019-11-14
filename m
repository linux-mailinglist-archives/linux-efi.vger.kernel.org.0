Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268E9FCCBC
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKNSEx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 13:04:53 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:40309 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKNSEF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 13:04:05 -0500
Received: by mail-qv1-f74.google.com with SMTP id g33so4656299qvd.7
        for <linux-efi@vger.kernel.org>; Thu, 14 Nov 2019 10:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c5ZdhZ0YGUmz1p5pK6AEd80tJtC02zu3w0ESO5REMCw=;
        b=HvmXn12wl0qX/E3Rsy6XqFvz7iTSNFZJIf1ZuTbKx3Tf8RzcRepEE5HIoqTt7DRQTD
         BhA9D84TWAiMyyFx8ULMX+Dm3fgOaUFKhbkkAo23XPCj17yXfdvGlxXC3T5hbr6vY+2E
         /+LOp1OCb1YMNQGDPTs/kvDX3vj+tn43TQfV5DRowqaLe3Rsy0CJONrwytkRB963xQt2
         RhDiCzHw1wa4bGdIbJDAOtNuLIelDK4ow+jKCLXn6s6/F6/Dqiq3o5xn1VqYsLMdgaay
         aADxdgs93rup9XUu0H6SUFQRc26NJEOqN8mzXO6Y75vGKv4cuA3T/r8IkQiHZQ5uN5h2
         exoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c5ZdhZ0YGUmz1p5pK6AEd80tJtC02zu3w0ESO5REMCw=;
        b=fyrF5NElBE/PKuhvWwTDo9C9Z+nlYKlibWRUjIBuqD3YBLmEsCGfjfxmQ3tiFoGzM4
         Jo9ofUxL8Hc9bkV20opWVlpb+1y8VrlxD9FGGOWpYefUb2idI5o2ZzyRdIpapTKSATyP
         OWXPddHG7ZzkEWgrYHFzT7IT/Zs9J5QDhteSDRYBedqxUKUlMFAthxhyMinAsARdzol6
         s4AWVO9L4+JMiLOBuQnk8USeqhUBscXL/xYnrDbYRBLI2Df04QjSv9PLs4WY9nDgJnCD
         5fJKI50LyFk5Aacfa4LCd3bm/5YMHuAcII5faTDqsa00bPFwV2WrdyIWtMeCcUX1aLWx
         yB8g==
X-Gm-Message-State: APjAAAWqi4MNVnlpjf9vNKAzvzjsr8fBn2xeC57eUU5Vu+P1r/qcX8ZW
        S9FK2BbuniiPauCwJ/lFLH9Wnypydg==
X-Google-Smtp-Source: APXvYqwUlw4hUlsakl9iLIPewvS2JHArNK+4NJ+usYinBWA3JzGZ7XeylKBeWUNZaEF3evwOmxW2Hl7CfA==
X-Received: by 2002:a05:6214:1332:: with SMTP id c18mr7908552qvv.213.1573754643719;
 Thu, 14 Nov 2019 10:04:03 -0800 (PST)
Date:   Thu, 14 Nov 2019 19:02:55 +0100
In-Reply-To: <20191114180303.66955-1-elver@google.com>
Message-Id: <20191114180303.66955-3-elver@google.com>
Mime-Version: 1.0
References: <20191114180303.66955-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 02/10] include/linux/compiler.h: Introduce data_race(expr) macro
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
        linux-mm@kvack.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This introduces the data_race(expr) macro, which can be used to annotate
expressions for purposes of (1) documenting, and (2) giving tooling such
as KCSAN information about which data races are deemed "safe".

More context:
http://lkml.kernel.org/r/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com

Signed-off-by: Marco Elver <elver@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
v4:
* Introduce this patch to KCSAN series.
---
 include/linux/compiler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c42fa83f23fb..7d3e77781578 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -310,6 +310,26 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
+#include <linux/kcsan.h>
+
+/*
+ * data_race: macro to document that accesses in an expression may conflict with
+ * other concurrent accesses resulting in data races, but the resulting
+ * behaviour is deemed safe regardless.
+ *
+ * This macro *does not* affect normal code generation, but is a hint to tooling
+ * that data races here should be ignored.
+ */
+#define data_race(expr)                                                        \
+	({                                                                     \
+		typeof(({ expr; })) __val;                                     \
+		kcsan_nestable_atomic_begin();                                 \
+		__val = ({ expr; });                                           \
+		kcsan_nestable_atomic_end();                                   \
+		__val;                                                         \
+	})
+#else
+
 #endif /* __KERNEL__ */
 
 /*
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

