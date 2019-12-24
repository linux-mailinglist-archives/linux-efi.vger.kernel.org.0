Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C68129EA2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLXHrH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 02:47:07 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39716 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfLXHrH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 02:47:07 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so879021pjb.4
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 23:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3vmiAbPmcKUrwVQnNlObMOmrlg8Ww3BYlRZiYjbak/I=;
        b=WZ7aAUfZyYPYoBtskBkwoi+iPWFpGslYcluegYchAOJIZs7zqDQRKT8w8hFKuTQ0rP
         ql+X6hihSNnE2eFQI7T7atufwUZzRls/u6lOe7tuezv8TvElEIRq8x8BEDEuMhjj5tha
         LAUp6A55v0G66YjuLiNviwLPCIrU9tSMGxWKs/9GdByUTWmJuSdr5TBMe6JjWA1jxe23
         v0Czv9nV9D3teIOgEE6whaOCjPXA2S1nayWwkZZl4myvSjgxXV8a5puLjyRkZ2zdSbm8
         QQW7jamgCOIiwtuBa/FYGNa2YR8aOBXcnihjG+eSH8LM4bC87FCqmdyBoKD1mHSyie87
         XW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3vmiAbPmcKUrwVQnNlObMOmrlg8Ww3BYlRZiYjbak/I=;
        b=rh+M9hndtI+cTXJjav3MPNFEo38lX5ua5WeTDz+PQE0FrJUHuGXl2Bf4CL5fPB3e+T
         aU558aby9heWAnWcpEpGMibR2nQeXa3xt4vAPL5wJIvCBxLVvU6oadZ4oGb62HHmE2q1
         wF1F+axq+4bUkq7c+qm9cUd9WEhV/RoMfO8a0LfbfAmLFIw1U45x2FRHNky0QZqRdiU1
         RTi4hqfwhezIU4bw8cf6hRj7aZ4vvq7N/b2nXw2flWQpOhBiQCaU/oRi5oCFy4AIdvRD
         l5fxyMeLP6MT8/LCgkALGimCnw7Iw7KIhtijJ2l7FOpRv5bRl1aroKtITFJXEWhkhI76
         Z7Vg==
X-Gm-Message-State: APjAAAUetKXffSWTHencg9SvwCMfoLia61qQTmfy3VokE/cVIcrktXya
        bEomOIgIxMVIlREzOVylpLy6vw==
X-Google-Smtp-Source: APXvYqyQKJMWsMovgwCXKyeyMcNSxwEmzBQ7fRkDMQhS08eXSBTDcRO8HWAevp+Uq8S+MSlO50DgtA==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr33298951plo.228.1577173626704;
        Mon, 23 Dec 2019 23:47:06 -0800 (PST)
Received: from [25.170.196.173] ([172.58.27.144])
        by smtp.gmail.com with ESMTPSA id v4sm3643263pff.174.2019.12.23.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:47:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/efistub: disable paging at mixed mode entry
Date:   Tue, 24 Dec 2019 15:47:01 +0800
Message-Id: <94A83725-602F-4253-B715-25C391672384@amacapital.net>
References: <CAKv+Gu9B4+MGP7gqpSiaYMaGG5u1K9D1nQ2sTvTt50qPhvwQFg@mail.gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
In-Reply-To: <CAKv+Gu9B4+MGP7gqpSiaYMaGG5u1K9D1nQ2sTvTt50qPhvwQFg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 24, 2019, at 3:38 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Tue, 24 Dec 2019 at 03:15, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>=20
>>> On Mon, Dec 23, 2019 at 7:23 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>>=20
>>> The EFI mixed mode entry code goes through the ordinary startup_32()
>>> routine before jumping into the kernel's EFI boot code in 64-bit
>>> mode. The 32-bit startup code must be entered with paging disabled,
>>> but this is not documented as a requirement for the EFI handover
>>> protocol, and so we should disable paging explicitly when entering
>>> the kernel from 32-bit EFI firmware.
>>=20
>> Does this mean that EFI is allowed to call the kernel with paging on
>> but the text identity-mapped?
>=20
> Yes. This is explicitly mentioned in the spec. Paging may be on or
> off, but all memory must be mapped 1:1
>=20
>> Have you seen this happen in practice?
>>=20
>=20
> Yes. GRUB and OVMF both implement the EFI handover protocol, but OVMF
> doesn't disable paging before calling the 32-bit entry point, and so
> it explodes in startup_32(). GRUB calls the EFI handover entrypoint
> with paging disabled, and so then everything works fine.
>=20
>> If the kernel is entered with paging on and the text not
>> identity-mapped, this is going to blow up badly.
>>=20
>=20
> Not just text: all of system memory is guaranteed to be 1:1 mapped if
> paging is on when entering the kernel from EFI, so this should be
> safe.
> Note that this change only affects mixed mode configurations that use
> OVMF instead of GRUB.
>=20
> We are using OVMF/qemu in kernelCI for test coverage of the EFI stub
> for all architectures, and this is the missing puzzle piece to get it
> working in x86 mixed mode as well.

Sounds good to me, then.

I admit to being a bit confused, since I would have sworn that I=E2=80=99ve p=
ersonally tested mixed mode with OVMF.=
