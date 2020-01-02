Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447EB12E9FC
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgABSiU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 13:38:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSiU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 13:38:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so1199009wrm.11
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBxinf2ZFnjMqmeYxmxpC01aIRiKiuWT4J5+AGr2HrA=;
        b=Y8fXU5PIDITB/jCO9tkQs240p102u09Z8lwTNhCSGKCRXCDVX9FUcEj88RZolocGaU
         KNDmyOhL4Q02N4gGHC+O8kX2ya8rY5xyGJXBYeBkIMTIVVF1fwb3jUBnkDdAECxDDFDY
         hSY7UPn/ng93QbRztaihJDxfl5f+AFrRQKtglNkoXzMe7Tz8IqLjIgn+IwDUdEnSS/FP
         A47TUQ8KEvze6BpVJX3pRRpEBH0yvpkfV+IF1FqVEXUn4NTf04lGQJnpBYl6xrGMVxVv
         tPyKkz1DPLXTRkR0YgnRhUZYqYvx9oytF4tZdcZMQXA2Tbykq5/JFhYZ3sEEyqevu3OB
         iZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBxinf2ZFnjMqmeYxmxpC01aIRiKiuWT4J5+AGr2HrA=;
        b=V/G7pirex0SYYV4nJlxLRcAD+lf0zf7dLOTLJiR/oJtc1l5oQUAau9gGTOb7u9yfAF
         13we05+9Dd7lNGGd/LUBBpNJwx2YGJ5DQeU6Goc6JdIvO7WaLctOSA0wgXuxpnCUm9LX
         HbOqySiNsHiUTstJPeA3Uo7U3nMO3h/dqH67+FTEs0JG/L4K99/fX2X+DWjriGoYXqKi
         6em7JA092Gch+73Dq98tbyd5QuN2bxREFpNiuM5coVtWPHWBhqi7gWnMdmcVz3Fv69q+
         FDkbDmd8OOZnU9ZyZTMtW28LUVUUI5tIynu3pUAVltJIIg7Tr6KsPSDvdKCnAoMpt8fb
         pebw==
X-Gm-Message-State: APjAAAXlyYESgSiC+XKC9YVPIoC1LlBYmP42i/nh4OBZa6n8hopwRu9b
        8twn8Kt6h1MEfqSX3PWpJirn6sRjvh6AtWU/MUHNag==
X-Google-Smtp-Source: APXvYqyiGpvs5TyzkXg2VjjLr0/ZB01QTxe6/7wC1njwkRvIYgDvBLr9f/H+3qvnh9LtXtxAQCr0reoFhrCvxa+QCgk=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr78475633wrr.32.1577990298427;
 Thu, 02 Jan 2020 10:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20200102140653.GA626673@rani.riverdale.lan> <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan> <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan> <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan> <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
 <20200102181015.GA720259@rani.riverdale.lan>
In-Reply-To: <20200102181015.GA720259@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 19:38:06 +0100
Message-ID: <CAKv+Gu8stpJ2YZ6sJb5WvwftNy9SDsQpxoS1uH0FV5vXQKvihA@mail.gmail.com>
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

On Thu, 2 Jan 2020 at 19:10, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Jan 02, 2020 at 06:48:52PM +0100, Ard Biesheuvel wrote:
> > Currently, I am not managing to get the 64-bit compiler to emit any
> > GOT based references for efi_is64, though, even without the attribute,
> > so I am not sure what's going on there.
>
> With gcc 9, I do get R_X86_64_REX_GOTPCRELX relocations in libstub,
> which are then eliminated by the linker -- if they weren't they would be
> using addresses from the GOT. They turn into R_X86_64_PC32 with the
> hidden visibility.

Indeed. I was looking at eboot.o but that gets built with -fPIE not
-fPIC [if available].

libstub objects indeed have the R_X86_64_REX_GOTPCRELX relocations, so
I'll add the hidden visibility to the extern declaration of efi_is64
