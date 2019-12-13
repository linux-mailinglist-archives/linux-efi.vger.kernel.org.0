Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41911DFA3
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 09:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfLMIqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 03:46:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMIqL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 03:46:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id d5so5628128wmb.4
        for <linux-efi@vger.kernel.org>; Fri, 13 Dec 2019 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQX7IoRzayvPcwiznKH/C/tA7zz363CN9vLxnqOgif4=;
        b=RtuBqCypClYu4hSNRut649Y51ufh+CnNakb7XqMkMFIN45kBOypKcc0SrEPZapbUbZ
         eGg52U92PP1gqW1CoH4n51jEblXko9+57A6YbpfFOJcICyD581ZbJqNd0VEuQT0nAX5B
         cn7crY7bStV7Saiewszg6Ep4d0SDj18MngTI0bsygFQzD0jAKc8C5XixQy36gHQJV/3E
         76jPf8YHLHgIJlBNDA4l11qbN2nyVcCxCwU8uu5pmbKeoOL5Zyk6LgfwlXBAerKgcKk3
         RUB59+7PjnyMB2peBy4GD9vZjdp6Bzir/FSPvwZteLuhBtr0NE5Y3HvOESE5mRW1SLsL
         nFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQX7IoRzayvPcwiznKH/C/tA7zz363CN9vLxnqOgif4=;
        b=IAe9aFAdnefOyG/Y4jnb5a/NW8YEogJ4cmumlK7U0ldEQmoiMxtxWjJNxD37ZTORi6
         eh6zAGJyJwoQKVI5XgkFul0EKn/fOI49oYBCUf2MhitYz9dU4lYlcZh41MNzhGszzL1u
         OduumZGS+7d9BOvhLnhudGCBvYDumUESyTif8iI4H1eHhznSSQcbb5BkP8xwDZjDQgYn
         oW/xUub+bW0sgYo8UtfpVvoznlc19KXeLru0670f8l8662oBbMcWLTGmG42tySLGzuvK
         nHVvBOUsto1HMG4IrqB9C/V4acSSu26Wts+sJDe+Kxv+FoXqlWnAQMjN/NrXUVoULehW
         ozpw==
X-Gm-Message-State: APjAAAVcu8IWKI7kGiBrD9CzlbOspOJ2ZgkMRLG/hcmgjMGAAkCJZndK
        RTpH2yUju7/AQ4K06sKUitxQTZpp6iw2yRbB6Dq9JCRzjVT/OdNc
X-Google-Smtp-Source: APXvYqzVK+sD9PVDSQiL44xPU80qjBmQ9NCFE47b46tkM0il75eFivEkftfSrJz/xM3MOjuAMjye6IiNhlm60k4K7L4=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr12309700wmc.9.1576226768892;
 Fri, 13 Dec 2019 00:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20191212103158.4958-1-hdegoede@redhat.com> <20191212103158.4958-3-hdegoede@redhat.com>
 <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
 <82c65f05-1140-e10e-ba2f-0c4c5c85bbc8@redhat.com> <CAKv+Gu9StgwBs=y6KU2Pb_P499SfH8po978gHoAbXVL8mB722A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9StgwBs=y6KU2Pb_P499SfH8po978gHoAbXVL8mB722A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 08:46:07 +0000
Message-ID: <CAKv+Gu8UjvLO=Y9LDTOTzx+xt9xJZJBw+4wt8m49FAvzC8iB8A@mail.gmail.com>
Subject: Re: [PATCH 5.5 regression fix 2/2] efi/libstub/helper: Initialize
 pointer variables to zero for mixed mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Dec 2019 at 15:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 12 Dec 2019 at 13:45, Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 12-12-2019 12:29, Ard Biesheuvel wrote:
> > > On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
> > >>
> > >> When running in EFI mixed mode (running a 64 bit kernel on 32 bit EFI
> > >> firmware), we _must_ initialize any pointers which are returned by
> > >> reference by an EFI call to NULL before making the EFI call.
> > >>
> > >> In mixed mode pointers are 64 bit, but when running on a 32 bit firmware,
> > >> EFI calls which return a pointer value by reference only fill the lower
> > >> 32 bits of the passed pointer, leaving the upper 32 bits uninitialized
> > >> unless we explicitly set them to 0 before the call.
> > >>
> > >> We have had this bug in the efi-stub-helper.c file reading code for
> > >> a while now, but this has likely not been noticed sofar because
> > >> this code only gets triggered when LILO style file=... arguments are
> > >> present on the kernel cmdline.
> > >>
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >> ---
> > >>   drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >> index e02579907f2e..6ca7d86743af 100644
> > >> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > >> @@ -365,7 +365,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
> > >>                                    u64 *file_sz)
> > >>   {
> > >>          efi_file_handle_t *h, *fh = __fh;
> > >
> > > What about h? Doesn't it suffer from the same problem?
> > >
> > >> -       efi_file_info_t *info;
> > >> +       efi_file_info_t *info = NULL;
> > >>          efi_status_t status;
> > >>          efi_guid_t info_guid = EFI_FILE_INFO_ID;
> > >>          unsigned long info_sz;
> > >
> > > And info_sz?
> >
> > And "efi_file_io_interface_t *io" and "efi_file_handle_t *fh"
> > in efi_open_volume().
> >
> > I think that is all of them.
> >
>
> OK.
>
> I'll fix it up locally.

Actually, I am going to drop this patch, and disable file loading
entirely for mixed mode. Your findings here prove it is unlikely that
it works on mixed mode systems today, and the
efi_file_handle_t::open() prototype is actually incompatible with
mixed mode, since it takes u64 arguments, which are marshalled
incorrectly by the thunking code (each function arg gets a 32-bit
stack slot for the 32-bit calling convention, which works fine for
pointers and smaller types, but it breaks for u64 since they require
two stack slots)
