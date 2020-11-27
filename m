Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83972C6A45
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgK0Q4R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 11:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbgK0Q4R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Nov 2020 11:56:17 -0500
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Nov 2020 08:56:16 PST
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55DBC0613D1
        for <linux-efi@vger.kernel.org>; Fri, 27 Nov 2020 08:56:16 -0800 (PST)
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m2x.dev; s=key1;
        t=1606495874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5mjI+AQcHSVQthiTxsPjXhZSmVk/Hx+CAQbbx8ybKU=;
        b=fAGbIKgzRvpE/+ZEOAHN+swXBsycPHFkLrwMV48VrQZZyQNm06TGHvxNCmcT5T72gAYDud
        3K4N7j6JWIAaV/wRAczGjOQheqXxd+n17DJkwUcrJvz6JnDIAJgvOjw3ler8bypbIlIdwf
        tQsnVwojBnt6SphJw4ZJSgvE++CaYRx6zPR3o8w4pfatgWYFZNGJz0UkyOtesMt3Cl9yS0
        p2EegMnbKZhN2VcAO/oW0cQlqp0pdZU3qdcY4MRvQgF+yACAT24h9CnOahz+dBmjZxvhmy
        wy6CpgfKbEShVI7aMmMYLNqvDHq/x9KOzsP8c6fJiEp5eiju0WNzPGvNfXwRmA==
To:     Ard Biesheuvel <ardb@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-efi <linux-efi@vger.kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@google.com>,
        David Laight <David.Laight@aculab.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
References: <20201125075303.3963-1-ardb@kernel.org>
 <309bd3399d042ca94e5bab35980d661c@natalenko.name>
 <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathon Fernyhough <jonathon@m2x.dev>
Message-ID: <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
Date:   Fri, 27 Nov 2020 16:50:34 +0000
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RfaFAzNL9k5mf8L2I9SrvVssXgXFCTDvZ"
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathon@m2x.dev
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RfaFAzNL9k5mf8L2I9SrvVssXgXFCTDvZ
Content-Type: multipart/mixed; boundary="yYUdWpNb1mo0S5yzOaogWdW51EmlxvelQ";
 protected-headers="v1"
From: Jonathon Fernyhough <jonathon@m2x.dev>
To: Ard Biesheuvel <ardb@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-efi <linux-efi@vger.kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
 Matthew Garrett <mjg59@google.com>, David Laight <David.Laight@aculab.com>,
 Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Message-ID: <a07e1520-f08b-2456-a954-707e0c3bcb4a@m2x.dev>
Subject: Re: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
References: <20201125075303.3963-1-ardb@kernel.org>
 <309bd3399d042ca94e5bab35980d661c@natalenko.name>
 <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>
In-Reply-To: <CAMj1kXHHW2MSUb1emSnDPqffBVFinAO2=w5Si3toEvqXZUBY2Q@mail.gmail.com>

--yYUdWpNb1mo0S5yzOaogWdW51EmlxvelQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 25/11/2020 10:28, Ard Biesheuvel wrote:
> On Wed, 25 Nov 2020 at 11:27, Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
>>
>> On 25.11.2020 08:53, Ard Biesheuvel wrote:
--snip--
>>
>> Do we need to do this as well:
>>
>> #include <linux/kmemleak.h>
>>
>> ?
>>
>> Because otherwise for 5.9 I get:
>>
>> [  148s] fs/efivarfs/inode.c: In function 'efivarfs_create':
>> [  148s] fs/efivarfs/inode.c:106:2: error: implicit declaration of
>> function 'kmemleak_ignore' [-Werror=3Dimplicit-function-declaration]
>> [  148s]   106 |  kmemleak_ignore(var);
>> [  148s]       |  ^~~~~~~~~~~~~~~
>>
>=20
> Ah yes, thanks for the report. I will add the include to the patch.
>=20
>=20

Is this necessary if CONFIG_DEBUG_KMEMLEAK is not enabled in the kernel
config? e.g. should there be an #ifdef CONFIG_DEBUG_KMEMLEAK somewhere
in there?


--yYUdWpNb1mo0S5yzOaogWdW51EmlxvelQ--

--RfaFAzNL9k5mf8L2I9SrvVssXgXFCTDvZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEdsbkdwQr/phcwiC9nAiiVUQvr/AFAl/BLloFAwAAAAAACgkQnAiiVUQvr/DJ
2xAAzSMQ1w8yUPYjvTNnJ2QIudzJCDBKNaLkZImCd6lFP8EWN0WtV5nh26mN/lkVla65E0BDFSy4
RKnOW5K5w2ynIjLTuP0ZVwquH7W3QfXl+GEhX4GZzhy3R/9pNDPUj7JQqcLItuJYFveCK38LJTMf
JGSQdvtGJZRPDqdyEy3BZ2E6J+7L4vpx3CDprolO1ejsDL/2eo+VxR8VKuR5D3ADyAk4fXPXhWlT
+pthO9hGPZXApao58rxNi8aHN8S2heUGrJIpoQmXvTuVlqJYmX3pma6qZcLV/Er5l+c8qgsSKkXf
4IZqWECv6g9sBe4Nq+J3D6MK7DkiyPRIm8r2uLR4+84EaR/8DUfA1NdAuHXEUoMqWEu9XEAbPvdS
ZskYK1uU2vw4OAsAvltyvBziEOnmm7LAQ482gMA/aYYpuYvFEIPKl4zDqQtomU5qPTzDEDlmGVFB
YYm6aDiT5EEQ4qGPoASy48vPb6ey/JgpxtehKwWxlfVCKEEkVNUTfq57H01Dfz8zDCvMfYQ8zL1v
C4jU88wGfS4NlSjnwePo0qhHO4eRt5Wk9/gVguLtl2VHwgWbInus03BAR4zcWvaKqJtzcRX/Dcz3
mst4ev/ABsqxTGGjtr9N7JI63IGMItX6952wfQHkJQ4ysjS9/BcNlC6PYNWamllIEEEKRUJ2ZMqv
X9k=
=9yRU
-----END PGP SIGNATURE-----

--RfaFAzNL9k5mf8L2I9SrvVssXgXFCTDvZ--
