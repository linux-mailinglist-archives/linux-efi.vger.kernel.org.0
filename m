Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26722406
	for <lists+linux-efi@lfdr.de>; Sat, 18 May 2019 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfERQLh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 May 2019 12:11:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfERQLh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 May 2019 12:11:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so8879177wmk.4
        for <linux-efi@vger.kernel.org>; Sat, 18 May 2019 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFr1YyUnFGeCjFihL0M44pTcBFr6oYpvRa26FUmOnLY=;
        b=dCjmGeejG4V1SWbPj07n4gqVDinH+M/I4Q6eRiioY/gHiwQG4skjQb3HoDmVujJgjd
         3T9sid7FQGbEMpCoV4Oax4wzPsOVCapsTWMuzwqQnhWnLuRTNGpGfEV3W+DOuWphTJE0
         TfbXqMqG0/FZpWG8KPekm9/mgRERZlZZqmaqxer+uzbZvAo2Mo3AqTJhD5p1tMnZL+hH
         xgPZhBc0yKtRAjcUBwKaey4Akoo4dUWH8jRejV5m3zskDwWi0WMDuAf5hLID2C4TV7+m
         VFGH/BDVzsFk0vgOmG2jhOepKf4zPKMrwOvSw+o2GxmK0Pun0Za3lAQmfr5AuQ8pwq9V
         G62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFr1YyUnFGeCjFihL0M44pTcBFr6oYpvRa26FUmOnLY=;
        b=DEJxDkinEOBh7manABVLrTG/KQRzI+L2a2gdBsIKWD2NDAoSNPBYztF/b82bbQr8cd
         tuOt7mkBKXJBgxM+tRTH7fBS4rAESUZ6toMkKbzuo4VBTuN2IiyS9rPOaL5vWj5RzEqI
         NsmXBbUiZR3mXBpdQ2uFijnRu5nsGxE63KYxq3sTsfGfd9EEQadv4y33xEyG4xXZ2YP7
         jIJZsggKBgtXBiDZrBCXGlZ/38dig4huRTnTL7rRwm7UdQXcBci9Y6RxbSYwJZKt8YZk
         +YucemPnOFICJwZxEdl/NHLPIVWNrwLU9mREIXpNZNUmI06J8WtQH7d6lQVscsP+XrHS
         SKrw==
X-Gm-Message-State: APjAAAX4SNiyrHLdkB7yiCTV+u5Q1VH1YaX2RA7P5QUV+oH95Gjemx6T
        negAXjpzNsx580Pra498B9BtEEnwiE+8Nw==
X-Google-Smtp-Source: APXvYqx0JKX+SwPD2WAjb4n7jugq5O9FCgU5h94AC5pT0s09zlSHxeB/k6vEQqZqbg6M0Cqk2zdlQA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr5843107wmc.59.1558195895262;
        Sat, 18 May 2019 09:11:35 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:bd35:2d8e:b14a:152c])
        by smtp.gmail.com with ESMTPSA id b10sm27242089wrh.59.2019.05.18.09.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 09:11:34 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, mingo@kernel.org, jarkko.sakkinen@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: [PATCH] x86/boot: provide KASAN compatible aliases for string routines
Date:   Sat, 18 May 2019 18:11:13 +0200
Message-Id: <20190518161113.27780-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The KASAN subsystem wraps calls to memcpy(), memset() and memmove()
to sanitize the arguments before invoking the actual routines, which
have been renamed to __memcpy(), __memset() and __memmove(),
respectively. When CONFIG_KASAN is enabled for the kernel build but
KASAN code generation is disabled for the compilation unit (which is
needed for things like the EFI stub or the decompressor), the string
routines are just #define'd to their __ prefixed names so that they
are simply invoked directly.

This does however rely on those __ prefixed names to exist in the
symbol namespace, which is not currently the case for the x86
decompressor, which may lead to errors like

  drivers/firmware/efi/libstub/tpm.o: In function `efi_retrieve_tpm2_eventlog':
  tpm.c:(.text+0x2a8): undefined reference to `__memcpy'

So let's expose the __ prefixed symbols in the decompressor when
KASAN is enabled.

Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Matthew Garrett <matthewgarrett@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/string.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 19dbbcdd1a53..81fc1eaa3229 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -11,7 +11,7 @@
 #include "../string.c"
 
 #ifdef CONFIG_X86_32
-static void *__memcpy(void *dest, const void *src, size_t n)
+static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	int d0, d1, d2;
 	asm volatile(
@@ -25,7 +25,7 @@ static void *__memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 #else
-static void *__memcpy(void *dest, const void *src, size_t n)
+static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	long d0, d1, d2;
 	asm volatile(
@@ -56,7 +56,7 @@ void *memmove(void *dest, const void *src, size_t n)
 	const unsigned char *s = src;
 
 	if (d <= s || d - s >= n)
-		return __memcpy(dest, src, n);
+		return ____memcpy(dest, src, n);
 
 	while (n-- > 0)
 		d[n] = s[n];
@@ -71,5 +71,11 @@ void *memcpy(void *dest, const void *src, size_t n)
 		warn("Avoiding potentially unsafe overlapping memcpy()!");
 		return memmove(dest, src, n);
 	}
-	return __memcpy(dest, src, n);
+	return ____memcpy(dest, src, n);
 }
+
+#ifdef CONFIG_KASAN
+extern void *__memset(void *s, int c, size_t n) __alias(memset);
+extern void *__memmove(void *dest, const void *src, size_t n) __alias(memmove);
+extern void *__memcpy(void *dest, const void *src, size_t n) __alias(memcpy);
+#endif
-- 
2.20.1

