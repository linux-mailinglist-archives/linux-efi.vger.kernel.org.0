Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCE3D71C5
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhG0JPi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 05:15:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhG0JPi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jul 2021 05:15:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 862FC200E5;
        Tue, 27 Jul 2021 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627377337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xb68m5dHAKR0PH/2cvLJWdoZvjz2UPvyTRQe435BQg8=;
        b=osSoRLMgc+ypLi2F6EFUg8jgbpY/EBCs8Dmo9MNWFt3N6JudyWlJSZOHMROOE5ZGluEZgQ
        6WrVbrbypShi0GNKFI641Zq5J3OF0+KvEaGnej4/GYCRGTS8FFG3WBLTOmq9U9b/YpqkpT
        YBLA1WF5SMUxJJnGakeWp+VHvlxGNaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627377337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xb68m5dHAKR0PH/2cvLJWdoZvjz2UPvyTRQe435BQg8=;
        b=3qauaXYm1eYovoaT0uz5z18OcXJEejFwdzcyciDgwb+oG2g8TElHP8q1xoAUBuzdEBVCR5
        viqcvs6dEeqLBUDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 58BBA133DE;
        Tue, 27 Jul 2021 09:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cViwFLnO/2CJLQAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Tue, 27 Jul 2021 09:15:37 +0000
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
References: <20210727050447.7339-1-rdunlap@infradead.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <aefba212-1e08-9994-6d6e-6db292bf9db6@suse.de>
Date:   Tue, 27 Jul 2021 11:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0RCxopRs9DF6c7HQAMBrIYe4QeHSjEThh"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0RCxopRs9DF6c7HQAMBrIYe4QeHSjEThh
Content-Type: multipart/mixed; boundary="NXt3eb7tog0K2DhmRA1oDM5VMlY2jRIyP";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
Message-ID: <aefba212-1e08-9994-6d6e-6db292bf9db6@suse.de>
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
References: <20210727050447.7339-1-rdunlap@infradead.org>
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>

--NXt3eb7tog0K2DhmRA1oDM5VMlY2jRIyP
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.07.21 um 07:04 schrieb Randy Dunlap:
> When # CONFIG_EFI is not set, there are 2 definitions of
> sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
> and the __init function from sysfb_efi.c should not be used.
>=20
> ../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of =E2=80=
=98sysfb_apply_efi_quirks=E2=80=99
>   __init void sysfb_apply_efi_quirks(struct platform_device *pd)
>               ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
> ../include/linux/sysfb.h:65:20: note: previous definition of =E2=80=98s=
ysfb_apply_efi_quirks=E2=80=99 was here
>   static inline void sysfb_apply_efi_quirks(struct platform_device *pd)=

>                      ^~~~~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-next@vger.kernel.org

Thanks for the patch. It should have a fixes line

 > dim fixes 8633ef82f101c040427b57d4df7b706261420b94

Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer=20
setup for all arches")


=2E.. and maybe a few more of the CCs below

Cc: Javier Martinez Canillas <javierm@redhat.com>

Cc: Borislav Petkov <bp@suse.de>

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

Cc: Thomas Zimmermann <tzimmermann@suse.de>

Cc: Ard Biesheuvel <ardb@kernel.org>

Cc: Paul Walmsley <paul.walmsley@sifive.com>

Cc: Palmer Dabbelt <palmer@dabbelt.com>

Cc: Albert Ou <aou@eecs.berkeley.edu>

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: Linus Walleij <linus.walleij@linaro.org>

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Cc: John Stultz <john.stultz@linaro.org>

Cc: Colin Ian King <colin.king@canonical.com>

Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>

Cc: Sudeep Holla <sudeep.holla@arm.com>

Cc: Maxime Ripard <maxime@cerno.tech>

Cc: linux-efi@vger.kernel.org

Cc: linux-riscv@lists.infradead.org


Best regards
Thomas

> ---
>   drivers/firmware/efi/sysfb_efi.c |    2 ++
>   1 file changed, 2 insertions(+)
>=20
> --- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
> +++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
> @@ -332,6 +332,7 @@ static const struct fwnode_operations ef
>   	.add_links =3D efifb_add_links,
>   };
>  =20
> +#ifdef CONFIG_EFI
>   static struct fwnode_handle efifb_fwnode;
>  =20
>   __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> @@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
>   		pd->dev.fwnode =3D &efifb_fwnode;
>   	}
>   }
> +#endif
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--NXt3eb7tog0K2DhmRA1oDM5VMlY2jRIyP--

--0RCxopRs9DF6c7HQAMBrIYe4QeHSjEThh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD/zrgFAwAAAAAACgkQlh/E3EQov+B2
og/7BYM2si7NL1hDIJB8rYBrta2i9u1ew55fC5EuI7RnQkmsUI+xLddnSu0vYg13xoXXP2TodApl
VAUPHtbkYdKPlqlYMXScUi9t6iCfraElh41EIapWG3r0PRDgkdLtMmLzHatEChFiEJp32ydFzdPm
xzFwTctOObTNdjqpRwDYDIH1CNdQYpnyzF29F83Cshe8JjIrt9uRf61jp6gKMKYY1YaHpxXkVb/t
QCyiL1cgP2obQyrTuTogUd5tMCljyYliKCHqI+l7pz1zPLv1c7JyrMQtg0m+0aNHfaUsPYVamnRb
EaJdBBd17Axh7B3XInD6GFYx4oIq5CX42hiLAm+Ov8qbvsNF2cF0j+94KtXUqpUaIgI3y15+FbMw
dQb8RefgWQJDj0Dhgl1ULmjYh/mImRkJuRtYpoZNbFvrcxCJK4Y5Sl+KA7puj7TEJ4a4ls/s4nXH
UOQl8PYzzR93P0C1m72jqCoNnLR6p5kwxDZPIt9MzGc20EZ8vi3lrYASvtxFKEn/GS02cY8Xhx0w
r5walgfbLu4jpD+PP83sxF6jUsaRyVECG8ld9/MboEty51Chj9UcPp7xHLIICfv4yAMIw5ZWeVYC
hGyrw4v42Z7QL/QIzHOjIibughA/avWJ6f2H17lpRfpP4fx76bXLB8iV9uHBSXJRN8bQKD/sNRVx
jrU=
=Jqd2
-----END PGP SIGNATURE-----

--0RCxopRs9DF6c7HQAMBrIYe4QeHSjEThh--
