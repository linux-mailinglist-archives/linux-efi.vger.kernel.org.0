Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B544844FB
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiADPoV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 10:44:21 -0500
Received: from condef-01.nifty.com ([202.248.20.66]:44652 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiADPoV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Jan 2022 10:44:21 -0500
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-01.nifty.com with ESMTP id 204Fewe0003795
        for <linux-efi@vger.kernel.org>; Wed, 5 Jan 2022 00:40:58 +0900
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 204FeZ83025435;
        Wed, 5 Jan 2022 00:40:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 204FeZ83025435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641310836;
        bh=DugniExp2XmgLl7ZzfeuQ1Apx6MUJTA6MNRLje4FSnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wfkpwjQNUXgqtfaBO2x0igGFWj/mss3d3tVx063RGEUhBS+12Nsyt/RKTcLku6VMA
         cfyD6SYCIaoE/MYSv0Ov9sEW+ngUfa5MAKKU5m+x3S7N2SWLZE8EYEYnBoZWO4dDhz
         ivGfBUlAtODhITCovvOJ+cQy4DjwSEzpm8iOo7NLei5zziYRkcGxRNeXNToixaCfUO
         1NXTSTqPtebvQ58Wx2vV8LWdebo0BLBmz510nkPgTn/MrL/wwLxXvD+sj4pZWc5kW5
         8U1oQ8EFRz/sX2/FI2TzFZqwS3tuBsFvqURiTPQ6hGO2J3DbwrBPD+IS3fG66r6wV0
         hYgog4OjXr45w==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id 205so32583564pfu.0;
        Tue, 04 Jan 2022 07:40:35 -0800 (PST)
X-Gm-Message-State: AOAM532VCyCNrdUzlLbrewLzQlE+814KKU7OsH9wwHGjry/jd5VVHr+f
        Gv571brAn3yt1bfl0s+WnJB+0xCLwcG1MU4nuEQ=
X-Google-Smtp-Source: ABdhPJyhXYYQVBVnRK8+v8MvikdEObQrQhD09k7c68rzG/jmhd4ynmP2j4kUAeZ+ERWFy95lpGKawC962FaMod+Rp/o=
X-Received: by 2002:a63:3753:: with SMTP id g19mr22939727pgn.126.1641310834718;
 Tue, 04 Jan 2022 07:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20211218031122.4117631-1-willy@infradead.org>
In-Reply-To: <20211218031122.4117631-1-willy@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 5 Jan 2022 00:39:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
Message-ID: <CAK7LNAQUChvX3NoukBnjBfJJGu+a96pfbM--xHEHOygWPgE9eA@mail.gmail.com>
Subject: Re: [PATCH v2] builddeb: Support signing kernels with the module
 signing key
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efi@lists.einval.com,
        debian-kernel <debian-kernel@lists.debian.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+CC the maintainers of CERTIFICATE HANDLING
M:      David Howells <dhowells@redhat.com>
M:      David Woodhouse <dwmw2@infradead.org>
L:      keyrings@vger.kernel.org




On Sat, Dec 18, 2021 at 12:11 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If the config file specifies a signing key, use it to sign
> the kernel so that machines with SecureBoot enabled can boot.
> See https://wiki.debian.org/SecureBoot
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2:
>  - Handle private keys stored in the pem file as well as adjacent to the
>    certificate
>  - Handle certificate paths specified relative to both dsttree and srctree
>    (as well as absolute)
>  - Only try to sign the executable if EFI_STUB is enabled
>  - Only try to execute sbsign if it's in $PATH
>
>  scripts/package/builddeb | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 91a502bb97e8..9dd92fd02b12 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -147,7 +147,30 @@ else
>         cp System.map "$tmpdir/boot/System.map-$version"
>         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
>  fi
> -cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
> +
> +vmlinux=$($MAKE -s -f $srctree/Makefile image_name)
> +key=
> +if is_enabled CONFIG_EFI_STUB && is_enabled CONFIG_MODULE_SIG; then
> +       cert=$(grep ^CONFIG_MODULE_SIG_KEY= include/config/auto.conf | cut -d\" -f2)
> +       if [ ! -f $cert ]; then
> +               cert=$srctree/$cert
> +       fi
> +
> +       key=${cert%pem}priv
> +       if [ ! -f $key ]; then
> +               key=$cert
> +       fi


I still do not understand this part.

It is true that the Debian document you referred to creates separate files
for the key and the certificate:
  # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform
DER -out MOK.der -days 36500 -subj "/CN=My Name/" -nodes

but, is such a use-case possible in Kbuild?


In the old days, yes, the key and the certificate were stored in separate files.
(the key in *.priv and the certificate in *.x509)


Please read this commit:


commit fb1179499134bc718dc7557c7a6a95dc72f224cb
Author: David Woodhouse <David.Woodhouse@intel.com>
Date:   Mon Jul 20 21:16:30 2015 +0100

    modsign: Use single PEM file for autogenerated key

    The current rule for generating signing_key.priv and signing_key.x509 is
    a classic example of a bad rule which has a tendency to break parallel
    make. When invoked to create *either* target, it generates the other
    target as a side-effect that make didn't predict.

    So let's switch to using a single file signing_key.pem which contains
    both key and certificate. That matches what we do in the case of an
    external key specified by CONFIG_MODULE_SIG_KEY anyway, so it's also
    slightly cleaner.

    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
    Signed-off-by: David Howells <dhowells@redhat.com>




Since then, both key and certificate are stored in a single *.pem file.


The motivation for this change is still questionable to me;
the commit description sounds like they merged *.priv and *.x509
into *.pem just because they could not write a correct Makefile.
(If requested, I can write a correct Makefile that works in parallel build)

But, anyway, as long as I read the current code, we never
have a separate *.priv file.


The help message of the config option supports my view.


config MODULE_SIG_KEY
        string "File name or PKCS#11 URI of module signing key"
        default "certs/signing_key.pem"
        depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
        help
         Provide the file name of a private key/certificate in PEM format,
         or a PKCS#11 URI according to RFC7512. The file should contain, or
         the URI should identify, both the certificate and its corresponding
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         private key.
         ^^^^^^^^^^^



I CC'ed  David Howells, David Woodhouse, keyrings@vger.kernel.org
in case I understood wrong.












> +       if ! command -v sbsign >/dev/null; then
> +               key=
> +       fi
> +fi
> +
> +if [ -n "$key" ]; then
> +       sbsign --key $key --cert $cert "$vmlinux" --output "$tmpdir/$installed_image_path"
> +else
> +       cp "$vmlinux" "$tmpdir/$installed_image_path"
> +fi
>
>  if is_enabled CONFIG_OF_EARLY_FLATTREE; then
>         # Only some architectures with OF support have this target
> --
> 2.33.0
>


--
Best Regards
Masahiro Yamada
