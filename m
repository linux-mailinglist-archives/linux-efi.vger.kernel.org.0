Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9EA3B735D
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jun 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhF2NnL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 09:43:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:60227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233957AbhF2NnL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Jun 2021 09:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624974026;
        bh=p5AhWvJObj5E48c5fHGcL6jXDuBVZdpgQb8yMlXS5lQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kbNAu9qrfhjH8KLiI0jIC/qkXlvAf5WyXLSyNdHAHYUDGWZB2UDKqDUZHp4kCXDwE
         7GreXgsYkwrIovrYN8d6/PUWSVJ3HlwnQOZhRTtrP07B//BdrpL6FPD5hKZknLbSeh
         KdKcMrGbq5DZrA7ghlvFfDFahf0FTEtGdOlIXPhY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([88.152.144.157]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1m3iAQ26PU-00EOFS; Tue, 29
 Jun 2021 15:40:26 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
Date:   Tue, 29 Jun 2021 15:40:18 +0200
Message-Id: <20210629134018.62859-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgBc8Ey65V6us9wivMljuEpQjELTw45ZYekN3WeWP7EoTZQqdi9
 lSTJfNjLwwn39LG5t+wlOV95sd/H5CVCUd2fcTQeINYy7VKpqnR5PvKUBw3tFj8vXTlLIRA
 xdg/VFCpoGQmlBASv2EnqDMC7oyUTAD6jzc3KfeuAsAwck59dBCiQSEcBkvVgxPraBjZQWy
 QzaGFch8Z/36PVcA2KcMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4vb5uaMYpIE=:5sDfrtR1QE2vNvA9ao0JqE
 QCuwt/pPqkBuNXZG6n+V0YepLxjcDmHWEkz0B/7tbDMrZGb/RnsgaYGZzPLYOEl7j+euc12aY
 XhImlGTnVQKvO0n0d/aR83TCkr5ie+etSl2BFe1F+ten38vMmkK6dH3m2/jyZCGLM1GaGHxhG
 /NrnWeNUlldqlRm1CjK8bTxj2fgFd2qf9zo2PXx9Ha41vtJGyMGa8KapunitBeV1AmA1QcVSU
 XmM+G3zQLGAOYSoOynunILlEH3yhiJ8LWGjSqk7hevu+vMd+z9XZKNnCD0iNhA2ku0L1frBdG
 RSGLwQXnMzokwwZW8PMySbic0VYy5yqGo7Fk901OokEfTHoz2GkqbSDnHid9VABbWDXBRV65+
 aT+PUuAP/iD0QHGflYWOokZXuzh3+twCKwHMMdU5GcKw1JyEv3/7zsg2WnLUSDM2xgiGwMscW
 Hg41CcaZbAIQMbjHQ7Tecy3Ko28hQKQ3rjid0kMd3mzIh97wARBfXgm8PJukYxEPbbe4CbSGA
 Y/2ecd0XEp2pUcsgDuaMut2NGQYgJGkddbyucAuEKt7c0n+ekRyio0GVwoQuTJwAqRoLJUZRD
 EeH8s20BCAd56PLxDnGjaItR8G+qr72D/GxG6h3Ga4G9ZP4cYuQpEpzz4zbD9aDOc+pHJheAT
 uFjQGNOnG4ipeXTV0ObUibh+cGmUlVZeOnqey1oaeIcvi18+a0aziBynTRKemC1rbt7pQgxeE
 CMTHgTVfIQIzSm0zff2ftyvvj68P73k3HiRUF7yMbrUwmOsfLjEd5nTdGLV+h3nOS3SSO1Zxj
 hHu9PBop3QFRgmjYDwwoteERFqYfTHT619wxtfXK07JYySnYm/xcneyAcuNj8XFsKXJ94+elh
 +/jbr4Y73K+6iBruxN4XKYdmXthtKJKdKp/wwNAppODlqcCwQsAq1vvAVJnZCT75XYdvuC5AZ
 CUIzh8gPAHE3PyQskMkvh1Wk73ICGpPKbQ0DXKUb16f1js3XVvkTpD3LGfp8uiNcYAKk8LVT/
 YllnIUhcVaO8EqtkpePpN58I/qAaX4j2Z4Cz/h1cz786BolNO+kNT86hIDjiIm9tH69AOOEBw
 t4xkpPWoQ4ZF1DyrfS2jXuD5ZZu3aA08NeJ
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Requiring that initrd is loaded below RAM start + 256 MiB led to failure
to boot SUSE Linux with GRUB on QEMU, cf.
https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html

Remove the constraint.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/riscv/include/asm/efi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
index 7542282f1141..649ab513dc99 100644
=2D-- a/arch/riscv/include/asm/efi.h
+++ b/arch/riscv/include/asm/efi.h
@@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsig=
ned long image_addr)

 #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)

-/* Load initrd at enough distance from DRAM start */
+/* Load initrd anywhere in system RAM */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_a=
ddr)
 {
-	return image_addr + SZ_256M;
+	return ULONG_MAX;
 }

 #define alloc_screen_info(x...)		(&screen_info)
=2D-
2.30.2

