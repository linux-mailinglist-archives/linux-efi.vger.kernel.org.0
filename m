Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7038F2821C8
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 08:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCGEc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 02:04:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:41255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCGEc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 3 Oct 2020 02:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601705044;
        bh=p1fszQHLO1oaX4N+JlH+fI7RR2cmom2OYUSkpziklSg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YFROAs4s4/wgnRNEystLtUHP+SQgYoPiD94StuDYpBOkJZDV+rBuEMm5pDRd+47+e
         nUrGhPASCxovjiLb7W2m+kVm0doE/81TtJ/25bRAD/HBK1aehG5qGUnD0Ma/Nt2k0T
         RQplGz0HEytrAgAPl7GxJ8nk+Biy9Mukl3GzSmjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5UN-1kDKeB1YFL-00FBAu; Sat, 03
 Oct 2020 08:04:04 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub/x86: simplify efi_is_native()
Date:   Sat,  3 Oct 2020 08:03:56 +0200
Message-Id: <20201003060356.4913-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q7J8S3RAbCTOaoUtZERmhE7IkCezyRFuH7MhqkXa0GzfVSAeTTM
 8LnLJzjkdv5n2tIsuB5FyncCPBjd/RLy0Pb5TrXjLOVJu2atIr479upkgU5UuTiJMhKy6iH
 xuQPoGH4ciWepDNL+3G/MWiM+OPRWM0YjCGNzxKm1j1CKgI67+kotrjE9M0fV4cnnFF+ge9
 MTPyH9brJi0f0Ce53Sprw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4aXaXjSWv1A=:4Z/dXvbxtQllnkTFCrHMxT
 JaULTKOLlsPf0tsAOiUUlOsyrqmPqfthfCCf+5X4eSmefDFudPZNtOIOVAWiTaJouim9HFrgx
 6vi6ZWLXkSr0BsGhEyshozWCF9DQs2zWHV5Nx8OaltYlnCwj5kSvQiu49Cqw95XEqsZe2QFgV
 ovDxJCvrFTU1aItRFChYrziu/QklnfPhgqQ7/Sq1jZObkFIcoArOW0mBO5QdAHImL6FZjHnzE
 E3q6zKgo7QVHqawfEfuH0WEOMGUCGoBSmdKAQAU0trC9BlAfynjLLnk5yoy6Bd5EwkowpFAAf
 LP4+rmjttcOLzDY0Mj++Dhm6+j0OH0AuZ381S6dYaVBqSRUr0/jH9eSYZHN0TGJs/Y7Ht8Lr3
 hj2I9wx4IWUlhZMMNhdy3JjNdv1D7iQJhNPiAosSKP8fGNiMIdKHGLW/FXwuPfAiWJ/dSBqeF
 3hQmLz84DJ0XPSplLU0wQe5zlkCDGZrkJjvyd2h8FMLc8FQNR61dh5F/VE4NrZNJUzPQIMfhH
 15BByCTBHoPeoydapfa+Pg+OT0CXLEtoIalwRD51WNfi2IWcQKM3t0KyAmxFB/C3SA9bN+DzL
 OWwHdaGKw6U8cKD0+uZUcHc+X1UOsSuUzDoA6GzRqcQNWMPSr6bDo2FTmfnRihh5VvrUNQCqM
 xsYBo0Jv8pQCXx4SbSE5aUoJb8sM+uVIiRxDCcBcac7KA3wXGPcj4XM+egJ2qGqXkcsjtWNwu
 5QNCLRGgOi6cxN60Hv4ylGq56ZiI4xT2D6YCBs7RNLeKbaHfOYYCvT+do3xBS+bs5CHB0vB72
 CNJWeGjb5vDQe7/hiE5eRgUmIv7Khs67p5NXu1FNhxvsoFeTAgdoT4egn0cbqHUKdx+SjZbxE
 sUITbJQnhENog/FA2xfpKZOrpm+NT4S9h9ZYpRXc3oqJ49xmu3VlbVPHkcm4sA1DEQMq8xSCL
 ftc7JMcqD2zAch7QeOWjGVikAykUpH7aLSy1PmLTqlAH5N3q8i+1123H5SquYKYAp50sHKZKU
 RbI37PAgg4pVLiAcqoLe+bIRs4EL0Vtq6obnp32UQ0owx4W7ARzUEM05i6+QV2wqUL2eVOKQS
 OJZyXHJnuyFJ3lCFbd+KMI+p/ldqvaZd8ife3F6faYqwdjgouQaE3rQnPBH6PGV6qVstVfz38
 0P9VJONrAFXMIU8EekUB9/rL7xypo757gPF2n7Hz27EE8NWS+E38fcUnS0p1/z1Ew5K7PMZ/J
 pSSZvcoqFndIwTszu5phPW3WPqj8g+YSRvp+p4g==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

CONFIG_EFI_MIXED depends on CONFIG_X86_64=3Dy.
There is no need to check CONFIG_X86_64 again.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/x86/include/asm/efi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b9c2667ac46c..ab28bf1c74cf 100644
=2D-- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -223,8 +223,6 @@ static inline bool efi_is_64bit(void)

 static inline bool efi_is_native(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_64))
-		return true;
 	return efi_is_64bit();
 }

=2D-
2.28.0

