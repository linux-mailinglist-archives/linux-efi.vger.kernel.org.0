Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940D43D6FF3
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhG0HGR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 03:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235812AbhG0HGG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Jul 2021 03:06:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF3FE6120F;
        Tue, 27 Jul 2021 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627369567;
        bh=1TC/Az3GWgRQRVEMAdi/3rlrGgY9/Gln3X8vwmTmv+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e18QTB8FQVC/Pcu8BKEZpNDao+wOja4eIGe8ORUkTz/5mu433x3r6MlAyEWpROJ7F
         lPOWO39RR4IIDbnnuKaaI9sbAPOS02dGWl3ugYBcXWXhjlCfZCau+i28gehAVHRurC
         ErRp9qtzBgvGOfh8n4ms+39n3D4UDBVQ8uLGZMjQJLXq7BaVtujRLCD0g0voQadJOt
         MyfiFP96UN7corSNOUr/x4HmBuJbjLUDTMrFjiU9aOsiTqDiVYxH92I6aZHAj56STi
         OWHn+SOyClwoEmCRovJsScZBOkuQCoRtjySbpK5x0SqwtFAVY/GMK8nKo9xY2QM0Qe
         2y95Khxudlecg==
Received: by mail-ot1-f42.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so7860275ota.11;
        Tue, 27 Jul 2021 00:06:06 -0700 (PDT)
X-Gm-Message-State: AOAM530hZV/K2AdwOP3jL0M4uCNKLBqDBSKaXyj7R5WrSlhbaOhgmtyx
        CndFUGhnUilHubfVw1w9iYnYK0pA+BvCuC+znd8=
X-Google-Smtp-Source: ABdhPJyeFgKOXhjrhvnFpEn730k8SbaVAr5F9/F0Cu8OnIZQ5j5sVRC5iYB6Y0/6aKl/ASZH0k9HGhADS98rRGUq0Bk=
X-Received: by 2002:a05:6830:34a6:: with SMTP id c38mr14149146otu.108.1627369566333;
 Tue, 27 Jul 2021 00:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210727050447.7339-1-rdunlap@infradead.org>
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jul 2021 09:05:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE--e+XYVMR=i0_hWQ8TZD7a+OshxsuHbbAf6UZwH4=XA@mail.gmail.com>
Message-ID: <CAMj1kXE--e+XYVMR=i0_hWQ8TZD7a+OshxsuHbbAf6UZwH4=XA@mail.gmail.com>
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 27 Jul 2021 at 07:05, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When # CONFIG_EFI is not set, there are 2 definitions of
> sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
> and the __init function from sysfb_efi.c should not be used.
>
> ../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of =E2=80=
=98sysfb_apply_efi_quirks=E2=80=99
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
>              ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
> ../include/linux/sysfb.h:65:20: note: previous definition of =E2=80=98sys=
fb_apply_efi_quirks=E2=80=99 was here
>  static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
>                     ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-next@vger.kernel.org

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/sysfb_efi.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
> +++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
> @@ -332,6 +332,7 @@ static const struct fwnode_operations ef
>         .add_links =3D efifb_add_links,
>  };
>
> +#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> @@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
>                 pd->dev.fwnode =3D &efifb_fwnode;
>         }
>  }
> +#endif
