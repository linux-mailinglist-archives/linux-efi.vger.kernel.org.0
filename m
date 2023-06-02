Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99861720279
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjFBM7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjFBM7j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 08:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AA1A5;
        Fri,  2 Jun 2023 05:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E43164F2F;
        Fri,  2 Jun 2023 12:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AC9C4339B;
        Fri,  2 Jun 2023 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685710775;
        bh=hgQ+jcnBRg7Kz5BV/YLx0DsJ02rSu8vuSyPtdfEMiRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kvu0pWSsado4ksDKBBw9DqrCuvKkxBZQ64tWb9c5McH56AqRdnsX1Ax7JvIodHsvL
         2qwkQSkSPiqunr/lwIUwWm28u1m9lR/hArDc/aVgVu7VTF2JxHt+2AU7ypaGi8QuLP
         CnvQ50M2Rl9e7kPVZl5mtL0zlVaM+kaMgixLO3xLpovW2FdHk5t+o3Xg8jwEFl7Vsh
         j5+wLRFXI3lSalEGWjSf6e6Gr97KiRuGchqBaRKhEieHWRsoO/5jLAcX2JYgGQIVPv
         meTWbbGd4qHMabnJ4hTeD7Bw4iC4khZvWYB5XW61IfbEIG8idNLQ+TVQIRa5O2uL70
         KBLYNgsXB672g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso2652513e87.1;
        Fri, 02 Jun 2023 05:59:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDwdFnY9O+dlwHFoOEUQp1Q5pLimRysDj/HbajwWn3QF+1FiU8tN
        ioEJf+ulxciVI5bvqHAYf+NiEQwXLLHzJ1lvd3A=
X-Google-Smtp-Source: ACHHUZ60ZaYZ6HTdyybNTMhnhXuFiOk76bJEGNaKp6z6pG3Kz0xJwO0AFSRHiI2iT4sCoq1Hh6ohnJvwrT37cPMUDRI=
X-Received: by 2002:ac2:53ab:0:b0:4f6:13f1:38a4 with SMTP id
 j11-20020ac253ab000000b004f613f138a4mr759648lfh.41.1685710773672; Fri, 02 Jun
 2023 05:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230512194302.1662230-1-nicholasbishop@google.com> <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
In-Reply-To: <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Jun 2023 14:59:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkJGUzksNRwMv1nBb-b3=ZOXb0xD=ZfA1RQvWZBHMBXQ@mail.gmail.com>
Message-ID: <CAMj1kXFkJGUzksNRwMv1nBb-b3=ZOXb0xD=ZfA1RQvWZBHMBXQ@mail.gmail.com>
Subject: Re: [PATCH] efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
To:     Nicholas Bishop <nicholasbishop@google.com>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 May 2023 at 10:11, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 12 May 2023 at 21:43, Nicholas Bishop <nicholasbishop@google.com> wrote:
> >
> > Access to the files in /sys/firmware/efi/esrt has been restricted to
> > CAP_SYS_ADMIN since support for ESRT was added, but this seems overly
> > restrictive given that the files are read-only and just provide
> > information about UEFI firmware updates.
> >
> > Remove the CAP_SYS_ADMIN restriction so that a non-root process can read
> > the files, provided a suitably-privileged process changes the file
> > ownership first. The files are still read-only and still owned by root by
> > default.
> >
> > Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>
>
> Seems reasonable to me. Peter?
>

I've queued this up now.


> > ---
> >  drivers/firmware/efi/esrt.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > index d5915272141f..aab96ab64a1a 100644
> > --- a/drivers/firmware/efi/esrt.c
> > +++ b/drivers/firmware/efi/esrt.c
> > @@ -95,10 +95,6 @@ static ssize_t esre_attr_show(struct kobject *kobj,
> >         struct esre_entry *entry = to_entry(kobj);
> >         struct esre_attribute *attr = to_attr(_attr);
> >
> > -       /* Don't tell normal users what firmware versions we've got... */
> > -       if (!capable(CAP_SYS_ADMIN))
> > -               return -EACCES;
> > -
> >         return attr->show(entry, buf);
> >  }
> >
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >
