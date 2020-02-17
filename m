Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A7161CFE
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 22:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgBQVyw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 16:54:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:39223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbgBQVyw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 16:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581976488;
        bh=B2nziXmh6lJFW+2WLt9Q+OF3D2Vko/3vLipflS6cozk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=h9VOpNkvlqksAGy17eMY5Ye/eONQ3Njxs1RN522zlVBVDiqt/qVrI4MmxPWnddkFA
         GU2BxR2UNdQfiBSwM6YfhmnpIBHfZKweYZXke8zRf/CNfjM2c+bPvH40eXYdzeKBrF
         4NDmkOFwvks8ZA1rX4E9q/muywfE0kTxTYAsgyh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McYCb-1jblWX1bGX-00czH1; Mon, 17
 Feb 2020 22:54:48 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/1] efi/libstub: describe memory functions
Date:   Mon, 17 Feb 2020 22:54:43 +0100
Message-Id: <20200217215443.3004-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nR3PnHiek6o8c3O7s6+4afR8vKohCSVQm4b5XrVdRC44EGBd6dP
 1PEMinRHB5i1s1Yd2OKUNlgchGPlMTTbLcoXKLr//rkYJahjcHfZHlsuXQNr+RLdxHLrsey
 VsFwRFhyWa+qDzE3cz+mZr7mrE5OcWTHNAnz9DLI4baDsdKFbe9sniT5fmmSuzu5Uajnli4
 0JPZvGZX+lXILeEePcKRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGjEc0owDlk=:OBlls5d8rs5WFyk3p7MfoU
 AY29vZEEomFTaAQgvv74wgYnYbMFKnlMbn63CeTKPb2bLOwERkdQz9oAVAB7YYMFBLYk9S/5g
 5POtLRn1WBpZVvm4Lno+IDGV0WltODiQqvXP7NM/5KBHSfwjXBI8PHGnIsUbC8qJqCgzN5DWv
 MZUSJxZXIUueqYqVUhZsYho/3DFiJr9ORmfDx2JrHya0Ppwfqp+lJSg1leSQHwDUVKJ0veJiS
 XmxMdLwdnlvGqOztKS2d7RifZmPuuaNSMTVMO3Y192dnYEbyfcrswmFmQmNKC+QfuCgirjTQq
 6XGAlugPZis5DDSWVAoAKNv6ElH7hPciQJyl0BAQcwtJ1IkVJK/aqNuf9wK+IyS3mJ1mBeBWg
 +mUaos8Hb31VhPqUEtTQiZWO33koFLOSyOgCGCb1k8kwPT+boxsFzAEYUhq9Anj3k2yPxh06h
 3QNG8b4SomRX4paHCWqmWtQa8lKatUbatlntiXIcx1wyo9KvFErgsS8/ME9elReaez+fTvjkz
 mKW1M73Hdd9oFqMh68mrHRjxkvalnfWidlSErn1YZFFpO5D7kxvNoiBr22cij6mTugo/kqoGV
 HV4AXKqHED5HHxOWeYAJp4KWQxDJryDN+HHEJ+lxElm8JWHeWX47TunCHR5doL1r2Iw0iJrBc
 Ss0KD/nPcZe12sA/fDpWDhESurjfSQh99SsEjjMiyZCEicE+p3mRMVhouAe86Z2USBB26axCd
 Db7CAdVT1OajB7WY7Ffkzvwn26DOhSKDrbjMTTpIFQ0pjm5i9zaHsTeYL/nKB4oix1uV2o8eI
 ZjxKDMrSf7uhrPVnRKqzSLiDZ1+OVh4Md+lSdiZHLRI3I73wGrwiwXHUteQw3zQI2X6l3NkVB
 QqdHpLhyDHYVumPtDOiPqa1VeV1HteYbCnEkgZ8Bsuz8qbP9TnHRiugXdRcXwci29R+zt1ch3
 5dzjYeDqlbvwFZdLbNjPDGnYymE09dSdgZrymd+qgkWGAdyOEXfkFuaOuVSWBu0jVrYTclNSg
 p8PnkzN4aSBNJR6//u197i0DBJ9v73DQ7JqclB7aIS01RY+BuAS3YhHbeZIkLbjpntIg0x8Sh
 1sFbJe8c4P85hLNd2qHwYNofUADWBShf7yRTVYIWJP5+qjlkUotyTAz2Z1VA/EqbSfY3AKRhZ
 aSRL3MpfjbWhiNzHUg4hJ93X6q9kn3dfTVKlJmNEZaQtrPVFjxqQF9TsmJXNPbzJ+lIqTcGMP
 jMXJ7oW3TjURrf3E8
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
v2:
	point out how efi_free() is rounding up the memory size
=2D--
 drivers/firmware/efi/libstub/mem.c | 36 ++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index c25fd9174b74..49116b9b0801 100644
=2D-- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -16,6 +16,15 @@ static inline bool mmap_has_headroom(unsigned long buff=
_size,
 	return slack / desc_size >=3D EFI_MMAP_NR_SLACK_SLOTS;
 }

+/**
+ * efi_get_memory_map() - get memory map
+ * @map		on return pointer to memory map
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
+ * @size	size of the memory area to free in bytes
+ * @addr	start of the memory area to free (must be EFI_PAGE_SIZE
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

