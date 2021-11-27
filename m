Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215F45F793
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbhK0Ase (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbhK0Aqd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:46:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F3C06175D;
        Fri, 26 Nov 2021 16:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80A97B82958;
        Sat, 27 Nov 2021 00:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93DC004E1;
        Sat, 27 Nov 2021 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637973797;
        bh=VjGdawolzHACJokhOF749JVacumNKAm7ctN8SJsDFQs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j83vBPHjzoi+5z+QBNC5xCGaH6OX0DbYWUS/IXK6DMhcvWeVvHv0LcGlcvQnEFaqV
         KLzquPPaHtXHmtBg64OHfG1wDnCcfidjQfMWKp3neSiqIDd/7XjCazdNPcocRGGb/D
         Bel3MZD0DBdUmCDyjXr4SxteS9e7oJ4ZJZF8/olXg/5QRNyitHf3tJscfDTH5HuKWl
         W2p31LZWBZlXOPmbHtziqb5SvgHfPTEuoyz9pRVQNRm6BWFfIoBoh8dDpGmj14Pk90
         XMJGACfOeZtZNENBgNeMRGLBCjy1RLDFjAZtw5PCfT39U8tyCuXXBxWD6EKoCLKN+G
         EKKWBZ5cXSk5Q==
Message-ID: <8f64f76e81a3e50118d0d332d43e78e9b89e2bd8.camel@kernel.org>
Subject: Re: [PATCH v8 05/17] X.509: Parse Basic Constraints for CA
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
Date:   Sat, 27 Nov 2021 02:43:14 +0200
In-Reply-To: <20211124044124.998170-6-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-6-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTIzIGF0IDIzOjQxIC0wNTAwLCBFcmljIFNub3diZXJnIHdyb3RlOgo+
IFBhcnNlIHRoZSBYLjUwOSBCYXNpYyBDb25zdHJhaW50cy7CoCBUaGUgYmFzaWMgY29uc3RyYWlu
dHMgZXh0ZW5zaW9uCj4gaWRlbnRpZmllcyB3aGV0aGVyIHRoZSBzdWJqZWN0IG9mIHRoZSBjZXJ0
aWZpY2F0ZSBpcyBhIENBLgo+IAo+IEJhc2ljQ29uc3RyYWludHMgOjo9IFNFUVVFTkNFIHsKPiDC
oMKgwqDCoMKgwqDCoCBjQcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBCT09MRUFOIERFRkFVTFQgRkFMU0UsCj4gwqDCoMKgwqDCoMKgwqAgcGF0aExlbkNvbnN0cmFp
bnTCoMKgwqDCoMKgwqAgSU5URUdFUiAoMC4uTUFYKSBPUFRJT05BTCB9Cj4gCj4gSWYgdGhlIENB
IGlzIHRydWUsIHN0b3JlIGl0IGluIGEgbmV3IHB1YmxpY19rZXkgZmllbGQgY2FsbCBrZXlfaXNf
Y2EuCj4gVGhpcyB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3cgb24gcGF0Y2ggdGhhdCByZXF1aXJl
cyBrbm93aW5nIGlmIHRoZQo+IHB1YmxpYyBrZXkgaXMgYSBDQS4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+CgpZb3UgY291bGQgZXh0
ZW5kIHRoZSBkZXNjcmlwdGlvbiB0byBzdGF0ZSB3aHkga2VybmVsIG5lZWRzIFguNTA5IEJhc2lj
CkNvbnN0cmFpbnRzIHN1cHBvcnQuCgovSmFya2tvCgo+IC0tLQo+IHY3OiBJbml0aWFsIHZlcnNp
b24KPiB2ODogTW92ZWQga2V5X2lzX2NhIGFmdGVyIGtleV9pc19wcml2YXRlLCByZWNvbW1lbmRl
ZCBieSBNaW1pCj4gLS0tCj4gwqBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJz
ZXIuYyB8IDkgKysrKysrKysrCj4gwqBpbmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMSArCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2Nl
cnRfcGFyc2VyLmMgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIuYwo+
IGluZGV4IDZkMDAzMDk2YjViYy4uZjQyOTliOGE0OTI2IDEwMDY0NAo+IC0tLSBhL2NyeXB0by9h
c3ltbWV0cmljX2tleXMveDUwOV9jZXJ0X3BhcnNlci5jCj4gKysrIGIvY3J5cHRvL2FzeW1tZXRy
aWNfa2V5cy94NTA5X2NlcnRfcGFyc2VyLmMKPiBAQCAtNTcxLDYgKzU3MSwxNSBAQCBpbnQgeDUw
OV9wcm9jZXNzX2V4dGVuc2lvbih2b2lkICpjb250ZXh0LCBzaXplX3QgaGRybGVuLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqDCoMKgwqDCoMKgwqDCoH0K
PiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmIChjdHgtPmxhc3Rfb2lkID09IE9JRF9iYXNpY0NvbnN0
cmFpbnRzKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2WzBdICE9IChB
U04xX0NPTlNfQklUIHwgQVNOMV9TRVEpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FQkFETVNHOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAodlsxXSAhPSB2bGVuIC0gMikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUJBRE1TRzsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKHZbMV0gIT0gMCAmJiB2WzJdID09IEFTTjFfQk9PTCAmJiB2
WzNdID09IDEpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjdHgtPmNlcnQtPnB1Yi0+a2V5X2lzX2NhID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4g
Kwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmggYi9pbmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmgK
PiBpbmRleCBhOWIyZTYwMGI3Y2MuLjcyZGNiYzA2ZWY5YyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2NyeXB0by9wdWJsaWNfa2V5LmgKPiArKysgYi9pbmNsdWRlL2NyeXB0by9wdWJsaWNfa2V5LmgK
PiBAQCAtMjYsNiArMjYsNyBAQCBzdHJ1Y3QgcHVibGljX2tleSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oHZvaWQgKnBhcmFtczsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHBhcmFtbGVuOwo+IMKgwqDCoMKg
wqDCoMKgwqBib29sIGtleV9pc19wcml2YXRlOwo+ICvCoMKgwqDCoMKgwqDCoGJvb2wga2V5X2lz
X2NhOwo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICppZF90eXBlOwo+IMKgwqDCoMKgwqDC
oMKgwqBjb25zdCBjaGFyICpwa2V5X2FsZ287Cj4gwqB9OwoK

