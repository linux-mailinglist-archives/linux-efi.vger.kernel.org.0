Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91958B6E2
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiHFQeX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 12:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiHFQeT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 12:34:19 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662912AE1;
        Sat,  6 Aug 2022 09:34:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h138so3959043iof.12;
        Sat, 06 Aug 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SaUBoqntZ3xpwrUzgeOy0DwQIiOjlZNYBHlnYS80ldA=;
        b=ALOJApgiU1Bu3FBCE6WOR5MxyhMFROfvC2N4q2QgxbdLU8q5Oz6ouEKcxRaLJXRvm2
         u4X1wlQszDadkFj1NVcSc2LBAot93rNmccBTeeZQvnjT5sFyawYLZxOiiFGCx1qHtA9Y
         rt2WpaBNi9ispLb4kU+UPMPeTIV52hJ68eHHc3jHHpnROX/dDCvv3NyGJRDuCmErtkZF
         fM9CZacWKhb8Gdr7qb62NorcVrVZgfgxa/qI5WaUTQLuJ5MoLskJKQO91Zovgdc/LhZJ
         QxyoAryeDy01p1QYDyvYi7bHwzQyCWOQ+/vR82/J9aUf/tInw8ceycHXAF2AV7MJUHM3
         0sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SaUBoqntZ3xpwrUzgeOy0DwQIiOjlZNYBHlnYS80ldA=;
        b=N1amumODcw+Kbu9dmyI7A90U3dcToZGX8i11It896ClfFjI3x71YBjbunJjAEmnLeZ
         P7NchMR6rPfbHMX3htMlwzL+8vuDEGi8MnhZCiSHpxDqIvG+yCmOpN+pCrMpqj22cMTY
         HEBcMFjpaXgcOEeH22xwVKKlyEbitZseE7X1Wa1mhr7DpJXZiDFTyIfI1cYX7QW/Rlfl
         oHXraW3g9RBAnjZPdKUTcTJ8FgvHXypr21Wh4YXD+oZaTsKo10hjoD79iY2EtVKNwNpn
         7hA5EIsjTI3yl3UuC1LszGelT2sSETno5+Q+/VbCwuYBxxf/BjMHhUQNei30qL9mqcSz
         5vog==
X-Gm-Message-State: ACgBeo3BmjCXM0YLQcBGAK6k6dEsMIBf9vs5JWhVEdzF0IPonp9vSpOf
        BgzWWFvXELOHYS+PCAwPm9JX+052YNtqVsjd
X-Google-Smtp-Source: AA6agR7DiKfCMvxm+CA/RzSBpZzX9VjXHcm3LmI4qDSBMzjn4WzFx9p3rf/PMs3V8fkzCvhnxs8qUg==
X-Received: by 2002:a05:6602:2c01:b0:65d:d998:680c with SMTP id w1-20020a0566022c0100b0065dd998680cmr4791990iov.132.1659803657459;
        Sat, 06 Aug 2022 09:34:17 -0700 (PDT)
Received: from nergzd-desktop.localdomain (tor-exit-50.for-privacy.net. [185.220.101.50])
        by smtp.gmail.com with ESMTPSA id a20-20020a056e020e1400b002de6fa0d0c0sm2908009ilk.63.2022.08.06.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:34:17 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] drivers: serial: earlycon: Correct argument name
Date:   Sat,  6 Aug 2022 19:32:22 +0300
Message-Id: <20220806163255.10404-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220806163255.10404-1-markuss.broks@gmail.com>
References: <20220806163255.10404-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The "node" argument is actually an offset, and it's also
an "int", and not "unsigned long". Correct the of_setup_earlycon
function.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/tty/serial/earlycon.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 57c70851f22a0e78805f34d1a7700708104b6f6a..bc210ae8173d97d5ef422468acf2755a853cb943 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -244,7 +244,7 @@ early_param("earlycon", param_setup_earlycon);
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
 int __init of_setup_earlycon(const struct earlycon_id *match,
-			     unsigned long node,
+			     int offset,
 			     const char *options)
 {
 	int err;
@@ -255,25 +255,25 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 
 	spin_lock_init(&port->lock);
 	port->iotype = UPIO_MEM;
-	addr = of_flat_dt_translate_address(node);
+	addr = of_flat_dt_translate_address(offset);
 	if (addr == OF_BAD_ADDR) {
 		pr_warn("[%s] bad address\n", match->name);
 		return -ENXIO;
 	}
 	port->mapbase = addr;
 
-	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
+	val = of_get_flat_dt_prop(offset, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
 	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
-	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
+	val = of_get_flat_dt_prop(offset, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
-	big_endian = of_get_flat_dt_prop(node, "big-endian", NULL) != NULL ||
+	big_endian = of_get_flat_dt_prop(offset, "big-endian", NULL) != NULL ||
 		(IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
-		 of_get_flat_dt_prop(node, "native-endian", NULL) != NULL);
-	val = of_get_flat_dt_prop(node, "reg-io-width", NULL);
+		 of_get_flat_dt_prop(offset, "native-endian", NULL) != NULL);
+	val = of_get_flat_dt_prop(offset, "reg-io-width", NULL);
 	if (val) {
 		switch (be32_to_cpu(*val)) {
 		case 1:
@@ -291,11 +291,11 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		}
 	}
 
-	val = of_get_flat_dt_prop(node, "current-speed", NULL);
+	val = of_get_flat_dt_prop(offset, "current-speed", NULL);
 	if (val)
 		early_console_dev.baud = be32_to_cpu(*val);
 
-	val = of_get_flat_dt_prop(node, "clock-frequency", NULL);
+	val = of_get_flat_dt_prop(offset, "clock-frequency", NULL);
 	if (val)
 		port->uartclk = be32_to_cpu(*val);
 
-- 
2.37.0

