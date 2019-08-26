Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF29D528
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfHZRpr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 13:45:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40540 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbfHZRpr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Aug 2019 13:45:47 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so39368112ios.7
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pU42gGw1gVlVUlF/wW/uAiCaAt/FVvOc/4u8XYPtZ6Q=;
        b=m/a0mTn8JIle2t4XwbClGaKckf9LvOCHpdQOtGkzUU0rgUZ8S22KXFW8g1bzXRTigd
         LRdxz5zugcj/G1i+OuzEkIRhO17zMitYulMruQy5JkXpHCG89RN1LywMhCPsUGuVD/rf
         0tUvUnBlKrwHT+X2zmLr3/8lQaz7tJQwVrjgZhGdJ36x8/MvvefYoliDLf3Memx7VrkB
         TyVgQnHkRw5PAIlEsUU8ds+God+tLcZl29vHHkKyDVjspcuYQG6bwL0xGUFNpRy9E+dg
         PW5adaRX7JBso0vpertu9Oi9ZrkqAkUo6QmK67BhqPOMrN+eg/S5CPh7mMH7o3c0e2G7
         XTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pU42gGw1gVlVUlF/wW/uAiCaAt/FVvOc/4u8XYPtZ6Q=;
        b=L9VbI6URnr0jeaMJegb2CTXhv2R4CrI/dmeZ0hF6AzhZvQJKC/CodOEtQPeo1lm41i
         O+3mh7QqcDesThFTSrHXTDS9w64VgRJD8HgvV7iROH6+Ss3iiuvQLnmQoI8T5NgMeewW
         dUM94muUDGimDSWLa+JIlpscDA/ov385/1wDizcsHI+to7lEJsotEym8BbABJqML/3fP
         3IQGuj0VJvYtbKy/E6dsRYJvXMjypcmvDBHGXjLnC+r1TlNA0GE4PZAxCi1p+A0vBI7z
         5dMAAHy88ZvoNgQ1AafUf3b14GPTsbMLmTBNmUm0MB3G8W4/FV3n5LJCyAWf4iyBE/Uo
         at5A==
X-Gm-Message-State: APjAAAXbTVrn6VXuNMngj7frqpT37GpEDkdWq1uBJlYaCvU7q+YJRhQI
        hMTQixX4PTeBG65j6WgpAmzIlyPqBPHTi7obQeBogg==
X-Google-Smtp-Source: APXvYqwOqTkOFbPFSsSZbOULUPv8P8IBKF6ZVFOE7qI6tsIsvWnFBKuVEdlXRjTQSOHCljAxWZogDhucBGlwtm4ztH0=
X-Received: by 2002:a6b:c94c:: with SMTP id z73mr27054283iof.84.1566841546578;
 Mon, 26 Aug 2019 10:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com> <20190826153028.32639-2-pjones@redhat.com>
 <20190826163020.e7sahr3irqwwneey@linux.intel.com>
In-Reply-To: <20190826163020.e7sahr3irqwwneey@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 26 Aug 2019 10:45:35 -0700
Message-ID: <CACdnJuu7Sernq__mU-t0e9MYs35szCGZHxn-qYfz--fkm59i6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi+tpm: don't traverse an event log with no events
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 26, 2019 at 9:30 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 26, 2019 at 11:30:28AM -0400, Peter Jones wrote:
> > When there are no entries to put into the final event log, some machines
> > will return the template they would have populated anyway.  In this case
> > the nr_events field is 0, but the rest of the log is just garbage.
> >
> > This patch stops us from trying to iterate the table with
> > __calc_tpm2_event_size() when the number of events in the table is 0.
> >
> > Signed-off-by: Peter Jones <pjones@redhat.com>
> > Tested-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/firmware/efi/tpm.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> > index 1d3f5ca3eaa..be51ed17c6e 100644
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -75,11 +75,15 @@ int __init efi_tpm_eventlog_init(void)
> >               goto out;
> >       }
> >
> > -     tbl_size = tpm2_calc_event_log_size((void *)efi.tpm_final_log
> > -                                         + sizeof(final_tbl->version)
> > -                                         + sizeof(final_tbl->nr_events),
> > -                                         final_tbl->nr_events,
> > -                                         log_tbl->log);
> > +     tbl_size = 0;
> > +     if (final_tbl->nr_events != 0) {
> > +             void *events = (void *)efi.tpm_final_log
> > +                             + sizeof(final_tbl->version)
> > +                             + sizeof(final_tbl->nr_events);
> > +             tbl_size = tpm2_calc_event_log_size(events,
> > +                                                 final_tbl->nr_events,
> > +                                                 log_tbl->log);
> > +     }
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>
