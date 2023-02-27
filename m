Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A36A396E
	for <lists+linux-efi@lfdr.de>; Mon, 27 Feb 2023 04:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjB0DVd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Feb 2023 22:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjB0DVd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 26 Feb 2023 22:21:33 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B521FF06;
        Sun, 26 Feb 2023 19:21:32 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677468090;
        bh=pwAr4IcABcpaKfjReOPmkgEkSQjrSvAGXYILulSm0gM=;
        h=From:Date:Subject:To:Cc:From;
        b=McozBUvbP0l7qh5s6Kn4nC6vqB2W8kMjyy4KqP1x3ScwtVpkrd45Ol9VLU+DTW0ug
         uv4dwh3LxW9op3Tg/iHSfEv1vVCQsuWxW/N+ifCnUtdhNTD/oq/tQ6UhYok8LUhCsr
         EYsbgSQjwSy+FXcGZ4GYvIOlUXzJ3Xx32xUlJDbQ=
Date:   Mon, 27 Feb 2023 03:21:27 +0000
Subject: [PATCH] efi: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230227-kobj_type-firmware-efi-v1-1-26221abace3c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALYh/GMC/x2N2wrCQAwFf6Xk2UCN2IK/IiLZbdZG67ZkvZXSf
 zf0cYYznAWKmEqBU7WAyUeLjtlhv6sg9pxvgto5A9V0qIlafIzhfn3Nk2BSe37ZBCUpUorcNkc
 mIgaPAxfBYJxj73l+D4PLyXz6297Ol3X9A/cRkzx9AAAA
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677468088; l=1024;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pwAr4IcABcpaKfjReOPmkgEkSQjrSvAGXYILulSm0gM=;
 b=sc+FDFVb7BbroNSy7MXVjIaaqxVx1PkrgUHay3UeN0qy7Av0X5eGn7sY4IuOuLUdxM71T8aXG
 RBgjpFaM3pzAHJuvcPomANwuNzCfWLIWIwTVSfuhzM60XdbO5Eyxvdn
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
 drivers/firmware/efi/esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 87729c365be1..c61398634d75 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -156,7 +156,7 @@ static void esre_release(struct kobject *kobj)
 	kfree(entry);
 }
 
-static struct kobj_type esre1_ktype = {
+static const struct kobj_type esre1_ktype = {
 	.release = esre_release,
 	.sysfs_ops = &esre_attr_ops,
 	.default_groups = esre1_groups,

---
base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
change-id: 20230227-kobj_type-firmware-efi-2fca765a222a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

