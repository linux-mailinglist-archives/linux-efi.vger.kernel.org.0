Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4D41B886
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhI1Un2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 16:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242734AbhI1Un2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 16:43:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7887A61373
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 20:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632861708;
        bh=R6ico/w3xvjUwc0cpoYBrmW8uUbBJOufS34XYbcwsSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tpNi45zs3RLsF5OUW7s1qcvIYxhsgtnJeMxEf/qOl1fOMfGLTsuQsURupwBk9UBx0
         afqcOVwRV1T3OyRMYXYzUC8LaBlIGXfoKa7bsHp/EdKss73kGO1/7/9TqQOfm9h4yd
         DhHU6h/7ZATNKVDtT50iFrp4artTAGU6ucRvlE5XYa/A5vecQ4jJxWWIyD952VvUkB
         ccQHkUXHmoFrJYDk1EnZEeRv4Z1/r/TCEXpj5VYPZRJB9AF3vf09oKF1Pp5sD7gOGK
         v9/jza8xhPIuDTtJ9tvf3qo8ugxe2Xvp77sqijpQNXyhpKl88eZo6AfNPcWDahorm6
         K9K5WXReIDU/w==
Received: by mail-ot1-f49.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so85058ota.6
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:41:48 -0700 (PDT)
X-Gm-Message-State: AOAM530DYyaOBqCAEZtF0jDOLmQMqhkUyivmNBdYAbJ34vVRgMmrxCms
        IpzMgOoIkBR9AEBMrmZI5QzTcUTWppgDPnwZLac=
X-Google-Smtp-Source: ABdhPJzSSPCUEW5QAIe49opqaZ+5yBgTb1A8ZDhjodRoMqcpulQrotvkXZt6CSxazmnS9/0S7YvqaPkdBtPxKt1pAdY=
X-Received: by 2002:a9d:63c7:: with SMTP id e7mr2514381otl.30.1632861707874;
 Tue, 28 Sep 2021 13:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de> <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de> <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
 <87k0j0a1hw.ffs@tglx>
In-Reply-To: <87k0j0a1hw.ffs@tglx>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Sep 2021 22:41:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHp7NzPfGjZg+199vR09PuQfb=da+iqhh-Ts5kf337UHQ@mail.gmail.com>
Message-ID: <CAMj1kXHp7NzPfGjZg+199vR09PuQfb=da+iqhh-Ts5kf337UHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Sept 2021 at 22:28, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ard,
>
> On Tue, Sep 28 2021 at 15:34, Ard Biesheuvel wrote:
> > On Tue, 28 Sept 2021 at 15:33, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> >>
> >> On 2021-09-28 15:30:32 [+0200], Ard Biesheuvel wrote:
> >> > This is generic code and the commit log only talks about arm64. How
> >> > about other architectures?
> >>
> >> They also invoke the EFI services with disables interrupts. If they
> >> provide a RTC behind spi/i2c then we end up in the same situation right?
> >> Or did I misunderstand your point?
> >>
> > Are you sure you want to disable EFI runtime services on all x86
> > systems with PREEMPT_RT as well?
>
> I'm pretty sure because we've ran into inacceptable latencies with EFI
> runtime services often enough.
>
> Since we disabled them these complaints have gone down to 0 and nobody
> so far complained about their non-availability.
>

Excellent.

> We might revisit that and make them default disabled on RT and offer a
> command line option to enable them for those who really want them.
>

Yes this is what Sebastian's second patch provides.

> Thanks,
>
>         tglx

I'll take this as an ack from you, Thomas, and queue these up for v5.16

Thanks,
Ard.
