Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7403D01CC
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGTR6w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 13:58:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGTR6T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 13:58:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80010202FE;
        Tue, 20 Jul 2021 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626806323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Itbuyl1CzYZ7paouos+Swyo4VPUIJaRt4atAD+g7b4E=;
        b=vA6iScBn4/u/Wziq8CzkVziwPhiPjDEH98IrUR1IQ5re1rpNrSe4mS29cI54SS2WSvrFSy
        B0diseP/p9EB+bvqo8x8SyLh8r1jSGENRGf5b5/B8okkZ9MeP2gL6EWZH0QbG3GL3m8FCc
        n24nMyq14PEzxE/Mq0xGl22TrCV38jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626806323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Itbuyl1CzYZ7paouos+Swyo4VPUIJaRt4atAD+g7b4E=;
        b=1JIMXVY4pTlFUqFjyxJevhpnFGvHqQgrdOo+pkrgWpfa0IdruwQvoLQDc99O69fuLtZEtS
        nHTKbXeeMlZWEIAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 13CD013BA3;
        Tue, 20 Jul 2021 18:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id XqtiAzMY92DSXAAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Tue, 20 Jul 2021 18:38:43 +0000
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
 <YPbWrV/cIODdgu6A@phenom.ffwll.local>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
Date:   Tue, 20 Jul 2021 20:38:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPbWrV/cIODdgu6A@phenom.ffwll.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zqBJYs0jTVrrb3d3a45VU8trX1N28Y7W5"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zqBJYs0jTVrrb3d3a45VU8trX1N28Y7W5
Content-Type: multipart/mixed; boundary="1j8k54rxJM8w24eiu5PhN408CT5BxM6T4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dave Airlie <airlied@gmail.com>,
 linux-efi <linux-efi@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Catalin Marinas <catalin.marinas@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Russell King <linux@armlinux.org.uk>, Atish Patra <atish.patra@wdc.com>,
 linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon
 <will@kernel.org>, the arch/x86 maintainers <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Robinson <pbrobinson@gmail.com>,
 Borislav Petkov <bp@suse.de>, Albert Ou <aou@eecs.berkeley.edu>,
 Hans de Goede <hdegoede@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
 <YPbWrV/cIODdgu6A@phenom.ffwll.local>
In-Reply-To: <YPbWrV/cIODdgu6A@phenom.ffwll.local>

--1j8k54rxJM8w24eiu5PhN408CT5BxM6T4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.07.21 um 15:59 schrieb Daniel Vetter:
> On Tue, Jul 20, 2021 at 03:42:45PM +0200, Javier Martinez Canillas wrot=
e:
>> On 7/20/21 3:01 PM, Daniel Vetter wrote:
>>> On Mon, Jul 19, 2021 at 09:10:52AM +0200, Ard Biesheuvel wrote:
>>>> On Mon, 19 Jul 2021 at 04:59, Dave Airlie <airlied@gmail.com> wrote:=

>>
>> [snip]
>>
>>>>>
>>>>> Can we just merge via drm-misc and make sure the acks are present a=
nd
>>>>> I'll deal with the fallout if any.
>>>>>
>>>>
>>>> Fine with me. Could you stick it on a separate branch so I can doubl=
e
>>>> check whether there are any issues wrt the EFI tree?
>>>
>>> It'll pop up in linux-next for integration testing or you can pick up=
 the
>>> patch here for test-merge if you want.
>>>
>>
>> Thanks a lot Dave and Daniel!
>=20
> Oh I haven't merged them, I'm assuming Thomas will do that. Just figure=
d

Can I simply put the patches in to drm-misc-next? There was some talk=20
about a topic branch?

Best regards
Thomas

> I'll throw my ack on top:
>=20
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
>>> And since Dave has given a blanket cheque for handling fallout he'll =
deal
>>> with the need for fixups too if there's any.
>>
>> I also plan to look at any regression that might had been introduced b=
y these.
>>
>> Best regards,
>> --=20
>> Javier Martinez Canillas
>> Linux Engineering
>> Red Hat
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--1j8k54rxJM8w24eiu5PhN408CT5BxM6T4--

--zqBJYs0jTVrrb3d3a45VU8trX1N28Y7W5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD3GDIFAwAAAAAACgkQlh/E3EQov+Cy
CA/+NPcliJKPQpDfrX9J8jEslefrqYJqDEMFIXRQUC0mvqHkXwSy2cKKK18NSQGAbLKlii82BeoM
wCuaTJ6XUaZmBHsd6IqnkGHTBi6ytimeuGMHy9iNUqieuamxl/h3vIkUraDnAHgmeZtBxwVxSxKe
8HX+XJI/OEtaFdNqeZCHefwD4u3FFBmcSvnJDGKYFt84Wcbyt5LsvrzwXvyVEvSixkB6VFSLjufc
lRbdqMdtWs6At9YoxDcDsnZhnVCCnyWrCbfxptyPg77C7GfT4CM3ZF+HYby+gjNpsqKBbAgGvpxM
pNWsJP92rucNPnCopzcuPdpo4v6IPET4QCg8BQjIZVBoWsU8JAzoz75shl0/nICkpeAiwN58sMBt
/KtHCAcnwVgHhuTf5LR7u6la16IC7++lsuoW4qefmeKiPOCMfhIaWqWxCVz7sfo1rasobhJUw5f2
kWd1N1ujR5pRSfxTdfDYTqjUP8HEXK57E/KINStLfI8J+ERHhN117XTmO38juIHMkhWuvwL9nyff
Bn+E5q23QYw8j55D7KOX0MFcp8RtW18IPojaBkWjsPrNDfTdmMiPlZcLjzPuZxJahOhJhWbK1HTO
SWPPXnZX9Sk4eDdTaKZw/MnqD60ofyvpZn5USkKKQrVps+KZcjb4rFgQVHd9nOZzT/hFWNvX1yc+
Fh8=
=OXq5
-----END PGP SIGNATURE-----

--zqBJYs0jTVrrb3d3a45VU8trX1N28Y7W5--
