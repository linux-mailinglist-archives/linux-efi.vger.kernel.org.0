Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5E1A6A31
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgDMQsO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 12:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgDMQsN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 13 Apr 2020 12:48:13 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B212063A
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796493;
        bh=QF8Agpk1zRz9RjwLFjyl66kAjdopMGsM1h0d6AWC4HQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ESMdPj3yOywkDNFCEQLV90YJQWUZVKftTUmu788W09SrFAJfmM7w2ylykwMQwf3gp
         /5WSRAQw9Cpkn06yVZjgca040sZDWTUbiVj9QrmxMHGUSmf/V0x7qyt8EjGpztdqN0
         FlHB/BQ6Cd4STQLEEFk5hF5LjSdMqJT5U6wns0fU=
Received: by mail-io1-f46.google.com with SMTP id w20so10011864iob.2
        for <linux-efi@vger.kernel.org>; Mon, 13 Apr 2020 09:48:13 -0700 (PDT)
X-Gm-Message-State: AGi0PubqKjYAu6AUaD4lvZGim53/AMEqlu4DbJ1G/ie2Fq++0/KjiRpH
        Sh/TFhXH1n2Z5crHTf8KiMp5AIq7DjpBGNjIcZw=
X-Google-Smtp-Source: APiQypKDCgIHmJiLmAtZys6y806W3RG2Xj5RcWWNymWBjmvmeFp4reUd+h4M6TGLbtHbkDIkn4MIPYlvAqEsrYK2zK0=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr5868156ioh.203.1586796491493;
 Mon, 13 Apr 2020 09:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200413162135.14955-1-ardb@kernel.org> <20200413164130.GP25745@shell.armlinux.org.uk>
In-Reply-To: <20200413164130.GP25745@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Apr 2020 18:47:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF7wwDq72N9=E9DFGs8yDqz=27-aAVC1-UuRStD70AVOQ@mail.gmail.com>
Message-ID: <CAMj1kXF7wwDq72N9=E9DFGs8yDqz=27-aAVC1-UuRStD70AVOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: simplify handover from UEFI to decompressor
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 at 18:41, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Apr 13, 2020 at 06:21:30PM +0200, Ard Biesheuvel wrote:
> > The EFI stub in the ARM kernel runs in the context of the firmware, which
> > means it runs with the caches and MMU on. Currently, we relocate the zImage
> > so it appears in the first 128 MiB, disable the MMU and caches and invoke
> > the decompressor via its ordinary entry point. However, since we can pass
> > the base of DRAM directly, there is no need to relocate the zImage, which
> > also means there is no need to disable and re-enable the caches and create
> > new page tables etc.
> >
> > This simplification is implemented by patch #5. Patches #1 - #4 are
> > prerequisite changes to permit the decompressor to execute from the
> > offset chosen by the UEFI firmware.
>
> Why?  The decompressor is already fully relocatable, so this doesn't
> explain why all these changes breaking up the single place where data
> is stored into multiple smaller pieces, making the code more complex
> is really necessary.  To me, this seems ot be change for change sake.
>

Please refer to patch #3 for the explanation. The EFI stub will no
longer enter the decompressor startup code at the top, but jump
straight to the 'wont_overwrite' label. Most of the contents of LC0
are never used before that point, so its load can easily be deferred
until afterwards. If you look carefully, you'll notice that that by
itself simplifies the code, because we no longer need to stack/unstack
those registers either. So I would argue that reducing the liveness
scope of r0, r2, r3, r11 and r12, and deferring their initialization
to the point where their values are actually needed is an improvement
in itself, regardless of whether the EFI stub simplification in patch
#5 depends on it or not.
