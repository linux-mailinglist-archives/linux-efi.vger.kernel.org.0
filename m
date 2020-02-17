Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB518161CAF
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 22:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgBQVOi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 16:14:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:42879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgBQVOi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 17 Feb 2020 16:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581974073;
        bh=8H8JRzVVErLcA/Cb9W/Jfd6wJk5WexFr0YnVg4lPI9Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZFS8ynyc0sOGd37Ms2urLYqMtXjjUUR8xfk8N2GzMivAA2qr4lGGCcHxO9HEHTfpZ
         cC+M5lJ2XA7Q3EShCtdFxmLBRHlU2nbqB8YrBf1W7ntHgfCE7oMT4NpIOLPO2PRjQd
         eFmrhfBjTKog2dQvWOiN5Q65EZb6DfrnIafeUZVw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfJd-1jJh4w2WI3-00vBI0; Mon, 17
 Feb 2020 22:14:33 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: describe memory functions
Date:   Mon, 17 Feb 2020 22:13:23 +0100
Message-Id: <20200217211323.4878-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q2AyUA5LF6qwEZq6Q+uOFmeB3JLxCGgHUi2RXlqJuONOIwkhyFG
 YLp1Y1+VrxJS6LDZP0D9KpAug6GS9nAZ51KTewxY4qlubTvAwJDW5+Cqfk2T4pd4jIpSYAX
 LeUcuaktEif0wE79/j81lgVr9BYzH5XarnngToXZr6zy5hRS3+pxZYa6BSqtyhdocUC54wb
 1ZujKBWWo3vNwbvkRyRkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5OSwgTjpeJg=:XaezFtnCG82PBKlTkduXgm
 ZfRBMgRF/tp8R+zxSoxrZPvxnvo2SOJ+EhNJNpDQDPxt3U39TQ2FWPNCXHHlZqovbqdI1N8LT
 cvQKPad8KzDQ4gfM1jPUeEYlKzvQscXA4XHPyQ2P3sSF677xNMR6jdDjU2cBRJyQCNLZI8i5E
 4gEXiTFoUvjRUzB1dGT+FA1+kT8cPz+iuEE/2S84DCP1Wf0kGAfssBjrBDUSDSVv8m50HQ6vf
 5005EAeiiLp4IW/vNuxsW4sRmypY8DiHGk6UV7D/PgLMX1n2zqYq+5M9pziChnDYuoT3PjB+J
 4klfhYD057+Hj1P627yfmgS16vBZzjSq2wnzigN0Zak+qxRTIij1XXPgUG9Le05MpRAiz5Q0h
 7QqMhmR+6+0sSQJiRpMZzWOtjSD3O2YhAu2F0gDyBF7xziERi7ueBH0YYuzs3x1xb37jiCBfS
 4ks11PKLhj3fJ6w9/ztbYkBdXNpSie8wQrLQwGDCtO5YFR6XBcK8PDFMWf1r7wsLnCsvILYeY
 WuVeoXVukN8VoMAY9jkQhALcVQ7RH8/fSepEDQZAbeIFvahmWwosmEios3cn989jIih9ZCAq0
 390d3WNCtIDKa2rAGHVEo02hJLLuMZfvqEONtCrv4hL6c3d0d8wYCen0c9H6k6ztsUG+e3Iki
 N/3rli66uA/PStk/OiLRnbdJSqVR2Orx8K++JN3+ihjkMnK7thiWz37zHyDElVidKD10xzgAH
 TDOoWBAf9WcWswif/BLE94K1nYKAtb0wRrpTT1qdzM70o3s6LIXHXH+5f1ExRbvjfAinzUEkx
 kbhns9jHwybUEZRUspYTyiryHkptdrHl+Nlz89MnNZSbiox4U2mLd4kHr2sd++nDmykrCyDXB
 e5R55gNdTK75M3JwzK7o/c3eGA1xVQblX34YxRcbNLSLw1Al+FSTJdfQLyaTs1z2HZhSdHl5p
 TJBnnXswQmadhS7ABycOLvrk0MVqS8DyAULAY3HRmK0TTQLCjlDRhCVp8HdqMFr0uGHBiruYG
 ciHCvNBiQuzHa3bOEiEScN6VL+Z3k8C6+5rRjfvP1StK/N9rR4P3zMy5P5XeQhjomefNmF/ti
 ejSUaqZce4sUBkYo/0dq4Pgz8jRg1fdB+M2N54BhacA2vcDz256aEj3bl0h773EW7PJJd5dy8
 GnPN51YgUQ/ZMXgTqH9Ncc/poHCAAetSSWfA4LWT+2H9QFPtwTzA1w/h/Rn99yf4i8JPLe+Gk
 SIuVUbUbIAcDb7ywm
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
 drivers/firmware/efi/libstub/mem.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index c25fd9174b74..be24c062115f 100644
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
@@ -187,6 +208,12 @@ efi_status_t efi_low_alloc_above(unsigned long size, =
unsigned long align,
 	return status;
 }

+/**
+ * efi_free() - free memory pages
+ * @size	size of the memory area to free in bytes
+ * @addr	start of the memory area to free (must be EFI_PAGE_SIZE
+ *		aligned)
+ */
 void efi_free(unsigned long size, unsigned long addr)
 {
 	unsigned long nr_pages;
=2D-
2.25.0

