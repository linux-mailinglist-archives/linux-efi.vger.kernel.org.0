Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E342B4A1E
	for <lists+linux-efi@lfdr.de>; Mon, 16 Nov 2020 16:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKPP52 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Nov 2020 10:57:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45419 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgKPP51 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Nov 2020 10:57:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id k19so10649382oic.12;
        Mon, 16 Nov 2020 07:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0EALgO/iHdkJfCGgD7QPEg0Ns+sovLzKtBhiiye9yc=;
        b=GEG1JXD1xFDHwLqBfktkhibBPunMuy9lSd1mV9y9Xl+sXRXYTDEsD/mmfdPfklEQD0
         7+jCHtpwKdrawdWNjcdqMvr19JvcT4kY0aOR4V8haw+/DqdnQB9ddfr9rUfNuN/aDduf
         q5XQb9R4ygo1cnRLQJIhhN8RSmPYWcC1rY0ty529TGGHezvjR/Ve07gSRLwX1qoYAFAr
         zKT8pTExo0cM4u7LnDy1pajmRWGH/vSA0y30zZ2HmFzPXcq/NKqx5lV1BOg5kb34W1ml
         owAm4SL+oGu7i4kCe6TyggntWYQVFSiLZmrcCw73ljkaT/p+tiYJFt8392987/SYrlRl
         otNg==
X-Gm-Message-State: AOAM531dcQMWUwMAnT4JcFyCRc5oqwkIglgMDoULAXsDe+wsr1CFZ67d
        X7dBN6HOQ7UJ+3WG0BHX5tMbpRQ9dryFjoAuAFs=
X-Google-Smtp-Source: ABdhPJwWZwAQFC3+TfMVq7Mp20QMGFtCLh1JEt1ACvAt6CB+xKVyxfDezXlr6XYrO/QfmP3uWddeWGq7i2O+RgNMlig=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr69296oif.69.1605542246780;
 Mon, 16 Nov 2020 07:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com> <20201104232356.4038506-10-saravanak@google.com>
In-Reply-To: <20201104232356.4038506-10-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 16:57:15 +0100
Message-ID: <CAJZ5v0h31RrsrU4F1tjZKQ1O8BFWtkDJxkwyWoKBzm_kyknxVQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/18] driver core: Allow only unprobed consumers for
 SYNC_STATE_ONLY device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> SYNC_STATE_ONLY device links only affect the behavior of sync_state()
> callbacks. Specifically, they prevent sync_state() only callbacks from
> being called on a device if one or more of its consumers haven't probed.
>
> So, creating a SYNC_STATE_ONLY device link from an already probed
> consumer is useless. So, don't allow creating such device links.

I'm wondering why this needs to be part of the series?

It looks like it could go in separately, couldn't it?

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1a1d9a55645c..4a0907574646 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -646,6 +646,17 @@ struct device_link *device_link_add(struct device *consumer,
>                 goto out;
>         }
>
> +       /*
> +        * SYNC_STATE_ONLY links are useless once a consumer device has probed.
> +        * So, only create it if the consumer hasn't probed yet.
> +        */
> +       if (flags & DL_FLAG_SYNC_STATE_ONLY &&
> +           consumer->links.status != DL_DEV_NO_DRIVER &&
> +           consumer->links.status != DL_DEV_PROBING) {
> +               link = NULL;
> +               goto out;
> +       }

Returning NULL at this point may be confusing if there is a link
between these devices already.

> +
>         /*
>          * DL_FLAG_AUTOREMOVE_SUPPLIER indicates that the link will be needed
>          * longer than for DL_FLAG_AUTOREMOVE_CONSUMER and setting them both
> --
> 2.29.1.341.ge80a0c044ae-goog
>
