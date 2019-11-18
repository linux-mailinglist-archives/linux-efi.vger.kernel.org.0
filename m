Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED4100AA2
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2019 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfKRRm5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 12:42:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38437 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKRRm5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Nov 2019 12:42:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so205202wmk.3
        for <linux-efi@vger.kernel.org>; Mon, 18 Nov 2019 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hvD75NY8BGYGJ9zuzt5ynrizPkcMUgtR+96pDOAx2Uc=;
        b=PxKA1vx696llhJa4pBEiNxFMI+bTJR1EPKQk1RXzdOy4n74RGaZDLIXX8nvWZgfkf8
         1vVASG72qCG/xwt6YsxFukKG7BrzKBbYlKz/SU+yI9cXUpvF4Ccq3aHWsa97qqv1JvWu
         Mpad7PCze+QuZG+FGxZf86s2m6AQv6GksJ9GhQZgziDUNDOzXtQQ4RYDXGDA5EqKdTvh
         /1ZK3LN5p0+N6GAV2/o7gTwrb+US5No+3Y9r1fAtnXwcgZ+3v2DnLvueLCMg64/LtOSP
         cjZbRExPeCmJEYy3yDjyI9X2aq6b1zjOiX++YwtCUWFlDH7dmXau/Cx8097tvTb7OrB8
         QByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hvD75NY8BGYGJ9zuzt5ynrizPkcMUgtR+96pDOAx2Uc=;
        b=h16rQr3UJSZJfbby7RWxQQ9/CMIG5ICZir/DI5KHWTst7sX7DBo0VGOvuUMngr5LzS
         XD3MBPepzmIHb3pZagBBHSagBzLdNcwoUDTVgkGw/oA/60dwrqiwxVsxyj0qTg2OlMUu
         DrlRMtnbz9FMGsqnQT626VVBUcBfNT7n9XaorydW3GlPkIVER5L6/Mciw3CqOMCoGe0L
         KG4W8vm+k/0tmhHsBoMauuLGX6KVrqERi1muHCH3z6auw2cyOJTPSLWhL9mCqRVMoE+K
         yB81oljrVFlR4J/d0IrQj9cnifIbCjXmilc2A5G+gtgXTHOzvdspAqZsElB6mUOD8fN3
         lhlA==
X-Gm-Message-State: APjAAAWWqGgpxQYdDHYY6PTfSY4LnSxsMAbLBRXUyAnFQvCka0lo8ObW
        43Ocdimlwnb2pMEpicEGzjQ=
X-Google-Smtp-Source: APXvYqz6PBaZzG57uNzX6aAB+X4l3gH15W3tuLcRLAmz8RnE5FrTN6TBaPOLL6ubPnRwWUOao64NqQ==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr247312wmj.134.1574098975302;
        Mon, 18 Nov 2019 09:42:55 -0800 (PST)
Received: from localhost.localdomain ([79.116.233.68])
        by smtp.gmail.com with ESMTPSA id c10sm71198wml.37.2019.11.18.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:42:54 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org, kasong@redhat.com,
        hdegoede@redhat.com, matthewgarrett@google.com,
        linux-efi@vger.kernel.org
Subject: [PATCH 1/1] efi/libstub: Workaround for data abort on armv6z architecture
Date:   Mon, 18 Nov 2019 19:42:52 +0200
Message-Id: <20191118174252.26758-2-cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118174252.26758-1-cristian.ciocaltea@gmail.com>
References: <20191118174252.26758-1-cristian.ciocaltea@gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The armv6-eabihf toolchains generate some ldrd instructions
that trigger data abort on RaspberryPi Zero (ARM1176JZF-S CPU):

drivers/firmware/efi/libstub/efi-stub-helper.c:91
	*map->map_size =	*map->desc_size * 32;
    92c8:	e1c420d4 	ldrd	r2, [r4, #4]

This patch is a hack to instruct the compiler to avoid
using the problematic ldrd instructions.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 35dbc2791c97..8d7d27b8b9c2 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -86,9 +86,10 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 	efi_status_t status;
 	unsigned long key;
 	u32 desc_version;
+	unsigned long hack;
 
 	*map->desc_size =	sizeof(*m);
-	*map->map_size =	*map->desc_size * 32;
+	*map->map_size =	sizeof(*m) * 32;
 	*map->buff_size =	*map->map_size;
 again:
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
@@ -111,7 +112,9 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 		 * exceed this headroom once we are ready to trigger
 		 * ExitBootServices()
 		 */
-		*map->map_size += *map->desc_size * EFI_MMAP_NR_SLACK_SLOTS;
+		hack = *map->desc_size * EFI_MMAP_NR_SLACK_SLOTS + 1;
+		*map->map_size += hack;
+		--(*map->map_size);
 		*map->buff_size = *map->map_size;
 		goto again;
 	}
-- 
2.17.1

