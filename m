Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED27AC9F9
	for <lists+linux-efi@lfdr.de>; Sun, 24 Sep 2023 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIXO0t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Sep 2023 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIXO0q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Sep 2023 10:26:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35C107;
        Sun, 24 Sep 2023 07:26:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690f8e63777so1008186b3a.0;
        Sun, 24 Sep 2023 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695565600; x=1696170400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgWTrzjoY3sGlxnii74atqnIgdbUIfPkMFowVdxWBx0=;
        b=gnslyBqHtL+ACSsx942MbJwZ/6KEjSJTKd33Qq+yMtGUcycUiCm1yNGSHV4j5BEMwj
         dAP/30KTBSf5fGxRBiAKpifeDjl0lZNHtL0l8I3UQXXRM1AykjFkT+Ewm79AflksUxYr
         vbJ6eXjWJXAspNdXjBxUvZYVcGo2d2mwvoJonul/YbB7kG/I9BrQHsy1wA72Td1+giz0
         0pCNIWcZMOaQVT4rntppt8Ksm/WrWV75opBYO5P0+OuGl/p/i+9BpTkg7Q7GyMrtjZwE
         4429zailAy+1z5fv2f6SMpEZeQ8bI3PNc4Se3F60jArCR6+LOfrgRnCWF3nhoJGwNpD0
         1GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695565600; x=1696170400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgWTrzjoY3sGlxnii74atqnIgdbUIfPkMFowVdxWBx0=;
        b=Q57VcdmG8h3+qxl7zHfnxBE92lSWa60S9wUx91PDR9N+ptx1TUI8BE4y07T45LDM/G
         mcKHk/GXUVBY+/7C4JR9soUtSOW2wvNQdvSQ3Ak5TrFL4iqq1T3WjT2R0EWXhdsImNtJ
         aKEUIaBhNrqkeC95VUfg8yOUbFxO5oMUbZM0xUhjoNLOBRBfAPM3jK6HAgrpqwc7NlTX
         KAubSZ6RuVpzkRWgAf+8gQ1XsfFdR63pggAXa5t0gDaINYwJkDtMa7OWNOWM+aABux/v
         VIv1yRSWj45WUzb4XEBzsoXxmZojdpTN8a++4sSORvu1lcoVbUN/gn/cQti209mooUAd
         NnYQ==
X-Gm-Message-State: AOJu0Yy4fzlOi9neQEEbN33Wcx56h7xlaz8Vo22a4cBMkQEmATL1Ci0t
        IJ5TXO5L4W3iux5fEgnqgpA=
X-Google-Smtp-Source: AGHT+IE4gK9VmVit+w05RhD05sljoNnzS0SQYHlCpXHZxV6BCrWXbofcfjBEh6GMANTHGqbapxMUHQ==
X-Received: by 2002:a05:6a00:328b:b0:692:ad93:e852 with SMTP id ck11-20020a056a00328b00b00692ad93e852mr5780138pfb.2.1695565599613;
        Sun, 24 Sep 2023 07:26:39 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b0068aca503b9fsm6377210pfi.114.2023.09.24.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 07:26:39 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] efi: fix memory leak in krealloc failure handling
Date:   Sun, 24 Sep 2023 22:26:33 +0800
Message-Id: <20230924142633.1090000-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the previous code, there was a memory leak issue where the
previously allocated memory was not freed upon a failed krealloc
operation. This patch addresses the problem by releasing the old memory
before setting the pointer to NULL in case of a krealloc failure. This
ensures that memory is properly managed and avoids potential memory
leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/firmware/efi/efi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ce20a60676f0..1974f0ad32ba 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -273,9 +273,13 @@ static __init int efivar_ssdt_load(void)
 		if (status == EFI_NOT_FOUND) {
 			break;
 		} else if (status == EFI_BUFFER_TOO_SMALL) {
-			name = krealloc(name, name_size, GFP_KERNEL);
-			if (!name)
+			efi_char16_t *name_tmp =
+				krealloc(name, name_size, GFP_KERNEL);
+			if (!name_tmp) {
+				kfree(name);
 				return -ENOMEM;
+			}
+			name = name_tmp;
 			continue;
 		}
 
-- 
2.25.1

