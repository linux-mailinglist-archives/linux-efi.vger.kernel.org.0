Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB582D15ED
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgLGQ05 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Mon, 7 Dec 2020 11:26:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33791 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgLGQ05 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 11:26:57 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-Bby5aBFqM56ZRCF6phHXMw-1; Mon, 07 Dec 2020 16:25:18 +0000
X-MC-Unique: Bby5aBFqM56ZRCF6phHXMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Dec 2020 16:25:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Dec 2020 16:25:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "laniel_francis@privacyrequired.com" 
        <laniel_francis@privacyrequired.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Thread-Topic: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Thread-Index: AQHWzKs0kz/fG1FbOEiEJcYInMSfrqnr0Lsg
Date:   Mon, 7 Dec 2020 16:25:17 +0000
Message-ID: <70d98067245c4b4ebb411e68fb3162ef@AcuMS.aculab.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
        <20201204170319.20383-8-laniel_francis@privacyrequired.com>
        <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
        <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
        <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
        <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
        <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
        <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
        <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
        <8a169362defed5af16be78c5a11f4ff9f58da2a8.camel@HansenPartnership.com>
 <20201207101025.1d133a5d@gandalf.local.home>
In-Reply-To: <20201207101025.1d133a5d@gandalf.local.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Steven Rostedt
> Sent: 07 December 2020 15:10

> 
> On Sat, 05 Dec 2020 15:04:31 -0800
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > Well, I think the pattern
> >
> > if (strstarts(option, <string>)) {
> >    ...
> >    option += strlen(<same string>);
> >
> > is a bad one because one day <string> may get updated but not <same
> > string>.  And if <same string> is too far away in the code it might not
> > even show up in the diff, leading to reviewers not noticing either.  So
> > I think eliminating the pattern is a definite improvement.
> 
> And one of the reasons we created str_has_prefix() is because we fixed that
> exact bug, in a few places.
> 
> It was caused by a typo, where we had something like:
> 
> 	strstarts(option, "foo=") {
> 		option += strlen("foo");
> 
> and forgot the "=" part, and broke the rest of the logic.

And then someone else wonders whether the paint is the right colour.
Maybe the function should return the pointer to the character
after the prefix.

Suddenly you have a load of functions to pick from, none do
quite what you want - so you add yet another :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

