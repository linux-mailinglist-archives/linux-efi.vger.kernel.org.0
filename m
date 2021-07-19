Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31A13CCC74
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhGSDCU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 18 Jul 2021 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDCS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 18 Jul 2021 23:02:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C94C061762;
        Sun, 18 Jul 2021 19:59:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l1so21762180edr.11;
        Sun, 18 Jul 2021 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pw/ymT7jTI4vbe9EaHsLlpbaG3qADekUdaOoeZi9DCI=;
        b=N6dvNJGmplWlVHUfqKxCiO2YRlq9xOWASWYoxMFmKqo8XQSvSmc/KzvxC5n5K3/qcC
         mXivOogsUDIFmfvM1VFQcoltPPbrVhryDHWYIzFjFxCpL1KwD+m88meKroRfJ98DeAO4
         rYuKsPmdg4byYvJ7UNo3h9AWz8WOiGUbwRTuNuht/WjMsSDu2Tn1KS1+AzadNNr6kz2B
         Z0xBg3B8qB8mzBjxQS/subjiXw5ND9R8DH/+LN4g0hHJATcXWeqUjtCgAz0n3yAw7Mes
         AvMCR0txSFHoIfw+m9F3cbKHbZ8/zpprDfcBNywDMH+VQUf8VJcG137+oFoelGqFfHB6
         PUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pw/ymT7jTI4vbe9EaHsLlpbaG3qADekUdaOoeZi9DCI=;
        b=rsZEL9uGzMYq82e+I6CPC2RXqA1WHJ/kAT0MZFGh0A9PX4jpGHIyqrb1chcT68/kEi
         2JjgcHQsOlx4Lj71aDd6zkS65r+gCnPR33gjg/YT5eax7JNscICm5Z5sXRRt/WgzeNx4
         e0qIRha5rqKSXbS+2m4jwAYV+d9Y/0ySiTiLLXGN6GZ0arIY8MpLdDDOWouiaSB9c2dJ
         3uQ2a3ULzM+MOL8iA808YDzSMb3Iv3IcncaLFAAq+9uDRhAWOin6VHSCbbMBDfOsQc9q
         awSSBZFBsavggRTbDWpZGQV3CXJmiidzbhHk/dVVJxdYFT0RFzyavKRbwEGsDXxB3ju4
         7RvA==
X-Gm-Message-State: AOAM533BbgU5io6rAYB7BLUuzY2z6NlD8drEGO7GVSail77rjtOpYDzm
        JYpqOL7IgM/ta/ywOECOVKQLZYhyFsjbUqjwC9k=
X-Google-Smtp-Source: ABdhPJzDYG5f7P7jdkKSk8KghE2W4nVdpPNwQo3VTesZyc9brB+mQqwde7gjS7CS/C495OdoAgptMS7+b1KWthjJxgU=
X-Received: by 2002:a05:6402:291a:: with SMTP id ee26mr31661153edb.220.1626663557377;
 Sun, 18 Jul 2021 19:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210625130947.1803678-1-javierm@redhat.com> <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
In-Reply-To: <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 19 Jul 2021 12:59:06 +1000
Message-ID: <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Atish Patra <atish.patra@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Jul 2021 at 18:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 13.07.21 um 18:59 schrieb Javier Martinez Canillas:
> > On 6/25/21 3:09 PM, Javier Martinez Canillas wrote:
> >> The simplefb and simpledrm drivers match against a "simple-framebuffer"
> >> device, but for aarch64 this is only registered when using Device Trees
> >> and there's a node with a "simple-framebuffer" compatible string.
> >>
> >> There is no code to register a "simple-framebuffer" platform device when
> >> using EFI instead. In fact, the only platform device that's registered in
> >> this case is an "efi-framebuffer", which means that the efifb driver is
> >> the only driver supported to have an early console with EFI on aarch64.
> >>
> >> The x86 architecture platform has a Generic System Framebuffers (sysfb)
> >> support, that register a system frambuffer platform device. It either
> >> registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
> >> VGA/EFI FB devices for the vgafb/efifb drivers.
> >>
> >> The sysfb is generic enough to be reused by other architectures and can be
> >> moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
> >> logic used by non-x86 architectures to be folded into sysfb as well.
> >>
> >
> > Any more comments on this series? It would be nice for this to land so the
> > simpledrm driver could be used on aarch64 EFI systems as well.
> >
> > The patches have already been acked by x86 and DRM folks.
>
> Time to get this merged, I'd say. People are asking for these patches
> already.

Can we just merge via drm-misc and make sure the acks are present and
I'll deal with the fallout if any.

Dave.
