Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB07375364
	for <lists+linux-efi@lfdr.de>; Thu,  6 May 2021 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhEFMDE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 May 2021 08:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhEFMDD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 May 2021 08:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCB0A613D6;
        Thu,  6 May 2021 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620302525;
        bh=5Gzv1EgP8ugr8VkNQhYuP2JYCLcGm/i2fZly2+DmE+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZM/C0q2gf2Lqooa0S0tIY/F9qaoR3z5P5rLVOuPRDs1rLPeG5XTVgYQJ+oiJLBRht
         yTsnLbyyN03YtCHad+9m7fReN9mX8XesR6J/V4YUNoE7aC+O48s74f8pDBTAA6om+s
         f9CSHcjXRnADEF3e3niACWCrMc6ndgnwbe9CdTGBDnagaIei0kH5/A/Aw4dk7m4ObK
         HjSxgNA5Kk7tm65mbJXiaqvVEZP4SEZtkx5W07JYYOp+G/jeLKuaCTyzoD7Ae3fbXQ
         GwZ4GW81FQ1QMHva+tkf2pPUHFfHI7YHzIoJZ2kY+HrM9PZfI9ixZNNvilx8MFLUk8
         22aAntxT3XM1Q==
Received: by mail-oi1-f177.google.com with SMTP id m13so5222452oiw.13;
        Thu, 06 May 2021 05:02:05 -0700 (PDT)
X-Gm-Message-State: AOAM530Kd88UITi7ZAGSkrXTTlJbfe5UoViI7ykmAvA/+cz4IIZLWwaw
        0amBq4NzQFTow6aZnFu1ivtKTT9wVYExkwY2c8I=
X-Google-Smtp-Source: ABdhPJxBqThxkLMkWoBTe7tUxQnHa0Y+jGsCXBVnCURHb+YxWKBmCyBZBelHDQGTkbGVW+KKW0gzug14b7Xpj/tX5Z8=
X-Received: by 2002:aca:e142:: with SMTP id y63mr2839986oig.33.1620302524970;
 Thu, 06 May 2021 05:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210506115813.397657-1-willy@infradead.org>
In-Reply-To: <20210506115813.397657-1-willy@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 May 2021 14:01:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPofJoXVhNribrNhf7ReUvcj_hpox020gboncpj5EPpA@mail.gmail.com>
Message-ID: <CAMj1kXFPofJoXVhNribrNhf7ReUvcj_hpox020gboncpj5EPpA@mail.gmail.com>
Subject: Re: [PATCH] builddeb: Support signing kernels with a Machine Owner Key
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, debian-efi@lists.debian.org,
        debian-kernel@lists.debian.org, efi@lists.einval.com,
        mjg59@srcf.ucam.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 May 2021 at 14:00, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If the config file specifies a signing key, use it to sign
> the kernel so that machines with SecureBoot enabled can boot.
> See https://wiki.debian.org/SecureBoot
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Shouldn't this be conditional on CONFIG_EFI as well?

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
> 2.30.2
>
