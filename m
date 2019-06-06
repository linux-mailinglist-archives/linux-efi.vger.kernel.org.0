Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9736CA5
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2019 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFFGzn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jun 2019 02:55:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37088 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFGzn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jun 2019 02:55:43 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so993918iok.4
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2019 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzYHOcm04V7pY89OMe1ayw64K31F1RwMQUnnebF2vQg=;
        b=PCZ8xQ+zgS+exi65IVAynpf6n2dVQ2aMd8IZrDp05SrkbQi3WQ4ysjYvQ7bwaWkaCs
         yxrfn82fV2bko0z2eGUAdF/UEchtticxfogCLaowjdt8DdcQGJYkGS2wpSP+R9a88/Vj
         xwb9ucRn8Y28nfwLDvP5EuTmjhIUah2DFaB8JK4shJkX11tDoNblzipsiZ1rNUKla7WL
         d3Y1jAUm3echWSkinPSRxj7grvrYAPCeDxKGfASBDjYW3p6lZeoKb6yaeRORtm9d5MSu
         /gGjtE2ZpU6hpYhKUqAApETWMTbCMMlvK48wgJ1ixCAIqKK/J2Wqy/p0t4/ssQVVkmxl
         6XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzYHOcm04V7pY89OMe1ayw64K31F1RwMQUnnebF2vQg=;
        b=Klw9Nc6uRvnTU3YoVQtTgvQLOPUu0k6DF78wo8/qbatMJsvL8kERs0fvMy/qLl6zOm
         qavJiwS9/Rk6UxDeU454aj5Acds9Y95JGyULemqqSPjVR+K1g/kjbeBi1rf0EyAm58ol
         wsrCoKEG/87Sc20+YaMx2aF4NL1bw44sKXrdOLhSfoBGA7Una+oV3SK6bZ7UOt7RywBg
         YzF+47b8mATMU1BN/Y9xBAT9h49QnD0iQg20KAq5ZB4T8+mxtLBPGs9xpM+wSpt2kKIQ
         EXi8DnqYxUPkj28AJjsB4qVyjl9/lUgOvKmaiL2D5RC1jmOeo2Oew9fS3R2znBbDqPKB
         DqOQ==
X-Gm-Message-State: APjAAAUefCyOMKPvivbCrcvWUiNv78rxVE4zdxngb0QFX+MQZaFXGl4N
        KvvYsqNUV17PDPQLvyTKLQrpEDfHbSTlvqvf9G/KQg==
X-Google-Smtp-Source: APXvYqzmVB1goVLdL/gBMnVpgzDUq1wp1x/P5RQsZ3Td5fa9metOI9KhI69VTT90C5Ka3qNwhh94GESgCKyvqNrDng4=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr25129792ion.65.1559804142376;
 Wed, 05 Jun 2019 23:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <CAKv+Gu9QkKwNVpfpQP7uDd2-66jU=qkeA7=0RAoO4TNaSbG+tg@mail.gmail.com> <CAKwvOdnPcjESFrQRR_=cCVag3ZSnC0nBqF7+LFHrcDArT_segA@mail.gmail.com>
In-Reply-To: <CAKwvOdnPcjESFrQRR_=cCVag3ZSnC0nBqF7+LFHrcDArT_segA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 08:55:29 +0200
Message-ID: <CAKv+Gu9Leaq_s2kVNzHx+zkdKFXgQVkouN3M56u5nou5WX=cKg@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rolf Eike Beer <eb@emlix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 5 Jun 2019 at 22:48, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Jun 5, 2019 at 11:42 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > For the record, this is an example of why I think backporting those
> > clang enablement patches is a bad idea.
>
> There's always a risk involved with backports of any kind; more CI
> coverage can help us mitigate some of these risks in an automated
> fashion before we get user reports like this.  I meet with the
> KernelCI folks weekly, so I'll double check on the coverage of the
> stable tree's branches.  The 0day folks are also very responsive and
> I've spoken with them a few times, so I'll try to get to the bottom of
> why this wasn't reported by either of those.
>
> Also, these patches help keep Android, CrOS, and Google internal
> production kernels closer to their upstream sources.
>
> > We can't actually build those
> > kernels with clang, can we? So what is the point? </grumpy>
>
> Here's last night's build:
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/114388434
>

If you are saying that plain upstream 4.9-stable defconfig can be
built with Clang, then I am pleasantly surprised.

> Also, Android and CrOS have shipped X million devices w/ 4.9 kernels
> built with Clang.  I think this number will grow at least one order of
> magnitude imminently.
>

I know that (since you keep reminding me :-)), but obviously, Google
does not care about changes that regress GCC support.

> > Alternatively, we can just revert this patch from 4.9
>
> That would break at least the above devices next time Android and CrOS
> pulled from stable.
>
> > It would be helpful to get a relocation dump (objdump -r) of
> > arm64-stub.o to figure out which symbol needs a 'hidden' annotation to
> > prevent GCC from emitting it as a PIC reference requiring a GOT.
>
> Sounds like the best way forward, as well as having more info on which
> config/toolchain reliably reproduces the issue.

Let me know once you can reproduce it, I will have a look as well.
