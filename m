Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935FF1CE886
	for <lists+linux-efi@lfdr.de>; Tue, 12 May 2020 00:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgEKWx3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 May 2020 18:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKWx2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 May 2020 18:53:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB9C061A0C;
        Mon, 11 May 2020 15:53:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so9556287qtb.5;
        Mon, 11 May 2020 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YphSq6A1v4I+cV1naaXrYy9+htaDBx1Hhi/F0oFai1E=;
        b=vc3uSObPLePA6JT0lSL3grgVDF8dkVZqHkTljTrBVZapWRF92Thk9z0hcIIUhu2Mwg
         wkXlTsyNDosMUUWpL3ho7Ar2sEWUEIbA2DZdWnswQhvGfnBUWdDPmlZ/8LmtJnOzopJs
         x2py/I3vEg2KGuD0i673/J2rFs/bOTC9pRclJ1E4tHtzOLx9uwohYfl+m6bs4ozrUFkw
         eaSyVIyatC2Cnz1wgnECAuu6hA8UkOLvE5m3d0grTgjA0Wyf8k0w+f5VS4hXrqbYXI1e
         DxXrNHsgEc7e5fPHAp2Qfq/s3HglwjFBWC3VNiLwfG7E5UU8WV5bvZmPIEgaPn8Zi5p+
         HMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YphSq6A1v4I+cV1naaXrYy9+htaDBx1Hhi/F0oFai1E=;
        b=p+bDCKEhpWkdTl7r6U4tt2+Ywr1S4KmsP9zYHPhYrcel8XIMIRvgwiSBFv8kjxQnEO
         ntLWbNQgmaoJg1kiBt6KEZWYfQlZT6+lcmo9uS1K8YDtHA0usvSvtDNa3wesECre4F31
         9IpJKXBax0uPFX3kMJkEWC/8goLozaoyyH3HzyKyMb3uXo2MqmdL6Fw9vxOv1jZO2dZf
         WSRwk2SB26aWowzIwdw6LWHqi/6b/Pp1rglaxqC15Ya/PT1c1YRie3upaoLVjMaAfPF/
         xJdypjSeY7BkEqUOnzkFKm8PVfqBoUAjBn1rXvq4+Tyy/hzX7CGvdq6NyUUk43GVMS78
         ZYUw==
X-Gm-Message-State: AGi0Pua/jXTq8rztatBwqT48IZeqQM/OGCHKd1U19fbCqs/7uV16VOb+
        M37r00RGXPvT8UNLf68GW/AhnjH971g=
X-Google-Smtp-Source: APiQypLYqUazQMqxESsO3qdbOBln1514e3zcNq96foSMd6Kfctag6VJpizyanbpss3qBoDztbfVW/A==
X-Received: by 2002:ac8:839:: with SMTP id u54mr12267672qth.382.1589237606886;
        Mon, 11 May 2020 15:53:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b33sm2382131qtk.97.2020.05.11.15.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:53:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 11 May 2020 18:53:24 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Mike Lothian <mike@fireburn.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 4/5] efi/x86: Remove extra headroom for setup block
Message-ID: <20200511225324.GA1307788@rani.riverdale.lan>
References: <20200303221205.4048668-5-nivedita@alum.mit.edu>
 <20200511170149.1363260-1-mike@fireburn.co.uk>
 <20200511183645.GA596850@rani.riverdale.lan>
 <CAMj1kXEmJRpVyWDVkBn9eL0y0J4iVrUkYZd_pk_oKOeQPH661g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEmJRpVyWDVkBn9eL0y0J4iVrUkYZd_pk_oKOeQPH661g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 11, 2020 at 11:13:00PM +0200, Ard Biesheuvel wrote:
> On Mon, 11 May 2020 at 20:36, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Mon, May 11, 2020 at 06:01:49PM +0100, Mike Lothian wrote:
> > > Hi
> > >
> > > This patch has been causing issues for me since switching to GCC 10.1:
> > >
> > >   CALL    scripts/checksyscalls.sh
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   DESCEND  objtool
> > >   CHK     include/generated/compile.h
> > >   HOSTCC  arch/x86/boot/tools/build
> > > /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: error: linker defined: multiple definition of '_end'
> > > /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld: /tmp/ccEkW0jM.o: previous definition here
> > > collect2: error: ld returned 1 exit status
> > > make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
> > > make: *** [arch/x86/Makefile:303: bzImage] Error 2
> > >
> > > Cheers
> > >
> > > Mike
> >
> > I'm not getting an error even with gcc 10 for some reason, but I can see
> > that it is busted. It's using the linker-defined _end symbol which is
> > just pass the end of the .bss.
> >
> > Does adding "static" to the declaration of _end fix your error?
> 
> This is in a host tool, so it depends on the builtin linker script the
> toolchain decides to use. This is risky, though, as it may be using
> PROVIDE() for _end, which means that in cases where it doesn't break,
> other references to _end that may exist will be linked to the wrong
> symbol. I don't think 'build' should be expected to do anything
> interesting with its own representation in memory, but better fix it
> nonetheless.

Right, _end _is_ getting redefined in my system linker script too: I can
see with objdump that the final _end symbol in my version of build is
actually pointing beyond the .bss. But my toolchain doesn't report an
error for some reason.

> 
> Arvind: mind sending a fix for this, please?

Yeah, I have one ready -- was just waiting to hear back if "static" did
fix it, but I can send it out now.
