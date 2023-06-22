Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376F2739ACA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jun 2023 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFVIwW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jun 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFVIvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Jun 2023 04:51:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1831BF9
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:51:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso3724750b3a.2
        for <linux-efi@vger.kernel.org>; Thu, 22 Jun 2023 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687423910; x=1690015910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=lRMPoKgteboi5BDLXq9IoGL6fdATD5xL9QXWbSWrPG4INfl4WfM46TLpOTcaotd8Q+
         mzxc6tAyND+TXkB14zDUIt4aAFBjIUlo3rh0gm86sO7O2yfq6fSpI16MxwXZEKzLXcuq
         JTjIHGIDs4IoBnRXfMzpLwzhz4ysPd4P3jwqIDALJEnkszIPCZlVNKU3pX6Ch5X0Qclr
         T8P2Fh6RqzN968RbXJdISWq2ffH8UyeSdMxFAAwRG5fN9hDI4x6Fb8XV2uvcL9Tf8l+N
         6hV9pc9uP+FKX4TgusQLJS6iE6OoGveeKPdJ3GRbkahbczaDzMFULkUTH8BA/mStNHaf
         Em3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423910; x=1690015910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=frvvof1H3BQMwM8Va3rgw+UwYPVz+FFf4OcKh5081pHfNfX2l8z5Q51izFXh7frAV/
         q4f3L3a9Cu12oY5wjdOQ2+Xdvw72Cd7DRjz0rBMZdM2CVALWGhUzBFBJ087JO342A84q
         SNjn3u6U3HhifdyNu5w8qr1EUdiqerETitl3XRcUZa7cbbeVYJd6rMA4wQhxFNXHVmVd
         TEHeNPrWX1X4MkNXg1mHvjryclOvafjJxmla17pcrW8zUF/tgR57Bi2Gc8tHNXUl9rU3
         4od+LtkaP7SqXH2IHhrlg8pRF7E2MPw2pb+11ELx6HAcBc4EuVZXb0z1kvG9WrEkQ+Zu
         56kA==
X-Gm-Message-State: AC+VfDwkjJsNF1spbGAcPAiJYswzotQdXzo/9JwdMqK4PpcXX6yX78Nf
        HYzlowcaOP+NeCEhLzBUwH7zvA==
X-Google-Smtp-Source: ACHHUZ5aqPSlp75sei5U+RBORHyQ+4lHkar4bjIvj4XEGqp+xY+SDdIoG9/FmjhTGr+qvI+UQWosRQ==
X-Received: by 2002:a05:6a20:6a26:b0:121:f190:e5ba with SMTP id p38-20020a056a206a2600b00121f190e5bamr8947239pzk.16.1687423910170;
        Thu, 22 Jun 2023 01:51:50 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b02bd00c61sm4820154plg.237.2023.06.22.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:51:49 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org
Subject: [PATCH v6 2/4] efi: Add EFI_ACCESS_DENIED status code
Date:   Thu, 22 Jun 2023 17:51:09 +0900
Message-Id: <20230622085112.1521-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622085112.1521-1-masahisa.kojima@linaro.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index b8ba9c5adc7a..657f7e203374 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2

