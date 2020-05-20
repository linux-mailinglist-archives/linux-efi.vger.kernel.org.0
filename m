Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520401DB9CB
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETQjF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 12:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETQjF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 12:39:05 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C685F2072C
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589992744;
        bh=32mixnN60DFudH07EXqDtqHzyzrinjaCX3yGpsTx5Ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CjP4QcCTSKd1VuKL21pztMbMb7BjbKeKBXtiTQ1hC7wSTBXeKLqnYFR19XC/m2H8s
         lAVjlEcdnTYjsY//+ag1e/CHH6ZvKJo66rQDio48w9gV5rMg+skpEIIergeZ+882DC
         Sq5uY7Rx3x6IQTCk5v43suB2Nx9mujDa4O9pvWT0=
Received: by mail-il1-f180.google.com with SMTP id 4so3815588ilg.1
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 09:39:04 -0700 (PDT)
X-Gm-Message-State: AOAM531C9opIaYhN5Ta2EZtw/iRoqcmoivAz+A8iv7XDc9hUIaBzbsaK
        qKMK5DISVsU1wcaeMBrp0880eZ1DJmjqStaxIsk=
X-Google-Smtp-Source: ABdhPJweLo0VaWQ4/yS+zbaePsPjr4dnu4ojV0vbCeyegAMUPtxEdiw/1goWbc278sCFHKITbeq7PtVDPqDKf76v7kA=
X-Received: by 2002:a92:5ec1:: with SMTP id f62mr2026285ilg.80.1589992744151;
 Wed, 20 May 2020 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-18-nivedita@alum.mit.edu> <CAMj1kXE=YowWg2CbqXVhPcXoq3eZdowzTnGxLkpD5xcf29fHhw@mail.gmail.com>
 <20200519150755.GC1526900@rani.riverdale.lan> <20200520163808.GA3274869@rani.riverdale.lan>
In-Reply-To: <20200520163808.GA3274869@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 May 2020 18:38:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG2h=x9sfu0ELyUyveu_1hU5qiuRkQXf8Y4dnRPErb3Xw@mail.gmail.com>
Message-ID: <CAMj1kXG2h=x9sfu0ELyUyveu_1hU5qiuRkQXf8Y4dnRPErb3Xw@mail.gmail.com>
Subject: Re: [PATCH 17/24] efi/libstub: Implement printk-style logging
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 May 2020 at 18:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 19, 2020 at 11:07:55AM -0400, Arvind Sankar wrote:
> > On Tue, May 19, 2020 at 10:22:40AM +0200, Ard Biesheuvel wrote:
> > > On Mon, 18 May 2020 at 21:07, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > @@ -100,7 +123,9 @@ efi_status_t efi_parse_options(char const *cmdline)
> > > >                 if (!strcmp(param, "nokaslr")) {
> > > >                         efi_nokaslr = true;
> > > >                 } else if (!strcmp(param, "quiet")) {
> > > > -                       efi_quiet = true;
> > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
> > > > +               } else if (!strcmp(param, "debug")) {
> > > > +                       efi_loglevel = CONSOLE_LOGLEVEL_DEBUG;
> > >
> > > Should we wire this to 'efi=debug' instead?
> > >
> >
> > Sure.
>
> Do you prefer it wired up to both or just efi=debug?
>

Let's stick with efi=debug, that is what all other EFI code uses.
