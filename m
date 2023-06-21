Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDF7382F5
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jun 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjFULpq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jun 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFULpp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jun 2023 07:45:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758EE57
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 04:45:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so4668895e9.1
        for <linux-efi@vger.kernel.org>; Wed, 21 Jun 2023 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687347942; x=1689939942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9diQLvSxjMs6xAGnA2pdApMjgni3zVWKA+Wt7BjIAVs=;
        b=Dy+0Xpykwbo8prZFI97d/boX6VfR8V7t3mPscGNYupuffVuSsN+OIVNiBfwuadRBPt
         dbBfLs1KQh1g2gAwl4OZKWwrHROh4D20WpcsiAjh7fIYsMLN+MKoxqnNmaRF4ZqAiv8g
         5ants6B6Fah9aVcwXA94xxFJfew05/+MhpB7qrb28/49u8QJVOFhgr6Pc0+pg4njlYDk
         ZZHaMoUkSMuOePdfBP1Zu3jNxKaeJHbZDkPvMxbcqsPcRY9Og1W8pfLvrcEkQ7yZa/is
         JmVvCps1ZO/NLB+npPy2sRFIKHlWMQwYv35RQVe3vg513lhxT2g8xFBn57uJvJFyHa9T
         yZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347942; x=1689939942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9diQLvSxjMs6xAGnA2pdApMjgni3zVWKA+Wt7BjIAVs=;
        b=Die9pX7QB3GQFAPnZ/ZTQ6HcbEvYWiOVmYXb09uHYZN+RnmlQB/o7veOhJ1qBWk7lA
         yreeB/cpwbxEQpYTJXqqhaineUfW65fYSfNyf+4A02UclTifYrD95dwVnKpBJDCHbdho
         tJ7BJwB03/BQYEt/UpadG9VKYbPUefGqiJmfYqXNi9W07XSAMHcyVrdxdRhPCXHGYX+q
         JAX+A63r5FnljVzB/QaTT7MDR3Q5jIbcBDQ5NJzONaEoHS/Zuc3qw0r84U/KCHvc0YwK
         zoBkaRSrJjMf5NonwAbEQaSmEi4wo9RKceINsL45ncrssAXpVvobgZEek/FjbM1vdYOy
         4QhA==
X-Gm-Message-State: AC+VfDxb9PbqQiIvapeD8pZkvDM80Xd4j/O0zTP1EiABCOiK4y9FaSeK
        sKRmRY98kFRQSj9YKIwQ79I36w==
X-Google-Smtp-Source: ACHHUZ63C8A9tBFwFaSb0q9aqCH8vASI4w0tziAQpjWmkdudk58m2FlYjqfU3UenpMRTKYaYHiEfFg==
X-Received: by 2002:a7b:ca57:0:b0:3f9:b4a0:6062 with SMTP id m23-20020a7bca57000000b003f9b4a06062mr4993654wml.24.1687347942509;
        Wed, 21 Jun 2023 04:45:42 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v15-20020a1cf70f000000b003f8d770e935sm16097220wmh.0.2023.06.21.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:45:42 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [RFC PATCH 1/1] libstub: zboot: Use -ffunction-sections + --gc-sections
Date:   Wed, 21 Jun 2023 13:44:39 +0200
Message-Id: <20230621114439.42851-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621114439.42851-1-alexghiti@rivosinc.com>
References: <20230621114439.42851-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Static linking is done at an object file (actually section) granularity,
meaning that if a function in an object has an undefined reference, the
link will fail, even though this function is not used in the resulting
ELF.

To avoid such failures, allow the linker to garbage collect unused sections
(which actually are functions).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/firmware/efi/libstub/Makefile       | 1 +
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3abb2b357482..6182366d00c0 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -40,6 +40,7 @@ KBUILD_CFLAGS			:= $(subst $(CC_FLAGS_FTRACE),,$(cflags-y)) \
 				   -ffreestanding \
 				   -fno-stack-protector \
 				   $(call cc-option,-fno-addrsig) \
+				   -ffunction-sections \
 				   -D__DISABLE_EXPORTS
 
 #
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 89ef820f3b34..5bb52d262133 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -51,7 +51,7 @@ $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FO
 
 ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
+LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds --gc-sections
 $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
 	$(call if_changed,ld)
 
-- 
2.39.2

