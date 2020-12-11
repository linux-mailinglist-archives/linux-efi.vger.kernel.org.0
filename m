Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D12D7305
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393876AbgLKJrL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Dec 2020 04:47:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60041 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgLKJqz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Dec 2020 04:46:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-252-AgPfXOr8MiC6RNWXAg0nGg-1; Fri, 11 Dec 2020 09:45:16 +0000
X-MC-Unique: AgPfXOr8MiC6RNWXAg0nGg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 09:45:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 09:45:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "laniel_francis@privacyrequired.com" 
        <laniel_francis@privacyrequired.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Thread-Topic: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Thread-Index: AQHWzyB/+YxwkDE2h0210TLWUlhJ1qnxoqgg
Date:   Fri, 11 Dec 2020 09:45:15 +0000
Message-ID: <4c251bcaf8234dd19ca0ecd0a756cf7f@AcuMS.aculab.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
 <20201204170319.20383-8-laniel_francis@privacyrequired.com>
 <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
 <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
 <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
 <X9Jlfqiu/vCOAm3U@rani.riverdale.lan>
In-Reply-To: <X9Jlfqiu/vCOAm3U@rani.riverdale.lan>
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

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAxMCBEZWNlbWJlciAyMDIwIDE4OjE0DQouLi4N
Cj4gSSB3YXNuJ3QgYXdhcmUgb2Ygc3RyX2hhc19wcmVmaXgoKSBhdCB0aGUgdGltZS4gSXQgZG9l
cyBzZWVtIHVzZWZ1bCB0bw0KPiBlbGltaW5hdGUgdGhlIGR1cGxpY2F0aW9uIG9mIHRoZSBzdHJp
bmcgbGl0ZXJhbCwgSSBsaWtlIHRoZQ0KPiBza2lwX3ByZWZpeCgpIEFQSSBzdWdnZXN0aW9uLCBt
YXliZSBldmVuDQo+IA0KPiAJYm9vbCBzdHJfc2tpcF9wcmVmaXgoY29uc3QgY2hhciAqKnMsIGNv
bnN0IGNoYXIgKnBmeCkNCj4gCXsNCj4gCQlzaXplX3QgbGVuID0gc3RyX2hhc19wcmVmaXgoKnMs
IHBmeCk7DQo+IAkJKnMgKz0gbGVuOw0KPiAJCXJldHVybiAhIWxlbjsNCj4gCX0NCj4gCS4uLg0K
PiAJaWYgKHN0cl9za2lwX3ByZWZpeCgmb3B0aW9uLCBwcmVmaXgpKSB7IC4uLiB9DQo+IA0KPiB0
byBhdm9pZCB0aGUgaW50ZXJtZWRpYXRlIHZhcmlhYmxlLg0KDQpUaGF0J2xsIGdlbmVyYXRlIGhv
cnJpZCBjb2RlIC0gdGhlICdvcHRpb24nIHZhcmlhYmxlIGhhcyB0byBiZQ0KcmVwZWF0ZWRseSBy
ZWxvYWRlZCBmcm9tIG1lbW9yeSAodW5sZXNzIGl0IGlzIGFsbCBpbmxpbmVkKS4NCg0KUGVyaGFw
cyB0aGUgI2RlZmluZQ0KDQojZGVmaW5lIHN0cl9za2lwX3ByZWZpeChzdHIsIHByZWZpeCkgXA0K
eyggXA0KCXNpemVfdCBfcGZ4X2xlbiA9IHN0cmxlbihwcmVmaXgpKTsgXA0KCW1lbWNtcChzdHIs
IHBmeCwgX3BmeF9sZW4pID8gMCA6ICgoc3RyKSArPSBfcGZ4X2xlbiwgMSk7IFwNCil9DQoNClRo
ZXJlJ3MgcHJvYmFibHkgc29tZXRoaW5nIHRoYXQnbGwgbGV0IHlvdSB1c2Ugc2l6ZW9mKCkgaW5z
dGVhZA0Kb2Ygc3RybGVuKCkgZm9yIHF1b3RlZCBzdHJpbmdzIChpZiBvbmx5IHNpemVvZiBwZngg
IT0gc2l6ZW9mIChjaGFyICopKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

