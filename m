Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119493B81A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2019 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbfFJPMu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jun 2019 11:12:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36936 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389322AbfFJPMu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jun 2019 11:12:50 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so13695775itl.2
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2019 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDSWhJFvFSpMRIQjv3sV2z7AOFrUltYdK5kocBGrXwg=;
        b=GU+MWaZ2efR/e1wZuprMJhPrNYhcWneIGNvL/NAlNQYqm7aMnuF36yZdQD1EQgRIyq
         T7KcjBuaeAZZRzqmZ/2tuSIDUCyCTR+66KLvrlOc+ItZKgdSiEmk6Zp1yWVPbmfthTZY
         XIh0MQzWdBvSFEIKVt6ItUdd/cWwKfmW9xIsBgpvwbbW6p6Wp6CvrXY2w6qGOJBtXNYf
         Eihg/XT98weEi0TtsWCZ3Hz7sPewcPSN2DfMUcCHeeFK7qy8Yx9x0yIYZFj1HT1U0MN6
         diKIXV3oem+g7psOOI6nv5iKKGPKZPzWtVpZWZq8wQx+7LstwWpJOHXr4LQNCeqDr9sQ
         O5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDSWhJFvFSpMRIQjv3sV2z7AOFrUltYdK5kocBGrXwg=;
        b=AnworvWAvSi2LZ40VIjNiZMT0d6CCQJmZgbR/5mDhm4FVSIs20uXPTpKzG9ZLJaODR
         pm3cRsI8ZqX5Ox23Wv8ypOAq7juyBKfl1d1l8aD4Nn1QIoF3+tP/96arn4W4w/4HHy3S
         Cl39TCVlKcRqkDa3im2xehZOBk37DucXdWOukGr7YuIQcTWubNlch1DBWeR1XVK54n2G
         JfQ0V+voZsZfCqFNDA3yps55UdhBf9XiMqoxD3cFq2s0sGQLXlFgB/+uUhhZFPIbwQO2
         j5p+mavf1T18tsLG1IhdBFf4TMdVFFtAZkBe2J8N8E74Jyq5oQCs3oudrmUfMhSQgmXd
         S/3Q==
X-Gm-Message-State: APjAAAUHHuNmKUXA5UHZNaw7C0BEY7OoOWcBh5oC/2jGUtYQ/us8tTkA
        eUvyN09cbvBh27FLqZSF4d9xWNaD1rptK6WWKjqQDw==
X-Google-Smtp-Source: APXvYqzBLvoymnSF+owavozveFKM8hqJFa6AZ7Uaq97rs/+7MNKLbvwxRoxDS/z5WedMnK5dJwe1jjMY2MUJc2N9kKU=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr13126351itl.153.1560179569891;
 Mon, 10 Jun 2019 08:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190529154635.2659-1-hdegoede@redhat.com>
In-Reply-To: <20190529154635.2659-1-hdegoede@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 17:12:37 +0200
Message-ID: <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
> reserved. These bits are now used to indicate if the image needs to be
> rotated before being displayed.
>
> The efifb code does not support rotating the image before copying it to
> the screen.
>
> This commit adds a check for these new bits and if they are set leaves the
> fb contents as is instead of trying to use the un-rotated BGRT image.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/video/fbdev/efifb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 9f39f0c360e0..dfa8dd47d19d 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -169,6 +169,11 @@ static void efifb_show_boot_graphics(struct fb_info *info)
>                 return;
>         }
>
> +       if (bgrt_tab.status & 0x06) {
> +               pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
> +               return;
> +       }
> +
>         /* Avoid flashing the logo if we're going to print std probe messages */
>         if (console_loglevel > CONSOLE_LOGLEVEL_QUIET)
>                 return;
> --
> 2.21.0
>
