Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D333EA9E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Mar 2021 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCQHfh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Mar 2021 03:35:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:45581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhCQHfG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Mar 2021 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615966502;
        bh=BSvzdLCpMSTIAlEgeD2Se2apmNBbKvJbABocc9lX6GI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YXmDmqDfAw1dX6SKf99rA9+8sFWn+SjUrhdhdqmqZk8bDS3AOzyFfxU8SAK5zWK5B
         OnKMBVk+ZpS4LLrH+8okOp3E6CAUCbHRj7g37g1ma6XYFkQS7Jyprnt3EwIbMCBfdZ
         OiAUPNSvlIPRHkHTkG/deBJF5ZJGv2ZDb26wmHH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHQh-1m6Bi847Zp-00kg07; Wed, 17
 Mar 2021 08:35:02 +0100
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC] efi: variable name size limit in efivar_init()
Message-ID: <75d99346-73c1-993c-8bba-08cb3b3271a2@gmx.de>
Date:   Wed, 17 Mar 2021 08:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIlKworuwoBEK9bJqnXo5PMeF/dRjsLO7Am/avxwfWdBpwATBbA
 3FNEw4ZBt3vJHIsxJWzF7MGAenX7vO20tU3FnRGE1pnq5+coaFpTZLShlBWhz25K1z/WemB
 Eqy/P1OCX59EdVGAUrQh84Bz57HcY6YhQ+OXQ26TSpXXs4qnE/2k3UVjXbbd93NvDciOP8a
 UkQAsM47MJXC0gvqoliZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1bPWdmBAY8=:edCshdUhyZQywMFF/+X+E3
 F6v1qiwjFjBnArdEtg2+Q2ib6XnvHTdw8ICsoobqSnQbBYVKLegLyXx5gjcTJTnYvuDyl0BaE
 ZUrOyBE5MgXhE6BYz4tq/gjqTYJkYSta1MhCemtoIVxABNLJA1jSrELYlWplNpWpUhKHJKMP3
 hhJ7MHAxoiCEx5PqMU7NidH/VQRtHr3rDw5gDj/S0xpVAcw1PD1uNoyDrlbSu0k5p5ZTVtUHV
 LzxUChvAfeneq7tEJw9Z2DDfZXb6oOsnQVDzugyxt0zmefA53nV+K6HHjrOogQfe2ziVMWzpd
 ve7MrrYVs0KdpxStPIuTxC/xERUYSqPsWFM6VLwkG/Ix6KDn2w3GlU9WjI7mbufeT8mF7K/aG
 DnQcIo5c/iM9x5SgdKubyh3eqI1gTo2JbP3Gi0xjxsXjgd8E8Ulf/SBpKplvpKPb7yvn/XDYF
 dOmPO8NbvQARk5VhI9bWgoYN6PoI9kZb+fLQjqEMPuxDjM3xWmIWK+tvAv1E+L669UXBLM61k
 ok0kB/QOzW9ZwqKFSxUHSqGyGgMJW7C2HJ9CKYemBdf+e/pyVnaBOFGDkIoUgKyIS+Xg5sSQg
 zbZNHUf7UDofIiqVHqoJd5o5mNzqRajqz6k1mtF1Or90Ys2NWBmociJJDogw+b39WYflvpAJK
 WGFygG7rrZ+qVXoYUHEeVF8BXHxmkeYycJpdi3NnyVUxnZbvdsPo3VWzwEeN3uFNcUHAo138Z
 cjLbAL2nhSqn+i8lvN6Xp/KPjLLyKWJLum+3LSivhFIJbfJYT1UGhFnEJuPF5PiHid6ju10Fp
 VoKHdgog/751O22A0cwyxjPKWA0HBaE3jfYMs3NUZHEN8izbK86JpkXgMvQ+VEw6G7B/+dQxM
 msY7v4e6PUO9s5WnL8Nw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Hello Ard,

in efivar_init() I read:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Per EFI spec, the maxi=
mum storage allocated for both
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the variable name and =
variable data is 1024 bytes.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0variable_name_size =3D 1024;

This dates back at least to Linux 2.5.0 of 23-Nov-2001 where in
arch/ia64/kernel/efivars.c we have:

/*
  * The maximum size of VariableName + Data =3D 1024
  * Therefore, it's reasonable to save that much
  * space in each part of the structure,
  * and we use a page for reading/writing.
  */

I cannot find this 1024 byte size limit neither in UEFI spec 2.8B nor in
EFI spec 1.1.

Variable d719b2cb-3d3a-4596-a3bc-dad00e67656f-db has 5080 bytes of data
on my laptop.

It may not reasonable to use a variable name exceeding 512 UTF-16
characters. But shouldn't we handle this case gracefully in efivar_init()?

Best regards

Heinrich
