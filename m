Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0727E169254
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 00:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBVXif (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Feb 2020 18:38:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37779 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgBVXif (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Feb 2020 18:38:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id q23so6066596ljm.4
        for <linux-efi@vger.kernel.org>; Sat, 22 Feb 2020 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6NihziCTyZMAUdv/tajx8t4ufGMIb+wHMLzzNaM6Qc=;
        b=KsM6sFEt0PpXEdyf2g72FHXKriIH7ohllYlnTqE9t2lgHEQ/FgJKQBR/LbvEqGTeH0
         zS1h/7IkcSQulywMOMsTWj2DIHqg3hWW+US/H3nXZjlvZA1nNhdJ3WGdQQlnsENPmgqY
         p73FdtM589cbmZCb34mHbMWS8OZLFahbyxrn8iOSIsTnUpFUqRBO++k3Jw9ziK24sB14
         1aEJkNkdhEPN/DwB9zunSF9ErK707rj1NqaFQRD0syG6oCo4aPIVR0XaMUx2kJSBIx29
         OhwRrCD9Ex4HVVr1r/dJzSMmSwAcEyMUmo32cG5Vx50/hb/WXwU9SEgXnf6wt/Hu9Bzq
         XYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6NihziCTyZMAUdv/tajx8t4ufGMIb+wHMLzzNaM6Qc=;
        b=NPk3HPdN/cxWWguuDeQEfsmgFvoJXORq2DHroYqUuTZIHtrZNQYXw1ioCs10LbAkSO
         ae5QD6zI6ObP5AX0I/crHxHAszUB7Njsunvrk7uB8YdQ+YZ5ODAO51IyRka3y55VbxsC
         5hYhorUMCzXpka8D4cJb3YJoRITB4m6fXGU6hqpqdVnE07uSdVe3sHy2u8Gn0sEpcSQ7
         tJXtIOxqUo+SqCxhEng7D99PI01VQFCK8Noe5JpdcFL95KbBn8HIQMb+/i2jIILFPg0b
         Q+OIk/Vczkr+uDLnAM34o6EAcRzLD9/zrgpz+1JbqGk9uOMe535THokJpyQDQzKB8NfS
         UATQ==
X-Gm-Message-State: APjAAAUpTf+kI+mfF+FxM0IsIaUrr9iKGtgyfyAO08/qzv1nLY1Us7Fv
        +Mqk5FicPxmjKpH3pHADrL4RNR5MBlASq4/+FmxYzA==
X-Google-Smtp-Source: APXvYqziLZ994tDnwRiLck1FaENzmhT9e4Iye+IQizxx2JZmB9oorbeE1//5MgiHKZhF8rfXYT8vkMOYdjt9JS7vGvw=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr24505315ljo.99.1582414711800;
 Sat, 22 Feb 2020 15:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20200219094340.16597-1-ardb@kernel.org> <CAKv+Gu_aL_=W7qMuLwu+427=DSgj5Kmg7Qm0ujooxS9s=zDT2g@mail.gmail.com>
 <fa6aa783-0b01-9d29-03be-3ec8d352f373@arm.com> <CAKv+Gu8g_fb-Xq3XcyZivG5405jypHnkBy6gnWMWy4Oz8763XA@mail.gmail.com>
 <01039e92-8354-a75f-44de-7638b103be42@arm.com>
In-Reply-To: <01039e92-8354-a75f-44de-7638b103be42@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Feb 2020 00:38:20 +0100
Message-ID: <CACRpkdZpM18k0S64U1UvgFbDGPYZbY-gRzchGRYsi9g2wTbQCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 21, 2020 at 5:09 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 21/02/2020 1:42 pm, Ard Biesheuvel wrote:

> > OK, so where should it be instead? Are you saying it is now required
> > to have a /soc or /smb node that contains all the device nodes?
>
> That is now my understanding, yes - if there is some property of the
> system interconnect which is not entirely transparent relative to the
> conceptual CPU-visible physical address space and needs to be described,
> then the only way to correctly encode that in DT is with an explicit
> level of 'bus' in the hierarchy to represent that interconnect.
> Otherwise these address translation properties quickly end up in
> philosophical conundrums over what the parent of the root node is.

This confirms my similar understanding. Rob sent a patch to
remove the root level dma-ranges from the ARM Integrator,
and I have since added it back below the logic module bus
after you pointed out that the dma-ranges was actually there
for that very bus.

Yours,
Linus Walleij
