Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67447820DB
	for <lists+linux-efi@lfdr.de>; Mon,  5 Aug 2019 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfHEPzO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Aug 2019 11:55:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36702 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfHEPzO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Aug 2019 11:55:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so85013350wrs.3
        for <linux-efi@vger.kernel.org>; Mon, 05 Aug 2019 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnsluh819l1ZStKbmfOcG3O4jnLq32HWa/lDwn+83Yg=;
        b=nIKF7wwwI0QPjCu0IOvAfwL8Hr2Lr3IyHpP1+ypF27lI+2iwFL7eal+6vIO+rqw+Mt
         LXAwxw+s2ChlfUXNMEXSxChFPEyBlt2mrI7syMIUMzAKRifN913by3ykVqN0/d6xl7XU
         45yp5Dbam98j3f3E/3LUUY2skj+VRIR6Q8k8Rg31HD71xr5EqDX6gQ6cap/HUwc24hja
         S7D4kueITTfZcQpcEVxOCeYR8beovQfohGrp1HjLWzMgb2ix1D3u4rlYkfqFYgbvAlqx
         BgcR5X7htSE1LfbrPS4WmeTMbUqF3oBy6DHpwH+405NuzlAK/rx/oVE5GFOwT1brTawU
         LZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnsluh819l1ZStKbmfOcG3O4jnLq32HWa/lDwn+83Yg=;
        b=VRJNY9/AD5Y9/ePl+FX1US2F3qFmQGe4uvE9allnwCh6oQJcV/l/ph4gZkwZloXqh9
         gM8P0MSGnX/bAtbxskT23O4+BCi3CcKhf1pvSpLuIDt3G7/MkynW4Q76hUKWUZiwW2Vg
         UrWdltu9Z5M3UZFI4GVVdNibmpBF+qBdjjLC+nQU4jBfnfPGxcXGwgBdUGLh5P5g5hF1
         GNfcjf6oeJYOwGqKeShKhicKsh1XTulAO8XBusg15GKf1ANCkSfg+PYntrdwueeI9Cdm
         4oyqT5Q5fHZSK2CXuFi9kbzGUQ1hVDFVrA9Ao0LBIePEtR6ZgvZttOdsyQZ8WffEVKxB
         zuyQ==
X-Gm-Message-State: APjAAAVUpht4NXOipkAPAZJWADacPIUXvtSj9koWSIkqrMh14sTur5ug
        L+kuYalNVlwdlAQfrnKyVZRE3eSaKJYuUNJaf/AVPw==
X-Google-Smtp-Source: APXvYqzYjhwZn5w5yyV/Vo+58zqgFvAH23OEi6QSh7dNxwvBI9af8UVivxjFT+LneGo0eAeVs1mIu/sfzpI/ECNUVHU=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr26762663wrs.93.1565020512761;
 Mon, 05 Aug 2019 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Aug 2019 18:55:03 +0300
Message-ID: <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 5 Aug 2019 at 11:36, Dave Young <dyoung@redhat.com> wrote:
>
> kexec reboot fails randomly in UEFI based kvm guest.  The firmware
> just reset while calling efi_delete_dummy_variable();  Unfortunately
> I don't know how to debug the firmware, it is also possible a potential
> problem on real hardware as well although nobody reproduced it.
>
> The intention of efi_delete_dummy_variable is to trigger garbage collection
> when entering virtual mode.  But SetVirtualAddressMap can only run once
> for each physical reboot, thus kexec_enter_virtual_mode is not necessarily
> a good place to clean dummy object.
>

I would argue that this means it is not a good place to *create* the
dummy variable, and if we don't create it, we don't have to delete it
either.

> Drop efi_delete_dummy_variable so that kexec reboot can work.
>

Creating it and not deleting it is bad, so please try and see if we
can omit the creation on this code path instead.


> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- linux-x86.orig/arch/x86/platform/efi/efi.c
> +++ linux-x86/arch/x86/platform/efi/efi.c
> @@ -894,9 +894,6 @@ static void __init kexec_enter_virtual_m
>
>         if (efi_enabled(EFI_OLD_MEMMAP) && (__supported_pte_mask & _PAGE_NX))
>                 runtime_code_page_mkexec();
> -
> -       /* clean DUMMY object */
> -       efi_delete_dummy_variable();
>  #endif
>  }
>
