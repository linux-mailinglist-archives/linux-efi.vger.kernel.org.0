Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91517290C
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgB0T6T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 14:58:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1710 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgB0T6T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 14:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582833523; x=1614369523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PWJqM+XutTpd9lvfIeJXt62C9tEefHVY/C2jDbgZ7Ks=;
  b=DP110f42C72JIEhbOZ5GUyC4fiRanAwGLT+rlau8Dkm9XoO9S7Kiy2KC
   F2o0vvVp0c2F4W9gnh00dDaPPZTFGqsXocexZI/npzNu522/RiTZhMjA/
   U5e/xLcg795oFqZz/4PSXSDppXXkldmBmGTrkXCeVpJWr1xpM5D6BiVmz
   AqmRPOZnl5SHgObSaKV1Ybh+Fw+4CV4N8ThL2glNn7xO87Ey4nM8CYa1c
   afJdKsX+WwyCeL+LlsgNqx4ZRG4TCtaxRqHxXxvqfOS/AWILF5Xy/SW9Q
   as14yEN1NzqZ7LAVfgHMzbOXSACKaElL5zW+dyJvdPZ51VSoPIw4YnwgZ
   Q==;
IronPort-SDR: 5pATTQCqoYC+SDZWncn72rCjXXP9TDLCedmWotNyUbyvOdfKXe7Sne/r+kumZ5IOjvwQ4sf9dV
 snzIb9VGbX9zLIqjCnfdyFGwmIm1imJb7zD9K444MiHORlXZlWBBYumXBkGwnmuK8Ndf/P/hlG
 3lqzmmE5Kss/En23xxopM0sLKQQuauK/Te+Uwwq+dcntLy60KM3Sk12qyLohS2q/IOYYjbTDX1
 yu3PFN9H8zbnlU0j7fIeWHrfyPY0K1yI4Bve4ltEF3zHdrXacB0ek6Mai1GfxwggwYXxw4TSdV
 hcg=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="232852167"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 03:58:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hps1v/GGX6aGYmMZJGBI2U+FE/0d8yIxZkkAn7N5EoAFE1xqeLomU6KXTF0ypcPaep9qWmuZMJJ9y4y4jK+7FvXm6HP9VSe9/XwGOaoazCfI5vcjbsKtcDjX7L8D5n7cpDFCH2HZmG01O42aDzjCJyeGFoFUtpduvX/XYYARGXo9GSIdcIht2xytpurfzrB9BIg8BAovcAIta2/WzAhgz/y2gceb7L/2hHnsdmf88XikXPstLohqFw6aZEs5EL9fkXHOu4bDgxZc1QMD5aU7i2/YWPi5MdwxLWfxZ29vz/ZYWJ8TV2RSZL0HaOYu1QXlSFnf6ab+ysB2k3AuOfdvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWJqM+XutTpd9lvfIeJXt62C9tEefHVY/C2jDbgZ7Ks=;
 b=iQwzpH6nfVjwaaddg8l1HYEbozVceWO5f4LgKAAP1pgQ7+7DiUtgMr7ay5Q5WL5+WHZEDRdpu+hMkLWw4QXjLojpQvzVOWOlOIyw//wLiI88dPLYZo2ZdhMTjZUWPuFljhU4Az9e9oZMihgKhWpmRPVM9MGGmFz5d/F9kbW/jQw6CgVIhMNS9Tlr/fN1tXQhphf372sIAU2b9WJlvLHj2Shrbpb+ostmJ2CKMcDVqtk29VE73yr5ZNrT6n4+8U80wMxwLffaNq8QvFNwpqW2p9dAxC67XhPb0C2QxC0Phr/ctKQp5E8ct27jyH2cpyOzlQPUh+ntybZJm+12imrWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWJqM+XutTpd9lvfIeJXt62C9tEefHVY/C2jDbgZ7Ks=;
 b=TP5QXLQvHwFPEs4l8JLqKOCQDnNL/ZuylZA/DmXuVIQzWpHQwHaOzRFnpeHjkcEElhqdXozypQWCrq0sKQi1aDNmP9R7K8OMa90CNm5JFcCv9HNPKG1cghwxZkBGp+ICKtga8L6a/VtNavhePsnz+C3Gdhbb1NF7geNJO6U7Sgs=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB4744.namprd04.prod.outlook.com (2603:10b6:a03:16::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Thu, 27 Feb
 2020 19:58:13 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 19:58:13 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "ardb@kernel.org" <ardb@kernel.org>
CC:     "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.schaefer@hpe.com" <daniel.schaefer@hpe.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "agraf@csgraf.de" <agraf@csgraf.de>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "han_mao@c-sky.com" <han_mao@c-sky.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] RISC-V: Define fixmap bindings for generic early
 ioremap support
Thread-Topic: [RFC PATCH 3/5] RISC-V: Define fixmap bindings for generic early
 ioremap support
Thread-Index: AQHV7EGa80eUgMGvZ0y5cPI87oAY5qgtDq0AgAJpSAA=
Date:   Thu, 27 Feb 2020 19:58:13 +0000
Message-ID: <08322b0eeb26b564954a14273baf18db72e2f1e9.camel@wdc.com>
References: <20200226011037.7179-1-atish.patra@wdc.com>
         <20200226011037.7179-4-atish.patra@wdc.com>
         <CAKv+Gu8HdRa5k=h1XF2fm80VEgvuxa_tX_P0qFSdkk=CVc6ffA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8HdRa5k=h1XF2fm80VEgvuxa_tX_P0qFSdkk=CVc6ffA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58a0aa68-6807-42a4-c173-08d7bbbf6116
x-ms-traffictypediagnostic: BYAPR04MB4744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4744D14E312D0741888C16FCFAEB0@BYAPR04MB4744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(5660300002)(36756003)(71200400001)(6916009)(316002)(54906003)(6506007)(2616005)(186003)(8676002)(81156014)(81166006)(26005)(8936002)(86362001)(478600001)(7406005)(4326008)(7416002)(2906002)(76116006)(6512007)(66946007)(66476007)(66556008)(66446008)(64756008)(6486002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4744;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNGxWTxPWurVKwbt5rrTzC9n+9bTr5O9eP+gpFxmP+vfH7Yn4/xW7OpVQc8i/MC3qZgnQTApBSgREce2xhyuqfYsfq9TGlI/nL7dYAZ2YkseIHgViWaRt2JFoo6B2lBEmSxh66sTV4cQB/vXwSVXj3vXZ+RBauhBPaRE065DRiMH/LHCwnxzmJyAapZkkg61noQKCXKmZAFoVJ8xRa5H/sto0U/JADju4jEXoWN8/LbfcKDrxL97jDzmi6sVtMtWX/96XsXqBqez0yITFYEGm0zaWfLyv8KQNr53DV1aNribQfeiSH2XrjHj0BnU0hONgeBgnpeDuV2LxlhtnzdwgnHlA53h5N+AslSZgEzbg+pI+Y7Q7GXDw8MQIzOJrxj90ZXmLI5R4B1ekwYGcnI5i+LFcxPVZ+5ZfwFMjn1OAkf3riCTFoEHxfEyOtOSVgHiP7fWEX2aIZ2zMwHcQiMXtk5vTYbipUj4pZFWenZcATg=
x-ms-exchange-antispam-messagedata: 3hGiChdVDqLmuQjp9sex8phzK3WmPs2WV0W7ZDDa/PVwWgYABI/WVb/MikE3ads6a8gPeXHyuwDXK8W6DKqAXISsyoH8aelmX960yn86FTDVOB8seNP7X+e51O7JV4ZuM7jLqMjzp0pJ9cpw7Xl1Wg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CE2E255ECB4C54FBC4543A9A11320D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a0aa68-6807-42a4-c173-08d7bbbf6116
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 19:58:13.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns2IiWqET1Thr4UZAJrRAj2Mwibd5PP8LqUV0/PI+2HU8dXIIqv9vgWeecyRUNIb6A9vyaqvbdB7oqCxZIInOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4744
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDA4OjA4ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gV2VkLCAyNiBGZWIgMjAyMCBhdCAwMjoxMCwgQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJh
QHdkYy5jb20+DQo+IHdyb3RlOg0KPiA+IFVFRkkgdXNlcyBlYXJseSBJTyBvciBtZW1vcnkgbWFw
cGluZ3MgZm9yIHJ1bnRpbWUgc2VydmljZXMgYmVmb3JlDQo+ID4gbm9ybWFsIGlvcmVtYXAoKSBp
cyB1c2FibGUuIFRoaXMgcGF0Y2ggb25seSBhZGRzIG1pbmltdW0gbmVjZXNzYXJ5DQo+ID4gZml4
bWFwIGJpbmRpbmdzIGFuZCBoZWFkZXJzIGZvciBnZW5lcmljIGlvcmVtYXAgc3VwcG9ydCB0byB3
b3JrLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3
ZGMuY29tPg0KPiANCj4gTG9va3MgcmVhc29uYWJsZSB0byBtZSwNCj4gDQo+IEFja2VkLWJ5OiBB
cmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiANCj4gYWx0aG91Z2ggSSB3b25kZXIg
d2h5IGl0IGlzIHBhcnQgb2YgdGhpcyBzZXJpZXM/DQo+IA0KDQpiZWNhdXNlIG9mIENPTkZJR19F
RkkuIFdpdGggQ09ORklHX0VGSSBlbmFibGVkLCBhbGwgdGhlIHJ1biB0aW1lDQpzZXJ2aWNlIG1l
bW9yeSBtYXBwaW5nIGNvZGUgaXMgY29tcGlsZWQgZm9yIFJJU0MtVi4gSSBjb3VsZCBoYXZlDQpj
cmVhdGVhIGEgc2VwYXJhdGUgY29uZmlnIGZvciBvbmx5IGJvb3QgdGltZSBzZXJ2aWNlcyBvciB1
c2VkIEVGSV9TVFVCDQphdCBwbGFjZXMgd2hlcmUgQ09ORklfRUZJLiBCdXQgaXQgc2VlbXMgcmVk
dW5kYW50IGFzIHdlIHdpbGwgc3VwcG9ydA0KcnVudGltZSBzZXJ2aWNlcyBzb29uLiBMZXQgbWUg
a25vdyBpZiB0aGF0J3MgYSB3cm9uZyBhcHByb2FjaC4NCg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jp
c2N2L0tjb25maWcgICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL0tidWlsZCAgIHwgIDEgKw0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ZpeG1hcC5o
IHwgMjEgKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20v
aW8uaCAgICAgfCAgMSArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcg
Yi9hcmNoL3Jpc2N2L0tjb25maWcNCj4gPiBpbmRleCAyN2JmYzc5NDdlNDQuLjQyYzEyMjE3MGNm
ZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25maWcNCj4gPiArKysgYi9hcmNoL3Jp
c2N2L0tjb25maWcNCj4gPiBAQCAtNjUsNiArNjUsNyBAQCBjb25maWcgUklTQ1YNCj4gPiAgICAg
ICAgIHNlbGVjdCBBUkNIX0hBU19HQ09WX1BST0ZJTEVfQUxMDQo+ID4gICAgICAgICBzZWxlY3Qg
SEFWRV9DT1BZX1RIUkVBRF9UTFMNCj4gPiAgICAgICAgIHNlbGVjdCBIQVZFX0FSQ0hfS0FTQU4g
aWYgTU1VICYmIDY0QklUDQo+ID4gKyAgICAgICBzZWxlY3QgR0VORVJJQ19FQVJMWV9JT1JFTUFQ
DQo+ID4gDQo+ID4gIGNvbmZpZyBBUkNIX01NQVBfUk5EX0JJVFNfTUlODQo+ID4gICAgICAgICBk
ZWZhdWx0IDE4IGlmIDY0QklUDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vS2J1aWxkDQo+ID4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL0tidWlsZA0KPiA+IGluZGV4
IGVjMGNhOGM2YWI2NC4uNTE3Mzk0MzkwMTA2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vS2J1aWxkDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9LYnVp
bGQNCj4gPiBAQCAtNCw2ICs0LDcgQEAgZ2VuZXJpYy15ICs9IGNoZWNrc3VtLmgNCj4gPiAgZ2Vu
ZXJpYy15ICs9IGNvbXBhdC5oDQo+ID4gIGdlbmVyaWMteSArPSBkZXZpY2UuaA0KPiA+ICBnZW5l
cmljLXkgKz0gZGl2NjQuaA0KPiA+ICtnZW5lcmljLXkgKz0gZWFybHlfaW9yZW1hcC5oDQo+ID4g
IGdlbmVyaWMteSArPSBleHRhYmxlLmgNCj4gPiAgZ2VuZXJpYy15ICs9IGZsYXQuaA0KPiA+ICBn
ZW5lcmljLXkgKz0gZG1hLmgNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9maXhtYXAuaA0KPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9maXhtYXAuaA0KPiA+IGlu
ZGV4IDQyZDJjNDJmM2NjOS4uN2E0YmViN2UyOWEzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vZml4bWFwLmgNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L2ZpeG1hcC5oDQo+ID4gQEAgLTI1LDkgKzI1LDI4IEBAIGVudW0gZml4ZWRfYWRkcmVzc2VzIHsN
Cj4gPiAgI2RlZmluZSBGSVhfRkRUX1NJWkUgICBTWl8xTQ0KPiA+ICAgICAgICAgRklYX0ZEVF9F
TkQsDQo+ID4gICAgICAgICBGSVhfRkRUID0gRklYX0ZEVF9FTkQgKyBGSVhfRkRUX1NJWkUgLyBQ
QUdFX1NJWkUgLSAxLA0KPiA+ICsgICAgICAgRklYX0VBUkxZQ09OX01FTV9CQVNFLA0KPiA+ICsN
Cj4gPiAgICAgICAgIEZJWF9QVEUsDQo+ID4gICAgICAgICBGSVhfUE1ELA0KPiA+IC0gICAgICAg
RklYX0VBUkxZQ09OX01FTV9CQVNFLA0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIE1h
a2Ugc3VyZSB0aGF0IGl0IGlzIDJNQiBhbGlnbmVkLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyNk
ZWZpbmUgTlJfRklYX1NaXzJNICAgKFNaXzJNIC8gUEFHRV9TSVpFKQ0KPiA+ICsgICAgICAgRklY
X1RIT0xFID0gTlJfRklYX1NaXzJNIC0gRklYX1BNRCAtIDEsDQo+ID4gKw0KPiA+ICsgICAgICAg
X19lbmRfb2ZfcGVybWFuZW50X2ZpeGVkX2FkZHJlc3NlcywNCj4gPiArICAgICAgIC8qDQo+ID4g
KyAgICAgICAgKiBUZW1wb3JhcnkgYm9vdC10aW1lIG1hcHBpbmdzLCB1c2VkIGJ5IGVhcmx5X2lv
cmVtYXAoKSwNCj4gPiArICAgICAgICAqIGJlZm9yZSBpb3JlbWFwKCkgaXMgZnVuY3Rpb25hbC4N
Cj4gPiArICAgICAgICAqLw0KPiA+ICsjZGVmaW5lIE5SX0ZJWF9CVE1BUFMgICAgICAgICAgKFNa
XzI1NksgLyBQQUdFX1NJWkUpDQo+ID4gKyNkZWZpbmUgRklYX0JUTUFQU19TTE9UUyAgICAgICA3
DQo+ID4gKyNkZWZpbmUgVE9UQUxfRklYX0JUTUFQUyAgICAgICAoTlJfRklYX0JUTUFQUyAqIEZJ
WF9CVE1BUFNfU0xPVFMpDQo+ID4gKw0KPiA+ICsgICAgICAgRklYX0JUTUFQX0VORCA9IF9fZW5k
X29mX3Blcm1hbmVudF9maXhlZF9hZGRyZXNzZXMsDQo+ID4gKyAgICAgICBGSVhfQlRNQVBfQkVH
SU4gPSBGSVhfQlRNQVBfRU5EICsgVE9UQUxfRklYX0JUTUFQUyAtIDEsDQo+ID4gKw0KPiA+ICAg
ICAgICAgX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzDQo+ID4gIH07DQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vaW8uaA0KPiA+IGIvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS9pby5oDQo+ID4gaW5kZXggMGY0NzcyMDZhNGVkLi4wNDdmNDE0YjY5NDggMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pby5oDQo+ID4gKysrIGIvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS9pby5oDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vbW1pb3diLmg+DQo+ID4gICNp
bmNsdWRlIDxhc20vcGd0YWJsZS5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2Vhcmx5X2lvcmVtYXAu
aD4NCj4gPiANCj4gPiAgLyoNCj4gPiAgICogTU1JTyBhY2Nlc3MgZnVuY3Rpb25zIGFyZSBzZXBh
cmF0ZWQgb3V0IHRvIGJyZWFrIGRlcGVuZGVuY3kNCj4gPiBjeWNsZXMNCj4gPiAtLQ0KPiA+IDIu
MjQuMA0KPiA+IA0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
