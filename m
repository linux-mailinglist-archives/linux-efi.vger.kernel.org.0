Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086C5323B4
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiEXHKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiEXHKH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 03:10:07 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5E68A30A
        for <linux-efi@vger.kernel.org>; Tue, 24 May 2022 00:10:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:4593:272c:6293:e2cc])
        by baptiste.telenet-ops.be with bizsmtp
        id aXA22700g2jQL2A01XA20k; Tue, 24 May 2022 09:10:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntOg6-001Rds-Ij; Tue, 24 May 2022 09:10:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntORN-0046tw-LZ; Tue, 24 May 2022 08:54:49 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] efi: EFI_DISABLE_RUNTIME should depend on EFI
Date:   Tue, 24 May 2022 08:54:48 +0200
Message-Id: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI_DISABLE_RUNTIME config option controls the use of Extensible
Firmware Interface (EFI) runtime services, which matters only if EFI
support is enabled.

Hence add a dependency on EFI, to prevent asking the user about this
control knob when configuring a kernel with EFI support.

Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 4720ba98cec312e7..ff6e7bfa8355cfc2 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -299,6 +299,7 @@ config EFI_CUSTOM_SSDT_OVERLAYS
 
 config EFI_DISABLE_RUNTIME
 	bool "Disable EFI runtime services support by default"
+	depends on EFI
 	default y if PREEMPT_RT
 	help
 	  Allow to disable the EFI runtime services support by default. This can
-- 
2.25.1

