Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58CB652FE8
	for <lists+linux-efi@lfdr.de>; Wed, 21 Dec 2022 11:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiLUKyn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Dec 2022 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiLUKyk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Dec 2022 05:54:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4CF20186;
        Wed, 21 Dec 2022 02:54:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f18so14522613wrj.5;
        Wed, 21 Dec 2022 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS2SuPyrrLQszLfTlNtHGbczRo/TVo6iehbioyR9aVQ=;
        b=V5g9bWYDeFiA79+HKnoNqj3Yrev9rnYg89t+lfD4CE7yyoy6A/NBcDsfmFhWul0zPC
         XDc1JLVjMnEPDvVhTn6fxwBTE96EKLlJSCjwaXsgARV3dYkyMXEZVIjg+U48zNHsMNK9
         bgerLFXI3daey7af/Q8IU3a1iErE/XGHuqpeiZeO15b9n3cAFRlTuWe9rFKR+q8gmTu/
         uJkQqcPeHSQh9wnCU+fwj/O436GrmycxV2r4YbGjUxkgBG+mWgnbFURsYO1q96q7/T1E
         KuUTEq2lKbAfkhe0WSDEnA7xfWpVsZ1nd5FHenfwuN8O6LIWqLkzF4a1VEnCTTqEBAU9
         9PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS2SuPyrrLQszLfTlNtHGbczRo/TVo6iehbioyR9aVQ=;
        b=oilS7gJMYcCLOaclsdJ9ogv8kARzlmpoUbsPee4ZB9FTvffXGqbKu4+auOlAYhF5zx
         qFQZpPlrgkawCA0A3R1HXpENwAXgU4LkjEULo2vNgYP2p9qxn6GTPTH1gwZ4td1HY/g7
         sX1jO9+V6yUi2PwFc99+Ifn8ZlVZQP26T0ZseuFAmZ2r6ilFThNf09ch+CkVRK8jlTxa
         z6KW/ZJn0xigIZfkenJSuOIqYD23MlqAgbItRMqL3D7MfrmXnCLrGA/pTVgqkFEa27kV
         tEVS6g9Dzxng9p66JUZ/X6BM3QhXkBDUy7k3euEINv3Hi/m5PG7iessaih7UFRVXa6Bw
         GszA==
X-Gm-Message-State: AFqh2kq2EwGS2v0CbUU+aVqZ/1FwRjHiUKq3+oJ+CV5AVVVJgzo2lSKQ
        8am5kvZY8kZq9U9MoviKB3fUoTh8NejBCA==
X-Google-Smtp-Source: AMrXdXsDx4mXzQ1l6DWUcUU5nf5+qfbEQQBy9kHLbjRKwCnT1eRKgeElBMlbjp5Bn+6qmj+Y4Voi5Q==
X-Received: by 2002:a5d:55c7:0:b0:242:5f1f:9d3b with SMTP id i7-20020a5d55c7000000b002425f1f9d3bmr909249wrw.16.1671620077591;
        Wed, 21 Dec 2022 02:54:37 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm15080156wrw.53.2022.12.21.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 02:54:37 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@protonmail.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/3] drivers: serial: earlycon: Pass device-tree node
Date:   Wed, 21 Dec 2022 12:53:58 +0200
Message-Id: <20221221105402.6598-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221105402.6598-1-markuss.broks@gmail.com>
References: <20221221105402.6598-1-markuss.broks@gmail.com>
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
index 4f6e9bf57169..0c7a789d7eb7 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -307,6 +307,9 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		strscpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
 	}
+
+	early_console_dev.node = node;
+
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
 	earlycon_print_info(&early_console_dev);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fd59f600094a..0b06c0ee7705 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -783,6 +783,7 @@ struct earlycon_device {
 	struct uart_port port;
 	char options[16];		/* e.g., 115200n8 */
 	unsigned int baud;
+	unsigned long node;
 };
 
 struct earlycon_id {
-- 
2.39.0

