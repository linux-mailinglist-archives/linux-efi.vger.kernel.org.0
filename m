Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145C6276034
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIWSne (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 14:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgIWSne (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 14:43:34 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780662371F;
        Wed, 23 Sep 2020 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600886613;
        bh=3ZfAoL5dYUwxybym1OlybpcFUx1k2eiGDupEFcVC31c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TtZy5LbJkWpVCnEVoj2ZGqKcX0BCamibOSEohvsqdzhl0gLkyTIDvSwdWxGiO5d+R
         ovFEn1fEdnUrHwVCQq7jwvWM7qSG9qDGCDFOXBPaO7LBfH28cFWVffnyeTS7HDB6Ch
         +4SmrhLDVk3gM036aMIQgMJ6NYG1Qr6+lfWYP7PQ=
Received: by mail-oi1-f170.google.com with SMTP id 26so912442ois.5;
        Wed, 23 Sep 2020 11:43:33 -0700 (PDT)
X-Gm-Message-State: AOAM532Eht7yiGiWa1WtuGLqYCnZZd8zEKe/7bSVJaPnOpJk0j35q166
        uts7nHZBroA7dgNCJQLqTG6tYsVg4PkPLTlTnbE=
X-Google-Smtp-Source: ABdhPJxn65qP+Onmm74D7SHwmq3++Wfxwp/7/5/CRmJcvBQItWERPqxk019bzV8OlpWSoGGVw8TReLCJzDpBnaj+A50=
X-Received: by 2002:aca:d845:: with SMTP id p66mr264571oig.47.1600886612754;
 Wed, 23 Sep 2020 11:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200923161404.17811-1-ardb@kernel.org> <20200923161404.17811-2-ardb@kernel.org>
 <202009231140.B4648C6@keescook>
In-Reply-To: <202009231140.B4648C6@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Sep 2020 20:43:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFFs2rLMn5kdY9CGsz32ctBshb93iN7yBtZNHYwW2mWnw@mail.gmail.com>
Message-ID: <CAMj1kXFFs2rLMn5kdY9CGsz32ctBshb93iN7yBtZNHYwW2mWnw@mail.gmail.com>
Subject: Re: [PATCH 1/7] efi: pstore: disentangle from deprecated efivars module
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Sep 2020 at 20:41, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 23, 2020 at 06:13:58PM +0200, Ard Biesheuvel wrote:
> > The EFI pstore implementation relies on the 'efivars' abstraction,
> > which encapsulates the EFI variable store in a way that can be
> > overridden by other backing stores, like the Google SMI one.
> >
> > On top of that, the EFI pstore implementation also relies on the
> > efivars.ko module, which is a separate layer built on top of the
> > 'efivars' abstraction that exposes the [deprecated] sysfs entries
> > for each variable that exists in the backing store.
> >
> > Since the efivars.ko module is deprecated, and all users appear to
> > have moved to the efivarfs file system instead, let's prepare for
> > its removal, by removing EFI pstore's dependency on it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> With this and the other pstore patch, do the pstore self-tests still
> pass on an EFI system?
>
> If so, please consider both:
>
> Acked-by: Kees Cook <keescook@chromium.org>
>

Selftests? Excellent! Are they documented too?
