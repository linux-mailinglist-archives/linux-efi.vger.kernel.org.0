Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F1129889
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWP6j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 10:58:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41745 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLWP6j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 10:58:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so17083995wrw.8
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 07:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKwtJraB71LUy+PEILjX1PP0gnM/mEjqoj5wLbqDS0o=;
        b=PHV+kUNeSt5T7oPce18CnuHYOPe+9jei0vFerVAYGC70EYOxYaeq3oheotPCPqLalF
         cf3yaCTBRp0Vwbxwg5R4ppL1A+tpQYnhuHrgZq6GpYjmq1Z2kjmW9g99v/NEJiJaUQRm
         nX+ZBQC40DiYkW1xXGgIfvHdz9B3gOQUX3RZTL0nHbexhh1WIiUY0u7M1f5HHbC9bMhy
         1TON7sbqcIgCnN8XLurNWkE9CoxslDe9kHNz2cW1mM6e1aPOMQ9vc8hHPLhTBFEskjXU
         ttyC7kudEvt+7HNJqNgdhUNDSMXjXmGtjTq0e/rRGCew6Iqbq9TayrGXnJ1c6Wi9k2S7
         6F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKwtJraB71LUy+PEILjX1PP0gnM/mEjqoj5wLbqDS0o=;
        b=gjOxUtYrdkN+BgakYiTDXDiegicgWyEeJU6Jdg+OY5rEZD9jmEkYZO2F94fzfvghmi
         r6rgRojmqR9rWmIfNaHjYp+/wK1rHKHfs3XzU4HZMb+m69AJH0t6xNk73+klzbqZURjR
         CuPH7WpN6SR0c6AQaJyqxKZTSKmvw1Ko0dVBOrrgrRj+JSedjVZRXTvtixc+zspC6Tm5
         aBZkE+UbcUS9FiqibCMyaN7oJkfdzl4PIyq1rY/6kMzThvRZ/KqP8X12rflcqVUeu3I/
         15z1MvcB90Lu5hWu5OBApoInhjFYGyGU+ymowEhsUIEvsSSqQfqn52Rd4F2DkEBKgwkD
         /7tg==
X-Gm-Message-State: APjAAAVvHa4lHSjfpG07DMjQIbmHshDCzoohCUqKihlft5mEUbnOqmv2
        LUQhn+TCCMHUK2VFfqI48S/z4RH11nIJNUcX5WVpBg==
X-Google-Smtp-Source: APXvYqyfAvz0LnHYPi7LXgTlzw12K+rmqx0VKhCCTG+9T77bEOuZS5Ve5iZLVqlMPbqFNsFjcc5lOz+XHXXQoiSIamw=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr28912116wrr.32.1577116717236;
 Mon, 23 Dec 2019 07:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
 <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
 <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
 <20191221225426.GA6970@rani.riverdale.lan> <CAKv+Gu-PmOo6mvaBELjxj=9hbLynidt4Yf_qyr6m9db=6SS7vw@mail.gmail.com>
 <20191223154648.GA10522@rani.riverdale.lan>
In-Reply-To: <20191223154648.GA10522@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 23 Dec 2019 16:58:26 +0100
Message-ID: <CAKv+Gu9kFVFdkaOGP2EYACa7eo4pTTKFif9ZgQ+uKnoKcsrmgQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Dec 2019 at 16:46, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Dec 23, 2019 at 03:02:40PM +0100, Ard Biesheuvel wrote:
> >
> > Practically, on PCIe systems, PCI/PCI bridges are the only thing we
> > need to care about, since that is how PCIe root ports are modelled.
>
> If I'm interpreting my lspci output correctly, I have a PCI/ISA bridge
> on bus 0 that's not behind a PCI/PCI bridge. Device 1f.0 below is the
> PCI/ISA bridge.

Yeah, this is the LPC controller, right? What devices are actually on
that bus that are not closely tied to the chipset?

> Devices 1-3 are the CPU root ports and 1c.* are the
> chipset root ports.
>

Right.

> Also, what about for eg, the USB or SATA controllers? I know that
> someone had said earlier that disabling BM on endpoints is pointless as
> malicious endpoints could just re-enable it, but is it not possible for
> malicious USB devices/SATA devices to try to use DMA through those
> controllers? ie if we trust the controllers since they're on-board, but
> not necessarily the devices behind them, wouldn't it still be worth it
> to disable BM on the controllers too?
>

At this point, it probably makes sense to clarify what the threat
model is. I have been assuming (but Matthew should confirm) that we're
primarily concerned with DMA attacks over, e.g., Thunderbolt ports, in
which case managing the BM bit at the root port level should be
sufficient.

If there are other things we want to address (or if my assumption was
incorrect), we should clarify this first, before deciding what the
right mitigation would be.

> $ lspci -tv -s 0:0:
> -[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D DMI2
>            +-01.0-[01]--
>            +-01.1-[02]--
>            +-02.0-[03]--
>            +-02.2-[04]--
>            +-03.0-[05]--
>            +-03.2-[06-09]--
>            +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
>            +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
>            +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
>            +-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC
>            +-11.0  Intel Corporation C610/X99 series chipset SPSR
>            +-11.4  Intel Corporation C610/X99 series chipset sSATA Controller [AHCI mode]
>            +-14.0  Intel Corporation C610/X99 series chipset USB xHCI Host Controller
>            +-16.0  Intel Corporation C610/X99 series chipset MEI Controller #1
>            +-16.1  Intel Corporation C610/X99 series chipset MEI Controller #2
>            +-1a.0  Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2
>            +-1b.0  Intel Corporation C610/X99 series chipset HD Audio Controller
>            +-1c.0-[0a]--
>            +-1c.2-[0b]--
>            +-1c.3-[0c]--
>            +-1c.4-[0d]--
>            +-1c.7-[0e-0f]--
>            +-1d.0  Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1
>            +-1f.0  Intel Corporation C610/X99 series chipset LPC Controller
>            +-1f.2  Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode]
>            \-1f.3  Intel Corporation C610/X99 series chipset SMBus Controller
>
