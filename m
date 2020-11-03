Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFB2A4F90
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgKCTBr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 14:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgKCTBr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Nov 2020 14:01:47 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DA420786;
        Tue,  3 Nov 2020 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604430106;
        bh=V3c8A60Mt8FDmBSb5SG5gM3Xe0u/VBs+7BXbOhDur9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N94z9neykWgY2TSEK66S3E6JQiR1XBw1INNSY4Zrq5ckvuC8Q2t+S/IBhdoca7X7V
         LbGIJ3c923EOZJnhTjB7uPY8sUi9NKFst9OGI2C4Vpo/J9OUIGhAKMLwzxXrWubR8G
         aS24oRcQpJJ3Iaki2OMGQ8SfuU8nrNwDZc3o1OVg=
Received: by mail-oi1-f180.google.com with SMTP id m143so10132298oig.7;
        Tue, 03 Nov 2020 11:01:46 -0800 (PST)
X-Gm-Message-State: AOAM532KXk118EVlatFmVKUUvX6qrExpalMlYWt2xtXTK4XxgBJ9Uc3O
        az015R/WQmFidT7S7q3ELMasQOF9mAcBQAcU8Co=
X-Google-Smtp-Source: ABdhPJyU9k/6h/LqztyYVASIkRH9NonIhOOmSXq9TIkSDow0OmbXnxcfNl1A6i02eI4H7+ugPq27PJwB1aZrGAa/zMo=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr395749oif.174.1604430105420;
 Tue, 03 Nov 2020 11:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20201102223800.12181-1-ardb@kernel.org> <20201102223800.12181-2-ardb@kernel.org>
 <93e614b138c9f047612db304ca5ebe8a7b21c941.camel@linux.ibm.com>
In-Reply-To: <93e614b138c9f047612db304ca5ebe8a7b21c941.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Nov 2020 20:01:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQe46CuGSna8+EJw6MGq1keLbcuit16LfJbKGnfnAN6g@mail.gmail.com>
Message-ID: <CAMj1kXHQe46CuGSna8+EJw6MGq1keLbcuit16LfJbKGnfnAN6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] efi: generalize efi_get_secureboot
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 3 Nov 2020 at 19:49, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> > From: Chester Lin <clin@suse.com>
> >
> > Generalize the efi_get_secureboot() function so not only efistub but also
> > other subsystems can use it.
> >
> > Note that the MokSbState handling is not factored out: the variable is
> > boot time only, and so it cannot be parameterized as easily. Also, the
> > IMA code will switch to this version in a future patch, and it does not
> > incorporate the MokSbState exception in the first place.
> >
> > Note that the new efi_get_secureboot_mode() helper treats any failures
> > to read SetupMode as setup mode being disabled.
> >
> > Co-developed-by: Chester Lin <clin@suse.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks, Ard.  Other than one minor thing inline below, the patch looks
> good.  I haven't done any testing yet.
>
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index bd9d83a94173..79b2d4de62e0 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1082,7 +1082,28 @@ enum efi_secureboot_mode {
> >       efi_secureboot_mode_disabled,
> >       efi_secureboot_mode_enabled,
> >  };
> > -enum efi_secureboot_mode efi_get_secureboot(void);
> > +
> > +static inline
> > +enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
>
> get_var() should be defined as "efi_status_t".   If this is being
> upstreamed via integrity, I can make the change.
>

No, get_var is a pointer to a function returning efi_status_t, check
include/linux/efi.h for details.
