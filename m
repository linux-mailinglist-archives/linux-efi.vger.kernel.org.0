Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73455B277
	for <lists+linux-efi@lfdr.de>; Sun, 26 Jun 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiFZObD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Jun 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZObC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 26 Jun 2022 10:31:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7190DF4A
        for <linux-efi@vger.kernel.org>; Sun, 26 Jun 2022 07:30:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n10so6105029plp.0
        for <linux-efi@vger.kernel.org>; Sun, 26 Jun 2022 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6A7GlUDHwL3WxTiFrXiqzQEKwaRgCN/xddkMAihvOHQ=;
        b=Q1FpL6Sn0/+A2SCWBdmRB3iPpf+dxEzhIxlrqTb2ddhmTpT0gSNUyEfy2WlC3G3Wvr
         qM0Y9hnVNX8HCH2gL++jpG/LffDJl8c2QTHA/df7/VpYJwzluH4NDWOkGobGJ78/KCGa
         A14tZgfQUZ2Y7/hMkwaCBWdFxpP2kWA9p+tPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6A7GlUDHwL3WxTiFrXiqzQEKwaRgCN/xddkMAihvOHQ=;
        b=rAsmi1AnCyM4ENPmvo1Nw32XyU/XNynNEVL3yaPpK2fomIwz66vTDzKPqvawP5ZmpB
         OZ/iGW5d9EkFqZdm/D6HZirD3/DqLMU88LWqW97NrO7Ghp5g2DygD+k3GLWBwPC36Pzv
         gq3qM8N2QLE905FqRR1H3pan/GUqVf7v1PZ+Has7xyLQZTscdmXWofC0yBEDeYt/5XKq
         diqfCEQoPo9T+AAKsVwkzHVK+DmjIRyO7JP6x+mejohPIKXcwj6ktUMMa1pe3pBOqjYd
         jNHCQVpBxV+oyep47bERjraRHFAUIdEXLkdoY3uXgUJA2C0oyeb9tp+3T0LYlLWHlxx3
         njOg==
X-Gm-Message-State: AJIora99S6JfxSKqX0jJkbfRZExIW3ImPF5aS+wQhjB3HTTeGHQegM5n
        ybTbOqfgTBL6DgC3JUxKHtQLmQ==
X-Google-Smtp-Source: AGRyM1t4gGjROKICNOpgyOa3jVkSukQo73KSNLM2IlabJLyxHYH95zQ4g7btjtASIxbPltIrsG7OOg==
X-Received: by 2002:a17:90b:1d06:b0:1ec:cd94:539b with SMTP id on6-20020a17090b1d0600b001eccd94539bmr9938725pjb.215.1656253859348;
        Sun, 26 Jun 2022 07:30:59 -0700 (PDT)
Received: from DESKTOP-65TREBA.localdomain (118-161-192-248.dynamic-ip.hinet.net. [118.161.192.248])
        by smtp.gmail.com with ESMTPSA id a27-20020aa794bb000000b005252a06750esm5294678pfl.182.2022.06.26.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:30:59 -0700 (PDT)
From:   Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
Subject: [PATCH] drivers: fix typo in firmware/efi/memmap.c
Date:   Sun, 26 Jun 2022 22:29:58 +0800
Message-Id: <20220626142958.5790-1-kevinjone25@g.ncu.edu.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch fixes the spelling error in firmware/efi/memmap.c, changing
it to the correct word.

Signed-off-by: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
---
 drivers/firmware/efi/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 4df55a55da84..7ff9f1e911e1 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -245,7 +245,7 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
  * @range: Address range (start, end) to split around
  *
  * Returns the number of additional EFI memmap entries required to
- * accomodate @range.
+ * accommodate @range.
  */
 int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
 {
-- 
2.25.1

