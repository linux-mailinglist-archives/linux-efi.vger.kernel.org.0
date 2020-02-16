Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD57616058D
	for <lists+linux-efi@lfdr.de>; Sun, 16 Feb 2020 19:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgBPSlB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 13:41:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:42341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPSlA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 16 Feb 2020 13:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581878456;
        bh=SSRIb3UcFG0HZ62FbpRPA/jmVRv2yFX2P1dmBznrzqU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Rvieat/sFHpWwVWeo+6Ftmysg0EaumkTD0Kyp6tH9yYE7uFyCoqjRDzskefXN6d7d
         72tPIw5Dc279GSJDE9Mr6zWc4h2GEZrRaPLMlU1Lxw0f6Sbr0NBZA5nlzd7LXjcl8i
         zdZhyGBtpOaThjpg5IkGAHFG3aeCp6NB2h0RbCac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKZ3-1il2Fb0Vmp-00Llnz; Sun, 16
 Feb 2020 19:40:56 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: simplify efi_get_memory_map()
Date:   Sun, 16 Feb 2020 19:40:50 +0100
Message-Id: <20200216184050.3100-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37shUavVqDQ2Y2UAkT4uB5vcCOlKfitq+crqcrDJ4vjvDZIygNB
 zXCKiKZ6PahDQU5lVJHhpFUQGWlwPgwDGnUerMDeRznzOuMLdgLf7ks7LxthsVEqztEk4rU
 PuRSkXiIk8eieMyr7zOmPeMtnXShbPTs0FC5UjeAGlH7HhLofkZCSVfntkVPWTKyOKn1+dT
 K/DZ9HBTuDhpl1UPohD/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vq4cYGzA9Rk=:HQJszciVRNpAP34/LDpikL
 XoLk+v4gDVrDS6h0nbdJx3oFvn9NfTKSwzLxRzxryHTKXJeKdQDDYOotpX2NC4S+2xIKiXeSe
 Kb81W+kgOj/+kanxBhDNBBeZV2Gm7aZrolAmUlhydFsNemi0pq7h59Q9t/NPlMNbZ+rT3TaPb
 cmUMqsCzc4Ro1B/CqHsObgNLPo1it3aJnqxoT1suvJwjDKr3VBpZ7g3Zygd750A7jUvbjtju2
 TemwBfqiTyLDOA+tk01L2+eaPXPkzWQ7kQHtaNRzLaiKfzsJR597kfduPpvsBmbHoahT3uTTb
 u0b6Mk/c+gPZLndM1+Ax9byiPeSBuhrpg691m9MyOyQdk5DEkQLMSeJb1hSH8C1MW3oCsfGDG
 QOqvfsP/NJfjM7WCI3uzg5tuWx09TvqzlyCq6n8ZvngBGH3MJM2KXi5xUOg2R3LLb4rvSVnci
 wYZv6TXGldHVRoA7FkP0IB+ABNJEKvvtlrEEvOLUn3cgQ9hFVNkPbsy7xefgF8Q1P1SDHLRmD
 RToh3J9vCpy9wFCxTL+2+Kkkqv0fdvT8bfMmG6xZ6/Zc42YuSLJOvdooGgQszKX1ClYjYF/bE
 PzDux8p1EhdGSImP5RJL6HGMh3HQSLPnStEDyq1Zty87l87p47fxQktKdQEsgurzp/NSfw6IH
 gUBJM3U9MuyF8SL+9tlQtEu78oV8qKGk19EkEyQrLcFVR78hPc8llxszE+lq/34xi2qPtVSPV
 5RcAPRgGhlrgJ4igUnBs7zDoZRx3ghOBrw2J5GF6aunqbQ25qiFiakLmxwCAYaXDs2USGyH7M
 ow7oJy726nn15AxGL0Rrqj2E/+LrOzBKCdCbt964wpNYdf2dOuf5k0UZVV9esKGYe9fiQPT2d
 k9c+vxwqeKZmn4sP+SdkxizXonhpmuTPHvuEnvYF65JKGAd/qonJRM7pcI1HEaQPgx9SrKrPr
 ZtNJcK45mbwuSAV6Byt5YcSvHwgt1y8mj1Sw7pa9Dj7WL8+TKsQJdDhr2VJakCaXdEgvFoyrf
 hgCht55oep3lxz9CTdyE/PfGj1UZ4egaF7mrnkw9qqezm2cLDhFsPFBooEhsnV70duP/16tZz
 GLTENyRvNAvc+GLZ6HoJQlqN/Nnh+/r1DITVXRcP0Fxnmrwp9Df4cxmDJmzz0XpHSrVQgm3aJ
 iuiIfvu8kGRECr1/Li2qFmN6A7RMbKNeSXKAtgwA6MZkpbIr9es96pU0+iwS9WM3QEFFOG5TE
 OGL5VbYh1usPzYjR7
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Do not check the value of status twice.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/mem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/lib=
stub/mem.c
index c6a784ed640f..c25fd9174b74 100644
=2D-- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -52,13 +52,14 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap=
 *map)
 		goto again;
 	}

-	if (status !=3D EFI_SUCCESS)
+	if (status =3D=3D EFI_SUCCESS) {
+		if (map->key_ptr)
+			*map->key_ptr =3D key;
+		if (map->desc_ver)
+			*map->desc_ver =3D desc_version;
+	} else {
 		efi_bs_call(free_pool, m);
-
-	if (map->key_ptr && status =3D=3D EFI_SUCCESS)
-		*map->key_ptr =3D key;
-	if (map->desc_ver && status =3D=3D EFI_SUCCESS)
-		*map->desc_ver =3D desc_version;
+	}

 fail:
 	*map->map =3D m;
=2D-
2.25.0

