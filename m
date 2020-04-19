Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312D81AF9B8
	for <lists+linux-efi@lfdr.de>; Sun, 19 Apr 2020 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgDSL7s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Apr 2020 07:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgDSL7s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 19 Apr 2020 07:59:48 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A05421841
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587297587;
        bh=SDmGQo6LVmIVqHTMkoK2IArJhLPdejelbmJnlz5TjIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=umOKEUC9cmVkMg8q3cvMGAF5pkGKghmSNvZNkr0nYRRntEKbOGF81QUrAnNuLf/VA
         amME1jYdKdN0GwI4k9qbmpxCx4WypxqGtB3OD3L2cqb07kGKmizOO7CpxLCfLiYf3+
         CrohUwRxXt0lJW7gEcy0c+jRVxgdtmtvPXsQ51pM=
Received: by mail-io1-f44.google.com with SMTP id i19so7602820ioh.12
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 04:59:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuZIt9XdBL4L+fNC3dLwxUqMr7ubPRQaJYraQhlvc4UDgvGpWc+5
        m768mV7KV3tyWgIJmEW1klh4oNPGCmS1mrJHQMk=
X-Google-Smtp-Source: APiQypLWjYwoVyovWqwN68OxEGXu+UZ6LxA7/gV6kBDlo7bmj7kH5S1YZcedTJPGc9Bp59eM/8OA1Y036N8hDozMfq0=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr11266947iot.161.1587297586769;
 Sun, 19 Apr 2020 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <bf17f4c7-f7a8-01c1-f7a9-bf0a499c502c@redhat.com>
In-Reply-To: <bf17f4c7-f7a8-01c1-f7a9-bf0a499c502c@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 19 Apr 2020 13:59:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEdjqph0d96o6j=avT+Zt41ibegiyTKHK+RCmGaZVeTpA@mail.gmail.com>
Message-ID: <CAMj1kXEdjqph0d96o6j=avT+Zt41ibegiyTKHK+RCmGaZVeTpA@mail.gmail.com>
Subject: Re: Starting with kernel 5.6 deleting efibootmgr entries no longer
 works (efivarfs regresson)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, russianneuromancer@ya.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 19 Apr 2020 at 13:41, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> I got a bug report by email that "grub-install" was throwing errors
> on 32 bit UEFI (64 bit kernel, mixed mode) systems starting with 5.6 .
> After that I noticed that the Fedora installer also threw an error about
> it being unable to setup the bootloader (which I could luckily skip), this
> was also a 32 bit UEFI mixed-mode system.
>
> So I've been running some tests with efibootmgr from the shell. Adding
> new entries works, but removing an entry involves unlinking the EFI var
> for the old which fails, here is the relevant part from a strace run:
>
> unlink("/sys/firmware/efi/efivars/Boot0000-8be4df61-93ca-11d2-aa0d-00e098032b8c") = -1 EINVAL (Invalid argument)
>
> With kernel 5.5 the same unlink succeeds, I guess this is also the
> cause for the grub-install and Fedora 32 installer errors. At least
> the Fedora 32 install error was seen on a system which already had
> a "Fedora" efibootmgr entry, so likely the installer tried to remove
> the old entry first and that caused the failure.
>
> I've also tried removing efibootmgr entires on a 64 bit UEFI system running
> 5.6.4 and that works fine. On 32 bit UEFI mixed-mode systems the problem
> persists with 5.7-rc1.
>
> Ard, any idea where to start with pinpointing the cause of this
> regression ?
>

Can you start by trying this patch please?

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=9461aa3b44ac21668100067939d24a6ffa810eae

It is already in Linus's tree, but not in -rc1
