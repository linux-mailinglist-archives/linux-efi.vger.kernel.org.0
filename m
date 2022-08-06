Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB758B6E7
	for <lists+linux-efi@lfdr.de>; Sat,  6 Aug 2022 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiHFQef (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Aug 2022 12:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiHFQef (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Aug 2022 12:34:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24E11453;
        Sat,  6 Aug 2022 09:34:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p9so1489107ilq.13;
        Sat, 06 Aug 2022 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lQzsDSHH/Bii36GW148CpzzSSa0PYzrLw0cKTC8v8kk=;
        b=hFobmJQK6P0zU3BwVaJVOeRfR8NjKJd0BpCBeJV8Sv60LNy1tvgi4Hk8og/34srU3k
         eS7VOeHEv8DM21kQAlThdmquREUGhJWZIyHuXcQUhNBP8e3T/jfREWt/ZUs9Sdj+qkhy
         yjHhdJWbGEyKadKAP6Vj44sBZ1bKbCRmBpgFJQJ08E7tnf8Wpemw7VNHbFdYMJ48ONFC
         5Gwj275ZOjz3goTKvLPQeA0Zl8IcMLk4Xyup5NmFma3pkWx1ufB41aMDkMZ6e49PvTqv
         EMW90DQQTQb8XDvEwxbzO6THMs1tNkoVIUE0GiZ8y8XKZXMdsGRMgftZH9K+eq1QpXK1
         assw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lQzsDSHH/Bii36GW148CpzzSSa0PYzrLw0cKTC8v8kk=;
        b=e+q+P+bD2IeP7bVNGK/pSGjZ06o4dlQb/7/gzPwYEsxDWPXJd5IySPEfSmvJ8c6Q9G
         CFVWu27YH/cxBCdWWUzjoLXQYNsnesrBhi8hgJTrzSw6mNKlzibvIOxXdbMPmAWeY+WK
         1OuFoZJiYwGJ1bTh42lbAgbK7x63IwUBZeNaG5ASKcrpTrlbFOCa9rrqFOHLmcc3VQBk
         KRmSHacZURgCkgQlrv7rY79XM7BUI5R/dMviwbHtKDiBsN3ZEmH7V4gvXmC8opl2Lik4
         rx3NaR5LVIoKqW/BKQuGiLnVUN0VpgyfETa8cfz0FBr6xy6uQp0PC2E+COiH/ZvMzjno
         1pWg==
X-Gm-Message-State: ACgBeo23WlXlrynw/6nbWbPsjLK9GCVGDRyMo0M0agwPSrOMpUf3UiYA
        XnEZgWrn1AytWqNLSGXJQRcOh5uOji8r2kwY
X-Google-Smtp-Source: AA6agR5CMSPTnUTrWYTukW0U5sy4javWSpA0m81oq3pZpfkjgXKOFa2aByaa4rMOqVFbgga7cPkFag==
X-Received: by 2002:a05:6e02:1a81:b0:2de:a8d7:de0c with SMTP id k1-20020a056e021a8100b002dea8d7de0cmr5324479ilv.309.1659803673460;
        Sat, 06 Aug 2022 09:34:33 -0700 (PDT)
Received: from nergzd-desktop.localdomain (tor-exit-50.for-privacy.net. [185.220.101.50])
        by smtp.gmail.com with ESMTPSA id a20-20020a056e020e1400b002de6fa0d0c0sm2908009ilk.63.2022.08.06.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:34:33 -0700 (PDT)
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
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drivers: serial: earlycon: Pass device-tree node
Date:   Sat,  6 Aug 2022 19:32:23 +0300
Message-Id: <20220806163255.10404-3-markuss.broks@gmail.com>
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

Pass a pointer to device-tree node in case the driver probed from
OF. This makes early console drivers able to fetch options from
device-tree node properties.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/tty/serial/earlycon.c | 3 +++
 include/linux/serial_core.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index bc210ae8173d97d5ef422468acf2755a853cb943..be2f01520f6608f6ece725dd83d2526e30477b47 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -304,6 +304,9 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		strlcpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
 	}
+
+	early_console_dev.offset = offset;
+
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
 	earlycon_print_info(&early_console_dev);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cbd5070bc87f42aa450c4ca7af8a9b59fbe88574..e65b9aba4e5fdaedb560d2cbbf326a11cfecbcac 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -349,6 +349,7 @@ struct earlycon_device {
 	struct uart_port port;
 	char options[16];		/* e.g., 115200n8 */
 	unsigned int baud;
+	int offset;
 };
 
 struct earlycon_id {
-- 
2.37.0

