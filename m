Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8106F110550
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 20:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfLCTkg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 14:40:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34645 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfLCTkf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 14:40:35 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so5156183iof.1
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ch+WNijaY6AsPxm0+XePiTtapq06gZNm+FnTtW+Yvk=;
        b=cUiQ2WxJYfgxGRtIYYrBFgideFa64zwJVC0xM+vPn1heDbtP8PS8yhn2SslWuKeDcv
         qhLffbJ3Uo+Xo+PBrM9d1srYRC+HpClcuPS7jDcp7nCHYvNKj3tAiPHBPOeKB6nyEJgr
         hAziOs01GF/Nm9RN1Ac/APBu0vvoX7TLuXjbEo16RDF+snyauxsyRnPMV36z/iiP3SDn
         hKDznvFTSRzqAqz2WkQLpDHNKsS+cvsRHjWorCY9fY2HMWbBfkQv7Akz/++xiyUkfxYF
         soTgico8aclq+HXraOhqfo7I5eaUa1BR59m74mMTlpG6jLAnZo16mBg2DDLjOz1EzXtX
         1Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ch+WNijaY6AsPxm0+XePiTtapq06gZNm+FnTtW+Yvk=;
        b=en4r+oHynQJ4eL60/cFbDYAUEUuWANiFY+kIzV9MGKdjpyQ1WoTE1z/aX8nvIFaed1
         2a5rJIP6LhcEh3PM2K/n58SrxiGMnKa3nsTZkgZeuJ/NpoZDHpfnrNl5lEfsavZPD3Wx
         jkQo9kHRGhKQIUB2lHgCQ9QpvuaH8yxoMrD1ZuAMnA4Wj/s9kVrrmj8Xs7JFte5zw69J
         EPERfLivnKQTRfWiGlsoQyu0ByfaN1C3mZCuD5WV2h7pAV9i502P8NDxoP9tKxf8ia+K
         aOc4kGzPLqHmyL/Zlsu8DicYUHsIH/FM5dr3oqGO4NRMsDIwrLR5S+FUeE1kuLgQ4A5E
         axFQ==
X-Gm-Message-State: APjAAAXeRnDql2tKfY/JHrMCRxKvbbjUIzImNOGP/LHLeC8j3vaW5Wr4
        ZKZ0wUL+yWfmntbUqbqTOHUp6Ezl6S0z9TF6vmzg0g==
X-Google-Smtp-Source: APXvYqycuBVBV4ixbORLjq5bU2odtfEntOXSTXVTJDzP7mv/SVY3vXetQWjJOUPobARr4NVuoGg3ywXDKlHjyRak6ng=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr3715528ioq.84.1575402034437;
 Tue, 03 Dec 2019 11:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com> <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
In-Reply-To: <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:40:23 -0800
Message-ID: <CACdnJusMeC+G3wq_oDGTYi1CBMWDiuq4NdANTBmhNBTDu5zCug@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 3, 2019 at 3:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> There is no reason this shouldn't apply to ARM, but disabling bus
> mastering like that before the drivers themselves get a chance to do
> so is likely to cause trouble. Network devices or storage controllers
> that are still running and have live descriptor rings in DMA memory
> shouldn't get the rug pulled from under their feet like that by
> blindly disabling the BM attribute on all root ports before their
> drivers have had the opportunity to do this cleanly.

Yes, whether this causes problems is going to be influenced by the
behaviour of the hardware on the system. That's why I'm not defaulting
it to being enabled :)

> One trick we implemented in EDK2 for memory encryption was to do the
> following (Laszlo, mind correcting me here if I am remembering this
> wrong?)
> - create an event X
> - register an AtExitBootServices event that signals event X in its handler
> - in the handler of event X, iterate over all PPBs to clear the bus
> master attribute
> - for bonus points, do the same for the PCIe devices themselves,
> because root ports are known to exist that entirely ignore the BM
> attribute
>
> This way, event X should get handled after all the drivers' EBS event
> handlers have been called.

Can we guarantee that this happens before IOMMU state teardown? I
don't think there's a benefit to clearing the bit on endpoint devices,
if they're malicious they're just going to turn it back on anyway.
