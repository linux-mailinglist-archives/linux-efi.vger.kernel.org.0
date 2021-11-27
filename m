Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0B45F7A4
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbhK0AwR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhK0AuQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:50:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46235C061756;
        Fri, 26 Nov 2021 16:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6419623BC;
        Sat, 27 Nov 2021 00:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56D4C004E1;
        Sat, 27 Nov 2021 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637973991;
        bh=XvSnPhAvCLOCJ7UF2wfePKwVGk1ERZRcl2zgcp4vlU8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c+Dj5YZZvJR1eP5sgA0c8T4NctGeoOmP5qKdGE/j+J1VnAgJwQCcbV/RXMo/6/MtH
         aN/tY76+xbvZmt2p9k78Uq8CDKyvXbKnjD2T44KaQ+KRQ3pySC7je6qdiPfVHe8SIv
         cgAKmChL8LBEMWsidKNU6Zn6R4nUMHZ6Ajxf8xgMPWzzNxyjAFhBZVogji2KUuD4BH
         bR+bMZZ82LPUxleOAEDiLCm80PLMoo8cL9hfPLd7dYnIpQ+Pg9GxM92zQa8jfuZOrz
         iu4776PcDodPINfZTCDWrFkogFciRX/4Ef7XIEb9oylTE6DKQtMiblK8HFk0RH1cX1
         0vzEhVUPDkPfA==
Message-ID: <b6cd1296b3e0c0d7cfb79d2b68736e4271d2397a.camel@kernel.org>
Subject: Re: [PATCH v8 08/17] integrity: add new keyring handler for mok keys
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Sat, 27 Nov 2021 02:46:28 +0200
In-Reply-To: <20211124044124.998170-9-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-9-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Tml0OiBpbiB0aGUgc2hvcnQgc3VtbWFyeSBtb2sgLT4gTU9LCgpPdGhlcndpc2UgTEdUTS4KCi9K
YXJra28KCgpPbiBUdWUsIDIwMjEtMTEtMjMgYXQgMjM6NDEgLTA1MDAsIEVyaWMgU25vd2Jlcmcg
d3JvdGU6Cj4gQ3VycmVudGx5IGJvdGggU2VjdXJlIEJvb3QgREIgYW5kIE1hY2hpbmUgT3duZXIg
S2V5cyAoTU9LKSBnbyB0aHJvdWdoCj4gdGhlIHNhbWUga2V5cmluZyBoYW5kbGVyIChnZXRfaGFu
ZGxlcl9mb3JfZGIpLiBXaXRoIHRoZSBhZGRpdGlvbiBvZiB0aGUKPiBuZXcgbWFjaGluZSBrZXly
aW5nLCB0aGUgZW5kLXVzZXIgbWF5IGNob29zZSB0byB0cnVzdCBNT0sga2V5cy4KPiAKPiBJbnRy
b2R1Y2UgYSBuZXcga2V5cmluZyBoYW5kbGVyIHNwZWNpZmljIGZvciBNT0sga2V5cy7CoCBJZiBN
T0sga2V5cyBhcmUKPiB0cnVzdGVkIGJ5IHRoZSBlbmQtdXNlciwgdXNlIHRoZSBuZXcga2V5cmlu
ZyBoYW5kbGVyIGluc3RlYWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJp
Yy5zbm93YmVyZ0BvcmFjbGUuY29tPgo+IFJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBs
aW51eC5pYm0uY29tPgo+IC0tLQo+IHYxOiBJbml0aWFsIHZlcnNpb24KPiB2MzogT25seSBjaGFu
Z2UgdGhlIGtleXJpbmcgaGFuZGxlciBpZiB0aGUgc2Vjb25kYXJ5IGlzIGVuYWJsZWQKPiB2NDog
UmVtb3ZlZCB0cnVzdF9tb2tsaXN0IGNoZWNrCj4gdjU6IFJlbmFtZSB0byBtYWNoaW5lIGtleXJp
bmcKPiB2NzogVW5tb2RpZmllZCBmcm9tIHY1Cj4gdjg6IENvZGUgdW5tb2RpZmllZCBmcm9tIHY3
IGFkZGVkIE1pbWkncyBSZXZpZXdlZC1ieQo+IC0tLQo+IMKgLi4uL2ludGVncml0eS9wbGF0Zm9y
bV9jZXJ0cy9rZXlyaW5nX2hhbmRsZXIuY8KgIHwgMTcgKysrKysrKysrKysrKysrKy0KPiDCoC4u
Li9pbnRlZ3JpdHkvcGxhdGZvcm1fY2VydHMva2V5cmluZ19oYW5kbGVyLmjCoCB8wqAgNSArKysr
Kwo+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L3BsYXRmb3JtX2NlcnRzL2xvYWRfdWVmaS5jwqDCoCB8
wqAgNCArKy0tCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0
cy9rZXlyaW5nX2hhbmRsZXIuYyBiL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9r
ZXlyaW5nX2hhbmRsZXIuYwo+IGluZGV4IGU5NzkxYmU5OGZkOS4uNDg3Mjg1MGQwODFmIDEwMDY0
NAo+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hhbmRs
ZXIuYwo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hh
bmRsZXIuYwo+IEBAIC02Nyw3ICs2Nyw3IEBAIHN0YXRpYyBfX2luaXQgdm9pZCB1ZWZpX3Jldm9j
YXRpb25fbGlzdF94NTA5KGNvbnN0IGNoYXIgKnNvdXJjZSwKPiDCoAo+IMKgLyoKPiDCoCAqIFJl
dHVybiB0aGUgYXBwcm9wcmlhdGUgaGFuZGxlciBmb3IgcGFydGljdWxhciBzaWduYXR1cmUgbGlz
dCB0eXBlcyBmb3VuZCBpbgo+IC0gKiB0aGUgVUVGSSBkYiBhbmQgTW9rTGlzdFJUIHRhYmxlcy4K
PiArICogdGhlIFVFRkkgZGIgdGFibGVzLgo+IMKgICovCj4gwqBfX2luaXQgZWZpX2VsZW1lbnRf
aGFuZGxlcl90IGdldF9oYW5kbGVyX2Zvcl9kYihjb25zdCBlZmlfZ3VpZF90ICpzaWdfdHlwZSkK
PiDCoHsKPiBAQCAtNzYsNiArNzYsMjEgQEAgX19pbml0IGVmaV9lbGVtZW50X2hhbmRsZXJfdCBn
ZXRfaGFuZGxlcl9mb3JfZGIoY29uc3QgZWZpX2d1aWRfdCAqc2lnX3R5cGUpCj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4gKy8qCj4gKyAqIFJldHVybiB0aGUgYXBwcm9w
cmlhdGUgaGFuZGxlciBmb3IgcGFydGljdWxhciBzaWduYXR1cmUgbGlzdCB0eXBlcyBmb3VuZCBp
bgo+ICsgKiB0aGUgTW9rTGlzdFJUIHRhYmxlcy4KPiArICovCj4gK19faW5pdCBlZmlfZWxlbWVu
dF9oYW5kbGVyX3QgZ2V0X2hhbmRsZXJfZm9yX21vayhjb25zdCBlZmlfZ3VpZF90ICpzaWdfdHlw
ZSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGlmIChlZmlfZ3VpZGNtcCgqc2lnX3R5cGUsIGVmaV9j
ZXJ0X3g1MDlfZ3VpZCkgPT0gMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfSU5URUdSSVRZX01BQ0hJTkVfS0VZUklORykpCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gYWRkX3RvX21h
Y2hpbmVfa2V5cmluZzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGFkZF90
b19wbGF0Zm9ybV9rZXlyaW5nOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKPiArfQo+ICsKPiDCoC8qCj4gwqAgKiBSZXR1cm4gdGhlIGFwcHJvcHJpYXRlIGhh
bmRsZXIgZm9yIHBhcnRpY3VsYXIgc2lnbmF0dXJlIGxpc3QgdHlwZXMgZm91bmQgaW4KPiDCoCAq
IHRoZSBVRUZJIGRieCBhbmQgTW9rTGlzdFhSVCB0YWJsZXMuCj4gZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hhbmRsZXIuaCBiL3NlY3VyaXR5
L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hhbmRsZXIuaAo+IGluZGV4IDI0NjJi
ZmEwOGZlMy4uMjg0NTU4ZjMwNDExIDEwMDY0NAo+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9w
bGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hhbmRsZXIuaAo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0
eS9wbGF0Zm9ybV9jZXJ0cy9rZXlyaW5nX2hhbmRsZXIuaAo+IEBAIC0yNCw2ICsyNCwxMSBAQCB2
b2lkIGJsYWNrbGlzdF9iaW5hcnkoY29uc3QgY2hhciAqc291cmNlLCBjb25zdCB2b2lkICpkYXRh
LCBzaXplX3QgbGVuKTsKPiDCoCAqLwo+IMKgZWZpX2VsZW1lbnRfaGFuZGxlcl90IGdldF9oYW5k
bGVyX2Zvcl9kYihjb25zdCBlZmlfZ3VpZF90ICpzaWdfdHlwZSk7Cj4gwqAKPiArLyoKPiArICog
UmV0dXJuIHRoZSBoYW5kbGVyIGZvciBwYXJ0aWN1bGFyIHNpZ25hdHVyZSBsaXN0IHR5cGVzIGZv
dW5kIGluIHRoZSBtb2suCj4gKyAqLwo+ICtlZmlfZWxlbWVudF9oYW5kbGVyX3QgZ2V0X2hhbmRs
ZXJfZm9yX21vayhjb25zdCBlZmlfZ3VpZF90ICpzaWdfdHlwZSk7Cj4gKwo+IMKgLyoKPiDCoCAq
IFJldHVybiB0aGUgaGFuZGxlciBmb3IgcGFydGljdWxhciBzaWduYXR1cmUgbGlzdCB0eXBlcyBm
b3VuZCBpbiB0aGUgZGJ4Lgo+IMKgICovCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0
eS9wbGF0Zm9ybV9jZXJ0cy9sb2FkX3VlZmkuYyBiL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9y
bV9jZXJ0cy9sb2FkX3VlZmkuYwo+IGluZGV4IGYyOTBmNzhjM2YzMC4uYzFiZmQxY2Q3Y2MzIDEw
MDY0NAo+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9sb2FkX3VlZmku
Ywo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9wbGF0Zm9ybV9jZXJ0cy9sb2FkX3VlZmkuYwo+
IEBAIC05NCw3ICs5NCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGxvYWRfbW9rbGlzdF9jZXJ0cyh2
b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBwYXJzZV9lZmlfc2ln
bmF0dXJlX2xpc3QoIlVFRkk6TW9rTGlzdFJUIChNT0t2YXIgdGFibGUpIiwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW9rdmFyX2VudHJ5LT5kYXRhLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2t2YXJfZW50cnktPmRhdGFfc2l6ZSwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfaGFuZGxlcl9mb3JfZGIpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdldF9oYW5kbGVyX2Zvcl9tb2spOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogQWxsIGRvbmUgaWYgdGhhdCB3b3JrZWQuICovCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJjKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiBAQCAtMTA5LDcg
KzEwOSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGxvYWRfbW9rbGlzdF9jZXJ0cyh2b2lkKQo+IMKg
wqDCoMKgwqDCoMKgwqBtb2sgPSBnZXRfY2VydF9saXN0KEwiTW9rTGlzdFJUIiwgJm1va192YXIs
ICZtb2tzaXplLCAmc3RhdHVzKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1vaykgewo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBwYXJzZV9lZmlfc2lnbmF0dXJlX2xpc3Qo
IlVFRkk6TW9rTGlzdFJUIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2ss
IG1va3NpemUsIGdldF9oYW5kbGVyX2Zvcl9kYik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbW9rLCBtb2tzaXplLCBnZXRfaGFuZGxlcl9mb3JfbW9rKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKG1vayk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAocmMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcHJfZXJyKCJDb3VsZG4ndCBwYXJzZSBNb2tMaXN0UlQgc2lnbmF0dXJlczog
JWRcbiIsIHJjKTsKCg==

