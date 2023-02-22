Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AF69EE71
	for <lists+linux-efi@lfdr.de>; Wed, 22 Feb 2023 06:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBVFjZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Feb 2023 00:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjBVFjY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Feb 2023 00:39:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468AF3402E
        for <linux-efi@vger.kernel.org>; Tue, 21 Feb 2023 21:39:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n5so4018927pfv.11
        for <linux-efi@vger.kernel.org>; Tue, 21 Feb 2023 21:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=v2P8i10tN9N4ftFuujRjViMb7v95BAl1BRZ3f6ug9wqxssUaI7SVNE/1UjahEz/4w3
         36F6Tz+xIIn2J9yCqynx2wZNrJa8GALlu9HVIdDsVsZqRq2ri+5r/3mvFPSNuIyOVWRW
         GTqMH8cPhwYi2xdif2ra0JXycaKGuJxCcu/mAXMLaQGppqiH4gWh6f64ztwnCsXE+L5t
         GJ3RVaMjN32tBCTfgw0x/6+kWdEViZxsPCrOAJqQkxvJhitIePr50ktChlgmyu4VNYrw
         7WBVDEBKxNfBf6VPXR6e5vJi/D4MrddCsFmei9W2Q+akT3W7RAV91I/YgsVmbClDRok0
         JlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uLVfjCRzss/xwXNobW3aKCGuDntkGHej1tSNXCA8VQ=;
        b=l7iIPtmE/YKuskpAC5IETlMWbZsw8lXAzjGN7JZLIxZsa35WSBqP4CYOzk5O0xq50L
         IiMHBvKfwR215g3+oQg9qxJGachA9NKM4guzsfG1EXcVFzHPTLVCal7RCUcnN119dUP4
         +c4AuVhGjxadsDbK9NTBgL5S6lDtdq8bnRtdfEKJ5XwsryRc7NqYAkMyDeXmUkm6LZS0
         2ftsC6kbIdmCoIhiGqRyw1V2IOmjFCMYmbld6VcpfUU9EAx+DW1x+1Bsp36ikI4Lh6vr
         jaaicucmstrYsEDafC2C/97KmQ+PJ4FIgW4AqXHKts2T0Ji93DSg9J78j1gxpvHmN1Zt
         ACJA==
X-Gm-Message-State: AO0yUKUcJ/P2B1VcVk4nYvabPkH7sekoGrdv/3FzWUi+FTK7l1z9jce4
        nGCYPoB2bjjD1ySyrg5ekvFpJg==
X-Google-Smtp-Source: AK7set9NMn0QrWn2pOuo7EoSj/WuhfT2Xv5MDeDc2OBwYr6TcFbMjtv4rKm4aNTAgH9Ym68VeJjG2Q==
X-Received: by 2002:a05:6a00:2d1b:b0:5a8:d3d9:e03a with SMTP id fa27-20020a056a002d1b00b005a8d3d9e03amr7374216pfb.0.1677044361682;
        Tue, 21 Feb 2023 21:39:21 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b005931a44a239sm1107130pfo.112.2023.02.21.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:39:21 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v3 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Wed, 22 Feb 2023 14:38:23 +0900
Message-Id: <20230222053825.992-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230222053825.992-1-masahisa.kojima@linaro.org>
References: <20230222053825.992-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

