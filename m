Return-Path: <linux-efi+bounces-2486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988249FDC3B
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2024 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382A4161541
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1C16C69F;
	Sat, 28 Dec 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fyralabs.com header.i=@fyralabs.com header.b="eUo8spD5"
X-Original-To: linux-efi@vger.kernel.org
Received: from hosted.mailcow.de (hosted.mailcow.de [5.1.76.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6191E515;
	Sat, 28 Dec 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.1.76.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418168; cv=none; b=B0nmaAnPyaIrjk0gD/gaJLpZXl8p0LuS9gnGyQ+Pss6FXzNpQA6AuNqBbNLZLLvOBfdwmc99KOEa+6zXZ3D0aRQ3GB/gI4B+5yLfvghuDT92P1y4lNOpue3I7TX16pjaXfGiwiC3EhcwPRJBzltV0XELDtuRJrZ90YgzvFNTvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418168; c=relaxed/simple;
	bh=KffvmpUB2jEZ5UfemKmUbVgUyON5bdLnmSoj7ZfH3Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gz+ZW8c7IfIKYyJDDSSSXyyGkDsG1xo5fTN4GYF4Ee2rL+liLZ5qliNqiWw29nmXE1GHNV+NrVUcf/XMWOmcOomhyijg37YBcuJm3Vp61y9Dgs58AgwgWZAn7Y6ae9KfNB8r3GNQFGb2J0d/GOPCDjY1EYI2NNsL0KRzSng0FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fyralabs.com; spf=fail smtp.mailfrom=fyralabs.com; dkim=pass (2048-bit key) header.d=fyralabs.com header.i=@fyralabs.com header.b=eUo8spD5; arc=none smtp.client-ip=5.1.76.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fyralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fyralabs.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fyralabs.com;
	s=default; t=1735417557; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=q8njUUoU33aoapvcUM1e8V9ZxhyGAziGiKStM32tCYQ=;
	b=eUo8spD5tvv+zQacezG5lgde4smzegb0Cm7VoajMY9Wcv52cRo+cUBGiwepiQJqKy7JnCU
	8Hw4KdgMyx1WlniIhVoi0sAVFd3eDjYZ1FWUjPH7ML+Qf6cEOj2ruhMiPZypxpnI9lh54E
	gvvwiKrsAUuK2NqXbzcKstomzPSQgfgM1hqXN/gHU9TCvrR9mBxx/2z+nWHG0GDEesMZXE
	DVDn3cAg6gfxk6X/X77u9Uzp1GsWtJ0BIDaIQKkVOGeNZJxrey3nGKb0XaRHzodY4O0BAl
	1ylUWrEofu2maN0pYTaXtuxDBa7cF+OMyxLWpAX16qIk/lUcGtzJwv88N14REg==
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E69B5C0175;
	Sat, 28 Dec 2024 21:25:53 +0100 (CET)
From: Lleyton Gray <lleyton@fyralabs.com>
To: 
Cc: gargaditya08@live.com,
	Lleyton Gray <lleyton@fyralabs.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Marek <jonathan@marek.ca>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH] x86/efistub: Add options for forcing Apple set_os protocol
Date: Sat, 28 Dec 2024 12:21:58 -0800
Message-ID: <20241228202212.89069-1-lleyton@fyralabs.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 71e49eccdca6 ("x86/efistub: Call Apple set_os protocol on dual GPU
Intel Macs") calls the Apple set_os protocol, but only on T2 Macbook Pro
models. This causes issues on other T2 models when an egpu is used.
Add two options which allow force enabling or disabling usage of the
protocol to fix.

Signed-off-by: Lleyton Gray <lleyton@fyralabs.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c  | 6 ++++++
 drivers/firmware/efi/libstub/efistub.h          | 2 ++
 drivers/firmware/efi/libstub/x86-stub.c         | 3 ++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..1d1b88c57c44 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1447,7 +1447,8 @@
 	efi=		[EFI,EARLY]
 			Format: { "debug", "disable_early_pci_dma",
 				  "nochunk", "noruntime", "nosoftreserve",
-				  "novamap", "no_disable_early_pci_dma" }
+				  "novamap", "no_disable_early_pci_dma",
+				  "enable_apple_set_os", "disable_apple_set_os" }
 			debug: enable misc debug output.
 			disable_early_pci_dma: disable the busmaster bit on all
 			PCI bridges while in the EFI boot stub.
@@ -1464,6 +1465,10 @@
 			novamap: do not call SetVirtualAddressMap().
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
+			enable_apple_set_os: Report that macOS is being booted
+			to the firmware, even if the device is not a dual GPU Mac.
+			disable_apple_set_os: Disable reporting that macOS is being booted
+			to the firmware, even if the device is a dual GPU Mac.
 
 	efi_no_storage_paranoia [EFI,X86,EARLY]
 			Using this parameter you can use more than 50% of
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..c33bb98bf79d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -20,6 +20,8 @@
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
+bool efi_enable_apple_set_os;
+bool efi_disable_apple_set_os;
 
 static bool efi_noinitrd;
 static bool efi_nosoftreserve;
@@ -95,6 +97,10 @@ efi_status_t efi_parse_options(char const *cmdline)
 				efi_disable_pci_dma = true;
 			if (parse_option_str(val, "no_disable_early_pci_dma"))
 				efi_disable_pci_dma = false;
+			if (parse_option_str(val, "enable_apple_set_os"))
+				efi_enable_apple_set_os = true;
+			if (parse_option_str(val, "disable_apple_set_os"))
+				efi_disable_apple_set_os = true;
 			if (parse_option_str(val, "debug"))
 				efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
 		} else if (!strcmp(param, "video") &&
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 685098f9626f..3be4b5393812 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -39,6 +39,8 @@ extern bool efi_nokaslr;
 extern int efi_loglevel;
 extern int efi_mem_encrypt;
 extern bool efi_novamap;
+extern bool efi_enable_apple_set_os;
+extern bool efi_disable_apple_set_os;
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..566118195f92 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -265,7 +265,8 @@ static void apple_set_os(void)
 	} *set_os;
 	efi_status_t status;
 
-	if (!efi_is_64bit() || !apple_match_product_name())
+	if (efi_disable_apple_set_os || !efi_is_64bit() ||
+		!efi_enable_apple_set_os && !apple_match_product_name())
 		return;
 
 	status = efi_bs_call(locate_protocol, &APPLE_SET_OS_PROTOCOL_GUID, NULL,
-- 
2.47.0


