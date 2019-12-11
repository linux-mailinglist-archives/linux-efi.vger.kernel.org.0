Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B685311B5BA
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfLKPzH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 10:55:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41578 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfLKPzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 10:55:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so6644474qtv.8;
        Wed, 11 Dec 2019 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4qbpxDRbYg2u8lQ7TRQ+GrmKeOYvxZcCQg549V74FuQ=;
        b=Lg+VOPVDCEHExTdgxd9GJmm6D7ZU2kN8s6A8U+mdlmbh8ln6wEANdsQ3b7z4I1dipu
         K4MTgTXHkR1ArQPq44Lf5itXDiN04iplES1lbAKx4sl5hYLw6LhjIhNsO1yilH+hXK/3
         drqJhr7iJri15v8oMZ1rqKCuLYxewX3xloaKhPBBiPYBbgKz85PXOE2JflE1ggWdbd0t
         2drMU7k0biPOQcT1j3d9rRPgvT13NSRkh6alF0r0RD+WqevBYcW8RbotDzmLCiJ9IWn0
         brtCEKyI3pMCu5G6wUtpNENhxz+A5DBQvcxuXDJ+YwMziMcE/P9gOuLbSfHGAEbQLz5y
         le+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4qbpxDRbYg2u8lQ7TRQ+GrmKeOYvxZcCQg549V74FuQ=;
        b=lLjDZ6GSSK6rKoj08esP+OfFeXptBmZqagC+THXKSVF9lQWpL0ZFyURJ268469yMrK
         eTjTjozGp0C6VOKfOhVGRSLk5CtigZzsRXh57F9PTRlJfzzFyTS42utl2Q+ns5RMax3x
         ytgI2Lf0HOcIEjXFCvfY7Hp8HY2e14EgdMw98BJNYDSgk7LWfenYQZSSPMPxe7wopTAV
         mSQHfFrRQhVlhZ6nk8hXfji35ueo70d+xMXZADEsaJ4XjDl2AzWzkgOZykVwvacvJ4+c
         OYb6ZUnkLB2e6lQ4aHOjqpmXak3nh2nY3vSxN5fwbJTC0Of0C2Ay8yIEccnGQ/20ds5t
         mEpg==
X-Gm-Message-State: APjAAAXucutHS2ridyQTg+GfOjvZ1zZKhtRtsFESnPPwAbgG8EwfJNLV
        HPJOzlqp8+nthhoX/wlEfgo=
X-Google-Smtp-Source: APXvYqwmqM7jnFz5jF5L13rgEwvrEc6B0RGShgKFd1rKkf9NkPIz0NGYWveINlPKY1rhoM8DwMR1gQ==
X-Received: by 2002:aed:3ac6:: with SMTP id o64mr3377873qte.219.1576079705428;
        Wed, 11 Dec 2019 07:55:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q2sm605481qkm.5.2019.12.11.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:55:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Dec 2019 10:55:03 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH 6/6] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191211155503.GA204038@rani.riverdale.lan>
References: <20191206165542.31469-1-ardb@kernel.org>
 <20191206165542.31469-7-ardb@kernel.org>
 <20191209191242.GA3075464@rani.riverdale.lan>
 <CAKv+Gu8QWcSwRajsO5voTQJxDHy613ugCd_R6=SStf9ABrmtfQ@mail.gmail.com>
 <20191210200546.GA55356@rani.riverdale.lan>
 <CAKv+Gu_VUAEw0auwhOyEAHn4BjDBPc9P4a+WBwJuRb_cBVi0NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_VUAEw0auwhOyEAHn4BjDBPc9P4a+WBwJuRb_cBVi0NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 11:26:17AM +0000, Ard Biesheuvel wrote:
> On Tue, 10 Dec 2019 at 21:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > Thanks. Another q -- I tried out the earlycon=efifb, and it seems like
> > it gets disabled (without keep_bootcon) as soon as dummycon takes over,
> > which is well before the real console.
> >
> > DUMMY_CONSOLE is defined as
> >         depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y
> >         default y
> >
> > so it seems like it will pretty much always be enabled, as it doesn't
> > seem likely that VGA_CONSOLE=y and SGI_NEWPORT_CONSOLE=y would ever be
> > true simultaneously.
> >
> > Am I missing something or is this the way it's supposed to work? So
> > keep_bootcon seems almost necessary with the EFI boot console? Would a
> > patch to not disable boot console when dummycon is initialized, but wait
> > for a real console, be useful?
> >
> 
> Well spotted!
> 
> I have traced this down to [0] which combined various arch specific
> definitions into one, and obviously chose the wrong boolean operator
> for combining the conditions.
> 
> Patches welcome.
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/video/console/Kconfig?id=31d2a7d36d6989c714b792ec00358ada24c039e7

Thanks! I was a little mistaken about what actually disables it though,
it seems to be when vt_console_driver gets registered, and at that point
the vt is still using dummy_con. I had thought dummy_con itself was a
console driver.
