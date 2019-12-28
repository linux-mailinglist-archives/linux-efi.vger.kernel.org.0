Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E816212BCC3
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 06:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfL1F3G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 00:29:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43157 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1F3F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 00:29:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so15404673pga.10
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 21:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XSe30cWulPamZ+GrY4WFEU8AKQkHXDH6AXMp7whJCDk=;
        b=X7vraYBFnQ6uZ5QAllAPOThk7ClZrwXw9Lxla3szr5C4nuL8hO3YZ3pQYlRUNrU7Yj
         Rujl+2CkVLrRxSOinY90RaVNPQHCcOTBmFxkeoDrxxddhKIHBpgUlehDRcF4RYNrwXKA
         w7lHR+CGUl+Siusfm3rPX7PhSeoSmVJzzhDbJKq3YaLpRTnxJGVmNQUlMW3dgMn0COR7
         kAA90N/99BEdooLQq9MDcLz3ospLxTpRwp4FA1owEHe6J675Xwi6tLPArvqsspn9iS1B
         TDnJzvNyBPP9MDvmzhb+Nrfe9uXGEU5Rfcyr/ML5qu18zFX+XvOkuLR7Cve0Pump/U/F
         OS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XSe30cWulPamZ+GrY4WFEU8AKQkHXDH6AXMp7whJCDk=;
        b=VtcJmJIPKeJ5zgjTtKMtCNm58bmWsEqVirWsy9j/0bfEKXC2QX8ue3cin3a0DyuJwn
         YyxAWaIpgVL2kua3kqsEY8xz+9mYMu0a+lKxPQtiIsxsgG+4C2F3ENDbfjrcW1tic1hm
         At4gMl9fq3eXfFidjBg90s8jJDu0Rb2upJrTdikbb7ebvyKRMh867pE9/LxEuEz0iPs0
         YDmW5ij0CLy7cw6sXhKvaCppCxHlk0WhXiuCeEZiKdi2Et381jPWsgx8+QRUdXfmbOf7
         91KrgTmiaxL0VEqUCEl2OSOLnEoj2E5D21x8o1E9MeHGhiVG7v5QLHurGHKTMnrGOU6E
         79Hw==
X-Gm-Message-State: APjAAAWzBX/VLxOwhRnoXSL1AdA55CDonBcfJiNAiy8PTMcayssqkJBl
        gegsGrwjSHdMDieMfq/X6vHpYQ==
X-Google-Smtp-Source: APXvYqxGIMkGjLxw4OwQR0NiphkF3U4OR9DtMsquOmkg23+olU7y09cYUHwjcMarAEbxqqj3+k7aog==
X-Received: by 2002:a62:a209:: with SMTP id m9mr49088691pff.16.1577510945116;
        Fri, 27 Dec 2019 21:29:05 -0800 (PST)
Received: from [25.170.118.188] ([172.58.27.172])
        by smtp.gmail.com with ESMTPSA id z30sm43473485pff.131.2019.12.27.21.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 21:29:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Sat, 28 Dec 2019 13:29:00 +0800
Message-Id: <F8539C65-87F2-460C-A3CB-474C4D1BC08B@amacapital.net>
References: <20191228044357.GA1194635@rani.riverdale.lan>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20191228044357.GA1194635@rani.riverdale.lan>
To:     Arvind Sankar <nivedita@alum.mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


> On Dec 28, 2019, at 12:44 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote:=

>=20

>>=20
>> Does the UEFI spec explicitly state what FP state can be used by the
>> EFI functions?
>=20
> For 32-bit, it requires the following for boot services and runtime
> services:
>=20
> * Direction flag in EFLAGs clear

Check.

> * 4 KiB, or more, of available stack space

There ought to be.

> * The stack must be 16-byte aligned

Nope. The asm needs to do this for runtime services. The kernel runs with 8-=
byte stack alignment.

> * Floating-point control word must be initialized to 0x027F (all exception=
s masked, double-
>  precision, round-to-nearest)

Ingo, surely kernel_fpu_begin() does this.  But I can=E2=80=99t find any cod=
e that does this. Please tell me I=E2=80=99m just missing it because I=E2=80=
=99m on my phone.

Presumably the code ought to optimize it by saving regs, then checking for u=
nexpected values, then doing FNINIT and STMXCSR if the state is bad.

> * Multimedia-extensions control word (if supported) must be initialized to=
 0x1F80 (all
>  exceptions masked, round-to-nearest, flush to zero for masked underflow)

Ditto.

> * CR0.EM must be zero
> * CR0.TS must be zero

Check, on modern kernels anyway.

>=20
> We don't actually align the stack for 32-bit mode before calling, do we?
>=20
> No FP registers are clobbered except the floating point status register.

I don=E2=80=99t believe this for a minute :).

>=20
> For 64-bit:
> * Direction flag in EFLAGs clear
> * 4 KiB, or more, of available stack space

Check.

> * The stack must be 16-byte aligned

Nope. We need to align it. Does the EFI runtime service code do this?

> * Floating-point control word must be initialized to 0x037F (all exception=
s masked, double-
>  extended-precision, round-to-nearest)
> * Multimedia-extensions control word (if supported) must be initialized to=
 0x1F80 (all exceptions
>  masked, round-to-nearest, flush to zero for masked underflow)

See above.

> * CR0.EM must be zero
> * CR0.TS must be zero
>=20
> xmm0-5 (and the FP status register) may be clobbered, the rest of the FP
> registers are preserved.

Seems reasonable.=
