Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F9367374
	for <lists+linux-efi@lfdr.de>; Wed, 21 Apr 2021 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhDUTc2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Apr 2021 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhDUTc0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Apr 2021 15:32:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F89C06138A
        for <linux-efi@vger.kernel.org>; Wed, 21 Apr 2021 12:31:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd23so56528812ejb.12
        for <linux-efi@vger.kernel.org>; Wed, 21 Apr 2021 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXVhnwT23D/qpAtyx2UOpz422ajD7V5LrdFOfsaVYc=;
        b=TFO2BuTEkby0ABFf1OkYK/1D90LhANve4lIJJ88/sKZDsAJPhoQCSO6f82qhRXN6ec
         CgCyxKIrUZTopeueP681KmvgiJ8Xrqm0WA7FASO/sO+pV5OxEEkbRVNqbAvDGYZQi23f
         x6FX3N+GdEEGDOfY323qyIWLzzEsmsepQ9XoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foXVhnwT23D/qpAtyx2UOpz422ajD7V5LrdFOfsaVYc=;
        b=MfE5wanj9tCjmEpt8rMVLH5myesw4GPCkxo8MhNKnafgfsgmzX7IjbXWUTsYlguGSY
         z0fcjR1WA6CwSJ8xh+q6QncfMvgVeXm88/BihEUtfzIzbrBY2bl+OvNpP8eWaqoeVy8T
         0KH+p8s/ggqtGqhKeO6/zmwc2ZN38V629EN+EI+R3lUzNePTTBgHTWqJZ+Y4BhlrG1PY
         ijlSxnwUWAgQKZ9BKif86BeQkAdzhwND1s2imtyuzHA1FWLmZAUHJl2wcvr9iyPmT/GL
         svh119DDnjDHAeql+XQ6o794eEZMKwdpUNqHBxoqaegg7WmkQzMhrm0z8NbkDREjw0dH
         jMPg==
X-Gm-Message-State: AOAM532lk5qJfWkz9bVqZ40ErmG4x0xhHv3TkrzfFGdZToAgBar0Seav
        yPTYHfypFeZeMNYlyuHbXfIoyw==
X-Google-Smtp-Source: ABdhPJzrmiWm8xqN10Pgm6ApQ10O3qhZBNiRi56u9Q1ia2YUMP15g1RqZs30XvuXJlWLsHsUwui6Yg==
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr8143866ejj.523.1619033509937;
        Wed, 21 Apr 2021 12:31:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id z6sm284781ejp.86.2021.04.21.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:31:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alex Kluver <alex.kluver@hpe.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi: cper: fix scnprintf() use in cper_mem_err_location()
Date:   Wed, 21 Apr 2021 21:31:46 +0200
Message-Id: <20210421193146.1539649-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The last two if-clauses fail to update n, so whatever they might have
written at &msg[n] would be cut off by the final nul-termination.

That nul-termination is redundant; scnprintf(), just like snprintf(),
guarantees a nul-terminated output buffer, provided the buffer size is
positive.

And there's no need to discount one byte from the initial buffer;
vsnprintf() expects to be given the full buffer size - it's not going
to write the nul-terminator one beyond the given (buffer, size) pair.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/firmware/efi/cper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e15d484b6a5a..dfa0bd140bef 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		return 0;
 
 	n = 0;
-	len = CPER_REC_LEN - 1;
+	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
 		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
@@ -258,13 +258,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "responder_id: 0x%016llx ",
 			       mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
-			  mem->target_id);
+		n += scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
+			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		scnprintf(msg + n, len - n, "chip_id: %d ",
-			  mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
+		n += scnprintf(msg + n, len - n, "chip_id: %d ",
+			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
-	msg[n] = '\0';
 	return n;
 }
 
-- 
2.29.2

