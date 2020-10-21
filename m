Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1118B295408
	for <lists+linux-efi@lfdr.de>; Wed, 21 Oct 2020 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395378AbgJUVSn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Oct 2020 17:18:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59524 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506013AbgJUVSm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Oct 2020 17:18:42 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-190-mJ-rMIRbOpWxzbbz5YLg0w-1; Wed, 21 Oct 2020 22:18:39 +0100
X-MC-Unique: mJ-rMIRbOpWxzbbz5YLg0w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 21 Oct 2020 22:18:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 21 Oct 2020 22:18:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>, Joe Perches <joe@perches.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, "X86 ML" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Marco Elver <elver@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: RE: [PATCH -next] treewide: Remove stringification from __alias macro
 definition
Thread-Topic: [PATCH -next] treewide: Remove stringification from __alias
 macro definition
Thread-Index: AQHWp9zKqfE0UY1ZpUePerljMWlMOqmijyIw
Date:   Wed, 21 Oct 2020 21:18:38 +0000
Message-ID: <1f487127202a49c09bc5db4fd95ec247@AcuMS.aculab.com>
References: <e9b1ba517f06b81bd24e54c84f5e44d81c27c566.camel@perches.com>
 <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
In-Reply-To: <CAMj1kXHe0hEDiGNMM_fg3_RYjM6B6mbKJ+1R7tsnA66ZzsiBgw@mail.gmail.com>
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
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMjEgT2N0b2JlciAyMDIwIDIwOjAzDQo+IA0K
PiBPbiBXZWQsIDIxIE9jdCAyMDIwIGF0IDIwOjU4LCBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IExpa2UgdGhlIF9fc2VjdGlvbiBtYWNybywgdGhlIF9fYWxp
YXMgbWFjcm8gdXNlcw0KPiA+IG1hY3JvICMgc3RyaW5naWZpY2F0aW9uIHRvIGNyZWF0ZSBxdW90
ZXMgYXJvdW5kDQo+ID4gdGhlIHNlY3Rpb24gbmFtZSB1c2VkIGluIHRoZSBfX2F0dHJpYnV0ZV9f
Lg0KPiA+DQo+ID4gUmVtb3ZlIHRoZSBzdHJpbmdpZmljYXRpb24gYW5kIGFkZCBxdW90ZXMgb3Ig
YQ0KPiA+IHN0cmluZ2lmaWNhdGlvbiB0byB0aGUgdXNlcyBpbnN0ZWFkLg0KPiA+DQo+IA0KPiBX
aHk/DQoNCkl0IGFsbG93cyB0aGUgc2VjdGlvbiBuYW1lIGJlIG1hZGUgdXAgb2YgdHdvIGNvbmNh
dGVuYXRlZCBzdHJpbmdzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

