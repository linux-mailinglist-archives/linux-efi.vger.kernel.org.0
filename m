Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4937E22D76E
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jul 2020 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGYMNE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jul 2020 08:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGYMNE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 25 Jul 2020 08:13:04 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06AD20674;
        Sat, 25 Jul 2020 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595679183;
        bh=zRw6d17GoVtvI1l3GK+dyKmcdnwOg4wwfjyOcWySfLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LF4AzFkzLpfLbcNVWzXboAUULqsgUV1w0k5rTlIA30XvUDgEd1+uzAqP9aTeWdvZz
         tLFG5izOhnSidxC1Ub2vtH06KIoH3dKFmPIDv98/ED1lQO9YtStdCZdEfCnjqHX1mX
         rAh1JwLDZYAXfzoUZmuxmYbpDv4IBor1Lw59I9Dw=
Received: by mail-oi1-f169.google.com with SMTP id j11so10353068oiw.12;
        Sat, 25 Jul 2020 05:13:03 -0700 (PDT)
X-Gm-Message-State: AOAM533YQ5oBSqX5tSY4zkq/iGkUcDNs1YX8igahOBK4zEoq/SV6z+Pl
        SVvy53ZHzfloKpec18AJ2ffqQ7tRVAihxpULZtE=
X-Google-Smtp-Source: ABdhPJzq1TXQYdywbReuouFO6wIWuSCTKIG6kI2Fi8vPYOalaOAOB/b222sBhZcBc1duguve0G1o73ZTMb8eJauRWIs=
X-Received: by 2002:aca:cc0a:: with SMTP id c10mr711767oig.174.1595679183082;
 Sat, 25 Jul 2020 05:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132807.32232-1-ardb@kernel.org> <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
 <CAMj1kXFQt4f0XT6C_4_xAuDALv_jVsc+z0zkSnxh6MU-zHxj2g@mail.gmail.com> <20200725102559.GA757519@gmail.com>
In-Reply-To: <20200725102559.GA757519@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Jul 2020 15:12:51 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGET_-VPpEU8QvaHT_PbBetCOjOhrL5ttRYGe=MkNCdjA@mail.gmail.com>
Message-ID: <CAMj1kXGET_-VPpEU8QvaHT_PbBetCOjOhrL5ttRYGe=MkNCdjA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes for v5.8-rc
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 Jul 2020 at 13:26, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Ping again?
>
> Sorry about the delay - sending it to Linus now.
>

Thanks Ingo
