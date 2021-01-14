Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3570A2F5F7E
	for <lists+linux-efi@lfdr.de>; Thu, 14 Jan 2021 12:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhANLHe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Jan 2021 06:07:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:58903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbhANLHe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Jan 2021 06:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610622358;
        bh=I43rMUfK1fo0PlRRUmJRrhdupYUuZAN9RWsx6tHDCI8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=h1ujnOXsT8YDVGbghezmnySHAbyalsfNQTydCUBQ2A110XuiAoUIYS9HHLkLkAKAG
         1l8RZzVpfasuoXg/pIwhh0PHoI0y3Fr+kX/RDj3sFucYbefbzvzKFTBVaEplqJC5e4
         HTmTcCLkOyA2wS8NODO1hjp/61TNKnu6r+0SOSkU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from pinea64lts.fritz.box ([62.143.246.89]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MYvcG-1lUr933oum-00UtPs; Thu, 14 Jan 2021 12:05:58 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ivan Hu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/efi_test: read Revision
Date:   Thu, 14 Jan 2021 12:05:52 +0100
Message-Id: <20210114110552.1522-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wpRo9pWEJ8MyjW09beQ9DV70jofyCY5djJFzJAD/pmDXwQPFukn
 vD9ANEGj0asIFN/tJ+9ScWFLfttcafQ4Q0FvZzZp6ywEqEtx2lpME5hLwiGX/Jd5h16eqf8
 9OGndhVDsedsBDAj67YHlNJ0Z6vwBWotlk0+1dR//j29uvfawH1gtWfj4LXvugLmUIvYaCU
 CGNjVqBa9T+geckoRHNeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EWuTI7CenPk=:rys905WaERl7wEEuPqMS2a
 VEqHvTXeJqZRsZPQCgbdgyFoYgGd1pobRgup2ix4lizdGH/c+aPokVN6uBWy+MBSGDl1kuy73
 eKxKGHSHPnzkMxEHoWJT9LSn09/G6PV6Hm9koIoJZ5D49Q2dkPZAhiRdPjlsNx3qursqL6L0P
 vjMkNhA2GQdAm8hmdR48F1k6XjPX8XM66XvPFCc6nRWy0a+viXvnTLcdD7yjiG7pS5i1Ys8ns
 vTZIpmlQIAcs7Qjz+qWADWZdHLDDkFhsIQ7vE/grreP0T788pogfiqa977Q6CP+//1fn6Xk6j
 SISLjMP2kivHaBDQC3pbRMf56DnRJEKAti0vs14Hk/z32nKFIiPmW0R1PhnOPR1chfSmRRinS
 f9yufYz/tDSdkdnomwRHUhRfEMt+584b/Rx2IjYxIdGngBTM329U+PbO5ictoH8R5fw29T7fd
 DWfz4Wo0eAElfumoDzQ9x1C9fLztafwymgSV8uyt7evi5gXLMHO8XfevRJR24f0PfbJTJERnO
 ClVwfcjc4ICexWvjrAM4slVfb0n+gqdy+x+prnV/yF+HZOoT3SRVNrMAEcP22JBQEsex9MKS8
 BgASzzxOLMejhBSGcT5/CpnXpyD/MOZKH5ePrWqqkoxi8QfLbS0OugAy3E/2DKFP2Y/DpHeu2
 cQ1/AQ8ImxzwYJog5DiLnkWXx38AousG74HaVuf+4WfP2A04AUvwWmVWohH3zL8y6vfFvMvmG
 kC/B5+lZqm17ib5hG3BfFRydn1iMfyQZ82iJhn693e8p0Td8o38bhAzKcsQnx44KasZuusF7c
 synXuPzY0ReTBuFyCjJ7LocxS9P8d8WZ7Jc3fkj+dJYQIalIY/LJJgzSO2lBOuNrzj9AFb/LY
 Q9Bu9PztAXDwFSluR2fg==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For testing UEFI conformance using the Firmware Test Suite it is necessary
to know the revision of the UEFI specification followed by the firmware.

With this patch an IOCTL call is provided to read the value of the field
Revision of the UEFI system table , e.g.

    #define EFI_RUNTIME_GET_REVISION \
            _IOR('p', 0x0D, unsigned int)
    unsigned int revision;
    fd =3D open("/dev/efi_test", O_RDWR);
    ret =3D ioctl(fd, EFI_RUNTIME_GET_REVISION, &revision);

For UEFI specification 2.8 this will yield

    revision =3D=3D 0x250 =3D=3D (2 << 16) | 80

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
For testing you can use:
https://github.com/xypron/rtmask
=2D--
 drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
 drivers/firmware/efi/test/efi_test.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/t=
est/efi_test.c
index 47d67bb0a516..115e2c8ca8cf 100644
=2D-- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -676,6 +676,19 @@ static long efi_runtime_get_supported_mask(unsigned l=
ong arg)
 	return rv;
 }

+static long efi_runtime_get_revision(unsigned long arg)
+{
+	unsigned int __user *revision;
+	int rv =3D 0;
+
+	revision =3D (unsigned int *)arg;
+
+	if (put_user(efi.runtime_version, revision))
+		rv =3D -EFAULT;
+
+	return rv;
+}
+
 static long efi_test_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -715,6 +728,9 @@ static long efi_test_ioctl(struct file *file, unsigned=
 int cmd,

 	case EFI_RUNTIME_GET_SUPPORTED_MASK:
 		return efi_runtime_get_supported_mask(arg);
+
+	case EFI_RUNTIME_GET_REVISION:
+		return efi_runtime_get_revision(arg);
 	}

 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/t=
est/efi_test.h
index 117349e57993..c8ab162256c8 100644
=2D-- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -121,4 +121,7 @@ struct efi_resetsystem {
 #define EFI_RUNTIME_GET_SUPPORTED_MASK \
 	_IOR('p', 0x0C, unsigned int)

+#define EFI_RUNTIME_GET_REVISION \
+	_IOR('p', 0x0D, unsigned int)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
=2D-
2.29.2

