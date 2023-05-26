Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D6711C1B
	for <lists+linux-efi@lfdr.de>; Fri, 26 May 2023 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjEZBJT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 May 2023 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEZBJS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 May 2023 21:09:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11382E4D
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 18:09:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b00ffb4186so856305ad.0
        for <linux-efi@vger.kernel.org>; Thu, 25 May 2023 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685063349; x=1687655349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=FObbQtu4GFbmQuTgf6aAqO5O2uXBGL8UuGGP7kXn2zsY1ISyVb8PdD6gG4GoJko1+1
         DDiuo7mckH+RAh9/vYKFaq90VuUX/Fb6/BWPdRsk6x10KDb+oGvr4cysiU6Ursi0r/4X
         57l8o3oyYju0dXoXe1HJMhfPJqQrsos5g/YFIBbziGmBmneuFXjq8Ha26+cZIN3rdYtM
         cMeRiEeOoUyRIwpvUzcGoDK9cIphqxjmP2byAk789hLiM5dW14KTZ/89Imwajat5BVI/
         UBzeWFFiu18YqLINKSRPIcZBZJIhuSYZGH5Uke78EdOYGGQ4eJP/RriIaHM8C+uX6qE5
         0cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063349; x=1687655349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=OQoRBDFuXsRV+ajyXxNltLkuSZ5XlXQL1GKo2JXl4i91me4WQ5ovzkHP4SrYxzWqym
         k39vwBz4rI5nhiEkKMm0scUhoghrfAGTP1U05wlLZ5AKw6VTTZ4kjQMD0xbDtUIf55XE
         AvybXgkWEU9j0jmg7TUQPbtZ7ajVqUTp0c4L6N41kwmOdIEqOlx0jyQaeYg9frwI1pjf
         M6JJb7agHGpZRgvfh8D6G7r6turkMpXQrei6DyRkP1WTSRQyjIQPC/6M4X8zT3APpsyZ
         XMJFA/gwCSS0+joobmE+cceNnomEaGwX5GkfRA/DrgqI8Zv98ywnqcJDknI2ugAsrq4P
         J0YQ==
X-Gm-Message-State: AC+VfDz8E3/OXj4cwqlo12IaiCT9bDN7s1wcjpSyMCe9OBdGrlJAEIxu
        ore68CKo64QgQlBNXS7ec2n4tg==
X-Google-Smtp-Source: ACHHUZ73h7AvNfYSrL000FfhE5TFz9qtPzLZShVBDhPWXfxmPXt4P/y+jMX8/rJ9W3y0q1NgU6d+tQ==
X-Received: by 2002:a17:903:48a:b0:1a1:c7b2:e7c7 with SMTP id jj10-20020a170903048a00b001a1c7b2e7c7mr554460plb.49.1685063349368;
        Thu, 25 May 2023 18:09:09 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001a687c505e6sm1981016plb.232.2023.05.25.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:09:08 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v5 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Fri, 26 May 2023 10:07:46 +0900
Message-Id: <20230526010748.1222-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230526010748.1222-1-masahisa.kojima@linaro.org>
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
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

