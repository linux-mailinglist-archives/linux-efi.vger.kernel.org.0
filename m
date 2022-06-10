Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17B5460B1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jun 2022 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiFJJAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jun 2022 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiFJJAh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jun 2022 05:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DAB665A0
        for <linux-efi@vger.kernel.org>; Fri, 10 Jun 2022 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654851634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ukK3D5FOT/lVXAY3CQ/ZTU+kRLHSqaAf/1KzQyUA/fo=;
        b=GOu1LxGTV2aJdv0dirBVgxTQooieaSq14reWZVLt/1+FcdqQeyPueyvP5gggpP9KBIqVtS
        /MX67uRYwk/YA10SZw3J0STSJHzQCTx1Vfb4MLERlf31WNN8+BFlkE1piJORrH6OkF5eCn
        VU3OE5OXYl/4eVhZhZoSjy+GtGOTG/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-L0rSa0NIPPOXuH0GgBi9hQ-1; Fri, 10 Jun 2022 05:00:32 -0400
X-MC-Unique: L0rSa0NIPPOXuH0GgBi9hQ-1
Received: by mail-wr1-f70.google.com with SMTP id q14-20020a5d61ce000000b00210353e32b0so5981035wrv.12
        for <linux-efi@vger.kernel.org>; Fri, 10 Jun 2022 02:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukK3D5FOT/lVXAY3CQ/ZTU+kRLHSqaAf/1KzQyUA/fo=;
        b=m+ZC6Dg7T+LPlVUoVHbH/Aon6owkR8X7jxzJj//Er/DCk3/gZorCeBesV0TW9MIPTw
         eexs/25o2/uV29Id82yZZzVhAzm6pIrBXpElnUFNJx8BL7KJJdDKgpuIFMAsyPxRhnrG
         Bxrl+mk6/LwrqTVdlIZHUmtpPJ8huByvwyFVQAzJAjZVcx21/+dA5FzQ54flLghMZe4C
         SAI/nJInbH6W/+TmZBAUuGT03qmFV5KdvWL2ZGA4wZr5QXRXEF1NMyXShBiEdH+eVwiT
         +mbKDePp2mvkjc5JJTTYX4k0Q0ARr1EfEG3s8YD7vDPGsIiiQaJ9Cg3Vh8CJpH0lBdS9
         ribA==
X-Gm-Message-State: AOAM531crTKIa0fpHqxYe8AGc8Q4XNdYBloXMpDkDWC829o/5TSKwhyo
        AhSBJs77uNNmnzBAFZ6e8Gfx/DLnjFrqN5PO1eUmWQ64HQYOOBulekezH1qCkMGjh5yhLQTPvhi
        fThVL94mearRQupmlCC9a
X-Received: by 2002:a05:600c:4e54:b0:39c:6e5e:c667 with SMTP id e20-20020a05600c4e5400b0039c6e5ec667mr6753178wmq.151.1654851631574;
        Fri, 10 Jun 2022 02:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkBzMN6zqmh3ItL1DEVgtjb5YNjsnmi9WVMAPERuUJTVsqu+6f1r+Qr2+wxO0IT9zUq3CNg==
X-Received: by 2002:a05:600c:4e54:b0:39c:6e5e:c667 with SMTP id e20-20020a05600c4e5400b0039c6e5ec667mr6753151wmq.151.1654851631352;
        Fri, 10 Jun 2022 02:00:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5588000000b00219e4ebf549sm1711792wrv.56.2022.06.10.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:00:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] efi: sysfb_efi: remove unnecessary <asm/efi.h> include
Date:   Fri, 10 Jun 2022 11:00:05 +0200
Message-Id: <20220610090005.1358402-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nothing defined in the header is used by drivers/firmware/efi/sysfb_efi.c
but also, including it can lead to build errors when built on arches that
don't have an asm/efi.h header file.

This can happen for example if a driver that is built when COMPILE_TEST is
enabled selects the SYSFB symbol, e.g. on powerpc with allyesconfig:

drivers/firmware/efi/sysfb_efi.c:29:10: fatal error: asm/efi.h: No such file or directory
   29 | #include <asm/efi.h>
      |          ^~~~~~~~~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/efi/sysfb_efi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 4c7c9dd7733f..7882d4b3f2be 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -26,8 +26,6 @@
 #include <linux/sysfb.h>
 #include <video/vga.h>
 
-#include <asm/efi.h>
-
 enum {
 	OVERRIDE_NONE = 0x0,
 	OVERRIDE_BASE = 0x1,
-- 
2.36.1

