Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD5165802
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 07:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgBTGxh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 01:53:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:37995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgBTGxg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 01:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582181603;
        bh=57bSrNIO8vooP3oPWDS+RWszP4EdhAofLElDkZ74PRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TYF8v6sl3/aA23hWT7WjdZVGTXRiz4UCv91tbwi5nfQVOVph3h+cyA8Vyz6JohT7x
         FDia3WE47xFF1HGr5O+bM/G4brnDR8xbO3iLLrzso941cOZ3nlJTk0ccQceXdlvB9G
         Q/55obidLvHDhXFLIMYWS61O5EmcRsJpX5EjxAeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1jAxMf3Rr1-00BwYE; Thu, 20
 Feb 2020 07:53:22 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: describe efi_relocate_kernel()
Date:   Thu, 20 Feb 2020 07:53:17 +0100
Message-Id: <20200220065317.9096-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AzByTvqIzEUk9OWcZDLa4x2/GmSUAFaNlfdl2QEcw5s5v3Jj3+o
 gSLvXRD4NfNVo/96lRnYt+qu8kj0Tudes+ahkkhV6/xuSR3lzECbDqeZRISdK3FSuRIYul6
 ac1mHfGfNNCqtTyk7EIhgoF2Bd1HFxzu4HQT+n2J7V6oYT5avEZ0l8QGUU/SUdbIlme+WSB
 8wZtblqA6W3t8/a+uj0aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVQiiZxJyp8=:lkFgXrOlU9dumxHBDgWh4H
 /lv4IgbI2jDTkYI2jrW8hjNyLu/5mb61BE2TjisrONO3KdjId5vR2yiRymHp4pEwvAdEMLGQU
 4zPtQwwTznG7AaZNskWOSWovj4Re0BAi5WYwwdUd+ybOipVzyZ0C8jVgurFUOyDLP0ohTCg9D
 GPrNWhRvTlFEJJz91YjvBAQOiry0fp8P6tlK6eBM+NqIkgDFXf2EED89d3EMeQ7z1BokJvqtR
 oXT8ipYcBbvtMHCXop/Mqf+ElbWMfrwIw22zCcsQEWomwqZVX3cS5rWnp2saXN4JljYhFE6nw
 GDDndGangS4qYjInbB8r02IUZRGqJOj5rqXa+mwiEU9CYgghEix3YXG4yJpHZk0YxZxvvsTx1
 q+AcvcGIkV1jEfXsG/Jbi4/GOLzo5EUiuFfuXAEXwPSN1K/ur7q6bJAUpAHPxbQmWHAmrt5L6
 Is/qE9XBuQoXZwR9kAPDQb1Hgj7nnWMhnRUgYvrQKTd3NNQBTBjAksjYUItvy8vSuiJsq3Qs3
 eLMDocJonPkpGY8nPmVMu1FQ48vjfrI25R/eFvGiYqQE7NQDaOt9MBFjmgaZ5d536M43FtPeE
 tb0MrQwZRSmajxegSbkDWrIrvkYoYAGjtQe04qrHLz+cJdtHXzgU9Xicx451B/eB39PCTK6ih
 tvOwG3BLKkjpTZab0vIhpLORHuJwh4qbPWvRqLbLOh9TP/CqXjZbuKAh0GPHRE0JF5JAU6aik
 RiJZipXowQkK9B7X83rJXOSU5WwyErxIM5dZlYmlpYEYh6ZySILa2hv0jbTA0SP2NSQ4e1Une
 emjqoSTvkPAxHffLccLXGrMalLjQg7W//iGgYXZH+aM/vhClWJBsFs0BWcrriB/mHGzhJu7cN
 6GOipPSB3VjANsmChADiMMw98qWHEUYXOTQw+twvii+8+EP3UVON3ZUY2CquZhJi4liNtwfHJ
 QmJM1nqIIgUq+CcV2lYELn8LGFymkrECHJKNrmKkVg3zzS3QxbDFFbmKf2CZHF4TRfyTiXuYj
 zE0TX96FOqH441ln/w0HhHpI0M4m6brziGB851kjjyLSdGwzLOKzQ3luJ2SacrYgGdYdhasUv
 2O0bx6Brn7OTAWztgPgSViSqN78ssZurL6P8NrJVp6TCNX1mxPBhXoTrqc5eysCC4U0mHFdct
 whdGwf/KJRH9yRPU1ApwGVlP5+2YOIjBLcCAnLAAAwD9tA3Q5Hz3CnI3i6KXsCOUr/99ylL31
 uV0O2Yypwj0q8xQwT
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update the description of of efi_relocate_kernel() to match Sphinx style.

Update parameter references in the description of other memory functions
to use @param style.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/mem.c | 38 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index 0d57078e5e62..7efe3ed2d5a6 100644
=2D-- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -86,7 +86,7 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *=
map)
  *
  * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned acc=
ording
  * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the addres=
s
- * given by 'max'.
+ * given by @max.
  *
  * Return:	status code
  */
@@ -126,10 +126,10 @@ efi_status_t efi_allocate_pages(unsigned long size, =
unsigned long *addr,
  * @addr:	on exit the address of the allocated memory
  * @min:	minimum address to used for the memory allocation
  *
- * Allocate at the lowest possible address that is not below 'min' as
- * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' =
but at
+ * Allocate at the lowest possible address that is not below @min as
+ * EFI_LOADER_DATA. The allocated pages are aligned according to @align b=
ut at
  * least EFI_ALLOC_ALIGN. The first allocated page will not below the add=
ress
- * given by 'min'.
+ * given by @min.
  *
  * Return:	status code
  */
@@ -214,7 +214,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, u=
nsigned long align,
  * @addr:	start of the memory area to free (must be EFI_PAGE_SIZE
  *		aligned)
  *
- * 'size' is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
+ * @size is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
  * architecture specific multiple of EFI_PAGE_SIZE. So this function shou=
ld
  * only be used to return pages allocated with efi_allocate_pages() or
  * efi_low_alloc_above().
@@ -230,15 +230,25 @@ void efi_free(unsigned long size, unsigned long addr=
)
 	efi_bs_call(free_pages, addr, nr_pages);
 }

-/*
- * Relocate a kernel image, either compressed or uncompressed.
- * In the ARM64 case, all kernel images are currently
- * uncompressed, and as such when we relocate it we need to
- * allocate additional space for the BSS segment. Any low
- * memory that this function should avoid needs to be
- * unavailable in the EFI memory map, as if the preferred
- * address is not available the lowest available address will
- * be used.
+/**
+ * efi_relocate_kernel() - copy memory area
+ * @image_addr:		address of memory area to copy, on exit target address
+ * @image_size:		size of memory area to copy
+ * @alloc_size:		minimum size of memory to allocate, must be greater or
+ *			equal to image_size
+ * @preferred_addr:	preferred target address
+ * @alignment:		minimum alignment of the allocated memory area. It
+ *			should be a power of two.
+ * @min_addr:		minimum target address
+ *
+ * Copy a memory area to a newly allocated memory area aligned according
+ * to @alignment but at least EFI_ALLOC_ALIGN. If the preferred address
+ * is not available, the allocated address will not be below @min_addr.
+ *
+ * This function is used to copy the Linux kernel verbatim. It does not a=
pply
+ * any relocation changes.
+ *
+ * Return:		status code
  */
 efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
=2D-
2.25.0

