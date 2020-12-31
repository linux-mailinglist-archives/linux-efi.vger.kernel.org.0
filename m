Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B02E7E0E
	for <lists+linux-efi@lfdr.de>; Thu, 31 Dec 2020 06:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLaFTo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Dec 2020 00:19:44 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:57059 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgLaFTo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Dec 2020 00:19:44 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2020 00:19:43 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 3458A101E6A85;
        Thu, 31 Dec 2020 06:10:37 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id DDD3A60B908A;
        Thu, 31 Dec 2020 06:10:36 +0100 (CET)
X-Mailbox-Line: From be958bda75331a011d53c696d1deec8dccd06fd2 Mon Sep 17 00:00:00 2001
Message-Id: <be958bda75331a011d53c696d1deec8dccd06fd2.1609388549.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 31 Dec 2020 06:10:32 +0100
Subject: [PATCH v2] efi/apple-properties: Reinstate support for boolean
 properties
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-efi@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 4466bf82821b ("efi/apple-properties: use
PROPERTY_ENTRY_U8_ARRAY_LEN"), my MacBook Pro issues a -ENODATA error
when trying to assign EFI properties to the discrete GPU:

pci 0000:01:00.0: assigning 56 device properties
pci 0000:01:00.0: error -61 assigning properties

That's because some of the properties have no value.  They're booleans
whose presence can be checked by drivers, e.g. "use-backlight-blanking".

Commit 6e98503dba64 ("efi/apple-properties: Remove redundant attribute
initialization from unmarshal_key_value_pairs()") employed a trick to
store such booleans as u8 arrays (which is the data type used for all
other EFI properties on Macs):  It cleared the property_entry's
"is_array" flag, thereby denoting that the value is stored inline in the
property_entry.

Commit 4466bf82821b erroneously removed that trick.  It was probably a
little fragile to begin with.

Reinstate support for boolean properties by explicitly invoking the
PROPERTY_ENTRY_BOOL() initializer for properties with zero-length value.

Fixes: 4466bf82821b ("efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org # v5.5+
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v1 -> v2: Check for entry_len instead of !entry_len. (Andy)

 drivers/firmware/efi/apple-properties.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 34f53d898acb..e1926483ae2f 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -3,8 +3,9 @@
  * apple-properties.c - EFI device properties on Macs
  * Copyright (C) 2016 Lukas Wunner <lukas@wunner.de>
  *
- * Note, all properties are considered as u8 arrays.
- * To get a value of any of them the caller must use device_property_read_u8_array().
+ * Properties are stored either as:
+ * u8 arrays which can be retrieved with device_property_read_u8_array() or
+ * booleans which can be queried with device_property_present().
  */
 
 #define pr_fmt(fmt) "apple-properties: " fmt
@@ -88,8 +89,12 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 
 		entry_data = ptr + key_len + sizeof(val_len);
 		entry_len = val_len - sizeof(val_len);
-		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
-						       entry_len);
+		if (entry_len)
+			entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
+							       entry_len);
+		else
+			entry[i] = PROPERTY_ENTRY_BOOL(key);
+
 		if (dump_properties) {
 			dev_info(dev, "property: %s\n", key);
 			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
-- 
2.29.2

