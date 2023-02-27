Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F206A3948
	for <lists+linux-efi@lfdr.de>; Mon, 27 Feb 2023 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjB0DJu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Feb 2023 22:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjB0DJt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 26 Feb 2023 22:09:49 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972F1ABE2;
        Sun, 26 Feb 2023 19:09:41 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677467379;
        bh=M96BHr6D8PREKeYkC4HEQ3Rau29GrZ2n9RtbMYx//sY=;
        h=From:Date:Subject:To:Cc:From;
        b=kr5DzsxoEKmWimZcCDEoTW2gduowwC96E5oSb+YYbPerKR58/PqPz7qLJ0WcEvhcV
         9riPJA65WjuJhmEYw483yNe49eA+9I3wkc1lGowGFfYxdWL+UkMgyWfJ/bpFggjWkk
         9Qk2GAvaxwSXIcatMh0HCAT3DI5VnmlLCrcvBmmc=
Date:   Mon, 27 Feb 2023 03:09:36 +0000
Subject: [PATCH] efi: x86: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-x86-efi-v1-1-a335952d2536@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAO8e/GMC/x2N6wqCQBBGX0XmdwN7yUu9SkTs6JhTsspuhSG+u
 4M/z+E7fCtkTsIZrsUKiX+SZYoK9lRAO4T4ZJROGZxx3jhX43ui1+PznxmXpkLuBevyYsn6syf
 TgHYUMiOlENtBy/gdR5Vz0ulyHN3u27YDbLDhfXgAAAA=
To:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677467377; l=1069;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=M96BHr6D8PREKeYkC4HEQ3Rau29GrZ2n9RtbMYx//sY=;
 b=hjHjN4C4yK57HVHj9bFzkPD3hnpxM4psSwDftz37HChSVdWAwLGzp6NBw79dZkDBZdDbNOfU0
 EWRAXD8qeSTAvRkrY0gwOSehaFtD7Wy5QsOSFMw6VflvmSh0HUjFdiX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/platform/efi/runtime-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/runtime-map.c b/arch/x86/platform/efi/runtime-map.c
index bbee682ef8cd..a6f02cef3ca2 100644
--- a/arch/x86/platform/efi/runtime-map.c
+++ b/arch/x86/platform/efi/runtime-map.c
@@ -93,7 +93,7 @@ static void map_release(struct kobject *kobj)
 	kfree(entry);
 }
 
-static struct kobj_type __refdata map_ktype = {
+static const struct kobj_type __refconst map_ktype = {
 	.sysfs_ops	= &map_attr_ops,
 	.default_groups	= def_groups,
 	.release	= map_release,

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-x86-efi-7591b1343b08

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

