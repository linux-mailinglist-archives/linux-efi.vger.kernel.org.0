Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABC103C40
	for <lists+linux-efi@lfdr.de>; Wed, 20 Nov 2019 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfKTNmI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Nov 2019 08:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfKTNmG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:06 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76FC122528;
        Wed, 20 Nov 2019 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257325;
        bh=ImiUar8SpFecCMDnr8VK71R7PTUkzqO+RyLiTn28ha4=;
        h=From:To:Cc:Subject:Date:From;
        b=qtyggUEszVHGCy2JsYZqfZIS9QkZa2YGAnfxWo+R+M1qk/HhWKv3fXeUC10SmcoXv
         CYBD/VHiT9dcOT3RPlI/ATGGlmBpVtgIl2pZrUph3V9hmfbqXD7ri1mnVd1XtMXCoc
         Wru/wm1MR5pttRW955JKf1QhH2TWsH9RbC8c5PF4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] firmware/efi: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:02 +0800
Message-Id: <20191120134202.15531-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/firmware/Kconfig     | 4 ++--
 drivers/firmware/efi/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index e40a77bfe821..312c27876b60 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -86,8 +86,8 @@ config EDD
 	  BIOS tries boot from.  This information is then exported via sysfs.
 
 	  This option is experimental and is known to fail to boot on some
-          obscure configurations. Most disk controller BIOS vendors do
-          not yet implement this feature.
+	  obscure configurations. Most disk controller BIOS vendors do
+	  not yet implement this feature.
 
 config EDD_OFF
 	bool "Sets default behavior for EDD detection to off"
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index bcc378c19ebe..47a3231755d7 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -101,7 +101,7 @@ config EFI_PARAMS_FROM_FDT
 	help
 	  Select this config option from the architecture Kconfig if
 	  the EFI runtime support gets system table address, memory
-          map address, and other parameters from the device tree.
+	  map address, and other parameters from the device tree.
 
 config EFI_RUNTIME_WRAPPERS
 	bool
-- 
2.17.1

