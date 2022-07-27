Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C7582835
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiG0OF7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiG0OF6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 10:05:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5E5F58;
        Wed, 27 Jul 2022 07:05:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id mh14so12977947qvb.1;
        Wed, 27 Jul 2022 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7sXk1x+mAlIVnjI6mSnBUc3PosDoepD30XFI2Dsmk8=;
        b=o03vaz9SgZGF20HFejqu8j4uk14t+1+Ntu8f8HX38wHE6fda2DYCQTbuj2RG5re4ll
         CZAinx0CB9KAOb6xR72buzUfZqho5Vg3XXffxwUrvYdC/lrwabGCRM4bEG4hPe6JEOV/
         4E4ginhpyjdaE20FIubMwiaPeIRIReKh9QChah53hBBb6g7mVPTbeBdUrwarbtq3PWm8
         KVqjnJ5zDWt7D4aSLMhLc0kFp6dUvMXmmv6EsPZYsr9wLeUqEfm+xgl+tYaifsP+aiRq
         NQnIARacSJgYXRzG+qsTuv7W9mxZoEy0MTB4pYDDpg0rz4dlTDOeCWBQj6i4QXqOA3Ji
         rvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7sXk1x+mAlIVnjI6mSnBUc3PosDoepD30XFI2Dsmk8=;
        b=EM25ENfm3w1R6lQIKG384aV7i7j5TSDgWCy2JTjT+dypYQufUuUvUwYuQkNdFnyLHJ
         UmCyhlgxi8xrUX3tJcUn4kih2Wzwpopn5lLPW9iPqezG5QQn9bkCmnd3Uuju9zFoa4Vg
         C2l8AQcVe8bnV/FSUcCV8ZAp9I3t448UEKKTKcpelfygd0V5sHibGEI5n/8oOBMQrdk7
         gY+TWDGo1uE0tQxJfZjZBQlF/5ESKp5xjuHP3hDprvlPzwV49PgnVEB0feiILyPMWiIz
         58UnZTmTIkiM9xMr7Bmxbrf3HroKaMJRQxQ7GxQcVqsQoxhFuetEQ3+OKqL5k/rMj9pR
         YGjQ==
X-Gm-Message-State: AJIora8ixmN+h2SUiipo75XAyPIp50MJwKRqNE0VnTUDUGcgtxsXaRYv
        dg3F945el6msHmJ5BrYp0gMfq1DD/Ws=
X-Google-Smtp-Source: AGRyM1vhQ8zosTUVzYGVDlCdLsHQaHX3U9IIZfJxtNNoYlp4pYrpAnjXqd+GZ9j7fGo2+Ke8o74/Qg==
X-Received: by 2002:a0c:b2d0:0:b0:473:2c19:f1ee with SMTP id d16-20020a0cb2d0000000b004732c19f1eemr19103337qvf.130.1658930756307;
        Wed, 27 Jul 2022 07:05:56 -0700 (PDT)
Received: from mimieux.lan ([38.126.102.198])
        by smtp.gmail.com with ESMTPSA id ci23-20020a05622a261700b0031ed8ef7982sm10829015qtb.22.2022.07.27.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:05:56 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessos.org>
To:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux@endlessos.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= 
        <jprvita@endlessos.org>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: efi-stub: Fix paths for x86 / arm stubs
Date:   Wed, 27 Jul 2022 10:05:39 -0400
Message-Id: <20220727140539.10021-1-jprvita@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This fixes the paths of x86 / arm efi-stub source files.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessos.org>
---
 Documentation/admin-guide/efi-stub.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 833edb0d0bc4..b24e7c40d832 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -7,10 +7,10 @@ as a PE/COFF image, thereby convincing EFI firmware loaders to load
 it as an EFI executable. The code that modifies the bzImage header,
 along with the EFI-specific entry point that the firmware loader
 jumps to are collectively known as the "EFI boot stub", and live in
-arch/x86/boot/header.S and arch/x86/boot/compressed/eboot.c,
+arch/x86/boot/header.S and drivers/firmware/efi/libstub/x86-stub.c,
 respectively. For ARM the EFI stub is implemented in
 arch/arm/boot/compressed/efi-header.S and
-arch/arm/boot/compressed/efi-stub.c. EFI stub code that is shared
+drivers/firmware/efi/libstub/arm32-stub.c. EFI stub code that is shared
 between architectures is in drivers/firmware/efi/libstub.
 
 For arm64, there is no compressed kernel support, so the Image itself
-- 
2.20.1

