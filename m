Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F497697B21
	for <lists+linux-efi@lfdr.de>; Wed, 15 Feb 2023 12:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBOLvN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Feb 2023 06:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjBOLvM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Feb 2023 06:51:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B52698
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 03:51:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hx15so47485724ejc.11
        for <linux-efi@vger.kernel.org>; Wed, 15 Feb 2023 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtmOLRXgnRB1fQxx3Jha9wPJINvn6jn7vc917nESkKA=;
        b=YfgQlTD186paEe4pPesKVrbq6XGIwhgsYLDMI0X6kJ+iBpr1/I1M2BnClncHt2pIja
         qs0+dpLlzJB6JEixcv+ocGc+P5rU2eLl+BEMzn9GxKPnWruyknV8BjJfTPtDF/0EcsPb
         MASvs9MisN4yhPwJvcqG+wYQeJaY87CROef0I2uvgDuibcC59/oH8YqXMObJ5SSJy/3g
         f0ZrOB9zM1U8oHTbg29C/CgPzid7Cax2OCwSsoylIW4MHhAeAZcWN3gXQGsKYheyrIQz
         /a99dbHKCUb+YgJmgyb6lHkd6ZIwxUVWmVNYSvGbB8RtmwEespOFdQCVlPsuokloyq1m
         x9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtmOLRXgnRB1fQxx3Jha9wPJINvn6jn7vc917nESkKA=;
        b=1oEwPAZrf9LAAzrEn8HXIZaQf/J/7EVY5ZqqdR50M6DobZ7vqIZEzME5ArJ/zSCndd
         8C1FbnrkEdIeYmRv7wZVUZYk/6uEv/6CPyG0vN926H7HjlkW3dWfzQ4YoY+pgbSKW6rP
         nI/5rwXUl8qpcWrwbjAdVh5Mp1V+khIYLjjjyTFzH224YssToNwJZPRxhzeiflAksa6Z
         XVkgs4t9ayjEywP3bLed1s1DLT/JnFbvACfsuX5Yjo2vKqw3sT9uPa6a8I2Y5J6GnsRh
         M7WEmQRGmvlEAErAHY+lLPDp6Dmc1kV2vXfhzrPygavE1ZXw4X+bIUU2hMakwu48N2Rg
         cfzg==
X-Gm-Message-State: AO0yUKWZItRKfrQpNuNs1Y90il9Ona+Py0uFBg9FBtGy2QI8yKMWdjNM
        u02JVRltXh4b+MEApSovDSaGoEGBfbVlLQ==
X-Google-Smtp-Source: AK7set8sBJb4+ULt8wJIlsTP1a5RHd/5WdT8pNJAmOUV6NRi02N0Xdm9XPEMZVrF6uUhqqIGRQ1VjA==
X-Received: by 2002:a17:906:ce2d:b0:86f:763c:2695 with SMTP id sd13-20020a170906ce2d00b0086f763c2695mr1742554ejb.17.1676461869494;
        Wed, 15 Feb 2023 03:51:09 -0800 (PST)
Received: from darrell-Z570.home (dapali.plus.com. [80.229.150.88])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906344e00b008b13a1abadasm1320250ejb.75.2023.02.15.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 03:51:08 -0800 (PST)
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
To:     hdegoede@redhat.com, ardb@kernel.org, linux-efi@vger.kernel.org,
        maxime@cerno.tech
Cc:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Subject: [PATCH v2] firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3
Date:   Wed, 15 Feb 2023 11:50:45 +0000
Message-Id: <20230215115045.9396-1-darrell.kavanagh@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
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

Another Lenovo convertable which reports a landscape resolution of
1920x1200 with a pitch of (1920 * 4) bytes, while the actual framebuffer
has a resolution of 1200x1920 with a pitch of (1200 * 4) bytes.

Signed-off-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
---
Changes in v2:
	- Improve commit message

---
 drivers/firmware/efi/sysfb_efi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 7882d4b3f2be..f06fdacc9bc8 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -264,6 +264,14 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
 					"Lenovo ideapad D330-10IGM"),
 		},
 	},
+	{
+		/* Lenovo IdeaPad Duet 3 10IGL5 with 1200x1920 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"IdeaPad Duet 3 10IGL5"),
+		},
+	},
 	{},
 };
 
-- 
2.39.1

