Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99299128BD0
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2019 23:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLUWya (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Dec 2019 17:54:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42633 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWya (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Dec 2019 17:54:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so11868767qtq.9
        for <linux-efi@vger.kernel.org>; Sat, 21 Dec 2019 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NUA0tMPiPo9iWvCXq9WCqpgMF6/3sYhocP4B0+hPSxQ=;
        b=kY5f0cda8vbogd8qULhOBANXLI5LrvZXJTXZM2lAU0LF2dAv65jdjJYEMFyhpSbWMN
         XHAQCsqyBuV+IPjYrwF6c8CYC053cSk7o2pF3AMHPZyfASj4NT2KSABTMZa53vr60g2I
         5bswxu4hnTLJiiKP48YHJhnnD3nlOHdWyg41WSxpQAR1u9Djy9WI2zFWvPrvIayRmKhQ
         zibkqeFn/yUO9yYdNDXEOdloS6BNu3tp0XkF9jpAiTaR1LIgKqxMNgdLrA4Qv3zzK01/
         NcegfEgCQ1bSvQykIS/SSA9a1oWwj5qUVRhOMdz0RcDWh/+7Uk4lWV+4/kY8xcZH1ae6
         O7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUA0tMPiPo9iWvCXq9WCqpgMF6/3sYhocP4B0+hPSxQ=;
        b=hdulkLQy4vPI/B9pkYhEilXY3xrX9rBXAJaMajrvR6QQHKyHb14IgaiId3DhY9yc2p
         4qQnYw6r1qdGMSmRrxm87F8uRkFkTWOsyOugx6aUeMoIg+bgRG9a9SYqVzSjiQRvLdPD
         6bMseEmFZsDV+CGFDPXHD52SwuyCOAsUODItdqECN9o+h7duvpAZbZa59FH/zn+fFYth
         IwMT5faOxFDqEz9SSpNQFWGsrfaJ6HCz1aX+AjBxVLWjiGBwY1IIBUUnimfs4fNBv9B4
         WLndtDoaMZSkijk3/RTeeq2Jd+iE1eGRfdrEvUen5rGikPvBtpXyEl8IvlnSGc74IXPt
         LOQw==
X-Gm-Message-State: APjAAAVZi9QbeAO1q4MpcSnFiof34dBBsYxMwNBWkafJdxfplSj87w5B
        0jC1jwgyJ7r+7RA0cXEast9YGiWdaZY=
X-Google-Smtp-Source: APXvYqwctCnOq2jupKhqJHx1WI+5CESSArkuZ6n+CxwI3QSxU205YKj+40MKolpnrGEe6+NNNdkHjg==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr17742450qtj.106.1576968869548;
        Sat, 21 Dec 2019 14:54:29 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e2sm4270856qkl.3.2019.12.21.14.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 14:54:29 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 21 Dec 2019 17:54:27 -0500
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on
 bridges during boot
Message-ID: <20191221225426.GA6970@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com>
 <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
 <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 21, 2019 at 01:24:16PM -0800, Matthew Garrett wrote:
> On Sat, Dec 21, 2019 at 8:44 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > Point taken. I like Arvind's suggestion but we need to take care not
> > to disable the device producing the GOP. Beyond that, it should be
> > possible to disable all devices that are behind PCI bridges. It does
> > mean we need to decode the secondary/subordinate bus values from the
> > config space and take them into account when iterating over the PCI
> > handle list.

Why do we need to look at the bus numbers? Shouldn't it be just looping
and disabling everything that's a regular device in the first pass
(possibly excluding devices that are producing GOP/UGA), and then going
over it again to disable the bus-master settings on bridges?

Also, why do we restrict the bus-master disable to only PCI/PCI bridges?
Shouldn't we also disable bus-mastering on all the other PCI-xxx
bridges?

> 
> The device producing the GOP is the device that I'm most afraid of, to
> be honest.I'd naively expect that anything presenting a linear
> framebuffer will probably leave it up at disconnect time, and we're
> definitely not using DMA to access that framebuffer.

At least on my system, disconnecting the GOP device does leave the
display up, and the framebuffer remains active (ie writing to it updates
the display). It wouldn't be surprising if this doesn't work for all
GPUs though.

