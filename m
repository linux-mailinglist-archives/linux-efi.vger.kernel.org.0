Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B456EE8E68
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfJ2RjE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 13:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfJ2RjE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:04 -0400
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4852020856;
        Tue, 29 Oct 2019 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572370743;
        bh=seibnrRNRbSPy1J1lWeJMDFnX5JQTvYifsg77MzzXhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZ2+Mf0FboDrCDBF7qwaLAOyhzrruAsrSFoMvn+aY8Q17n7HP4Maxk+1xU+6G19nr
         VPRR+0FDnnfONTcLpHLlfb2mtX3LfECi6+zKM75oKmu7xXC8kztbWB50JLpTt/xJlJ
         QYwKUDYEVUVCqOiPv0X3Yhhl1d0vp4hFqAEJf4eg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Narendra K <Narendra.K@dell.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only
Date:   Tue, 29 Oct 2019 18:37:50 +0100
Message-Id: <20191029173755.27149-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029173755.27149-1-ardb@kernel.org>
References: <20191029173755.27149-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Narendra K <Narendra.K@dell.com>

For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
for input on platforms where the option may not be applicable. This patch
modifies the kconfig option to ask the user for input only when CONFIG_X86
or CONFIG_COMPILE_TEST is set to y.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Narendra K <Narendra.K@dell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..b248870a9806 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -182,6 +182,7 @@ config RESET_ATTACK_MITIGATION
 
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	depends on X86 || COMPILE_TEST
 	help
 	  Displays the content of the Runtime Configuration Interface
 	  Table version 2 on Dell EMC PowerEdge systems as a binary
-- 
2.17.1

