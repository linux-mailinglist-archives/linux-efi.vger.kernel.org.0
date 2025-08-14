Return-Path: <linux-efi+bounces-4550-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA20CB25892
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 02:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C635A6B99
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 00:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770F2EB11;
	Thu, 14 Aug 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="iCnpY2c1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B5EEB2;
	Thu, 14 Aug 2025 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132819; cv=none; b=YAxXU+dRBxHrF3vhOQ8Ru1/OLT24u7tm0lkcPlfxlG1TDTtLGFX8ahvXFqAFGmjhRcu8UJ2M9nhkb8Og5tCjS6bJf3zVw37AGUUVKzu3P450FQ1nf6uY2Wy0tuS7vU11pyVI4NdFpgw2uxZKlTwwZm65ptbKpLUyge6S1utfb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132819; c=relaxed/simple;
	bh=1ORJIFZKqjNpVC2Sd7H0x9EA+Vt2CmcnwYXOtshSG4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwfBTvqAya3zm6xpxiZGPOQnG+8BRHfpJL9+bPE8Fdfs03IrFnDiaovAVihVeFig50wQPm4xz6Fw33ZDXEgX024HuVdVSpTYQU4hjjGNsxoYvutgzOLoj8ob1ZUvoO9V2yx7Pnx569TEAHdfzJBj8mIdsxk7shxwYT253GL0w7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=iCnpY2c1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755132818; x=1786668818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ORJIFZKqjNpVC2Sd7H0x9EA+Vt2CmcnwYXOtshSG4o=;
  b=iCnpY2c1M+WMJbO+ogxN4t6ym1qABHOgltdkVGMm0OqFJ3aJoGYFXWw7
   f71AIUVMSEA5WZdn+YovDRwUdQ2T0XfLoirBYvZt/hvUbAwOi2zs1tJ4z
   9esEUOggf8BN9jyf1qDD3/JRnsAFmt/hZZD7FMF3JuAhcK5JeyL4uXDWq
   LUT1YfQQ4RRIoWSGCAglvJegQyxagCwhywYVJ3xQGrg/2+tNCKrtWB4Em
   pCo0A9Mud1lKTQPKaB7W+kSPvlR2gMcGllJ0+p/DnlLYErCp7YMQKR2Xc
   zPU11q4jlKFMKIZBWh42K60z6oydwTJG7GNsSupre3+f49W4GcGS4AjW/
   w==;
X-IronPort-AV: E=Sophos;i="6.17,287,1747699200"; 
   d="scan'208";a="544402597"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 00:53:33 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:54312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.219:2525] with esmtp (Farcaster)
 id 936cf1f1-6a32-4613-b27d-a7c18e18a2cc; Thu, 14 Aug 2025 00:53:31 +0000 (UTC)
X-Farcaster-Flow-ID: 936cf1f1-6a32-4613-b27d-a7c18e18a2cc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 14 Aug 2025 00:53:31 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 14 Aug 2025
 00:53:29 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <rppt@kernel.org>
CC: <ardb@kernel.org>, <changyuanl@google.com>, <epetron@amazon.de>,
	<graf@amazon.com>, <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH] efi: Support booting with kexec handover (KHO)
Date: Thu, 14 Aug 2025 00:53:15 +0000
Message-ID: <20250814005321.31705-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aJmQNuQxLLtXjq2r@kernel.org>
References: <aJmQNuQxLLtXjq2r@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGV5IE1pa2UsIHRoYW5rcyBmb3IgeW91ciByZXZpZXcsCgpPbiBNb24sIDExIEF1ZyAyMDI1IDA5
OjM5OjUwICswMzAwLCBNaWtlIFJhcG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9u
IEZyaSwgQXVnIDA4LCAyMDI1IGF0IDA0OjM2OjUxUE0gKzAwMDAsIEV2YW5nZWxvcyBQZXRyb25n
b25hcyB3cm90ZToKPiA+IFdoZW4gS0hPIChLZXhlYyBIYW5kT3ZlcikgaXMgZW5hYmxlZCwgaXQg
c2V0cyB1cCBzY3JhdGNoIG1lbW9yeSByZWdpb25zCj4gPiBlYXJseSBkdXJpbmcgZGV2aWNlIHRy
ZWUgc2Nhbm5pbmcuIEFmdGVyIGtleGVjLCB0aGUgbmV3IGtlcm5lbAo+ID4gZXhjbHVzaXZlbHkg
dXNlcyB0aGlzIHJlZ2lvbiBmb3IgbWVtb3J5IGFsbG9jYXRpb25zIGR1cmluZyBib290IHVwIHRv
Cj4gPiB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIHBhZ2UgYWxsb2NhdG9yCj4gPgo+ID4gSG93
ZXZlciwgd2hlbiBib290aW5nIHdpdGggRUZJLCBFRkkncyByZXNlcnZlX3JlZ2lvbnMoKSB1c2Vz
Cj4gPiBtZW1ibG9ja19yZW1vdmUoMCwgUEhZU19BRERSX01BWCkgdG8gY2xlYXIgYWxsIG1lbW9y
eSByZWdpb25zIGJlZm9yZQo+ID4gcmVidWlsZGluZyB0aGVtIGZyb20gRUZJIGRhdGEuIFRoaXMg
ZGVzdHJveXMgS0hPIHNjcmF0Y2ggcmVnaW9ucyBhbmQKPiA+IHRoZWlyIGZsYWdzLCB0aHVzIGNh
dXNpbmcgYSBrZXJuZWwgcGFuaWMsIGFzIHRoZXJlIGFyZSBubyBzY3JhdGNoCj4gPiBtZW1vcnkg
cmVnaW9ucy4KPiA+Cj4gPiBJbnN0ZWFkIG9mIHdob2xlc2FsZSByZW1vdmFsLCBpdGVyYXRlIHRo
cm91Z2ggbWVtb3J5IHJlZ2lvbnMgYW5kIG9ubHkKPiA+IHJlbW92ZSBub24tS0hPIG9uZXMuIFRo
aXMgcHJlc2VydmVzIEtITyBzY3JhdGNoIHJlZ2lvbnMgd2hpbGUgc3RpbGwKPiA+IGFsbG93aW5n
IEVGSSB0byByZWJ1aWxkIGl0cyBtZW1vcnkgbWFwLgo+Cj4gSXQncyB3b3J0aCBtZW50aW9uaW5n
IHRoYXQgc2NyYXRjaCBhcmVhcyBhcmUgImdvb2Qga25vd24gbWVtb3J5IiA6KQo+CgpJIFdpbGwg
ZG8gc28gb24gUmV2Mi4KCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuZ2Vsb3MgUGV0cm9uZ29uYXMg
PGVwZXRyb25AYW1hem9uLmRlPgo+ID4gLS0tCj4gPgo+ID4gUmVwcm9kdWN0aW9uL1ZlcmlmaWNh
dGlvbiBTdGVwcwo+ID4gVGhlIGlzc3VlIGFuZCB0aGUgZml4IGNhbiBiZSByZXByb2R1Y2VkL3Zl
cmlmaWVkIGJ5IGJvb3RpbmcgYSBWTSB3aXRoCj4gPiBFRkkgYW5kIGF0dGVtcHRpbmcgdG8gcGVy
Zm9ybSBhIEtITyBlbmFibGVkIGtleGVjLiBUaGUgZml4Cj4gPiB3YXMgZGV2ZWxvcGVkL3Rlc3Rl
ZCBvbiBhcm02NC4KPiA+Cj4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYyB8IDMx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS1pbml0
LmMKPiA+IGluZGV4IGEwMGUwN2I4NTNmMjIuLjJmMDhiMWFiNzY0ZjYgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmktaW5pdC5jCj4gPiArKysgYi9kcml2ZXJzL2Zpcm13
YXJlL2VmaS9lZmktaW5pdC5jCj4gPiBAQCAtMTY0LDEyICsxNjQsMzUgQEAgc3RhdGljIF9faW5p
dCB2b2lkIHJlc2VydmVfcmVnaW9ucyh2b2lkKQo+ID4gIAkJcHJfaW5mbygiUHJvY2Vzc2luZyBF
RkkgbWVtb3J5IG1hcDpcbiIpOwo+ID4KPiA+ICAJLyoKPiA+IC0JICogRGlzY2FyZCBtZW1ibG9j
a3MgZGlzY292ZXJlZCBzbyBmYXI6IGlmIHRoZXJlIGFyZSBhbnkgYXQgdGhpcwo+ID4gLQkgKiBw
b2ludCwgdGhleSBvcmlnaW5hdGUgZnJvbSBtZW1vcnkgbm9kZXMgaW4gdGhlIERULCBhbmQgVUVG
SQo+ID4gLQkgKiB1c2VzIGl0cyBvd24gbWVtb3J5IG1hcCBpbnN0ZWFkLgo+ID4gKwkgKiBEaXNj
YXJkIG1lbWJsb2NrcyBkaXNjb3ZlcmVkIHNvIGZhciBleGNlcHQgZm9yIEtITyBzY3JhdGNoIHJl
Z2lvbnMuCj4gPiArCSAqIE1vc3QgbWVtYmxvY2tzIGF0IHRoaXMgcG9pbnQgb3JpZ2luYXRlIGZy
b20gbWVtb3J5IG5vZGVzIGluIHRoZSBEVCwKPiA+ICsJICogYW5kIFVFRkkgdXNlcyBpdHMgb3du
IG1lbW9yeSBtYXAgaW5zdGVhZC4gSG93ZXZlciwgaWYgS0hPIGlzIGVuYWJsZWQsCj4gPiArCSAq
IHNjcmF0Y2ggcmVnaW9ucyBtdXN0IGJlIHByZXNlcnZlZC4KPiA+ICAJICovCj4gPiAgCW1lbWJs
b2NrX2R1bXBfYWxsKCk7Cj4gPiAtCW1lbWJsb2NrX3JlbW92ZSgwLCBQSFlTX0FERFJfTUFYKTsK
PiA+ICsKPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX01FTUJMT0NLX0tIT19TQ1JBVENIKSkg
ewo+Cj4gSXQncyBiZXR0ZXIgdG8gY29uZGl0aW9uIHRoaXMgb24ga2hvX2dldF9mZHQoKSB0aGF0
IG1lYW5zIHRoYXQgd2UgYXJlCj4gYWN0dWFsbHkgZG9pbmcgYSBoYW5kb3Zlci4KPgoKSG1tLCBJ
IHNlZSB0aGF0IGBraG9fZ2V0X2ZkdCgpYCBpcyBzdGF0aWMuIE15IGZpcnN0IGluc3RpbmN0IHdh
cyB0byB1c2UKa2hvX2VuYWJsZSgpIGluc3RlYWQuIERpdmluZyBhIGJpdCBtb3JlIGludG8gdGhl
IGluaXRpYWxpc2F0aW9uIGZsb3csCmR1cmluZyB0aGUgYHNldHVwX2FyY2goKWAtPmBlZmlfaW5p
dCgpYCwgYGtob19lbmFibGUoKWAgd2lsbCByZXR1cm4KdHJ1ZSBpZiBraG8gaXMgZW5hYmxlZCBp
biB0aGUgY21kbGluZSwgYnV0IG5vdCBpZiB3ZSBhcmUgYWN0dWFsbHkgZG9pbmcKYSBLSE8gZW5h
YmxlZCBrZXhlYy4gSG93ZXZlciwgaW4gdGhpcyBjYXNlLCB0aGUgcGFyc2luZyBvZiBtZW1vcnkK
cmVnaW9ucyBpcyBnb2luZyB0byBiZSBhIG5vb3AgaW4gdGVybXMgb2YgZnVuY3Rpb25hbGl0eSwg
YnV0IHdpbGwKY29udHJpYnV0ZSwgbmVnYXRpdmVseSDigJR0aG91Z2ggdGhlIG92ZXJoZWFkIHdv
dWxkIGxpa2VseSBiZQp1bm1lYXN1cmFibGUgdG8gdGhlIChjb2xkKSBib290IHRpbWUuIElmIHdl
ICB3YW50IHRvIGF2b2lkIHRoYXQsIHdlCm1pZ2h0IGNvbnNpZGVyIGFkZGluZyBhbm90aGVyIGZ1
bmN0aW9uIHRvIHRoZSBLSE8gQVBJLCBsaWtlCmBpc19ib290aW5nX3dpdGhfa2hvKClgLCB0aGF0
IHByYWN0aWNhbGx5IHdyYXBzIHRoZSBga2hvX2dldF9mZHQoKWAuCklNTywgaXQgZmVlbHMgYSBi
aXQgY2xlYW5lciB0aGlzIHdheSwgYXMgb3RoZXIgY29tcG9uZW50cyAgZG9uJ3QKbmVjZXNzYXJp
bHkgKG5lZWQgdG8pIGtub3cgdGhlIGludGVybmFsIEZEVCBiYXNlZCBpbXBsZW1lbnRhdGlvbiBv
ZgpLSE8uIFRoYXQgYmVpbmcgc2FpZCwgSSBhbSBkZWZpbml0ZWx5IG5vdCB0aGUgbW9zdCBleHBl
cmllbmNlZCBwZXJzb24Kd2hlbiBpdCBjb21lcyB0byBBUEkgZGVzaWduLCBzbyB0aGVyZSBpcyBh
IGhpZ2ggY2hhbmNlIHRoYXQgSSBhbSB3YXkKb2ZmIDopCgpTbyB0byBzdW0gaXQgdXAsIEkgc2Vl
IHRocmVlIHBhdGhzIGZvcndhcmQ6CjEuIENvbmRpdGlvbiB3aXRoIGBraG9faXNfZW5hYmxlZCgp
YCBpbnN0ZWFkIG9mIHRoZSBDT05GSUcgKGFjY2VwdGluZwogICB0aGUgbWlub3IgY29sZCBib290
IG92ZXJoZWFkKQoyLiBQb3N0IGFub3RoZXIgcGF0Y2ggdGhhdCBleHRlbmRzIHRoZSBLSE8gQVBJ
LCBhZGRpbmcgYSB3cmFwcGVyIGZvcgogICB0aGUgYGtob19nZXRfZmR0KClgLCBsaWtlIGBpc19i
b290aW5nX3dpdGhfa2hvKClgIGluZGljYXRpbmcgdGhhdCB3ZQogICBhcmUgYm9vdGluZyB3aXRo
IEtITyBlbmFibGVkCjMuIFBvc3QgYW5vdGhlciBwYXRjaCB0aGF0IGV4cG9ydHMgdGhlIGBraG9f
Z2V0X2ZkdCgpYCBkaXJlY3RseS4KCkkgYW0gaGFwcHkgdG8gaW1wbGVtZW50IGFueSBvZiB0aGUg
dGhyZWUsIG9yIGFueSBvdGhlciBzdWdnZXN0aW9uIHlvdQptaWdodCBoYXZlLgoKPiA+ICsJCXN0
cnVjdCBtZW1ibG9ja19yZWdpb24gKnJlZzsKPiA+ICsJCXBoeXNfYWRkcl90IHN0YXJ0LCBzaXpl
Owo+ID4gKwkJaW50IGk7Cj4gPiArCj4gPiArCQkvKiBSZW1vdmUgYWxsIG5vbi1LSE8gcmVnaW9u
cyAqLwo+ID4gKwkJZm9yIChpID0gbWVtYmxvY2subWVtb3J5LmNudCAtIDE7IGkgPj0gMDsgaS0t
KSB7Cj4KPiBQbGVhc2UgdXNlIGZvcl9lYWNoX21lbV9yZWdpb24oKQo+CgpUb2RvIGluIFJldjIu
Cgo+ID4gKwkJCXJlZyA9ICZtZW1ibG9jay5tZW1vcnkucmVnaW9uc1tpXTsKPiA+ICsJCQlpZiAo
IW1lbWJsb2NrX2lzX2tob19zY3JhdGNoKHJlZykpIHsKPiA+ICsJCQkJc3RhcnQgPSByZWctPmJh
c2U7Cj4gPiArCQkJCXNpemUgPSByZWctPnNpemU7Cj4gPiArCQkJCW1lbWJsb2NrX3JlbW92ZShz
dGFydCwgc2l6ZSk7Cj4gPiArCQkJfQo+ID4gKwkJfQo+ID4gKwl9IGVsc2Ugewo+ID4gKwkvKgo+
ID4gKwkgKiBLSE8gaXMgZGlzYWJsZWQuIERpc2NhcmQgbWVtYmxvY2tzIGRpc2NvdmVyZWQgc28g
ZmFyOiBpZiB0aGVyZQo+ID4gKwkgKiBhcmUgYW55IGF0IHRoaXMgcG9pbnQsIHRoZXkgb3JpZ2lu
YXRlIGZyb20gbWVtb3J5IG5vZGVzIGluIHRoZQo+ID4gKwkgKiBEVCwgYW5kIFVFRkkgdXNlcyBp
dHMgb3duIG1lbW9yeSBtYXAgaW5zdGVhZC4KPiA+ICsJICovCj4gPiArCQltZW1ibG9ja19yZW1v
dmUoMCwgUEhZU19BRERSX01BWCk7Cj4gPiArCX0KPiA+Cj4gPiAgCWZvcl9lYWNoX2VmaV9tZW1v
cnlfZGVzYyhtZCkgewo+ID4gIAkJcGFkZHIgPSBtZC0+cGh5c19hZGRyOwo+ID4gLS0KPiA+IDIu
NDMuMAo+Cj4gLS0KPiBTaW5jZXJlbHkgeW91cnMsCj4gTWlrZS4KPgo+CgotLQpLaW5kIFJlZ2Fy
ZHMsCkV2YW5nZWxvcy4KCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNm
dWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4g
YW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJl
cmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


