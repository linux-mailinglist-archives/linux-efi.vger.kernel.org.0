Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBC14F290
	for <lists+linux-efi@lfdr.de>; Fri, 31 Jan 2020 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAaTKt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jan 2020 14:10:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39985 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgAaTKt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jan 2020 14:10:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so6248326qto.7;
        Fri, 31 Jan 2020 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PivSctEp2dPEPNMFSJeuoUGncLiGgf5oX5CQhG0ZOqA=;
        b=dSaUshI4Xa0FzW4mbEcpG/KqihtGBIkR/jsxix5pxp8qC/PW6HswxZqJX1EqqYwCe+
         4x0K9DZ4EKNOC0v2kijhreMdOWyTs6WII+y6HxTbxbIXZyiUrmDYq3/uVJ4J4eajzkb7
         jnJGe2qIE+xkTnJm7P9HrAfcNQaCmjAoj9FcH6JekXgu6G5f1d3bzSpRfJCn5UJ6RxmO
         qauIlodO5Yzv8oYcurphzJtuwyR40IHpXPwUW13FoNf6UIqMSJaslx0Dd1X0vIJ8OHwZ
         6lcp993LPc1VW7DS25fbv+28bDi+whudccjfj0XkGrw3L9xpIvlCcJ5jbRJ2O8zyPhWo
         NLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PivSctEp2dPEPNMFSJeuoUGncLiGgf5oX5CQhG0ZOqA=;
        b=BbYDAguIdaM0bHII5DzQcyLYQAg5UdWHRuzwRTrIuJkrped+pnzFocy9ZTwGS9/6Gt
         zeevrcer/GOxWzglnRANZ6xzNlD9NUgX6hSohsA+Qtbrc5yBtIlMeVtOhSrlPmeGdmLm
         GqOWTJ5Ad6i7V1SBSg4W76A7nTN8vIx7P9NVkyPXGvnnTALpy4MEN7xB3qPPXC2Do4J/
         ufIfScrtKyagJ3FoUiiz/IHDwD/YOlrqgcQu0q/XYGQRlmVkD1lQtliIfyB3ZAkCJ1PW
         nH3v5d7TBQWprYONmCYy54x0ES98swCCSxsgZkFdX5n3eesc/o+2XYPepSKY5a2KUbu4
         Y46g==
X-Gm-Message-State: APjAAAXJQfPlo4dELMp0Kib621MnXbvSCM2jsBh6YWr3KpmaxjrEBOOA
        ZlGcUNqaZ+sNl+wWJvPkyps=
X-Google-Smtp-Source: APXvYqwABYI983zuvxlpiVGDIBsEapH4xcdq2vH+NgM1DMH0lVyXFERRRFuygbPrsnaPOjhZL+kjVQ==
X-Received: by 2002:ac8:187b:: with SMTP id n56mr12363273qtk.173.1580497848286;
        Fri, 31 Jan 2020 11:10:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm5173264qte.59.2020.01.31.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 11:10:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 31 Jan 2020 14:10:46 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/8] Remove 64-bit GDT setup in efi_main + doc fixes
Message-ID: <20200131191045.GA2346161@rani.riverdale.lan>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <CAKv+Gu8JGC21R+ngSYtVxFDF7m2nvX=Opo1fkvdFSq-Fz_7B_Q@mail.gmail.com>
 <CAKv+Gu_xw+0dJipX073ErZmJz7RVSn2ZK3SzK3HUDYhJoEOQyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_xw+0dJipX073ErZmJz7RVSn2ZK3SzK3HUDYhJoEOQyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 31, 2020 at 10:31:44AM +0100, Ard Biesheuvel wrote:
> Playing around with this a bit more, I think we should go with
> 
> if (IS_ENABLED(CONFIG_X86_32)) {
>   static const struct desc_struct desc[] __aligned(8) = {
>     [GDT_ENTRY_BOOT_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
>     [GDT_ENTRY_BOOT_DS] = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
>   };
> 
>   native_load_gdt(&(struct desc_ptr){ sizeof(desc) - 1,
>                                       (unsigned long)desc });
> }
> 

This is the way I originally did it (except I loaded the GDT with the
relocated address of desc in case efi_relocate_kernel got called). It
booted on a test, but I grew concerned because this GDT will be
somewhere in the middle of the decompression buffer and get overwritten
either during the copy to the end of the buffer or during decompression.
If anything tries to reload segment registers it will blow up.

Looking at the code though it doesn't look like anything will -- the
segments are loaded at the beginning of startup_32, and then it looks
like nothing should touch them until we get to the startup code of the
decompressed kernel, which sets up its own boot GDT first. So this might
be ok if the x86 maintainers agree.

