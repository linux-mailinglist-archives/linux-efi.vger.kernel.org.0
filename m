Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892C13B58AD
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 07:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF1Frt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 01:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhF1Frs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Jun 2021 01:47:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD1C061574;
        Sun, 27 Jun 2021 22:45:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so23939931edc.7;
        Sun, 27 Jun 2021 22:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6lXpsyWyT2SW3Qm9aBi8uv0daxCqjJCWU4Uauor+VrE=;
        b=plROW7+vzWYVvlgmPMaIDloiqjNWauB9du2293fcOYiGq+7+qV6nLK3l7TZ+tjby+t
         sVY8AbcB2KOG6pEIkmggDf4TP0ZE2R8V7d2cTKusUrhVW6l5e+po1+tmxeBcuAOg5kFw
         kC1ag59qBrGcQFOamw3hbVfhAPQNp1pTN2kGKDJakQwmnhAnObSwbdK59AzAa11cPSrl
         f2KqTE4+a3/pBhKJ3ZgydlSSktK3thmz6cf9PjlHeikCUA6L4WyUKgGjyxNr6q+dDD89
         t5BcF+lTYe2NcSztAYE8t58IVbqLWj5VkXuuBfJjtMTS6KJ0F6NLfmnI+S2ldCbOpJWR
         HJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=6lXpsyWyT2SW3Qm9aBi8uv0daxCqjJCWU4Uauor+VrE=;
        b=RvzBchsQMoG+cG2pY/5VbpxaD7ruCpvCdV+k5VEr3i7EhtDX0Ior3QRlRDHn3qdpKu
         HGaEdC5+mGqZw3Da2oHohSuUsdDBoHEVvPbLuTn3e/se4um9Wh5T98iLhK8lw9bkJlnK
         n0m/MziaC95lLIiIUzPt/RUW9/dcziBFABXrZi0VOFhPQvt19sEzYgflLR0+eHqCnckm
         ZRtXYGa24+FRLZu31fCeXY6AQsPKR7utIvXzTkBJJwTzrtlOuN4zy2KnJb4iEbpimlid
         Z76cNBzRgtLBraUUxZHIBXjd0WWvcejp27QVSPCq1gBfwL4/u5DpOYSJqZMqzQYSAeMq
         xd+Q==
X-Gm-Message-State: AOAM532RB0406Mizeo9OegTbx9Wc3kJeIWSXrfXkHnNpxT0ko6OdwNVX
        oP0xl+e/GSJRBs48tpL5fQ8=
X-Google-Smtp-Source: ABdhPJyhSFQN7MXwUS8Ut784zjRC7gMAG0bkbQMEzZIODyG76P9K9JrAxZSOnPc2Mu5EZpnjl6ILag==
X-Received: by 2002:a05:6402:516b:: with SMTP id d11mr30666277ede.252.1624859120434;
        Sun, 27 Jun 2021 22:45:20 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id o9sm4214296edc.91.2021.06.27.22.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:45:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:45:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, peters@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI changes for v5.14
Message-ID: <YNlh7jolB04h6z0h@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-06-28

   # HEAD: 267be9dbacf4485f7842a3755eef4bb68dc85fc9 Merge tag 'efi-next-for-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

EFI changes: two driver API cleanups, and a log message tweak.

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      efi/dev-path-parser: Switch to use for_each_acpi_dev_match()

Heikki Krogerus (1):
      efi/apple-properties: Handle device properties with software node API

Paul Menzel (1):
      x86/efi: Log 32/64-bit mismatch with kernel as an error


 arch/x86/platform/efi/efi.c             |  2 +-
 drivers/firmware/efi/apple-properties.c |  2 +-
 drivers/firmware/efi/dev-path-parser.c  | 49 ++++++++++++---------------------
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e705cb06..147c30a81f15 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -468,7 +468,7 @@ void __init efi_init(void)
 	 */
 
 	if (!efi_runtime_supported())
-		pr_info("No EFI runtime due to 32/64-bit mismatch with kernel\n");
+		pr_err("No EFI runtime due to 32/64-bit mismatch with kernel\n");
 
 	if (!efi_runtime_supported() || efi_runtime_disabled()) {
 		efi_memmap_unmap();
diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index e1926483ae2f..4c3201e290e2 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -157,7 +157,7 @@ static int __init unmarshal_devices(struct properties_header *properties)
 		if (!entry[0].name)
 			goto skip_device;
 
-		ret = device_add_properties(dev, entry); /* makes deep copy */
+		ret = device_create_managed_software_node(dev, entry, NULL);
 		if (ret)
 			dev_err(dev, "error %d assigning properties\n", ret);
 
diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index 5c9625e552f4..10d4457417a4 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -12,52 +12,39 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 
-struct acpi_hid_uid {
-	struct acpi_device_id hid[2];
-	char uid[11]; /* UINT_MAX + null byte */
-};
-
-static int __init match_acpi_dev(struct device *dev, const void *data)
-{
-	struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
-	struct acpi_device *adev = to_acpi_device(dev);
-
-	if (acpi_match_device_ids(adev, hid_uid.hid))
-		return 0;
-
-	if (adev->pnp.unique_id)
-		return !strcmp(adev->pnp.unique_id, hid_uid.uid);
-	else
-		return !strcmp("0", hid_uid.uid);
-}
-
 static long __init parse_acpi_path(const struct efi_dev_path *node,
 				   struct device *parent, struct device **child)
 {
-	struct acpi_hid_uid hid_uid = {};
+	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
+	struct acpi_device *adev;
 	struct device *phys_dev;
 
 	if (node->header.length != 12)
 		return -EINVAL;
 
-	sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
+	sprintf(hid, "%c%c%c%04X",
 		'A' + ((node->acpi.hid >> 10) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
 		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
 			node->acpi.hid >> 16);
-	sprintf(hid_uid.uid, "%u", node->acpi.uid);
-
-	*child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
-				 match_acpi_dev);
-	if (!*child)
+	sprintf(uid, "%u", node->acpi.uid);
+
+	for_each_acpi_dev_match(adev, hid, NULL, -1) {
+		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
+			break;
+		if (!adev->pnp.unique_id && node->acpi.uid == 0)
+			break;
+		acpi_dev_put(adev);
+	}
+	if (!adev)
 		return -ENODEV;
 
-	phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
+	phys_dev = acpi_get_first_physical_node(adev);
 	if (phys_dev) {
-		get_device(phys_dev);
-		put_device(*child);
-		*child = phys_dev;
-	}
+		*child = get_device(phys_dev);
+		acpi_dev_put(adev);
+	} else
+		*child = &adev->dev;
 
 	return 0;
 }
