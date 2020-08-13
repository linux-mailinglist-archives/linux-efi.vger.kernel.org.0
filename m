Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF919243F0F
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMS6P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 14:58:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42514 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgHMS6O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 14:58:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id c12so5176663qtn.9;
        Thu, 13 Aug 2020 11:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GH4hjr+KtlyXRPJQ7rmAwftHj2VvTfyj8hXxXoMFuY=;
        b=RIUTiOKF654q7oexEIvEhJVIVZBX82gdEiSNXnbTkQp7VyWgJl5sgE8wdI5C8B7Uca
         bDdJsdLFtv+vMKooENpijT2n5ghDPI9x7wV3dwcvqjfdLlVnM/XzBz/WGoEgUkmFaOCN
         ht2Pag8+y/CZvSiMnrv6Dfr4sjJ3pvKqEtDZE8YeX8LGuqq7kYVSkYOgm7fLKMk0DHAf
         /dx29JpChiJ4SYjwutLnaQRPOPXaH9Emamywkmv86gjz5MjyRodjohFAYuLpeOsDJ3VO
         4z+mxg8LSf89Wj5dGJakbY76GXgk2LXasQWKl9FklDTM1eepf6QKpf9CJObey2QKw1kp
         ZnWg==
X-Gm-Message-State: AOAM533/L/aUYwVtnR25Lsb0c7JwpxwqlTl6aXEFEnnJM2bDtdrZ+xHW
        P3WBdulOmTQYXoTreeVzdxqYhuT9
X-Google-Smtp-Source: ABdhPJyWhUAkCXpZL1VDPN/OtyACJnk0nF/Csxqr5jYpSNHVsE5iwWV4ayGAD6OgCBxaKRVJ9gWldw==
X-Received: by 2002:ac8:2ab9:: with SMTP id b54mr6754004qta.323.1597345093442;
        Thu, 13 Aug 2020 11:58:13 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm5994563qkm.44.2020.08.13.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:58:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] efi/libstub: Handle NULL cmdline
Date:   Thu, 13 Aug 2020 14:58:10 -0400
Message-Id: <20200813185811.554051-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813185811.554051-1-nivedita@alum.mit.edu>
References: <20200813185811.554051-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Treat a NULL cmdline the same as empty. Although this is unlikely to
happen in practice, the x86 kernel entry does check for NULL cmdline and
handles it, so do it here as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 37ff34e7b85e..f53652a3a106 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -187,10 +187,14 @@ int efi_printk(const char *fmt, ...)
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
-	size_t len = strlen(cmdline) + 1;
+	size_t len;
 	efi_status_t status;
 	char *str, *buf;
 
+	if (!cmdline)
+		return EFI_SUCCESS;
+
+	len = strlen(cmdline) + 1;
 	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, len, (void **)&buf);
 	if (status != EFI_SUCCESS)
 		return status;
-- 
2.26.2

