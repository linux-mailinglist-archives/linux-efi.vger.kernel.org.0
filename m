Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20527129AEB
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2019 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLWU5V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 15:57:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40554 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfLWU5V (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 15:57:21 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so17343498iop.7
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiMlIYDZgVwerUaTZ6obhkMnj0f8HmgcG1JFPzTHF9c=;
        b=HttetAeD/bPa++sR2aYSy7ret5VLsSn8HCubPt+49oisC6gx7J0+HzQWOVIqheOI3E
         rCWOtnfOnaNCMQdimdQJK4HP0yiyEpIjq6UN8WU1EmeU/u9eNJNgR90gmFOtbGezhRLw
         fsaHuc2fdi7UCF7bWccg+sBRgj/IMEoOW554cn8qCtGieCn/M/WCIxqSIrGMctyzhqht
         iga0b+D5UI1xTV1G3+X+NnqV0GNp2mvMdjwM2M4eOr6fEfID+i+gLejEpJ/xQuVuKWCS
         C0wGD8DnLD4/fHRV0v3COAO/mNzpVHSd0lZIst2ufPOImKAqY8LrkyEk7eQkVwhKg008
         VXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiMlIYDZgVwerUaTZ6obhkMnj0f8HmgcG1JFPzTHF9c=;
        b=kPxSSNbr9TDjOf7koyzHBSNSNiQZqmwxb2Cuu7F5Le/t9QgnkU124rtgF5vi1+fWIE
         1sjPm+O7qwTaYtGHn06eQncb5Z+wwxxLVTFRiaD1NP4xsN2tpPqujvjWVOnM1VKfOrV7
         P+4Fx7rQlXWqg/u4w12BMShaCGV148J8aPTPOVkgmtfL2ee1J8kMgem/tsL2Z3m6Oaso
         lL9qAy4gmlDzqR/NaG8dZj8GHSG4k0Sj76GMAUyydJcw979g204b3ZTtSnKMtEtzYT7n
         iqBmTre3Gd4D0O9EEpE1+cJqUfvAFHk+87YAVO7s1aj6fL0a2T5GM37xIVnPBcbYjeCh
         Xfkg==
X-Gm-Message-State: APjAAAUXGdqB4F4MgOhiHbKgHnx0c/ztV1XUodKmBeXi3Gkhb7dxdIIp
        g8370InREhnqzbc30MAAIFpYsjopFJgKYh9fhHITeA==
X-Google-Smtp-Source: APXvYqzu9TOeaCMm5KWoTbrrwoGEebKS9W2Za/yEiix2R3am1eB5Cqo0kBZaSA11WVf+SFsEKV6TYT/Yev1R8Z4OM9M=
X-Received: by 2002:a02:40e:: with SMTP id 14mr24641133jab.102.1577134640172;
 Mon, 23 Dec 2019 12:57:20 -0800 (PST)
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
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 23 Dec 2019 12:57:09 -0800
Message-ID: <CACdnJuuzNPBktKxk9wFMKJCay4hd+uVBRf4YXN47SxOk2Br63A@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Mon, Dec 23, 2019 at 7:46 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> Also, what about for eg, the USB or SATA controllers? I know that
> someone had said earlier that disabling BM on endpoints is pointless as
> malicious endpoints could just re-enable it, but is it not possible for
> malicious USB devices/SATA devices to try to use DMA through those
> controllers? ie if we trust the controllers since they're on-board, but
> not necessarily the devices behind them, wouldn't it still be worth it
> to disable BM on the controllers too?

The concern is DMA initiated by a hostile device. SATA and USB don't
permit the devices themselves to initiate DMA, whereas PCI does.
