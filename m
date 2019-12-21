Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8929A128BB7
	for <lists+linux-efi@lfdr.de>; Sat, 21 Dec 2019 22:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLUVY2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Dec 2019 16:24:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41582 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfLUVY2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Dec 2019 16:24:28 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so9245092ioo.8
        for <linux-efi@vger.kernel.org>; Sat, 21 Dec 2019 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfAh1pcC0obslw2olIYd1gBQMLt/j28C8VMm3zWeLYc=;
        b=YL4rOSbJ+s5T5NBsup1epwMBQ4puwCBWlmYLNujCPCdHflnfxKd1ZTGSJ9Eoul58Xm
         ooDavU9tb6TRuAwzez7cLjM8G6PuXH593vUmuxFoz82iHLcUCyG2bDFsG2S9TtDychK6
         TiCSc/OwZ5ani7ig36rxJObrwk5BCbX1uddJSZBrI9JjCUWCZRFoEOq9PfxIXtEDgF+1
         ydHAiSPX8OEn+PSzYnAbKWrBdrwz59txRsH2wzziRnlKYFvXtWUxdqUZmAXmlEZoJ2Z4
         6O0hmTd85enU2EmR45RpzibzyA3sH6BQmWuBaZz90+ZmZi2l9je8WJKa4VYei7+mQygd
         +FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfAh1pcC0obslw2olIYd1gBQMLt/j28C8VMm3zWeLYc=;
        b=Lwv0O8XY7T70xkNi5tFdzYMv/8qWEVLgjPMhKxrecBM/Zhxf/m56xsNtvOFO0J9ffU
         DWVRTn1M+L51VfkBX/eUDSAvifvY8M3Dh9KC0JCMcWcOiFCxcNycaLZ+HCpcAOzzsb4A
         O5B35Ay17gVpZVORJa+UZQBqyRMTRxojXxUGhLHrB2O6VyPlAS379Bqn75YQk4HcOs0r
         m7tf66riTQqF9r4Ds1OWuGNZlmjfP6T2RHliTPfDULg5KWvNYujuEd6eK9dqc8IcPeET
         imtqJyKluPosDl8p5TiQx1ipf3CTKqSu34tqVcqCVMnVQBg++B4n2D8OrZFzltsVQrU9
         00fw==
X-Gm-Message-State: APjAAAWIYUyyoFItwsO5f5zG4hzLaMCR04YdSG6QKiH7/jiu/T5zVEiS
        tbgd2Mv4XPJg3yBsbTxLRfySBHTUW6safaE6ZsunGg==
X-Google-Smtp-Source: APXvYqzeT6fHHFwpBSQ3bM2tImcqhlQKKsNml0a5C+eSeFBB8LrDt0PiCL2HhlJEyXu0ELGWe2Wc3S12uYUtfBDt+dQ=
X-Received: by 2002:a5d:8055:: with SMTP id b21mr14927766ior.169.1576963467617;
 Sat, 21 Dec 2019 13:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CACdnJusxs_vAMvE_tOX12ZJiEc3__1NimT3aD3r-Oabvx62FtA@mail.gmail.com>
 <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <CACdnJuucz5CC=LVA5589t0SByH6NHfxbjqm1ONv1nArnUEaHoA@mail.gmail.com> <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_ofVxDKBoe8cRFCRfwHtxN1UNYtYjb0AggXOSTOegtPA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Sat, 21 Dec 2019 13:24:16 -0800
Message-ID: <CACdnJutegX4Yo2=VY+MgUt_oqKSetvDrO2dRdB++=sf2gAisHQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 21, 2019 at 8:44 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Point taken. I like Arvind's suggestion but we need to take care not
> to disable the device producing the GOP. Beyond that, it should be
> possible to disable all devices that are behind PCI bridges. It does
> mean we need to decode the secondary/subordinate bus values from the
> config space and take them into account when iterating over the PCI
> handle list.

The device producing the GOP is the device that I'm most afraid of, to
be honest.I'd naively expect that anything presenting a linear
framebuffer will probably leave it up at disconnect time, and we're
definitely not using DMA to access that framebuffer.
