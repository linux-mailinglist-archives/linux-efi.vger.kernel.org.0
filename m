Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9802CFE0F
	for <lists+linux-efi@lfdr.de>; Sat,  5 Dec 2020 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLETKa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 14:10:30 -0500
Received: from [198.167.222.108] ([198.167.222.108]:40979 "EHLO
        devianza.investici.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgLETKa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Dec 2020 14:10:30 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CpJyb073Xz6vZP;
        Sat,  5 Dec 2020 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607195335;
        bh=Enxbl35bWgW2k4CXkeFg1MrWekQN+UnByDQFI9Ki+mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IN0WugIkKjzuabyrLtCIqrR5Dz9NmwNdrJ2PDOHkbzu+mx7X50hjdtiNjCESr/O4T
         9G1STvvilcWHw6XLRChWJvAaKHumeLDAxPFyBlKW+m++YelIpnAUKL4YKuaKgjMXg/
         WJBQXXLzio/SQvLNIV5MvwVfnuiJ24euv3+PB+h8=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CpJyZ5dyqz6vZL;
        Sat,  5 Dec 2020 19:08:54 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by str_has_prefix().
Date:   Sat, 05 Dec 2020 20:08:53 +0100
Message-ID: <2156854.ibmmEGdOxF@machine>
In-Reply-To: <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com> <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com> <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Le vendredi 4 d=E9cembre 2020, 19:02:09 CET James Bottomley a =E9crit :
> On Fri, 2020-12-04 at 18:07 +0100, Ard Biesheuvel wrote:
> > On Fri, 4 Dec 2020 at 18:06, <laniel_francis@privacyrequired.com>
> >=20
> > wrote:
> > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > >=20
> > > The two functions indicates if a string begins with a given prefix.
> > > The only difference is that strstarts() returns a bool while
> > > str_has_prefix()
> > > returns the length of the prefix if the string begins with it or 0
> > > otherwise.
> >=20
> > Why?
>=20
> I think I can answer that.  If the conversion were done properly (which
> it's not) you could get rid of the double strings in the code which are
> error prone if you update one and forget another.  This gives a good
> example: 3d739c1f6156 ("tracing: Use the return of str_has_prefix() to
> remove open coded numbers"). so in your code you'd replace things like
>=20
>     if (strstarts(option, "rgb")) {
>         option +=3D strlen("rgb");
>         ...
>=20
> with
>=20
>     len =3D str_has_prefix(option, "rgb");
>     if (len) {
>         option +=3D len
>         ...

The proposed changes were a bit mechanical and I did not think about using =
the=20
returned value in the way you proposed.
This a good idea though, so I can modify my patches to include this and sen=
d a=20
v2!
=20
> Obviously you also have cases where strstart is used as a boolean with
> no need to know the length ... I think there's no value to converting
> those.

=46or the v2, should I only change cases where using str_has_prefix() bring=
s a=20
benefit over strstarts() or all the cases?

> James


