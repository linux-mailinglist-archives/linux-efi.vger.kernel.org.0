Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E03129870
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWPqw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 10:46:52 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:36490 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLWPqw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 10:46:52 -0500
Received: by mail-qt1-f177.google.com with SMTP id q20so15721140qtp.3
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 07:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5mGrvyyns2Gk/zlvNkCZf7geATX/5PDTOksfWRjxtA=;
        b=ErM/fpRPjkXDeHq5U6k8zT6VkoqSERfDzhaF/LYA5Ndp+r6rfQPiIhjTvtU4W1o/YP
         ViLgEXGHpeY0jsXNwe5PiJHWD7wdTlov7A+EJ4TjxDdvQMgXy/TRKbJCqzJ56IXs4xK0
         RUjWsvGmEPvQLWgDrX71R/f6ny1KDwq/0+VDI8BeBJVT21LJqHDmUNaMmdbU4XKopd/x
         pgwJDmiFAaDryWjDvghjMEU9yIOyzdKkyIUWaO+AQw8GZaqNYHAxTJ48tJEtrpKm9aHS
         8qcAHMfNguh6AnZOMiCTsoeTfKD1NEBSnjW9fPLEapl0B9TkbZZ2ibOL1Zhi9QGykFiv
         hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5mGrvyyns2Gk/zlvNkCZf7geATX/5PDTOksfWRjxtA=;
        b=KKeB3yk3LlPn+AcsuYQoX4bbueeD3ccHjSBVP2Rv9EqUO8edn4/uDwhXIxRY++ejZh
         5RIBxSISJh+D12UJvZXjNYevP8+4fPq5EIzZMrjiPDGqIS7XRRj9m5DLIqhqjkFQAFWX
         lUWbx3wfsFaFhSgYTWhlv0hqdgLCTIQ4bzddVzGzzIllcMDVzEAYyWzZqzfxHUHcNhCX
         qzKZr/QGTrOQbYqRekk5BMpUq25eRtpm11RUf27/lUlfQW7VD9AhMCCjKOD1a02Fhkwu
         rXrl3QlGHoDGaELaauAA6cnBHKqPqFkkaKIlddpXwA4jQU1wTSPUAUGtDA7x5mEu1PZB
         jcHg==
X-Gm-Message-State: APjAAAXYXC493yyZoLOmQIlpKg3MG3zPIAaewgzCYdtGqKjkFPBiIKv7
        ch9Nnlr/tBBzNjF2e8y/KU0=
X-Google-Smtp-Source: APXvYqymFbwaxfIwZAgw4mqepIvUB7/2Oo8l5+B9QTX93NTtwIcxsPZYerX03Xc9Vi17eZ926NGYTQ==
X-Received: by 2002:ac8:685:: with SMTP id f5mr23143665qth.199.1577116011309;
        Mon, 23 Dec 2019 07:46:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k14sm5829801qki.66.2019.12.23.07.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 07:46:50 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 23 Dec 2019 10:46:49 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on
 bridges during boot
Message-ID: <20191223154648.GA10522@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
 <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
 <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
 <20191221225426.GA6970@rani.riverdale.lan>
 <CAKv+Gu-PmOo6mvaBELjxj=9hbLynidt4Yf_qyr6m9db=6SS7vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-PmOo6mvaBELjxj=9hbLynidt4Yf_qyr6m9db=6SS7vw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 23, 2019 at 03:02:40PM +0100, Ard Biesheuvel wrote:
> 
> Practically, on PCIe systems, PCI/PCI bridges are the only thing we
> need to care about, since that is how PCIe root ports are modelled.

If I'm interpreting my lspci output correctly, I have a PCI/ISA bridge
on bus 0 that's not behind a PCI/PCI bridge. Device 1f.0 below is the
PCI/ISA bridge. Devices 1-3 are the CPU root ports and 1c.* are the
chipset root ports.

Also, what about for eg, the USB or SATA controllers? I know that
someone had said earlier that disabling BM on endpoints is pointless as
malicious endpoints could just re-enable it, but is it not possible for
malicious USB devices/SATA devices to try to use DMA through those
controllers? ie if we trust the controllers since they're on-board, but
not necessarily the devices behind them, wouldn't it still be worth it
to disable BM on the controllers too?

$ lspci -tv -s 0:0:
-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D DMI2
           +-01.0-[01]--
           +-01.1-[02]--
           +-02.0-[03]--
           +-02.2-[04]--
           +-03.0-[05]--
           +-03.2-[06-09]--
           +-05.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management
           +-05.1  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO Hot Plug
           +-05.2  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D IIO RAS/Control Status/Global Errors
           +-05.4  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D I/O APIC
           +-11.0  Intel Corporation C610/X99 series chipset SPSR
           +-11.4  Intel Corporation C610/X99 series chipset sSATA Controller [AHCI mode]
           +-14.0  Intel Corporation C610/X99 series chipset USB xHCI Host Controller
           +-16.0  Intel Corporation C610/X99 series chipset MEI Controller #1
           +-16.1  Intel Corporation C610/X99 series chipset MEI Controller #2
           +-1a.0  Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2
           +-1b.0  Intel Corporation C610/X99 series chipset HD Audio Controller
           +-1c.0-[0a]--
           +-1c.2-[0b]--
           +-1c.3-[0c]--
           +-1c.4-[0d]--
           +-1c.7-[0e-0f]--
           +-1d.0  Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1
           +-1f.0  Intel Corporation C610/X99 series chipset LPC Controller
           +-1f.2  Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode]
           \-1f.3  Intel Corporation C610/X99 series chipset SMBus Controller

