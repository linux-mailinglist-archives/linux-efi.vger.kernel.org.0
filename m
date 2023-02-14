Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E038696B66
	for <lists+linux-efi@lfdr.de>; Tue, 14 Feb 2023 18:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjBNR1M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Feb 2023 12:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNR1L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Feb 2023 12:27:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969042D67
        for <linux-efi@vger.kernel.org>; Tue, 14 Feb 2023 09:27:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qb15so39821608ejc.1
        for <linux-efi@vger.kernel.org>; Tue, 14 Feb 2023 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc4DRf/lL7c6OBQipEC8iJSNp1SJ2cHDwCIvwLDAn/8=;
        b=fvK2NzTSOAMGhqaddzi+3xvzpp82OQxS+gxnKKrSy/7jCYM+N0R/aaxAu2Tlo3icMq
         UfHnSWYUwIonwA89c5d70P6zsGY8+as1Ne6wsk+3GghU88JzpHS277ls5pDReuKeTMrx
         JkAddSg1MFGQ23MG3n1xNPPv9EGZFaMEk9xnoFp0wfaeuvu4oufeGQaT/iJoG5qC8oFI
         0wJx3dn6rtE0Nxq8D84wrBu+ya8Sm8mO9hyw2ZiloPVFYpcf4a+lHZ1A7sfzZvVf1LPf
         8eszr4/Ekzod0ByODr16Y9bDFgDqAuadXBshJeCWIMQAAuCX4Jwy9ya6LH6snVL00ZSq
         4/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc4DRf/lL7c6OBQipEC8iJSNp1SJ2cHDwCIvwLDAn/8=;
        b=KTYdFZidxhPBzYWqkOmJd+ZiqN+Lvb/6LywRpXb9DDS3EtRtAogzY9fSo4IpCR489w
         2xbpjUt1Rc44vJwTDLZKftbcQESGE7CGHy4S8y8ZNPkWTiNNqWkVkLe3/3si/xeFe9kj
         3jszp0dZAhdnTtUn5nW5sKtR29Tz05E0YGe+6kZMYaIL5GNFcLm9EkC57r/jy8K4gGKb
         3wW6hXTxbsBk7MetE/89xjHF7Q7VtwdJUCOxxkos2SxqwvPewqNcB58z/9aJLL8E5JMz
         2LDghdl6mK2lr7GawHIcljhq3VYSsDlVvPHf8LuDzRKY8Vc/LFTVdRTaFIzmkU5nxK81
         ASLA==
X-Gm-Message-State: AO0yUKVyY0bsr5+WojE0Cc0NiSRMlHrbxF6GhM3SW/+kIr2K5XCoM4Tb
        5RfNNMPXr6c9G4BnMYUrYss=
X-Google-Smtp-Source: AK7set9LtOybuP1tZ+emFeZqktZfxtS894JlMbhPPTww0x8uy6mIyyF5ZnHcW4lwfB0DKdcOiks7Rg==
X-Received: by 2002:a17:906:dfc5:b0:884:9217:4536 with SMTP id jt5-20020a170906dfc500b0088492174536mr3366556ejc.64.1676395629075;
        Tue, 14 Feb 2023 09:27:09 -0800 (PST)
Received: from darrell-Z570.home (dapali.plus.com. [80.229.150.88])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906490b00b0084d4b8f5889sm8484550ejq.102.2023.02.14.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:27:08 -0800 (PST)
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org, maxime@cerno.tech,
        hdegoede@redhat.com
Cc:     Darrell Kavanagh <darrell.kavanagh@gmail.com>
Subject: [PATCH] firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3
Date:   Tue, 14 Feb 2023 17:27:16 +0000
Message-Id: <20230214172716.4106-1-darrell.kavanagh@gmail.com>
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

Another Lenovo convertable where the panel reports incorrect orientation
to the kernel

Signed-off-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>

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

