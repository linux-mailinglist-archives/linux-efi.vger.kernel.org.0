Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35ECF3CEEB
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbfFKOhd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 10:37:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35102 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388608AbfFKOhc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 10:37:32 -0400
Received: by mail-it1-f196.google.com with SMTP id n189so5147811itd.0
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0317WyxAHetn0NHNS7xAQoK7fjU4Bd3mmAZamc45khg=;
        b=ngMkOizS56BSDZza15iZDm5M/DEVXntMYcvUuLixdoX2PeyfEJWlPPiXvsLqveMenM
         3Ceol3hAHxIsto5dkisy12B7OUMbuE4IiE+NSD13xCWMhhMzSYBR4VpOXLKxI6OTWMwO
         n8rAQtUx0Jb0oYXhLmSZI4AImlK6gwvGmpwR0b6h8KcI5+mTwFTdY3Zw6HjcizVGOC64
         NsTR2Urbgari4QKganY21zTOrTrrEn2a+PhkaooteMtkhHWoYToQn+n42DvpJ/F/fcd+
         Pz60NJsPwRrKpsz40oLKrAy1U32HDWsa48LcRvaY62dlseYvyZq6OgnKfT2OkZHnPTO8
         KAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0317WyxAHetn0NHNS7xAQoK7fjU4Bd3mmAZamc45khg=;
        b=kjgToQiyxgcgeT5stXe6pHvdL1ZuBDERIBkBg59LHtvihfboc1+Xz3fhOCbeqDWqh4
         hdIdx4VcWHfV3JeKD6+rHeLCKUgguIPWrfJTzdg5ZpPYh76wdg6qpBDMZg6q8kAiuuB5
         qnjakuojhsWn9InfJgYOR0KIiVZVIQp4o+ck1xbu09zuKRrqREb8v7ozjGF/AjdVrRLf
         B/UncRz8Do9TKHib3O0lPsJYxGWnTIaV4qsPwlFpvbb5H73VWX9OpwFK9Idv7gV3lMPx
         Q4OOJ6J2JxHICzV/gcMmK33ybLlYybAduZY6BCaIuoP629WutNOKDxaS/MGPWl2pSmBe
         tuIA==
X-Gm-Message-State: APjAAAU5/ZVnrag7guqhoR6clD+O2ITce/l0pdvhWNZdK3k/6vbtxP+g
        amY+2KWqP07tfuu8b8cbuBLg0B6bCM1pksFtO20fhA==
X-Google-Smtp-Source: APXvYqzP3djssPZsqWAOo+HhK3d3yrF7GY/buRBsZMACgJJGWptbspYa1GgGU0bIpky0yCyTvQOmNxy6YkUGRaxWR3k=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr49518874jar.2.1560263851619;
 Tue, 11 Jun 2019 07:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190529154635.2659-1-hdegoede@redhat.com> <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
 <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com> <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
In-Reply-To: <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 11 Jun 2019 16:37:19 +0200
Message-ID: <CAKv+Gu8_+6MNtM3_muP8YqHYYij58LzRFgV_UPaWp4vbjPkm5w@mail.gmail.com>
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

On Tue, 11 Jun 2019 at 16:24, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11-06-19 16:04, Ard Biesheuvel wrote:
> > On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
> >>> reserved. These bits are now used to indicate if the image needs to be
> >>> rotated before being displayed.
> >>>
> >>> The efifb code does not support rotating the image before copying it to
> >>> the screen.
> >>>
> >>> This commit adds a check for these new bits and if they are set leaves the
> >>> fb contents as is instead of trying to use the un-rotated BGRT image.
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >
> > BTW should we make sure that this patch and the efi-bgrt patch get
> > merged at the same time?
>
> The 2 patches are related but merging them at the same time is not
> necessary.
>
> > I guess the net result is just that we get
> > rid of some error in the log, but a rotated BMP will be ignored
> > otherwise.
>
> Right, worse case (if the bmp fits pre-rotation) it will be displayed
> rotated. Note on the one machine I'm aware of which uses these bits
> the bmp does not fit pre-rotation, so we end up triggering:
>
> error:
>          memunmap(bgrt_image);
>          pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
> }
>

Doesn't that mean we may now end up breaking 'quiet', by exchanging a
pr_notice() in the efi-bgrt driver for a pr_warn() in this one?

> Which this patch replaces with hitting:
>
>          if (bgrt_tab.status & 0x06) {
>                  pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
>                  return;
>          }
>
> Instead. So at least on the one machine I know of this is 99% cosmetic.
>
> > Or is it relevant for userland in some other way?
>
> No.
>
> Regards,
>
> Hans
