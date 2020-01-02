Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AA12E90F
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgABREC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:04:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgABREC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:04:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so39880628wro.2
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9geGGNNry2ZqJN4Bd+DMp1YvJlcblt9JKsPvC8Xto0=;
        b=n2xNDgnzEXXj0YQbKIwCqCXegkG8rJAK03sxnWjxc11k/+L/0dopW6/dQUFgOulcRZ
         WzSfk1gmNt+Vw5f1XNyU1PAFHVavyT46DPuEs+08uLQZ99o0gfKEk/MKP98FvkyLAtKV
         R+7FCKIXXrWyoYnmqUXOIWZ39X5IkeU9g7aXiwkcWbdxWstwcToAVEpDhG90QE4jHcxw
         hyFLYN/ZCCSYWJATaCnuQUpbEDkYeJ70V507CX089HcuYTBbynFFFx21c0Q+rR8d4fiC
         YHUtrJEdWrptIaOhGWkZZs4vTuQhM8vX5McMFHuIeiMQJKDgun08CbJgW2XX7pIa/VYn
         jROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9geGGNNry2ZqJN4Bd+DMp1YvJlcblt9JKsPvC8Xto0=;
        b=Il92aozkqD00fPzptzoKNRqPrU6BVAfEnmgdgH+M+4zQruczzdZ7ABlyDcPAByuR+D
         ouT+BDm0TSjvq8DO0soBxdrRWHnPPZdOHTUmUCTJzZH72yBX5ErJVIv2LvPAoh6f7oCR
         3gbJ5hiJOOS20v1KMdW2BsFLYgts3SfZzN6Pabc6Dh32dY0UbTJSmx+ZcG00RlId7XDC
         OYWYT5kVdNTxbNeEofJon73oDTdXp5gRzfazAGkyDP4ag7zWMTsBk0PoquQ/TtNJRi86
         MBbmszMCgfs+WmcLIu0B0XpwdlGnmu6TbZ7ZDy5BbLAHK4wDqoimE+167PAQM2IN/CnR
         ry1A==
X-Gm-Message-State: APjAAAXIVpwLxmlSgOWsyDvwZH2GKsRbVIqKeIqwD/psg0mdB41BL3Ql
        PuBoWwSnABToRLONpa1L2E5qzVpflMRDZG9vpU1POg==
X-Google-Smtp-Source: APXvYqzAnKzSIC7KeThax98UF8OlSbq/pyNTURP3M79OOggCdLfseinkdS8Y53l409Qw4AI9N+Rhnp1FDascYfJKuXc=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr86003505wrw.246.1577984639957;
 Thu, 02 Jan 2020 09:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-14-ardb@kernel.org> <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan> <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com> <20200102165927.GA683588@rani.riverdale.lan>
In-Reply-To: <20200102165927.GA683588@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 18:03:48 +0100
Message-ID: <CAKv+Gu93H_M=Bjr+DREAuAwSjZH2sVwA_ZRmbcr8TDtJDypFHw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 17:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 05:28:16PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > > Yeah, good point.
> > > > >
> > > > > I pushed as branch here;
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > >
> > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > >
> > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > mentioned?
> > >
> > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > to the extern declaration of efi_is64, but I am having trouble to
> > > reproduce the original issue.
> >
> > Some background:
> >
> > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
>
> I wonder if commit 6d92bc9d483a ("x86/build: Build compressed x86
> kernels as PIE") resolved this.

Good question. But note that the stub is still built with -fPIC not -fPIE.
