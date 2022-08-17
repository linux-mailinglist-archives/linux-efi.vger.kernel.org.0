Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF6596E75
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiHQMcK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiHQMcJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 08:32:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C15861F5
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 05:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B30B81B73
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 12:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2291C43142
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660739525;
        bh=qNhxJcrxebiLjOSbt0+pup21b3OaGgib68az7l1dANU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U42fas20RP3fCkkEjGMIWT2kmuAG1RsYXfUp0XOw2J+U0R2J9hemdf0XSjmKuazun
         tVbEJZJ4PCrfpLccCsP0Xv1dG2wWKk3LORqRvVEdJpuLiLfRM+UBxAFplW15UWprFu
         A7MV6+OLbSQob5Rq3QYf5j+Bfq4tAAVFnm79uqcf6vtCSQfM0I9tU8Iat/1o+06lsZ
         XsfTPGeIs8I8wuJcfI17kMCeJuiX5UUampSKNUpJ2lwI7OgGMGRhxJ8bpRV4fKwHcQ
         Iij4uweO1F+u9mamfmGEv7x8rCQjE3Y+AS3beSLCwvdPwjPly3bNQPfTcr/4mXnLjL
         7qQdRcS8AnJag==
Received: by mail-wr1-f43.google.com with SMTP id n4so16007232wrp.10
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 05:32:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo234+N1n5sUO+Rbp1B+7dYPXKF0gvIAtTcVhpvnyCJVzcj5w5J/
        SVgRCIvgs5WUIqHBNgpPb1kLtvpYXr+LVTyAJtc=
X-Google-Smtp-Source: AA6agR6KOh8pjZ0irmLE0Kgo65YhPXvRc5lB36+BXNEF4fkf4BauATljs7+pTUztBiHcu9KykLASBdWYmwaGc9geJdg=
X-Received: by 2002:adf:ebd2:0:b0:222:cd3f:cf9 with SMTP id
 v18-20020adfebd2000000b00222cd3f0cf9mr14295167wrn.598.1660739524049; Wed, 17
 Aug 2022 05:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220817110345.1771267-1-ardb@kernel.org> <20220817110345.1771267-5-ardb@kernel.org>
 <CAK8P3a17HJXYhVLou+Xc2tZyLggcmqH-V+9MRjrDHAc0TUYZ2Q@mail.gmail.com>
In-Reply-To: <CAK8P3a17HJXYhVLou+Xc2tZyLggcmqH-V+9MRjrDHAc0TUYZ2Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Aug 2022 14:31:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH2uNfVxFn0ExH_OooS9=F_7PoPgFmTdXWhx9rBcvqgDQ@mail.gmail.com>
Message-ID: <CAMj1kXH2uNfVxFn0ExH_OooS9=F_7PoPgFmTdXWhx9rBcvqgDQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-efi@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 Aug 2022 at 13:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Aug 17, 2022 at 1:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > BZIP2 has been omitted from the set of supported compression algorithms,
> > given that its performance is mediocre both in speed and size, and it
> > uses a disproportionate amount of memory. For optimal compression, use
> > LZMA. For the fastest boot speed, use LZO.
> ...
> > +config EFI_ZBOOT
> > +       bool "Enable the generic EFI decompressor"
> > +       depends on EFI_GENERIC_STUB && !ARM
> > +       select HAVE_KERNEL_GZIP
> > +       select HAVE_KERNEL_LZ4
> > +       select HAVE_KERNEL_LZMA
> > +       select HAVE_KERNEL_LZO
>
> I hope I don't turn this into a bike-shed discussion, but it feels
> like if you give
> the choice between these four, you should also offer ZSTD, which combines
> high compression ratio with fast decompression speed.
> XZ is probably more widely installed than LZMA.
>
> I would be happy with just gzip (to minimize build dependencies) and
> zstd, but there is little harm in also including the other ones you have
> here, or all seven of them.
>

Let's add whatever people feel is useful. The reason I dropped bzip2
is because it uses much more memory. This is not a problem per se, but
it seemed pointless to accommodate bzip2 if we have better options
anyway.

zstd seems trivial to add if i bump the heap size to 256k, and xz just
needs a little tweak so it doesn't redefine memmove and memcpy, but
beyond that, it's just copy/paste'ing the pattern another couple of
times.
