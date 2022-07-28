Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1958412C
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiG1O24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiG1O2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:28:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C565D66;
        Thu, 28 Jul 2022 07:28:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j22so3491429ejs.2;
        Thu, 28 Jul 2022 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qxi1BsKPmynG3xfpNZLp6J5s/IWJprPFoEGd6KJx1s=;
        b=Dqobgjs1nII8eXteQLjz2ED1bVraj/SM6DyKm259IZRg1sN9fXwxKHIjnG2b0D3INP
         CJtDIdhUiiT3FrZ8VGIV5YyCY/B5CS56vg2LrtG2qoKAVoBPg5C5Rc4irrfAhqzUR8Gh
         +kybMZBZKngEWg1dyX5m4BVx0V2laC+H53UD1uGBiO18QUV/cjUgIsNB5O4VSdrtTV9W
         Cjr63Q11WQXEj+bfEst6CJpV6b6nywbFMPcaGL39fGMjwTeOGbNRQn9EtmKqq7ZN4xwN
         pF26gzooknPqRasWoevZQAJ4FehkqRleQDodSdYOcvnJ8YGzspu/VUm+wAjSwHvBT353
         9FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qxi1BsKPmynG3xfpNZLp6J5s/IWJprPFoEGd6KJx1s=;
        b=HBiH159v6FP5hmFNEK1MbJWvrDYIqVclT5Dl+AOO0iKd0yHrkxHnbsO58UF3dO770+
         hEF952flatyyhaMQX7pTelv6SWMFjW4K5pNdiwlOLxNqGzDT97hVFYlyapWCorZpMtWB
         0uy1lu/vysX5fUd+pQ312MxgwSDyR+FWIjCCVHCKb7RXa74Py+xi8/yCN9wztZVszwu1
         GTXHlYHs/+5b71YUB1HZ2jW2x48TesaXd4Emr5jK5yZkvg11JRqyK7k7lM5b33GMteZL
         KK7erNO0ijxdKiqNWS+huOqDTYzVhj2khydwnOiBS507h+9QHCqQKuGJKwlaVt1POxvM
         SAXQ==
X-Gm-Message-State: AJIora+rHdZaamCrYfr2AnIh9uK5Ad2uAfyA0RKBUHuj0fIWP6egv66r
        YAux1owDDUEwsfCbH1hbPclwCQiID5pQIKCj
X-Google-Smtp-Source: AGRyM1thhqvyGnz1B8Vxf/2phwUgpIo+oFuDvwayWQtnd+524pm6oLNhycj5/sutoRUawvMv1D4DGA==
X-Received: by 2002:a17:907:6089:b0:72f:56db:ccb6 with SMTP id ht9-20020a170907608900b0072f56dbccb6mr21020085ejc.318.1659018530972;
        Thu, 28 Jul 2022 07:28:50 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([23.154.177.9])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7d501000000b0043cce1d3a0fsm755949edq.87.2022.07.28.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:28:50 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] drivers: serial: earlycon: Pass device-tree node
Date:   Thu, 28 Jul 2022 17:28:18 +0300
Message-Id: <20220728142824.3836-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220728142824.3836-1-markuss.broks@gmail.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
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

Pass a pointer to device-tree node in case the driver probed from
OF. This makes early console drivers able to fetch options from
device-tree node properties.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/tty/serial/earlycon.c | 3 +++
 include/linux/serial_core.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 57c70851f22a0e78805f34d1a7700708104b6f6a..14e8a7fe54486a1c377a6659c37a73858de5bf0b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -304,6 +304,9 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		strlcpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
 	}
+
+	early_console_dev.node = node;
+
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
 	earlycon_print_info(&early_console_dev);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cbd5070bc87f42aa450c4ca7af8a9b59fbe88574..3295721f33e482124fae8370b5889d5d6c012303 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -349,6 +349,7 @@ struct earlycon_device {
 	struct uart_port port;
 	char options[16];		/* e.g., 115200n8 */
 	unsigned int baud;
+	unsigned long node;
 };
 
 struct earlycon_id {
-- 
2.37.0

