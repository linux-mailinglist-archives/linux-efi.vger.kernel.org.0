Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5B12A857
	for <lists+linux-efi@lfdr.de>; Wed, 25 Dec 2019 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYOmp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Dec 2019 09:42:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYOmp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Dec 2019 09:42:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so3641687wme.1
        for <linux-efi@vger.kernel.org>; Wed, 25 Dec 2019 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlOZrS/zV7/3xmf3ZkRzcqveBiOROyYvCQZXZ1HuBxE=;
        b=eE+aEZe7Pf65Cq0zuZadRae+/2XtFDHq+EeOdYZamjDFckdNefoEqLJ2XrJxuRj1Q4
         x+1mrOPPA8ojZT4LIij98aRAWyXFQIyM6DfcG33lW00HcRNajWzY3W75GASeiGzaFBmk
         5y/Me0ubysn4LYWviGOlTeDhM156AttYL8+ioHlSNP5c/N49DNANlfXzZ51+Ur+1dya2
         kvNhCsAntYOucVBscl5OSvj6eWMfSdjMGBNGNJNafLeOVGbIWsf/V6RxRXg30UvMgBit
         y5G28S8y+YC8T5FRWlzpTsb+4xrvCh20CIVaoRyf42sZ0qK1twFVPsgycj2zttFNIFXe
         YM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlOZrS/zV7/3xmf3ZkRzcqveBiOROyYvCQZXZ1HuBxE=;
        b=d3JYG+P7X4j3ex+OJREHWsOEXddYNZYCD4p3nM69JaeG6PBGg9nvNejVaTrFUxX/Hu
         Rer+Qze7450hwPQt1FvE+3m5lA1rVeHL8CuHOu/LM9OkqsGDHE1t/DT57F2lGEGMQ2A0
         QEFXwcpwxnjQ4KE252fNPZz63vWm7NBKusFD787hYciDOWKN92ce7dwmG7hlZCJDUZ5M
         1Hz7jOzHIWdocLJJz7S1nq7aMwZSW7DgaPoaDzFm0cirw+vVWYeN/0MQgpQQYoqPlUCc
         n2Rg8izbGh61rfKveguGDUDvE44BX1nrXm/kBWGBjlLUZbhMaTawoGL6z/GwjGwCfgKw
         Lfnw==
X-Gm-Message-State: APjAAAUTaISbMRwLrR5ICHr24Oixfs0Gpcw2ePYnDepxtxvB/m56zNfM
        fk7wFyyGY8h0FZAAxEe2ySAuSHvaPa/58BJAolm/wQ==
X-Google-Smtp-Source: APXvYqxxOf9pygDePkH/YKZFKBc3JmwjvwPCySo9MiHNKc6daOGSpX/a50AFwz7sMYCYLbZMq7wxJft0WdJuke1TyIw=
X-Received: by 2002:a1c:7901:: with SMTP id l1mr9518562wme.67.1577284964492;
 Wed, 25 Dec 2019 06:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-14-ardb@kernel.org>
 <463b0b17-3be7-697e-1227-5d3df52996d6@redhat.com>
In-Reply-To: <463b0b17-3be7-697e-1227-5d3df52996d6@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Dec 2019 15:42:44 +0100
Message-ID: <CAKv+Gu-wk5qBOGuoLx6v7Zo41dOZ5oNL3oBCnyT858DY7JCuhw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Dec 2019 at 20:34, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
> > The various pointers we stash in the efi_config struct which we
> > retrieve using __efi_early() are simply copies of the ones in
> > the EFI system table, which we have started accessing directly
> > in the previous patch. So drop all the __efi_early() related
> > plumbing, except for the access to a boolean which tells us
> > whether the firmware is 64-bit or not.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I synced my personal tree yesterday to 5.5-rc3 + the most
> recent version (as of yesterday afternoon) of your
> efistub-x86-cleanup-v3 branch on top.
>
> This has been working fine on a bunch of devices, but it fails
> on a Teclast X89 Bay Trail (mixed mode) device. When reverting all
> the commits from your efistub-x86-cleanup-v3 branch one by one, things
> start working again after reverting this one.
>

Oops again. And thanks again for taking the time to test this stuff.

Could you please try the branch below and check whether it fixes it?

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-core-mm-fix
