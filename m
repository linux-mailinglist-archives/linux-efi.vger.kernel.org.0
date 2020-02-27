Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE0170D7E
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 01:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgB0AxG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 19:53:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17257 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgB0AxG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 19:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582764793; x=1614300793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ckps28SYkVweMJF2SY5LcXYLlRdGKB1lKG/0P8E/8Bc=;
  b=Uat+WHGeA95lYAqYSzmd6fXMohHCgNRJIT9wRbwRAe/vbB8cfE6uCbjX
   TxgcQJ5zqzgUn06NSQUZYafw4OzT1kIaIBZ9pZlWa2QrGVOViS/5eMcEg
   DhEOHEBaYpjMVHEvjbSeNr8G1MbdL9N9bK5mGOM/fv+GbruUxbdMydl94
   IHcGckkhq1nQx+QtIaoGb8VRD2fADYuTOsPnXShX68Imxbd9kwjw96IC9
   M3v7ldpqrvsmzkMgGK5TK1LsZx/jcxg/ye0Q6KtW5e20W6oopMl6qJ57C
   W5OLbL55omMU55p54pqQOc8z7b8egNMY18KDk+sXIaGtwQSYDEmAq+gwY
   w==;
IronPort-SDR: y1wpxpdg5xoeapUxSFqwqe4ZsLwU27M/xSgJ1J/qWHPRpyjZIPD0Xn6kRPg/Zt1zHcHHR4u9h7
 E2Ew8gludEovA75FMB1quVQl+Wqu32hsTrujYpD7GbHtiMgGkTba7svwtxRyOUcykc1OWK5fyC
 cVdc6E59pDI2MBsPEVkEEkEc0AkGhSmj9cE5utJuihl5zkUWrP8kIyh4+QxlKReeim85cPxCqq
 NfBNCQKsgSphHeh6AfU6QEZ+MguE4TyefDI7IU5MICo+XMMrp7GhCtxLPiha4e6sZVKa8YX9on
 4fI=
X-IronPort-AV: E=Sophos;i="5.70,490,1574092800"; 
   d="scan'208";a="232758574"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 08:53:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMK4JUiExIpK2yx7oZjYM1sKRT/nnrvUMqKBpr6MBcxIMbv9EkkHGZtRjpYUXrqoDp7P1ci8nI+ZqtZbeyDHIFFtYXIrPo3BjvniAA95bglIfSmalLk9V8VirUzbZ1DEOq8oRg2s1fqsnzYWj5ZmoTfXvDa3357XyUcOb8Db0V7mlKYGW9QeiL3enTVXvrCSr+7VfrCYcEGHwb2DbQi5n8+NwUU3WFUyJ+YXeCRRgxtrfaUY2R48aIc0xsHaZIXtXXjhJSwCDAOj8hiU7gGjgIyaJuaA+dQa0PNW8ihgG4GVmdpYGWrgNfIOsDjvhArJKpDaYtCt94++9KiVaznUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckps28SYkVweMJF2SY5LcXYLlRdGKB1lKG/0P8E/8Bc=;
 b=BrM4q7MsyO5hrTN2iXhryyNhDrc1bYzJWDRQwkErdcnZccsMxoKZzrDJfirZKozsgWvEKXe0L+D3ZYSOidi/gqI47334rpAeji5WizBdNfif+4ZJgXI54SG1i68gf0Fn5IfunwgWevebj8vqjLiCkxytI+8lYQmflsX05a4xN8FVe4YoMkxypDKdTPT5Y0tKSISqLTRWgYAIk8yxZxAofVQ+jmqeUlCOGIX1rR3978lcE7vbzeAEXDN6LxXKCZ43RIimpkBgopRo49fwrXYNB9NIeS7le9jdGRr/VNzbmD98x2PbYrz9GusrXWS3Ix8posa1qCCeS71dc5ifXenaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckps28SYkVweMJF2SY5LcXYLlRdGKB1lKG/0P8E/8Bc=;
 b=YxaNitAF3mvbDhT0I6fNs6ll8HwL5OMRzODCE9p1bgxtpapLLEBeNu4JqCieMaMK5j8XccbOXv9mIPSOTkHIWymogY8RAbPjwhbebwVg6JCFzIZ85IL4GLdTW+nj+uG1d8Dh3LIngiRyccNqHSb5CIBQRH1FNkCZHnAltGWkA7A=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB5864.namprd04.prod.outlook.com (2603:10b6:a03:10d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 00:53:02 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 00:53:02 +0000
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
Subject: Re: [RFC PATCH 2/5] include: pe.h: Add RISC-V related PE definition
Thread-Topic: [RFC PATCH 2/5] include: pe.h: Add RISC-V related PE definition
Thread-Index: AQHV7EGbQ/hJ0+85jUS9XgnqZeDXpagtDecAgAEqGoA=
Date:   Thu, 27 Feb 2020 00:53:01 +0000
Message-ID: <aec81e45ab5ee1104d2088513fe4ca668b83d04a.camel@wdc.com>
References: <20200226011037.7179-1-atish.patra@wdc.com>
         <20200226011037.7179-3-atish.patra@wdc.com>
         <CAKv+Gu-LAfcH5mLZNLk7=A3E43a93FK+8DPYNrx1FANnbo3J7g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-LAfcH5mLZNLk7=A3E43a93FK+8DPYNrx1FANnbo3J7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bde3bbc0-a1c0-480e-c0c7-08d7bb1f65dd
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58643C25C01B2FD3E02561FEFAEB0@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(64756008)(4326008)(66556008)(66446008)(6486002)(26005)(66946007)(7406005)(76116006)(6916009)(186003)(6506007)(7416002)(4744005)(86362001)(66476007)(6512007)(71200400001)(478600001)(8936002)(81156014)(81166006)(36756003)(8676002)(316002)(2906002)(54906003)(5660300002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBwmDI9oLkEviR24iCWDI8jF4o1dtMZS+bnsUixry2wDiYDhGs5EjZL/BA6GSshT7MKjfuXD8C3UTfA94PfkfdcuD/H8xrGnkdKAkSlNJrzKcmxuYRcOsGpy+62FDjLmdfV0lDWqs5Qi0ls8VCsubLRzkxNbW8ELBNZPbBOQ/fDFe5yBK9e1JNw5PYb0OO9WsVrclVJIT7LDTCExp7K0ieewoW8fNBAbdQ6tt8goWxTwM2CfjH6Ntqvz480NNGbXo8t+98BYQxz2MQSkvR3d3eLtVhXClM6d1BlUOSFzw5ug78ald46AfTn4jUjRRAKSvrLKMWsFaOm11t37wUmvVbjV5/fSlfPyxWbzme12DEqcNvY1fDkfhJwVnNKMee8OvlTO2gheBLgU18UcI7Cc8DNDMPx+a9m3o5+yk6DKfmqFz9O86r06r7mIpDsBXgox
x-ms-exchange-antispam-messagedata: Tw1zDQpxzeGe4K0cjGdDrQMQUJ1MDCpSDwEWO38PeLYMJ2CTkjWOf7V3w4V3RvziuZw0BQDbuh1Zu9wcUpowkWKydEUZCg4ZTyp3i233FR8pBx/19972E4XIVQFYfG9IXVeSF6ipxNn95N9wxmpfnQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7DBC50AADC2E642A6F479BB55C8A7B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde3bbc0-a1c0-480e-c0c7-08d7bb1f65dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 00:53:02.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Kb2O0lTk65YZhEOwK5JIp2Cm9OWsYSiaajMQyg/EU5ZHHGUt1rjOJ9WB9ITlBq9JAQ2ixzAzVIYS+1bemJMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDA4OjA2ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gV2VkLCAyNiBGZWIgMjAyMCBhdCAwMjoxMCwgQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJh
QHdkYy5jb20+DQo+IHdyb3RlOg0KPiA+IERlZmluZSBSSVNDLVYgcmVsYXRlZCBtYWNoaW5lIHR5
cGVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3
ZGMuY29tPg0KPiANCj4gSWYgeW91IHB1dCB0aGVtIGluIGFscGhhYmV0aWNhbCBvcmRlciB3cnQg
U0gzOg0KPiANCg0KRG9uZS4NCg0KPiBSZXZpZXdlZC1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4NCj4gDQoNCj4gDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvcGUuaCB8
IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wZS5oIGIvaW5jbHVkZS9saW51eC9wZS5oDQo+ID4g
aW5kZXggOGFkNzFkNzYzYTc3Li42YTdjNDk3ZTRiMWYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9wZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9wZS5oDQo+ID4gQEAgLTU2LDYg
KzU2LDkgQEANCj4gPiAgI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9NQUNISU5FX1BPV0VSUENG
UCAgICAweDAxZjENCj4gPiAgI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9NQUNISU5FX1I0MDAw
ICAgICAgICAweDAxNjYNCj4gPiAgI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9NQUNISU5FX1NI
MyAgICAgICAgICAweDAxYTINCj4gPiArI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9NQUNISU5F
X1JJU0NWMzIgICAgICAweDUwMzINCj4gPiArI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9NQUNI
SU5FX1JJU0NWNjQgICAgICAweDUwNjQNCj4gPiArI2RlZmluZSAgICAgICAgSU1BR0VfRklMRV9N
QUNISU5FX1JJU0NWMTI4ICAgICAweDUxMjgNCj4gPiAgI2RlZmluZSAgICAgICAgSU1BR0VfRklM
RV9NQUNISU5FX1NIM0RTUCAgICAgICAweDAxYTMNCj4gPiAgI2RlZmluZSAgICAgICAgSU1BR0Vf
RklMRV9NQUNISU5FX1NIM0UgICAgICAgICAweDAxYTQNCj4gPiAgI2RlZmluZSAgICAgICAgSU1B
R0VfRklMRV9NQUNISU5FX1NINCAgICAgICAgICAweDAxYTYNCj4gPiAtLQ0KPiA+IDIuMjQuMA0K
PiA+IA0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
