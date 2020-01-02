Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0912E93B
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgABRVU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 12:21:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34188 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgABRVU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 12:21:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so32266173qkk.1
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vvHRjcUb7wde9i/wiLJ79Lr5kxIJ0e2Ftc1H02oJtZE=;
        b=ZsjJsmKq8epa0va/afhuUasP8uWnH5lgtRRN/joqxpicjKunb4qfrcTQB1B+dA3Bf8
         +X8/ocxGxzqQh82xus/7+ru14mhKpjlmPSVC2ggbi8K5zARqSyy6HefpJscsxQBjIlBK
         YsTfHxMIi0eUMOwYpxmKbNX29RsStfbCwQx7UFcYbrmmNnmuozLYrFcSrZtbPeTnGaDC
         Hpomh7Cvd3/YMLxkRanuQKd79M/sv81wzkbPDP2DZx86Uo/fJZyTthvV2eJ8dnkn+9Br
         xsQcwfemkP9XbiF4pl2lBynQGHXThQKu+CyDRcxNRuU+k1Yhro8e+6DvRCXDeA8c2hDY
         ullA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvHRjcUb7wde9i/wiLJ79Lr5kxIJ0e2Ftc1H02oJtZE=;
        b=i308Z/rbmr2g8EX7FWjgrTK3HoTJy01iGxA9Xh2tkAEUuK8YtZ+SdSmJGXLKsh4q6p
         kkUOJfxMucIP+m8eWCYIH4WBr/z+Xc/2BdHDsYMGZVNTzmp0hSz9TlOvbYrUBCGycfhs
         hGQM1pFhFRTLOeAXKA/KO2sulRSrhMlWx8E4Rdhiu5t6+EKQSgsQg77Sr/qBXIMO0mAS
         17ImFMl6EgX6QfCBawvTX0FoGWkd2g4Nsbwq1+8JEA98IwdaO1Lt4f6Fnd+Lg5OHlIQJ
         L+Os3O7FEi18N4e4Qd7xf06yV6LL0NIxV00OOZ9DfTnyEiemDTyIHdWbD9oyPC9wHXt4
         oOyg==
X-Gm-Message-State: APjAAAXi/1ucVY9MVb6NeAdujyrSSLI/xk81lHPvnI+BCkOouZTDXx6j
        QJy4TdPAouArrTAG9jqBXzY=
X-Google-Smtp-Source: APXvYqz1dbHEHq5vFA3ARMKAgaQwtyfzOPz81PkRS+VbHtm+1G+V1SurYbgjmK1FGuqrNuWaTdFMOw==
X-Received: by 2002:a37:a00b:: with SMTP id j11mr67529537qke.268.1577985679673;
        Thu, 02 Jan 2020 09:21:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r44sm17364785qta.26.2020.01.02.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:21:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 12:21:17 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102172117.GA701372@rani.riverdale.lan>
References: <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <20200102165927.GA683588@rani.riverdale.lan>
 <CAKv+Gu93H_M=Bjr+DREAuAwSjZH2sVwA_ZRmbcr8TDtJDypFHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu93H_M=Bjr+DREAuAwSjZH2sVwA_ZRmbcr8TDtJDypFHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 06:03:48PM +0100, Ard Biesheuvel wrote:
> On Thu, 2 Jan 2020 at 17:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Jan 02, 2020 at 05:28:16PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 2 Jan 2020 at 16:58, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Thu, 2 Jan 2020 at 16:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> > > > > >
> > > > > > Yeah, good point.
> > > > > >
> > > > > > I pushed as branch here;
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> > > > > >
> > > > > > Could you please check if that fixes the issue for efi_is_64bit() ?
> > > > >
> > > > > Haven't built it yet -- but how does this handle the GOT issues you
> > > > > mentioned?
> > > >
> > > > It doesn't. The trick is to add __attribute__((visibility("hidden")))
> > > > to the extern declaration of efi_is64, but I am having trouble to
> > > > reproduce the original issue.
> > >
> > > Some background:
> > >
> > > https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> > > https://lore.kernel.org/lkml/20140919104021.GA11552@gmail.com/
> >
> > I wonder if commit 6d92bc9d483a ("x86/build: Build compressed x86
> > kernels as PIE") resolved this.
> 
> Good question. But note that the stub is still built with -fPIC not -fPIE.

Hm libstub is -fPIC but arch/x86/boot/compressed is -fPIE. With -fPIE
gcc 5+ doesn't use GOTPCREL even with default visibility, but gcc 4.7
does. With -fPIC though you need hidden visibility to avoid GOTPCREL.
