Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF67499B3
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jul 2023 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGFKtB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jul 2023 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGFKs6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jul 2023 06:48:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD21BE5;
        Thu,  6 Jul 2023 03:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42017204E4;
        Thu,  6 Jul 2023 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688640535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yN2iGJzPRI5qeaMkkVQG1/mfO37rIiV1XHtVYwXdmk=;
        b=QsKVTUAZs9bZ1Zqds/Rr99SwmMWTBA7dJIpiJOcfOiVr9PaiDz9/gvJ8Xpd41hGSLu5A1L
        NkoTEDB5bnVHBN7YgwWnK7m/BqHfO0Dkj5wC/OE+oye5NVAseEzcVlgqlIBt4EKvhmLMqv
        jUP5NQDW4EoBc8dJA3cL2jjg1Eejf2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688640535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yN2iGJzPRI5qeaMkkVQG1/mfO37rIiV1XHtVYwXdmk=;
        b=hCzA+TAkXJSjwQ5MsRnAI4urtMf8Rqw5taRcMcRV7jwZ5cNBr0JQtZwtD/nolJEXZiCfec
        6V42HBVTJrjgp9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00BA1138EE;
        Thu,  6 Jul 2023 10:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBntOhacpmSDAQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 10:48:54 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, suijingfeng@loongson.cn, arnd@arndb.de
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v2 2/4] fbdev/sm712fb: Do not include <linux/screen_info.h>
Date:   Thu,  6 Jul 2023 12:42:15 +0200
Message-ID: <20230706104852.27451-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706104852.27451-1-tzimmermann@suse.de>
References: <20230706104852.27451-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Sm712fb's dependency on <linux/screen_info.h> is artificial in that
it only uses struct screen_info for its internals. Replace the use of
struct screen_info with a custom data structure and remove the include
of <linux/screen_info.h>.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/sm712fb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index b7ad3c644e13..f929091da4e7 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -27,12 +27,17 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/console.h>
-#include <linux/screen_info.h>
 
 #include <linux/pm.h>
 
 #include "sm712.h"
 
+struct smtcfb_screen_info {
+	u16 lfb_width;
+	u16 lfb_height;
+	u16 lfb_depth;
+};
+
 /*
  * Private structure
  */
@@ -829,7 +834,7 @@ static const struct modeinit vgamode[] = {
 	},
 };
 
-static struct screen_info smtc_scr_info;
+static struct smtcfb_screen_info smtc_scr_info;
 
 static char *mode_option;
 
-- 
2.41.0

