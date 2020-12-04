Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08BF2CF31C
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgLDR21 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 12:28:27 -0500
Received: from [198.167.222.108] ([198.167.222.108]:44591 "EHLO
        devianza.investici.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbgLDR21 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 12:28:27 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 12:28:27 EST
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CnfZb0VrZz6vXN;
        Fri,  4 Dec 2020 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607102359;
        bh=frsKfUcx/OUGftXNRhNwoBBPDTlStxGdJUYS6C0cC+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2Ur4AJJCXBPdcQ3s6S3Al2ZpBVWL+5l/s5vrG4tMPFsjvRESe1ObDn4vKdanzp1r
         JucA0HYFdVn0uAwn7VjC3UuGkt95LNDgWErlsMeEY8kB6v26PSJ6KmmSAJAaMp/QPm
         i6OFJsaGlW9esRxvbBM8HSkMjvz5cgNMGrfmSi6c=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfZZ6KLZz6vXM;
        Fri,  4 Dec 2020 17:19:18 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
Date:   Fri, 04 Dec 2020 18:19:17 +0100
Message-ID: <76549435.0IJL5AjtZl@machine>
In-Reply-To: <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com> <20201204170319.20383-8-laniel_francis@privacyrequired.com> <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Le vendredi 4 d=E9cembre 2020, 18:07:11 CET Ard Biesheuvel a =E9crit :
> On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com> wrote:
> > From: Francis Laniel <laniel_francis@privacyrequired.com>
> >=20
> > The two functions indicates if a string begins with a given prefix.
> > The only difference is that strstarts() returns a bool while
> > str_has_prefix() returns the length of the prefix if the string begins
> > with it or 0 otherwise.
> Why?

The code works fine actually with the two functions, it is a fact.

Not long ago, I read string.h and saw that there was two functions doing th=
e=20
same thing.
At this moment, I thought that it can be a good idea to replace one by anot=
her=20
so there is only one remaining function.

I think the benefit of this patch is that it makes the code a bit simpler.
I agree that this is not a huge benefit and that the code can stay in its=20
actual state.
I also marked this patch as RFC to get people's opinion about if they find =
it=20
useful or not.

> > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> > ---
> >=20
> >  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
> >  drivers/firmware/efi/libstub/gop.c             | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > b/drivers/firmware/efi/libstub/efi-stub-helper.c index
> > aa8da0a49829..a502f549d900 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -230,7 +230,7 @@ efi_status_t efi_parse_options(char const *cmdline)
> >=20
> >                         if (parse_option_str(val, "debug"))
> >                        =20
> >                                 efi_loglevel =3D CONSOLE_LOGLEVEL_DEBUG;
> >                =20
> >                 } else if (!strcmp(param, "video") &&
> >=20
> > -                          val && strstarts(val, "efifb:")) {
> > +                          val && str_has_prefix(val, "efifb:")) {
> >=20
> >                         efi_parse_option_graphics(val + strlen("efifb:"=
));
> >                =20
> >                 }
> >        =20
> >         }
> >=20
> > diff --git a/drivers/firmware/efi/libstub/gop.c
> > b/drivers/firmware/efi/libstub/gop.c index ea5da307d542..fbe95b3cc96a
> > 100644
> > --- a/drivers/firmware/efi/libstub/gop.c
> > +++ b/drivers/firmware/efi/libstub/gop.c
> > @@ -39,7 +39,7 @@ static bool parse_modenum(char *option, char **next)
> >=20
> >  {
> > =20
> >         u32 m;
> >=20
> > -       if (!strstarts(option, "mode=3D"))
> > +       if (!str_has_prefix(option, "mode=3D"))
> >=20
> >                 return false;
> >        =20
> >         option +=3D strlen("mode=3D");
> >         m =3D simple_strtoull(option, &option, 0);
> >=20
> > @@ -65,10 +65,10 @@ static bool parse_res(char *option, char **next)
> >=20
> >         h =3D simple_strtoull(option, &option, 10);
> >         if (*option =3D=3D '-') {
> >        =20
> >                 option++;
> >=20
> > -               if (strstarts(option, "rgb")) {
> > +               if (str_has_prefix(option, "rgb")) {
> >=20
> >                         option +=3D strlen("rgb");
> >                         pf =3D PIXEL_RGB_RESERVED_8BIT_PER_COLOR;
> >=20
> > -               } else if (strstarts(option, "bgr")) {
> > +               } else if (str_has_prefix(option, "bgr")) {
> >=20
> >                         option +=3D strlen("bgr");
> >                         pf =3D PIXEL_BGR_RESERVED_8BIT_PER_COLOR;
> >                =20
> >                 } else if (isdigit(*option))
> >=20
> > @@ -90,7 +90,7 @@ static bool parse_res(char *option, char **next)
> >=20
> >  static bool parse_auto(char *option, char **next)
> >  {
> >=20
> > -       if (!strstarts(option, "auto"))
> > +       if (!str_has_prefix(option, "auto"))
> >=20
> >                 return false;
> >        =20
> >         option +=3D strlen("auto");
> >         if (*option && *option++ !=3D ',')
> >=20
> > @@ -103,7 +103,7 @@ static bool parse_auto(char *option, char **next)
> >=20
> >  static bool parse_list(char *option, char **next)
> >  {
> >=20
> > -       if (!strstarts(option, "list"))
> > +       if (!str_has_prefix(option, "list"))
> >=20
> >                 return false;
> >        =20
> >         option +=3D strlen("list");
> >         if (*option && *option++ !=3D ',')
> >=20
> > --
> > 2.20.1




