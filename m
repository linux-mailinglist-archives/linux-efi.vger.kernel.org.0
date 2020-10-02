Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC672818E1
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBRL2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 13:11:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:38737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJBRL2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 2 Oct 2020 13:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601658680;
        bh=63H9pOiH0+7afFaplsAsPhAJR6vHQUiql917hmAqUC4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AHIBOjdQrMnUSdVEpEelxmJ0npV7i+cfWWBZpd6MXVvFQY+HVm4duv1WSEclNWJrW
         na5XrKkpugfVIrDGvUE4f/dLVJnT5g153nRdkc9WPZhxCff8fUaMHymb4hwcAa+MCD
         jF9sK+FPAfQIc6VfM/EoTqalSl5zwCrAI0eleQmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation4.fritz.box ([178.202.41.107]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MWAOQ-1jvBXx43li-00XgCU; Fri, 02 Oct 2020 19:11:20 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] docs: admin-guide: fdt and initrd load in EFI stub
Date:   Fri,  2 Oct 2020 19:11:12 +0200
Message-Id: <20201002171112.22738-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9fZxmnWDuYGgQgNcRpM+wK+ePCFLSvRfmJIcmYW0YkFQZN49Tsg
 yaKZn5ZsBMZQ5LRjl//11nXeogKaa2pU5bf/SogphX0yOLPONPcEdGytZxFXXjna8RU7Hyh
 0WFxYbNbsN5hE8khpQgI+Tb8CgrX0uDxkfS6eao8jsA1ToID86fjUTVe9TVxa7LdtOqGlOr
 8gljEF1Tn6HkC1hkYERBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4lfLB/DNw+M=:GCTPZBTTs4ZmwZ+lZr0j9j
 uScruu1n/2XPrZWcdyK2iG/MY5HrVtJ7wznHNHAyuKUfsVGuz7cVePf8d7authL+lu2Xh7T4q
 sR17or3373rFET5LBE87NmpiK2sjAaFmpDxsABqYhTvLg0lLaJf4bs7eDQRoAp+PrMtsp5rdz
 M/g4Mt6TDxVPeooKpYrytcK3dgW/AWgBK46GMXm0nTX7OsUNPbDDJH3zMlDHHdWe7azuwTWTe
 2N0jvi4uvALkHjyCb1QRYETxh5PcUkwPaWN344tQQqHq2PVLCTbXuQjmfAenvY0w83TbVLS0g
 f7rX9SABHptl03s90sj3OtF3pUZp5u2pV0cFWmjPyK+QzTBbtGGfMX0BfZ+WcobvV/rlH7zB6
 2dZ6tTR6vn/d+579yvY8YgjpKiiEplWRJ5o+VzRUXfXaKh3wum4CwLibf2r9370pZAgV6zr4H
 5jm5qQWcKpT4BWL8FMHmd1JCGGuYWtvT5NnuA66zFXPKvAeMu45+qJa8cLvRemvNJeIv2xx16
 anqVHu2uqVcK+9m8V/Jvp+CSXcEGMs06wiGqbMfFuJSV1pWtCFx+cv5e9AE8rXQCAGWuLH25h
 0V3SC4AtBibpv+AkB8Td8QKDxR0y8tOXmINIzQN7wgvZa/0XPtuE6Uv8xK+wwn89XAvLiujFb
 W2HoXUK4jR9KNS2Loj2UReX9Agvc/hRWY5NZ2cKNklKL/PeGIBbhw1YvB4NMnN3Bh1bhMdefQ
 GOVTXiev0ez6NYeh3tiQIHW/L8GSb0b18FS79s2wbMUGu8YQcRZdI3jZjtQM90MYIVbWlTjeB
 3SwRigV8QoT3dscHeKs3Wd5Cd4GmeIvT0U5/DXKUqBKHdX1p1pllmK0dIfHM3GbSAcDD6DgC8
 ACLbK86XXI34bR0MIStUrmU34RHZsjjz4UbzeBbQ4eYvzSaSR2elvQja10Tl3D3VPddTZ3d6/
 F+VzjZTNpkgn6i8OoxTi6BhE0N7T60FYhIcIy+sB+G9TzVyGP0deeRvXUDlSHP7fTSFZzLlRd
 iNUSV8OZ/h3RphYGYkT0Fuw8naeehrIWDC6VQnGA7oSdvjssZI2Iimhds9MMQTLKcaxwJ8Sx8
 goXwuwL7BgGpHjWzT69RE8niHnn4Bx6eWuyoMajW1h8J1h7+UfE65E6vs/6C+4SK/xTA1PlK3
 Ju7pcBpGkdpG76SAZNrDkin7R+1+Jt87d1G+Qx0rUQtFdiXnXVHP+x5ikixF8aB9IXnA3rydG
 L+VxNDn/79m5OiZJjcNylfpGeF5ZjELEXKjeRPQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Describe how a device tree and an initial RAM disk can be passed to the EF=
I
Boot Stub.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-=
guide/efi-stub.rst
index 833edb0d0bc4..86f50a33884c 100644
=2D-- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -38,6 +38,34 @@ arch/arm/boot/zImage should be copied to the system par=
tition, and it
 may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
 should be copied but not necessarily renamed.

+Passing an initial RAM disk to the EFI Boot Stub
+------------------------------------------------
+
+The following means sorted by decreasing priority can be used to provide =
an
+initial RAM disk to the EFI Boot Stub:
+
+* The firmware may provide a UEFI Load File 2 Protocol. The stub will try=
 to
+  load the RAM disk by calling the LoadFile() service of the protocol usi=
ng
+  a vendor device path with the vendor GUID
+  5568e427-0x68fc-4f3d-ac74-ca555231cc68.
+* Next the EFI stub will try to load the file indicated by the "initrd=3D=
" command
+  line parameter.
+* The prior boot stage may pass the location of the initial RAM disk via =
the
+  "linux,initrd-start" and "linux,initrd-end" properties of the "/chosen"=
 node
+  of the device-tree.
+
+The first two items are inhibited by the "noinitrd" command line paramete=
r.
+
+Passing a device-tree to the EFI Boot Stub
+------------------------------------------
+
+A device-tree can be passed to the EFI Boot Stub in decreasing priority u=
sing
+
+* command line option dtb=3D
+* a UEFI configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aa=
e0.
+
+The command line option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADE=
R=3Dy
+and secure boot is disabled.

 Passing kernel parameters from the EFI shell
 --------------------------------------------
@@ -46,6 +74,10 @@ Arguments to the kernel can be passed after bzImage.efi=
, e.g.::

 	fs0:> bzImage.efi console=3DttyS0 root=3D/dev/sda4

+The "noinitrd" option
+---------------------
+
+The "noinitrd" option stops the EFI stub from loading an initial RAM disk=
.

 The "initrd=3D" option
 --------------------
@@ -98,3 +130,6 @@ CONFIGURATION TABLE.

 "dtb=3D" is processed in the same manner as the "initrd=3D" option that i=
s
 described above.
+
+This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=3Dy and se=
cure
+boot is disabled.
=2D-
2.28.0

