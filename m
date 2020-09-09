Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D028C26309C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIIPcl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 11:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbgIIPbc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:31:32 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66B922283
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665438;
        bh=A58R2FwpUk+Bv6cIGIrRQlDvLoWAI4dMEu48+3I7uSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hV9ES6+EQyRJTCs8sTquOUtviNCTiNtTXcoGJIj0+i18niZEno34dQMlBVXjWs5nF
         6aFeAhACrfDq0ZTn+S3cpe/qPcstup1lpj8oUwNGOTMX2zHkMUDEUOoCXojIqtDy5u
         sE997awefMQAUNxDQ5iI7QGbdkaRa1mxBpGwvveo=
Received: by mail-oo1-f49.google.com with SMTP id s17so669801ooe.6
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 08:30:37 -0700 (PDT)
X-Gm-Message-State: AOAM533w++ZUYZQ5AU6YZsoIYIMOEUHrlGZvQzKZc6ZvIoZyIuuppwkN
        ojtFq7J3b4JOXR0dvqmMkRq/n0uJn/JGb3zAP0g=
X-Google-Smtp-Source: ABdhPJz3B4t15hMJe1o9XqYUkGhgjNuE9BYBuLbPapwiG5EN+HYguvsehK0+esAd6EzUpksmXTdhrErc2NpvXfTmNaw=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr1177486ooq.13.1599665437106;
 Wed, 09 Sep 2020 08:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200909151623.16153-1-ardb@kernel.org> <5b4c9d0f-d0c1-4627-d000-3bdf093b252a@arm.com>
In-Reply-To: <5b4c9d0f-d0c1-4627-d000-3bdf093b252a@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Sep 2020 18:30:25 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEroKLMNdh1vDeDHMqvnW4mCvKBuU1ZGtE2FrqUrx0wcw@mail.gmail.com>
Message-ID: <CAMj1kXEroKLMNdh1vDeDHMqvnW4mCvKBuU1ZGtE2FrqUrx0wcw@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on dram_base
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 18:26, Grant Likely <grant.likely@arm.com> wrote:
>
>
>
> On 09/09/2020 16:16, Ard Biesheuvel wrote:
> > Maxim reports boot failures on platforms that describe reserved memory
> > regions in DT that are disjoint from system DRAM, and which are converted
> > to EfiReservedMemory regions by the EFI subsystem in u-boot.
> >
> > As it turns out, the whole notion of discovering the base of DRAM is
> > problematic, and it would be better to simply rely on the EFI memory
> > allocation routines instead, and derive the FDT and initrd allocation
> > limits from the actual placement of the kernel (which is what defines
> > the start of the linear region anyway)
> >
> > Finally, we should be able to get rid of get_dram_base() entirely.
> > However, as RISC-V only just started using it, we will need to address
> > that at a later time.
>
> Looks reasonable to me. Presumably all special cases (platform specific
> spin tables, etc) are covered as reserved in the UEFI memory map, correct?
>

Yes. The only reason the code is as it is today is for a proprietary
HP Inc. platform that had a bootservicesdata allocation at the base of
DRAM of 8 KiB, but this should now be covered in the same way as any
other reserved region living in the window below TEXT_OFFSET. (Note
that the current logic is flawed in any case: even though boot
services regions are released to the OS at ExitBootServices(), there
are types of EFI configuration tables that keep their contents in
BsData regions as well, and those may get clobbered by the
decompressed image)

In summary, I am not expecting these changes to regress any platforms
we care about (famous last words), and if it works, we can start
removing the dram base handling code altogether (which currently gets
called on arm64 as well, even though we never use the result)
