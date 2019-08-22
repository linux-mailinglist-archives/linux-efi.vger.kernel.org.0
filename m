Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59D98AE2
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2019 07:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfHVFla (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Aug 2019 01:41:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44064 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfHVFl3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Aug 2019 01:41:29 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so1137985iog.11;
        Wed, 21 Aug 2019 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn6rxeyfQPsYnbNUt5MSgWQtbToPh9tKf9jba7m/Mb0=;
        b=qh9NTAxShXjNLbP7aaKIkgSdqONWOprq9JZrxoqc5kVXFAF5XJO5QWJ5FTba1FYzh3
         y+OtXi6NNfMAbQe96n5PTZ2GLN8Ybf570q7QcCkXQwkR3A2jqYHPWQTtLJDyCxxQ8vpd
         FzSSFLB6V/D5k3rOIAg7WfBgNX8of0+VO6VwIiUvUCxse5vr2s4F3MMKuILFAbFrOqNJ
         lS+1sHQf8TtPAnMc9+mI5kOv/1frTd1/wywNNNTIIz42s5GGVf1QxgFPRhvXI6dIUv/7
         myvqsmGFBPQngRg+CXIaw4wu72oAay3IjQyGlN2B4sBh6xhEnbbur+SeKGMAfsOPCbsP
         1RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn6rxeyfQPsYnbNUt5MSgWQtbToPh9tKf9jba7m/Mb0=;
        b=nUhf9Phac08CA/jnkLXcJoi/sEPWvbc+5LpZUcUq+7bk2Up3hmSGWRVvOPQucx+MVD
         o4wnb8TAcupcOYClvAmrpemduSnNTPnAoP/34rddiZBIMqh82oz/5rGe5wEOYXx2CCbB
         QQe6fIwQQucfEIimFhzDPMjOsB9i+00edLTmi3GjYdP16K6LJ4q8k/BxpbDq0vl0kvoW
         DMsooqligz/M4fr9nfrPk7yKhcgbF5CU+c47yYqnXzFyJ4fozfjCcY5NzOHtzKtD2YHI
         IS511i++fXETUhLa1KHl9B6/UHkh8hesd4yJCUAnItuXua3mjorhOcCkaQbv3pGGaR/P
         dJXw==
X-Gm-Message-State: APjAAAWbAwT+YZMtjrGt9acXxzEIARfkOBVE5X02ghPpEpS9ITZACmf1
        PcMcFvt9uOqvhFDFbI7oEe1vr6j+N23a/RjDl7w=
X-Google-Smtp-Source: APXvYqy6nIsjmdyjJU/y7Jt/ct3pwz+lpQCAmPtDtYRpTMGX/1uH9hIhwQwdQXVE23y8PT5ZqJiCE/t5E0jsquqbZXI=
X-Received: by 2002:a6b:6e0e:: with SMTP id d14mr25453232ioh.18.1566452488810;
 Wed, 21 Aug 2019 22:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-2-git-send-email-nayna@linux.ibm.com> <eda9210b56ab220519642d272079eeca60a18265.camel@gmail.com>
In-Reply-To: <eda9210b56ab220519642d272079eeca60a18265.camel@gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 22 Aug 2019 15:41:17 +1000
Message-ID: <CAOSf1CHOsnnC94DxHhG4opZfYjV7u_ndrE2B3Cr6ZV58RAxoWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/powernv: Add OPAL API interface to access
 secure variable
To:     Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 22, 2019 at 3:02 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Wed, 2019-08-21 at 11:08 -0400, Nayna Jain wrote:
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index aba443be7daa..ffe6f1cf0830 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -32,6 +32,8 @@
> >  #include <asm/mce.h>
> >  #include <asm/imc-pmu.h>
> >  #include <asm/bug.h>
> > +#include <asm/secvar.h>
> > +#include <asm/secboot.h>
> >
> >  #include "powernv.h"
> >
> > @@ -988,6 +990,9 @@ static int __init opal_init(void)
> >       /* Initialise OPAL Power control interface */
> >       opal_power_control_init();
> >
> > +     if (is_powerpc_secvar_supported())
> > +             secvar_init();
> > +
>
> The usual pattern here is to have the init function check for support
> internally.
>
> Also, is_powerpc_secvar_supported() doesn't appear to be defined
> anywhere. Is that supposed to be is_opal_secvar_supported()? Or is this
> series supposed to be applied on top of another series?

To answer my own question, yes it depends on the series at [1] which
adds IMA support. Turns out actually reading the cover letter helps,
who knew.

That said, I'm still not entirely sure about this. The implementation
of is_powerpc_secvar_supported() in [2] parses the DT and seems to
assume the DT bindings that OPAL produces. Are those common with the
DT bindings produced by OF when running on pseries?

[1] http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=125961
[2] http://patchwork.ozlabs.org/patch/1149257/

>
> >       return 0;
> >  }
> >  machine_subsys_initcall(powernv, opal_init);
>
