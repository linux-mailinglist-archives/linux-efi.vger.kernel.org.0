Return-Path: <linux-efi+bounces-4686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88995B4374B
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736E53B8A02
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1352EFD99;
	Thu,  4 Sep 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="tiySNM70"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC251A9F82;
	Thu,  4 Sep 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978575; cv=none; b=qlQzMrDkLLllMh/5eHbm8olJOheM08lIM7xMRfwkoqPyHX39mUWHKFCF+5bzSYx6oZOAvyrF+oqTp9NqyVJcptOEM53V2AUlpWtCqB58MfSITU70HnTp1U6H/C54FeUVxBbovH71DC9ycJMmnspnLydRkABBZECOa9nW9AF7rRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978575; c=relaxed/simple;
	bh=wjGzphpQSmdgD73ekPijlgtAxRIRaR7CsFHs0fRNlso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXr0kbpuvtQVv06fUcta8c7P1zoS3teZcYQUP/afyQ7rhVZdRdUTuQrpsmiPR9BLbkilQWD6aZGJz6QxR+HIdeuW7j/z+WKC0azR06tyqmG9fsQ4vn3r/R8LO75Q8gQz94iceGRZ9sG2GBckxa9GZgK+kYqJkzwdMMMSlapb0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=tiySNM70; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756978573; x=1788514573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjGzphpQSmdgD73ekPijlgtAxRIRaR7CsFHs0fRNlso=;
  b=tiySNM703RtKNRf5FJAKiQHqeK/XNj+6dGK8IVim3Wk0YCNrFKoSa5mv
   7RN//YdI11POPp0ozm5qaNgG+DjAB+LwufnAqzurkhEcbIjbIrHAFsyyG
   lxeQkjoK0IazF205HeAWSD0q7RYfLDatpXy+HlZwWds2hFuBJ9QhN8gBx
   GKZk7kKi45fiNVl+5OPm+nanIst2WFhEf5iqcdzpqcAkdw/Zog5rQsSca
   iJrgK2PHuRfAYJLlq41S9jDRKRC/zps4Hd5s4/Kje5DUAmFv4r6eqw6zM
   an+adF7kqfwOrQB8+ER2xCsJOL43RJ5AcVRPDZt7xrM76EotWbAk0urHH
   A==;
X-CSE-ConnectionGUID: bjc+8o0ZQjSAH2UyMvYysw==
X-CSE-MsgGUID: 4EwNZJGCR2GA8AZ5/CtUCA==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2272356"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:36:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:47410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id 67cfe508-291c-474a-991f-c5f04ba32975; Thu, 4 Sep 2025 09:36:10 +0000 (UTC)
X-Farcaster-Flow-ID: 67cfe508-291c-474a-991f-c5f04ba32975
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 09:36:10 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 4 Sep 2025
 09:36:08 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <ardb@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <bhe@redhat.com>, <changyuanl@google.com>, <graf@amazon.com>,
	<kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>, <rppt@kernel.org>
Subject: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
Date: Thu, 4 Sep 2025 09:34:09 +0000
Message-ID: <20250904093455.73184-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de> <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com> <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCA0IFNlcCAyMDI1IDA5OjE5OjIxICswMjAwLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiBPbiBTYXQsIDIzIEF1ZyAyMDI1IGF0IDIzOjQ3LCBBcmQgQmll
c2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiAoY2MgSWxpYXMpCj4gPgo+
ID4gTm90ZSB0byBha3BtOiBwbGVhc2UgZHJvcCB0aGlzIHNlcmllcyBmb3Igbm93Lgo+ID4KPiA+
IE9uIEZyaSwgMjIgQXVnIDIwMjUgYXQgMDQ6MDAsIEV2YW5nZWxvcyBQZXRyb25nb25hcyA8ZXBl
dHJvbkBhbWF6b24uZGU+IHdyb3RlOgo+ID4gPgo+ID4gPiBXaGVuIEtITyAoS2V4ZWMgSGFuZE92
ZXIpIGlzIGVuYWJsZWQsIGl0IHNldHMgdXAgc2NyYXRjaCBtZW1vcnkgcmVnaW9ucwo+ID4gPiBl
YXJseSBkdXJpbmcgZGV2aWNlIHRyZWUgc2Nhbm5pbmcuIEFmdGVyIGtleGVjLCB0aGUgbmV3IGtl
cm5lbAo+ID4gPiBleGNsdXNpdmVseSB1c2VzIHRoaXMgcmVnaW9uIGZvciBtZW1vcnkgYWxsb2Nh
dGlvbnMgZHVyaW5nIGJvb3QgdXAgdG8KPiA+ID4gdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBw
YWdlIGFsbG9jYXRvcgo+ID4gPgo+ID4gPiBIb3dldmVyLCB3aGVuIGJvb3Rpbmcgd2l0aCBFRkks
IEVGSSdzIHJlc2VydmVfcmVnaW9ucygpIHVzZXMKPiA+ID4gbWVtYmxvY2tfcmVtb3ZlKDAsIFBI
WVNfQUREUl9NQVgpIHRvIGNsZWFyIGFsbCBtZW1vcnkgcmVnaW9ucyBiZWZvcmUKPiA+ID4gcmVi
dWlsZGluZyB0aGVtIGZyb20gRUZJIGRhdGEuIFRoaXMgZGVzdHJveXMgS0hPIHNjcmF0Y2ggcmVn
aW9ucyBhbmQKPiA+ID4gdGhlaXIgZmxhZ3MsIHRodXMgY2F1c2luZyBhIGtlcm5lbCBwYW5pYywg
YXMgdGhlcmUgYXJlIG5vIHNjcmF0Y2gKPiA+ID4gbWVtb3J5IHJlZ2lvbnMuCj4gPiA+Cj4gPiA+
IEluc3RlYWQgb2Ygd2hvbGVzYWxlIHJlbW92YWwsIGl0ZXJhdGUgdGhyb3VnaCBtZW1vcnkgcmVn
aW9ucyBhbmQgb25seQo+ID4gPiByZW1vdmUgbm9uLUtITyBvbmVzLiBUaGlzIHByZXNlcnZlcyBL
SE8gc2NyYXRjaCByZWdpb25zLCB3aGljaCBhcmUKPiA+ID4gZ29vZCBrbm93biBtZW1vcnksIHdo
aWxlIHN0aWxsIGFsbG93aW5nIEVGSSB0byByZWJ1aWxkIGl0cyBtZW1vcnkgbWFwLgo+ID4gPgo+
ID4gPiBBY2tlZC1ieTogTWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KSA8cnBwdEBrZXJuZWwub3Jn
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuZ2Vsb3MgUGV0cm9uZ29uYXMgPGVwZXRyb25AYW1h
em9uLmRlPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlcyBpbiB2MzoKPiA+ID4gICAgICAgICAtIElt
cHJvdmUgdGhlIGNvZGUgY29tbWVudHMsIGJ5IHN0YXRpbmcgdGhhdCB0aGUgc2NyYXRjaCByZWdp
b25zIGFyZQo+ID4gPiAgICAgICAgIGdvb2Qga25vd24gbWVtb3J5Cj4gPiA+Cj4gPiA+IENoYW5n
ZXMgaW4gdjI6Cj4gPiA+ICAgICAgICAgLSBSZXBsYWNlIHRoZSBmb3IgbG9vcCB3aXRoIGZvcl9l
YWNoX21lbV9yZWdpb24KPiA+ID4gICAgICAgICAtIEZpeCBjb21tZW50IGluZGVudGF0aW9uCj4g
PiA+ICAgICAgICAgLSBBbWVuZCBjb21taXQgbWVzc2FnZSB0byBzcGVjaWZ5IHRoYXQgc2NyYXRj
aCByZWdpb25zCj4gPiA+ICAgICAgICAgYXJlIGtub3duIGdvb2QgcmVnaW9ucwo+ID4gPgo+ID4g
PiAgZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYyB8IDI5ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPiA+ID4KPiA+Cj4gPiBJJ2QgcmF0aGVyIGRyb3AgdGhlIG1lbWJsb2NrX3Jl
bW92ZSgpIGVudGlyZWx5IGlmIHBvc3NpYmxlLiBDb3VsZCB3ZQo+ID4gZ2V0IHNvbWUgaW5zaWdo
dCBpbnRvIHdoZXRoZXIgbWVtYmxvY2tzIGFyZSBnZW5lcmFsbHkgYWxyZWFkeQo+ID4gcG9wdWxh
dGVkIGF0IHRoaXMgcG9pbnQgZHVyaW5nIHRoZSBib290Pwo+ID4KPiA+Cj4gCj4gUGluZz8KCkhl
eSBBcmQgSSB3YXMgQUZLIHRyYXZlbGxpbmcuIEkgYW0gYmFjayBub3cgYW5kIHdpbGwgZ2V0IHRv
IGl0LgpQUzogS2VlbiB0byBtZWV0IHlvdSBsYXRlciB0b2RheSBpbiB0aGUgS1ZNIEZvcnVtLgoK
S2luZCBSZWdhcmRzLApFdmFuZ2Vsb3MKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1l
bnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


