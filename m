Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2FF30C19B
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhBBO2E (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 09:28:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58846 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234326AbhBBO02 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 09:26:28 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-274-flNrt4sAPICkZEemnUm5Og-1; Tue, 02 Feb 2021 14:24:34 +0000
X-MC-Unique: flNrt4sAPICkZEemnUm5Og-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 2 Feb 2021 14:24:32 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Feb 2021 14:24:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "raphael.gault@arm.com" <raphael.gault@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
Subject: RE: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Thread-Topic: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Thread-Index: AQHW+Pb1TwqrTbfiDUONrIh7m3kiG6pE6I/Q
Date:   Tue, 2 Feb 2021 14:24:32 +0000
Message-ID: <7c14b5b8b11241cd8271ba5b3f785c51@AcuMS.aculab.com>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <20210202000203.rk7lh5mx4aflgkwr@treble>
In-Reply-To: <20210202000203.rk7lh5mx4aflgkwr@treble>
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

U3RpcnJpbmcgbW9yZSBnb29wIGludG8gdGhlIGhvbGUgLi4uLg0KDQpSZXF1aXJpbmcgZ2NjLXBs
dWdpbnMsIG1hdGNoaW5nIGNvbXBpbGVyIHZlcnNpb25zIGFuZCB0aGUNCnNhbWUgJ2R3YXJmJyBm
b3JtYXQgZm9yIE9PVCBtb2R1bGVzIGlzIHByb2JhYmx5IHZlcnkgcGFpbmZ1bC4NCg0KSW4gbWFu
eSBjYXNlcyAoYW5kIHRoaXMgbWF5IGluY2x1ZGUgZHJpdmVycyByZWxlYXNlZCBieSBzb21lDQpk
aXN0cmlidXRpb25zKSBhbiBPT1QgZHJpdmVyIGhhcyB0d28gc2VwYXJhdGUgcGFydHMuDQoNCk9u
ZSBwYXJ0IGlzIEMgc291cmNlIHRoYXQgaXMgY29tcGlsZWQgd2hlbiB0aGUgbW9kdWxlIGlzIGJ1
aWx0DQpvbiB0aGUgdGFyZ2V0IHN5c3RlbSBhbmQgYWdhaW5zdCB0aGUgaW5zdGFsbGVkIGtlcm5l
bCBoZWFkZXJzLg0KR2V0dGluZyB0aGlzIHRvIG1hdGNoICdqdXN0JyByZWxpZXMgb24gaGF2aW5n
IHRoZSBjb3JyZWN0DQpjb21waWxlciAoZXRjKSBpbnN0YWxsZWQgYW5kIGluICRQQVRILg0KDQpU
aGUgc2Vjb25kIHBhcnQgaXMgbXVjaCBtb3JlIHByb2JsZW1hdGljLg0KVGhpcyBpcyBqdXN0IGFu
IG9iamVjdCBmaWxlIGNvbXBpbGVkIGJ5IGEgdGhpcmQgcGFydHkuDQpJdCBkb2Vzbid0IGRpcmVj
dGx5IGRlcGVuZCBvbiBhbnl0aGluZyBkZWZpbmVkIGluIHRoZQ0Ka2VybmVsIGhlYWRlcnMgLSBz
byBjYW4gKGN1cnJlbnRseSkgYmUgbGlua2VkIGludG8gYW55DQprZXJuZWwgdmVyc2lvbi4NCg0K
SW4gdGhlIHBhc3Qgc29tZSBncmFwaGljcyBkcml2ZXJzIGhhdmUgaGFkIGEgdGhpcmQgcGFydHkN
Cm9iamVjdCBmaWxlLg0KSSB0aGluayBzb21lIG9mIHRoZSBsYXB0b3Agd2lmaSBkcml2ZXJzIG1p
Z2h0IGFzIHdlbGwuDQoNCk5vdyBJIHNvbWUgcGVvcGxlIHRoaW5rIGV2ZXJ5dGhpbmcgc2hvdWxk
IGJlIGZyZWUgc291cmNlLg0KQnV0IHRoZXJlIGFyZSB2YXJpb3VzIGNvbW1lcmNpYWwgYW5kIHBy
YWN0aWNhbCByZWFzb25zDQpmb3IgYm90aCBPT1QgZHJpdmVycyBhbmQgb2JqZWN0IGZpbGUgJ2Js
b2JzJyBpbiBPT1QgZHJpdmVycy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

