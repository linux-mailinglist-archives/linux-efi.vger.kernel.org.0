Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81A12E357
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 08:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgABHdv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 02:33:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34306 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgABHdv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 02:33:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so4410385wme.1
        for <linux-efi@vger.kernel.org>; Wed, 01 Jan 2020 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaDJb1ZhTUFbw2ylXiS0BKaVoJguv5Qe4YVisv1aoqs=;
        b=i6l/5woekKm3gP+a9YppOCqwgfCQXJmKjFk54ydTkn0PRuNLJ8sG4Ufbx+JDQ8+GGi
         svxoRPaoF3Bqzab4+yOoPRx+cK8y3dt0OZxKoK1cCTW5UIakepUjOtOx4ACIZFv8fc3b
         B5h1LpHieVWO661RuaA6rbYsrmIwknEg7ECJRQZRpS2ZaBNtC8GxOy6wHADulE1Qkm0g
         BaGbgbJ1akut1XXJnN/EHlw+DbTvICduqWez5d+DFjhXl2J9n/qmNsNQR99zTwKmkyKE
         nv4Kr5SYj7z7xwQGThv3HFcHBHD+EfWFsa9gJuG6OEC5TvQJv0jwbq4zkr8fCvqUsXOI
         IEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaDJb1ZhTUFbw2ylXiS0BKaVoJguv5Qe4YVisv1aoqs=;
        b=uBox9/RSs383tlTeZFoch1UBXi8YxL1Z0c3zb56m+da7NI4wGbyY1oYgL92rlJeYRm
         dPCBvnDrmDYruIiGjA69QoyukqGyhbpE3dg1WfzIeCyJ8LKoH/gPKpjVZECxw6X9281x
         huKrqgfjW1w3XRcLqwgpZyU8pX/P2kwylpKmcdAxOfogXcDviazSYjd75I1qE6QMHX1F
         qkubz/r4P3Np2QMEuTiSPTErtLZKgQ5nzJCdWGZ7J048pJEwQMvwJoxtyRog9W/VoHNI
         lU8UHibf/0BFl2q+7F76LOcUWTALVFX1oTh1x0/E8jaO/HYdPlfUE6uxwczFX28k/4V4
         yidQ==
X-Gm-Message-State: APjAAAXdkDgJZvnCvAzutV3A81JZFlxplNLAFIMZdmaPcGJsWB3kI2gO
        N4VYi9NPDkb8OG2l9XBDvykXec+IM5ldmAodKSw7mQ==
X-Google-Smtp-Source: APXvYqws0MKk5/vh5bKH11Y+BMbnulpUFqEVMryyKw4XnGG9WL0H6ksmo8ocZJ66/W6KNeWkt/BfP4wSkx6lOWScgic=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr13125662wme.148.1577950429661;
 Wed, 01 Jan 2020 23:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan> <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
In-Reply-To: <20200101190844.GA208136@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 08:33:54 +0100
Message-ID: <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
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

On Wed, 1 Jan 2020 at 20:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 01, 2020 at 07:13:45PM +0100, Ard Biesheuvel wrote:
> > The GCC documentation mentions that it does not make sense for a
> > function annotated as const not to take any arguments, so I'd rather
> > avoid it here.
>
> Where does it say that? I only see it saying it doesn't make sense for
> it to return void.
>

You're right. I looked into this in the past, and I misremembered, and
paraphrased it incorrectly.

The documentation does mention that const functions are not permitted
to read global memory.

> Currently if we call 5 EFI services in the same function, it has to
> re-evaluate systemtable and is64 for each call, which seems wasteful,
> though of course this is not exactly performance-critical code.

The alternative would be to use globals with external linkage in a way
that is guaranteed not to rely on GOT entries, since we'll end up with
absolute addresses that need to be fixed up first. This has caused
breakage in the past, and is the reason we use this scheme with
globals with static linkage and __pure getters.

However, hidden visibility should yield the same results so we should
be able to make it work with that instead. However, given the breakage
in the past, I don't think it's worth it since the performance gain
will be negligible.
