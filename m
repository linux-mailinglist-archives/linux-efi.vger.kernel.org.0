Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A538311C84
	for <lists+linux-efi@lfdr.de>; Sat,  6 Feb 2021 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhBFKDa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Feb 2021 05:03:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:34257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhBFKD1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 6 Feb 2021 05:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612605694;
        bh=iRGL7FWGbS8lM2q90/wYQp1C2YaJp0pAX99Mh1ZkBJI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ITSJlgqOgnjlBmQSI7u5Tr0R3RoM1ekTI+Kw9Frjs+1UxxjT1Ym1t4Gz7nXPz/6YB
         D/6TiWN9pDTE1rAnzF/WVYBCGA+5n9KSF42/Y3807m0w4s/1Hk+Q+3wX3qQk7KB7oW
         z6pB2ygKLow1Rb1l6S7eJNt8BHOMrptMeZw4airQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiDd-1lHtpZ1IPH-00Q8xK; Sat, 06
 Feb 2021 11:01:34 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] docs: update EFI stub description
Date:   Sat,  6 Feb 2021 11:01:15 +0100
Message-Id: <20210206100115.58074-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8qcEMLM+q98tifEQUVifOqzq8mbDrZvtjXPzNpOcEs3ylpjSaY
 0iyi/6lmi9OUYa+jAPiVe7IobgtHDytWHPyNmBOCEVLXXnux1DTBFV3YN5/0PJWvjWcEykY
 Jg6c5v9urzKjZBsOMr7piX0bND0X2dE7duA5WNtQzp0/yG1LJvBn3OZ96ay/ix05biNDYyy
 3ZwWD4BCotPG5LVLY7T7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4MkptHc9bXA=:IiEAiAK9dOtd2NTs3c2Pem
 lSupszveXV4JXmeXK88kELbCIbnmwWJj9VL8eJl0pATLDAsYR/GAesRa2+69r92u5+jwMyGU2
 TvpdKL/EvBoUTfUoHvr3zNDnhT5KBjcufVZGxMEgQ1zkFTJuFYxp1v+3BRqLoH2gUIMlQn9B7
 ZHuMvhIpqWHvN813SqvlocCtyN9RdiW17KKnvKZKXi4Yrt2hEayK1BE8zoqCgXa/VHjGIsrDY
 U+VOqnXhq5deeEiaW7KUaSmvjIjg900irbNLfB1e7capIjXMOzPHl0uZcNHOjxCvB/n077Msq
 IjwBroqZKU9xbGZrwJwcvWZ4S2Wxh0Mb9P4t4B2Tf+hrvBXGM3gJ0Wk2oeRuLHqJhddtAniI1
 d2NdyNQShAEEv7pc0vWq5S96ijmcJA0yd80Go+0C/U3uVLF15x7jDvU0uMGRFrqF1gecq4lML
 txjlt30Rzmp+qJ9A27JWyCWVT8xUsPMAljzXoYwo/XqeA9T5lhdvQQkMy/KaEm9RND67sP878
 3vtv+bzEsHx43RdTbQKiwkbjCVKnzz9QODLS4in4fom5RQHikS7aeLfY9C93zxCbgBL8bxeYX
 RxCYx6h064bGiyKLqY84dyqmoAJB30huZ1x8kSF4O0wSqtjiMcSwtmjkz0W1TbVub2CXYbgeM
 oADkjtJSfy81xdFCoCTRkubKt5QU8hLmeTcuifJNzRKFlEwH1OCBz4c2EkiV2xA+Wp+TjZPsg
 9XuhpuqgDhgsy7aa/UVKcmxabtYJCt1e5SPuGCjVXwPjvNTvA33v6f5RhSteVPRIcQ4sRTWYN
 aoqDq/6yhH/n7dMNchQ94H6swcp6HxI6GcNUbIyl1XuSRftVEHPhYOyUa6YTjYY6Ap0MDrkFN
 MZQUYKOQWJfL35egQV0A==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

* Mention RISC-V.
* Update code references.
* initrd=3D does not specify a path relative on the ESP but to the partiti=
on
  from which the EFI stub was loaded (as specified in the loaded image
  protocol).
* Mention that ACPI tables and device trees are alternatives.
* Provide the FDT GUID.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 Documentation/admin-guide/efi-stub.rst | 47 +++++++++++++++-----------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-=
guide/efi-stub.rst
index 833edb0d0bc4..9e1bb79e8655 100644
=2D-- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -8,15 +8,20 @@ it as an EFI executable. The code that modifies the bzIm=
age header,
 along with the EFI-specific entry point that the firmware loader
 jumps to are collectively known as the "EFI boot stub", and live in
 arch/x86/boot/header.S and arch/x86/boot/compressed/eboot.c,
-respectively. For ARM the EFI stub is implemented in
-arch/arm/boot/compressed/efi-header.S and
-arch/arm/boot/compressed/efi-stub.c. EFI stub code that is shared
-between architectures is in drivers/firmware/efi/libstub.
+respectively. For ARM the EFI stub entry point is implemented in
+arch/arm/boot/compressed/efi-header.S.

-For arm64, there is no compressed kernel support, so the Image itself
-masquerades as a PE/COFF image and the EFI stub is linked into the
-kernel. The arm64 EFI stub lives in arch/arm64/kernel/efi-entry.S
-and drivers/firmware/efi/libstub/arm64-stub.c.
+For ARM64 and RISC-V, there is no compressed kernel support, so the Image
+itself masquerades as a PE/COFF image and the EFI stub is linked into the
+kernel. The EFI stub entry point is in  arch/ARM64/kernel/efi-entry.S for
+ARM64 and in arch/riscv/kernel/efi-header.S for RISC-V.
+
+EFI stub code that is shared between architectures is in
+drivers/firmware/efi/libstub.
+
+The common secondary entry point efi_pe_entry() for ARM, ARM64, and RISC-=
V
+into the stub is in drivers/firmware/efi/libstub/efi-stub.c while x86 use=
s
+drivers/firmware/efi/libstub/x86-stub.c.

 By using the EFI boot stub it's possible to boot a Linux kernel
 without the use of a conventional EFI boot loader, such as grub or
@@ -35,7 +40,7 @@ the extension the EFI firmware loader will refuse to exe=
cute it. It's
 not possible to execute bzImage.efi from the usual Linux file systems
 because EFI firmware doesn't have support for them. For ARM the
 arch/arm/boot/zImage should be copied to the system partition, and it
-may not need to be renamed. Similarly for arm64, arch/arm64/boot/Image
+may not need to be renamed. Similarly for ARM64, arch/arm64/boot/Image
 should be copied but not necessarily renamed.


@@ -55,10 +60,11 @@ multiple initrd files using the "initrd=3D" option. Th=
is is the only EFI
 stub-specific command line parameter, everything else is passed to the
 kernel when it boots.

-The path to the initrd file must be an absolute path from the
-beginning of the ESP, relative path names do not work. Also, the path
-is an EFI-style path and directory elements must be separated with
-backslashes (\). For example, given the following directory layout::
+The path to the initrd file must be an absolute path from the beginning o=
f
+the partition from which the kernel was loaded, relative path names do no=
t
+work. Also, the path is an EFI-style path and directory elements must be
+separated with backslashes (\). For example, given the following director=
y
+layout::

   fs0:>
 	Kernels\
@@ -83,18 +89,19 @@ is passed to bzImage.efi.
 The "dtb=3D" option
 -----------------

-For the ARM and arm64 architectures, a device tree must be provided to
-the kernel. Normally firmware shall supply the device tree via the
-EFI CONFIGURATION TABLE. However, the "dtb=3D" command line option can
-be used to override the firmware supplied device tree, or to supply
-one when firmware is unable to.
+If ACPI tables are not available, a device tree must be provided to the
+kernel. Normally the firmware shall supply the device tree as an EFI
+configuration table with GUID b1b621d5-f19c-41a5-830b-d9152c69aae0.
+However, the "dtb=3D" command line option can be used to override the
+firmware supplied device tree, or to supply one when firmware is unable
+to.

 Please note: Firmware adds runtime configuration information to the
 device tree before booting the kernel. If dtb=3D is used to override
 the device tree, then any runtime data provided by firmware will be
 lost. The dtb=3D option should only be used either as a debug tool, or
-as a last resort when a device tree is not provided in the EFI
-CONFIGURATION TABLE.
+as a last resort when a device tree is not provided as an EFI
+configuration table.

 "dtb=3D" is processed in the same manner as the "initrd=3D" option that i=
s
 described above.
=2D-
2.30.0

