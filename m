Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0372168D40
	for <lists+linux-efi@lfdr.de>; Sat, 22 Feb 2020 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBVHhp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 02:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgBVHhp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 22 Feb 2020 02:37:45 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B37024673
        for <linux-efi@vger.kernel.org>; Sat, 22 Feb 2020 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582357064;
        bh=wwlcvLyUUjq+aCUhLUkAhHiYjSH4uxAtpnE4vgF+h+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sde1d7C2Mjm5LUHGg8qaINBz5JTdkBfBVrrLfsWGpon33qFPiE/ee/UOtpXKaJU6b
         JUmiiHm+dNfZJAYZYLPWDvCawpz4J8r21Z4cdbveVj32CVYxIg6nmgLiidgfRSy4eU
         0giwVyyBDBzF7qhezjrG2J6RzGKmKwFQqALnjHkg=
Received: by mail-wm1-f45.google.com with SMTP id m10so6751164wmc.0
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 23:37:44 -0800 (PST)
X-Gm-Message-State: APjAAAVm0byOLIMkDJnsLPHu00w5Wcc4HZh69EDzCkgAnCYH8yErv6yb
        TNwdbpN/fjITyhZz3m8zH4TYXIWv+CnFvKSbVHwu7A==
X-Google-Smtp-Source: APXvYqzLEqjaOCEz1rffDgh/i9rxHLaVrhkmq+aVjKgFm+xgANVXwtlOL9ob2zJTeWHA7/jtQHU14ap2WODxfLZ++eY=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr9246324wmk.68.1582357062812;
 Fri, 21 Feb 2020 23:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com> <20200222014038.180923-4-saravanak@google.com>
In-Reply-To: <20200222014038.180923-4-saravanak@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Feb 2020 08:37:31 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8GtHQpFGM5U61uH86dnesnaVCkvqrPA6Y8wv4qRc8V4A@mail.gmail.com>
Message-ID: <CAKv+Gu8GtHQpFGM5U61uH86dnesnaVCkvqrPA6Y8wv4qRc8V4A@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] efi/arm: Start using fw_devlink_get_flags()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 22 Feb 2020 at 02:40, Saravana Kannan <saravanak@google.com> wrote:
>
> The fw_devlink_get_flags() provides the right flags to use when creating
> mandatory device links derived from information provided by the
> firmware. So, use that.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  drivers/firmware/efi/arm-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index d99f5b0c8a09..6703bedfa9e1 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -349,7 +349,7 @@ static int efifb_add_links(const struct fwnode_handle *fwnode,
>          * If this fails, retrying this function at a later point won't
>          * change anything. So, don't return an error after this.
>          */
> -       if (!device_link_add(dev, sup_dev, 0))
> +       if (!device_link_add(dev, sup_dev, fw_devlink_get_flags()))
>                 dev_warn(dev, "device_link_add() failed\n");
>
>         put_device(sup_dev);
> --
> 2.25.0.265.gbab2e86ba0-goog
>
