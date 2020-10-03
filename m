Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592992821D7
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 08:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJCGiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 02:38:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:43077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJCGiO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 3 Oct 2020 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601707074;
        bh=ZegSKPFynorzf2pHNijeVk4xWnZ06qcsVKppYuZJeIE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Wl6L2h2LSUeIekSLAHG8p3k9MeKhItnHe76V4UmNHlC10PN4m15X08SlX+l5rG65i
         miCaimq6eeYfRnj7PvYDmRFrNbNPXxPn+kXFgnoxSI7Kcwdz3VbVmJD499sruJ1BKP
         OVAQX/ZF9b0K0Q2MF4kCLzHswb9m+wQtBsPHzuYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFvp-1kHCnX0PBN-00AH4c; Sat, 03
 Oct 2020 08:37:54 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 0/2] docs: admin-guide: EFI Boot Stub
Date:   Sat,  3 Oct 2020 08:37:23 +0200
Message-Id: <20201003063725.8698-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4NyI44BPR448lQJvY48cLHhTdO9OzbONsVoYMawOm9/qhQtVBH
 6MhreeG89mbVB04RQZCyr3fqiJBsGRb2GRm7c+GLvzhsbXR/BSsPnPynLHd2b05rPT7LUFh
 h9WnbHIh3Orbg1isYlZZkq+3HNPN4h8nNfJlAMRxmiUfRSDAHgFEfZ6VQBIF1eQWtnVyZMy
 wAxsSPWHOs1v6/dROulxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCCHzUNE040=:EwOaPHUt5//Ko9uVYJMY5Y
 BiF0pXYPl6rWjTtXbZKCJLJQjzA20RgSCY9Uyj6ZQPbbDcOwVWflZDYrSSOr13+q4ZjAV8lM7
 CCBKDniVB8yoRUU2CDfBbHQdHkEWt16km8hM7aCsvN45JG5hLe9xtSXB9L36BE2gHnD2/rnYH
 5kc6kl/9DGbBNBWoqSYhrG64PKBPl9m53o/gfMsejCulEHxKf5IeyN64Z1CfD17gJnxRFRFoZ
 4fJHAa7heVx0rDAuZtPJmft3P3EyTHSmJ/+knXjzZaqn7yRAprF0V+TZ/kVrblyv7sLPMBYSU
 n5i7sPtyRBooCM8qyjOWdqq23UitNoKbmEKFS6tiNhRI1YnlltN2zKO+IDxM3mDHgrl2hcCUO
 /fHMbskIN3uX2CB82TQDhTb7Ys2frh5Tvxd/t9syzKt81t/cNlMp9jwaTFbNXfdPUKiICrd73
 tuRBsspZm1FepTJVWB7rgjtqCWiEdKRUaMdtTzZznt7hmIKXYS2OcP4afr3+gwpqykzNU1Bm4
 7vWWKyq7nY/lLdQzDB/9/oAtE1ytXrtj3NGsCMX/UTz8m1CLAgR0MJ2nsL4JFedfCZ0eEctLK
 WdOgTV+dQBTlottRD47UQvOq4Ztx0FN4fcOtGaWzu/Q2S8xALCRbNeL485nGklJ7YcrPnm419
 ne5Hdm/c7OeONHzpoQykVkysC3Vk9fKTeIguiI7zbGz1kZrX0BATinwSLnff/h+ujve3hKqTs
 sB92TWRb7+JjcyHoV7lQYZhU8HdMWWyazQEY0Nygl7LX4MAQnobP+1W3ZO1JcNV5Nm6GVIjEx
 tdvZusMCrZM3Ix9rotHpDnRRhvfNUeDbTOQWIuhwujUpxS9yv1qUAB3m60eRZ3Tqhl+vpqIrw
 /gijbkcyfh228iLC1qWpsMNEpZdYjuUUCwiZoTpenoTb3dgApDyg5m2zjEe+PwvwTRRyZVE36
 woys6UBhjkqI29k1qR+K0pKjsWYQnfcdl4nC9Qhwuhp5TVznRE6PO3U4IhetpAQ2CjME4aNno
 W/83kbeU1VvW/kfKrOBDNjBrnmi2+RgiOoujbTyJv5EjTTJBpcaPHc9VP6r1YKRnE+zR/i3MT
 QlOVeOqBrSAufl/kqw8T8XFfOwsCWBGnF8RWlhpMQwee/xA/9c65MdVtFgBJA+rcvofYjNzve
 Soua73JBU5bqZ6oeCNlPq3SrXTyrf9NRURHgBq+v03nnrvbAG8uAQFcoSwFKu0kGy3zjGPfIj
 4N9bcNDDAj9WWrTyood2hGeAbqr407l2l5Wv8/g==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Describe the passing of the device tree and the initial RAM disk to the
EFI Boot Stub.

Describe the handoff to the main Linux kernel. The links given here
provide the necessary information about structures like boot_params that
have to be filled by the EFI stub. So we don't have to describe them in
the admin-guide.

Heinrich Schuchardt (2):
  docs: admin-guide: fdt and initrd load in EFI stub
  docs: admin-guide: EFI stub to main Linux handoff

 Documentation/admin-guide/efi-stub.rst | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

=2D-
2.28.0

