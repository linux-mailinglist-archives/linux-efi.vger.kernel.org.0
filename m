Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B1169A75
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBWWZr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 17:25:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:56979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWWZq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 17:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582496742;
        bh=2i5YMl/hfe+PmpPCLdddML5DVgrpCwKNSzzG2FlJGVI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JF9Z1zTbOVc08jB8r1fcLoVfC/IXWI7sFqyw5TvQk4/PznV+stiHKpjc4mv77zV1m
         MUNzhZ5VkWH6sKm+q5Z58ZQ8klZOAYSuMdWsvqvrB1RLL6jWHioWuCTVeUyHb5c2oE
         Qu+B9kRnt1P8ABsPyY3N3TvHZkJLbzV5CjZjprrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1jJWNB1n4Y-00x2fz; Sun, 23
 Feb 2020 23:25:42 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi: superfluous assignment in setup_fake_mem()
Date:   Sun, 23 Feb 2020 23:25:35 +0100
Message-Id: <20200223222535.156348-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LK6sG8SfIIYx1YnO8w4Z4NnmNAmf4socAqMd1voV54UvOjur99a
 kMkxwqo9TixuLqF5fYZ5zhdENmElOccRM18UokExDcbQlScjL4JyeROW4FtbquugQMfKGpU
 sO8nUSGjCrmkD3GgfffmTg6utY5orpbevCWN4Bc+QmrBANnf6UGBl4WffMVsjFo5umoSMjb
 HMnDjSLRQon2Z+ZP4qPlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NOQSK9gUsYA=:AADbh22rGB0+Y/DtNtpxVi
 XsGJCXDgmZA0mTSTkXrKZ2kH3kB1eGtXTq0DkZ053Eve7GnuUfAoac6GvI7bYwSDsM4+zO29z
 jdbo4hN1vKGvthJT0NIW6PEkq9sxBWdSL6MPy5CPmOpJ+nSDBd0kwCBH3mdARNslbbPbTdSzl
 CLp4KqNz+feXnkISni6jKjtGOfYLMOwOyAwtxMagbyni6gcIn7V1Zha/Oj5HMTuVYkfHVUCpD
 6O9fG4haMoAztBWiEu/K5EQ9vUN0BImhRtRzzQnBAwpdinybVu+DEspXCp3ZvhlLR9p1SVfHm
 wG7csxmNPs0JqN/96grU7a/MA9v2F67ZptrPyxbMYevofUf0JHxguZuNiPVIuJgT9aaeYd36L
 BlUh/qBH1a2eZrZv9zvDIannzlbf/H+hcZXUeQrNgtFefKTjc6cu3AHhS3nVs3eJYEVbntkJp
 ET2TU9UmuuTys+4eBQczQuWDCI+MABQiNfni3vm++yj5KdFQVbxfS9ySQJIPZeu1xSfc7yZ1E
 VEGr8cHzRDeSsz4YHX5cMHxNf+8/6nwgAtD1V1v4GXHN75SL7WMeJ+EgvyCalkhtz12AlET35
 LMc3rLRQW2Ens5pkQsAR3aDfV7NYHvrCA5IpgOcVAc0Uglw8X+Jms1cexwEPA/NxpPQyjtYm9
 vO2qbCvPmf2IOHrFxEke3FYd1yMW+KXKQKZ/+Bxnepr0Zb+c/AKzoJg4/qbMv0dCyiVYOCyu+
 9lBt3/9JCjg499WE67auAlJnlXI9yteEx/5SZDSWUSYWUGf3/CfhjcwlAzEAJRw0euPUZBgGI
 Amoecp1RtnU1pN5HKVNTW0ORR0BDE4qqQkMSnjbVl6ZhHIKd7MNpYvFvz7o3lsCsy90efK1id
 si7DnqOdb8vbmcHS0NHUK7URKFrZIyxpgf/ugDFZZM52QLWNtYBVT+j5s3bfgYk6MgxiWm3d9
 fGoPJYZNcOECTd30/E11qDox7+k1svpoqo6lsWWqy7ByibAl9iExgBtUxrBmKqSFy3ra7UuPY
 HsppytmxKFDbDE9uJRQ9C+fEgL9lIFi5rU9UgSQhhuTWMmWhtl2LQSqlyTdj/D3S99rFUG8FA
 QhEBWfl2I4FUy+l12yT1i6zbbwprNEuPHKAvd5SOQuezKEAVUu4Ly1lJHr/j63TivX588CXeW
 Kikml2RmmD1Kuaiee5OGKAXrpvm2LzQhpyVFkMPTBF7XTSrB6DNHsk+YiwY0WLFgf7oXgEu1q
 D9CNS0nWUwi7fiTci
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The value 0 assigned to mem_size is never used. So let's remove the
assignment.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/fake_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_m=
em.c
index 6e0f34a38171..2e314306ce3c 100644
=2D-- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -80,7 +80,7 @@ void __init efi_fake_memmap(void)

 static int __init setup_fake_mem(char *p)
 {
-	u64 start =3D 0, mem_size =3D 0, attribute =3D 0;
+	u64 start =3D 0, mem_size, attribute =3D 0;
 	int i;

 	if (!p)
=2D-
2.25.0

