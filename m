Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53E165077
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 22:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSVAY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 16:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSVAY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 16:00:24 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A638124670
        for <linux-efi@vger.kernel.org>; Wed, 19 Feb 2020 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582146023;
        bh=TJkZi3j+dhUK0k6i8hFThhPmsZ/TuJ6LjIHOiZrUA58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cgPo8AvBVF8BKoHpoBtq++Sjz2uSDnC8BzZZtmO9BwdLnhcuNaT/uVjXaIxQBBVNW
         4YxWfTyUB6kGlsJm1tNO2PrkIJvDhK2UR4JNDgugEOPhtsIj0rDvyyZ67lrNQAirVC
         tvVnoul1Q55a3M+rDC3l/APpLONQGUgbSmetitW8=
Received: by mail-wm1-f52.google.com with SMTP id t23so2206088wmi.1
        for <linux-efi@vger.kernel.org>; Wed, 19 Feb 2020 13:00:23 -0800 (PST)
X-Gm-Message-State: APjAAAVEDVWibpSeHKWUmGDxtHVmVEGuDRwUyYQyH5iXz3i6yrRfSZ6l
        k64tpYcKbrjuCV5ARi1B8qi1DzD132bzuiCKMqGemg==
X-Google-Smtp-Source: APXvYqxyM/lxKvLeCAXUFUbYNNjRx6BxZzdxagSXjUJ2m/ZiWEfMvEkt2cTcyPPIOcinYGzX85tCav6dCc6/yiJrioI=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr12630279wmf.133.1582146022109;
 Wed, 19 Feb 2020 13:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20200219171907.11894-1-ardb@kernel.org> <20200219171907.11894-10-ardb@kernel.org>
 <20200219204603.GA28639@mail.hallyn.com>
In-Reply-To: <20200219204603.GA28639@mail.hallyn.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Feb 2020 22:00:11 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_c4mhMN5LBoH5jJWwMHaMxKY7zcp4hiqdRFiadPT8Nww@mail.gmail.com>
Message-ID: <CAKv+Gu_c4mhMN5LBoH5jJWwMHaMxKY7zcp4hiqdRFiadPT8Nww@mail.gmail.com>
Subject: Re: [PATCH 9/9] integrity: check properly whether EFI GetVariable()
 is available
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Feb 2020 at 21:46, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Wed, Feb 19, 2020 at 06:19:07PM +0100, Ard Biesheuvel wrote:
> > Testing the value of the efi.get_variable function pointer is not
> > the right way to establish whether the platform supports EFI
> > variables at runtime. Instead, use the newly added granular check
> > that can test for the presence of each EFI runtime service
> > individually.
> >
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  security/integrity/platform_certs/load_uefi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > index 111898aad56e..e2fe1bd3abb9 100644
> > --- a/security/integrity/platform_certs/load_uefi.c
> > +++ b/security/integrity/platform_certs/load_uefi.c
> > @@ -76,7 +76,7 @@ static int __init load_uefi_certs(void)
> >       unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
> >       int rc = 0;
> >
> > -     if (!efi.get_variable)
> > +     if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
>
> Sorry, where is this defined?
>

Apologies, I failed to cc everyone on the whole series.

It is defined in the first patch.

https://lore.kernel.org/linux-efi/20200219171907.11894-1-ardb@kernel.org/
