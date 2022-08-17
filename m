Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E29596DD2
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiHQLxn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQLxe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:53:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353571C916
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:53:31 -0700 (PDT)
Received: from mail-ed1-f42.google.com ([209.85.208.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRnXY-1nwCtn2PP8-00TFRk for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022
 13:53:29 +0200
Received: by mail-ed1-f42.google.com with SMTP id y3so17163595eda.6
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:53:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo38vvS0QExRyL+vT2i5i4Sb6OW/sRDhTukZ1rj/KDwt4twB2QIU
        2+HZuMDUOU2VKQBgT1EGFKL7vue+qRdEfOVtFp4=
X-Google-Smtp-Source: AA6agR5ZusYFZnvDv014BIRhEHbBXvdnfQ6ZLvUu40QPcEMr3BF8W/ibSF0iWZROYkzFYjXFA9Uu7edSy+kt79jVYnE=
X-Received: by 2002:a05:6402:520e:b0:43d:df14:fbed with SMTP id
 s14-20020a056402520e00b0043ddf14fbedmr23168292edd.16.1660737209216; Wed, 17
 Aug 2022 04:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220817110345.1771267-1-ardb@kernel.org> <20220817110345.1771267-5-ardb@kernel.org>
In-Reply-To: <20220817110345.1771267-5-ardb@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Aug 2022 13:53:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17HJXYhVLou+Xc2tZyLggcmqH-V+9MRjrDHAc0TUYZ2Q@mail.gmail.com>
Message-ID: <CAK8P3a17HJXYhVLou+Xc2tZyLggcmqH-V+9MRjrDHAc0TUYZ2Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qrKp2IR4Y8GzuFlQH6uX7IdoyZVyKutUbl2EgJw6mXSXIeF9YF6
 xm4lKZsehgbar5xcR3P6GXT9gMh9k0D5IzcQvt1aoB9an81gjyjmpN2YShNm26RyPJUbVNg
 Z0+NfnTpzE53gZM0RUX/FubxVZ/4Unu5S5LUu6ltIV0vPhtIl40RxkHpIbpZe6Wy+/QvGLO
 xekTZCyH/lMrNkme2h7Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6m2vZyjHW4=:3yoxVhxh9Dp9sKc3Fj2RUX
 T09E+aD8Yz3G/nDb46FGdyfjnB5HBpnQ53RcCO2wqfsdhFplaTnTpvTu9EJU/HjKC++H7pQeE
 MXI5FCcK0v+YYn+KRXeiTJWDiI1QwBhljMYIPB/QBZbBXZ6w/Zig809o7yHVVaZ4iysbmNupa
 LJA1ncMu5M3Pmy7ignuQ7scZLDHw2t0g37rtGShfckMaGw1t7wlmICqjzV65gYK/bVpWtSnK3
 Ax2p2CSWajelPyRD3p1nH6sqjIuRCxoKETNJl2fW6pUp4KzXfawWQ/D6CGTC1YAnBd6KBO4by
 9wlIpIvWDiJBlwY0LqgOj6I5l82IsqQUkCKlc3VTo3ApWYgjey6ar8j5l2MZcxrZOdnIHP013
 6SzGGFHovpG8h2HgFuxOfqOdvYEKiAHvcircpX3BeSyCkiIOQ6fjicvHEwsNJvZ6RGw3RK6Gj
 1AIVkTPul2+QYZRXcSrzJFd90g873vMXeX1so/J3Krd1Z/0RJvzR8kMrV6Wzp1ZqSbFoZTYcO
 q94NwCS982BBpq5oEV9+D267bCgFueKehHEHQPZ2E2ji4k5KaqSJ7IZTAC9NbeBkazWAl52Wm
 GOoLKicvmMPNU7ldeGRd70Z5GmizEmLsltccNX8mwR/10r9eUeVJQBhRpp1Hpw56xDd3ej8cN
 s3cm3o02vsv4e3xnkHLajWD8w5uTkDZSVLkWvB2Gi7dmFEgJjIjmQJmutPHXE/5zYa7smZreO
 LkvnpniB5el8wk+o6ivqDEo1dbMsnNdv+I86GCjd/zV8dRSQeUajDHeuMUH+lTzvqMHpFCi21
 gkP4eONA0hcToLpJm/u1Rk0UozfzfiqGkGuKnHgVJkqrkZ+pUFbJyXHytS3SfT7Ek+5Q0m+fT
 YXPBa04WzZUJ1m+fyyWA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 17, 2022 at 1:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> BZIP2 has been omitted from the set of supported compression algorithms,
> given that its performance is mediocre both in speed and size, and it
> uses a disproportionate amount of memory. For optimal compression, use
> LZMA. For the fastest boot speed, use LZO.
...
> +config EFI_ZBOOT
> +       bool "Enable the generic EFI decompressor"
> +       depends on EFI_GENERIC_STUB && !ARM
> +       select HAVE_KERNEL_GZIP
> +       select HAVE_KERNEL_LZ4
> +       select HAVE_KERNEL_LZMA
> +       select HAVE_KERNEL_LZO

I hope I don't turn this into a bike-shed discussion, but it feels
like if you give
the choice between these four, you should also offer ZSTD, which combines
high compression ratio with fast decompression speed.
XZ is probably more widely installed than LZMA.

I would be happy with just gzip (to minimize build dependencies) and
zstd, but there is little harm in also including the other ones you have
here, or all seven of them.

        Arnd
