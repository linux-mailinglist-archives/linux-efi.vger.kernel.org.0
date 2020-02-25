Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEC16EA71
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgBYPsZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 10:48:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33767 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbgBYPsZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 10:48:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so10136527lfl.0
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 07:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJpgxMXzpYahxV3eOR5lZa3e8wpI0rCX0tapALIRn68=;
        b=H2tBYEXpI5LqNDAVvlyFtYHS9YwKuPY9Xoe4UiaKypSyHl5uW0+wUDsP6cvX3L3YRU
         2g+VPO1CJsxsBE3roP/ovZdzwS/gpzyJD/4eSs9Yr+grOUZNAYry6Vzpl+g7aWBQ2B+j
         RfszI6jjRReHVJVnujjbdKuR8h9Rz2CW8mx5n4On5ntq+tYTWENf//m3NmXd5FXtmnQW
         B082YDxJ4kveSmGBaENmvZp4geqXfiDs8rFqBaq+mh6cWuugw2kyLyCu06DX1/SeqDrg
         Ffvwxgz95pguvSETFVRU6Q5xTGsZCsNSc1lafHU6tANu/ZDUAD0X2X4CnMASLMme1qEX
         k+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJpgxMXzpYahxV3eOR5lZa3e8wpI0rCX0tapALIRn68=;
        b=Bt16R991thGITrqPC2xBlj7DU3dpdgR9dFwF3G2x90BoX3FrLm/f32ZBq4acG/+ocF
         GiEHGPFA7q8pQgSW+wkd24Ze+pxXEKVKDSEfM9ot//iEpjFQ4swY3Y4YZ9RBLHtAEyrI
         B4XHHqVQ8phWAWBuhIdRj9xW0lZrHHbPlhnQmPLX89E3RGMrJv4fcgg6EDmvb2a6k4VO
         MS9MF+GnxXzYD0PGYUTUGl+by3Km6aWLOdyRzaOeskHcP+xLNXcUHdM33Mq7NQZoWiGA
         vcKZnkLFAKo/l3wKezR2D9sZyTYKLWQJuKKMR97iecdvhRIt9Pdf7niS+2otBmr7S+yw
         vAUg==
X-Gm-Message-State: APjAAAWslJG3rbex5Ry7f/YdJm59ZCN//9aQKgS6TpsHbjC2+ab+wS8i
        pL0NP4RKaG6kqt1wv6wMWPLLuLVjPwkMcWhUrWgskw==
X-Google-Smtp-Source: APXvYqy4mOvCXDyj7XSFn26gwn37tfh2gp60wsJ72Vo9+vwAF50M0xGjuEMYpar4fZCVYzhrv4+6Jv9hqKmDvHuBm48=
X-Received: by 2002:ac2:5328:: with SMTP id f8mr2601376lfh.47.1582645703369;
 Tue, 25 Feb 2020 07:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20200224121733.2202-1-ardb@kernel.org>
In-Reply-To: <20200224121733.2202-1-ardb@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Feb 2020 16:48:12 +0100
Message-ID: <CACRpkda5VFzMHE483MPj86VN7uU7w4bNibY=ZeLUHyED=JD7Cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ARM: decompressor: use by-VA cache maintenance for
 v7 cores
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 24, 2020 at 1:17 PM Ard Biesheuvel <ardb@kernel.org> wrote:

> While making changes to the EFI stub startup code, I noticed that we are
> still doing set/way maintenance on the caches when booting on v7 cores.
> This works today on VMs by virtue of the fact that KVM traps set/way ops
> and cleans the whole address space by VA on behalf of the guest, and on
> most v7 hardware, the set/way ops are in fact sufficient when only one
> core is running, as there usually is no system cache. But on systems
> like SynQuacer, for which 32-bit firmware is available, the current cache
> maintenance only pushes the data out to the L3 system cache, where it
> is not visible to the CPU once it turns the MMU and caches off.
>
> So instead, switch to the by-VA cache maintenance that the architecture
> requires for v7 and later (and ARM1176, as a side effect).

I took this v3 patch set for a ride on some ARMv7 and ARMv6
(hardware) boards using zImage:s so the compressed path
should be exercised:

- Ux500 (ARMv7 Cortex A9 x 2) works like a charm
- RealView PB11MPCore (ARM1176 x 4 MPCore) works like a charm

Tested-by: Linus Walleij <linus.walleij@linaro.org>

I can do more thorough tests with more boards if needed.

Yours,
Linus Walleij
