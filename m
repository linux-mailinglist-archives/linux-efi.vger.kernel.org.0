Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75207347B11
	for <lists+linux-efi@lfdr.de>; Wed, 24 Mar 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhCXOqT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Mar 2021 10:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236251AbhCXOqD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 24 Mar 2021 10:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4188761A0F;
        Wed, 24 Mar 2021 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616597163;
        bh=IpQqeZizpAkmktM1ykYR3SVGsq3cc7ebBvwgwpKHb54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0uoMNCsY34YsQOjwo+6nuFTZULLZcwjyfF47zMiOqHO2Z6jhu9AMPSUvR3Y57LD1
         028suKzN0rxO3FrrVNP8rSV5SOb/SKEDKLnumQ3lPCKg8ZwW0RwojHzFkqya5YkbJx
         mtaG3DKcNkFLNBUJ7P0NxijHB7C+WtD7/83CWSjhqIqpVJ3IFWMEYAhgV9Bu86JWBy
         6tMunJLtesSZL5fTjqhA2zCdAm5jabL7ePNZaapK5elYb95ayP6XfRS+Hbc2mg0ctR
         VIdu3IvKk677XPRepzNoqzs5dFvbI5rG4AV9oN1JGg2tE7IWyiVqUe+LE0BiDI2H1b
         8qlzjB/MeeLlQ==
Received: by mail-ed1-f50.google.com with SMTP id bx7so27924056edb.12;
        Wed, 24 Mar 2021 07:46:03 -0700 (PDT)
X-Gm-Message-State: AOAM530j29Bnx2h2zHQ4pFt0IXg27z8J3yL/JMdXgiNIYoDFa4Dg+nzx
        QQmjka7L5VQsCAH5zfX8yW3OhYfWJe3lnmybjw==
X-Google-Smtp-Source: ABdhPJx9s+DKhEIneKlm50ecrAh88tChNkD/fmlCgrTsMQymYLNt6jDsywvmbgGVambNzhd8cZzpeq1mkk+S3JmVtj4=
X-Received: by 2002:a05:6402:2d0:: with SMTP id b16mr3933538edx.194.1616597161877;
 Wed, 24 Mar 2021 07:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210309000247.2989531-1-danielwa@cisco.com>
In-Reply-To: <20210309000247.2989531-1-danielwa@cisco.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Mar 2021 08:45:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLN=TtAck+0cT+MFtxRiMUpiWRUMnrvnJJf55fwCxATLg@mail.gmail.com>
Message-ID: <CAL_JsqLN=TtAck+0cT+MFtxRiMUpiWRUMnrvnJJf55fwCxATLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Generic Command Line changes
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        xe-linux-external@cisco.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 8, 2021 at 5:02 PM Daniel Walker <danielwa@cisco.com> wrote:
>
> This fixed some problem identified in my last release. I made updates
> based on comments from Christophe Leroy.
>
> I added scripted updates to the defconfig file for mips and powerpc.
> This is required in order to maintain the status quo for those platforms
> which used the prior builtin command line system.
>
> These were tested on all effected architectures.
>
> Daniel Walker (7):
>   CMDLINE: add generic builtin command line
>   CMDLINE: drivers: of: ifdef out cmdline section
>   powerpc: convert config files to generic cmdline
>   CMDLINE: powerpc: convert to generic builtin command line
>   mips: convert config files to generic cmdline
>   CMDLINE: mips: convert to generic builtin command line
>   CMDLINE: x86: convert to generic builtin command line

Can you send out or provide a branch of the other converted arches you
have patches for? Given this got revived due to arm64 cmdline changes,
including arm64 patches at least would be beneficial as there are
folks motivated to review and test this on Arm.

Rob
