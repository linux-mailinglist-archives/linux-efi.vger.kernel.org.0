Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743691C3C2F
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgEDOCm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgEDOCm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 10:02:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82AC061A0E
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 07:02:41 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so8333633qvb.10
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iiHXG75cWRukl+2lWkJwx6XBOfXUfdgxGLFV8Laz2v8=;
        b=MF9VExjj5ghpaqpk7DdW1ddCRSGHnxILPylUh/5lzrTBBroc6W5nmuuvWocENESyU5
         vgCJAmDhD4wcc8JyC8whAGrmuVWh22elt/wYARynvcH3iBHr6jjA/uTCKTn2QcDBX6pu
         ybm9J1FqYs1AdcywU9r4Ks51Tq1rdALqYKDw/uEmHBKrCTbhAICMkzN3a4zCHBbYCQDy
         NZygsdWoB1Pr+CRVc/zGGPhXTXPeJcm9+kpOaSCeAyQUXUA1626oGFU8nRHc7ietQxUd
         JYH63uW0iEMva0TBYASrX6iv1tM7eCjSI/zkzRF7KMqgEA70HcA6xBxbMXvYsExDHeoe
         KHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iiHXG75cWRukl+2lWkJwx6XBOfXUfdgxGLFV8Laz2v8=;
        b=BEvfyA3z/bST9i8vVPsMTI8lM306byMmJZe9JZyVqx3rnZOhveJ0mgOWWb/pZi0KGH
         EOP2woS2GXPAS6ofuhHkV105aSfOFFZ3tNPgP0FwDLdpx3YuZdveauDYy1oNi2IjkLsj
         YT8yO2+BtYxn5WpO6C4urKC8MOlMZ+w4NKVoGAnlYdNGBb8v6fJafdcZsDJjVcuw41cI
         SHRYyuE2iJ3qcLzzQMk+uUDP6iYAteLyCxCrnSgsu85kY4DZY6E2Oqld93HDmm/+5MpW
         MmOlV3FxweVrqGSEqZC1dCXi0WdQR+IrBeo4ecXScPD9wGQEZq5AP0hyGQn4FctQp9gq
         rxOQ==
X-Gm-Message-State: AGi0PuaDp3zEW3cC8CDZwHFawE8CBxGGFG5+E3nYeFu3tHUBGo1yAHYl
        OScO5UkZ95d0GR1XyfSkWyI=
X-Google-Smtp-Source: APiQypJ3WQxYKaLu+H1yKzE+LN4qfHQmm4vKS5MVMDkcXtyWAUY2vWpZEsaoKimnaYbSp9kVUd9EDA==
X-Received: by 2002:a0c:da01:: with SMTP id x1mr16929925qvj.103.1588600960419;
        Mon, 04 May 2020 07:02:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g25sm9735252qkl.50.2020.05.04.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 4 May 2020 10:02:34 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/1] efi/libstub: Fix mixed mode boot issue after macro
 refactor
Message-ID: <20200504140234.GA2943621@rani.riverdale.lan>
References: <20200503154507.82880-1-ardb@kernel.org>
 <20200504003852.1096018-1-nivedita@alum.mit.edu>
 <20200504003852.1096018-2-nivedita@alum.mit.edu>
 <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqt2h+6EUoQ4qquX5zUJDKpg5MhXaGQcdVguNcOHrZ+A@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 04, 2020 at 10:05:23AM +0200, Ard Biesheuvel wrote:
> On Mon, 4 May 2020 at 02:38, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit
> >   22090f84bc3f ("efi/libstub: unify EFI call wrappers for non-x86")
> >
> > refactored the macros that are used to provide wrappers for mixed-mode
> > calls on x86, allowing us to boot a 64-bit kernel on 32-bit firmware.
> >
> > Unfortunately, this broke mixed mode boot due to the fact that
> > efi_is_native() is not a macro on x86.
> >
> > Fix this by conditioning the generic macro definitions on
> > CONFIG_EFI_MIXED, and removing the wrapper definitions on x86 if
> > CONFIG_EFI_MIXED is not enabled.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Thanks Arvind.
> 
> Currently, CONFIG_EFI_MIXED is never referenced outside of arch/x86,
> and I prefer to keep it that way.

All these macros go together though -- they should either all be defined
or none, so it makes sense to put them under a single #if. If you think
it's possible that a future architecture might need the wrappers but not
be mixed, we could maybe add an ARCH_NEEDS_EFISTUB_WRAPPERS?

> 
> Also, I fail to see where the definition of efi_is_native() comes from
> after applying this patch.

The generic definition is in the same place -- I just moved it to the
top as it's a predicate rather than a wrapper, and kept all the actual
wrappers together.

> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index 874233cf8820..37ca286a40c6 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -33,20 +33,14 @@ extern bool efi_novamap;
> >
> >  extern const efi_system_table_t *efi_system_table;
> >
> > -#ifndef efi_bs_call
> > +#ifndef CONFIG_EFI_MIXED
> > +
> > +#define efi_is_native()                (true)
> >  #define efi_bs_call(func, ...) efi_system_table->boottime->func(__VA_ARGS__)
> > -#endif
> > -#ifndef efi_rt_call
> >  #define efi_rt_call(func, ...) efi_system_table->runtime->func(__VA_ARGS__)
> > -#endif
> > -#ifndef efi_is_native
> > -#define efi_is_native()                (true)
> > -#endif
> > -#ifndef efi_table_attr
> >  #define efi_table_attr(inst, attr)     (inst->attr)
> > -#endif
> > -#ifndef efi_call_proto
> >  #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
> > +
> >  #endif
> >
> >  #define efi_info(msg)          do {                    \
> > --
> > 2.26.2
> >
