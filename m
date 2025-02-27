Return-Path: <linux-efi+bounces-2856-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9BA486C1
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4A1889077
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443D1DE2B9;
	Thu, 27 Feb 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8Fa7aeb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6E1C5F1D
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677718; cv=none; b=pqSYyToso2ThPasUdD64SD/yBR0UkCqzAEIo8Lridt/pYADdLlyhNysuD+qBzwi61805tuxCedf2qR9S34/1QsSMWy3p7aE6c08AbVEhLFJd0q/GgNPZgLjv8vk012my4WaA6zjFqo+ewc1Nry6WdwWh+L8qePSaL88/fnESRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677718; c=relaxed/simple;
	bh=1uKJRk8rSFzySR4XkJKcvuochb3fMQnlj3kE46GFLPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J6BjxNymjJjLwh5KHa81vs9QnoYySx3nZFmYdLkaaLJ8YJJ9JF5+EVQDIjcJbvp9fjq2lrU8nG/ze+XWXOMIKmp8r+TAXKxovrq8y2qUIpHHpXTSGB0DQxlHLpgFPNupbvFDKasm9bWYfMkV+eKXisi9226mdNT4LQu9ozrjSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8Fa7aeb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43998ec3733so6663045e9.2
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740677715; x=1741282515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2HhjFWqC9QyyuYrEYhL+iJhqIItf+r/wFBiIJqdXlkc=;
        b=V8Fa7aebJP8dVZVg7h17Uc7y89cbTMm9xFQ777W4bdUXC+DS6/2TpvePzwUPAZiWOX
         y0r84QtBawky74TexpXBr3gWv29Ec79aO4fghB7mo7oQbOg5k00+agMBxiMpaLD8l+JD
         L7DniV9nwKs/YsjJf/uCBNbqDCex4osISDwhqjseXXPAQiRh8gEfYxs2h6dYM/ZU4Nz6
         zNeVqyowpSGjcWZyvfaF4HfuC+hlOMJp21Zs8clYsoAqKz9ZnqGm0JYnJA1NLxeXYx1V
         wvSN0CigCM4qh9CcTyPflv3SFCBTBixwzedXmte5MM6tkV9grsHhw4xSBJCeVtrECH0h
         ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677715; x=1741282515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HhjFWqC9QyyuYrEYhL+iJhqIItf+r/wFBiIJqdXlkc=;
        b=vff3Lr0zFxI69PlOBrherGYNxSjqwElHs5C1jy6pXeZhVDoltKmIXDkqWBHrvyAr5v
         kW5yR15cazmUQZ71qkSZDtvmAU7+LYTh7JTsJ6r8aJ0/i5Ddzkp8VNlCzxaRlvEd2MHJ
         PTz3FJJU74P3qNZvf/VOg7MXeNy6dReUkkY3qKInZmCSTMK1v9d8CBYBcQKsrvyTvlPN
         ZFybJPPqWmtYXukVmfnXb47OSehHTBeW170q5De49jG0hqvSE94HKTwGxlbusOvLrnKq
         0c8aH6zm8+gHyQ77V1IZMLRqafLyvj7qJPkGTckZxlNG5X9qrU0cjdTznNAaqPcDf94r
         rdUw==
X-Gm-Message-State: AOJu0YxFgJqH8bGtH9OaI8FIpOfhyezZC7Q1avSxjvvB58+s7OvniOTq
	CHHeM27xdFsnkdf6yPKgexQiYMyMGJMcMSDJP1Xozls+ylKrZ29rDq6r8bg1kRxJh7Ks1yqJiBr
	ZgOsjwvpXpk/+7ltROLik1Le3LjeXY3M1n3Milf/PUJleLzDtJtClZiyBcp2HEsQM+cEF0emIic
	XHVz4ZNFbK/KXH/G5yS8HunEn9rw==
X-Google-Smtp-Source: AGHT+IFRogC7Vk9j/07vOx2yhrS+HokYCyGyHwMc5adcTDHyOms4Z0Y6xScwWQYoTfsBFBj48wafGqOC
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:439:804a:4a89])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a0b:b0:439:8c80:6af2
 with SMTP id 5b1f17b1804b1-43ba675dc1emr340735e9.21.1740677715440; Thu, 27
 Feb 2025 09:35:15 -0800 (PST)
Date: Thu, 27 Feb 2025 18:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=ardb@kernel.org;
 h=from:subject; bh=FqxuuLU4GONmOhxVemlMvaacFUg/II5xynlGvKjChzU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3AIv+0d/d/BX1/ojfH+5NAzrK574LTp8eZLvmv/DS7Z
 s5euSXLO0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEJNYxMjTqzPwXE8+/jnVK
 /KdtaecdZzLMCvps1XJpbRSD1NtItRSG/4ms/VtTO2onl+Y+4Ig4dk94+5r5KzxVIxU1dRL0WRS S2AA=
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227173511.3237014-2-ardb+git@google.com>
Subject: [PATCH v2] efi/libstub: Avoid CopyMem/SetMem EFI services after ExitBootServices
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Given that memset/memcpy are intrinsics, the compiler might insert calls
to these routines unpredictably, including in code that executes after
ExitBootServices(). In this case, the respective boot services are no
longer accessible, and calling them will cause a crash.

So fall back to a bytewise copy/store if this happens to occur.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: preserve memmove() semantics

 drivers/firmware/efi/libstub/intrinsics.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/firmware/efi/libstub/intrinsics.c b/drivers/firmware/efi/libstub/intrinsics.c
index 965e734f6f98..418cd2e6dccc 100644
--- a/drivers/firmware/efi/libstub/intrinsics.c
+++ b/drivers/firmware/efi/libstub/intrinsics.c
@@ -15,8 +15,31 @@ void *__memmove(void *__dest, const void *__src, size_t count) __alias(memmove);
 void *__memset(void *s, int c, size_t count) __alias(memset);
 #endif
 
+static void *efistub_memmove(u8 *dst, const u8 *src, size_t len)
+{
+	if (src > dst || dst >= (src + len))
+		for (size_t i = 0; i < len; i++)
+			dst[i] = src[i];
+	else
+		for (ssize_t i = len - 1; i >= 0; i--)
+			dst[i] = src[i];
+
+	return dst;
+}
+
+static void *efistub_memset(void *dst, int c, size_t len)
+{
+	for (u8 *d = dst; len--; d++)
+		*d = c;
+
+	return dst;
+}
+
 void *memcpy(void *dst, const void *src, size_t len)
 {
+	if (efi_table_attr(efi_system_table, boottime) == NULL)
+		return efistub_memmove(dst, src, len);
+
 	efi_bs_call(copy_mem, dst, src, len);
 	return dst;
 }
@@ -25,6 +48,9 @@ extern void *memmove(void *dst, const void *src, size_t len) __alias(memcpy);
 
 void *memset(void *dst, int c, size_t len)
 {
+	if (efi_table_attr(efi_system_table, boottime) == NULL)
+		return efistub_memset(dst, c, len);
+
 	efi_bs_call(set_mem, dst, len, c & U8_MAX);
 	return dst;
 }
-- 
2.48.1.658.g4767266eb4-goog


