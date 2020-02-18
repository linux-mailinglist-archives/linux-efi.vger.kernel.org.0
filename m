Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F51620DF
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgBRGbB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 01:31:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:53083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgBRGbB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 18 Feb 2020 01:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582007446;
        bh=ZetF6xqDcMO2JF+8ExFRyxevjA05EVourTLBK+C8MZY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=h3t6q6HbpWcMIwuM5XXaitRV946wHWz34zMRYTptt5KD2Ry1Yas2Npt31bfP5tWrM
         oNszrJ1aLhWvK2UBAMJE2LEDfRGlstHC+OFXnUD9hjAFA8aLQkS6vN3H/C53Xr8Fw7
         HxwxXFNB6XhwklUfR2Npj5x7FzvpW8rh6urwAVgM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49lJ-1jU1yh0qjh-01039u; Tue, 18
 Feb 2020 07:30:46 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/1] efi/libstub: describe memory functions
Date:   Tue, 18 Feb 2020 07:30:38 +0100
Message-Id: <20200218063038.3436-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wT1b3Hyriht0Y77UyRjiTY6NhsK1Xom/4zgy+2HXWMVTFqzr6/n
 t+QKm6GAaqJ2IpNAjPI4O/TMx+SN+D4qVDIltIss/NZU+ne3/28FnphpYlIPWmrZv2CwHnx
 BhwH1YHTDRF2KbZttiUzC1S70sIrbELJysZyTHywn81LQLWhp0YwC0Z4DDJSYROLJrqKpFN
 IknPAM1db1q/Z5WHNS6Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TDUFYsQl3c=:LwgYPXofV36Z4bUprxb3WS
 ThwGAwg9JS9rNiWrmbQZHXaHSq1qiiiwYrRdhZDXYJTLG9Xg0zlyosRCHeaXsYumt2xL7jaUR
 mfxjh9ZkIBJngNbUX8LaARIh7t/Prmb9YUShztE57eO1DwkkDBkgCxG6Lbw0wjnthIwGcwXRU
 J0USL485kjdPGvPJoZ8cmnTkr6/nDcOuJrGW7OkhrMHQgqVToxoT14dPvQ1jgc3EYq2fdKuxY
 oAkF3rHXDbzSlUzyGUouHIp3KDq5Oyy7fEAA8eLlWsu1zOjSsBxY0XcBvHk4ZkdBR7fTS0JuY
 7TDH8/kO3zp4N6J6I7Yo6w/I9WFh8WGoRXNgB+5uFbvGNdhYR5wmm5m79ofaejSCtzQd3w3IN
 tGJKKdlW2N+wRS9O7cUqxSeWdHVgnUu/DC8py50r+CFcdYLL5VID7Ekn6sqPPOUxvkun1V7Uv
 t8xwdXb9bYD6jqzi/lguXOTNGQ3uYOLeDNpOrTa0OxEwR/xdyWR5s6FRIlloqIakb6AT7A46h
 YcuOGGkz7tEfGQFRDd8x5VikQJydAyo/4YbHHVLg85y+t1+DTJ6kzB4RIPlHQyv/wElBNWQDm
 1dxbjwE+1DOlIz4eUs/HQYRl8IQJUNy+ls69LUOtSKB76E+sEXzIsLxOrL+/TetwO1drvVSCU
 QbbKwtHiPbXW62ldbV94+AVT6PCGHg4n7cfehplBSQ11qXyoAi+5/7cAuCTPGLylZNstb6Krn
 MQk/sMyAIwl33HKoYwuRm624fOISoUS/l7+PuTU1q2n+5vAuzYMTGdNdw/pBu1w6Xy81qr7v8
 CoxM1Zzdss7XM15TvJzwbqPk8SH6SRuM4CW+D1O00nhvMIkzefWkQvz86nm5mdVY3tVlg4y1D
 UGIoc5ehc7qRLNPp0tQ0xiEy/bEIglmruk39v2MIFuxq9i7fh1jpiMh5w0PItA7VP8VpXcBd7
 3nwG+qJHiLPgyJqARXJZ9eOHHhF9Q9oJ6Fo0EybGmrGMwO4tfvq0Hbr7Jz0wvQFwAhfg63BBs
 rqE9SaaMlSukpKFPumtFTiTH0r7atXv6nkiZPD5BJytjynzVMJdyYP9lldZ/v7yOVA8hXnOuh
 e9zVnHKRVXSTX6b4B+Du4Wyp8/KWnEND7YbxSnw9bWi7a1Wgzsh9Yex0gTDCaXjpw/FkgvjzJ
 sKdez7wXrIwj2mOchhkl1v7ehwwF9lNq6FngyrulCXcJMHU+Zo7hOhhdx+4Z6tfiNDgXlplFJ
 D7mPBOq6N+yVoMuZq
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide descriptions of:

* efi_get_memory_map()
* efi_low_alloc_above()
* efi_free()

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
v3:
	add missing colons for parameter descriptions
v2:
	point out how efi_free() is rounding up the memory size
=2D--
 drivers/firmware/efi/libstub/mem.c | 36 ++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index c25fd9174b74..7cf2823bdedc 100644
=2D-- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -16,6 +16,15 @@ static inline bool mmap_has_headroom(unsigned long buff=
_size,
 	return slack / desc_size >=3D EFI_MMAP_NR_SLACK_SLOTS;
 }

+/**
+ * efi_get_memory_map() - get memory map
+ * @map:	on return pointer to memory map
+ *
+ * Retrieve the UEFI memory map. The allocated memory leaves room for
+ * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
+ *
+ * Return:	status code
+ */
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
 {
 	efi_memory_desc_t *m =3D NULL;
@@ -109,8 +118,20 @@ efi_status_t efi_allocate_pages(unsigned long size, u=
nsigned long *addr,
 	}
 	return EFI_SUCCESS;
 }
-/*
- * Allocate at the lowest possible address that is not below 'min'.
+/**
+ * efi_low_alloc_above() - allocate pages at or above given address
+ * @size:	size of the memory area to allocate
+ * @align:	minimum alignment of the allocated memory area. It should
+ *		a power of two.
+ * @addr:	on exit the address of the allocated memory
+ * @min:	minimum address to used for the memory allocation
+ *
+ * Allocate at the lowest possible address that is not below 'min' as
+ * EFI_LOADER_DATA. The allocated pages are aligned according to 'align' =
but at
+ * least EFI_ALLOC_ALIGN. The first allocated page will not below the add=
ress
+ * given by 'min'.
+ *
+ * Return:	status code
  */
 efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min)
@@ -187,6 +208,17 @@ efi_status_t efi_low_alloc_above(unsigned long size, =
unsigned long align,
 	return status;
 }

+/**
+ * efi_free() - free memory pages
+ * @size:	size of the memory area to free in bytes
+ * @addr:	start of the memory area to free (must be EFI_PAGE_SIZE
+ *		aligned)
+ *
+ * 'size' is rounded up to a multiple of EFI_ALLOC_ALIGN which is an
+ * architecture specific multiple of EFI_PAGE_SIZE. So this function shou=
ld
+ * only be used to return pages allocated with efi_allocate_pages() or
+ * efi_low_alloc_above().
+ */
 void efi_free(unsigned long size, unsigned long addr)
 {
 	unsigned long nr_pages;
=2D-
2.25.0

