Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA52821D6
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 08:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJCGiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 02:38:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:47939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgJCGiO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 3 Oct 2020 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601707074;
        bh=md0r0m36JBviEhAlMywLuogQp9PqQBA26y2UxZb0WKw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MR2S4uqJT6zeEuMKunqAU8seXGD3k5im+o8JRx+AyzgzgMsGEcD8Koam5EqTpkEGi
         DKl47rQfF9z5WXK53+nFUAmNArPXCRTUC2t3//VRvzA8D8LcCTelrot4I4Ffhurubz
         HJYsllbeYRAS9/3sJ1z43gqo076pqTEp8G1Md0fE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1khESP2Q1j-00roqy; Sat, 03
 Oct 2020 08:37:54 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/2] docs: admin-guide: fdt and initrd load in EFI stub
Date:   Sat,  3 Oct 2020 08:37:24 +0200
Message-Id: <20201003063725.8698-2-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201003063725.8698-1-xypron.glpk@gmx.de>
References: <20201003063725.8698-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GPrLsj9lxvHLBZU79XBKoGh3Tqybvf/pk+6ebZSYKfl9LsWZe9M
 BCkoXUBoP42pRKZvaX+A+f7GpZGLX8NUkJ00fdbt2e/rt22sk+FwjNk9mtxZSRZFSn5F4rw
 8+ff7EHNinTQyOmdS5699oVnFYj+nzycp57KzC3APNGuh9q5SlCZlj5EKYdAE3W/4+AFaAZ
 VTNluNFlCUWY/fn2r0nNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQMjD0Ttnxc=:yjwDY+VJpjraaTbaIxLNtR
 UhWnTe+z00u8DzzGXQQsnF4y56JE6nS6AHEu5UXA0KG/dj2lEhhYzKP+Dw236eAMiT8gdU5aM
 IRhTjAz1HXwbOgL/Sc341q6i8M8nX9ctxs/eDdgU6np6kxjx8NqzQw5OaOEf6aCSI32mHa3C0
 0lBj3r7iE5HO06W4ptJlCknGUA/bLpo7ceA+zFT2tSpLPI8NKKZ+S8c/BwH35/4g6vhj5+ZIo
 7iFsNLg9a4nTFEojiXoUvcyrQ8nQScHF43GTN7fQcxc1VY65hC3Tvmn3kZKHA+AxlOG7Byb9S
 aU2otWbLiV/fL5aVsqEUbJD5Z1wZTlg6DfNAltfdbJUl0IAGTklrrek/jz+ryUHFk0Vor6kJh
 rKnHDOnw7bK41vQ63FtL7F6z5dFYDxK+5lGNRwqHfSXA+iCYXJaUK2upbQZ1c9lmYSnJIuWIa
 Hf0eR0cb3DSx154wHWndA9GVcPi2GosvYxAFxlNxsg0VVpsrDchK4fDi5qc7LdaK4zIt9IG6q
 TRQjtM6/qXxTXLsn3gC7Sk75Inq61EiqNtz/bZNQt/77dqKCcz0KsNQ2cO56VnNSPtvu2spE+
 V87zC9tE4VrPjzk0Wff1fFbMCb0kZ1dGLdzmBk76VnTFw//5ec63sH+sx/5l2PXtAQvz3m6S3
 LLiguBkWxlpX7pWvBcdkhEcplkbey2DSeuUal7s9uus99tU6cB6oHNNzIEZLsp3fqBevc+2tD
 GM0qk1c/EowmDEHGvk9XgHROXokWkMAW06pu5EpSVw1UzFP9kEWCo6zRl1sDfPj/MzlyT2n0V
 b2dCDRN96m9eWqTHGA51uhlX8BAqYd1gGWyr87IIUiceE+yW1Uj9+k7SkZ0rCjSZ2X2qQqT2U
 sHHUQrPHob3m0OmdpaZWkpDhRKVBU5dLrhnglFz8WxfbC/bh71kCiQ6sAY3dreVs8I9c3jMn3
 LLdYXsaTRTlHNazd6aaD8ugUnbVFXjqQ66Q1liVC2X4dzX9ptmDqh0RCPOcQPGfDE/st22aEt
 b0GN+5vJw0YBAfRoqqKxwwQmY9nE8jXqTjvm7zH9Bs2UB6TWAiDjwCxe6+FmwhHU4OW0wfnVl
 mj9MLhGvHeCKbndMntW6Vt59HWgVNkSnavEiiglQMjhkiNMqFZKJ9aojAmobgCzoVNYvMtJnc
 ofkekeyvD+sujIRySDwewAiapDtnirTEGN5UOELsCaA7GSNwTAbDiEirwLS77Jjbwe4Qb2yVm
 cUV0sj1rMxiFjnkuJVBHBc1z6HxD1CRxaIIkAhQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Describe how a device tree and an initial RAM disk can be passed to the EF=
I
Boot Stub.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
v2:
	mention EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER (thx Atish)
=2D--
 Documentation/admin-guide/efi-stub.rst | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-=
guide/efi-stub.rst
index 833edb0d0bc4..4965dec48af4 100644
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
+  line parameter if CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is enab=
led.
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

