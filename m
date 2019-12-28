Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656D912BD0E
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL1JA5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 04:00:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42081 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfL1JA5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 04:00:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so12657711plk.9
        for <linux-efi@vger.kernel.org>; Sat, 28 Dec 2019 01:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=98Ywcf328YHflobb6QnObqusk2V55RKQtdWPtRTiPiU=;
        b=fXRo4aHo2KKlUuk5yhG28JNjx9NNS7qlBu6g1CuZCEkDxMcNXTAptpteUjmjPQw0+d
         lKixkIUh1fcVx+/gWvomrMFTQ9iYo+WqsnY/8li70Fhyx1MVE8hjRCeOlIIKMK23EnhD
         BQAdb9ld78xBzusVK47F08efB/fsxmY0QQmEHwfLiyI+p2v9fVYDJJPy+qen9j9hcPFH
         1v2uQeyzX69OHgyBWkR1ijMDkRuv3EgoqY4gLvHYc7sfWS6hV9p2bh8jKCzYA9ic+ubB
         jG0ox58pxAIMY612AAl+n/4NTVlWHAx6OyxMqmoiOfkvNGiJ3iOVW94PxhlPqmEUAOnk
         +GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=98Ywcf328YHflobb6QnObqusk2V55RKQtdWPtRTiPiU=;
        b=fFP/vhMcgSTlzCGoa9txw/SFDMpXU3/vnb/wXuEU6SIgaJzMPVNlguWg8oyFxJydCc
         Cd6YRiZRT2Gx2mDl3fIhaL0VLBCBHEg0J/uz0byNgYV5D5ReX28HMe7of3GueOjMQblK
         sKtsxCfDd6b1mjmbmti1kWizqAKaf++4UnNWtMorvFGySKMOTG1TX4aeogrQclxRj0xx
         cr3+b5A3+AQFD8FZAGmUxCbXr7qFi/TAMj9CYjEODOnPW2MI3nuhO9YOPhskTwl9NQkf
         YrdIDAhwlqFTv9j9WzkChekoaDsf3yrURYL1C/B0HweQfeOBNMZv+ZSZQu6gh/tm2j4X
         c4Sw==
X-Gm-Message-State: APjAAAVHdgCGv5TSYpCDcpMU6DXL92Yocdeni+YubOLFQtAEPVrCnLrI
        KxYlM9vkbNmGn/o4HwtviGU1hQ==
X-Google-Smtp-Source: APXvYqxowLhq6Bj64Ay+NA7LIQ1EaquKP2vdSYOzgS7vDT5urrCK0wKNdw/oYmh+yASNJf7F5JBzpg==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr56541496plk.233.1577523656776;
        Sat, 28 Dec 2019 01:00:56 -0800 (PST)
Received: from [25.170.118.188] ([172.58.27.172])
        by smtp.gmail.com with ESMTPSA id 13sm42719424pfi.78.2019.12.28.01.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2019 01:00:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Sat, 28 Dec 2019 17:00:52 +0800
Message-Id: <63CD3BC7-8BA7-41D4-9818-48827BBE3573@amacapital.net>
References: <CAKv+Gu9WF4iRQy9qpxaeFg+3CJkcDXxGePpn4f5ZnaA5yj4cmw@mail.gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAKv+Gu9WF4iRQy9qpxaeFg+3CJkcDXxGePpn4f5ZnaA5yj4cmw@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 28, 2019, at 4:51 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Sat, 28 Dec 2019 at 08:03, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>=20
>>=20
>>=20
>>>> On Dec 28, 2019, at 2:35 PM, Arvind Sankar <nivedita@alum.mit.edu> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Sat, Dec 28, 2019 at 01:29:00PM +0800, Andy Lutomirski wrote=
:
>>>>=20
>>>>> * The stack must be 16-byte aligned
>>>>=20
>>>> Nope. The asm needs to do this for runtime services. The kernel runs wi=
th 8-byte stack alignment.
>>>>=20
>>> 32-bit code is actually only 4-byte aligned in the kernel proper, right?=

>>=20
>> Right. By =E2=80=9C8=E2=80=9D I meant =E2=80=9Clong=E2=80=9D.  Sorry.
>>=20
>>>=20
>>> Currently, only native 64-bit calls always respect the 16-byte alignment=

>>> requirement, by aligning explicitly in the asm stubs, or after the
>>> cleanup patches, via the efi bootloader running with 16-byte stack
>>> alignment.
>>>=20
>>> I think mixed mode might actually be aligned via the asm stub in the
>>> kernel proper, though it doesn't look like it is in the bootloader
>>> portion.
>>=20
>> The underlying problem is that gcc doesn=E2=80=99t give us a way to do CA=
LL from asm while preserving more than a single word of alignment. This forc=
es us to compile the kernel proper with reduced alignment.  (Also, the gener=
ated code is better with reduced alignment.)
>=20
> At runtime, the 64-bit kernel always uses a 16 byte aligned stack when
> calling into EFI (32 or 64 bit), either by aligning the stack pointer,
> or by switching to a special stack.

Can you point me at the stack switching code?  Stack switches always make me=
 nervous due to interactions with other things, especially NMIs.=
