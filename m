Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3F170E36
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 03:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgB0CJT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 21:09:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9854 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgB0CJT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 21:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582769359; x=1614305359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nM4yNW+E/Fq5qtMBf4PFN7BewFfcG1dZkaLhgktytW4=;
  b=ZV0e8jt5kE/FCrIZFi1wepBlUvXCgnibEr4ZTFTLBytsu7WkasoZrZPI
   44yliSBC1inuN8eR7pzveFQamtXZU6mPo6rak1CK1iy/g+vYlBy0tQd1a
   VEVX6QGyb2rxJbuqQz7LLsSBLQc8R3+DteXpkFL56Ti9MijB0jJYsNJMD
   rxC8sBEPVHddNGeQPa0QzR3Cz+1putjeBFxFmGI5BmswQQxmBaZ22Fmuz
   DbbmjIPOsnQA9pqYBNOaq307gxMIuakSWCKQGH2wTxwTAu4Hs4mpPaRkr
   TiazKhJJKp6SKKhjyTq01vF2q7PoNXxq58oW2i/6137STT5IH1MN2H8Mo
   A==;
IronPort-SDR: Iw/zyn6ehGLvWqvLKM+SQw0GucQXwxDHx2oH77jnNle3vyaHNK29uHcgnyZV9ad2lFEHlv5izi
 DxjXpoEz1fq6qquVMI5h6ZGoAdVxOawDrPRzFIscNAQvAQxw1rlhFkv6FM0IbJF2TCxi8UiYkZ
 avd+5TLnxXrybZzaA1TqYtHugA1/nYJKUZZAPelqSeeIOZTOkkNReuHtx/RcEwl+p87HlvpL6L
 B5Ku62nnrMxcZ2LNO4yeMLLfxsGoOaXjWmLJD+mszraWvM3lIAgMmQ7LXY+suJBD3qVPyX84Dx
 PRg=
X-IronPort-AV: E=Sophos;i="5.70,490,1574092800"; 
   d="scan'208";a="132310405"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 10:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2vsf4Ktq1NYeD1rsOpU/Dgez5/vRvgmPs4TeqDNwQuP71rUaqg3dVix65Qkk/pbXDS9VGNYlVFSdTlrYKqSnpXNlEvQSn0SSWTGDyIQNGw0xxdfYG3Iiu5dkjG0h06UasO+xZgn2vkPWuriv2ckJcgLBpb+oQ4RsSAf+h7SC60S7U3mXoheSFHCtvKGFoQHr/gYF4Cyj1HBINPRU1k92dKQHVOLQN5SgJUhUmf5CmndxxTBM2KbGCHoemK29bCsDhoahon5nPr9NQxRXrF6KcDl1Cn6y+wfiaEUMZkILxZb7yZE5wg0bJckwJ+bkBy/E6nNum1UWo98I+c7lrL78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM4yNW+E/Fq5qtMBf4PFN7BewFfcG1dZkaLhgktytW4=;
 b=FNKdmAbg+2o1s0tFRm3y89R1VKboBA1xMdHMorgwU1lQKlGtGjgwImXTtixP1LyvjA6qUh8myVoRI3Wjl4eriBt7emBcZx3sci5bgkLw9ibV8qlhS92+B7fvdiaBKxTkDF43nQUiyv1UhJL6BExk5g1h2pSgsFgAE37CID4je0PpuCsrm/DcTdqe6ngnqIntWBiE60l7W2Pvr2ksoFStYBa2YDFQdFtPWgx8pD6nUKDpgqUxLa0w/gFWFXbJ2vfXsobe68vBeI+OErpd1BYOjmqW1BSk43pGh5Wt2lZAuR6x8py/svsGmkNEuMuVshzseDliXgfBYHbTrlsYaEkUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM4yNW+E/Fq5qtMBf4PFN7BewFfcG1dZkaLhgktytW4=;
 b=H50PWJp6IL/dHTv7r5wH8g8NYC7EEn5ae8/PTiieBTDw6nCzP0oUoGhTReZtnx7O7an2yVeCu9mkjGADNqaSR6kV4A6Yawy35JVaO0I4Vhh17TzVaRtRME3awWs5W+sCzM/Gc1jOc3JmbMwYw1RtF7EGnNb5X62EfvUJLi/Yjrk=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB5480.namprd04.prod.outlook.com (2603:10b6:a03:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 02:09:10 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 02:09:10 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "palmer@dabbelt.com" <palmer@dabbelt.com>
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
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "bp@suse.de" <bp@suse.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "agraf@csgraf.de" <agraf@csgraf.de>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "han_mao@c-sky.com" <han_mao@c-sky.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/5] Add UEFI support for RISC-V
Thread-Topic: [RFC PATCH 0/5] Add UEFI support for RISC-V
Thread-Index: AQHV7EGYoAdkl+AnW0myanef1YhJk6guJX0AgAAnyoA=
Date:   Thu, 27 Feb 2020 02:09:09 +0000
Message-ID: <7659f4c0970fac6113c290b0f3a4889bf6504cfd.camel@wdc.com>
References: <mhng-2fe6e2a0-9291-4810-b42c-af69b8dbaa06@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-2fe6e2a0-9291-4810-b42c-af69b8dbaa06@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26db07e1-5089-4429-e48e-08d7bb2a0872
x-ms-traffictypediagnostic: BYAPR04MB5480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5480763750A27E0275E4AB19FAEB0@BYAPR04MB5480.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(66556008)(66946007)(66476007)(64756008)(2906002)(86362001)(76116006)(2616005)(478600001)(81166006)(36756003)(81156014)(5660300002)(8676002)(186003)(966005)(6506007)(26005)(66446008)(6916009)(7406005)(7416002)(6512007)(71200400001)(8936002)(4326008)(54906003)(6486002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5480;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tay/hTfXcvFxZJV6dCnYd2pC5BIwZ2+hTc/NqnCbgasrtKOJ9xDGyiUJjJ+icBViJs+utjSGX45IICHTxZPlfS3Otgh+cs/pwTi4mhVEkI0CWXCgdZMX/Jj+d7HUmBU+ngCyR780RxJuO+PBVMxrCDYVM07wOaryBysFVqGofWLw8sIggOdielO1euR9gakWyxsSCG/uJKLPouIik4vjZPDhJZXGpUBCdX4wv1Cl91VrQLxiy6MS6cDPoCZSp8vwh+LDLmFNO0WC0tZbmF87EsxWOz7d6zszY0LFnRCo1D2Maq8OnPx+kT7VEMB2uBd5Vg3t9M0YgKtrGYCHcJDEKJ5fZE3ycHRN9wZDYzz1TGO3qbs3cxIUitjyu3EjPh+0n6qH9o0cue9rXhdyB15QVTI/4VPkQwkfBJlHgMt0Pa9JGRtrYAAnjvJIGqXPqZTCLo1qGqGTdYT39sP6Xl6kEtDRK2wmOayVHqIF0QNe6P3W7gmcqCi66wlouqmcwsYyEZOeekcRejilJY0LIbcwAg==
x-ms-exchange-antispam-messagedata: xlKUc5M138b3lfY0/jX9uM9c47+3Kqeue/FzRUIfV/yRwPJDCIRuM4vUgLGCM2UrKljndSxDhdGfVGuLzdO0RjirvoRrHTCIhouDtczwk6jV4afm+TgX8EmniN7ukIN7MFBqIR/BKCPQiyCjaHpgsA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3DB5AC33994F349A1137DF6E1798769@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db07e1-5089-4429-e48e-08d7bb2a0872
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 02:09:09.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXTHUEwoORa0A1jkFyxpJNZqykj8vK2GY73gPiRHVdpu0J66faOKxxT1KLOuNHjUR4GglZFUVWR5FdPPGTr9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5480
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDE1OjQ2IC0wODAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gVHVlLCAyNSBGZWIgMjAyMCAxNzoxMDozMiBQU1QgKC0wODAwKSwgQXRpc2ggUGF0cmEg
d3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBVRUZJIHN1cHBvcnQgZm9yIFJJU0MtVi4gQ3Vy
cmVudGx5LCBvbmx5IGJvb3QgdGltZQ0KPiA+IHNlcnZpY2VzIGhhdmUgYmVlbiBhZGRlZC4gUnVu
dGltZSBzZXJ2aWNlcyB3aWxsIGJlIGFkZGVkIGluIGENCj4gPiBzZXBhcmF0ZQ0KPiA+IHNlcmll
cy4gVGhpcyBzZXJpZXMgZGVwZW5kcyBvbiBzb21lIGNvcmUgRUZJIHBhdGNoZXMNCj4gPiBwcmVz
ZW50IGluIGN1cnJlbnQgaW4gZWZpLW5leHQgYW5kIGZvbGxvd2luZyBvdGhlciBwYXRjaGVzLg0K
PiA+IA0KPiA+IFUtQm9vdDogQWRkcyB0aGUgYm9vdCBoYXJ0aWQgdW5kZXIgY2hvc2VuIG5vZGUu
DQo+ID4gaHR0cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJvb3QvMjAyMC1GZWJydWFy
eS80MDEyMjcuaHRtbA0KPiA+IA0KPiA+IExpbnV4IGtlcm5lbDogU0JJIHYwLjIgYW5kIEhTTSBl
eHRlbnNpb24gc3VwcG9ydC4gVGhpcyBzZXJpZXMgaXMgYQ0KPiA+IG1hbmRhdG9yeQ0KPiA+IHBy
ZS1yZXF1aXNpdGUgZm9yIFVFRkkgc3VwcG9ydCBhcyBvbmx5IHNpbmdsZSBjb3JlIGNhbiBib290
IEVGSQ0KPiA+IHN0dWIgYW5kDQo+ID4gTGludXggdmlhIFVFRkkuIEFsbCBvdGhlciBjb3JlcyBh
cmUgYnJvdWdodCB1cCB1c2luZyBTQkkgSFNNDQo+ID4gZXh0ZW5zaW9uLg0KPiA+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1yaXNjdi8yMDIwLUZlYnJ1YXJ5LzAw
ODUxMy5odG1sDQo+ID4gDQo+ID4gT3BlblNCSTogbWFzdGVyIChjb21taXQ6IGdlM2Y2OWZjMWU5
MzQpDQo+ID4gDQo+ID4gUGF0Y2ggMSBqdXN0IG1vdmVzIGFybS1zdHViIGNvZGUgdG8gYSBnZW5l
cmljIGNvZGUgc28gdGhhdCBpdCBjYW4NCj4gPiBiZSB1c2VkDQo+ID4gYWNyb3NzIGRpZmZlcmVu
dCBhcmNoaXRlY3R1cmUuDQo+ID4gDQo+ID4gUGF0Y2ggMyBhZGRzIGZpeG1hcCBiaW5kaW5ncyBz
byB0aGF0IENPTkZJR19FRkkgY2FuIGJlIGNvbXBpbGVkIGFuZA0KPiA+IHdlIGRvIG5vdA0KPiA+
IGhhdmUgY3JlYXRlIHNlcGFyYXRlIGNvbmZpZyB0byBlbmFibGUgYm9vdCB0aW1lIHNlcnZpY2Vz
Lg0KPiA+IEFzIHJ1bnRpbWUgc2VydmljZXMgYXJlIG5vdCBlbmFibGVkIGF0IHRoaXMgdGltZSwg
ZnVsbCBnZW5lcmljDQo+ID4gZWFybHkgaW9yZW1hcA0KPiA+IHN1cHBvcnQgaXMgYWxzbyBub3Qg
YWRkZWQgaW4gdGhpcyBzZXJpZXMuDQo+ID4gDQo+ID4gUGF0Y2ggNCBhbmQgNSBhZGRzIHRoZSBQ
RS9DT0ZGIGhlYWRlciBhbmQgRUZJIHN0dWIgY29kZSBzdXBwb3J0IGZvcg0KPiA+IFJJU0MtVg0K
PiA+IHJlc3BlY3RpdmVseS4NCj4gPiANCj4gPiBUaGUgcGF0Y2hlcyBjYW4gYWxzbyBiZSBmb3Vu
ZCBpbiBmb2xsb3dpbmcgZ2l0IHJlcG8uDQo+ID4gDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2F0
aXNocDA0L2xpbnV4L3RyZWUvd2lwX3VlZmlfcmlzY3YNCj4gPiANCj4gPiBUaGUgcGF0Y2hlcyBo
YXZlIGJlZW4gdmVyaWZpZWQgb24gUWVtdSB1c2luZyBib290ZWZpIGNvbW1hbmQgaW4gVS0NCj4g
PiBCb290Lg0KPiA+IEhlcmUgaXMgYSBib290IGxvZy4NCj4gPiANCj4gPiBBdGlzaCBQYXRyYSAo
NSk6DQo+ID4gZWZpOiBNb3ZlIGFybS1zdHViIHRvIGEgY29tbW9uIGZpbGUNCj4gPiBpbmNsdWRl
OiBwZS5oOiBBZGQgUklTQy1WIHJlbGF0ZWQgUEUgZGVmaW5pdGlvbg0KPiA+IFJJU0MtVjogRGVm
aW5lIGZpeG1hcCBiaW5kaW5ncyBmb3IgZ2VuZXJpYyBlYXJseSBpb3JlbWFwIHN1cHBvcnQNCj4g
PiBSSVNDLVY6IEFkZCBQRS9DT0ZGIGhlYWRlciBmb3IgRUZJIHN0dWINCj4gPiBSSVNDLVY6IEFk
ZCBFRkkgc3R1YiBzdXBwb3J0Lg0KPiA+IA0KPiA+IGFyY2gvYXJtL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+IGFyY2gvYXJtNjQvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+IGFyY2gvcmlzY3YvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMSArKysNCj4gPiBhcmNoL3Jpc2N2L01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+IGFyY2gvcmlzY3YvY29u
Zmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9LYnVpbGQgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9maXhtYXAuaCAgICAgICAgICAgICAgIHwgIDIxICsrLQ0KPiA+IGFyY2gv
cmlzY3YvaW5jbHVkZS9hc20vaW8uaCAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9zZWN0aW9ucy5oICAgICAgICAgICAgIHwgIDEzICsrDQo+ID4g
YXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4g
PiBhcmNoL3Jpc2N2L2tlcm5lbC9lZmktaGVhZGVyLlMgICAgICAgICAgICAgICAgfCAxMDcgKysr
KysrKysrKysrKysNCj4gPiBhcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTUgKysNCj4gPiBhcmNoL3Jpc2N2L2tlcm5lbC9pbWFnZS12YXJzLmggICAgICAg
ICAgICAgICAgfCAgNTIgKysrKysrKw0KPiA+IGFyY2gvcmlzY3Yva2VybmVsL3ZtbGludXgubGRz
LlMgICAgICAgICAgICAgICB8ICAyNyArKystDQo+ID4gZHJpdmVycy9maXJtd2FyZS9lZmkvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ID4gZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi9NYWtlZmlsZSAgICAgICAgIHwgIDIwICsrLQ0KPiA+IC4uLi9lZmkvbGlic3R1Yi97
YXJtLXN0dWIuYyA9PiBlZmktc3R1Yi5jfSAgICB8ICAgNyArLQ0KPiA+IGRyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvcmlzY3Ytc3R1Yi5jICAgICB8IDEzNQ0KPiA+ICsrKysrKysrKysrKysr
KysrKw0KPiA+IGluY2x1ZGUvbGludXgvcGUuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMyArDQo+ID4gMTkgZmlsZXMgY2hhbmdlZCwgNDIwIGluc2VydGlvbnMoKyksIDIwIGRlbGV0
aW9ucygtKQ0KPiA+IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Nl
Y3Rpb25zLmgNCj4gPiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvZWZpLWhl
YWRlci5TDQo+ID4gY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yva2VybmVsL2ltYWdlLXZh
cnMuaA0KPiA+IHJlbmFtZSBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3thcm0tc3R1Yi5j
ID0+IGVmaS1zdHViLmN9DQo+ID4gKDk4JSkNCj4gPiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yaXNjdi1zdHViLmMNCj4gDQo+IEknbSBpbiBmYXZvciBv
ZiBhZGRpbmcgRUZJIHN1cHBvcnQsIGFuZCBJJ2QgcmF0aGVyIGhhdmUgaXQgc29vbmVyDQo+IHRo
YW4gbGF0ZXIgc28NCj4gd2UgZG9uJ3QgcGFpbnQgb3Vyc2VsdmVzIGludG8gYSBjb3JuZXIuICBJ
J20gbm90IHN1cmUgd2hhdCBoYXBwZW5lZA0KPiB0byB0aGUNCj4gUklTQy1WIEVGSSBzcGVjIHBy
b2Nlc3MsIHRob3VnaCwgd2hpY2ggd291bGQgYmUgbXkgb25seSB3b3JyeSBoZXJlDQo+IChhbHNv
IEkNCj4gaGF2ZW4ndCBsb29rZWQgYXQgdGhlIGNvZGUgOikpLiAgRG8gd2UgaGF2ZSBlbm91Z2gg
b2YgYSBzcGVjIHRocm91Z2gNCj4gdGhlIEVGSQ0KPiBwcm9jZXNzIHRoYXQgdGhpcyBpcyBhbGwg
a29zaGVyIG9uIHRoZWlyIGVuZD8NCj4gDQpUaGUgUklTQy1WIHBsYXRmb3JtIGlzIGFscmVhZHkg
bWVyZ2VkIGluIFVFRkkgc3BlYy4gVGhlIGxhdGVzdCBVRUZJDQpzcGVjIGNhbiBiZSBmb3VuZCBo
ZXJlLg0KDQpodHRwczovL3VlZmkub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMvcmVzb3VyY2VzL1VF
RklfU3BlY18yXzhfQV9GZWIxNC5wZGYNCg0KU2VjdGlvbiAyLjMuNzogUklTQy1WIFBsYXRmb3Jt
cw0KDQpUaGVyZSBhcmUgc29tZSBtb2RpZmljYXRpb24gcmVxdWlyZWQgaW4gdGhlIGN1cnJlbnQg
c3BlYy4gRm9yIGV4YW1wbGU6DQoNClRoZSBjdXJyZW50IHNwZWMgYXNzdW1lcyB0aGF0IFVFRkkg
d2lsbCBleGVjdXRlIGluIE0gbW9kZSBvbmx5IGFuZA0Kc2hvdWxkIHBlcmZvcm0gaGFuZG9mZiBj
b250cm9sIHRvIE9TIGluIE0tbW9kZSBhcyB3ZWxsLiBUaGlzIGlzIG5vdA0KZW50aXJlbHkgY29y
cmVjdCBhcyB3ZSBjYW4gZG8gdGhpcyBpbiBTLW1vZGUgYXMgd2VsbC4NCg0KV2UgYXJlIGluIHRo
ZSBwcm9jZXNzIG9mIGNyZWF0aW5nIGFuIEVDUiBzbyB0aGF0IG5leHQgcmVsZWFzZSB3aWxsIGhh
dmUNCnRoZSBjb3JyZWN0IGluZm9ybWF0aW9uLg0KDQo+IEdpdmVuIHRoYXQgdGhpcyBkZWZpbmF0
ZWx5IGlzbid0IGZvciB0aGVzZSBSQ3MsIEknbSBnb2luZyB0byBsZWF2ZSBpdA0KPiBpbiBteQ0K
PiByZXZpZXcgcXVldWUuICBJdCBtaWdodCBiZSBiZXN0IHRvIGdldCB0aGUgIm1vdmUgc3R1ZmYg
dG8gZ2VuZXJpYyINCj4gd29yayBtZXJnZWQNCj4gb24gaXRzIG93biwgYXMgdGhlbiB3ZSBjYW4g
Y2FycnkgbGVzcyBkaWZmIGFyb3VuZC4NCj4gDQo+IA0KDQpZdXAuIEl0J3MgZGVmaW5pdGVseSBu
b3QgcmMgbWF0ZXJpYWwuIEdpdmVuIHRoYXQgUklTQy1WIHNwZWNpZmljDQpzZWN0aW9uIGlzIGFs
cmVhZHkgbWVyZ2VkIGluIFVFRkkgc3BlYywgY2FuIHdlIGFpbSBmb3IgNS43IG1lcmdlIHdpbmRv
dz8gDQoNCj4gVGhhbmtzIQ0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
