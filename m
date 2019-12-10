Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42958119179
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 21:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJUFu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 15:05:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46483 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJUFu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 15:05:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so3927500qtb.13;
        Tue, 10 Dec 2019 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpl5a69JvY6GzTR5oUeYrNiOLOxlBeo8ElozW9pum5Q=;
        b=AkxT05ekyXRjMThw+9iEXTUhXwFhtBxYqVXlYf4klrgejyUcpKXSfuXPhRD/yf2DNj
         aueQEWJjPQ7jUE+W0ZFMqDFYlscTHeXJUtmCJbH8mbNaV5IirVGKjdhKbZmRwNYVuvlf
         huKetD3FU7GWI3jURtJEogvnCStsoTGbNZwj8SUUeQyOGakN6oe1u5cMwpuJQps9dSfk
         Q/aG53W0/S11ccVo6VTrXjXLNgtO6F1H+XkDDHWLhQU6Wl4GZyedUo75uN85h1hBIcN/
         XB2DxiXdUEJM7cXtUpe1FrY9gTjoPT5WVRGXP6GiDIRvtO2E7zmI+9L3GxatB1FUpFPF
         +3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpl5a69JvY6GzTR5oUeYrNiOLOxlBeo8ElozW9pum5Q=;
        b=uiJbJTXbNm5+2454mP2rG5hjwSQXZ9dluxrwdlsdYZCPM7MwPLVvRPoStrJFM0uuBy
         OpLYCiUW5/5jBFXRY3etqEWmSRoKMSs9PLI3Zvlrtha6ZAPokkb1DwY4MaDtecZglTaU
         Qrb5A8HD8hjN8yltEYc5OqHtbQARoM0HTTy/XwY0UQ6lifDhPoglr8oNBd5Oeeio8nJu
         314Ox911bORWia4R6lkp2u4k9jwhylUZpPumuebrLmlueLc7htZ3qupnbX0+zz+mh8x9
         Cr0EwswgupcUxPe6JSN1htKXOs32q6gVtLTqvu6lI+9PxdEAdmneMqGIje3xCzCYn/hq
         EumA==
X-Gm-Message-State: APjAAAWyIRF86tLZzO84wXswTexLUvzIrzP7flY0EFN/IJJxFC8WnTCu
        2qOqqHzxpACVNnb26XZScqM=
X-Google-Smtp-Source: APXvYqzuUxl11wIi6o5vCQr/UPQqonnlS+QqpBwyK0rkBdg+K3EWV0aNMW66jezrKGNJ7Do2bq+OMw==
X-Received: by 2002:ac8:5346:: with SMTP id d6mr32351262qto.49.1576008348859;
        Tue, 10 Dec 2019 12:05:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d19sm56856qto.15.2019.12.10.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:05:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 10 Dec 2019 15:05:46 -0500
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
Message-ID: <20191210200546.GA55356@rani.riverdale.lan>
References: <20191206165542.31469-1-ardb@kernel.org>
 <20191206165542.31469-7-ardb@kernel.org>
 <20191209191242.GA3075464@rani.riverdale.lan>
 <CAKv+Gu8QWcSwRajsO5voTQJxDHy613ugCd_R6=SStf9ABrmtfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8QWcSwRajsO5voTQJxDHy613ugCd_R6=SStf9ABrmtfQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 09, 2019 at 07:24:13PM +0000, Ard Biesheuvel wrote:
> On Mon, 9 Dec 2019 at 20:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Fri, Dec 06, 2019 at 04:55:42PM +0000, Ard Biesheuvel wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > When commit 69c1f396f25b
> > >
> > >   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> > >
> > > moved the x86 specific EFI earlyprintk implementation to a shared location,
> > > it also tweaked the behaviour. In particular, it dropped a trick with full
> > > framebuffer remapping after page initialization, leading to two regressions:
> > > 1) very slow scrolling after page initialization,
> > > 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> > >
> > > Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> > > behavior to the early boot stages, presumably due to eliminating heavy
> > > map()/unmap() operations per each pixel line on the screen.
> > >
> >
> > Could the efi earlycon have an interaction with PCI resource allocation,
> > similar to what commit dcf8f5ce3165 ("drivers/fbdev/efifb: Allow BAR to
> > be moved instead of claiming it") fixed for efifb?
> 
> Yes. If the BAR gets moved, things will break. This is mostly an issue
> for the keep_bootcon case, but that is documented as being a debug
> feature specifically for addressing console initialization related
> issues. Earlycon itself is also a debug feature, so if you hit the BAR
> reallocation issue, you're simply out of luck. Note that this happens
> rarely in practice, only on non-x86 systems where the firmware and the
> kernel have very different policies regarding BAR allocation, and on
> DT based systems, you can force the OS to honour the existing
> allocation by using linux,pci-probe-only

Thanks. Another q -- I tried out the earlycon=efifb, and it seems like
it gets disabled (without keep_bootcon) as soon as dummycon takes over,
which is well before the real console.

DUMMY_CONSOLE is defined as
	depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
	default y

so it seems like it will pretty much always be enabled, as it doesn't
seem likely that VGA_CONSOLE=y and SGI_NEWPORT_CONSOLE=y would ever be
true simultaneously.

Am I missing something or is this the way it's supposed to work? So
keep_bootcon seems almost necessary with the EFI boot console? Would a
patch to not disable boot console when dummycon is initialized, but wait
for a real console, be useful?

Thanks.
