Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B229545F7AA
	for <lists+linux-efi@lfdr.de>; Sat, 27 Nov 2021 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbhK0Ayp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Nov 2021 19:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbhK0Awp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Nov 2021 19:52:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40667C061759;
        Fri, 26 Nov 2021 16:49:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B1D623B7;
        Sat, 27 Nov 2021 00:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F5C004E1;
        Sat, 27 Nov 2021 00:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637974171;
        bh=II20qEySVqkmsSffnQMR42gko5v15gO6v2AkIbhSHD0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iCVlXX3jsDnAMRVtdTCa93IvYSoHXQ1jKDjJmY74JoFTchF1pI0dNgxsyM+btflf1
         4EO4qkjoLzyXjtscLvrESNgsWCXwNshsULVAD3edlFTOGS7HH5rRGq0e0S+17SCl2Q
         YDFc3JmqFu+Ot8/Cj4LtNcXQ0YCoT6Ia+qnVglBvpSoEf7t70CiL4K5YfyMjtRJJJK
         CTwBqrqwBpCajd2b3UMDi/kov+PNaBLCK6TIAexpT2Pwf77JG+YXCFDMdmuyKsj9CV
         r45llRMd6IkphpjK+sPl0srU3z3pQjBLDPocCCDT+Nl3tHkoSe/U48efMc+tUKTylb
         FGt/rdmRXfjgQ==
Message-ID: <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
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
Date:   Sat, 27 Nov 2021 02:49:28 +0200
In-Reply-To: <20211124044124.998170-10-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-10-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTIzIGF0IDIzOjQxIC0wNTAwLCBFcmljIFNub3diZXJnIHdyb3RlOgo+
IEluIHByZXBhcmF0aW9uIGZvciByZXR1cm5pbmcgZWl0aGVyIHRoZSBleGlzdGluZwo+IHJlc3Ry
aWN0X2xpbmtfYnlfYnVpbHRpbl9hbmRfc2Vjb25kYXJ5X3RydXN0ZWQgb3IgdGhlIHVwY29taW5n
Cj4gcmVzdHJpY3Rpb24gdGhhdCBpbmNsdWRlcyB0aGUgdHJ1c3RlZCBidWlsdGluLCBzZWNvbmRh
cnkgYW5kCj4gbWFjaGluZSBrZXlzLCB0byBpbXByb3ZlIGNsYXJpdHksIHJlbmFtZQo+IGdldF9i
dWlsdGluX2FuZF9zZWNvbmRhcnlfcmVzdHJpY3Rpb24gdG8gZ2V0X3NlY29uZGFyeV9yZXN0cmlj
dGlvbi4KPiAKPiBTdWdnZXN0ZWQtYnk6IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29t
Pgo+IFJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+IC0tLQo+
IHY2OiBJbml0aWFsIHZlcnNpb24KPiB2NzogVW5tb2RpZmllZCBmcm9tIHY3Cj4gdjg6IENvZGUg
dW5tb2RpZmllZCBmcm9tIHY3LCBhZGRlZCBNaW1pJ3MgUmV2aWV3ZWQtYnkKPiAtLS0KPiDCoGNl
cnRzL3N5c3RlbV9rZXlyaW5nLmMgfCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2NlcnRzL3N5c3RlbV9r
ZXlyaW5nLmMgYi9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jCj4gaW5kZXggNjkyMzY1ZGVlMmJkLi44
ZjFmODc1Nzk4MTkgMTAwNjQ0Cj4gLS0tIGEvY2VydHMvc3lzdGVtX2tleXJpbmcuYwo+ICsrKyBi
L2NlcnRzL3N5c3RlbV9rZXlyaW5nLmMKPiBAQCAtNzcsNyArNzcsNyBAQCBpbnQgcmVzdHJpY3Rf
bGlua19ieV9idWlsdGluX2FuZF9zZWNvbmRhcnlfdHJ1c3RlZCgKPiDCoCAqIEFsbG9jYXRlIGEg
c3RydWN0IGtleV9yZXN0cmljdGlvbiBmb3IgdGhlICJidWlsdGluIGFuZCBzZWNvbmRhcnkgdHJ1
c3QiCj4gwqAgKiBrZXlyaW5nLiBPbmx5IGZvciB1c2UgaW4gc3lzdGVtX3RydXN0ZWRfa2V5cmlu
Z19pbml0KCkuCj4gwqAgKi8KPiAtc3RhdGljIF9faW5pdCBzdHJ1Y3Qga2V5X3Jlc3RyaWN0aW9u
ICpnZXRfYnVpbHRpbl9hbmRfc2Vjb25kYXJ5X3Jlc3RyaWN0aW9uKHZvaWQpCj4gK3N0YXRpYyBf
X2luaXQgc3RydWN0IGtleV9yZXN0cmljdGlvbiAqZ2V0X3NlY29uZGFyeV9yZXN0cmljdGlvbih2
b2lkKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qga2V5X3Jlc3RyaWN0aW9uICpyZXN0
cmljdGlvbjsKPiDCoAo+IEBAIC0xMTcsNyArMTE3LDcgQEAgc3RhdGljIF9faW5pdCBpbnQgc3lz
dGVtX3RydXN0ZWRfa2V5cmluZ19pbml0KHZvaWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEtFWV9VU1JfVklFVyB8IEtFWV9V
U1JfUkVBRCB8IEtFWV9VU1JfU0VBUkNIIHwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgS0VZX1VTUl9XUklURSksCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLRVlf
QUxMT0NfTk9UX0lOX1FVT1RBLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfYnVpbHRpbl9hbmRfc2Vjb25kYXJ5X3Jlc3RyaWN0
aW9uKCksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdldF9zZWNvbmRhcnlfcmVzdHJpY3Rpb24oKSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5VTEwpOwo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoSVNfRVJSKHNlY29uZGFyeV90cnVzdGVkX2tleXMpKQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFuaWMoIkNhbid0IGFsbG9jYXRlIHNlY29uZGFyeSB0
cnVzdGVkIGtleXJpbmdcbiIpOwoKVGhpcyBpcyB3cm9uZyBvcmRlci4KCllvdSBzaG91bGQgZmly
c3QgZG8gdGhlIGNoYW5nZXMgdGhhdCBtYWtlIHRoZSBvbGQgbmFtZQpvYnNvbGV0ZSBhbmQgb25s
eSBhZnRlciB0aGF0IGhhdmUgYSBwYXRjaCB0aGF0IGRvZXMgdGhlCnJlbmFtZS4gVW5mb3J0dW5h
dGVseSwgdGhpcyBwYXRjaCBjYW5ub3QgcG9zc2libHkgYWNrZWQKd2l0aCB0aGUgY3VycmVudCBv
cmRlci4KCgovSmFya2tvCg==

