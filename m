Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629832FD965
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jan 2021 20:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390691AbhATSqf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Jan 2021 13:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733264AbhATRjh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Jan 2021 12:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=B6555LsRqYWm5SinOKfSQlleULzeG6eSsesT8D2nze6+2fByiemUtK9mWKEmm125dHaxoJ
        x78ZbpZ8gTRHwWwPsKS+AXq9mLBghUnc9KYnvWMdSc7Mhy7e/TJjdncflGxhqoNMR+fMjp
        cU2v+9oS5UtKVrD539Y1F55jpSCOXBI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-YudkiPCMOjmk3vUurLlSfg-1; Wed, 20 Jan 2021 12:38:06 -0500
X-MC-Unique: YudkiPCMOjmk3vUurLlSfg-1
Received: by mail-wr1-f71.google.com with SMTP id q18so11965932wrc.20
        for <linux-efi@vger.kernel.org>; Wed, 20 Jan 2021 09:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veDG5mWnaW2Ixi8XXsaq9WVUVN6IJdn0R3qA8goBbxk=;
        b=novqXbASCDH0uKo19eSwRoNIzWFpK8w6StylYdvWUz1i7cdlnw9MJ3svJ1GHelRbCN
         1YiETlRnreCfK6RyTstvwPYBmyjPLq5kwqkL5MGc6PRt3IJ0duw8pLKK+iq51n0aB76E
         HBzUx+3QQMFbcOE5bI+aB8bEcDQ72xM3X6lBKBeTKjdi17N8IZCn21E92sQcD8vAojJX
         fEBnTTlnFjqhOoskwLiZD5H3IpHOwtNP1iG5WDfkI0FiZOw9KFIBo2xp9J0YgeA9Pw2k
         w9z8mjeRsn5p4xYwhre1k/iyCludRp+cpYH7UW9S2ZPmD5S6lPPndiNOZqvufDmUuOIX
         o2iQ==
X-Gm-Message-State: AOAM530g54HeWTvqGA2uXiADq9KHe3QGwtZhikaOVJ4Urjpi6jbiYAuv
        WDojJRNUBA4d69Ph2MonpfihFnPbz1nFFfHyc5LvYzqI38jVvUR+fIIffuhtuSUpcusLk74D9kh
        7CwwhPeHiN6z1bzUSMqQq
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr10771814wrn.242.1611164285589;
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylft7yf7rgmFXUNRqNfNmGJKkqmx1XjdDH0fdpJqZZDyViFfZloLRO9kL6mc2iiU5PzrlGuw==
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr10771802wrn.242.1611164285463;
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:05 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 01/17] tools: Add some generic functions and headers
Date:   Wed, 20 Jan 2021 18:37:44 +0100
Message-Id: <20210120173800.1660730-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

These will be needed to be able to use arm64 instruction decoder in
userland tools.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/asm-generic/bitops/__ffs.h | 11 +++++++
 tools/include/linux/kernel.h             | 21 +++++++++++++
 tools/include/linux/printk.h             | 40 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/include/linux/printk.h

diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..963f8a22212f 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -42,4 +42,15 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+static inline unsigned long __ffs64(u64 word)
+{
+#if BITS_PER_LONG == 32
+	if (((u32)word) == 0UL)
+		return __ffs((u32)(word >> 32)) + 32;
+#elif BITS_PER_LONG != 64
+#error BITS_PER_LONG not 32 or 64
+#endif
+	return __ffs((unsigned long)word);
+}
+
 #endif /* _TOOLS_LINUX_ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index a7e54a08fb54..e748982ed5c1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -114,6 +114,27 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
+/* Inspired from ALIGN_*_KERNEL */
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_DOWN(x, a)	__ALIGN((x) - ((a) - 1), (a))
+
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/printk.h b/tools/include/linux/printk.h
new file mode 100644
index 000000000000..515ebdc47e6e
--- /dev/null
+++ b/tools/include/linux/printk.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KERNEL_PRINTK_H_
+#define _TOOLS_LINUX_KERNEL_PRINTK_H_
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define printk(fmt, ...) fprintf(stdout, fmt, ##__VA_ARGS__)
+#define pr_info printk
+#define pr_notice printk
+#define pr_cont printk
+
+#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#define pr_err pr_warn
+#define pr_alert pr_warn
+#define pr_emerg pr_warn
+#define pr_crit pr_warn
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
+/* pr_devel() should produce zero code unless DEBUG is defined */
+#ifdef DEBUG
+#define pr_devel(fmt, ...) printk
+#else
+#define pr_devel(fmt, ...) no_printk
+#endif
+
+#define pr_debug pr_devel
+
+#endif /* _TOOLS_LINUX_KERNEL_PRINTK_H_ */
-- 
2.25.4

