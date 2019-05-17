Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCA21636
	for <lists+linux-efi@lfdr.de>; Fri, 17 May 2019 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfEQJYl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 May 2019 05:24:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35273 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfEQJYl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 May 2019 05:24:41 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so10914018ith.0
        for <linux-efi@vger.kernel.org>; Fri, 17 May 2019 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1hRjgKSwHweZk8dB5JUfhPlYFrMWm3LL+UTvBdMO2U=;
        b=Kp1Z2DT/3W0yLQXVVl4ufLxOAJJlrRiv4Dqcu//FVib0bsRORina1Clxh30Mhe66cK
         E5D53/P6TIz3VL3qLtK7u8U7Kx1QUWl37ynrZajaq7Eh3j1IwXPKiU0rPNXswc+oXUGB
         gFPo6rIuBqhwMsQYdXALxUEi23N82f1NPxqLONoccpUJBJw9Uh+o9QbJ6HVEiIKm1ORT
         cysucRwvJTDop1Z4tDuuUrORv24g/sInMFpyfo73MmJhyg2YUeKkdmY2hlyjjw01BTm7
         PVQjYzmZ6ZavAB8o9/m6U9tdt5zXRf65pxGnumjGTeVsZaI4TYyPNSJ50JuldP6pGUVV
         LSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1hRjgKSwHweZk8dB5JUfhPlYFrMWm3LL+UTvBdMO2U=;
        b=ljjCJ3OPMnJxaiGepeUsUi1GpcTZU/6etKtib7LbCPVSavL+f16LguqFk1Ygpg0EpQ
         wEWBuz6V855aCa4fMwzB2cn80ThMSgAHftLTf8cJYFXdtcznJmC0eub/RWCkNnWVpBhT
         6+7dDCOLLAb3C2lbrrbwXSuGbnZab2iY7vDnRx8LB0L+GOva1kky0jHw1DRVa2lQ6gI/
         CmyFCOXzScV/8DlOkLD2i8T/XQ+SYL45VB6HgcphEbqWkJRli8gGsfXmiydybmx6ol31
         o+KUWqQ4ro3vuqkcaxPYGR8jGW6dnYO+42jl1u9h0NdY+BJxI9NRe40vWTmiuoxEFrWs
         Xspg==
X-Gm-Message-State: APjAAAXu+4zqnEjRqxfC+zAofsLbdZ5/9m+JJmVGNbmQD2YqoENZ/Bna
        gz14r5U9a21ifOKadXF8r+uq20CenbRNKW3wQF+4NA==
X-Google-Smtp-Source: APXvYqytJXMSh0eWfFOe5vOtUBeNAjTIoGoPnGO7MgQT6P5toncYqfiXlKrthASKsuyH6YeXZy+sb6ra9HCrreFdOdc=
X-Received: by 2002:a24:d00e:: with SMTP id m14mr15838673itg.153.1558085080212;
 Fri, 17 May 2019 02:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
In-Reply-To: <20190517090628.GA4162@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 17 May 2019 11:24:27 +0200
Message-ID: <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
 of Linux 5.1
To:     Gen Zhang <blackgod016574@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 17 May 2019 at 11:06, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> On Fri, May 17, 2019 at 10:41:28AM +0200, Ard Biesheuvel wrote:
> > Returning an error here is not going to make much difference, given
> > that the caller of efi_call_phys_prolog() does not bother to check it,
> > and passes the result straight into efi_call_phys_epilog(), which
> > happily attempts to dereference it.
> >
> > So if you want to fix this properly, please fix it at the call site as
> > well. I'd prefer to avoid ERR_PTR() and just return NULL for a failed
> > allocation though.
> Hi Ard,
> Thanks for your timely reply!
> I think returning NULL in efi_call_phys_prolog() and checking in
> efi_call_phys_epilog() is much better. But I am confused what to return
> in efi_call_phys_epilog() if save_pgd is NULL. Definitely not return
> -ENOMEM, because efi_call_phys_epilog() returns unsigned long. Could
> please light on me to fix this problem?


If efi_call_phys_prolog() returns NULL, the calling function should
abort and never call efi_call_phys_epilog().
