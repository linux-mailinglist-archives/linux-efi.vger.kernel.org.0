Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF633C2823
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jul 2021 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhGIRRq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Jul 2021 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRRp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Jul 2021 13:17:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F6C0613DD
        for <linux-efi@vger.kernel.org>; Fri,  9 Jul 2021 10:15:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g19so15740722ybe.11
        for <linux-efi@vger.kernel.org>; Fri, 09 Jul 2021 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfAm236+ZW2LhRr62fKnJMwoIctKDz6MX0I8ooLV4Hk=;
        b=Ti/AAu6fROwptWF8bpkOULqE3NuqDJti9uO0acIPfDTodRUrNg0kunoeZmAMhw7eat
         XNCt4Hsw8+Erz0qFR24p9Jj/TCMmVPcVdzb6cKu894/aUOFKeqoGXZ2u3GaZMWRzo3vU
         K0YbzIvlfxGV4u/HDl9u7yhi0Z2G9bBsNMM94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfAm236+ZW2LhRr62fKnJMwoIctKDz6MX0I8ooLV4Hk=;
        b=uZNBDjvtj9Tj7UWnvaVQthyto+hpVK0BVROYsdf5l+IRIEOxPj9FhGGSCOgX/MzqWr
         od8P2nzqE0Qx2gO27uvqUJbBbXno47ry4nrnlKU9SjyPQPYz9X83eef9nS2689mGh1fF
         hUHL8NMJ173Osvp6Zhii+wfjDrjpZu4YXlx6ZtG1te8VA630MY190DiD28UG50i8sLFL
         x9ZyeY/dWcgHwLe+0BgZT2BrL0fyu7QLbIQIJFukL6PWD6UQVgdqV0skaVpvCrNBZBWA
         vA3ejd2YGdRrb1vOISPWzwod77u0kWjhazugiecMHdsySUV16KE/MxXYmTpoiVi4ixsq
         WfPA==
X-Gm-Message-State: AOAM533myYUySmdGyK/ymxUe9VzCjEmVSs3ebSIvfxIAUKQwcLk7SUnG
        Ch8FgpXTMmG8MmKuEFFFthnO4JjJPjTUcgwQ5tru
X-Google-Smtp-Source: ABdhPJyQNjjz+iD+y8t80vrh6c1jtsrqchb4uyODrpPHieb6ZiR1HsxyXwYB4IvCM86/upEIhDFi2E4YhoitiwyInY0=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr45897853yba.442.1625850900256;
 Fri, 09 Jul 2021 10:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134018.62859-1-xypron.glpk@gmx.de> <877di3mfbe.fsf@igel.home>
In-Reply-To: <877di3mfbe.fsf@igel.home>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 9 Jul 2021 10:14:49 -0700
Message-ID: <CAOnJCUJhYZbAL9dMReJt0=y9V33Ed1DaBCXGCdwxH8iUU3bcRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 6, 2021 at 12:07 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 29 2021, Heinrich Schuchardt wrote:
>
> > Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> > to boot SUSE Linux with GRUB on QEMU, cf.
> > https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
> >
> > Remove the constraint.
> >
> > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> With that patch the image in
> http://download.opensuse.org/ports/riscv/tumbleweed/iso/ work again.
>

Thanks.
@palmer: Can you take this one in this cycle ?

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Regards,
Atish
