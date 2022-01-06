Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566274862D7
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 11:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiAFKVE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 05:21:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38206 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiAFKUu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 05:20:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40EA1B8202D;
        Thu,  6 Jan 2022 10:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04EBC36AE5;
        Thu,  6 Jan 2022 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641464446;
        bh=bvhFCaPuW66rtBnoQhDPOh11TxeI8AH9lm/r0BuhecM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mg2cVX9fITgg3+9RZRMnJIBfogV0wrgDfPdDhzXYLPYHR6wYFSHmlIiP7+t5IZxrY
         pBAeXvqUin3DmTuZqaEF70ZgDwwnCz2zmqQrodYMW8UFa6gmxYs8xpXV2ETOsDgg9i
         1FSvR+EWjGIccyQ1BwQEuXAudblVWOLqOaaX/ZJu0sQuxSXR67XJaze89Rxax8/tPc
         U1NzTkD0UpiZoePp0QKQ+PVeJCT0SW8SNWqwAO67uDzQjOB7iCsTHjAmxS2KP3o+A3
         cl8qFxLIeO4QGo0dT0BIPkIIDqMwqIQUF/MAV/HPVZlROLgbV0x3mNRA2ibSHq+hDL
         nfEOofTB68qGg==
Received: by mail-wr1-f51.google.com with SMTP id o3so3769306wrh.10;
        Thu, 06 Jan 2022 02:20:46 -0800 (PST)
X-Gm-Message-State: AOAM5303R8fhpJNGnI0FEcMYT/BoWsewc3sPnf6KSKbB2J8kyMmsPGqJ
        p/Sfx+Unq/SK3mJFZpSJC0PBglQP73UTQrTvZlc=
X-Google-Smtp-Source: ABdhPJxj/wYV+ofmN96AyMtnCSm7C039ZdrKNMSSJ6tYKVKo3ZfMY3d8QaX21/BZ2rsBe347TmDX7IJakCtt9qD7WBE=
X-Received: by 2002:a5d:6210:: with SMTP id y16mr1887155wru.454.1641464445288;
 Thu, 06 Jan 2022 02:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20220105183716.2841210-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220105183716.2841210-1-gregkh@linuxfoundation.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Jan 2022 11:20:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFqu7hkVt-RCh-DU8ZbOfi2e3ZZ-AEJvLLFZd=FG45pvw@mail.gmail.com>
Message-ID: <CAMj1kXFqu7hkVt-RCh-DU8ZbOfi2e3ZZ-AEJvLLFZd=FG45pvw@mail.gmail.com>
Subject: Re: [PATCH] efi: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 5 Jan 2022 at 19:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the firmware efi sysfs code to use default_groups
> field which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Queued up, thanks.

> ---
>  drivers/firmware/efi/efivars.c     | 3 ++-
>  drivers/firmware/efi/esrt.c        | 4 +++-
>  drivers/firmware/efi/runtime-map.c | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index e6b16b3a17a8..ea0bc39dc965 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -352,11 +352,12 @@ static struct attribute *def_attrs[] = {
>         &efivar_attr_raw_var.attr,
>         NULL,
>  };
> +ATTRIBUTE_GROUPS(def);
>
>  static struct kobj_type efivar_ktype = {
>         .release = efivar_release,
>         .sysfs_ops = &efivar_attr_ops,
> -       .default_attrs = def_attrs,
> +       .default_groups = def_groups,
>  };
>
>  static ssize_t efivar_create(struct file *filp, struct kobject *kobj,
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index d5915272141f..2a2f52b017e7 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -146,6 +146,8 @@ static struct attribute *esre1_attrs[] = {
>         &esre_last_attempt_status.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(esre1);
> +
>  static void esre_release(struct kobject *kobj)
>  {
>         struct esre_entry *entry = to_entry(kobj);
> @@ -157,7 +159,7 @@ static void esre_release(struct kobject *kobj)
>  static struct kobj_type esre1_ktype = {
>         .release = esre_release,
>         .sysfs_ops = &esre_attr_ops,
> -       .default_attrs = esre1_attrs,
> +       .default_groups = esre1_groups,
>  };
>
>
> diff --git a/drivers/firmware/efi/runtime-map.c b/drivers/firmware/efi/runtime-map.c
> index ad9ddefc9dcb..92a3d45a795c 100644
> --- a/drivers/firmware/efi/runtime-map.c
> +++ b/drivers/firmware/efi/runtime-map.c
> @@ -79,6 +79,7 @@ static struct attribute *def_attrs[] = {
>         &map_attribute_attr.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(def);
>
>  static const struct sysfs_ops map_attr_ops = {
>         .show = map_attr_show,
> @@ -94,7 +95,7 @@ static void map_release(struct kobject *kobj)
>
>  static struct kobj_type __refdata map_ktype = {
>         .sysfs_ops      = &map_attr_ops,
> -       .default_attrs  = def_attrs,
> +       .default_groups = def_groups,
>         .release        = map_release,
>  };
>
> --
> 2.34.1
>
