Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E71645F798
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhK0Ate (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:49:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35636 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbhK0Are (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C50B82952;
        Sat, 27 Nov 2021 00:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C21BC53FAD;
        Sat, 27 Nov 2021 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637973856;
        bh=rfvpfKXLCaSNNNFNVBnKe/kSS8lH0PdMoALqVSwzBpc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gGJVPYSKH4Bsuf/J04morcSX5/GEwbebmqikEgNr7qOd0/UqHucWU69AlGLltIvTw
         Fw1PJJJX8/JVnYTqEYsXZXZL0L/ghmnhgfrbHnM/uX9sFdFBmLyieICiJrmrJ9Swa7
         /pMNO+n2E3RVCSVaKJk8+lvC+puxKN8kno2I9IWReF31WEKoutNuoi1eLQIpO0F6Ng
         DsKXUWwk8aW4+6Camdvzpyh5eYDi4liIMoHcm87T4/KDvpWYQprtykXvjnaV9pKYqm
         8Ci6Uk4hqNwXmVknjonM1g+Exxc4idGTac0QggbJqyAvpW4evbg3uQubBtb+ySBWK0
         qt7HQPwOYQX/g==
Message-ID: <eeef5333bdfa32cfeae311aad2c66fcd77261c5f.camel@kernel.org>
Subject: Re: [PATCH v8 06/17] KEYS: CA link restriction
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
Date:   Sat, 27 Nov 2021 02:44:14 +0200
In-Reply-To: <20211124044124.998170-7-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-7-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTIzIGF0IDIzOjQxIC0wNTAwLCBFcmljIFNub3diZXJnIHdyb3RlOgo+
IEFkZCBhIG5ldyBsaW5rIHJlc3RyaWN0aW9uLsKgIFJlc3RyaWN0IHRoZSBhZGRpdGlvbiBvZiBr
ZXlzIGluIGEga2V5cmluZwo+IGJhc2VkIG9uIHRoZSBrZXkgdG8gYmUgYWRkZWQgYmVpbmcgYSBD
QS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNs
ZS5jb20+CgpBbHNvIGhlcmUgeW91IHNob3VsZCBleHRlbmQgdGhlIHN0b3J5IGEgYml0Li4uCgov
SmFya2tvCgo+IC0tLQo+IHYxOiBJbml0aWFsIHZlcnNpb24KPiB2MjogUmVtb3ZlZCBzZWNvbmRh
cnkga2V5cmluZyByZWZlcmVuY2VzCj4gdjM6IFJlbW92ZWQgcmVzdHJpY3RfbGlua19ieV9zeXN0
ZW1fdHJ1c3RlZF9vcl9jYQo+IMKgwqDCoCBTaW1wbGlmeSByZXN0cmljdF9saW5rX2J5X2NhIC0g
b25seSBzZWUgaWYgdGhlIGtleSBpcyBhIENBCj4gwqDCoMKgIERpZCBub3QgYWRkIF9faW5pdCBp
biBmcm9udCBvZiByZXN0cmljdF9saW5rX2J5X2NhIGluIGNhc2UKPiDCoMKgwqDCoMKgIHJlc3Ry
aWN0aW9uIGNvdWxkIGJlIHJlc3VlZCBpbiB0aGUgZnV0dXJlCj4gdjY6IFVubW9kaWZpZWQgZnJv
bSB2Mwo+IHY3OiBDaGVjayBmb3IgQ0EgcmVzdHJ1Y3Rpb24gaW4gcHVibGljIGtleQo+IHY4OiBG
aXggaXNzdWUgZm91bmQgYnkgYnVpbGQgYm90IHdoZW4gYXN5bSBrZXlzIG5vdCBkZWZpbmVkIGlu
IHRoZSBjb25maWcKPiAtLS0KPiDCoGNyeXB0by9hc3ltbWV0cmljX2tleXMvcmVzdHJpY3QuYyB8
IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoGluY2x1ZGUvY3J5cHRvL3B1
YmxpY19rZXkuaMKgwqDCoMKgwqDCoCB8IDE1ICsrKysrKysrKysrCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDU4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNf
a2V5cy9yZXN0cmljdC5jIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmljdC5jCj4gaW5k
ZXggODRjZWZlM2IzNTg1Li5hODkxYzU5OGEyYWEgMTAwNjQ0Cj4gLS0tIGEvY3J5cHRvL2FzeW1t
ZXRyaWNfa2V5cy9yZXN0cmljdC5jCj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0
cmljdC5jCj4gQEAgLTEwOCw2ICsxMDgsNDkgQEAgaW50IHJlc3RyaWN0X2xpbmtfYnlfc2lnbmF0
dXJlKHN0cnVjdCBrZXkgKmRlc3Rfa2V5cmluZywKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJl
dDsKPiDCoH0KPiDCoAo+ICsvKioKPiArICogcmVzdHJpY3RfbGlua19ieV9jYSAtIFJlc3RyaWN0
IGFkZGl0aW9ucyB0byBhIHJpbmcgb2YgQ0Ega2V5cwo+ICsgKiBAZGVzdF9rZXlyaW5nOiBLZXly
aW5nIGJlaW5nIGxpbmtlZCB0by4KPiArICogQHR5cGU6IFRoZSB0eXBlIG9mIGtleSBiZWluZyBh
ZGRlZC4KPiArICogQHBheWxvYWQ6IFRoZSBwYXlsb2FkIG9mIHRoZSBuZXcga2V5Lgo+ICsgKiBA
dHJ1c3Rfa2V5cmluZzogVW51c2VkLgo+ICsgKgo+ICsgKiBDaGVjayBpZiB0aGUgbmV3IGNlcnRp
ZmljYXRlIGlzIGEgQ0EuIElmIGl0IGlzIGEgQ0EsIHRoZW4gbWFyayB0aGUgbmV3Cj4gKyAqIGNl
cnRpZmljYXRlIGFzIGJlaW5nIG9rIHRvIGxpbmsuCj4gKyAqCj4gKyAqIFJldHVybnMgMCBpZiB0
aGUgbmV3IGNlcnRpZmljYXRlIHdhcyBhY2NlcHRlZCwgLUVOT0tFWSBpZiB0aGUKPiArICogY2Vy
dGlmaWNhdGUgaXMgbm90IGEgQ0EuIC1FTk9QS0cgaWYgdGhlIHNpZ25hdHVyZSB1c2VzIHVuc3Vw
cG9ydGVkCj4gKyAqIGNyeXB0bywgb3Igc29tZSBvdGhlciBlcnJvciBpZiB0aGVyZSBpcyBhIG1h
dGNoaW5nIGNlcnRpZmljYXRlIGJ1dAo+ICsgKiB0aGUgc2lnbmF0dXJlIGNoZWNrIGNhbm5vdCBi
ZSBwZXJmb3JtZWQuCj4gKyAqLwo+ICtpbnQgcmVzdHJpY3RfbGlua19ieV9jYShzdHJ1Y3Qga2V5
ICpkZXN0X2tleXJpbmcsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBjb25zdCBzdHJ1Y3Qga2V5X3R5cGUgKnR5cGUsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCB1bmlvbiBrZXlfcGF5bG9hZCAqcGF5
bG9hZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBrZXkgKnRydXN0X2tleXJpbmcpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1
Y3QgcHVibGljX2tleV9zaWduYXR1cmUgKnNpZzsKPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1
Y3QgcHVibGljX2tleSAqcGtleTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHR5cGUgIT0gJmtl
eV90eXBlX2FzeW1tZXRyaWMpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRU9QTk9UU1VQUDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgc2lnID0gcGF5bG9hZC0+ZGF0YVth
c3ltX2F1dGhdOwo+ICvCoMKgwqDCoMKgwqDCoGlmICghc2lnKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT1BLRzsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFz
aWctPmF1dGhfaWRzWzBdICYmICFzaWctPmF1dGhfaWRzWzFdKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0tFWTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcGtleSA9
IHBheWxvYWQtPmRhdGFbYXN5bV9jcnlwdG9dOwo+ICvCoMKgwqDCoMKgwqDCoGlmICghcGtleSkK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9QS0c7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoGlmICghcGtleS0+a2V5X2lzX2NhKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVOT0tFWTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHB1
YmxpY19rZXlfdmVyaWZ5X3NpZ25hdHVyZShwa2V5LCBzaWcpOwo+ICt9Cj4gKwo+IMKgc3RhdGlj
IGJvb2wgbWF0Y2hfZWl0aGVyX2lkKGNvbnN0IHN0cnVjdCBhc3ltbWV0cmljX2tleV9pZHMgKnBh
aXIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnN0IHN0cnVjdCBhc3ltbWV0cmljX2tleV9pZCAqc2luZ2xlKQo+IMKgewo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmggYi9pbmNsdWRlL2NyeXB0by9wdWJs
aWNfa2V5LmgKPiBpbmRleCA3MmRjYmMwNmVmOWMuLjA2ZTM0ZDMzNDBjNCAxMDA2NDQKPiAtLS0g
YS9pbmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmgKPiArKysgYi9pbmNsdWRlL2NyeXB0by9wdWJs
aWNfa2V5LmgKPiBAQCAtNzIsNiArNzIsMjEgQEAgZXh0ZXJuIGludCByZXN0cmljdF9saW5rX2J5
X2tleV9vcl9rZXlyaW5nX2NoYWluKHN0cnVjdCBrZXkgKnRydXN0X2tleXJpbmcsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHVuaW9uIGtleV9wYXlsb2Fk
ICpwYXlsb2FkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3Qga2V5ICp0cnVzdGVkKTsKPiDCoAo+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19BU1lNTUVU
UklDX0tFWV9UWVBFKQo+ICtleHRlcm4gaW50IHJlc3RyaWN0X2xpbmtfYnlfY2Eoc3RydWN0IGtl
eSAqZGVzdF9rZXlyaW5nLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBrZXlfdHlwZSAqdHlwZSwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCB1bmlvbiBrZXlfcGF5bG9hZCAqcGF5bG9hZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qga2V5ICp0cnVzdF9r
ZXlyaW5nKTsKPiArI2Vsc2UKPiArc3RhdGljIGlubGluZSBpbnQgcmVzdHJpY3RfbGlua19ieV9j
YShzdHJ1Y3Qga2V5ICpkZXN0X2tleXJpbmcsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1
Y3Qga2V5X3R5cGUgKnR5cGUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1bmlvbiBrZXlfcGF5
bG9hZCAqcGF5bG9hZCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBrZXkgKnRydXN0X2tleXJp
bmcpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArfQo+ICsjZW5kaWYKPiArCj4g
wqBleHRlcm4gaW50IHF1ZXJ5X2FzeW1tZXRyaWNfa2V5KGNvbnN0IHN0cnVjdCBrZXJuZWxfcGtl
eV9wYXJhbXMgKiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGtlcm5lbF9wa2V5X3F1ZXJ5ICopOwo+IMKgCgo=

