Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747441B93C0
	for <lists+linux-efi@lfdr.de>; Sun, 26 Apr 2020 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDZTt5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 26 Apr 2020 15:49:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:46519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgDZTt5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 26 Apr 2020 15:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587930592;
        bh=f8Rl3upU2cRQsGsRVWr741bAGe6+dxkQS+/WJM7bXJU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QGQ8lVY0i5tohLKOoVD3RJ0dSObw6G0GpmvsxCGFaTfXCevQHMgz5Oa9NC5rDQx6b
         0cqpCbY6m/ebxrRDFo5t4HEdZ/9VyWMB6crL9TOGaM0OcfIxTY43Gq1i+o+CsR0UKW
         Nc/LyBIKoZ9k+OaE6IVIUYWA90OGiPFLebm8hjfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.226]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bfq-1j8EAA1Zd8-0185iK; Sun, 26
 Apr 2020 21:49:52 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: setup_graphics() do not return random data
Date:   Sun, 26 Apr 2020 21:49:46 +0200
Message-Id: <20200426194946.112768-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KBERLvPF/oK8jHQChRbe2qHTupabdkJ/eSIrpQk9wQfiJYoEQPT
 /ypp3Bk3MHszy/3Icl6IHppfMWcRomEnXCjpb5oG1MceoqmaOdTGO0gRdp2lLEaPfQyTGbY
 AQPZgDOvNQ1Cpf3HYeVg8kdbtxsjQ75EmmmK+SumJTPlGFfCIWPiLed1l7cz1vytklOotK8
 1urWoVx/SwKqV+17xbzMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JXg6lru20U=:f67Vjgkza4wfqij7pu58ky
 Y0LxYPJNuZPS7LxoPL2NzLSxKGAoYJs689zXD/wlp5iX8q2ArpYLcJn5cqfQbVRnM6778QR7j
 0stcc79LXLamcJ+gmgIL7gTNXtCO8QkcUgXdvE9cCBtsv+L31gatSHaxHyltCftY2hAHepZpQ
 0T40A167fUMeIyUxEW0TlVAWhABkkHdoDo+eYYcqbCvIN99QGQE2T140tE907U/RzzMnzrSSc
 /Ya/LFxY+VCqIrCqoiwr+Tu5nQekZvlPeeqMC5caLIhHuBGoOZtVnl4lQFO/sj7VI2OuEErdz
 Lh8MXMW2NY+WdTy2t/WcHxSfVF5EqUGw4L8ffe3IPxGRB4V7JTSbLph9jT+LUr7oLzC6onNx2
 KW4dKVlzU1i924uM368z8umkxj2ENudJnVm47PwtJQwqcfxh9Qnk9Nuy0Beupxp+hpDnd17qT
 2/+k9Hh+ZsjAqrzRNfS1G2j9ai+k3oSDhueNfM800bTYyZkIC1xJjEbgaNFqtcu/QyTizLgbh
 C/OSpyL5FYj5tQtF5yhLB+jnlAVNMjBTY1i9muMqeS8c7EvdtwOtmfoIU+7nQIu0jWUFzSI2I
 zQnJPOUUiVhmbOA4y9PVaOW6n7nwxaxrYcaE6d/VFSvE8+2JkSDwzshk1od4IX8sfgQiD2SCr
 r5ZlcqpK1b9kd12bqLijE7gGNHlrQ9lL524W0d8VJPMq5sbOosOIzLheOFL++mrUSDsYNiz0s
 M8aWY0VbACltKV8RSEOrTNvGlBp8IOynqk+ans54G/d86ODbQr+vOagVeB0TDzvq+j+XZeqKc
 +nRx5/NJT3DdbMGCbbGQaxdqjmv8FFyN6gi9IOHLU0WcYJIQce6ioT6gUi9o/ycLFaQ6KtLDS
 dKA7uzw968VcDywTbl+fHM1h2CZ7hCyQir0TymYlmzyK6TFv3bGGyGLEvzAaVBQgzoZLHGqqm
 JtYLX4Nn66V7C6iBdsH4mjtQ9uWnnQRuAaSkXL8clRJ6ZCnlgRpQY5PESYZKI9QA4Coz7q0KT
 Eh0DNP1W/Ykk/Z9G9nID3/RLjlsyPfkZQM1LLrKrgqn0D0Fy22HOar9dKZ7DZ5lvnm3aFSj3b
 3CQEO7mEOvls+swDDkqf6p1/YPREur4pK5Rg78o1Yx8Ry0poH9QoDI6atHQCluPffuGlf+2O7
 mru8fRx/yZIwyR0jnj6u5sFePj/2Qk/u3GI8nYPZ4pBeUxe5A1TBtKDoBEc3GQZJm0irtdk2E
 +fFLcuRhiOOVds5SW
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently setup_graphics() ignores the return value of efi_setup_gop(). As
AllocatePool() does not zero out memory the screen information table will
contain random data in this case.

We should free the screen information table if efi_setup_gop() returns an
error code.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/efi-stub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/ef=
i/libstub/efi-stub.c
index ee225b323687..60377e5ceab3 100644
=2D-- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -55,7 +55,11 @@ static struct screen_info *setup_graphics(void)
 		si =3D alloc_screen_info();
 		if (!si)
 			return NULL;
-		efi_setup_gop(si, &gop_proto, size);
+		status =3D efi_setup_gop(si, &gop_proto, size);
+		if (status !=3D EFI_SUCCESS) {
+			free_screen_info(si);
+			return NULL;
+		}
 	}
 	return si;
 }
=2D-
2.26.2

