Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7F41B0EE
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhI1Ngw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 09:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241044AbhI1Ngi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 09:36:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90448611CC
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632836099;
        bh=Hud5+xwGKPTjXu8w2PHtjeTfxN4qI9TuoSjQgxyC/a4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WBDHKHWzv+mxrbVQm1NXHMAOflIRmoWVMXjwCe91GH9GrqdUHDeh1EQlXjKgmApiK
         Ytoj/lWPv1/bcILvm32AcIkTM2vrctCZRj1jakqvtu+vCwoEOFgu4XEdGLk2hB4WEg
         AUr+1fKRknRj7g2JNF1axr09eCiAbADq0MxJxkezCu7M8n7hgftB1XVm67AKmEZzjo
         IE0GsoXkeYDkn5imhIA3A/djQBu3UMOP+5nqenU3O6BBvsToL4DHciWSF0q/W2sPRR
         Lzt9dO+EP1RF+HKBzzlz5/vKG7bUOjLIE7LtUCFErQcIcMe5bpQsdu/sgthKcIMHak
         j1Cz/+Qo6PnRw==
Received: by mail-ot1-f46.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so6928353otu.0
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 06:34:59 -0700 (PDT)
X-Gm-Message-State: AOAM531UTlCHPpmqn6bH9tUC19TQ9GYNj+p+W4V5els+o1sJEASZXWGB
        PoRO0l/8v0JeS1yZeSzjNpbN7MMAfH9YfXm8Uuc=
X-Google-Smtp-Source: ABdhPJx07IcMlFqYIxYvYww5UQdWp2nULTYV8CWvd+tkafaHJiE25OYTKEdt6npMWDcjb8h/vdKCVzwpn7+0330NX2U=
X-Received: by 2002:a9d:63c7:: with SMTP id e7mr747809otl.30.1632836098937;
 Tue, 28 Sep 2021 06:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de> <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
In-Reply-To: <20210928133340.tmpjzdj367h54ddt@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Sep 2021 15:34:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
Message-ID: <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Sept 2021 at 15:33, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-09-28 15:30:32 [+0200], Ard Biesheuvel wrote:
> > This is generic code and the commit log only talks about arm64. How
> > about other architectures?
>
> They also invoke the EFI services with disables interrupts. If they
> provide a RTC behind spi/i2c then we end up in the same situation right?
> Or did I misunderstand your point?
>

Are you sure you want to disable EFI runtime services on all x86
systems with PREEMPT_RT as well?
