Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8770D86A
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjEWJHM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjEWJGp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 05:06:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1818D
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 02:06:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso3081419b3a.1
        for <linux-efi@vger.kernel.org>; Tue, 23 May 2023 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684832802; x=1687424802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNbc2Gn4lCWbgtCz86CXU5/fu3n/2droTjC+nnxxbnU=;
        b=m3dxUrhr7ssgRxrCAnXnCiKgDYN8FVNpEG1YyZbv4SLdIGjLgsQGnUBkj9mbtZpseW
         worrOSfWPZSONyeV/X665KYq26WN+UhV5ll4mRUCEfv3J6mkqpbjGp40zJGXTYjOGlMI
         nWxa2a/az1+rQoG26sqlSUf0bKi9YMt5x2REdpKGAnUw3lwHBlkBpPbuUJ9BErVZxUlT
         VGF4ki/86wwgy4hR+eyrZS3BftXKUkKpTxD7/q7Lv9nuCpB0E8LqW+Sfq464PUIHj3NT
         zdGGTkKsOgx/VQ+ddPjGoGm4xAoPG18HgxtsR5qYKc8/x+WHyNkjpu/NEkPmKrJxWe4c
         I70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832802; x=1687424802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNbc2Gn4lCWbgtCz86CXU5/fu3n/2droTjC+nnxxbnU=;
        b=inJI1s7Y2cDayNK8BQWq01Zwe6zYJeFfASM1uLUzfmJ8BrBLZuK+4J2bjX9rMvW7VO
         kyZ3Y4sAve99OqxWnmCkrp90bkxnyteT4N/3XHOneKSEO2Jf4OCEsYJcJzq2sLIE4bD7
         AkCqh78F8O6JpkbRTwhEqSaLQpvTLNv6eJabiEgURTfwHTQRUfTGjKkUBMa0YYIYjOhd
         XRW4YLb7ZlGKIoYydumkqEtZadN8GGJmU6IOTROu2VO+rz44tfwwEbfbIGd8FIuxJpW2
         vxdRU/G4QAlv9U+skthGwu6VI191Zpiw9llc0ii80OUbmuQjbsfGiipXbk1dx3khs7m0
         0kfQ==
X-Gm-Message-State: AC+VfDzfO8VNN4svIfBv2fmaHB1TqPdvD3ymxxCjRvuv8+npy1UjktFB
        LbJVoozguS2B5KP4sYSHByVyuQ==
X-Google-Smtp-Source: ACHHUZ7OBzMGCd5AtWIGzVeJwMHrjBmKNnV5JqscoqzMJj+eGF9s5MY0iuG0V6bLOa5yYQbkI49TXQ==
X-Received: by 2002:a05:6a00:23cc:b0:63d:368b:76b4 with SMTP id g12-20020a056a0023cc00b0063d368b76b4mr19569935pfc.17.1684832802632;
        Tue, 23 May 2023 02:06:42 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78113000000b006410f4f3ecdsm5338195pfi.83.2023.05.23.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:06:42 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Tue, 23 May 2023 18:06:05 +0900
Message-Id: <20230523090607.1433-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523090607.1433-1-masahisa.kojima@linaro.org>
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6d6c5e384345..b3b74a5fb60f 100644
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

