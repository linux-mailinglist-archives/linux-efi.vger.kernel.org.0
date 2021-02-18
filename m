Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE8231F0E5
	for <lists+linux-efi@lfdr.de>; Thu, 18 Feb 2021 21:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhBRUUo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 15:20:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:45683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhBRUUl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 15:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613679534;
        bh=v7T8wWtgo+xLwSXbQ882IbQmUkj3BIYNUxFQsrhglCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UbXiC4aCoRZZ0360SQ1/x4Y4uDm9GZ+bpA3fA1IdPb2wHjJHTER8Bj4W4Wm5gRDoJ
         of82DtZV8wcDJe6KYLAd3Fj5iYemqERJxa4iFIJkadHCdWjaKMw4YC23rPzWxOJYJ5
         UHrUjzrRU7EQLMnZz0tkPEipDaoxUeECkioTkQV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mcbin.fritz.box ([62.143.246.89]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1lgivT08lp-00nzm0; Thu, 18
 Feb 2021 21:18:54 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/efivars: ConInDev, ConOutDev, ConErrDev are volatile
Date:   Thu, 18 Feb 2021 21:18:49 +0100
Message-Id: <20210218201849.2805-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTr59JrbvIWwZeuuGu1CnEG/Edw4+MbE1e5p3fxo70KFdqrbq7q
 uXKaq2rRSlN5eVUXg47idQCP14mJUkrO/MoI5WbOEbzTilEjXl5tWBnssVpja8DSeRGWteo
 f8wqDfBUsqYMbwXyuI6m2EqlPyc0wsuSbjT90qsWgcaYSg2V7q9gOUU7qzIeWiZorXipDf7
 erGLkwqDmczG6bjzUNaGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:22JJ3K7ubG0=:52NEzhPr+n6w56Y8TEHK3j
 a/lFEIcTOydYR5yBl5V9vxPMEZs+xoS6S+WYup3uZGJ/1/95POS81dEbbXkA/EMor5Q9MNRej
 yFHwqUg5gjU8rFSbz0QFpLpJ3glYHJVBazL4Lh1pS7QMsBmXNE5qLAJwoSqR8KUByUyNZf4gx
 44cGjI2PhMlvsGcguWUR8FSvj4agYF1oBifHyObYs/MJt8WsWqYObsGruBE0gWrGrYkb908eh
 sqxJD/4n7Gjo9m1sftzR5X11sPD11gbsOJBFAAWe9gNUZYEyJRsXBxDUmnl3WCX9AhZVr2NYU
 LQ/MOYau1KIpKHePCnyJg7FWsXP46InhWk7RWWsIlwiMQDM4ED7Del4lFxggysd+4GwA/13L6
 QJAtOcS4M8fdXBIZ0SPiRIwX6RskPUS74sKWDs5VNudEMmNGh8MER1dsMUFOe4Y9dtMOt0N/J
 fDVlD+C1GEUoUl7eUKuUPpKYrghXwjO8VbBTUtuqI5iMeQTy1ZEeNLDSW54AH5SJtu1PDuxY0
 ngtBTFBjrCjdsOpi1HiF1vx9iXtnbrBik8AWtS/yIngj0flII7xkwj1jfCCvEPBaAtyf4ToFL
 cn5rNpx7AMI7IvSuCa1sPs5yvSXAV62OVObaZ4YFrBa2QLATJ6l1NJFfWXNQk8fZaT4NTQn1G
 UtFeeKIPMc0UAIFESkAVZbbv71CRzTjZx1VtgDc7IDBsKR+R1Bt0JUk2w2cpagpgnW4aBz1W0
 L/5PRZh7A7h6yYDKIPye8tMAs8pDcRYd+TEeiL/PBSvzghAMsEZMv8Uf73wbiDA8GAWQPJguE
 BjQNZIaX8k8AjicP+kQK917RvnCcWQm64Fr7ATDmJJS05s/r3rSWyGXxFPux5QAK8B3s3yYMj
 68sXjHtB5sU2YI4SaR8Q==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI variables ConInDev, ConOutDev, ConErrDev are volatile variables that
are set by the firmware on every reset. It does not make sense to set thes=
e
variables via the efivarfs filesystem.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/vars.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 41c1d00bf933..561e0a01093b 100644
=2D-- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -180,11 +180,8 @@ static const struct variable_validate variable_valida=
te[] =3D {
 	{ EFI_GLOBAL_VARIABLE_GUID, "DriverOrder", validate_boot_order },
 	{ EFI_GLOBAL_VARIABLE_GUID, "Driver*", validate_load_option },
 	{ EFI_GLOBAL_VARIABLE_GUID, "ConIn", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConInDev", validate_device_path },
 	{ EFI_GLOBAL_VARIABLE_GUID, "ConOut", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConOutDev", validate_device_path },
 	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOut", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOutDev", validate_device_path },
 	{ EFI_GLOBAL_VARIABLE_GUID, "Lang", validate_ascii_string },
 	{ EFI_GLOBAL_VARIABLE_GUID, "OsIndications", NULL },
 	{ EFI_GLOBAL_VARIABLE_GUID, "PlatformLang", validate_ascii_string },
=2D-
2.30.0

