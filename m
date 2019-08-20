Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A309527B
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 02:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfHTAT0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Aug 2019 20:19:26 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46929 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbfHTATX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Aug 2019 20:19:23 -0400
Received: by mail-qk1-f202.google.com with SMTP id c79so5229231qkg.13
        for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2019 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+olFNxFYhjL9QRL4ImBQxYfzLxvoDTRC2EU1toIBTB8=;
        b=g1htn3p5MZXFXzHIA+Jjt6jTrPQQXmo5akMJNxXZhfwpce3QyP067kNbJy/zfSbTxP
         cqz6lYhGVH0Y58/jTvOZi73Je+dj6hcnU1VPmFh5JWW26socuEY2ootWG3DEUR1iI5Nj
         FkuD5Sr2MnqIJJ0/mQ2m1R+Gatojxz/0YnCKFlSUhlohVO86a0EARley9S0ZUdIQjx2/
         PHareqg3wUQzuEQVwba2lcWN6esQv5jG3FrggakTQ/4Pq46kBazhFsDcmiyM2nxDFwVX
         7HJPcEoP4vJw5ivPgLu++46qCQuAEe782JNqba2Z2LlbukNPdEi26D4bMgjB2C4twbvo
         XJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+olFNxFYhjL9QRL4ImBQxYfzLxvoDTRC2EU1toIBTB8=;
        b=MjuyJ8wWAJGEPhvjLBkJ58eCtNYnAlhqMhwiapJEWY2nxzI/Vwr7F6Cxfk0EWONSOt
         S7n1xrF46GVjoXiAUNHaffHyEW6r+4v/4o0iGrx8gSOi4vlGYEZlF1r5HzxcS+k+Bu/S
         FbJgNIREIySuBHSc69kaE+ojsBhdVHY3wB9tbt9UKnCbJPM2RTr5nsj1uas7ZeVrvXmV
         WxQKfyDaNOlfBVcmFnkan1iqrL/Zsfg1L7bjnE4HJa/9y+a5K8S+vQ7xfA6eFX1+fnpv
         eqwJtYdco+DdnajSLBHc6l+8F9hxNTL3G/zBPdc+0oMlxo3D+Qawxzy3hpSVJg0c1l8M
         xjtw==
X-Gm-Message-State: APjAAAV7gojiEZDOFwk0lx0dTgjzmgLnXY3EIrJVNxWJFgs4oUEwCLpN
        frqI5xQbMAX9EdiCZT0xUmOCg1N+L1VDjELwhkXqEg==
X-Google-Smtp-Source: APXvYqyKVq6bwM7kYeFQvbD+BxIpXVpiuWJNkgMoBfKq9+4QIWBY0VIK8EebTXkq1faB4DrgMP8UwAK2DmoUx9lvKKRkxw==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr21987278qks.366.1566260362547;
 Mon, 19 Aug 2019 17:19:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:04 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7cf7bc0ded..5f98374f77f4 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -241,6 +242,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.23.0.rc1.153.gdeed80330f-goog

