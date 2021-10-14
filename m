Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7F42D665
	for <lists+linux-efi@lfdr.de>; Thu, 14 Oct 2021 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJNJtG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Oct 2021 05:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhJNJtF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Oct 2021 05:49:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C22610CC;
        Thu, 14 Oct 2021 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634204820;
        bh=iDTopwqbmzinhy2WDBTM0BLIidMVT/cz6C/ntNs7/Hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PkKUs94XsJkeJMfhunVJx/fHZwkZmlJ2BzzqUDp2+wpiJCjJFAe8k4I9TILwBTIWF
         9g1/Zc4evcPlTW+ZQ9WrsKk+hMGdHh/irjtNFavhAkL6QTDIxo11g+Pso6AplI81cy
         NX863loeIjwt53ifYUJdh4neEFDJgzkBPscP5ar4LKxqzGuOmTVv1a20T5RHRVtXO/
         TEOqatMR8Yo93dIRZ0wXlKdqwdVxUYmT8pgci+7XN2vmC0B66tyTUvfRUOQSlyU8NY
         oZ5d2S6s3mDB07dD3M5xXJUR4jIQYgxC07f3EavqpTb/pJxHn2C6vGEluygxjTxwRg
         gmAFdwlk/mUaQ==
Received: by mail-oi1-f171.google.com with SMTP id n64so7727578oih.2;
        Thu, 14 Oct 2021 02:47:00 -0700 (PDT)
X-Gm-Message-State: AOAM532fMiuwYxM5lVTcp6bW5O5flqcCQOjwxiUvOM2QpbQMPJ6S9LNS
        YqrxokTWFHdtBHFrGnwJTTd6alHgb5C0y+0FAnM=
X-Google-Smtp-Source: ABdhPJxcEjkB0IHaV3b2ZutNR9uVHbuth9q3bNDjrzoMwIcbnBzYNmZ1qBa3e6aI4D2mmHdl/modbyW9//GhLqhmAag=
X-Received: by 2002:aca:32c2:: with SMTP id y185mr12156681oiy.47.1634204820213;
 Thu, 14 Oct 2021 02:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211013200536.1851070-1-willy@infradead.org>
In-Reply-To: <20211013200536.1851070-1-willy@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Oct 2021 11:46:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
Message-ID: <CAMj1kXEJ+RThJ83H2VNAmOKkVdhTAUCUF61u9JTv6ccc9uVTDw@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com, debian-kernel@lists.debian.org,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 13 Oct 2021 at 22:07, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If the config file specifies a signing key, use it to sign
> the kernel so that machines with SecureBoot enabled can boot.
> See https://wiki.debian.org/SecureBoot
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

For the change itself

Acked-by: Ard Biesheuvel <ardb@kernel.org>

although I'd suggest to fix the subject not to refer to Machine Owner
Keys, as I don't see anything shim related here (i.e., if you sign
using a key that is listed in db, it should also work)


> ---
>  scripts/package/builddeb | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 91a502bb97e8..4fa6ff2b5cac 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -147,7 +147,15 @@ else
>         cp System.map "$tmpdir/boot/System.map-$version"
>         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
>  fi
> -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> +
> +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> +if is_enabled CONFIG_MODULE_SIG; then
> +       cert=$srctree/$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> +       key=${cert%pem}priv
> +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> +else
> +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> +fi
>
>  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
>         # Only some architectures with OF support have this target
> --
> 2.32.0
>
