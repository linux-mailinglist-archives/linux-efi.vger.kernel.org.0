Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650D6E6D77
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 08:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJ1Hqn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 03:46:43 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34886 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfJ1Hqm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 03:46:42 -0400
Received: by mail-wr1-f44.google.com with SMTP id l10so8707814wrb.2
        for <linux-efi@vger.kernel.org>; Mon, 28 Oct 2019 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXggoMr6TPefIjruk1V26dPCbcmEQg0JH5FI8IysJRo=;
        b=rk4+AJ8nyMt28tdWbyvdsOMoDYE+i2ATrZro4GHe2b9n5E8VnXI8G6yl6isooXMS/0
         0ftjhVuBwpjkcbSZMGgsmegUrzcWl2QtGaZ/GvMcUIYGZLCAmigKwxADLvyhTZKcI5i9
         Y1n9JUau2DYXTbd8hpteGQ9FGG2lW6ADmUpbH83YJepg+ZQQHjZiCkCNdHJVafuuzi+0
         Amn2/O3zRrrNLj7WmeVj9gMf6MS82x1Ylpf0Rhif0/I22hjc5HcKsE9a6aWhISoGKri0
         Mkwk1e6oua1kBqlSYyHi5PoqvS3XHXj9+g7l3dDohV5cua4JgDRj+dEoxvUkHsij1eug
         Y3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXggoMr6TPefIjruk1V26dPCbcmEQg0JH5FI8IysJRo=;
        b=tq4m1LFmH2PZSvTwGAfOigsBB7v3yNtaWl2D9qH/6gB3A7eMiVwHYREl0TgA+RUYG7
         B/VokfMyXuBCPET3tfKb6wR16G1Ny1Od3FtRz9TGsMrq0TYN0Ry2hiTGbUJ4vpcojkg1
         lXkwnLR4OIblfGxmtjUHhxpnKOkgIb3KeyDwxsuuz0dBD22x0NaeHLMYMS+HGSQxMERq
         pHmaGRXP7siZL54dKEQLE5owoDdhBb9gDA54IQEi+jYjuTKBoElo5d7ud5o0cnWxGyMe
         FluqqDmTQpybElYRPZkEaaxsrJbKf4oreaFwqVvwSyHCnjogJE/Ex9y5hTbB4Et/GCDK
         jE/g==
X-Gm-Message-State: APjAAAW6WpFYtTY1FIxd4zD81EZgB1n7A92LcT7SBE2kw7TWcBPn9I2j
        fvKzz60xApRrv4QTNtui4ApAEcaHMOLdcBo5tGFXgw==
X-Google-Smtp-Source: APXvYqxPjdRrBCat/z+Y/ktrD5+eP35/VUhqqOX1pS13q8vTbicHNHyK+rQT3KV0nKVP0RtoZzHxauWa6NuoG3eg0wU=
X-Received: by 2002:adf:9f08:: with SMTP id l8mr13163484wrf.325.1572248798818;
 Mon, 28 Oct 2019 00:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113753.GA77634@light.dominikbrodowski.net> <20191028072036.GA113601@owl.dominikbrodowski.net>
In-Reply-To: <20191028072036.GA113601@owl.dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 28 Oct 2019 08:46:28 +0100
Message-ID: <CAKv+Gu-RcHfupXzZaK3UK1x+fkffGind8JP_4fZ95wBXuasJoQ@mail.gmail.com>
Subject: Re: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Dominik,

On Mon, 28 Oct 2019 at 08:30, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Ard, Mario,
>
> in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
> BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
> Using my patch from a few weeks ago[1], efi_random_get_seed() is called from
> arch/x86/boot/compressed/eboot.c::efi_main(). In efi_random_get_seed(), the
> calls to
>
>         status = efi_call_early(locate_protocol, &rng_proto, NULL,
>                                 (void **)&rng);
>
> and
>
>         status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
>                                 sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
>                                 (void **)&seed);
>
> succeed. However,
>
>         status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
>                               seed->bits);
>
> returns EFI_INVALID_PARAMETER, though I can't see why one of these
> parameters is invalid.

The UEFI spec defines the conditions under which this function may
return EFI_INVALID_PARAMETER as

"""
RNGValue is null or RNGValueLength is zero.

"""


> When trying to use the default rng algorithm (by
> modifying the test to "(status != EFI_SUCCESS)"),
>
>                 status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
>                                       seed->bits);
>
> the call doesn't seem to return.
>
> Any ideas?
>

Try running this from the UEFI shell:

http://people.linaro.org/~ard.biesheuvel/RngTest-X64.efi
