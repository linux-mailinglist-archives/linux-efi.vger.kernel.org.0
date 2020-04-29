Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7031BE7B5
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 21:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgD2TsU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 15:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgD2TsQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 29 Apr 2020 15:48:16 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294AA22200;
        Wed, 29 Apr 2020 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588189696;
        bh=SFR74rYP9+0171FFCb6xDPTTpNtn0bIHwSgFclfamCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=upV3Ifzz+cvLqIozeRKbsBvPn0Cp7d3sXcIKtqgSU1XwmqHSBGFOcdNlsURh1AEoL
         5RScngGLRrgb3HZKt8vRvYNwGxnAM2X+ruEqQiP9kaLvVMJDxYHU5GyKFnlMVDRaxB
         2YsqSGxVUlin2mykY+rYlCnsgnK/RzNRweIGLP54=
Received: by mail-il1-f173.google.com with SMTP id s10so3621291iln.11;
        Wed, 29 Apr 2020 12:48:16 -0700 (PDT)
X-Gm-Message-State: AGi0Pua/NxeTDHMAVXWXvJAhPXZva/tj7bOcRIDR3Ac/SOyZExKi6RQy
        KrfNDjigBszRNErhFvLN2JLMTZYlwkTPBQyP/FY=
X-Google-Smtp-Source: APiQypJ/sJvL1QmMgGrcOxk5QdvbljU3Mk4YHsiqvrV/lveZgGlUmAgVNNWNZ76O2PEF0iLiyG7Pd986zBScJQUTLn0=
X-Received: by 2002:a92:405:: with SMTP id 5mr31735312ile.279.1588189695602;
 Wed, 29 Apr 2020 12:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu> <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
 <3fa8fba37f9339adc993cdb7afc77ed0e063967d.camel@perches.com>
 <CAMj1kXHN1j4+h-mTf_EpsaX3-ifAtKJOPmSSq9LvHoFUUg+0bw@mail.gmail.com> <f53e716ac4da310d0d9ed7d211ac17ba8ec64699.camel@perches.com>
In-Reply-To: <f53e716ac4da310d0d9ed7d211ac17ba8ec64699.camel@perches.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Apr 2020 21:48:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwxqPA7t8N+A25+VnxO4opBdM6__An=Er-Yh+QLOZ3Jw@mail.gmail.com>
Message-ID: <CAMj1kXEwxqPA7t8N+A25+VnxO4opBdM6__An=Er-Yh+QLOZ3Jw@mail.gmail.com>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
To:     Joe Perches <joe@perches.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 29 Apr 2020 at 21:47, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-04-29 at 20:59 +0200, Ard Biesheuvel wrote:
> > On Wed, 29 Apr 2020 at 20:57, Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2020-04-29 at 20:49 +0200, Ard Biesheuvel wrote:
> > > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > > > Looking at code for efi_printk -> efi_char16_printk,
> > > > > it's somewhat difficult to see where the "output_string"
> > > > > function pointer is set.  Any clue?
> > > > It is set by the firmware.
> > >
> > > Sure, where in the code though?
> > >
> >
> > In which code? The firmware code?
>
> I presume it's set from a struct received from hardware/firmware
> somewhere in drivers/firmware/efi, but it doesn't seem clear where.
>

It is a field in the EFI system table, which we dereference directly.
