Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845933C9A40
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhGOIOq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 04:14:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbhGOIOp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 04:14:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED8EC1FDE5;
        Thu, 15 Jul 2021 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626336711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqXB8FwbR4mWpXDEB856YL88ZL4zpytqwWSg0MK4Er0=;
        b=LHKTszttqznz72msYhWWLK1zPzgNrcB+dS3HiqvBes9ppU+jpyPba5y2HYbEjULgBG3/AV
        epTkUDMw1E2/4Wntdv56xMOgytYwbaPcStEJBedjAPKj+N23oSreLjdkUg36UE/xwMYH7W
        Jz+o6kupe6rb2gHOG+dtK1n/Z7UCsHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626336711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqXB8FwbR4mWpXDEB856YL88ZL4zpytqwWSg0MK4Er0=;
        b=I2b3kJ8MW05joOEVymY6wqDkHjgqqNfRErhlTZWfvH5QGu6TP9k69zTpGDWjYpr+mE/3on
        OLuKRBgrY5YGmbCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 459FD13AB3;
        Thu, 15 Jul 2021 08:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id b0TXDsft72C/agAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Thu, 15 Jul 2021 08:11:51 +0000
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel@lists.freedesktop.org, Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
Date:   Thu, 15 Jul 2021 10:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iu6zN0OFsiQ8WAhMAHq5Yk61xpQgmcPTH"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iu6zN0OFsiQ8WAhMAHq5Yk61xpQgmcPTH
Content-Type: multipart/mixed; boundary="oERJS9i9SRexZTdXWB5psyaCpbIofUtkZ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Peter Robinson <pbrobinson@gmail.com>,
 Borislav Petkov <bp@suse.de>, Albert Ou <aou@eecs.berkeley.edu>,
 Hans de Goede <hdegoede@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
In-Reply-To: <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>

--oERJS9i9SRexZTdXWB5psyaCpbIofUtkZ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.07.21 um 18:59 schrieb Javier Martinez Canillas:
> On 6/25/21 3:09 PM, Javier Martinez Canillas wrote:
>> The simplefb and simpledrm drivers match against a "simple-framebuffer=
"
>> device, but for aarch64 this is only registered when using Device Tree=
s
>> and there's a node with a "simple-framebuffer" compatible string.
>>
>> There is no code to register a "simple-framebuffer" platform device wh=
en
>> using EFI instead. In fact, the only platform device that's registered=
 in
>> this case is an "efi-framebuffer", which means that the efifb driver i=
s
>> the only driver supported to have an early console with EFI on aarch64=
=2E
>>
>> The x86 architecture platform has a Generic System Framebuffers (sysfb=
)
>> support, that register a system frambuffer platform device. It either
>> registers a "simple-framebuffer" for the simple{fb,drm} drivers or leg=
acy
>> VGA/EFI FB devices for the vgafb/efifb drivers.
>>
>> The sysfb is generic enough to be reused by other architectures and ca=
n be
>> moved out of the arch/x86 directory to drivers/firmware, allowing the =
EFI
>> logic used by non-x86 architectures to be folded into sysfb as well.
>>
>=20
> Any more comments on this series? It would be nice for this to land so =
the
> simpledrm driver could be used on aarch64 EFI systems as well.
>=20
> The patches have already been acked by x86 and DRM folks.

Time to get this merged, I'd say. People are asking for these patches=20
already.

Best regards
Thomas

>=20
> Best regards,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--oERJS9i9SRexZTdXWB5psyaCpbIofUtkZ--

--iu6zN0OFsiQ8WAhMAHq5Yk61xpQgmcPTH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDv7cYFAwAAAAAACgkQlh/E3EQov+B8
UxAAy4fbawz3l/323R44323T5tao9iLYrR1CirJHLwuir/wLpyBCiKntH12jR0bEROIu/rUG/KrQ
gtMsLgxRwNOIF2VTrz6I1cTS5/J83Q5NApEuFHJE1lXT24JV9LFtZTnDjCUIrrY5Yc1X5WIkC8Yi
KnFrEakP86onMRRc51y/B7RuGGHg+7k95LTGtbrsry4Yeu//SQyCnffr8jR3uWgF8ft3BKc51O19
7I2KkhlafdRS0R6jxhcuemVGgTxo3NfAe439lw2HMI+7PagXjf+ZirgSt34QsNVO2JuKPT3jymW3
m0u80hkUAv8kPc7gHL6CNN1eSKgR3s6yydi5uzlYQQR3I98v2OErLfLcBRwwjVqFpYv4lbDJqqBR
5tCt/78LRkoa/pBN6u7E0MSWd5JyBNJxcOGvLmMWJ5TsnCK3G0i0S78YUaBXOfKcYiSvO2i1xnrs
uzyvAJbq6Il71SL2clOXmmgstbGfBqJMewei4vjATq/O+k2SzkEZMuiksq7YyJxXU79LkbTo6PW8
fMWVWy1pmZqfQgwKfE2BPjTzu1UwAPHVBN8vQOgu2M7CcQ3MmrjnWLYem3tDloyRAzrHnSOkZ5MY
ZbkBlTsBqKJdTO4dA6dyJt15i30RV2k6DohnF5DCXepAF3fbWjv+Rm30/Acvs43UgtecBvWu68rh
ofQ=
=fW1p
-----END PGP SIGNATURE-----

--iu6zN0OFsiQ8WAhMAHq5Yk61xpQgmcPTH--
