Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6591381C5
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgAKO5f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 09:57:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729970AbgAKO5f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 09:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34V6MVw04HNczrIFfPnlt1JgWgywZsinYkcLO17vV9Q=;
        b=BEWWswpnCh4dVCukRk4Y2+hXXmsxKln4Ss+6Orz9x4oap9CFycWvlI3+wnV7NaoiblzjEt
        +9ffEHedGbdmkmGzrzWxc17YP1TVm94SnhpVgC+QESQFtCei8t/OOltaaLkPjbY66nh0Ri
        mUwRl8+ErQ4f8wEhDyndekYqOWLtrJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-HkhnOFTDOVW2ZHqm1MRvcw-1; Sat, 11 Jan 2020 09:57:31 -0500
X-MC-Unique: HkhnOFTDOVW2ZHqm1MRvcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F9518557C0;
        Sat, 11 Jan 2020 14:57:28 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F056D87EC6;
        Sat, 11 Jan 2020 14:57:24 +0000 (UTC)
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
Subject: [PATCH v11 05/10] test_firmware: add support for firmware_request_platform
Date:   Sat, 11 Jan 2020 15:56:58 +0100
Message-Id: <20200111145703.533809-6-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-1-hdegoede@redhat.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add support for testing firmware_request_platform through a new
trigger_request_platform trigger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v11:
- Drop a few empty lines which were accidentally introduced

Changes in v10:
- New patch in v10 of this patch-set
---
 lib/test_firmware.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 251213c872b5..6042840f861c 100644
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
@@ -507,6 +508,61 @@ static ssize_t trigger_request_store(struct device *=
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
+	struct efi_embedded_fw fw;
+	int rc;
+	char *name;
+
+	name =3D kstrndup(buf, count, GFP_KERNEL);
+	if (!name)
+		return -ENOSPC;
+
+	pr_info("inserting test platform fw '%s'\n", name);
+	fw.name =3D name;
+	fw.data =3D (void *)test_data;
+	fw.length =3D sizeof(test_data);
+	list_add(&fw.list, &efi_embedded_fw_list);
+
+	pr_info("loading '%s'\n", name);
+
+	mutex_lock(&test_fw_mutex);
+	release_firmware(test_firmware);
+	test_firmware =3D NULL;
+	rc =3D firmware_request_platform(&test_firmware, name, dev);
+	if (rc) {
+		pr_info("load of '%s' failed: %d\n", name, rc);
+		goto out;
+	}
+	if (test_firmware->size !=3D sizeof(test_data) ||
+	    memcmp(test_firmware->data, test_data, sizeof(test_data)) !=3D 0) {
+		pr_info("firmware contents mismatch for '%s'\n", name);
+		rc =3D -EINVAL;
+		goto out;
+	}
+	pr_info("loaded: %zu\n", test_firmware->size);
+	rc =3D count;
+
+out:
+	mutex_unlock(&test_fw_mutex);
+
+	list_del(&fw.list);
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
@@ -903,6 +959,9 @@ static struct attribute *test_dev_attrs[] =3D {
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

