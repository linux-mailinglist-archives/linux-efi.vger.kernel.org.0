Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76869C4E2
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBTFR4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 00:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTFRz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 00:17:55 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388561B8
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:17:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id bm5so17135pgb.12
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 21:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=FOOSjPxXxRalsG/FfFvutKoI1IfjDfWqfeRd/MYF1sjyWd9BNAQovSlvY/YW8q86vC
         BKvFz3hlzdPw8T3/8LLmB3MV+u/mo0ZAC22MV0C0qCXbNqZAZYkoFO0x6Pj+45rEI7Bp
         AoEgfp8LAXhetHj+wjIY8QwowwMgAp17QDRZot9fIipxqsZ9rlI0vPJMeo/AEgyEMqty
         XoKigbwp2BiGMbUnyCQBFjHu5F/K1I3kdvBsqZpcBbIWm14Vl28vBwN7XfPCZJYFANSD
         dpvZ5yHslEC1dvVc52KDTZqYrPAOpkJyu2+h6f9sbyG3l0EfnzCD0qkSN+b0iYBo4w7N
         DemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=hb8LHnZ2+CqLpAGNuKjr0now0731USTOUt6p72I5OXGQSGeTTipc4YkcNuRkX9zkbI
         CF6ZZpR2WelYa+xW9YN0c3x71wDssBVVffv3qy2/bn+cJBw7MOo8t6fI68yrG34X5jUK
         buCZPtzD9UsN/4uEoSg6Kh6jgdSlrXq/VgteOLj8Uo/cAIkGH0N37zT3uZGWsCOIQPO6
         IdahOZvht0TOae3GjmcuX10jI26lhRQ1ROY3pUngk7WyWqtRKRWqPQpnHL45KFun/yfs
         86aIKys4+FBzm4ZvMcV3Cvj5wzeec9bwlGL8TMZMzjzRcyb3tBA4uomhdeomlgtdYYCq
         pfNw==
X-Gm-Message-State: AO0yUKWBBZKicfARCFWMWwf1DozCWDP5MDl8gB9CQEhTmXJbBeCo+XWR
        R9pL6X63bq5dzQCPRpqG5e2rAA==
X-Google-Smtp-Source: AK7set88AEEUXYS2DCLbtCZqhJUrr5X1jIUgwi+Zp/XMl5gzwPWEDFGv/8j42HOz5oPOQOHo0DBKow==
X-Received: by 2002:a62:55c7:0:b0:5a8:d97d:c397 with SMTP id j190-20020a6255c7000000b005a8d97dc397mr1331630pfb.24.1676870271304;
        Sun, 19 Feb 2023 21:17:51 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm3192087pfn.107.2023.02.19.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 21:17:50 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v2 2/4] efi: Add EFI_ACCESS_DENIED status code
Date:   Mon, 20 Feb 2023 14:17:20 +0900
Message-Id: <20230220051723.1257-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230220051723.1257-1-masahisa.kojima@linaro.org>
References: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 7e5239da87bf..c0f60dbb8a8c 100644
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

