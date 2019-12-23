Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6E129899
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLWQM1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 11:12:27 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45773 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLWQM1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 11:12:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so6504393qvu.12
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tk71JQngaMAIzNPkkgd8t13g13HLGutomGGTzi0KCmU=;
        b=fTifpCmR/0kiTE0DX0JcrhlxcjX7GkJaT5UOwXNYvut0G+6HBUhMlmVEKZiLbAVB/F
         DvOfvVH6uQ+lgN2MhHHRHqMgwTxFAHIEafB6dFw0aXIU2a2DOQMgfAKwMGCkRX07GxDJ
         TS4m/h5xOFM1i5kmORJ4Gn1NrBbT3m7QFMrUN9Smfte84mU/6ly85mfYcBuvClCjkKPv
         zdxEa/96OX9vn/wDikhSKOg01rGxlCPo1SK+5lrbTv3HKG/MOtEhzvaIjkG3N1HOLTZ+
         LRi3ZW40xDbGOuB/IFjEwTLYpMpy09oSr2MrEEHmRmm8VdKLkOb4LN88u9cWYoRdlP/t
         Cjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tk71JQngaMAIzNPkkgd8t13g13HLGutomGGTzi0KCmU=;
        b=qsBh9AmXwHGrRmKidmiRipYaye7cxJNQvasSAl9AUntTgABHI7QR698zavUaLqC0Fx
         zMAfEKwiRi5aggxpjn3KdTNdkgxooWh+eW4lRF16dl5oUPBn2SD8ADB+ukXF9ZHrZ2g4
         Ca5uAu6GJ+i+0uN/T4aVNdcs00DAwNOQSDNr4RsE9GG17HbUTatl7f0cPy75cQs8OFDT
         dj/QxRDPHglv23RETUnewiS5vwYg3Gr8yzD6b2W30uAm5LyWcYLnhbrDqL+SujB1Hvyy
         aNclFXiTcVvGAc2lWeDGmrDbCJmxVyvhRQbeOq9lGvqdztaohJNq2b486KEILUrAny18
         QXrg==
X-Gm-Message-State: APjAAAXgcW4qQgYokBiVVEw/cRJerW0W7TZALxpWgUeMGwHYqWu9GQqo
        onjxdyo/0PkKOaZlb1nEMPM=
X-Google-Smtp-Source: APXvYqzoRSp64k3I7G4OoMaGh6YgsieIyKC9J7Dp/4atnlJk4Hm2q+ycKFNTktrM0i57jqOeOKr5kQ==
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr24116765qvb.133.1577117546254;
        Mon, 23 Dec 2019 08:12:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 2sm5901419qkv.98.2019.12.23.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:12:26 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 23 Dec 2019 11:12:24 -0500
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
Message-ID: <20191223161224.GA18630@rani.riverdale.lan>
References: <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
 <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
 <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
 <20191221225426.GA6970@rani.riverdale.lan>
 <CAKv+Gu-PmOo6mvaBELjxj=9hbLynidt4Yf_qyr6m9db=6SS7vw@mail.gmail.com>
 <20191223154648.GA10522@rani.riverdale.lan>
 <CAKv+Gu9kFVFdkaOGP2EYACa7eo4pTTKFif9ZgQ+uKnoKcsrmgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9kFVFdkaOGP2EYACa7eo4pTTKFif9ZgQ+uKnoKcsrmgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 23, 2019 at 04:58:26PM +0100, Ard Biesheuvel wrote:
> On Mon, 23 Dec 2019 at 16:46, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, Dec 23, 2019 at 03:02:40PM +0100, Ard Biesheuvel wrote:
> > >
> > > Practically, on PCIe systems, PCI/PCI bridges are the only thing we
> > > need to care about, since that is how PCIe root ports are modelled.
> >
> > If I'm interpreting my lspci output correctly, I have a PCI/ISA bridge
> > on bus 0 that's not behind a PCI/PCI bridge. Device 1f.0 below is the
> > PCI/ISA bridge.
> 
> Yeah, this is the LPC controller, right? What devices are actually on
> that bus that are not closely tied to the chipset?
> 

AFAICT it's my BMC's IPMI interface and some sort of watchdog I think --
don't have drivers but there are three other ACPI PNP* nodes under there
as well.
