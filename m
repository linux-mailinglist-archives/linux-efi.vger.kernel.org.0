Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEFD195871
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0N7f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 09:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgC0N7f (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 09:59:35 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440ED207FF
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585317575;
        bh=Jd38g6hUpeXc65bqRs8jSstB3VYR7iFsF7Sq09uHuFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kq6bKdsTnXU54O+VAwdQ9sU+Usqa4o+pnFQ4TWAw5Gs8C05SJm3wjuSHnWpeU3Ke2
         FFqufDWQehtmzGIwEuSonSobMJYlvpVFXIDyXgg5AfsnYkolSzQrogMlZDZCyZysBI
         iFQEcCrgtddyTwOlg+jw6xH9dC6Zy/42NIAsrv1M=
Received: by mail-io1-f41.google.com with SMTP id k9so9912343iov.7
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 06:59:35 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3O7LBhcU3ClFoPvZlO8UqItWnGlJWZQ+mzI0MP4Ttt0QxQ+UZo
        B29F20SOG7h4crEWStcnUc9Sv1kZfcs/gXK1rmM=
X-Google-Smtp-Source: ADFU+vvoKNJuf52tKIR5b28M0Ugzsaf01+axqgNcB5Qpi8DxZYVCKV6OE47xlXkAUtUITI1kZs/qBqeBH+mmsi++DMo=
X-Received: by 2002:a02:c985:: with SMTP id b5mr12408162jap.71.1585317574578;
 Fri, 27 Mar 2020 06:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200327105906.2665-1-ardb@kernel.org> <20200327105906.2665-2-ardb@kernel.org>
 <CAMuHMdWewhg9nDNrKw7F6f3uajxvw_mBZs17cZL64FQ8VrvrNA@mail.gmail.com>
In-Reply-To: <CAMuHMdWewhg9nDNrKw7F6f3uajxvw_mBZs17cZL64FQ8VrvrNA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Mar 2020 14:59:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF2nqGNL+YnfrPqRH3+ceYkpUqJzU4wbR1HMdmPZ+crqA@mail.gmail.com>
Message-ID: <CAMj1kXF2nqGNL+YnfrPqRH3+ceYkpUqJzU4wbR1HMdmPZ+crqA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: decompressor: move headroom variable out of LC0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hallo Geert,

On Fri, 27 Mar 2020 at 14:23, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
> Thanks for your patch!
>
> On Fri, Mar 27, 2020 at 11:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > Before breaking up LC0 into different pieces, move out the variable
> > that is already place relative (given that it subtracts 'restart' in
>
> placed
>

Actually, what I meant here was 'place-relative', i.e., the expression
subtracts two symbol offsets, whereas the others are absolute, link
time values that need to be fixed up according to the actual runtime
location of the code.


> > the expression) and so its value does not need to be added to the
> > runtime address of the LC0 symbol itself.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks,
Ard.
