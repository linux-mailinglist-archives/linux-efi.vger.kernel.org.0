Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F949169A1A
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 21:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWUyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 15:54:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:38039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWUyo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 15:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582491279;
        bh=xhGJX0qnxNbLAdYKh5tuBMoPDo2UrVNPqy5GvsRtThg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=T92t4YForW/qyb2UglHKJm/uVQK/iL01nSdxPT70sN3W6Y+YCv1kqApyqwxxm6W87
         h4wzz74KFZE9avw9D/4I91CVKhhoZ9p+slBCRn12UR//ITjSYsoxshaEmnstRsbBwF
         GAmV3M9q/J2+m3GyEz9hGcCn1TNlAr5jDlkpXyR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MysRu-1jIQeb2Ul8-00vuEl; Sun, 23
 Feb 2020 21:54:39 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/capsule-loader: superfluous assignment
Date:   Sun, 23 Feb 2020 21:54:35 +0100
Message-Id: <20200223205435.114915-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2i2sX+DwJIM1Yru+6zIsxk2nK/5QIlfpJppjkfS5ofb5Idns9vt
 J1Y/En5gkTZBaj0HZ/iY0hjqcfet1vjP/sqXGEBwTT3ifYBAl5L9TYeJOdy7dfwJ3tjO2oB
 uoqIGpoPS1svZNc/KawYM2l7K1cc8ESdotXMHyaf/fHqG2TW3eOgZhUaVJbWmmuwdKK8WDX
 K+/SkqkVgxIJW9cZEUZ/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WiOe8O9ghds=:cfA4mF5GTeGPTD5eemswQ0
 iKIqC7kJv8OHrG+5K7BPCYKu2oCGMGMZZa9k2x2TxnnlZDy0ao8JaIbQ1lq8GNs28tGQqLo7d
 M04TuK/4TFQcR/7pTlo1AuD5ZcVINyYfQzHKpLQd2GYjBAw83miGPXxwX2TzObYx3dAO1wqIb
 f2oiYEpRU+dN0iRjITHhUX2M1eoBlr3f1GYeVkwCHDMbVihyKBRSlCHhb03Z6ndqMAdWvXh+2
 0BVtw4CuQKY622Cxzwjjm0hXhavkZzJU7l9gs3es0+Asg+VZYtSslVj1UvpsYLXCsb7ujkI/l
 BObkdnUantDSW0FxXpNFWfHgKNP1wqmRg1j4M63pVDe5XVv1z25PIyEZyCZjB52tpqBzxZH1v
 /R2s7ZLwUMhJ0K+kcelCo/9XL0t+ozskAfFA2eyemAzgd8JHB10WSWYotvcppZB3lh6f0R2va
 Au5K0m1zHB7CjIXVnL2E+9HlzsHm3REcsFPwutG2yjqZPf+fNyULBv/oJ6Ia/ks+hDmGekq/Z
 qtZUB2fZqvHivtSmGQUP9nWutUwWc1ZSctunR4sV5MDkdezCfmgBnpDgtmwnyTQJhDfORESRl
 b/6riolu/BjaLDqijvjgrTC/2qp2cNXiNEf/akcW/YYB66RSZdFVe9wZVBpoen69QgXF3WfIz
 Ef9wcRwpvL8uF7P8cbarMG11S9P84AiM+RJ2OcgqLLVNI1dnrm6t+rtmyyDioaNWyUPNMYJ+T
 HFkIpSluyq4ZmZUKxJXG5mt4SSa+RiFVMB2z0mnhplBVEflf4ziOB1O86Wn6YYIbT5itQo2L/
 574lFuYl24ZCvG3VzSsLkQYI1ttxkyZbSNZUb8N3OskjUlwbd7dphJoh62ujHP74v4ypb3GgW
 C1qsQ5hVGeKAUhnrThkzG1v0IvevJ0/PaMyHR/aaYtBTJSlwwGAG7OgNxbyugX2ox0t/qwN5r
 x8zuI6+zIaY6b4181RKGKyO7mRvm+ylxO8d1TeN3ZMX0OTZ6OEKvfE2129uCHdmIB4RPYEiOe
 L/Y55PWBw0zGELwY016Z6dD2n82uIazOuHqtzwkpt9Jd35TzWGbNf/GywBk2cbaZuHV0R5vgK
 N0hkNLe69lJKNlVw6Ef3gJ1tse40+MGSmRuyUwvefxwaFfI8i9qYe0PyBX9AN2DqYb2xJxYPC
 yKDjxcjWQhGNbF+hhSmDTfRtqJRvLGTQEhJ72PhP9bUwuA+SFK1T5v3+JpQ7D/idbXJVI2MkM
 ub+rlXUL/tvcFrUxV
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In efi_capsule_write() the value 0 assigned to ret is never used.

Identified with cppcheck.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/capsule-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/=
capsule-loader.c
index d3067cbd5114..4dde8edd53b6 100644
=2D-- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -168,7 +168,7 @@ static ssize_t efi_capsule_submit_update(struct capsul=
e_info *cap_info)
 static ssize_t efi_capsule_write(struct file *file, const char __user *bu=
ff,
 				 size_t count, loff_t *offp)
 {
-	int ret =3D 0;
+	int ret;
 	struct capsule_info *cap_info =3D file->private_data;
 	struct page *page;
 	void *kbuff =3D NULL;
=2D-
2.25.0

