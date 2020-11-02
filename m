Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07792A345A
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKBTjd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 14:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKBTjc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Nov 2020 14:39:32 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59253C0617A6
        for <linux-efi@vger.kernel.org>; Mon,  2 Nov 2020 11:39:31 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so4430641ioc.2
        for <linux-efi@vger.kernel.org>; Mon, 02 Nov 2020 11:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPolsNW/zAAbJ+UkM+kxnB1XuZ8Lbiwy2vfx3k7sQlM=;
        b=tiQOre8cy177Vl1NXwD+rWVtyq6rgiM6KUgYxsHNMBuGg81aHGmW/u0+EQdniihZbO
         5gzKqm/eL82h+umS9J1aPghQsIjY38GkDNBV3XgmXaNdPJHJIg995ajc7QWfXt5EwjtB
         JbGWwATh4p4C5eBFWddRdXpaw6l0Mm6K3R3FGTX9j0o7ZZlZQ0FWOwAF0x+nEp4cbfhJ
         x8n15NjaMLQ5tyPC7GLN3FCuOjG9KB+YHTkdHiUtmcME+883W8FJTiiHIy8SERlzl0ur
         uOWIojPaRjwi9d1lYz7nNcBOSPD4Sk/CDQGJhyk8iVA3NWc+hCubJ9cX1cX5pIwo9FMN
         JQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPolsNW/zAAbJ+UkM+kxnB1XuZ8Lbiwy2vfx3k7sQlM=;
        b=d+cdscaktj9U8csSJZuLUvUwxqRAoa5LSNbaiSNryuHBvkjBGs17RBMqbkeP1JQsuv
         XskCk7sS/ot1pxhDH8BOFRZQClbisppD2r0lHpdwmJxA0LN8hWs3dR1ait/H+xVsuEEr
         Z1P1rIhRv5REl/MSlZxPERm7D30tJB6m0+xICA+OoxOzuAm1H6EwH7eYtOlB7B6EmlXc
         kbsWIUVqS8xzWf8KWO+7iZ6UZD3oFCUkikH5k7g8W3F/GlPS9X0lyWYBH+xSELE9jvF9
         QXara8kTsQGfOaC8+n4piuBMEOXOsLgoVbojZp+qgdh5zkFJGs3Brl+h9vd/0/pBLGUf
         hvEg==
X-Gm-Message-State: AOAM532kxHJizsx/9yivCpCG01OBJh24sBc4DeKmWadSlj4miE+QgwJv
        cJQqB814KD44olwLhhguMuWCKntPdObYjA0doNSGxjK4bb8=
X-Google-Smtp-Source: ABdhPJzdCkM+KM1lnUKLBzZCp0zlDwHobk6GAAk3NzfCBuvyjuxhiGUvOeSj44QE5zCpL7AxwObDv7pxXl8OuMk9eRU=
X-Received: by 2002:a02:cc77:: with SMTP id j23mr11373434jaq.20.1604345970427;
 Mon, 02 Nov 2020 11:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20201102170634.20575-1-ardb@kernel.org>
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Nov 2020 11:39:19 -0800
Message-ID: <CACdnJuvC3EjQb5ZfOBynNzMPOwUm3w5CnXDCYGd10w_AW+_efw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 2, 2020 at 9:06 AM Ard Biesheuvel <ardb@kernel.org> wrote:

> This is posted as an RFC since it is mostly an invitation to discuss how
> we can fit this into a longer term strategy for arch-agnostic secure and
> measured boot that does not hinge on the Shim+GRUB tandem, or on deep
> knowledge on the part of the bootloader regarding device trees, bootparams
> structs, allocation and placement policies of various artifacts etc etc

My initial concern was that we'd potentially do double measurement if
a separate bootloader loaded the initrd and then called the EFI entry
point, but it looks like you'll only measure if the stub loaded the
initrd itself, in which case this seems fine.

> Open questions:
> - Should we do this?

I think so. The initramfs is clearly part of our initial TCB.

> - Are Linux systems in the field using PCR value prediction when updating the
>   initrd? Does this approach interfere with that?

I'm not aware of any distro that's tried to solve this problem. I do
have an idea for how to (basically, build a generic initramfs and then
allow the bootloader to override specific configuration files - grub
has support for reading files and creating an additional cpio on the
fly), but handwave.

> - Which PCR and event type to use

Grub is measuring the initramfs (and all binaries) into PCR 9 with EV_IPL.

> - Is a separator event needed here, given that the initrd measurement is
>   recorded even if no initrd was loaded by the stub?

I think probably, but we should probably have a longer discussion
around when we should be logging separators (grub doesn't generate any
at the moment, and I don't think shim does either, and that's
definitely suboptimal for the PCR 7 case). We should probably look at
what Windows is doing here.
