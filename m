Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D11699FE
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 21:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWUqH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 15:46:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:41821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWUqH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 15:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582490762;
        bh=qZfvYCLOSrTYaWWsIfw80OJFIKAonSXgx7/lAZyVBkU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ijsR8YKoBO62QCVTY06/A3BiWJM3wBjwZ+a1C6GUTKHyuumVewbHX906j3MlLikKH
         dTjC2JXns5pTz2gc0B64yYJ/UxAL/REMqLvwxWvd9mPVAtzw2esCTDr91004aAMPSK
         rJN2VDFia784afw+DLPs7FBrDNEI6yLAAK3gAN7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1jW7uE20zg-00zjY6; Sun, 23
 Feb 2020 21:46:02 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/esrt: unused variable in __init efi_esrt_init
Date:   Sun, 23 Feb 2020 21:45:57 +0100
Message-Id: <20200223204557.114634-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgqCYKkQTKbRoU/yupnI6uC3jb44FCQ4Nu5SZfjmYi48GCYUaF3
 LcQqpdRjzjFMihjuVPeVeGtgnczUfIuPrNN12Ea6SpCIINCIkyWCfNr7IsDSPoBhBOvEoV2
 cacth49QHwyCf+wETJjAJzuXwqFEIKWDHkMdJWofLQxtB8CmxQdHavJyUnOvzsxSoRpewdf
 /TW6ufF5aSeBWXHDf/oeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l+ZkU9xBG24=:NmPPnFNG44eSRXj0nkemg9
 m0NhSvL4npoC0y/GlDTqfR8i5j4Ia0ZVbefZNpH8pgU51sgToGPGlmdmZrhiFxisEikHxbikC
 V8GtDPNEZlB2u6Z82PQcM4GBMZoevjHiysXFZG3NX5RgcsaNgcG021jMvoJvK4IeSvEQ+Fwf5
 BeWVkZh7vjBJRniePcr94zrBfKIwN2u/hK64vIJl8jg8T+5cw6IgSWm62ryIl6+BlIDiaUvHT
 7qR8CRewv+qKmbLqlLRGhepm6bncNYUP3V3odzkM7pfPODv8MwRT9MXmrWi+lDT6H422yTLY1
 qv5H2zZ9+erqDmqF55xefS4NMXGtAlGg2TvgkInV4qAY06UWcRElpYPGY5Dt9pOWnSpS0mSyR
 tvX3tE4sLZ1OpKzrlDaFKHDllYKinjdvmpqsfvOvNVqGS0abkZ97Qrs2EU1XOQsw2h8JRzg0n
 cF5BafV7C6F/8IL8HPM5Ime4LA3aG8BIV0+o4Vj3DtBqvwbec5n9F/mvTOYBCeqvlAlZGdr39
 Wn4nNIlWxNyIeM3ve6SXqCjSS2Zkcxw7GuALgKu3drj1wcTynGyul53/p7t/TssbbgEhZZiuD
 srG5cyXRA1ghzDalsGKLV9GQn7qNo0cPC109M1e8vq0e8v1gwXaaum38enmlNs7M0e0x9Mrvs
 QVSdHOOdZOxcApIPtzVYaAXBbiEU519t1wOiY23NkqLRwBFHFbhf09aF54sH2r/6WN85+yZjp
 H5L0pGn1pdDiKqWrkK/2xjsJDbaLfyMtkXt2VdV/rOgA2h7nVNfXbchQHd5upc/efgv3L7rqm
 UjmUTu2M2fVZYHQ2I12C54rCgj3iTyK/wW4r241Q9vbNJyOpoD6Z3AuVFyKUw+lyml3GF4SX/
 I28Ygrg3HHF5KTPacw8MgmkYyYdMyivpOrJVfsNvfi+eLSvwwY37xhwkYLlYVWcFss6uJZjMp
 WSBmulwv/NNr8splMGb8Y6BI2L95Z3JNNueV2+L5zNQr0zW3HdnnTHjXH0+qR/h9BKnQO8S56
 aQdMnkrUQWAGpojQxL3GKZZCre3PK4fygWLE9/DrvBIqbjg6Zijp6YdrbLaavuOzsEFNvreFe
 YqS3ys4JS+eogbSkrV4ByIhcTzztRKylti8MO9iyrmrJ5MVK96RpSokklEV2dpvd28DeO6FPX
 lwvah8TSPjydtzeheeqJ3JEPLGS0+gQE0+ZqOWmY/wqxBoDWsO4U5BGcz6PmWfSrviBu+ZkMI
 sIbiFuddlZJm48ukl
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove an unused variable in __init efi_esrt_init().
Simplify a logical constraint.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/esrt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 2762e0662bf4..e3d692696583 100644
=2D-- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -240,7 +240,6 @@ void __init efi_esrt_init(void)
 {
 	void *va;
 	struct efi_system_resource_table tmpesrt;
-	struct efi_system_resource_entry_v1 *v1_entries;
 	size_t size, max, entry_size, entries_size;
 	efi_memory_desc_t md;
 	int rc;
@@ -288,14 +287,13 @@ void __init efi_esrt_init(void)
 	memcpy(&tmpesrt, va, sizeof(tmpesrt));
 	early_memunmap(va, size);

-	if (tmpesrt.fw_resource_version =3D=3D 1) {
-		entry_size =3D sizeof (*v1_entries);
-	} else {
+	if (tmpesrt.fw_resource_version !=3D 1) {
 		pr_err("Unsupported ESRT version %lld.\n",
 		       tmpesrt.fw_resource_version);
 		return;
 	}

+	entry_size =3D sizeof(struct efi_system_resource_entry_v1);
 	if (tmpesrt.fw_resource_count > 0 && max - size < entry_size) {
 		pr_err("ESRT memory map entry can only hold the header. (max: %zu size:=
 %zu)\n",
 		       max - size, entry_size);
=2D-
2.25.0

