Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65021B391
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJLAv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jul 2020 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGJLAf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jul 2020 07:00:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC68AC08C5CE
        for <linux-efi@vger.kernel.org>; Fri, 10 Jul 2020 04:00:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so5940852ljo.7
        for <linux-efi@vger.kernel.org>; Fri, 10 Jul 2020 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EcXb80b30+tpFcdAM3LkbXH4OtvQdy0dqwPo/8t73Kg=;
        b=lJv7SRzZvI52d/GkPLIWxZELIIqVT+/yUEvPHEZM++z5EjEIgVM1Q9PbOahTy8nLz+
         jXUpfCbkx1kO0P1DFNFGgDQcxfr+Asvm+l1KRytTFKB6sJb/OQdZqA/F+F9IMCviIATT
         rnm6SYJqjXcE9rZUVzgDzM0JNbT/z1KImQ9HhXBgWgy9fqBsaWR1LkSHvEB6TFE19YNg
         DqLZMwgYRGi9Q6NReAmqqCNEB/GY0W4qJB+gUuGIMbu/HlMMUfYsLRagelH/LLFlFfqQ
         FIYmhiBqw9T5Mw8cQ+C03NO05h9sIW9Jd0TsShukw0edOombPiOI0e9z5iP1lWkndvY9
         DKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcXb80b30+tpFcdAM3LkbXH4OtvQdy0dqwPo/8t73Kg=;
        b=KR1RIkZ3n9FgXjMI8pCX84bS6+F8llLjBN1jdgYDVy3+rPlZaia3Be5PQk2BWckgHb
         IoaTW2qZM/rbdr/n0y0N6qzNvJasWDy+PlEcx6MPL18ohXsiGwa5pr9WLv81oohBAnW4
         sfWURT/Ebdxsahmkf5djucog5PKg3mi4Q1rMoL2oYl8nWT9d4y8X0MuzkWGkKqvifNPW
         vxGt0yolgcEgq0GmYbDdc5vttyzcGhIkYGYd93ZhdkvuT+lHpqxubqr5REj9avkFjGY4
         DciLQ8ZmXOJF2NQjNqmwIASPkezTQQrso8uEgRUyejxfUshnfgwstM4dVMqsWeqEkxbN
         IYeg==
X-Gm-Message-State: AOAM532sZgl3m4taGrA9ROenK2GaC604Nvprg7UXuyHYwgdsS6JFIo9X
        s76muxY7KolKrMOy7DPRJ/7Qng==
X-Google-Smtp-Source: ABdhPJz4WZbU5C4FhPBXfdsSPpIyNA3SNZczQAfzocvErK+Kz2A3rFV0UWXcHpqjcCVyU/WFLrPW2g==
X-Received: by 2002:a2e:7c07:: with SMTP id x7mr29045507ljc.166.1594378833261;
        Fri, 10 Jul 2020 04:00:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g7sm1800509ljl.7.2020.07.10.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:00:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 712EB10222B; Fri, 10 Jul 2020 14:00:34 +0300 (+03)
Date:   Fri, 10 Jul 2020 14:00:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200710110034.zthb7lctf7xwj2yt@box>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
 <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
 <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
 <20200709103459.wenqhbp52vesr7e5@box>
 <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 10, 2020 at 12:09:36PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 9, 2020 at 12:35 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Thu, Jul 09, 2020 at 11:30:27AM +0200, Arnd Bergmann wrote:
> > > The most interesting version to require in the future would be
> > > gcc-7, which IIRC is the point at which we can just use -std=gnu99
> > > or -std=gnu11 instead of -std=gnu89 without running into the
> > > problem with compound literals[1].
> >
> > It is gcc-5, not gcc-7. This commit:
> >
> > https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d303aeafa9b4
> 
> Ok, glad I was wrong here. I confirmed that with gcc-5 or higher I
> can build a kernel with -std=gnu11 or -std=gnu99 instead of
> -std=gnu89, but gcc-4.9.4 fails with anything other than gnu89.
> 
> I forgot why we care though -- is there any behavior of gnu11
> that we prefer over the gnu99 behavior, or is it just going with
> the times because it's the right thing to do? All the interesting
> features of c11 seem to also be available as extensions in
> gcc-4.9's gnu89, though I could not find a definite list of the
> differences.

Last time (llist_entry_safe() thread) it came up due to local variables in
loops feature that is not available for gnu89. Both gnu99 and gnu11 is
fine. Maybe we should leave it to default for the GCC (gnu17/gnu18 in
gcc-10).

-- 
 Kirill A. Shutemov
