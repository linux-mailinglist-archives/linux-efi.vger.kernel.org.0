Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621671FA165
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgFOUYV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 16:24:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729943AbgFOUYT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 16:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592252657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C/iH4DY/6Yao+IlFOJ9ZaQwmC0Ra1ZHKELUELgNEM4Y=;
        b=h9i73P/sUfHCioamiDpz7l8jez2COOZtyKSuzvQ7zZBEFhsSUuxHEUXgCuL9TFGszG8n2+
        8nZwdgQiRDj1qVy31yqRNSgdpNrj70e/3Ib0Lxgw8l0DK+C4xzugaMomoWeX21hi2l6nLC
        PXEu6cNQyl/gLH7aLI38/1kkpA9GdPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-SRe7YmtwODqSgPnUHCQbpg-1; Mon, 15 Jun 2020 16:24:15 -0400
X-MC-Unique: SRe7YmtwODqSgPnUHCQbpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADCE2E93F;
        Mon, 15 Jun 2020 20:24:14 +0000 (UTC)
Received: from random.internal.datastacks.com (ovpn-113-167.phx2.redhat.com [10.3.113.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0AEE9CFCE;
        Mon, 15 Jun 2020 20:24:13 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH] Make it possible to disable efivar_ssdt entirely
Date:   Mon, 15 Jun 2020 16:24:08 -0400
Message-Id: <20200615202408.2242614-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In most cases, such as CONFIG_ACPI_CUSTOM_DSDT and
CONFIG_ACPI_TABLE_UPGRADE, boot-time modifications to firmware tables
are tied to specific Kconfig options.  Currently this is not the case
for modifying the ACPI SSDT via the efivar_ssdt kernel command line
option and associated EFI variable.

This patch adds CONFIG_EFI_CUSTOM_SSDT_OVERLAYS, which defaults
disabled, in order to allow enabling or disabling that feature during
the build.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/efi.c   |  2 +-
 drivers/firmware/efi/Kconfig | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 48d0188936c..4b12a598ccf 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -192,7 +192,7 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
+#if IS_ENABLED(CONFIG_EFI_CUSTOM_SSDT_OVERLAYS)
 #define EFIVAR_SSDT_NAME_MAX	16
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6b38f9e5d20..fe433f76b03 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -278,3 +278,14 @@ config EFI_EARLYCON
 	depends on SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
+
+config EFI_CUSTOM_SSDT_OVERLAYS
+	bool "Load custom ACPI SSDT overlay from an EFI variable"
+	depends on EFI_VARS
+	default ACPI_TABLE_UPGRADE
+	help
+	  Allow loading of an ACPI SSDT overlay from an EFI variable specified
+	  by a kernel command line option.
+
+	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
+	  information.
-- 
2.26.2

