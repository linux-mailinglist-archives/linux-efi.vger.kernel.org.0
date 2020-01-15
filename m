Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2034013C99B
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAOQge (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:36:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729143AbgAOQgd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579106193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2+KBQ3DRpskHHzDy8jC2pctG+R82LGlRTav9U6g4p0=;
        b=QlRVr+j+zuC8LArcIN9gk59g1/vYL3W/K1ENCukEdIragiDT/Ex6HFpftXqioY/rAdlNTF
        5vZBzWM9ST9oSXvYtOEvx4MdBmrxmwcvakZmoOhASzEuJRLcYOYtb5RMGmSxH4bMC9QmQr
        zUohlmW3TRD2QtNaMk74mMQWHlTCKxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-AX241fG7Pxeuh35YOBMYiA-1; Wed, 15 Jan 2020 11:36:28 -0500
X-MC-Unique: AX241fG7Pxeuh35YOBMYiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263821800D48;
        Wed, 15 Jan 2020 16:36:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com [10.36.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AE515DA76;
        Wed, 15 Jan 2020 16:36:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v12 05/10] test_firmware: add support for firmware_request_platform
Date:   Wed, 15 Jan 2020 17:35:49 +0100
Message-Id: <20200115163554.101315-6-hdegoede@redhat.com>
In-Reply-To: <20200115163554.101315-1-hdegoede@redhat.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for testing firmware_request_platform through a new
trigger_request_platform trigger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v12:
- Use local / private firmware variable for the test instead of the
  global test_firmware variable and drop the mutex lock + unlock needed
  for accessing the global test_firmware variable

Changes in v11:
- Drop a few empty lines which were accidentally introduced

Changes in v10:
- New patch in v10 of this patch-set
---
 lib/test_firmware.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 251213c872b5..0c7fbcf07ac5 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
+#include <linux/efi_embedded_fw.h>
=20
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
@@ -507,6 +508,57 @@ static ssize_t trigger_request_store(struct device *=
dev,
 }
 static DEVICE_ATTR_WO(trigger_request);
=20
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+static ssize_t trigger_request_platform_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	static const u8 test_data[] =3D {
+		0x55, 0xaa, 0x55, 0xaa, 0x01, 0x02, 0x03, 0x04,
+		0x55, 0xaa, 0x55, 0xaa, 0x05, 0x06, 0x07, 0x08,
+		0x55, 0xaa, 0x55, 0xaa, 0x10, 0x20, 0x30, 0x40,
+		0x55, 0xaa, 0x55, 0xaa, 0x50, 0x60, 0x70, 0x80
+	};
+	struct efi_embedded_fw efi_embedded_fw;
+	const struct firmware *firmware =3D NULL;
+	char *name;
+	int rc;
+
+	name =3D kstrndup(buf, count, GFP_KERNEL);
+	if (!name)
+		return -ENOSPC;
+
+	pr_info("inserting test platform fw '%s'\n", name);
+	efi_embedded_fw.name =3D name;
+	efi_embedded_fw.data =3D (void *)test_data;
+	efi_embedded_fw.length =3D sizeof(test_data);
+	list_add(&efi_embedded_fw.list, &efi_embedded_fw_list);
+
+	pr_info("loading '%s'\n", name);
+	rc =3D firmware_request_platform(&firmware, name, dev);
+	if (rc) {
+		pr_info("load of '%s' failed: %d\n", name, rc);
+		goto out;
+	}
+	if (firmware->size !=3D sizeof(test_data) ||
+	    memcmp(firmware->data, test_data, sizeof(test_data)) !=3D 0) {
+		pr_info("firmware contents mismatch for '%s'\n", name);
+		rc =3D -EINVAL;
+		goto out;
+	}
+	pr_info("loaded: %zu\n", firmware->size);
+	rc =3D count;
+
+out:
+	release_firmware(firmware);
+	list_del(&efi_embedded_fw.list);
+	kfree(name);
+
+	return rc;
+}
+static DEVICE_ATTR_WO(trigger_request_platform);
+#endif
+
 static DECLARE_COMPLETION(async_fw_done);
=20
 static void trigger_async_request_cb(const struct firmware *fw, void *co=
ntext)
@@ -903,6 +955,9 @@ static struct attribute *test_dev_attrs[] =3D {
 	TEST_FW_DEV_ATTR(trigger_request),
 	TEST_FW_DEV_ATTR(trigger_async_request),
 	TEST_FW_DEV_ATTR(trigger_custom_fallback),
+#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+	TEST_FW_DEV_ATTR(trigger_request_platform),
+#endif
=20
 	/* These use the config and can use the test_result */
 	TEST_FW_DEV_ATTR(trigger_batched_requests),
--=20
2.24.1

