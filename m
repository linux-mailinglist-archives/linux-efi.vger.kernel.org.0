Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A345EAB86
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 09:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJaIYn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 04:24:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaIYn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 04:24:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so5203507wrt.3
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwRXo6F4Q49q2OBaCjuHQqtxPHes3aTNLtF4lURqyMo=;
        b=i6fHLUXiRR5UkIqqSBjC6ztqMNazpDg62eCa0ff6GP9Qt5QQfz5iTquXhd4F39+mYc
         u1w9ohGsXZTSFrmXZV6/t/aluc2s5O1YZR2OpmhbMo2jsqjpSMb2/66A2g+JifTzoWE3
         Q0U8MkIew1zeHP2NuQrdsltJKUM2HMJP0yldaOBI7VUOC/+PmSRWABGmktjluGExCps/
         ypYMgDU7N6/GAQko9k31Zq0KzFvsxXajclFLYpf8v/rSAVBKnuEvvNCt6BhVMghMGIaV
         7wkFzrvIh4WaQgXVREi4TGhFHEm8Mu9kuLoSuEtO4GwXu378GyLeaJq9/gELsV//5nFn
         1bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwRXo6F4Q49q2OBaCjuHQqtxPHes3aTNLtF4lURqyMo=;
        b=RgeCx99fyWI9CS0qpx5gNowyOg7zDL+R7T4jvLp5iWQBb9ItappUb/zMNp82ujzLV1
         RQXHAieNvJveRQ4RsCBTmvrz8P/9tjWxmKfsuOztt4rdqWXUJiU4Qq9F6aAhT73Wa+p/
         MohgFluB2GBtZr/A7k7bUNafpEH9Z7lbpGCl8qyE7fwM2Bru2Z7KZ9PjIUU5xHWUNTSb
         jaETFYutt4p7rw63/tc5Vf6OeGlFy9q1eL1cmo/C8alGP3NPoF3uC0rGY6iJxs5Ex21H
         Jdl+89FAz++FBCeDna3nhK3ReY/z3mS5K0siQs2IQhxrhmrJnTmMbBVWYC/OchLFFa8l
         EUKw==
X-Gm-Message-State: APjAAAVIJyXHYYB0WMMieq+Ur+NYeg3D6PyiaSIFTQxc8Eqa4QgvfBlh
        IShWuGZTuyGWBaE7Oz306/FsXZFw3sJvLueQuBN2fQ==
X-Google-Smtp-Source: APXvYqzcs5anAptA40KO2f/DjMvYh1MjL0Q8+V3IIgHojFe37raK8oYokFb0klEN4SUxJbbhlaj9FJFoP0hfP8H0A4Y=
X-Received: by 2002:adf:8289:: with SMTP id 9mr4551139wrc.0.1572510280859;
 Thu, 31 Oct 2019 01:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191029173755.27149-1-ardb@kernel.org> <20191029173755.27149-4-ardb@kernel.org>
 <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
In-Reply-To: <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 31 Oct 2019 09:24:29 +0100
Message-ID: <CAKv+Gu_zMMeRSBYk_tBX4UA+v1r+Kntrxe3xurLd1Q2_+HkbWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 29 Oct 2019 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Ard,
>
> On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > From: Dominik Brodowski <linux@dominikbrodowski.net>
> >
> > Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> > add_bootloader_randomness(), permitting randomness provided by the
> > bootloader or firmware to be credited as entropy. However, the fact
> > that the UEFI support code was already wired into the RNG subsystem
> > via a call to add_device_randomness() was overlooked, and so it was
> > not converted at the same time.
> >
> > Note that this UEFI (v2.4 or newer) feature is currently only
> > implemented for EFI stub booting on ARM, and further note that
> > CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> > done only if there indeed is sufficient trust in the bootloader
> > _and_ its source of randomness.
> >
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > [ardb: update commit log]
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Seems my Tested-by was dropped which I provide for the RFC version of
> this patch.
> See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
> for details.
>
> I can provide a similar Tested-by for this version as well.
>

Thanks Bhupesh
