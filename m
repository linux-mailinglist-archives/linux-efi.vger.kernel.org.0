Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CB13745C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgAJRGm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jan 2020 12:06:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34240 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAJRGm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jan 2020 12:06:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so2481905oig.1
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2020 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvMAZULjd+t6Z1IO7z3EeS0cYq8ZxzqfzhGty4Nz4qY=;
        b=FLgSitm39FYTcLuYRbsNts/aWHg4GhaKLHHRjdAR3hIJ0fpmEXM0Fi4fexFJOoxA2J
         q2WQ4hWQF6dKtx3BO8Y7AI+Jtfq7MrcV/yPV85pBLruRheP4hQjKvEOaoN1GdK1WmfKq
         BEZOjFehnKvUcDmI0W3Q/mIM132ofPkXXU7ZSj3eQbQwHJuDvwEfa9WTsn0ViS+AcuYf
         ZUFLD/xe63G7PvgoJwkNgzjuv9E20OGDGHHXpLe320K8yA371dMrbt8nNX41a+4DrdX6
         D2vD3NiCfmZrOHScFrHjpR9twekkziWZlmLFMLyZehlmk1hk7MX5q3+c8oI8zCw0vfS2
         fz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvMAZULjd+t6Z1IO7z3EeS0cYq8ZxzqfzhGty4Nz4qY=;
        b=Zs7CCLBgR+HDZG9HAN3NoUY391pJ/ot35Q/sO7+NrsQRyFTYcueFIFTyH7b5y5algP
         qZFlM8fGAzv6+F53im1XEVg36mWtmsXAppCON+8hCXdjDaE0uCnC+oG/2VfgJqz1/qla
         Vdk8pQNv+ezsDqXyOtYbEFw/+/2Ond9gygPJ1g0bfoLUjvCFQEm2Rt2f31uWWG0mlYr4
         JRlUPcBUH6u5i/Qs/UOGOm5wKEeBxFG+D2H3/o0c6onRS9iMAnZG/TYp4x2odtDp1KFU
         JpM0+8YGTh1uBj0A5XnUOX2zTpcKQbyLotGyllc3BT0gvCefUjVxpSLqq4Jh8PLWDsox
         je0Q==
X-Gm-Message-State: APjAAAU/PEegDVnTytWuqfLXETax8M0g0WkbX8BeNdBRLm8H4qdbKAbI
        3t+VTOHROJLbES9RngjXlCHzgusOfTY1VeEgBUsAOw==
X-Google-Smtp-Source: APXvYqyg7WZSXB3wuilNJnIu0C1IW78TPsLDLu18fcxaEb8Xn+gwyErSQsJTAKiUpgwEXjnUDONAJqMuf2ylZ6GlMDE=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr3103294oih.30.1578676001225;
 Fri, 10 Jan 2020 09:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20200110030112.188845-1-saravanak@google.com> <CAKv+Gu-4jvME3cuPBDtTVFn+-ZzttneFuBkor+N3G0JpeO4BzA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-4jvME3cuPBDtTVFn+-ZzttneFuBkor+N3G0JpeO4BzA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Jan 2020 09:06:05 -0800
Message-ID: <CAGETcx9b03SBKMcN7AokSOFRfVnr9G=vzSA4p5BXnmGPQ8JjHw@mail.gmail.com>
Subject: Re: [PATCH v3] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 9, 2020 at 10:41 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 10 Jan 2020 at 04:01, Saravana Kannan <saravanak@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The new of_devlink support breaks PCIe probing on ARM platforms booting
> > via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> > PCI device. The reason is that the probing order gets reversed,
> > resulting in a resource conflict on the framebuffer memory window when
> > the PCIe probes last, causing it to give up entirely.
> >
> > Given that we rely on PCI quirks to deal with EFI framebuffers that get
> > moved around in memory, we cannot simply drop the memory reservation, so
> > instead, let's use the device link infrastructure to register this
> > dependency, and force the probing to occur in the expected order.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >
> > v1 -> v2:
> > - Rewrote the device linking part to not depend on initcall ordering
> > v2 -> v3:
> > - Added const and check for CONFIG_PCI
> >
>
> Thanks. I've queued this version in efi/next for v5.6

Awesome, thanks!

-Saravana
