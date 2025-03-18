Return-Path: <linux-efi+bounces-3025-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1361A67A50
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5323BE825
	for <lists+linux-efi@lfdr.de>; Tue, 18 Mar 2025 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E7213244;
	Tue, 18 Mar 2025 17:02:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691F212D7B;
	Tue, 18 Mar 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317359; cv=none; b=u8UmCeQwgnf2uuKFQhtmTu5KS5fDkxYGYnoklYskW+DXfxPHHqcr+fvslecUgkRyHk4HQVVagSIbm9x87m2r1BR8wuBGoC/VtrfJniLclZsMpfhIih3UEyC3xeRT/PKLbE7g2aMOZ+bitHTD3KfUGvHGpS012wLTw2Vh153RtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317359; c=relaxed/simple;
	bh=gRkb6p8XPCkCChpfA0g/BMq90thBf9o9KpCxbQ5q/L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKHVaiDARdkEp+DSvD5/xMP1wMBbGY09y/pAc6MU/VxyzDPNMgIE9w89yp8OrSw9aXEZ2vonhYRu6OfqlHeysdRstLdbdGq56ygb/JaQ1WazBrqz5TJN0QewuggnzesTwzWcKP5oc/HsSXr0jK+GXWuyrOL8xN4hpvZx6QJNC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84742152B;
	Tue, 18 Mar 2025 10:02:46 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3446E3F673;
	Tue, 18 Mar 2025 10:02:37 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:44 +0000
Subject: [PATCH v2 6/8] efi: efivars: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-6-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=gRkb6p8XPCkCChpfA0g/BMq90thBf9o9KpCxbQ5q/L4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2aciI9VxHIej0aKWzdG0ZStyVb+NQKRpF5n/Q
 ttdDeVqi9WJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mIi6D/9h6GsGE8BacOX3uMQGEHySIAN9eHGjqgy+PGAtv4oy2OaTmZYwQS4j1bFA+C5x3wYbQdj
 VLXS+P/54M8C29XsUOcqyBLy4pZU4CDZKCEw+f8yTeYpLYEcrTE3OfIEi9VrYYXa3QB8p8FSqEI
 nPz7gI+OsFaHWh9QxBo7m3s6Jnw0Xp4K556IJZpUJ6C78zEHOswBNuL2LuPKkgSdP3GMsp3T5GF
 B0vVne8Un8M98XCs7QKV+1zq+j4pfVioHIuFVlMObV/RmAJeEqzCu3r3UNm2zgYLn1DDODXARvz
 j2z3TkNkqE73eSYn8E6O7Pqv2Dzr6SKsir7u6YRBPmXeAy08Mq6jmUunENoxrQwAxR/ZgJd2T3z
 D0ctTht3d/OyWUI240P807NzA/4ywnmfIJ8cWw1Tlt2e9vZyC9gccsjHTf7iFY2gbI0jGLR0aLz
 jRf+NC/cPnMBgWkyht/aFLO7PcDoATGoTihU/0WORFUK5FwMXQa9LDERwvcX3YfmROa707easdh
 jAENC68BaBnUipuIfod6Sqzj6Bdnvel9tMM7noqXMTCSlWct+YmtgyviyC/mm9KcH+E5Zk4iOWC
 GZ0NJne3WB4m0mySGYC800zg9lfVLmTxI66HaJqVwZ7H1Hm5Ood/bGsScLZ3MmEzq7KSfhxczkg
 WcsZDBwA21e70ww==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The "efivars" platform device is created just to enable the efi-pstore
module to autoload based on it. It doesn't have to be platform device
though. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate this efivars device to
utilize the faux bus, given that the platform device it previously
created was not a real one anyway.

The modalias is retained here as efi-pstore module is dependent on it.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/efi/efi-pstore.c | 2 +-
 drivers/firmware/efi/efi.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index a253b61449459eca31afc6ca780a20c4557659ba..eed756a59bba3b5a58cd2e238400c3c12fd5edd5 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -301,4 +301,4 @@ module_exit(efivars_pstore_exit);
 
 MODULE_DESCRIPTION("EFI variable backend for pstore");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:efivars");
+MODULE_ALIAS("faux:efivars");
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 862b7744c28ecc9e5a64bbb3533c34119f50267f..dc5c24a7ca540cac342ceddcdbf75b55bf82c889 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -24,7 +24,7 @@
 #include <linux/initrd.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
@@ -443,7 +443,7 @@ static int __init efisubsys_init(void)
 		error = efivar_ssdt_load();
 		if (error)
 			pr_err("efi: failed to load SSDT, error %d.\n", error);
-		platform_device_register_simple("efivars", 0, NULL, 0);
+		faux_device_create("efivars", NULL, NULL);
 	}
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);

-- 
2.34.1


