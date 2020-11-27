Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C92C6DF5
	for <lists+linux-efi@lfdr.de>; Sat, 28 Nov 2020 01:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgK0XaP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 18:30:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:52409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgK0UDS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 15:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606507397;
        bh=wu2nZP4IU+Top3OJoASjBBseXIv67/YM1/7RX5sWhD0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=haIfBawZIliqKxl/RsSy0Bpsjq/9bQ2CaXQjb9Ex58NAswaBQbS0rVxTxA3ZYEtlI
         fBqdBmZ6vCMssrm376nnvQ2MDLIL5VbLZuAazrIRdOvSSuDUzjJFE+U4Fm8GjdYlZo
         HpaCHbDvQAHctuxCaqVnY2o3mBB6yF23iiL2nlPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from pinea64lts.fritz.box ([62.143.246.89]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N5GE1-1k1fCx3yCb-011BwR; Fri, 27 Nov 2020 20:20:59 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ivan Hu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
Date:   Fri, 27 Nov 2020 20:20:51 +0100
Message-Id: <20201127192051.1430-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lWorqsxpAegYMv42EWAGou4VXMWq2jeLtSdLq2ZTmDI6syKzKM4
 JxPRHWZVYtXZcQAOl6Cvm0R7FduZ5lDyIVjtBGp/m/o9oJhKX2tOk8S8vkErwBDX7jkn2Ci
 vGzW4VbnKaQqOd0JTTI1kERCD/GYa6NEsWIBJWt0i/uT9r4N5lDX/Ju8R8VnK+0ZNBzmioM
 OXNdOQZnwGs8LhgcmkG1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AyDzyThsc0A=:F0KlDHaLkuDLJQfyFakpFx
 138e2j7ndyeuT/lrP/90SyFLlNaKn8Yr4FLVJRr/dc+6gonAudD9Un38241sWBI8jgO5nULqn
 zEdkpKTezxHYfu0kGWmB1yp8XrMHt4LKkMEUek+Sezk6zg5+hkxhjqTxB4NUFoJMF9t7gW7Z6
 lLA+X3ikjumhHM45orqCF78UOMEB5FX6sJUbaTcTz0AAGxLAA44yuEb9LYnV8caYKiUOzb1SF
 j0z+rXtpGmxnZlFEfgQQl8373PS/IXRxEJ2/mA4AK/YlbkcYmONkXVIz53nOTZOUHYXiitCzN
 dTIAESyHApyW1KTUPg3iqMKjx3jPDOd7a+bf6lNmzf59wr9dH740X9P4KaRFbJ6PweUKN+Uup
 1QrGCmfO0AXwsjMs7r2VCS9IecoKEWYkQqF+0r7FvQehxCPr7Te1+sFlzxPtyUKONLhlYTpWM
 /Sd4LyAyNwQqmDj7yCnu6G+HTjQQ6wEhrx4X26pwTcBYvv+b3zasnPNzwg8ZzWijCgiQN02f/
 +eBKKQ4raXN/IDI6mq++xQBwhcL134HqVbdYZBJcMxMB98jDWrl7ZrJbRfEVIIbxf7PhPZNF9
 Cl20rpCkgO5KHxeN+6tmCCxSC5hhwTincVVg5CvE5tGjcHmOuboCxKjENNdIo3wUdnOPnyYmO
 7wpVhRtGtGeiDnooIZr8pEy6YNTFLS4ZhA08xgfYbD9SA3UCnIHWXu9ZvK7ngQ/7VZ1Q23i5Y
 5I8HyMxgnF+AXF0WN8xA6D5USrNV/N5nTnk9CC/KTdEhzfGFc1uPpKdYFc4kfeYNFQjYg7ulj
 dUQJa3O7x/1VaBgySwx2G5AcSK/eRP0sw0CYMLV8ffmFnSAl0mPtkgXwqW46lCZnRFbiGKB2X
 Du1C7F/77zo9k3S3CgyQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since the UEFI 2.8A specification the UEFI enabled firmware provides a
configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
services are enabled. The EFI stub reads this table and saves the value of
the field RuntimeServicesSupported internally.

The Firmware Test Suite requires the value to determine if UEFI runtime
services are correctly implemented.

With this patch an IOCTL call is provided to read the value of the field
RuntimeServicesSupported, e.g.

    #define EFI_RUNTIME_GET_SUPPORTED_MASK \
            _IOR('p', 0x0C, unsigned int)
    unsigned int mask;
    fd =3D open("/dev/efi_test", O_RDWR);
    ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
 drivers/firmware/efi/test/efi_test.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/t=
est/efi_test.c
index ddf9eae396fe..47d67bb0a516 100644
=2D-- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned lo=
ng arg)
 	return rv;
 }

+static long efi_runtime_get_supported_mask(unsigned long arg)
+{
+	unsigned int __user *supported_mask;
+	int rv =3D 0;
+
+	supported_mask =3D (unsigned int *)arg;
+
+	if (put_user(efi.runtime_supported_mask, supported_mask))
+		rv =3D -EFAULT;
+
+	return rv;
+}
+
 static long efi_test_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned=
 int cmd,

 	case EFI_RUNTIME_RESET_SYSTEM:
 		return efi_runtime_reset_system(arg);
+
+	case EFI_RUNTIME_GET_SUPPORTED_MASK:
+		return efi_runtime_get_supported_mask(arg);
 	}

 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/t=
est/efi_test.h
index f2446aa1c2e3..117349e57993 100644
=2D-- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -118,4 +118,7 @@ struct efi_resetsystem {
 #define EFI_RUNTIME_RESET_SYSTEM \
 	_IOW('p', 0x0B, struct efi_resetsystem)

+#define EFI_RUNTIME_GET_SUPPORTED_MASK \
+	_IOR('p', 0x0C, unsigned int)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
=2D-
2.29.2

