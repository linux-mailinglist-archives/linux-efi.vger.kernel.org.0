Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2631607A3
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 02:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgBQBRd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 16 Feb 2020 20:17:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49648 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQBRd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 16 Feb 2020 20:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581902251; x=1613438251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qDfHKKFZrcrCr91QMXX8Qt0xdOLIVH/njGS+yo6BPQw=;
  b=fi8I/lkjUbZi5ibgWzpZ0WqPbGJu8mu4rpeypjLiMLJP/BVyw/kvaaBx
   duGqfQaaDh+DhrJQtPIrSQfJh8375GxN5qc6XktmyHt5H3CqMN4WQUGJM
   7V35Snq7j+23hw4WCB01TtRGxO19Jvi4Zti+ZCM5EK/MTaDaBvh7+cu8F
   3K7KPNxyKnL/u2kk2L4VkNC0qVEMQDzE2akrHiVm+BqnAz//lzU6XrPoi
   StSPm+KS2Rd8+1OaeA3PcMbdyRsJ1yVplhUjruCJGblEOuON0zAdsgpS5
   sVBfvOpnjYXNQAvlqNIJFDXYlwSNUILSFUB4xWvzAI3qd4pun5FkNazxf
   Q==;
IronPort-SDR: +2k5ilctqLzvmuWtyq2Y/H/0EkBIA99aZpHoB5KVTKXJLQr4XG62upkP0hCEmmlentXpIgtEiW
 LAsJcP6zazTpB43WxGEScHybwFZbNyhfZ0WPsOod0WqROqUMrZ44rvqq3BfMVon3R9pmF0F47W
 5lRnTpDixzlX2HGXOILYDnRIAl7KAkzvyojjOIG+9YsHYbqSdZjXJHZabwIPCQ94kl9+MYmSJJ
 8x+G04tl/djPGVOL4H0wDIwvhrPno/pVKIq9VFy2HhxoQ2Nj633K7jk+Bugf50F1HQ56kPy6We
 bWo=
X-IronPort-AV: E=Sophos;i="5.70,450,1574092800"; 
   d="scan'208";a="131421784"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 09:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwbr81slmpqH2wGctobIs6pVZYnlBBlj3HfReQmcqgPiyIPnz2AkXTSbLta5HbH4W+UK3WWK6uAlNovSAJSnRmN98KBa/OmwZOnHyJ5aQF242DsjWCdzZx+6bqpwhaiMqFKD4lVrlUmXln25uJwv9t8ALcRSPFLZF0+k2EMbxhjt15y9xnWL7WPgkFKbXgwTRVV6+7AWLJAPv87Qyk+bddz/+DvloyVKO3v4JMc8UY0jY7uPWqPds23pqizFUbUf/e3a73OJZdflzL5MDXMFvFM9j6gEH7YHk7/3iwHoVm/0cbtslh2PcBs1CxKexGjQ680qVxty48izUXxynUcXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDfHKKFZrcrCr91QMXX8Qt0xdOLIVH/njGS+yo6BPQw=;
 b=S4tNs8+u8PA5rEHxZ8z9h5FzedvpwvQgav0Yb4Oj8eGKjiWRirYs9/vn0Gj233HxIVFyln0SeNcr53aYCZHly2eBfR+RtqWF8d1SMluLYzaq/lyaI3Dq+FabEgoDTbU87A5hX9qgK/cxW9pFz2bfOdeV+8aNK+uiH1KiBpuQoXNnZoOcJ+z8ifUpk/YQ3QfvlA++8yLsadUGkkP/m6ruJmtx4KgxciBUe9g712SBxe+XXF8F48Rq0PNeYhQodsTRqujJJc6/qIyCxqSrRf51PxAXdYQbYYdVanW4Lbusg8sGbtCmvgMBZNR66ZIw2wtwpFQFX73tp7thjjoc67AUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDfHKKFZrcrCr91QMXX8Qt0xdOLIVH/njGS+yo6BPQw=;
 b=NszETZ5R9DfdOspGh05EW6rRTYpTtpyb60o0OD8uCGZLq79M+6cA/HASh4P6mRxLInWGdHGTIYINHQO4PClvOg+NNbfWE1BmP6d3FRjtpvmCf8Hf9fU/G9/nmI6WCAqCZzw545g9zJ7UR1qice9dW9oJxzxEihJjVMJMqrmp+Tg=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4584.namprd04.prod.outlook.com (52.135.236.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 01:17:29 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::fd01:e357:2522:2221]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::fd01:e357:2522:2221%6]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 01:17:28 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Topic: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Index: AQHV4CugasGk9YRM9UekC9cWCfOkeKgen7IA
Date:   Mon, 17 Feb 2020 01:17:28 +0000
Message-ID: <952796db5423caf21c411c6f5629f32882f55b29.camel@wdc.com>
References: <20200210160248.4889-1-ardb@kernel.org>
         <20200210160248.4889-14-ardb@kernel.org>
In-Reply-To: <20200210160248.4889-14-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [98.248.240.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ca99ebe-9c2f-4b18-2e4d-08d7b34727de
x-ms-traffictypediagnostic: BYAPR04MB4584:
x-microsoft-antispam-prvs: <BYAPR04MB4584D9E22E54563E0E45A6E3FA160@BYAPR04MB4584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(76116006)(8936002)(316002)(6486002)(66946007)(2906002)(8676002)(6512007)(5660300002)(66556008)(4326008)(6506007)(186003)(478600001)(2616005)(26005)(36756003)(66446008)(64756008)(81166006)(71200400001)(86362001)(81156014)(66476007)(110136005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4584;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMP9KgvKd4B7G94bNIQ9fQxf2o8HmhubZaxUMrYxsHEQAOxjV+4RkJLGqQlKwppnWL9lUrkRdmg+Lyo4bNhVTUf6pBDe/aE4Fr2u9WxKCwS9USkLYqxRJVNg+DKuCwKi3kMGipZL2cZFe2GDYk4quv16MZwm06m+CzEzOIgaUfo4493migRc1mhW0a1BRWd8hHSdEMa4FABuFDQoPI2wch3EJ5vgDmwW5caDhgtv4wGCFabZcdnbcYgsrth/jDT8BMCzSrLs6BNdjgDSKE1KcKf6xJE3kp46Y3it+KYKqlxZMyT7fnrVvvaiblW1rYKvbdkYrVzFj48wbWnDiVCAqJ5AijdT6XvR9/ahlKxPnNQp3kM2dIcfe+R+XcegUJGucuJZzmGJ3Ju05MEqFD66JN+0SFM2pH6CRB1B/Id824zSJZHGl8cfgVifHNjZh+EQ
x-ms-exchange-antispam-messagedata: I0Z1lP0uVCIWI0LeH9GPLimfzY2wgcb08fzTun9a17UoOHgwquw5O9x3U59Z+umU1uJ52H4o1BIcjqNfppbF+Y2ljDD1jH6hjzWUtPgQ+s092LEmqsmbjnk7D+7DP2X+L0OF1VljtvaLGIX2NK94oA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B77748E7156004190DF13E84B28FFA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca99ebe-9c2f-4b18-2e4d-08d7b34727de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 01:17:28.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F61t4nczKyq3GaKtUiRWSZG9qEcwyM61DhveQHAFcd+V7/4BXEUxL6irMZ+JqontmhQdiNAc9M2z+4Qgm5o8LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4584
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDE3OjAyICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gZ2V0X2RyYW1fYmFzZSgpIGlzIG9ubHkgY2FsbGVkIGZyb20gYXJtLXN0dWIuYyBzbyBtb3Zl
IGl0IGludG8NCj4gdGhlIHNhbWUgc291cmNlIGZpbGUgYXMgaXRzIGNhbGxlci4NCj4gDQoNCkp1
c3QgRllJOiByaXNjdiBlZmkgc3R1YiBwb3J0IGlzIGFsc28gZ29pbmcgdG8gdXNlIGdldF9kcmFt
X2Jhc2UoKS4NCkhvd2V2ZXIsIEkgaGF2ZSByZW5hbWVkIGFybS1zdHViLmMgdG8gZ2VuZXJpYyBl
Zmktc3R1Yi5jIHNvIHRoYXQgYXJtLA0KYXJtNjQgYW5kIHJpc2N2IGNhbiByZXVzZSBpdC4gVGh1
cywgTW92aW5nIGdldF9kcmFtX2Jhc2UoKSBpbnRvIGFybS0NCnN0dWIuYyB3b3JrcyBmb3Igcmlz
Y3YgYXMgd2VsbC4gSSB3aWxsIHJlYmFzZSBteSBwYXRjaGVzIG9uIHRvcCBvZiB0aGlzDQpzZXJp
ZXMuDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtLXN0dWIuYyAgICAg
ICAgfCAzMw0KPiArKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpLXN0dWItaGVscGVyLmMgfCAzNSAtLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0NCj4g
IGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpc3R1Yi5oICAgICAgICAgfCAgMiAtLQ0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybS1zdHViLmMN
Cj4gYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybS1zdHViLmMNCj4gaW5kZXggZWJk
ZjE5NjRkZDVjLi5mYjViMmIzNWQzYmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUv
ZWZpL2xpYnN0dWIvYXJtLXN0dWIuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJz
dHViL2FybS1zdHViLmMNCj4gQEAgLTg3LDYgKzg3LDM5IEBAIHZvaWQgaW5zdGFsbF9tZW1yZXNl
cnZlX3RhYmxlKHZvaWQpDQo+ICAJCXByX2VmaV9lcnIoIkZhaWxlZCB0byBpbnN0YWxsIG1lbXJl
c2VydmUgY29uZmlnDQo+IHRhYmxlIVxuIik7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB1bnNpZ25l
ZCBsb25nIGdldF9kcmFtX2Jhc2Uodm9pZCkNCj4gK3sNCj4gKwllZmlfc3RhdHVzX3Qgc3RhdHVz
Ow0KPiArCXVuc2lnbmVkIGxvbmcgbWFwX3NpemUsIGJ1ZmZfc2l6ZTsNCj4gKwl1bnNpZ25lZCBs
b25nIG1lbWJhc2UgID0gRUZJX0VSUk9SOw0KPiArCXN0cnVjdCBlZmlfbWVtb3J5X21hcCBtYXA7
DQo+ICsJZWZpX21lbW9yeV9kZXNjX3QgKm1kOw0KPiArCXN0cnVjdCBlZmlfYm9vdF9tZW1tYXAg
Ym9vdF9tYXA7DQo+ICsNCj4gKwlib290X21hcC5tYXAJCT0gKGVmaV9tZW1vcnlfZGVzY190ICoq
KSZtYXAubWFwOw0KPiArCWJvb3RfbWFwLm1hcF9zaXplCT0gJm1hcF9zaXplOw0KPiArCWJvb3Rf
bWFwLmRlc2Nfc2l6ZQk9ICZtYXAuZGVzY19zaXplOw0KPiArCWJvb3RfbWFwLmRlc2NfdmVyCT0g
TlVMTDsNCj4gKwlib290X21hcC5rZXlfcHRyCT0gTlVMTDsNCj4gKwlib290X21hcC5idWZmX3Np
emUJPSAmYnVmZl9zaXplOw0KPiArDQo+ICsJc3RhdHVzID0gZWZpX2dldF9tZW1vcnlfbWFwKCZi
b290X21hcCk7DQo+ICsJaWYgKHN0YXR1cyAhPSBFRklfU1VDQ0VTUykNCj4gKwkJcmV0dXJuIG1l
bWJhc2U7DQo+ICsNCj4gKwltYXAubWFwX2VuZCA9IG1hcC5tYXAgKyBtYXBfc2l6ZTsNCj4gKw0K
PiArCWZvcl9lYWNoX2VmaV9tZW1vcnlfZGVzY19pbl9tYXAoJm1hcCwgbWQpIHsNCj4gKwkJaWYg
KG1kLT5hdHRyaWJ1dGUgJiBFRklfTUVNT1JZX1dCKSB7DQo+ICsJCQlpZiAobWVtYmFzZSA+IG1k
LT5waHlzX2FkZHIpDQo+ICsJCQkJbWVtYmFzZSA9IG1kLT5waHlzX2FkZHI7DQo+ICsJCX0NCj4g
Kwl9DQo+ICsNCj4gKwllZmlfYnNfY2FsbChmcmVlX3Bvb2wsIG1hcC5tYXApOw0KPiArDQo+ICsJ
cmV0dXJuIG1lbWJhc2U7DQo+ICt9DQo+ICANCj4gIC8qDQo+ICAgKiBUaGlzIGZ1bmN0aW9uIGhh
bmRsZXMgdGhlIGFyY2hpdGN0dXJlIHNwZWNpZmljIGRpZmZlcmVuY2VzDQo+IGJldHdlZW4gYXJt
IGFuZA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1
Yi1oZWxwZXIuYw0KPiBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItaGVs
cGVyLmMNCj4gaW5kZXggOTJjY2QwYTUxYWU2Li4xYThmMmNmNWEyYmQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItaGVscGVyLmMNCj4gKysrIGIv
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1Yi1oZWxwZXIuYw0KPiBAQCAtNzUs
NDEgKzc1LDYgQEAgdm9pZCBlZmlfcHJpbnRrKGNoYXIgKnN0cikNCj4gIAl9DQo+ICB9DQo+ICAN
Cj4gLQ0KPiAtdW5zaWduZWQgbG9uZyBnZXRfZHJhbV9iYXNlKHZvaWQpDQo+IC17DQo+IC0JZWZp
X3N0YXR1c190IHN0YXR1czsNCj4gLQl1bnNpZ25lZCBsb25nIG1hcF9zaXplLCBidWZmX3NpemU7
DQo+IC0JdW5zaWduZWQgbG9uZyBtZW1iYXNlICA9IEVGSV9FUlJPUjsNCj4gLQlzdHJ1Y3QgZWZp
X21lbW9yeV9tYXAgbWFwOw0KPiAtCWVmaV9tZW1vcnlfZGVzY190ICptZDsNCj4gLQlzdHJ1Y3Qg
ZWZpX2Jvb3RfbWVtbWFwIGJvb3RfbWFwOw0KPiAtDQo+IC0JYm9vdF9tYXAubWFwID0JCShlZmlf
bWVtb3J5X2Rlc2NfdCAqKikmbWFwLm1hcDsNCj4gLQlib290X21hcC5tYXBfc2l6ZSA9CSZtYXBf
c2l6ZTsNCj4gLQlib290X21hcC5kZXNjX3NpemUgPQkmbWFwLmRlc2Nfc2l6ZTsNCj4gLQlib290
X21hcC5kZXNjX3ZlciA9CU5VTEw7DQo+IC0JYm9vdF9tYXAua2V5X3B0ciA9CU5VTEw7DQo+IC0J
Ym9vdF9tYXAuYnVmZl9zaXplID0JJmJ1ZmZfc2l6ZTsNCj4gLQ0KPiAtCXN0YXR1cyA9IGVmaV9n
ZXRfbWVtb3J5X21hcCgmYm9vdF9tYXApOw0KPiAtCWlmIChzdGF0dXMgIT0gRUZJX1NVQ0NFU1Mp
DQo+IC0JCXJldHVybiBtZW1iYXNlOw0KPiAtDQo+IC0JbWFwLm1hcF9lbmQgPSBtYXAubWFwICsg
bWFwX3NpemU7DQo+IC0NCj4gLQlmb3JfZWFjaF9lZmlfbWVtb3J5X2Rlc2NfaW5fbWFwKCZtYXAs
IG1kKSB7DQo+IC0JCWlmIChtZC0+YXR0cmlidXRlICYgRUZJX01FTU9SWV9XQikgew0KPiAtCQkJ
aWYgKG1lbWJhc2UgPiBtZC0+cGh5c19hZGRyKQ0KPiAtCQkJCW1lbWJhc2UgPSBtZC0+cGh5c19h
ZGRyOw0KPiAtCQl9DQo+IC0JfQ0KPiAtDQo+IC0JZWZpX2JzX2NhbGwoZnJlZV9wb29sLCBtYXAu
bWFwKTsNCj4gLQ0KPiAtCXJldHVybiBtZW1iYXNlOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgZWZp
X3N0YXR1c190IGVmaV9maWxlX3NpemUodm9pZCAqX19maCwgZWZpX2NoYXIxNl90DQo+ICpmaWxl
bmFtZV8xNiwNCj4gIAkJCQkgIHZvaWQgKipoYW5kbGUsIHU2NCAqZmlsZV9zeikNCj4gIHsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpc3R1Yi5oDQo+IGIv
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmlzdHViLmgNCj4gaW5kZXggYjk0YzYzZDE3
YTRmLi41MTIzZGVmNzYxZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpc3R1Yi5oDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZp
c3R1Yi5oDQo+IEBAIC01NDksOCArNTQ5LDYgQEAgZWZpX3N0YXR1c190IGVmaV9leGl0X2Jvb3Rf
c2VydmljZXModm9pZCAqaGFuZGxlLA0KPiAgDQo+ICB2b2lkIGVmaV9jaGFyMTZfcHJpbnRrKGVm
aV9jaGFyMTZfdCAqKTsNCj4gIA0KPiAtdW5zaWduZWQgbG9uZyBnZXRfZHJhbV9iYXNlKHZvaWQp
Ow0KPiAtDQo+ICBlZmlfc3RhdHVzX3QgYWxsb2NhdGVfbmV3X2ZkdF9hbmRfZXhpdF9ib290KHZv
aWQgKmhhbmRsZSwNCj4gIAkJCQkJICAgIHVuc2lnbmVkIGxvbmcNCj4gKm5ld19mZHRfYWRkciwN
Cj4gIAkJCQkJICAgIHVuc2lnbmVkIGxvbmcgbWF4X2FkZHIsDQoNCi0tIA0KUmVnYXJkcywNCkF0
aXNoDQo=
