Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484B01604EF
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 18:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBPRNu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 12:13:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:60355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgBPRNu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 12:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581873225;
        bh=eh78Xacl3/Rct4ovfBjtDAjQYNUH2DdDabj1l78Ud2E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FUePMweafQ1HybDIiHUSBXg1p3x2XqT3yJRRV7Y9dQnE/fHJCqhU9cuOhGnv+u6wP
         a0u5p5+F4vi63Zfa035HqKRNC1u2mL6UP7IKiy3JTC6pKtKXCYElAmcuiEPDLGRn4T
         jg1IoT4DJDtt2q6NR7CO18OXNTDqdfHgDw5WqB9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjjCL-1jjY4Q0ze7-00lFCc; Sun, 16
 Feb 2020 18:13:45 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: function description efi_allocate_pages()
Date:   Sun, 16 Feb 2020 18:13:40 +0100
Message-Id: <20200216171340.6070-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szui1R6XNTVN5ouJvt02v4IxyTNVgJsAcjjZDwLpipqFN0BnMP5
 SKcz1tFg5MQHlg/3I0iaSGoTQrhMmmM3TOe2ZrETEQ9MUGUu0K7Py/hMHBsETJFMvzUP8HU
 0aOeq52LdctXzTjCy2tIe4MGQqY7D2qu0JdovUvnBjyNDMAjNYrdL1YNC3Mjnr2oo8bWz8j
 0CWgA3nopl8t27iWORx/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LK1FmsZ+IfM=:RGYLg41Z4fp76SpfhfHVxp
 8ZXUBEIjpHZ/RzzCELnNaOCE4NjC/+Nqv7/RFYt+iYryDuwF0ww38l+TbafEv34KG2YD6LFJ+
 J9KeRkTZjUWyFbmtS0zm86Fpu1zOFCe+ijCmKYxhTbEdwAs2yAPsXoqYnKcbbrqW9ms86XL6M
 y/KMPhNCCqQJ5dMHby7FVce4+MmlvPzQ0Tns1fKTEI//n+ZVZY9o76wSUuLXtMBR4GVs6S9k6
 MKrPsVayLmX/YCyyGiK436n3ScRs2gvgLijuQAfXSlDUj9oxD0Jp/6p7SUXbDyOz1gC15YdZ9
 a7olfjVZf9JzkvdQ1J5kEJF1CvikIX42s2AMdBoT/SFWLubQw/ZaMBxwhwKgTLFYkFjtimKZ9
 4O8m4awv87V/IpI+DDfKwgtXbwVuRFvsleZcWQtkKX3VEymkuHA+vKoAW+A25wuzfAAEfTtAR
 +FpQcu7iUtY3gEOM+a2VfEL9NVHt1Uf+VKvvg256QXFKpBqy6zmp2UtcjBSwlZ6eNxIpKjoif
 1h8aF7B70+Tt25njSvH/rLgQiJdZPVHOidIIAMOdf9EgWyd8Jf8hYtbkZee2yug9chpt6jUif
 8HxGnaFcw2dC/D4TQz2GMn7s0Qx3ifWALsXV9dauh3VXBLprBq6k01ZJgXaCxz3zk2YraELU/
 jP0HKcnLLDbozNYExHlK++R94UCbuHPQhtR0cmCU3ykEWMjT32FhwrfmTKC/YTPlcPWHdEqbh
 s/CWYlVQ8JDjydpXGC7T1+Obk9M9xxLS29sVVdrVfzEtYezEvR8FqfwkarvKSTkEmiuzzQFWw
 WDcI/P9R/8vLVdGGPzJRil2af0Hs8yQNKx9/x6RNeoOmmlavJ1DK2SplTABj9hh9HC2JsVSzB
 UjJQYHdwoHUKj/Tbhtf14I0G/OXcmyjg7U5qEJaxSyENdrFEvsbaQejfo5YdNOi6dX0mJcp+6
 lRphOolyYFNYVnXyZsKyoj1Ztstcn2JhVwJLtPsDmXDgc+YGxMw47UpaC5SuaMfv2KLwerqF2
 nSPoigjw2Un1BNSFax1rgiVCxIKDkbwhEsiqbrpdOtWOcTMZmJ5zsGXKuZj+ZgtReA/ag5xZe
 M9WcjoCiCL8g1SHPI57arWVBmbP1rRqnUv+RaJ3ZC6vqCTm2DoOdvUeOa3PWMYLP/NHTHKYc+
 pj6fklXOnKUSjl5I1tSNMx61JuQ9X+M1FCabFwpRsU7qVPAAblJAZulVzvKIXPu1eDWII0mc9
 26pXWJfxamIli4i3R
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide a Sphinx style function description for efi_allocate_pages().

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/mem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index 5808c8764e64..c6a784ed640f 100644
=2D-- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -65,8 +65,20 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap =
*map)
 	return status;
 }

-/*
- * Allocate at the highest possible address that is not above 'max'.
+/**
+ * efi_allocate_pages() - Allocate memory pages
+ * @size:	minimum number of bytes to allocate
+ * @addr:	On return the address of the first allocated page. The first
+ *		allocated page has alignment EFI_ALLOC_ALIGN which is an
+ *		architecture dependent multiple of the page size.
+ * @max:	the address that the last allocated memory page shall not
+ *		exceed
+ *
+ * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned acc=
ording
+ * to EFI_ALLOC_ALIGN. The last allocated page will not exceed the addres=
s
+ * given by 'max'.
+ *
+ * Return:	status code
  */
 efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max)
=2D-
2.25.0

