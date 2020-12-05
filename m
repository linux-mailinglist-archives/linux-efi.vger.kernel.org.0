Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF12CFF9D
	for <lists+linux-efi@lfdr.de>; Sun,  6 Dec 2020 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLEXFO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Dec 2020 18:05:14 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:47534 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbgLEXFN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Dec 2020 18:05:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38BA412803B8;
        Sat,  5 Dec 2020 15:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607209473;
        bh=OHgDzHQ4UVZtoQc0+c8rR/RVimSRVd9Ac21GYuD8peA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Eq+EiKxG9EjW7mlOdt08xkKc534CrovgkHN6oAqEbvKSK9K9dpjlyf5EtklYPVy+/
         CcR6dJjhtW7bsPbWln4KTuKEADODYZYN0jfSIE8i1fnKlnX+hehYP7xyABK/b6eGAo
         YfZ3FsIX1tSUaR8o92BGXwgbT5DQtboHC7dj+yUc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FDIwrjWU5y9O; Sat,  5 Dec 2020 15:04:33 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BDAE31280319;
        Sat,  5 Dec 2020 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607209473;
        bh=OHgDzHQ4UVZtoQc0+c8rR/RVimSRVd9Ac21GYuD8peA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Eq+EiKxG9EjW7mlOdt08xkKc534CrovgkHN6oAqEbvKSK9K9dpjlyf5EtklYPVy+/
         CcR6dJjhtW7bsPbWln4KTuKEADODYZYN0jfSIE8i1fnKlnX+hehYP7xyABK/b6eGAo
         YfZ3FsIX1tSUaR8o92BGXwgbT5DQtboHC7dj+yUc=
Message-ID: <8a169362defed5af16be78c5a11f4ff9f58da2a8.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 05 Dec 2020 15:04:31 -0800
In-Reply-To: <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
         <20201204170319.20383-8-laniel_francis@privacyrequired.com>
         <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
         <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
         <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
         <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
         <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
         <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
         <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2020-12-05 at 22:20 +0100, Ard Biesheuvel wrote:
> On Sat, 5 Dec 2020 at 22:15, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > [Rostedt added because this is all his fault]
> > On Sat, 2020-12-05 at 21:57 +0100, Ard Biesheuvel wrote:
> > > On Sat, 5 Dec 2020 at 21:24, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> > > > > So I don't object to using str_has_prefix() in new code in
> > > > > this way, but I really don't see the point of touching
> > > > > existing code.
> > > > 
> > > > That's your prerogative as a Maintainer ... I was just
> > > > explaining what the original author had in mind when
> > > > str_has_prefix() was created.
> > > > 
> > > 
> > > Sure, I fully understand you are not the one proposing these
> > > changes.
> > > 
> > > But if the pattern in question is so common, couldn't we go one
> > > step further and define something like
> > > 
> > > static inline const u8 *skip_prefix_or_null(const u8 *str, const
> > > u8 *prefix)
> > > {
> > > }
> > > 
> > > which returns a pointer into the original string, or NULL if the
> > > prefix is not present.
> > > 
> > > The current patch as proposed has no benefit whatsoever, but even
> > > the meaningful alternative you are proposing is not actually an
> > > improvement, given that it is not self-explanatory from the name
> > > 'str_has_prefix' what it returns, and so the code becomes more
> > > difficult to understand.
> > 
> > Ah, so this is the kernel maintainer's syndrome: you see an API
> > which isn't quite right for your use case, so you update or change
> > it.  Then you see other use cases for it and suddenly to you it
> > becomes the best thing since sliced bread and with a one ring to
> > rule them all mentality you exhort everyone to use this new API
> > everywhere.  See this comment in the merge commit (495d714ad1400)
> > which comes from the merge cover letter:
> > 
> > >     - Addition of str_has_prefix() and a few use cases. There
> > >       currently is a similar function strstart() that is used in
> > > a
> > >       few places, but only returns a bool and not a length. These
> > >       instances will be removed in the future to use
> > >       str_has_prefix() instead.
> > 
> > Then you forget about it until someone else acts on your somewhat
> > ill considered instruction and actually tries the
> > replacement.  Once someone takes up your cause, the API shows up in
> > dozens of emails and the actual debate about whether or not this is
> > such a good API really begins, with the poor person who picked it
> > up caught in the crossfire.
> > 
> > As maintainers we really should learn to put the cart before the 

s/to put/not to put/

> > horse.
> > 
> 
> I am not disagreeing with any of this, but I simply don't see a point
> in merging patches that apparently result in the exact same machine
> code to be generated, and don't substantially make the code itself
> any better.


Well, I think the pattern

if (strstarts(option, <string>)) {
   ...
   option += strlen(<same string>);

is a bad one because one day <string> may get updated but not <same
string>.  And if <same string> is too far away in the code it might not
even show up in the diff, leading to reviewers not noticing either.  So
I think eliminating the pattern is a definite improvement.

Now whether the improvement is enough that we should churn the code
base to fix it is another question.

James


