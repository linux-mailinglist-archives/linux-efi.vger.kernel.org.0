Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DF161EA8
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 02:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgBRBxs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 20:53:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38621 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgBRBxs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 20:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581990827; x=1613526827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3ilPBxarkdRZS+xpy06f2LvRB6yOgGg9vzFzqe3oA6k=;
  b=mMaSMLnOrCzgBHmWF4kbZNbTvolssYJrpUSZB4DnbyzKi+d353LenxYr
   BiORGGWqMb5qGQE3tKLCAqicrieugWGZas7OJhaMnpB+0+UPcoA19KXnJ
   +cmdko3rPPJ+BOYHTaZmRprxC+GUdh0alhGAdB+1zfd3e7lI2xQl6vHiM
   hzQQXyBhsXeiJMhKnPLgO5kdfTOmq2h3BpkeDyAN4XequLLeL8y8Vh/OQ
   F5B0h56R/6bti0rM1xqaYs+F1JjzsA1LAXRu7ash/DJkq9+FlPbb1wi4Z
   F63fbY1xNsCyYnlDjp4u6i/2xbDS+nSKt6hMsjnrxESiY2XJd+awKiGts
   Q==;
IronPort-SDR: dbSIuzd3PbXwg/tIFLEYWm9jy316UgVVpduD8OccmRGfdgOLq6CnHQnaw4G/157x4g2K8bWIOs
 BbSAwudP42q1IH8PnWaWfrxjoeUQidxo8+MGqH342+z1MNQKoXpCQoHE/rL1+nqY4AVTaDMzz9
 CQYyr6x9pYPMIGPVx15NaHtlnfUZiwnNdF94u0p0m434VnzbVyu2opW1wxMcrMk7SduBtlROJy
 jm3GYJQEyouCMjrD0HLOunOmXJoMWIMNSS0byPQQLeIFtCwKKE1hbiAS3E0K+8kBXqKRdkAdza
 nqo=
X-IronPort-AV: E=Sophos;i="5.70,454,1574092800"; 
   d="scan'208";a="130580175"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2020 09:53:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU4virh3tMkClQk+NSx5WarCqy8W2vqHR18BCJrE0x/IlWe1GzGyMgmW+lMyWpXqXZjzvOvIz6TTYwZ6KkWwoBVtjHz1xogtHPVh1yCvzgtBlm1CBAhlHRTgvRxk1xPWHya1k0A2pHJ/mb82jLgEbRaHVRaVfADgz4wncuVp9/P35pvQhgABGUIS7w7Awu4Up3XZGp76FHN9pKC3EYo2VWc4d5chwgRQ4WU5i4WufIEitDipsfqPdYUB4QbA6yHV/t1ryRBW8GOB00mhZP/fFLqhZQAP1OfgWsDBPRz8AIBXL+RSkeT40BEihuDXxjF0vbJl0Pf2/MK2klFgLLO7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ilPBxarkdRZS+xpy06f2LvRB6yOgGg9vzFzqe3oA6k=;
 b=K4A1MTNgc+Va3mUcVDOKFl6FwsM+iavXkX5b1H67CpjlTFWa81Ow6/v7uKbG9xL9eGQI3JXPPeqYPUuTWin8J4S0ExJEEbVa3+hjo8UlCIcd+9/r/jjRAScHSwEF8utSKSTsv/jl19wh4Aj5Jqfhrg4ykcbg9uEwxCgvDptgk9068v4ie3B3NpcypeZjaqtfsWB+tjcUlcBB1Bq/trUxSm+trV48n8ABhcNjd4YQUDr0XnSbS4WKXBpN2MbU6uH/x9iu8JjpH7ASCB3n4avs1FnY5jKwjgMphPZMFTOy9IyZ0TzPiYvAVQrm1AkxpUnLWiGGWvqNNyZQo2CcyuSKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ilPBxarkdRZS+xpy06f2LvRB6yOgGg9vzFzqe3oA6k=;
 b=EeD0uXXHmjEGcrBUdy/qLK3ff3pVzXLNmOEoI5tIyDCkTxsv77htr2aIDQ66oOcekOHUeJowohEBvYyfuzW7YgRhEq7i8+w4WQKhfO62hQfQQzf1jDrDmp1twxSm/h65JXjXRskH68shniGvMIqczBxcw3K3xrE4EFK4NkR2Tqo=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4853.namprd04.prod.outlook.com (52.135.235.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 01:53:44 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::fd01:e357:2522:2221]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::fd01:e357:2522:2221%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 01:53:44 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>
Subject: Re: [PATCH] efi/libstub/arm: make efi_entry() an ordinary PE/COFF
 entrypoint
Thread-Topic: [PATCH] efi/libstub/arm: make efi_entry() an ordinary PE/COFF
 entrypoint
Thread-Index: AQHV5ZCyT990BUjgH0GuT2aCM/PwsqggMV2A
Date:   Tue, 18 Feb 2020 01:53:44 +0000
Message-ID: <bf031d41c75a1834820332d7973fda132a6fceb5.camel@wdc.com>
References: <20200217124904.16331-1-ardb@kernel.org>
In-Reply-To: <20200217124904.16331-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9d37f32-44dd-498d-dfbc-08d7b4156329
x-ms-traffictypediagnostic: BYAPR04MB4853:
x-microsoft-antispam-prvs: <BYAPR04MB48531693560CAC2E61106EAFFA110@BYAPR04MB4853.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(66556008)(64756008)(8936002)(76116006)(81156014)(71200400001)(66946007)(2616005)(81166006)(66446008)(26005)(2906002)(8676002)(36756003)(4326008)(66476007)(6512007)(478600001)(54906003)(86362001)(6486002)(110136005)(30864003)(186003)(316002)(6506007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4853;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DPZR+VHlxSfdpDwpZk4R1J8MyFshDFkr4gb9uMEsoOkHvTkvvwknNroqCKjjhLRd2tHtEJo9BVwsydOl+iH0LywCRw/6PA3W2XRcg5mcU7YjpLv032Snxk8wvIOrGSpRADbwX4a6UQeQ/tDNzVrGqd7V6cfAPbYPeXOgPRV8igjXPvMdkYfmuty04j40dzxxM8gjXSEMoIgpURxy1sLpRpdmZspkU+61BObRFwLzsBh85bZq1UbAwCVU92lPsdldN/fmbXoZMO9uuAnjNAKcJWv5BLjp2d2C5KhY6VPTt0ZXpHc50fUOMOsm3O0f0qbKLPWyxmxlppjczRJLJw//vujN9x03B8cs7U9h1i0TaWoUjjCnUGvnqdOGwfLtBkqEc/HqhwQycwTjnoyOC/znVYupBdufrjfM0yPhqJbUAnEytiEfPmpjJCeaKWU3p9wo
x-ms-exchange-antispam-messagedata: 2ACLGfZ8Y6f+mrJJoEFd2mENWNvYIb25R+/CH+mv9FQMDEBK6NraPK/tGj5tmd+bY+NT/72Dk/TH1lBiN3E6CRbK0dp0t6KJpLPt/LI+uWCbQSbo7qXN1iByjIiUOkb1NSvsO6726Jkaky5te6oHKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <027D8D9E19EA824D9EEE334FA74A0012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d37f32-44dd-498d-dfbc-08d7b4156329
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 01:53:44.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6axfDtV07cqBCFD6FENDLBucGtNccT2OQJ9ayFFkKhKMFeMEr+UiDMMdtGAMSV4hj5Ino5fId/hb4T9chck5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4853
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTE3IGF0IDEzOjQ5ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gRXhwb3NlIGVmaV9lbnRyeSgpIGFzIHRoZSBQRS9DT0ZGIGVudHJ5cG9pbnQgZGlyZWN0bHks
IGluc3RlYWQgb2YNCj4ganVtcGluZyBpbnRvIGEgd3JhcHBlciB0aGF0IGZpZGRsZXMgd2l0aCBz
dGFjayBidWZmZXJzIGFuZCBvdGhlcg0KPiBzdHVmZiB0aGF0IHRoZSBjb21waWxlciBpcyBtdWNo
IGJldHRlciBhdC4gVGhlIG9ubHkgcmVhc29uIHRoaXMNCj4gY29kZSBleGlzdHMgaXMgdG8gb2J0
YWluIGEgcG9pbnRlciB0byB0aGUgYmFzZSBvZiB0aGUgaW1hZ2UsIGJ1dA0KPiB3ZSBjYW4gZ2V0
IHRoZSBzYW1lIHZhbHVlIGZyb20gdGhlIGxvYWRlZF9pbWFnZSBwcm90b2NvbCwgd2hpY2gNCj4g
d2UgYWxyZWFkeSBuZWVkIGZvciBvdGhlciByZWFzb25zIGFueXdheS4NCj4gDQo+IFVwZGF0ZSB0
aGUgcmV0dXJuIHR5cGUgYXMgd2VsbCwgdG8gbWFrZSBpdCBjb25zaXN0ZW50IHdpdGggd2hhdA0K
PiBpcyByZXF1aXJlZCBmb3IgYSBQRS9DT0ZGIGV4ZWN1dGFibGUgZW50cnlwb2ludC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IC0tLQ0K
PiBBcG9sb2dpZXMgdG8gQXRpc2ggZm9yIG1ha2luZyBoaW0gdHJhY2sgYSBtb3ZpbmcgdGFyZ2V0
LCBidXQgdGhpcyBpcw0KPiBhbm90aGVyDQo+IGJpdCBvZiBjbGVhbnVwIHdvcmsgdGhhdCBJIHdv
dWxkIGxpa2UgdG8gbWVyZ2UgYmVmb3JlIHRha2luZyB0aGUNCj4gUklTQy1WDQo+IGNoYW5nZXMg
b24gdG9wLg0KPiANCg0KQW5kIEkgdGhvdWdodCBJIGFtIGRvbmUgcmViYXNpbmcgbXkgcGF0Y2hl
cyA7KS4gSm9rZXMgYXBhcnQsIHRoaXMgaXMNCmFjdHVhbGx5IG11Y2ggY2xlYW5lciBhcHByb2Fj
aCBpbiByZXRyaWV2aW5nIGltYWdlIGJhc2UgYW5kIHBhcnNpbmcgRFQNCmNvbXBhcmVkIHRvIHdo
YXQgSSBjdXJyZW50bHkgaGF2ZSBmb3IgUklTQy1WLg0KDQoNCj4gT24gUklTQy1WLCBJIHdvdWxk
IGV4cGVjdCBlZmlfZW50ZXJfa2VybmVsKCkgdG8gYmUgaW1wbGVtZW50ZWQgYXMgYSBDDQo+IHJv
dXRpbmUNCj4gdGhhdCBmaW5kcyB0aGUgaGFydCBpZCBpbiB0aGUgRFQgKHdoaWNoIGlzIHBhc3Nl
ZCBhcyBhbiBhcmd1bWVudCksDQo+IGFuZCBwYXNzDQo+IGl0IHRvIHRoZSBzdGFydHVwIGNvZGUg
b2YgdGhlIGtlcm5lbCBwcm9wZXIuDQo+IA0KDQpZZXMuIEkgcHJvYmFibHkgd29uJ3QgbmVlZCBl
ZmktZW50cnkuUyBmb3IgUklTQy1WIGF0IGFsbCB3aGljaA0Kc2ltcGxpZmllcyB0aGUgUklTQy1W
IGltcGxlbWVudGF0aW9uLiBZYXkhISANCg0KSXMgdGhlcmUgYSB0cmVlIHdpdGggdGhpcyBwYXRj
aCA/IEkgdHJpZWQgdG8gZmluZCBpdCBpbiB5b3VyIGtlcm5lbC5vcmcNCnJlcG8gYnV0IGNvdWxk
bid0IGZpbmQgaXQuIEFzIHRoZXJlIGFyZSAzIGVmaSByZWxhdGVkIHBhdGNoIHNldCBpbg0KZmxp
Z2h0LCBJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBvcmRlciBpbiB3aGljaCB0aGV5IHNob3VsZCBi
ZSBhcHBsaWVkLg0KDQoNCj4gIGFyY2gvYXJtL2Jvb3QvY29tcHJlc3NlZC9lZmktaGVhZGVyLlMg
ICAgIHwgIDIgKy0NCj4gIGFyY2gvYXJtL2Jvb3QvY29tcHJlc3NlZC9oZWFkLlMgICAgICAgICAg
IHwgNDQgKysrLS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtNjQva2VybmVsL2VmaS1lbnRyeS5TICAg
ICAgICAgICAgIHwgNjQgKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtNjQva2VybmVs
L2VmaS1oZWFkZXIuUyAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZp
L2xpYnN0dWIvYXJtLXN0dWIuYyAgIHwgMzcgKysrKystLS0tLS0NCj4gIGRyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvYXJtMzItc3R1Yi5jIHwgIDEgKw0KPiAgZHJpdmVycy9maXJtd2FyZS9l
ZmkvbGlic3R1Yi9hcm02NC1zdHViLmMgfCAgMyArLQ0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspLCAxMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9jb21wcmVzc2VkL2VmaS1oZWFkZXIuUw0KPiBiL2FyY2gvYXJtL2Jvb3QvY29tcHJl
c3NlZC9lZmktaGVhZGVyLlMNCj4gaW5kZXggYTU5ODM1ODhmOTZiLi5lMzhmYmRhMDJiOTMgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvY29tcHJlc3NlZC9lZmktaGVhZGVyLlMNCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL2VmaS1oZWFkZXIuUw0KPiBAQCAtNjAsNyArNjAs
NyBAQCBvcHRpb25hbF9oZWFkZXI6DQo+ICAJCS5sb25nCV9fcGVjb2ZmX2NvZGVfc2l6ZQkJQCBT
aXplT2ZDb2RlDQo+ICAJCS5sb25nCV9fcGVjb2ZmX2RhdGFfc2l6ZQkJQA0KPiBTaXplT2ZJbml0
aWFsaXplZERhdGENCj4gIAkJLmxvbmcJMAkJCQlADQo+IFNpemVPZlVuaW5pdGlhbGl6ZWREYXRh
DQo+IC0JCS5sb25nCWVmaV9zdHViX2VudHJ5IC0gc3RhcnQJCUANCj4gQWRkcmVzc09mRW50cnlQ
b2ludA0KPiArCQkubG9uZwllZmlfZW50cnkgLSBzdGFydAkJQA0KPiBBZGRyZXNzT2ZFbnRyeVBv
aW50DQo+ICAJCS5sb25nCXN0YXJ0X29mZnNldAkJCUAgQmFzZU9mQ29kZQ0KPiAgCQkubG9uZwlf
X3BlY29mZl9kYXRhX3N0YXJ0IC0gc3RhcnQJQCBCYXNlT2ZEYXRhDQo+ICANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvY29tcHJlc3NlZC9oZWFkLlMNCj4gYi9hcmNoL2FybS9ib290L2Nv
bXByZXNzZWQvaGVhZC5TDQo+IGluZGV4IDA4OGIwYTA2MDg3Ni4uOTQxY2QyOGExM2MzIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2NvbXByZXNzZWQvaGVhZC5TDQo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvY29tcHJlc3NlZC9oZWFkLlMNCj4gQEAgLTE0MzcsNTAgKzE0MzcsMjIgQEAgX19l
bnRlcl9rZXJuZWw6DQo+ICByZWxvY19jb2RlX2VuZDoNCj4gIA0KPiAgI2lmZGVmIENPTkZJR19F
RklfU1RVQg0KPiAtCQkuYWxpZ24JMg0KPiAtX3N0YXJ0OgkJLmxvbmcJc3RhcnQgLSAuDQo+IC0N
Cj4gLUVOVFJZKGVmaV9zdHViX2VudHJ5KQ0KPiAtCQlAIGFsbG9jYXRlIHNwYWNlIG9uIHN0YWNr
IGZvciBwYXNzaW5nIGN1cnJlbnQgekltYWdlDQo+IGFkZHJlc3MNCj4gLQkJQCBhbmQgZm9yIHRo
ZSBFRkkgc3R1YiB0byByZXR1cm4gb2YgbmV3IGVudHJ5IHBvaW50IG9mDQo+IC0JCUAgekltYWdl
LCBhcyBFRkkgc3R1YiBtYXkgY29weSB0aGUga2VybmVsLiBQb2ludGVyDQo+IGFkZHJlc3MNCj4g
LQkJQCBpcyBwYXNzZWQgaW4gcjIuIHIwIGFuZCByMSBhcmUgcGFzc2VkIHRocm91Z2ggZnJvbQ0K
PiB0aGUNCj4gLQkJQCBFRkkgZmlybXdhcmUgdG8gZWZpX2VudHJ5DQo+IC0JCWFkcglpcCwgX3N0
YXJ0DQo+IC0JCWxkcglyMywgW2lwXQ0KPiAtCQlhZGQJcjMsIHIzLCBpcA0KPiAtCQlzdG1mZAlz
cCEsIHtyMywgbHJ9DQo+IC0JCW1vdglyMiwgc3AJCQlAIHBhc3MgekltYWdlIGFkZHJlc3MNCj4g
aW4gcjINCj4gLQkJYmwJZWZpX2VudHJ5DQo+IC0NCj4gLQkJQCBDaGVjayBmb3IgZXJyb3IgcmV0
dXJuIGZyb20gRUZJIHN0dWIuIHIwIGhhcyBGRFQNCj4gYWRkcmVzcw0KPiAtCQlAIG9yIGVycm9y
IGNvZGUuDQo+IC0JCWNtbglyMCwgIzENCj4gLQkJYmVxCWVmaV9sb2FkX2ZhaWwNCj4gLQ0KPiAt
CQlAIFByZXNlcnZlIHJldHVybiB2YWx1ZSBvZiBlZmlfZW50cnkoKSBpbiByNA0KPiAtCQltb3YJ
cjQsIHIwDQo+ICtFTlRSWShlZmlfZW50ZXJfa2VybmVsKQ0KPiArCQltb3YJcjQsIHIwCQkJQCBw
cmVzZXJ2ZSBlbnRyeXBvaW50DQo+ICsJCW1vdglyNSwgcjEJCQlAIHByZXNlcnZlIERUIHBvaW50
ZXINCj4gIAkJYmwJY2FjaGVfY2xlYW5fZmx1c2gNCj4gIAkJYmwJY2FjaGVfb2ZmDQo+ICANCj4g
IAkJQCBTZXQgcGFyYW1ldGVycyBmb3IgYm9vdGluZyB6SW1hZ2UgYWNjb3JkaW5nIHRvIGJvb3QN
Cj4gcHJvdG9jb2wNCj4gLQkJQCBwdXQgRkRUIGFkZHJlc3MgaW4gcjIsIGl0IHdhcyByZXR1cm5l
ZCBieSBlZmlfZW50cnkoKQ0KPiAtCQlAIHIxIGlzIHRoZSBtYWNoaW5lIHR5cGUsIGFuZCByMCBu
ZWVkcyB0byBiZSAwDQo+ICAJCW1vdglyMCwgIzANCj4gIAkJbW92CXIxLCAjMHhGRkZGRkZGRg0K
PiAtCQltb3YJcjIsIHI0DQo+ICsJCW1vdglyMiwgcjUNCj4gIA0KPiAtCQlAIEJyYW5jaCB0byAo
cG9zc2libHkpIHJlbG9jYXRlZCB6SW1hZ2UgdGhhdCBpcyBpbiBbc3BdDQo+IC0JCWxkcglsciwg
W3NwXQ0KPiArCQlAIEJyYW5jaCB0byAocG9zc2libHkpIHJlbG9jYXRlZCB6SW1hZ2UgQCBbcjRd
DQo+ICAJCWxkcglpcCwgPXN0YXJ0X29mZnNldA0KPiAtCQlhZGQJbHIsIGxyLCBpcA0KPiAtCQlt
b3YJcGMsIGxyCQkJCUAgbm8gbW9kZQ0KPiBzd2l0Y2gNCj4gLQ0KPiAtZWZpX2xvYWRfZmFpbDoN
Cj4gLQkJQCBSZXR1cm4gRUZJX0xPQURfRVJST1IgdG8gRUZJIGZpcm13YXJlIG9uIGVycm9yLg0K
PiAtCQlsZHIJcjAsID0weDgwMDAwMDAxDQo+IC0JCWxkbWZkCXNwISwge2lwLCBwY30NCj4gLUVO
RFBST0MoZWZpX3N0dWJfZW50cnkpDQo+ICsJCWFkZAlyNCwgcjQsIGlwDQo+ICsJCW1vdglwYywg
cjQJCQlAIG5vIG1vZGUgc3dpdGNoDQo+ICtFTkRQUk9DKGVmaV9lbnRlcl9rZXJuZWwpDQo+ICAj
ZW5kaWYNCj4gIA0KPiAgCQkuYWxpZ24NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVs
L2VmaS1lbnRyeS5TIGIvYXJjaC9hcm02NC9rZXJuZWwvZWZpLQ0KPiBlbnRyeS5TDQo+IGluZGV4
IDMwNGQ1YjAyY2E2Ny4uNDllM2IxYWQxYjM2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2tl
cm5lbC9lZmktZW50cnkuUw0KPiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9lZmktZW50cnkuUw0K
PiBAQCAtMTAsNTUgKzEwLDE4IEBADQo+ICANCj4gICNpbmNsdWRlIDxhc20vYXNzZW1ibGVyLmg+
DQo+ICANCj4gLSNkZWZpbmUgRUZJX0xPQURfRVJST1IgMHg4MDAwMDAwMDAwMDAwMDAxDQo+IC0N
Cj4gIAlfX0lOSVQNCj4gIA0KPiAtCS8qDQo+IC0JICogV2UgYXJyaXZlIGhlcmUgZnJvbSB0aGUg
RUZJIGJvb3QgbWFuYWdlciB3aXRoOg0KPiAtCSAqDQo+IC0JICogICAgKiBDUFUgaW4gbGl0dGxl
LWVuZGlhbiBtb2RlDQo+IC0JICogICAgKiBNTVUgb24gd2l0aCBpZGVudGl0eS1tYXBwZWQgUkFN
DQo+IC0JICogICAgKiBJY2FjaGUgYW5kIERjYWNoZSBvbg0KPiAtCSAqDQo+IC0JICogV2Ugd2ls
bCBtb3N0IGxpa2VseSBiZSBydW5uaW5nIGZyb20gc29tZSBwbGFjZSBvdGhlciB0aGFuDQo+IHdo
ZXJlDQo+IC0JICogd2Ugd2FudCB0byBiZS4gVGhlIGtlcm5lbCBpbWFnZSB3YW50cyB0byBiZSBw
bGFjZWQgYXQNCj4gVEVYVF9PRkZTRVQNCj4gLQkgKiBmcm9tIHN0YXJ0IG9mIFJBTS4NCj4gLQkg
Ki8NCj4gLUVOVFJZKGVudHJ5KQ0KPiAtCS8qDQo+IC0JICogQ3JlYXRlIGEgc3RhY2sgZnJhbWUg
dG8gc2F2ZSBGUC9MUiB3aXRoIGV4dHJhIHNwYWNlDQo+IC0JICogZm9yIGltYWdlX2FkZHIgdmFy
aWFibGUgcGFzc2VkIHRvIGVmaV9lbnRyeSgpLg0KPiAtCSAqLw0KPiAtCXN0cAl4MjksIHgzMCwg
W3NwLCAjLTMyXSENCj4gLQltb3YJeDI5LCBzcA0KPiAtDQo+IC0JLyoNCj4gLQkgKiBDYWxsIGVm
aV9lbnRyeSB0byBkbyB0aGUgcmVhbCB3b3JrLg0KPiAtCSAqIHgwIGFuZCB4MSBhcmUgYWxyZWFk
eSBzZXQgdXAgYnkgZmlybXdhcmUuIEN1cnJlbnQgcnVudGltZQ0KPiAtCSAqIGFkZHJlc3Mgb2Yg
aW1hZ2UgaXMgY2FsY3VsYXRlZCBhbmQgcGFzc2VkIHZpYSAqaW1hZ2VfYWRkci4NCj4gLQkgKg0K
PiAtCSAqIHVuc2lnbmVkIGxvbmcgZWZpX2VudHJ5KHZvaWQgKmhhbmRsZSwNCj4gLQkgKiAgICAg
ICAgICAgICAgICAgICAgICAgICBlZmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJsZSwNCj4gLQkg
KiAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICppbWFnZV9hZGRyKSA7DQo+
IC0JICovDQo+IC0JYWRyX2wJeDgsIF90ZXh0DQo+IC0JYWRkCXgyLCBzcCwgMTYNCj4gLQlzdHIJ
eDgsIFt4Ml0NCj4gLQlibAllZmlfZW50cnkNCj4gLQljbW4JeDAsICMxDQo+IC0JYi5lcQllZmlf
bG9hZF9mYWlsDQo+IC0NCj4gK0VOVFJZKGVmaV9lbnRlcl9rZXJuZWwpDQo+ICAJLyoNCj4gIAkg
KiBlZmlfZW50cnkoKSB3aWxsIGhhdmUgY29waWVkIHRoZSBrZXJuZWwgaW1hZ2UgaWYgbmVjZXNz
YXJ5DQo+IGFuZCB3ZQ0KPiAtCSAqIHJldHVybiBoZXJlIHdpdGggZGV2aWNlIHRyZWUgYWRkcmVz
cyBpbiB4MCBhbmQgdGhlIGtlcm5lbA0KPiBlbnRyeQ0KPiAtCSAqIHBvaW50IHN0b3JlZCBhdCAq
aW1hZ2VfYWRkci4gU2F2ZSB0aG9zZSB2YWx1ZXMgaW4gcmVnaXN0ZXJzDQo+IHdoaWNoDQo+IC0J
ICogYXJlIGNhbGxlZSBwcmVzZXJ2ZWQuDQo+ICsJICogZW5kIHVwIGhlcmUgd2l0aCBkZXZpY2Ug
dHJlZSBhZGRyZXNzIGluIHgxIGFuZCB0aGUga2VybmVsDQo+IGVudHJ5DQo+ICsJICogcG9pbnQg
c3RvcmVkIGluIHgwLiBTYXZlIHRob3NlIHZhbHVlcyBpbiByZWdpc3RlcnMgd2hpY2ggYXJlDQo+
ICsJICogY2FsbGVlIHByZXNlcnZlZC4NCj4gIAkgKi8NCj4gLQltb3YJeDIwLCB4MAkJLy8gRFRC
IGFkZHJlc3MNCj4gLQlsZHIJeDAsIFtzcCwgIzE2XQkvLyByZWxvY2F0ZWQgX3RleHQgYWRkcmVz
cw0KPiArCW1vdgl4MjAsIHgxCQkJLy8gRFRCIGFkZHJlc3MNCj4gIAlsZHIJdzIxLCA9c3RleHRf
b2Zmc2V0DQo+IC0JYWRkCXgyMSwgeDAsIHgyMQ0KPiArCWFkZAl4MjEsIHgwLCB4MjEJCS8vIHJl
bG9jYXRlZCBJbWFnZSBhZGRyZXNzDQo+ICANCj4gIAkvKg0KPiAgCSAqIENhbGN1bGF0ZSBzaXpl
IG9mIHRoZSBrZXJuZWwgSW1hZ2UgKHNhbWUgZm9yIG9yaWdpbmFsIGFuZA0KPiBjb3B5KS4NCj4g
QEAgLTgwLDkgKzQzLDggQEAgRU5UUlkoZW50cnkpDQo+ICAJICogZW50cmllcyBmb3IgdGhlIFZB
IHJhbmdlIG9mIHRoZSBjdXJyZW50IGltYWdlLCBzbyBubw0KPiBtYWludGVuYW5jZSBpcw0KPiAg
CSAqIG5lY2Vzc2FyeS4NCj4gIAkgKi8NCj4gLQlhZHIJeDAsIGVudHJ5DQo+IC0JYWRyCXgxLCBl
bnRyeV9lbmQNCj4gLQlzdWIJeDEsIHgxLCB4MA0KPiArCWFkcgl4MCwgZWZpX2VudGVyX2tlcm5l
bA0KPiArCW1vdgl4MSwgZWZpX2VudGVyX2tlcm5lbF9zaXplDQo+ICAJYmwJX19mbHVzaF9kY2Fj
aGVfYXJlYQ0KPiAgDQo+ICAJLyogVHVybiBvZmYgRGNhY2hlIGFuZCBNTVUgKi8NCj4gQEAgLTEx
MCwxMSArNzIsNSBAQCBFTlRSWShlbnRyeSkNCj4gIAltb3YJeDIsIHh6cg0KPiAgCW1vdgl4Mywg
eHpyDQo+ICAJYnIJeDIxDQo+IC0NCj4gLWVmaV9sb2FkX2ZhaWw6DQo+IC0JbW92CXgwLCAjRUZJ
X0xPQURfRVJST1INCj4gLQlsZHAJeDI5LCB4MzAsIFtzcF0sICMzMg0KPiAtCXJldA0KPiAtDQo+
IC1lbnRyeV9lbmQ6DQo+IC1FTkRQUk9DKGVudHJ5KQ0KPiArRU5EUFJPQyhlZmlfZW50ZXJfa2Vy
bmVsKQ0KPiArCS5zZXQJZWZpX2VudGVyX2tlcm5lbF9zaXplLCAuIC0gZWZpX2VudGVyX2tlcm5l
bA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvZWZpLWhlYWRlci5TIGIvYXJjaC9h
cm02NC9rZXJuZWwvZWZpLQ0KPiBoZWFkZXIuUw0KPiBpbmRleCBhN2NmYWNjZTNlMTUuLjQwYzcw
NGM1ZDNhNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvZWZpLWhlYWRlci5TDQo+
ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL2VmaS1oZWFkZXIuUw0KPiBAQCAtMjcsNyArMjcsNyBA
QCBvcHRpb25hbF9oZWFkZXI6DQo+ICAJLmxvbmcJX19pbml0ZGF0YV9iZWdpbiAtIGVmaV9oZWFk
ZXJfZW5kCS8vIFNpemVPZkNvZGUNCj4gIAkubG9uZwlfX3BlY29mZl9kYXRhX3NpemUJCQkvLw0K
PiBTaXplT2ZJbml0aWFsaXplZERhdGENCj4gIAkubG9uZwkwCQkJCQkvLw0KPiBTaXplT2ZVbmlu
aXRpYWxpemVkRGF0YQ0KPiAtCS5sb25nCV9fZWZpc3R1Yl9lbnRyeSAtIF9oZWFkCQkJLy8NCj4g
QWRkcmVzc09mRW50cnlQb2ludA0KPiArCS5sb25nCV9fZWZpc3R1Yl9lZmlfZW50cnkgLSBfaGVh
ZAkJLy8NCj4gQWRkcmVzc09mRW50cnlQb2ludA0KPiAgCS5sb25nCWVmaV9oZWFkZXJfZW5kIC0g
X2hlYWQJCQkvLyBCYXNlT2ZDb2RlDQo+ICANCj4gIGV4dHJhX2hlYWRlcl9maWVsZHM6DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybS1zdHViLmMNCj4gYi9k
cml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybS1zdHViLmMNCj4gaW5kZXggNTZlNDc1YzFh
YTU1Li40MzljMDk0ZjdiZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvYXJtLXN0dWIuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2Fy
bS1zdHViLmMNCj4gQEAgLTEzMywxNyArMTMzLDIwIEBAIGVmaV9zdGF0dXNfdCBoYW5kbGVfa2Vy
bmVsX2ltYWdlKHVuc2lnbmVkIGxvbmcNCj4gKmltYWdlX2FkZHIsDQo+ICAJCQkJIHVuc2lnbmVk
IGxvbmcgKnJlc2VydmVfc2l6ZSwNCj4gIAkJCQkgdW5zaWduZWQgbG9uZyBkcmFtX2Jhc2UsDQo+
ICAJCQkJIGVmaV9sb2FkZWRfaW1hZ2VfdCAqaW1hZ2UpOw0KPiArDQo+ICt2b2lkIF9fbm9yZXR1
cm4gZWZpX2VudGVyX2tlcm5lbCh1bnNpZ25lZCBsb25nIGVudHJ5cG9pbnQsIHVuc2lnbmVkDQo+
IGxvbmcgZmR0KTsNCj4gKw0KPiAgLyoNCj4gICAqIEVGSSBlbnRyeSBwb2ludCBmb3IgdGhlIGFy
bS9hcm02NCBFRkkgc3R1YnMuICBUaGlzIGlzIHRoZQ0KPiBlbnRyeXBvaW50DQo+ICAgKiB0aGF0
IGlzIGRlc2NyaWJlZCBpbiB0aGUgUEUvQ09GRiBoZWFkZXIuICBNb3N0IG9mIHRoZSBjb2RlIGlz
IHRoZQ0KPiBzYW1lDQo+ICAgKiBmb3IgYm90aCBhcmNoaWN0ZWN0dXJlcywgd2l0aCB0aGUgYXJj
aC1zcGVjaWZpYyBjb2RlIHByb3ZpZGVkIGluDQo+IHRoZQ0KPiAgICogaGFuZGxlX2tlcm5lbF9p
bWFnZSgpIGZ1bmN0aW9uLg0KPiAgICovDQo+IC11bnNpZ25lZCBsb25nIGVmaV9lbnRyeSh2b2lk
ICpoYW5kbGUsIGVmaV9zeXN0ZW1fdGFibGVfdA0KPiAqc3lzX3RhYmxlX2FyZywNCj4gLQkJCSAg
ICAgICB1bnNpZ25lZCBsb25nICppbWFnZV9hZGRyKQ0KPiArZWZpX3N0YXR1c190IGVmaV9lbnRy
eShlZmlfaGFuZGxlX3QgaGFuZGxlLCBlZmlfc3lzdGVtX3RhYmxlX3QNCj4gKnN5c190YWJsZV9h
cmcpDQo+ICB7DQo+ICAJZWZpX2xvYWRlZF9pbWFnZV90ICppbWFnZTsNCj4gIAllZmlfc3RhdHVz
X3Qgc3RhdHVzOw0KPiArCXVuc2lnbmVkIGxvbmcgaW1hZ2VfYWRkcjsNCj4gIAl1bnNpZ25lZCBs
b25nIGltYWdlX3NpemUgPSAwOw0KPiAgCXVuc2lnbmVkIGxvbmcgZHJhbV9iYXNlOw0KPiAgCS8q
IGFkZHIvcG9pbnQgYW5kIHNpemUgcGFpcnMgZm9yIG1lbW9yeSBtYW5hZ2VtZW50Ki8NCj4gQEAg
LTE1Myw3ICsxNTYsNiBAQCB1bnNpZ25lZCBsb25nIGVmaV9lbnRyeSh2b2lkICpoYW5kbGUsDQo+
IGVmaV9zeXN0ZW1fdGFibGVfdCAqc3lzX3RhYmxlX2FyZywNCj4gIAl1bnNpZ25lZCBsb25nIGZk
dF9zaXplID0gMDsNCj4gIAljaGFyICpjbWRsaW5lX3B0ciA9IE5VTEw7DQo+ICAJaW50IGNtZGxp
bmVfc2l6ZSA9IDA7DQo+IC0JdW5zaWduZWQgbG9uZyBuZXdfZmR0X2FkZHI7DQo+ICAJZWZpX2d1
aWRfdCBsb2FkZWRfaW1hZ2VfcHJvdG8gPSBMT0FERURfSU1BR0VfUFJPVE9DT0xfR1VJRDsNCj4g
IAl1bnNpZ25lZCBsb25nIHJlc2VydmVfYWRkciA9IDA7DQo+ICAJdW5zaWduZWQgbG9uZyByZXNl
cnZlX3NpemUgPSAwOw0KPiBAQCAtMTY1LDggKzE2NywxMCBAQCB1bnNpZ25lZCBsb25nIGVmaV9l
bnRyeSh2b2lkICpoYW5kbGUsDQo+IGVmaV9zeXN0ZW1fdGFibGVfdCAqc3lzX3RhYmxlX2FyZywN
Cj4gIAlzeXNfdGFibGUgPSBzeXNfdGFibGVfYXJnOw0KPiAgDQo+ICAJLyogQ2hlY2sgaWYgd2Ug
d2VyZSBib290ZWQgYnkgdGhlIEVGSSBmaXJtd2FyZSAqLw0KPiAtCWlmIChzeXNfdGFibGUtPmhk
ci5zaWduYXR1cmUgIT0gRUZJX1NZU1RFTV9UQUJMRV9TSUdOQVRVUkUpDQo+ICsJaWYgKHN5c190
YWJsZS0+aGRyLnNpZ25hdHVyZSAhPSBFRklfU1lTVEVNX1RBQkxFX1NJR05BVFVSRSkgew0KPiAr
CQlzdGF0dXMgPSBFRklfSU5WQUxJRF9QQVJBTUVURVI7DQo+ICAJCWdvdG8gZmFpbDsNCj4gKwl9
DQo+ICANCj4gIAlzdGF0dXMgPSBjaGVja19wbGF0Zm9ybV9mZWF0dXJlcygpOw0KPiAgCWlmIChz
dGF0dXMgIT0gRUZJX1NVQ0NFU1MpDQo+IEBAIC0xODcsNiArMTkxLDcgQEAgdW5zaWduZWQgbG9u
ZyBlZmlfZW50cnkodm9pZCAqaGFuZGxlLA0KPiBlZmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJs
ZV9hcmcsDQo+ICAJZHJhbV9iYXNlID0gZ2V0X2RyYW1fYmFzZSgpOw0KPiAgCWlmIChkcmFtX2Jh
c2UgPT0gRUZJX0VSUk9SKSB7DQo+ICAJCXByX2VmaV9lcnIoIkZhaWxlZCB0byBmaW5kIERSQU0g
YmFzZVxuIik7DQo+ICsJCXN0YXR1cyA9IEVGSV9MT0FEX0VSUk9SOw0KPiAgCQlnb3RvIGZhaWw7
DQo+ICAJfQ0KPiAgDQo+IEBAIC0xOTgsNiArMjAzLDcgQEAgdW5zaWduZWQgbG9uZyBlZmlfZW50
cnkodm9pZCAqaGFuZGxlLA0KPiBlZmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJsZV9hcmcsDQo+
ICAJY21kbGluZV9wdHIgPSBlZmlfY29udmVydF9jbWRsaW5lKGltYWdlLCAmY21kbGluZV9zaXpl
LA0KPiBVTE9OR19NQVgpOw0KPiAgCWlmICghY21kbGluZV9wdHIpIHsNCj4gIAkJcHJfZWZpX2Vy
cigiZ2V0dGluZyBjb21tYW5kIGxpbmUgdmlhDQo+IExPQURFRF9JTUFHRV9QUk9UT0NPTFxuIik7
DQo+ICsJCXN0YXR1cyA9IEVGSV9PVVRfT0ZfUkVTT1VSQ0VTOw0KPiAgCQlnb3RvIGZhaWw7DQo+
ICAJfQ0KPiAgDQo+IEBAIC0yMTMsNyArMjE5LDcgQEAgdW5zaWduZWQgbG9uZyBlZmlfZW50cnko
dm9pZCAqaGFuZGxlLA0KPiBlZmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJsZV9hcmcsDQo+ICAN
Cj4gIAlzaSA9IHNldHVwX2dyYXBoaWNzKCk7DQo+ICANCj4gLQlzdGF0dXMgPSBoYW5kbGVfa2Vy
bmVsX2ltYWdlKGltYWdlX2FkZHIsICZpbWFnZV9zaXplLA0KPiArCXN0YXR1cyA9IGhhbmRsZV9r
ZXJuZWxfaW1hZ2UoJmltYWdlX2FkZHIsICZpbWFnZV9zaXplLA0KPiAgCQkJCSAgICAgJnJlc2Vy
dmVfYWRkciwNCj4gIAkJCQkgICAgICZyZXNlcnZlX3NpemUsDQo+ICAJCQkJICAgICBkcmFtX2Jh
c2UsIGltYWdlKTsNCj4gQEAgLTI2MCw3ICsyNjYsNyBAQCB1bnNpZ25lZCBsb25nIGVmaV9lbnRy
eSh2b2lkICpoYW5kbGUsDQo+IGVmaV9zeXN0ZW1fdGFibGVfdCAqc3lzX3RhYmxlX2FyZywNCj4g
IAkJcHJfZWZpKCJHZW5lcmF0aW5nIGVtcHR5IERUQlxuIik7DQo+ICANCj4gIAlpZiAoIW5vaW5p
dHJkKCkpIHsNCj4gLQkJbWF4X2FkZHIgPSBlZmlfZ2V0X21heF9pbml0cmRfYWRkcihkcmFtX2Jh
c2UsDQo+ICppbWFnZV9hZGRyKTsNCj4gKwkJbWF4X2FkZHIgPSBlZmlfZ2V0X21heF9pbml0cmRf
YWRkcihkcmFtX2Jhc2UsDQo+IGltYWdlX2FkZHIpOw0KPiAgCQlzdGF0dXMgPSBlZmlfbG9hZF9p
bml0cmRfZGV2X3BhdGgoJmluaXRyZF9hZGRyLA0KPiAmaW5pdHJkX3NpemUsDQo+ICAJCQkJCQkg
IG1heF9hZGRyKTsNCj4gIAkJaWYgKHN0YXR1cyA9PSBFRklfU1VDQ0VTUykgew0KPiBAQCAtMzEx
LDMzICszMTcsMzAgQEAgdW5zaWduZWQgbG9uZyBlZmlfZW50cnkodm9pZCAqaGFuZGxlLA0KPiBl
Zmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJsZV9hcmcsDQo+ICANCj4gIAlpbnN0YWxsX21lbXJl
c2VydmVfdGFibGUoKTsNCj4gIA0KPiAtCW5ld19mZHRfYWRkciA9IGZkdF9hZGRyOw0KPiAgCXN0
YXR1cyA9IGFsbG9jYXRlX25ld19mZHRfYW5kX2V4aXRfYm9vdChoYW5kbGUsDQo+IC0JCQkJJm5l
d19mZHRfYWRkciwNCj4gZWZpX2dldF9tYXhfZmR0X2FkZHIoZHJhbV9iYXNlKSwNCj4gKwkJCQkm
ZmR0X2FkZHIsDQo+IGVmaV9nZXRfbWF4X2ZkdF9hZGRyKGRyYW1fYmFzZSksDQo+ICAJCQkJaW5p
dHJkX2FkZHIsIGluaXRyZF9zaXplLCBjbWRsaW5lX3B0ciwNCj4gIAkJCQlmZHRfYWRkciwgZmR0
X3NpemUpOw0KPiArCWlmIChzdGF0dXMgIT0gRUZJX1NVQ0NFU1MpDQo+ICsJCWdvdG8gZmFpbF9m
cmVlX2luaXRyZDsNCj4gIA0KPiAtCS8qDQo+IC0JICogSWYgYWxsIHdlbnQgd2VsbCwgd2UgbmVl
ZCB0byByZXR1cm4gdGhlIEZEVCBhZGRyZXNzIHRvIHRoZQ0KPiAtCSAqIGNhbGxpbmcgZnVuY3Rp
b24gc28gaXQgY2FuIGJlIHBhc3NlZCB0byBrZXJuZWwgYXMgcGFydCBvZg0KPiAtCSAqIHRoZSBr
ZXJuZWwgYm9vdCBwcm90b2NvbC4NCj4gLQkgKi8NCj4gLQlpZiAoc3RhdHVzID09IEVGSV9TVUND
RVNTKQ0KPiAtCQlyZXR1cm4gbmV3X2ZkdF9hZGRyOw0KPiArCWVmaV9lbnRlcl9rZXJuZWwoaW1h
Z2VfYWRkciwgZmR0X2FkZHIpOw0KPiArCS8qIG5vdCByZWFjaGVkICovDQo+ICANCj4gK2ZhaWxf
ZnJlZV9pbml0cmQ6DQo+ICAJcHJfZWZpX2VycigiRmFpbGVkIHRvIHVwZGF0ZSBGRFQgYW5kIGV4
aXQgYm9vdCBzZXJ2aWNlc1xuIik7DQo+ICANCj4gIAllZmlfZnJlZShpbml0cmRfc2l6ZSwgaW5p
dHJkX2FkZHIpOw0KPiAgCWVmaV9mcmVlKGZkdF9zaXplLCBmZHRfYWRkcik7DQo+ICANCj4gIGZh
aWxfZnJlZV9pbWFnZToNCj4gLQllZmlfZnJlZShpbWFnZV9zaXplLCAqaW1hZ2VfYWRkcik7DQo+
ICsJZWZpX2ZyZWUoaW1hZ2Vfc2l6ZSwgaW1hZ2VfYWRkcik7DQo+ICAJZWZpX2ZyZWUocmVzZXJ2
ZV9zaXplLCByZXNlcnZlX2FkZHIpOw0KPiAgZmFpbF9mcmVlX2NtZGxpbmU6DQo+ICAJZnJlZV9z
Y3JlZW5faW5mbyhzaSk7DQo+ICAJZWZpX2ZyZWUoY21kbGluZV9zaXplLCAodW5zaWduZWQgbG9u
ZyljbWRsaW5lX3B0cik7DQo+ICBmYWlsOg0KPiAtCXJldHVybiBFRklfRVJST1I7DQo+ICsJcmV0
dXJuIHN0YXR1czsNCj4gIH0NCj4gIA0KPiAgLyoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvYXJtMzItc3R1Yi5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi9hcm0zMi1zdHViLmMNCj4gaW5kZXggN2IyYTYzODJiNjQ3Li4xMTMyOThiOGVhNjUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtMzItc3R1Yi5j
DQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtMzItc3R1Yi5jDQo+IEBA
IC0yMjcsNiArMjI3LDcgQEAgZWZpX3N0YXR1c190IGhhbmRsZV9rZXJuZWxfaW1hZ2UodW5zaWdu
ZWQgbG9uZw0KPiAqaW1hZ2VfYWRkciwNCj4gIAkgKiBSZWxvY2F0ZSB0aGUgekltYWdlLCBzbyB0
aGF0IGl0IGFwcGVhcnMgaW4gdGhlIGxvd2VzdCAxMjggTUINCj4gIAkgKiBtZW1vcnkgd2luZG93
Lg0KPiAgCSAqLw0KPiArCSppbWFnZV9hZGRyID0gaW1hZ2UtPmltYWdlX2Jhc2U7DQo+ICAJKmlt
YWdlX3NpemUgPSBpbWFnZS0+aW1hZ2Vfc2l6ZTsNCj4gIAlzdGF0dXMgPSBlZmlfcmVsb2NhdGVf
a2VybmVsKGltYWdlX2FkZHIsICppbWFnZV9zaXplLA0KPiAqaW1hZ2Vfc2l6ZSwNCj4gIAkJCQkg
ICAgIGtlcm5lbF9iYXNlICsNCj4gTUFYX1VOQ09NUF9LRVJORUxfU0laRSwgMCwgMCk7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LXN0dWIuYw0KPiBi
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQtc3R1Yi5jDQo+IGluZGV4IDcxOWQw
M2E2NDMyOS4uOTI1NGNkOGFiMmQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2Vm
aS9saWJzdHViL2FybTY0LXN0dWIuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJz
dHViL2FybTY0LXN0dWIuYw0KPiBAQCAtNDMsNyArNDMsNiBAQCBlZmlfc3RhdHVzX3QgaGFuZGxl
X2tlcm5lbF9pbWFnZSh1bnNpZ25lZCBsb25nDQo+ICppbWFnZV9hZGRyLA0KPiAgew0KPiAgCWVm
aV9zdGF0dXNfdCBzdGF0dXM7DQo+ICAJdW5zaWduZWQgbG9uZyBrZXJuZWxfc2l6ZSwga2VybmVs
X21lbXNpemUgPSAwOw0KPiAtCXZvaWQgKm9sZF9pbWFnZV9hZGRyID0gKHZvaWQgKikqaW1hZ2Vf
YWRkcjsNCj4gIAl1bnNpZ25lZCBsb25nIHByZWZlcnJlZF9vZmZzZXQ7DQo+ICAJdTY0IHBoeXNf
c2VlZCA9IDA7DQo+ICANCj4gQEAgLTE0MSw3ICsxNDAsNyBAQCBlZmlfc3RhdHVzX3QgaGFuZGxl
X2tlcm5lbF9pbWFnZSh1bnNpZ25lZCBsb25nDQo+ICppbWFnZV9hZGRyLA0KPiAgCQl9DQo+ICAJ
CSppbWFnZV9hZGRyID0gKnJlc2VydmVfYWRkciArIFRFWFRfT0ZGU0VUOw0KPiAgCX0NCj4gLQlt
ZW1jcHkoKHZvaWQgKikqaW1hZ2VfYWRkciwgb2xkX2ltYWdlX2FkZHIsIGtlcm5lbF9zaXplKTsN
Cj4gKwltZW1jcHkoKHZvaWQgKikqaW1hZ2VfYWRkciwgaW1hZ2UtPmltYWdlX2Jhc2UsIGtlcm5l
bF9zaXplKTsNCj4gIA0KPiAgCXJldHVybiBFRklfU1VDQ0VTUzsNCj4gIH0NCg0KLS0gDQpSZWdh
cmRzLA0KQXRpc2gNCg==
