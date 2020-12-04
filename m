Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A702CF2BB
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgLDRIE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 12:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgLDRIE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Dec 2020 12:08:04 -0500
X-Gm-Message-State: AOAM532WzK02qD1l2kDD8y7eWat4ElxS16G6b2XSLpkoxY/YgzfS15oc
        0WRh+iQhJRhex7xKvJt+9fiNT4yRxW416SL9B7o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607101643;
        bh=LCM/l/OFDG8l8JxKXFqzSJTqblII7JKN8AA1VZ/6a8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p53xpbZuyz6nbq3yuE8eYa1fv58U4CFbTFq1qojv4C477/+3g7vnqGEIcmse2jwvP
         uqcIBjN8MVvX4oUd4R/2Kphqx5MIHzAUfvzSQt3TUJrv3QniVTXLxXMin7R48UMdR/
         oYppwCqYW6DsUo9Q2zDCysGVCVYGDaIryPoUhyPobfOM/sRGykTp7Tb12XTwmSZnVt
         RDXPYe3XwiRbDchvuwCzl5iPysftAGyqMDFKuIPPoMAWKB0dQi78C2qM0TyHA4Xn0c
         5vY48MAAC18d+QtQRbmqDm4dJWQHqe3xpVMBp2nAdNt4jJoRYsAHmm8WKI6sutJJqo
         H5vdXycIZOigg==
X-Google-Smtp-Source: ABdhPJy+Vxuhgyy/Mkyy0618OZF1AopKWX0x2kfN3qWuwsouZqkTNwYaHlTMUtJhgFfl8tWADf+5SsnuwX78y+h7e1I=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr4317113otd.90.1607101642942;
 Fri, 04 Dec 2020 09:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com> <20201204170319.20383-8-laniel_francis@privacyrequired.com>
In-Reply-To: <20201204170319.20383-8-laniel_francis@privacyrequired.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 4 Dec 2020 18:07:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
Message-ID: <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
To:     laniel_francis@privacyrequired.com
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com> wrote:
>
> From: Francis Laniel <laniel_francis@privacyrequired.com>
>
> The two functions indicates if a string begins with a given prefix.
> The only difference is that strstarts() returns a bool while str_has_prefix()
> returns the length of the prefix if the string begins with it or 0 otherwise.
>

Why?

> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
>  drivers/firmware/efi/libstub/gop.c             | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index aa8da0a49829..a502f549d900 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -230,7 +230,7 @@ efi_status_t efi_parse_options(char const *cmdline)
>                         if (parse_option_str(val, "debug"))
>                                 efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
>                 } else if (!strcmp(param, "video") &&
> -                          val && strstarts(val, "efifb:")) {
> +                          val && str_has_prefix(val, "efifb:")) {
>                         efi_parse_option_graphics(val + strlen("efifb:"));
>                 }
>         }
> diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
> index ea5da307d542..fbe95b3cc96a 100644
> --- a/drivers/firmware/efi/libstub/gop.c
> +++ b/drivers/firmware/efi/libstub/gop.c
> @@ -39,7 +39,7 @@ static bool parse_modenum(char *option, char **next)
>  {
>         u32 m;
>
> -       if (!strstarts(option, "mode="))
> +       if (!str_has_prefix(option, "mode="))
>                 return false;
>         option += strlen("mode=");
>         m = simple_strtoull(option, &option, 0);
> @@ -65,10 +65,10 @@ static bool parse_res(char *option, char **next)
>         h = simple_strtoull(option, &option, 10);
>         if (*option == '-') {
>                 option++;
> -               if (strstarts(option, "rgb")) {
> +               if (str_has_prefix(option, "rgb")) {
>                         option += strlen("rgb");
>                         pf = PIXEL_RGB_RESERVED_8BIT_PER_COLOR;
> -               } else if (strstarts(option, "bgr")) {
> +               } else if (str_has_prefix(option, "bgr")) {
>                         option += strlen("bgr");
>                         pf = PIXEL_BGR_RESERVED_8BIT_PER_COLOR;
>                 } else if (isdigit(*option))
> @@ -90,7 +90,7 @@ static bool parse_res(char *option, char **next)
>
>  static bool parse_auto(char *option, char **next)
>  {
> -       if (!strstarts(option, "auto"))
> +       if (!str_has_prefix(option, "auto"))
>                 return false;
>         option += strlen("auto");
>         if (*option && *option++ != ',')
> @@ -103,7 +103,7 @@ static bool parse_auto(char *option, char **next)
>
>  static bool parse_list(char *option, char **next)
>  {
> -       if (!strstarts(option, "list"))
> +       if (!str_has_prefix(option, "list"))
>                 return false;
>         option += strlen("list");
>         if (*option && *option++ != ',')
> --
> 2.20.1
>
