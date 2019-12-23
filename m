Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051C41296BD
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWOCx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 09:02:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44505 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfLWOCx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 09:02:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so16706167wrm.11
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snMGWXrUZOPplEEsasOHR7//XzlNhprHe7UMsqo+aRc=;
        b=Sah3zn6T0AKCrmKx1KpO/JlU+BzKyDbJMHrflW5Su0FRdT7wspY16rqNPHiumuSZcZ
         cMAsZ+hznnhLWiNbgobVRsuRCNAh07p3wI46QgaaMSAkqJVRQRIAgdwrlVFPyiWR6hIO
         0pLNi+Mvwjbt/IAPHJJv3PVn3PuLWiodtLIKPypvdaY8hKSifpNQfdY/40kfcTHPrqtw
         CPbP++gWWNH+I244Fc716jmiZFHwWblxRNNuNG5RUqJI5t5/S5SQlZ6YhXiv7yaaNxnD
         jo7KNDjqavklxsnrTAxJv8sPSRuAOBcdUYfepvHuI5rFFHcS5eupXSAoRrnt1ov5fuqp
         J09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snMGWXrUZOPplEEsasOHR7//XzlNhprHe7UMsqo+aRc=;
        b=flln+PpLugAPkgtb/1dW2P4MLomRnduHtrIXvDDP6kwsXpI/dsbpbpxMRrweZL3xkr
         4nwQub2hDlXMdv+gkToqZiGm6TXMjhfEMeHhUDZUtIXqFGdanx7QjnSCgRLQLb+ZwMdy
         WJwNu418Iye/T9xiApbzVxYanfhU+4Lhtr++b2yX6sB62dIdnkfBE9q8bTVMdX4WUDe9
         vuWiwQXtP2kq43yC7OHv5JzdQrsDtS5cpyduv87W7GMGjtD6zJDryGOyV/fwoDd2KBxG
         SsZ8H6u+MqKHwZVuNXF73TgsfLmuVPJ3uF2NaMQGm0kjNU5+ad6Ol++uYyjMR7ff9i50
         eW2Q==
X-Gm-Message-State: APjAAAX58K2XJ3zLutR8LZ/Wc4uU9geJF6LwuAuVdRzLOMCkqTdeYQtj
        S3wBMWgGZTX1gJ3DYaB0/Hxb38fYzocXVszbd2ppWA==
X-Google-Smtp-Source: APXvYqwTkldDY1GjcrXq/YhQhDB3OqQTiolPzlp7SxLYJrqfKX+rQDRJl33hesIJhMl8BckI3OYYV61MKhPP8yrht/o=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr29695712wrs.200.1577109771044;
 Mon, 23 Dec 2019 06:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
 <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
 <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com> <20191221225426.GA6970@rani.riverdale.lan>
In-Reply-To: <20191221225426.GA6970@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 23 Dec 2019 15:02:40 +0100
Message-ID: <CAKv+Gu-PmOo6mvaBELjxj=9hbLynidt4Yf_qyr6m9db=6SS7vw@mail.gmail.com>
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

On Sat, 21 Dec 2019 at 23:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 21, 2019 at 01:24:16PM -0800, Matthew Garrett wrote:
> > On Sat, Dec 21, 2019 at 8:44 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > Point taken. I like Arvind's suggestion but we need to take care not
> > > to disable the device producing the GOP. Beyond that, it should be
> > > possible to disable all devices that are behind PCI bridges. It does
> > > mean we need to decode the secondary/subordinate bus values from the
> > > config space and take them into account when iterating over the PCI
> > > handle list.
>
> Why do we need to look at the bus numbers? Shouldn't it be just looping
> and disabling everything that's a regular device in the first pass
> (possibly excluding devices that are producing GOP/UGA), and then going
> over it again to disable the bus-master settings on bridges?
>

Yeah, that would work I guess

> Also, why do we restrict the bus-master disable to only PCI/PCI bridges?
> Shouldn't we also disable bus-mastering on all the other PCI-xxx
> bridges?
>

Practically, on PCIe systems, PCI/PCI bridges are the only thing we
need to care about, since that is how PCIe root ports are modelled.


> >
> > The device producing the GOP is the device that I'm most afraid of, to
> > be honest.I'd naively expect that anything presenting a linear
> > framebuffer will probably leave it up at disconnect time, and we're
> > definitely not using DMA to access that framebuffer.
>
> At least on my system, disconnecting the GOP device does leave the
> display up, and the framebuffer remains active (ie writing to it updates
> the display). It wouldn't be surprising if this doesn't work for all
> GPUs though.
>

Disconnecting a device should result in the protocols installed by the
driver to be removed again, and this also applies to the GOP protocol.
Whether or not the framebuffer is still live after that point is not
entirely relevant.

But if the GOP it produces is not BltOnly and its framebuffer address
doesn't intersect system memory, it should be safe to disable DMA on
such devices.

So in summary, we'll need to do

for each PCI I/O handle {
  if (bus == 0 || // not behind a bridge
      type == bridge)
    ignore;
  else
    disconnect();
}

for each PCI I/O handle {
  if (type == bridge)
    disable BM bit;
}

Disregarding bus 0 means all the 'special' devices integrated into the
root complex are disregarded as well, which seems safer to me.
