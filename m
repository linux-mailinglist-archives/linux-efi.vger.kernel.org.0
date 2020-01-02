Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5912E85C
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 16:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgABP63 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 10:58:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55000 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABP62 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 10:58:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so5949468wmj.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PY46Y24tQSS8pzo/wzcJFBTE1svW4bjNbhmg+CqsZE=;
        b=RzZwaxBv8m5nuyXOl5syaxDVtJ3pFKbKIFkQoxSagkVgHroKvfLtJcRSpDdpad2ZzA
         JzM3qeMrH4usJH9vMv7rL4CPHqZLEz0R0x1Cq7x2hqAVRqW+pyXEbCzdoOI3AEDtpT07
         1jrPwdzPlFjIgbcQSMRrSv80k2e17LCHbNhs1UXLtSdGKVoclKCJiPKvxN4pSbDxWjXu
         BOLWmffOe9x1Ez1epx5WL3JHM3hBUbK96/kp/75MpB7+rbRiv/oeHVKV6Y3JbayyBnww
         V4TqhLdtRI0RNdwWNCB6swvp3HIGJdY9VWd+M1rSxy+ulPxU1w9ClxtjPyOfI36+tFuj
         wB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PY46Y24tQSS8pzo/wzcJFBTE1svW4bjNbhmg+CqsZE=;
        b=Yh6SVSd28ZcB57TlxYt0QFx+Y+dfUXr3IqF3nYiKPvTjxiTn6ZAd+yqEq5TNqwXlE7
         cE8qW+N/qom7v98KoIapuqIprxbQqMB6q53oGUZUoi+HKS1aAHffauFD7+p49nfjoOD+
         8kYb5x2fCNcAQvKBFmljPAZy9l4c5cU+9gQyR5KceN01MSQONLSp9TJMUv+OfUBkFUid
         srsYIlojiqeHz26HLYLfSJ2WA+fR5+aIrDEI1IAKIb9KS06gm6jRBBZkJk0XpFS2NYor
         s383hEMIxXxfmJsu8q1dxx5SNdjIF3ntDJl6Z14SgmjRtuJDeSRQ3tyH4HXvVWpWbZ7J
         luTg==
X-Gm-Message-State: APjAAAX6jY+SMtzJTw/1Hvr+nxh/5rTPYXFjyU3Le5NgCsrax6FX9dde
        nyRJ74EjhIpQmlj9wlT5vN2KR6EqjErTAay2TIugbw==
X-Google-Smtp-Source: APXvYqzP+2Bm8Ox1UrQQlVIchhVdoZEwnhD+txl3ilJNrNOqjVA1x0HRP0qMsdKBCl+zJTCsPK24AosnAR2LF6+ID9U=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr15387736wmc.9.1577980706781;
 Thu, 02 Jan 2020 07:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan> <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
In-Reply-To: <20200102155129.GA668939@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 16:58:15 +0100
Message-ID: <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> >
> > Yeah, good point.
> >
> > I pushed as branch here;
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> >
> > Could you please check if that fixes the issue for efi_is_64bit() ?
>
> Haven't built it yet -- but how does this handle the GOT issues you
> mentioned?

It doesn't. The trick is to add __attribute__((visibility("hidden")))
to the extern declaration of efi_is64, but I am having trouble to
reproduce the original issue.
