Return-Path: <linux-efi+bounces-4692-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C213DB43C59
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FE5A55AD
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106D2F1FC7;
	Thu,  4 Sep 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="T/EFTQMc"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EA2FE074;
	Thu,  4 Sep 2025 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990775; cv=none; b=ZYVVm8p2+3soO7e52CwxNe+yDWTZNzMPzORGPngJ8SHRLkY6v50JbP2epfjPELAjtgIFIFVw5BEK1umGjgVGfIzV1FAwHTGw3MBEJtLrgvew5tApt14PyVcWPfFawECJO0eLrmIGJJn1BQUaUUxSaHdDamvYW3t/SNB7veOsRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990775; c=relaxed/simple;
	bh=r0FsS2N+qARjFVWMb2rj35Tf+GDOpHsxvfbAWYV1qnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtXzIHVtU0Roquhb1c7EmLGETUCG0Fv74OXa2GO2U1iS0K+LhLtd2QBjo+wW55l0k+crksCqU+8Rp/kGYBzRkiOj8QmNPrc6LII8tYkmm0KLEgDPEhUw02UjVsgKujiTZtsjMh87AOsBaPfsO2RoCq6++1ntnx/mKnnd3HZc7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=T/EFTQMc; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756990773; x=1788526773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r0FsS2N+qARjFVWMb2rj35Tf+GDOpHsxvfbAWYV1qnE=;
  b=T/EFTQMcYsTdfjVNydY5lEPdk0oLiv/zAggSvXaq2fpHwcP7MmWMRP20
   LX9jIET5zr59rUUFO+mFiOQACIswd2a//ENRRsgWAFMzC3OPII6Sccp08
   PczgQYkXC8siK4Me5IXTUju1L1zlZboCmx0TJvorOnhPgsuYbfsOL5+5b
   3zhYdJXASwoeAZKkHvYDKPp/yVxnJl492JGdFEK/yEGeQDsHUmm43J1Rd
   Q4HoBp4wpIeLx9RYUlvs5mGpaSsgFQsd/d+7gAl6vwjTL8X9UHP6Of8R3
   Ss4fLFNvtkvdO3kENmKpSfOcvLpDrL7lVU1bSnPa+Lq/S94wRicBkCm3o
   w==;
X-CSE-ConnectionGUID: w5o3pcZJSEWmO4VpbH1cjA==
X-CSE-MsgGUID: PqxWyFFzTeG4hSB2zHWP3w==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2394356"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:59:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:41673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.106:2525] with esmtp (Farcaster)
 id 9fc4525f-54d7-4afe-a1fd-c13054ca4bc1; Thu, 4 Sep 2025 12:59:30 +0000 (UTC)
X-Farcaster-Flow-ID: 9fc4525f-54d7-4afe-a1fd-c13054ca4bc1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 12:59:30 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 4 Sep 2025
 12:59:28 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <ardb@kernel.org>
CC: <akpm@linux-foundation.org>, <bhe@redhat.com>, <changyuanl@google.com>,
	<epetron@amazon.de>, <graf@amazon.com>, <ilias.apalodimas@linaro.org>,
	<kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>, <rppt@kernel.org>
Subject: Re: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
Date: Thu, 4 Sep 2025 12:57:51 +0000
Message-ID: <20250904125917.78112-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de> <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com> <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com> <20250904093455.73184-1-epetron@amazon.de> <CAMj1kXHTJxBMFX6J-QwcPRojLGMQsTNOH5Bz9kHk7CFdt1JApw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCA0IFNlcCAyMDI1IDExOjM5OjAyICswMjAwLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiBPbiBUaHUsIDQgU2VwdCAyMDI1IGF0IDExOjM2LCBFdmFuZ2Vs
b3MgUGV0cm9uZ29uYXMgPGVwZXRyb25AYW1hem9uLmRlPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUs
IDQgU2VwIDIwMjUgMDk6MTk6MjEgKzAyMDAsIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4gPiBPbiBTYXQsIDIzIEF1ZyAyMDI1IGF0IDIzOjQ3LCBBcmQgQmllc2hl
dXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IChjYyBJbGlhcykK
PiA+ID4gPgo+ID4gPiA+IE5vdGUgdG8gYWtwbTogcGxlYXNlIGRyb3AgdGhpcyBzZXJpZXMgZm9y
IG5vdy4KPiA+ID4gPgo+ID4gPiA+IE9uIEZyaSwgMjIgQXVnIDIwMjUgYXQgMDQ6MDAsIEV2YW5n
ZWxvcyBQZXRyb25nb25hcyA8ZXBldHJvbkBhbWF6b24uZGU+IHdyb3RlOgo+ID4gPiA+ID4KPiA+
ID4gPiA+IFdoZW4gS0hPIChLZXhlYyBIYW5kT3ZlcikgaXMgZW5hYmxlZCwgaXQgc2V0cyB1cCBz
Y3JhdGNoIG1lbW9yeSByZWdpb25zCj4gPiA+ID4gPiBlYXJseSBkdXJpbmcgZGV2aWNlIHRyZWUg
c2Nhbm5pbmcuIEFmdGVyIGtleGVjLCB0aGUgbmV3IGtlcm5lbAo+ID4gPiA+ID4gZXhjbHVzaXZl
bHkgdXNlcyB0aGlzIHJlZ2lvbiBmb3IgbWVtb3J5IGFsbG9jYXRpb25zIGR1cmluZyBib290IHVw
IHRvCj4gPiA+ID4gPiB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIHBhZ2UgYWxsb2NhdG9yCj4g
PiA+ID4gPgo+ID4gPiA+ID4gSG93ZXZlciwgd2hlbiBib290aW5nIHdpdGggRUZJLCBFRkkncyBy
ZXNlcnZlX3JlZ2lvbnMoKSB1c2VzCj4gPiA+ID4gPiBtZW1ibG9ja19yZW1vdmUoMCwgUEhZU19B
RERSX01BWCkgdG8gY2xlYXIgYWxsIG1lbW9yeSByZWdpb25zIGJlZm9yZQo+ID4gPiA+ID4gcmVi
dWlsZGluZyB0aGVtIGZyb20gRUZJIGRhdGEuIFRoaXMgZGVzdHJveXMgS0hPIHNjcmF0Y2ggcmVn
aW9ucyBhbmQKPiA+ID4gPiA+IHRoZWlyIGZsYWdzLCB0aHVzIGNhdXNpbmcgYSBrZXJuZWwgcGFu
aWMsIGFzIHRoZXJlIGFyZSBubyBzY3JhdGNoCj4gPiA+ID4gPiBtZW1vcnkgcmVnaW9ucy4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBJbnN0ZWFkIG9mIHdob2xlc2FsZSByZW1vdmFsLCBpdGVyYXRlIHRo
cm91Z2ggbWVtb3J5IHJlZ2lvbnMgYW5kIG9ubHkKPiA+ID4gPiA+IHJlbW92ZSBub24tS0hPIG9u
ZXMuIFRoaXMgcHJlc2VydmVzIEtITyBzY3JhdGNoIHJlZ2lvbnMsIHdoaWNoIGFyZQo+ID4gPiA+
ID4gZ29vZCBrbm93biBtZW1vcnksIHdoaWxlIHN0aWxsIGFsbG93aW5nIEVGSSB0byByZWJ1aWxk
IGl0cyBtZW1vcnkgbWFwLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFja2VkLWJ5OiBNaWtlIFJhcG9w
b3J0IChNaWNyb3NvZnQpIDxycHB0QGtlcm5lbC5vcmc+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBFdmFuZ2Vsb3MgUGV0cm9uZ29uYXMgPGVwZXRyb25AYW1hem9uLmRlPgo+ID4gPiA+ID4gLS0t
Cj4gPiA+ID4gPiBDaGFuZ2VzIGluIHYzOgo+ID4gPiA+ID4gICAgICAgICAtIEltcHJvdmUgdGhl
IGNvZGUgY29tbWVudHMsIGJ5IHN0YXRpbmcgdGhhdCB0aGUgc2NyYXRjaCByZWdpb25zIGFyZQo+
ID4gPiA+ID4gICAgICAgICBnb29kIGtub3duIG1lbW9yeQo+ID4gPiA+ID4KPiA+ID4gPiA+IENo
YW5nZXMgaW4gdjI6Cj4gPiA+ID4gPiAgICAgICAgIC0gUmVwbGFjZSB0aGUgZm9yIGxvb3Agd2l0
aCBmb3JfZWFjaF9tZW1fcmVnaW9uCj4gPiA+ID4gPiAgICAgICAgIC0gRml4IGNvbW1lbnQgaW5k
ZW50YXRpb24KPiA+ID4gPiA+ICAgICAgICAgLSBBbWVuZCBjb21taXQgbWVzc2FnZSB0byBzcGVj
aWZ5IHRoYXQgc2NyYXRjaCByZWdpb25zCj4gPiA+ID4gPiAgICAgICAgIGFyZSBrbm93biBnb29k
IHJlZ2lvbnMKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLWlu
aXQuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gSSdkIHJhdGhlciBkcm9wIHRoZSBtZW1ibG9ja19yZW1vdmUoKSBlbnRpcmVs
eSBpZiBwb3NzaWJsZS4gQ291bGQgd2UKPiA+ID4gPiBnZXQgc29tZSBpbnNpZ2h0IGludG8gd2hl
dGhlciBtZW1ibG9ja3MgYXJlIGdlbmVyYWxseSBhbHJlYWR5Cj4gPiA+ID4gcG9wdWxhdGVkIGF0
IHRoaXMgcG9pbnQgZHVyaW5nIHRoZSBib290Pwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+ID4g
UGluZz8KPiA+Cj4gPiBIZXkgQXJkIEkgd2FzIEFGSyB0cmF2ZWxsaW5nLiBJIGFtIGJhY2sgbm93
IGFuZCB3aWxsIGdldCB0byBpdC4KPiA+IFBTOiBLZWVuIHRvIG1lZXQgeW91IGxhdGVyIHRvZGF5
IGluIHRoZSBLVk0gRm9ydW0uCj4gPgo+IAo+IFllcywgbGV0J3MgY2F0Y2ggdXAhCj4gCj4gCgpJ
IGRpZCBzb21lIHRlc3Rpbmcgb24gcWVtdSB3aXRoIG1lbWJsb2NrIGFuZCBFRkkgZGVidWcgZW5h
YmxlZAoKKGBtZW1ibG9jaz1kZWJ1ZyBlZmk9ZGVidWdgKSBhbmQgbm8gS0hPLgpXZSBzZWUgdGhh
dCBgbWVtYmxvY2tfZHVtcF9hbGwoKWAgaW4gYHJlc2VydmVfcmVnaW9ucygpYCBvdXRwdXRzOgpg
YGAKWyAgICAwLjAwMDAwMF0gTUVNQkxPQ0sgY29uZmlndXJhdGlvbjoKWyAgICAwLjAwMDAwMF0g
IG1lbW9yeSBzaXplID0gMHgwMDAwMDAwMjAwMDAwMDAwIHJlc2VydmVkIHNpemUgPSAweDAwMDAw
MDAwMGRiNTM4M2UKWyAgICAwLjAwMDAwMF0gIG1lbW9yeS5jbnQgID0gMHg3ClsgICAgMC4wMDAw
MDBdICBtZW1vcnlbMHgwXQlbMHgwMDAwMDAwMDQwMDAwMDAwLTB4MDAwMDAwMDIzYzc2ZmZmZl0s
IDB4MDAwMDAwMDFmYzc3MDAwMCBieXRlcyBvbiBub2RlIDAgZmxhZ3M6IDB4MAouLi4KWyAgICAw
LjAwMDAwMF0gIHJlc2VydmVkLmNudCAgPSAweGYKWyAgICAwLjAwMDAwMF0gIHJlc2VydmVkWzB4
MF0JWzB4MDAwMDAwMDBmZTAwMDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdLCAweDAwMDAwMDAwMDIw
MDAwMDAgYnl0ZXMgZmxhZ3M6IDB4MjAKYGBgCgpNb3Jlb3ZlciBjaGVja2luZyB0aGUgY29kZSwg
dGhlIGJvb3QgZmxvdyAgKGF0IGxlYXN0IG9uIGFybTY0KQpwb3B1bGF0ZXMgbWVtYmxvY2tzIGZy
b20gRFQgbWVtb3J5IG5vZGVzIHZpYQpgZWFybHlfaW5pdF9kdF9hZGRfbWVtb3J5X2FyY2goKWAg
YmVmb3JlIGBlZmlfaW5pdCgpYCBpcyBjYWxsZWQKCmBzZXR1cF9hcmNoKClgIC0+IGBzZXR1cF9t
YWNoaW5lX2ZkdCgpYCAtPiBgZWFybHlfaW5pdF9kdF9zY2FuKClgIC0+CmBlYXJseV9pbml0X2R0
X3NjYW5fbWVtb3J5KClgIC0+IGBlYXJseV9pbml0X2R0X2FkZF9tZW1vcnlfYXJjaCgpYCAtPgpg
bWVtYmxvY2tfYWRkKClgCgpBcyBhIHJlc3VsdCwgaXQgc2VlbXMgdGhhdCBtZW1ibG9ja3MgQVJF
IHBvcHVsYXRlZCB3aGVuIGNhbGxpbmcgdGhlCmByZXNlcnZlX3JlZ2lvbnMoKWAuIFNvIGxvb2tz
IGxpa2UgIHdlIHN0aWxsIG5lZWQgdGhlCmBtZW1ibG9ja19yZW1vdmUoKWAgKD8pCgoKCgoKQW1h
em9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1E
YW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1
MzggNTk3Cg==


