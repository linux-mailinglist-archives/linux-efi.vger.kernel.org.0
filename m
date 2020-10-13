Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97028D2B7
	for <lists+linux-efi@lfdr.de>; Tue, 13 Oct 2020 18:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgJMQ7e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Oct 2020 12:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgJMQ7e (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 13 Oct 2020 12:59:34 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A0F25307;
        Tue, 13 Oct 2020 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602608373;
        bh=osZ8tJsN1XJAdwSi1ibvFjOI4ppbEHzl507BtoRa3RY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BVgO/RpFUbXU0rUhiHQ4PV7seCBjZCA5VZpjLt9fb7pnoZxE7/J2v8gFkpMq7al/x
         NMjFN0+OeJ/sVOOsN2LLPY3YNMD8GoZ5ncaUEdxxceVdpuik78E54GRrZLBAYex/Fk
         VhTmOSSHk5b6rOkFbDuFk7NR3TEllYJasaYjeEQ4=
Received: by mail-oi1-f171.google.com with SMTP id w141so131382oia.2;
        Tue, 13 Oct 2020 09:59:33 -0700 (PDT)
X-Gm-Message-State: AOAM53068MuKC1W0RBsGNaXD3pm6HByvtGHd5jULBpD0WfPpugzEmdRB
        /I4FkeYKFV9kJPZw9a+CW92m5ZqI07k3yU5Vums=
X-Google-Smtp-Source: ABdhPJyCyAZiLNWtZEpxTAWgjVYup7xXC2n8Dw2lOiZtXYQDhs3t2O/klyNtVYYJ8v1GO87o7QPqDtWtI4WZYBPYbfs=
X-Received: by 2002:aca:d845:: with SMTP id p66mr382549oig.47.1602608372672;
 Tue, 13 Oct 2020 09:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201013081804.17332-1-ardb@kernel.org> <ae9ab2560f6d7b114726efb1ec26f0a36f695335.camel@linux.ibm.com>
In-Reply-To: <ae9ab2560f6d7b114726efb1ec26f0a36f695335.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Oct 2020 18:59:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
Message-ID: <CAMj1kXFZVR46_oeYTxJ59q-7u+zFCFtOQuSQoiEzKLhXzpydow@mail.gmail.com>
Subject: Re: [PATCH v2] ima: defer arch_ima_get_secureboot() call to IMA init time
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, Chester Lin <clin@suse.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 13 Oct 2020 at 18:46, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [Cc'ing linuxppc-dev@lists.ozlabs.org]
>
> On Tue, 2020-10-13 at 10:18 +0200, Ard Biesheuvel wrote:
> > Chester reports that it is necessary to introduce a new way to pass
> > the EFI secure boot status between the EFI stub and the core kernel
> > on ARM systems. The usual way of obtaining this information is by
> > checking the SecureBoot and SetupMode EFI variables, but this can
> > only be done after the EFI variable workqueue is created, which
> > occurs in a subsys_initcall(), whereas arch_ima_get_secureboot()
> > is called much earlier by the IMA framework.
> >
> > However, the IMA framework itself is started as a late_initcall,
> > and the only reason the call to arch_ima_get_secureboot() occurs
> > so early is because it happens in the context of a __setup()
> > callback that parses the ima_appraise= command line parameter.
> >
> > So let's refactor this code a little bit, by using a core_param()
> > callback to capture the command line argument, and deferring any
> > reasoning based on its contents to the IMA init routine.
> >
> > Cc: Chester Lin <clin@suse.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Link: https://lore.kernel.org/linux-arm-kernel/20200904072905.25332-2-clin@suse.com/
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > v2: rebase onto series 'integrity: improve user feedback for invalid bootparams'
>
> Thanks, Ard.  Based on my initial, limited testing on Power, it looks
> good, but I'm hesistant to include it in the integrity 5.10 pull
> request without it having been in linux-next and some additional
> testing.  It's now queued in the next-integrity-testing branch awaiting
> some tags.
>

Thanks. No rush as far as I am concerned, although I suppose Chester
may want to rebase his arm64 IMA enablement series on this.

Suggestion: can we take the get_sb_mode() code from ima_arch.c in
arch/x86, and generalize it for all EFI architectures? That way, we
can enable 32-bit ARM and RISC-V seamlessly once someone gets around
to enabling IMA on those platforms. In fact, get_sb_mode() itself
should probably be factored out into a generic helper for use outside
of IMA as well (Xen/x86 has code that does roughly the same already)
