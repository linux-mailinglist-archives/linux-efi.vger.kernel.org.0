Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362B43D6DCA
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhG0FF0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 01:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhG0FFZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jul 2021 01:05:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35763C061757;
        Mon, 26 Jul 2021 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LbsOlfHeqNxTseZbI6JEafTqvq2PmDXu+dYbdpp/3uU=; b=LEYB0v4o2AJFAnH61UR7Bo2Uei
        66oVAJZFUsUisXHx7BswJ31Lu3uD0IRNNyNKbQOwlt4i14TMxD8jwbKmyyeSbcnwLS5y6UKsTVDdq
        0cQ6x9mnYEVCDDK4n9GgkX+sV/5cxzOaSB1IJGKx3MLIXjjBWESW/5CSgGQDFp2Lgn3hSKpYrZjkR
        akuXBztefQZVtAVUFqR7hu5LuQGelkxi3HgoFs8VTdlI2AuHJcSht8EIkaRC23361loIG4efl5tM5
        LX6SToyDSbo9g+7ze1jeNUWpkCkyQFTSXH0uB/ONszAbQsr0q/qZwcO/gIymbFzQMYGJgaMIy8NYR
        YYgi40WQ==;
Received: from [2601:1c0:6280:3f0:76e5:bff:fe2d:dc28] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8FGu-00Eg9T-RM; Tue, 27 Jul 2021 05:05:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
Subject: [PATCH] efi: sysfb_efi: fix build when EFI is not set
Date:   Mon, 26 Jul 2021 22:04:47 -0700
Message-Id: <20210727050447.7339-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When # CONFIG_EFI is not set, there are 2 definitions of
sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
and the __init function from sysfb_efi.c should not be used.

../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of ‘sysfb_apply_efi_quirks’
 __init void sysfb_apply_efi_quirks(struct platform_device *pd)
             ^~~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
../include/linux/sysfb.h:65:20: note: previous definition of ‘sysfb_apply_efi_quirks’ was here
 static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
                    ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-next@vger.kernel.org
---
 drivers/firmware/efi/sysfb_efi.c |    2 ++
 1 file changed, 2 insertions(+)

--- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
+++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
@@ -332,6 +332,7 @@ static const struct fwnode_operations ef
 	.add_links = efifb_add_links,
 };
 
+#ifdef CONFIG_EFI
 static struct fwnode_handle efifb_fwnode;
 
 __init void sysfb_apply_efi_quirks(struct platform_device *pd)
@@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
 		pd->dev.fwnode = &efifb_fwnode;
 	}
 }
+#endif
