Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1BB1B4BFE
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDVRnb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:43:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48306 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDVRna (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Apr 2020 13:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587577410; x=1619113410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5HfoYanYAU/rmhbxNc00IPmCk73tsreXpV/QSVzgBZ8=;
  b=UrfdBQ7LNrgJb6oUrxrRe3zCEjtdiedToNGWE9/spPG0wGjrRlR6nI5y
   hkM6skGpwYkm/gWBDKATDZxVGxPqc8tcTjZz7ZU8oVhC+ZeMg9Ez2vVTc
   dbsyMaPPxthrGNXPlzpUfnWp7U/U8Do8bzzQg8Dkqp4fwdepNFYGUjfWG
   tdee0e4O6TYd0/FU7UmnPCkEO6gvRwrhla6dPKaqpO6I72dlI/+0fPsvd
   h2qpcFAOaUcaf6je++kl+G5HLBOdiKLMEbkOMsx5Qlzx4F2/JYHVfBCvZ
   7qMxOxbcNLA79KiJa8ic2btRH80el4AIAR/b85tZi6QmWoPAoWEpmnioU
   w==;
IronPort-SDR: D3EgMQcv/5l8VS7A2s5VCTSaYMSM0DJIHjc0X+b8ag21MiMKmSxuTya2zAhMpJzUicY7eOvQ+z
 t68htt9DH/pW+AMIQV1MaRhwI35ksa2phJBnH0tPnfWJOuxSYEKKdIMWWye0C39KD77El5RxFa
 6exYlvS1/XDTkFDR90dT69Puzpt22gfAoguBWVukrFmXXBjGvkeEjLWHELMTELzwy14uL0YOAM
 nWWGex6+LpZFPHekPMCsnzNfwOImqLFHP3a19C5LA4bHMkX5gqmYZdDnIzSH9LcdmIiz1ITvzl
 xZs=
X-IronPort-AV: E=Sophos;i="5.73,304,1583164800"; 
   d="scan'208";a="140259905"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 01:43:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo6SXWjHXBd/u8DfS5Q0ygDuSBj5tQX7IiorIrS6+r1fT0pr9ABV3eQxdtSlogoYt/EulWuT4vqxTd0vVaZ0BAXeSktM+6YrUOwcA5ZUoWSfY7WcTQgWaL0LfeAxs0UYQqBn/T3g9A3OeaYfKJUiaBx+z6ZiK9531z/u/s45iM+nzZDRZU3F5RToBzZQR0OJJgMcXeItlEnHP9URYElnswoXUy/AYfr7RTNBKfs1tYYCQqzAPVl5evgTi1fuT/ju4Vw6Mp0SJrFNcGnsQ7QxBxsY39Z0VfLCtW+sKIdj8uNnuQLlzQAY6vx9lKJ8B7JCHcmLJ0Uob6hethfZQbX9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HfoYanYAU/rmhbxNc00IPmCk73tsreXpV/QSVzgBZ8=;
 b=cYPJj5ZNMpP4ES9NI8QWU+kcXMSm9ycw/WDKUNjTvPphSD4eENObt4UcLVpXTVwazWWNu4YTH/iisUwznyP74TbeTt2dbBdzGwUSVY+I/om1bs4BE0PZQ0lRTxFeuwc+TnUlrlJYog5gYo53u497FsKHzp1l38LWHiKzuw804s84YP3N74QozE07nK4xx3VYVmWtZ/t0mOvPrjt9w/p0URp2DDeTavRQZ5v/vVnb8VV1E7bD8eIq/pvZTuJ2927fMR84K7Hev9drAOQmGDI/vW+Hg7WUP7WKOP1LBZSW6IeIOHSaMH3OARdIkrEZ7XMA6s3YyeYzW4dmQMkc0Eus+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HfoYanYAU/rmhbxNc00IPmCk73tsreXpV/QSVzgBZ8=;
 b=oXwqUz3A6Una9PIkdwBNTL0semgAk7ERzsqf5cBYHr/sdJtrF2cuWvQ3KHBcZZvczDpVy8wtJh0FMfhatizAmom6WcmHRbknFSCPps+HqLhTKGkXGkaGWBFzJY6U5LEL//YU2eyE/vnkr/RFObe9p406gEy2LfNLEDlQfIfUKVc=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BY5PR04MB6600.namprd04.prod.outlook.com (2603:10b6:a03:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 17:43:28 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c%6]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 17:43:28 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "palmer@dabbelt.com" <palmer@dabbelt.com>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [v4 PATCH 2/3] RISC-V: Add PE/COFF header for EFI stub
Thread-Topic: [v4 PATCH 2/3] RISC-V: Add PE/COFF header for EFI stub
Thread-Index: AQHWF43MDvfKwf2EO06vZNelsf5ctqiEAFYAgAFrnIA=
Date:   Wed, 22 Apr 2020 17:43:28 +0000
Message-ID: <292b17611d215f9fc867dfe5b1b41fff2deb9764.camel@wdc.com>
References: <mhng-fc4c31fb-8f50-4aa9-82e1-6f2e9d08ac8f@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-fc4c31fb-8f50-4aa9-82e1-6f2e9d08ac8f@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [98.248.240.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7751930a-6c3a-421e-eb5c-08d7e6e4aa58
x-ms-traffictypediagnostic: BY5PR04MB6600:
x-microsoft-antispam-prvs: <BY5PR04MB6600F3304355A777DD570EFEFAD20@BY5PR04MB6600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(2616005)(4326008)(316002)(8676002)(64756008)(66446008)(66476007)(81156014)(76116006)(66946007)(186003)(66556008)(26005)(6506007)(478600001)(86362001)(54906003)(8936002)(2906002)(36756003)(6916009)(6512007)(71200400001)(6486002)(30864003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/WjGCgT3IkLFQet0hlAKiO+uzJz6XjA7+4b4Vix5D2nFGHA1vPjHbau1tnqqvpoTEH7KQnk2bqhGpkGWNEeTx6c8Uh6PjHWCAAiTmf5lFo1hLiRQq5YsLb+KAuamlq7KGIK1YSTQ67JGMS/YG/JQtnFOTDHySr3v5DY6cZAmN46+RaFZLjqts49LmpWqPLaj/xPuiUJGZ/ingQwvTIy9MyGK/3hM0Ib0vWkufL4X/IGzubPgb74GrtNdXEkP8MB08Arjabx8oD+hzN561+l0JaXC5hAbLaHMYC+nnnrmbDHNaEHK4hO3QTIBd+Z8pX7aRKrImHhyNSYH6qHOouRG2yjEt9Lt0zT4aYaodKkW/jeV9aG6tBoWaMC4VOtoGdcZw4PkUd21Jt1o1PliFr2scHL4BnxHGisbNq1OQ5WTC9ldNuiy5ea9L1zV/NdwGd8
x-ms-exchange-antispam-messagedata: VAngghZRO0huv7KJyuMiNd4gF9WLv/doC5XTfaCZ8L+JpDNoeunfbgkY2eIdwrBAsrO1+6IX0wHLUIY0NsxeOf70/6N3fOYeBV3RPi/RLkC1WAQITKuqOHSn3ihUQymP4FegUs6jJRXPwavvWsI/gQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C847519952F1EF48AC63B0EE073F2878@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7751930a-6c3a-421e-eb5c-08d7e6e4aa58
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 17:43:28.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5YkDCttnKArzqNZy19itQXZ03yejCKLfvn7knlS6kM4OKPtxMrIvZZDe3OBAX97vdmn0AcsXLOYPPT+nzAyjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6600
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTIxIGF0IDEzOjAyIC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gW0kganVzdCBzYXcgdGhlcmUncyBhIHY0LCBzbyBJJ20gbW92aW5nIG92ZXIgaGVyZV0NCj4g
DQo+IE9uIE1vbiwgMjAgQXByIDIwMjAgMjA6MzM6MzUgUERUICgtMDcwMCksIEF0aXNoIFBhdHJh
IHdyb3RlOg0KPiA+IExpbnV4IGtlcm5lbCBJbWFnZSBjYW4gYXBwZWFyIGFzIGFuIEVGSSBhcHBs
aWNhdGlvbiBXaXRoDQo+ID4gYXBwcm9wcmlhdGUNCj4gPiBQRS9DT0ZGIGhlYWRlciBmaWVsZHMg
aW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgSW1hZ2UgaGVhZGVyLiBBbiBFRkkNCj4gPiBhcHBsaWNh
dGlvbiBsb2FkZXIgY2FuIGRpcmVjdGx5IGxvYWQgYSBMaW51eCBrZXJuZWwgSW1hZ2UgYW5kIGFu
DQo+ID4gRUZJDQo+ID4gc3R1YiByZXNpZGluZyBpbiBrZXJuZWwgY2FuIGJvb3QgTGludXgga2Vy
bmVsIGRpcmVjdGx5Lg0KPiA+IA0KPiA+IEFkZCB0aGUgbmVjZXNzYXJ5IFBFL0NPRkYgaGVhZGVy
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmggfCAx
MyArKysrDQo+ID4gIGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAgICAgICB8ICA0ICsrDQo+
ID4gIGFyY2gvcmlzY3Yva2VybmVsL2VmaS1oZWFkZXIuUyAgICB8IDk5DQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgICAg
ICAgICAgfCAxNiArKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC9pbWFnZS12YXJzLmggICAg
fCA1MyArKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC92bWxpbnV4Lmxk
cy5TICAgfCAyMCArKysrKystDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMjAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3NlY3Rpb25zLmgNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
a2VybmVsL2VmaS1oZWFkZXIuUw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9r
ZXJuZWwvaW1hZ2UtdmFycy5oDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vc2VjdGlvbnMuaA0KPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zZWN0aW9u
cy5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNh
OTk3MWIxMjEwZg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3NlY3Rpb25zLmgNCj4gPiBAQCAtMCwwICsxLDEzIEBADQo+ID4gKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJp
Z2h0IChDKSAyMDIwIFdlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbiBvciBpdHMNCj4gPiBhZmZp
bGlhdGVzLg0KPiA+ICsgKi8NCj4gPiArI2lmbmRlZiBfX0FTTV9TRUNUSU9OU19IDQo+ID4gKyNk
ZWZpbmUgX19BU01fU0VDVElPTlNfSA0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGFzbS1nZW5lcmlj
L3NlY3Rpb25zLmg+DQo+ID4gKw0KPiA+ICtleHRlcm4gY2hhciBfc3RhcnRbXTsNCj4gPiArZXh0
ZXJuIGNoYXIgX3N0YXJ0X2tlcm5lbFtdOw0KPiA+ICsNCj4gPiArI2VuZGlmIC8qIF9fQVNNX1NF
Q1RJT05TX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUN
Cj4gPiBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQo+ID4gaW5kZXggODZjODMwODEwNDRm
Li44NmNhNzU1ZjhhOWYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZp
bGUNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQ0KPiA+IEBAIC0zMiw2ICsz
MiwxMCBAQCBvYmoteQkrPSBwYXRjaC5vDQo+ID4gIG9iai0kKENPTkZJR19NTVUpICs9IHZkc28u
byB2ZHNvLw0KPiA+IA0KPiA+ICBvYmotJChDT05GSUdfUklTQ1ZfTV9NT0RFKQkrPSBjbGludC5v
IHRyYXBzX21pc2FsaWduZWQubw0KPiA+ICtPQkpDT1BZRkxBR1MgOj0gLS1wcmVmaXgtc3ltYm9s
cz1fX2VmaXN0dWJfDQo+ID4gKyQob2JqKS8lLnN0dWIubzogJChvYmopLyUubyBGT1JDRQ0KPiA+
ICsJJChjYWxsIGlmX2NoYW5nZWQsb2JqY29weSkNCj4gPiArDQo+ID4gIG9iai0kKENPTkZJR19G
UFUpCQkrPSBmcHUubw0KPiA+ICBvYmotJChDT05GSUdfU01QKQkJKz0gc21wYm9vdC5vDQo+ID4g
IG9iai0kKENPTkZJR19TTVApCQkrPSBzbXAubw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2tlcm5lbC9lZmktaGVhZGVyLlMNCj4gPiBiL2FyY2gvcmlzY3Yva2VybmVsL2VmaS1oZWFkZXIu
Uw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42OWRk
ZTgyNjg1MjcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwv
ZWZpLWhlYWRlci5TDQo+ID4gQEAgLTAsMCArMSw5OSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAyMCBXZXN0ZXJuIERpZ2l0YWwgQ29ycG9yYXRpb24gb3IgaXRzDQo+ID4gYWZmaWxpYXRl
cy4NCj4gPiArICogQWRhcHRlZCBmcm9tIGFyY2gvYXJtNjQva2VybmVsL2VmaS1oZWFkZXIuUw0K
PiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wZS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvc2l6ZXMuaD4NCj4gPiArDQo+ID4gKwkubWFjcm8JX19FRklfUEVfSEVBREVSDQo+
ID4gKwkubG9uZwlQRV9NQUdJQw0KPiA+ICtjb2ZmX2hlYWRlcjoNCj4gPiArCS5zaG9ydAlJTUFH
RV9GSUxFX01BQ0hJTkVfUklTQ1Y2NAkJLy8gTWFjaGluZQ0KPiA+ICsJLnNob3J0CXNlY3Rpb25f
Y291bnQJCQkJLy8NCj4gPiBOdW1iZXJPZlNlY3Rpb25zDQo+ID4gKwkubG9uZwkwIAkJCQkJLy8N
Cj4gPiBUaW1lRGF0ZVN0YW1wDQo+ID4gKwkubG9uZwkwCQkJCQkvLw0KPiA+IFBvaW50ZXJUb1N5
bWJvbFRhYmxlDQo+ID4gKwkubG9uZwkwCQkJCQkvLw0KPiA+IE51bWJlck9mU3ltYm9scw0KPiA+
ICsJLnNob3J0CXNlY3Rpb25fdGFibGUgLSBvcHRpb25hbF9oZWFkZXIJCS8vDQo+ID4gU2l6ZU9m
T3B0aW9uYWxIZWFkZXINCj4gPiArCS5zaG9ydAlJTUFHRV9GSUxFX0RFQlVHX1NUUklQUEVEIHwg
XA0KPiA+ICsJCUlNQUdFX0ZJTEVfRVhFQ1VUQUJMRV9JTUFHRSB8IFwNCj4gPiArCQlJTUFHRV9G
SUxFX0xJTkVfTlVNU19TVFJJUFBFRAkJLy8NCj4gPiBDaGFyYWN0ZXJpc3RpY3MNCj4gPiArDQo+
ID4gK29wdGlvbmFsX2hlYWRlcjoNCj4gPiArCS5zaG9ydAlQRV9PUFRfTUFHSUNfUEUzMlBMVVMJ
CQkvLyBQRTMyKw0KPiA+IGZvcm1hdA0KPiA+ICsJLmJ5dGUJMHgwMgkJCQkJLy8NCj4gPiBNYWpv
ckxpbmtlclZlcnNpb24NCj4gPiArCS5ieXRlCTB4MTQJCQkJCS8vDQo+ID4gTWlub3JMaW5rZXJW
ZXJzaW9uDQo+ID4gKwkubG9uZwlfX3RleHRfZW5kIC0gZWZpX2hlYWRlcl9lbmQJCS8vDQo+ID4g
U2l6ZU9mQ29kZQ0KPiA+ICsJLmxvbmcJX2VuZCAtIF9fdGV4dF9lbmQJCQkvLw0KPiA+IFNpemVP
ZkluaXRpYWxpemVkRGF0YQ0KPiA+ICsJLmxvbmcJMAkJCQkJLy8NCj4gPiBTaXplT2ZVbmluaXRp
YWxpemVkRGF0YQ0KPiA+ICsJLmxvbmcJX19lZmlzdHViX2VmaV9lbnRyeSAtIF9zdGFydAkJLy8N
Cj4gPiBBZGRyZXNzT2ZFbnRyeVBvaW50DQo+ID4gKwkubG9uZwllZmlfaGVhZGVyX2VuZCAtIF9z
dGFydAkJCS8vDQo+ID4gQmFzZU9mQ29kZQ0KPiA+ICsNCj4gPiArZXh0cmFfaGVhZGVyX2ZpZWxk
czoNCj4gPiArCS5xdWFkCTAJCQkJCS8vDQo+ID4gSW1hZ2VCYXNlDQo+ID4gKwkubG9uZwlTWl80
SwkJCQkJLy8NCj4gPiBTZWN0aW9uQWxpZ25tZW50DQo+ID4gKwkubG9uZwlQRUNPRkZfRklMRV9B
TElHTk1FTlQJCQkvLw0KPiA+IEZpbGVBbGlnbm1lbnQNCj4gPiArCS5zaG9ydAkwCQkJCQkvLw0K
PiA+IE1ham9yT3BlcmF0aW5nU3lzdGVtVmVyc2lvbg0KPiA+ICsJLnNob3J0CTAJCQkJCS8vDQo+
ID4gTWlub3JPcGVyYXRpbmdTeXN0ZW1WZXJzaW9uDQo+ID4gKwkuc2hvcnQJTElOVVhfRUZJU1RV
Ql9NQUpPUl9WRVJTSU9OCQkvLw0KPiA+IE1ham9ySW1hZ2VWZXJzaW9uDQo+ID4gKwkuc2hvcnQJ
TElOVVhfRUZJU1RVQl9NSU5PUl9WRVJTSU9OCQkvLw0KPiA+IE1pbm9ySW1hZ2VWZXJzaW9uDQo+
ID4gKwkuc2hvcnQJMAkJCQkJLy8NCj4gPiBNYWpvclN1YnN5c3RlbVZlcnNpb24NCj4gPiArCS5z
aG9ydAkwCQkJCQkvLw0KPiA+IE1pbm9yU3Vic3lzdGVtVmVyc2lvbg0KPiA+ICsJLmxvbmcJMAkJ
CQkJLy8NCj4gPiBXaW4zMlZlcnNpb25WYWx1ZQ0KPiA+ICsNCj4gPiArCS5sb25nCV9lbmQgLSBf
c3RhcnQJCQkJLy8NCj4gPiBTaXplT2ZJbWFnZQ0KPiA+ICsNCj4gPiArCS8vIEV2ZXJ5dGhpbmcg
YmVmb3JlIHRoZSBrZXJuZWwgaW1hZ2UgaXMgY29uc2lkZXJlZCBwYXJ0IG9mIHRoZQ0KPiA+IGhl
YWRlcg0KPiA+ICsJLmxvbmcJZWZpX2hlYWRlcl9lbmQgLSBfc3RhcnQJCQkvLw0KPiA+IFNpemVP
ZkhlYWRlcnMNCj4gPiArCS5sb25nCTAJCQkJCS8vIENoZWNrU3VtDQo+ID4gKwkuc2hvcnQJSU1B
R0VfU1VCU1lTVEVNX0VGSV9BUFBMSUNBVElPTgkJLy8NCj4gPiBTdWJzeXN0ZW0NCj4gPiArCS5z
aG9ydAkwCQkJCQkvLw0KPiA+IERsbENoYXJhY3RlcmlzdGljcw0KPiA+ICsJLnF1YWQJMAkJCQkJ
Ly8NCj4gPiBTaXplT2ZTdGFja1Jlc2VydmUNCj4gPiArCS5xdWFkCTAJCQkJCS8vDQo+ID4gU2l6
ZU9mU3RhY2tDb21taXQNCj4gPiArCS5xdWFkCTAJCQkJCS8vDQo+ID4gU2l6ZU9mSGVhcFJlc2Vy
dmUNCj4gPiArCS5xdWFkCTAJCQkJCS8vDQo+ID4gU2l6ZU9mSGVhcENvbW1pdA0KPiA+ICsJLmxv
bmcJMAkJCQkJLy8NCj4gPiBMb2FkZXJGbGFncw0KPiA+ICsJLmxvbmcJKHNlY3Rpb25fdGFibGUg
LSAuKSAvIDgJCQkvLw0KPiA+IE51bWJlck9mUnZhQW5kU2l6ZXMNCj4gPiArDQo+ID4gKwkucXVh
ZAkwCQkJCQkvLw0KPiA+IEV4cG9ydFRhYmxlDQo+ID4gKwkucXVhZAkwCQkJCQkvLw0KPiA+IElt
cG9ydFRhYmxlDQo+ID4gKwkucXVhZAkwCQkJCQkvLw0KPiA+IFJlc291cmNlVGFibGUNCj4gPiAr
CS5xdWFkCTAJCQkJCS8vDQo+ID4gRXhjZXB0aW9uVGFibGUNCj4gPiArCS5xdWFkCTAJCQkJCS8v
DQo+ID4gQ2VydGlmaWNhdGlvblRhYmxlDQo+ID4gKwkucXVhZAkwCQkJCQkvLw0KPiA+IEJhc2VS
ZWxvY2F0aW9uVGFibGUNCj4gPiArDQo+ID4gKwkvLyBTZWN0aW9uIHRhYmxlDQo+ID4gK3NlY3Rp
b25fdGFibGU6DQo+ID4gKwkuYXNjaWkJIi50ZXh0XDBcMFwwIg0KPiA+ICsJLmxvbmcJX190ZXh0
X2VuZCAtIGVmaV9oZWFkZXJfZW5kCQkvLw0KPiA+IFZpcnR1YWxTaXplDQo+ID4gKwkubG9uZwll
ZmlfaGVhZGVyX2VuZCAtIF9zdGFydAkJCS8vDQo+ID4gVmlydHVhbEFkZHJlc3MNCj4gPiArCS5s
b25nCV9fdGV4dF9lbmQgLSBlZmlfaGVhZGVyX2VuZAkJLy8NCj4gPiBTaXplT2ZSYXdEYXRhDQo+
ID4gKwkubG9uZwllZmlfaGVhZGVyX2VuZCAtIF9zdGFydAkJCS8vDQo+ID4gUG9pbnRlclRvUmF3
RGF0YQ0KPiA+ICsNCj4gPiArCS5sb25nCTAJCQkJCS8vDQo+ID4gUG9pbnRlclRvUmVsb2NhdGlv
bnMNCj4gPiArCS5sb25nCTAJCQkJCS8vDQo+ID4gUG9pbnRlclRvTGluZU51bWJlcnMNCj4gPiAr
CS5zaG9ydAkwCQkJCQkvLw0KPiA+IE51bWJlck9mUmVsb2NhdGlvbnMNCj4gPiArCS5zaG9ydAkw
CQkJCQkvLw0KPiA+IE51bWJlck9mTGluZU51bWJlcnMNCj4gPiArCS5sb25nCUlNQUdFX1NDTl9D
TlRfQ09ERSB8IFwNCj4gPiArCQlJTUFHRV9TQ05fTUVNX1JFQUQgfCBcDQo+ID4gKwkJSU1BR0Vf
U0NOX01FTV9FWEVDVVRFCQkJLy8NCj4gPiBDaGFyYWN0ZXJpc3RpY3MNCj4gPiArDQo+ID4gKwku
YXNjaWkJIi5kYXRhXDBcMFwwIg0KPiA+ICsJLmxvbmcJX19kYXRhX3ZpcnRfc2l6ZQkJCS8vDQo+
ID4gVmlydHVhbFNpemUNCj4gPiArCS5sb25nCV9fdGV4dF9lbmQgLSBfc3RhcnQJCQkvLw0KPiA+
IFZpcnR1YWxBZGRyZXNzDQo+ID4gKwkubG9uZwlfX2RhdGFfcmF3X3NpemUJCQkJLy8NCj4gPiBT
aXplT2ZSYXdEYXRhDQo+ID4gKwkubG9uZwlfX3RleHRfZW5kIC0gX3N0YXJ0CQkJLy8NCj4gPiBQ
b2ludGVyVG9SYXdEYXRhDQo+ID4gKw0KPiA+ICsJLmxvbmcJMAkJCQkJLy8NCj4gPiBQb2ludGVy
VG9SZWxvY2F0aW9ucw0KPiA+ICsJLmxvbmcJMAkJCQkJLy8NCj4gPiBQb2ludGVyVG9MaW5lTnVt
YmVycw0KPiA+ICsJLnNob3J0CTAJCQkJCS8vDQo+ID4gTnVtYmVyT2ZSZWxvY2F0aW9ucw0KPiA+
ICsJLnNob3J0CTAJCQkJCS8vDQo+ID4gTnVtYmVyT2ZMaW5lTnVtYmVycw0KPiA+ICsJLmxvbmcJ
SU1BR0VfU0NOX0NOVF9JTklUSUFMSVpFRF9EQVRBIHwgXA0KPiA+ICsJCUlNQUdFX1NDTl9NRU1f
UkVBRCB8IFwNCj4gPiArCQlJTUFHRV9TQ05fTUVNX1dSSVRFCQkJLy8gQ2hhcmFjdGVyaXN0aWNz
DQo+ID4gKw0KPiA+ICsJLnNldAlzZWN0aW9uX2NvdW50LCAoLiAtIHNlY3Rpb25fdGFibGUpIC8g
NDANCj4gPiArDQo+ID4gK2VmaV9oZWFkZXJfZW5kOg0KPiA+ICsJLmVuZG0NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TIGIvYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5T
DQo+ID4gaW5kZXggOThhNDA2NDc0ZTdkLi5kZGQ2MTNkYWM5ZDYgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvaGVh
ZC5TDQo+ID4gQEAgLTEzLDYgKzEzLDcgQEANCj4gPiAgI2luY2x1ZGUgPGFzbS9jc3IuaD4NCj4g
PiAgI2luY2x1ZGUgPGFzbS9od2NhcC5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL2ltYWdlLmg+DQo+
ID4gKyNpbmNsdWRlICJlZmktaGVhZGVyLlMiDQo+ID4gDQo+ID4gIF9fSEVBRA0KPiA+ICBFTlRS
WShfc3RhcnQpDQo+ID4gQEAgLTIyLDEwICsyMywxOCBAQCBFTlRSWShfc3RhcnQpDQo+ID4gIAkg
KiBEbyBub3QgbW9kaWZ5IGl0IHdpdGhvdXQgbW9kaWZ5aW5nIHRoZSBzdHJ1Y3R1cmUgYW5kIGFs
bA0KPiA+IGJvb3Rsb2FkZXJzDQo+ID4gIAkgKiB0aGF0IGV4cGVjdHMgdGhpcyBoZWFkZXIgZm9y
bWF0ISENCj4gPiAgCSAqLw0KPiA+ICsjaWZkZWYgQ09ORklHX0VGSQ0KPiA+ICsJLyoNCj4gPiAr
CSAqIFRoaXMgaW5zdHJ1Y3Rpb24gZGVjb2RlcyB0byAiTVoiIEFTQ0lJIHJlcXVpcmVkIGJ5IFVF
RkkuDQo+ID4gKwkgKi8NCj4gPiArCWxpIHM0LC0xMw0KPiANCj4gVGhpcyBuZWVkcyB0byBiZSBh
IGMubGkgaW4gb3JkZXIgdG8gZW5jb2RlIGFzICJNWiIuICBJdCdkIGJlIGNsZWFuZXINCj4gdG8N
Cj4gZXhwbGljaXRseSB3cml0ZSBpdCB0aGF0IHdheSByYXRoZXIgdGhhdCBoYXZpbmcgdGhlIGFz
c2VtYmxlcg0KPiB0cmFuc3BhcmVudGx5DQo+IGNvbXByZXNzIGl0LCBidXQgd2UgZGVmaW5hdGVs
eSBuZWVkIHRvIGhhdmUgS2NvbmZpZyBtYWtlIEVGSSBzZWxlY3QNCj4gSVNBX0MuDQo+IA0KDQpT
dXJlLiBJIHdpbGwgYWRkIHRoYXQuDQoNCj4gPiArCWogX3N0YXJ0X2tlcm5lbA0KPiA+ICsjZWxz
ZQ0KPiA+ICAJLyoganVtcCB0byBzdGFydCBrZXJuZWwgKi8NCj4gPiAgCWogX3N0YXJ0X2tlcm5l
bA0KPiA+ICAJLyogcmVzZXJ2ZWQgKi8NCj4gPiAgCS53b3JkIDANCj4gPiArI2VuZGlmDQo+ID4g
IAkuYmFsaWduIDgNCj4gPiAgI2lmIF9fcmlzY3ZfeGxlbiA9PSA2NA0KPiA+ICAJLyogSW1hZ2Ug
bG9hZCBvZmZzZXQoMk1CKSBmcm9tIHN0YXJ0IG9mIFJBTSAqLw0KPiA+IEBAIC00Myw3ICs1Miwx
NCBAQCBFTlRSWShfc3RhcnQpDQo+ID4gIAkuYXNjaWkgUklTQ1ZfSU1BR0VfTUFHSUMNCj4gPiAg
CS5iYWxpZ24gNA0KPiA+ICAJLmFzY2lpIFJJU0NWX0lNQUdFX01BR0lDMg0KPiA+ICsjaWZkZWYg
Q09ORklHX0VGSQ0KPiA+ICsJLndvcmQgcGVfaGVhZF9zdGFydCAtIF9zdGFydA0KPiA+ICtwZV9o
ZWFkX3N0YXJ0Og0KPiA+ICsNCj4gPiArCV9fRUZJX1BFX0hFQURFUg0KPiA+ICsjZWxzZQ0KPiA+
ICAJLndvcmQgMA0KPiA+ICsjZW5kaWYNCj4gPiANCj4gPiAgLmFsaWduIDINCj4gPiAgI2lmZGVm
IENPTkZJR19NTVUNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaW1hZ2UtdmFy
cy5oDQo+ID4gYi9hcmNoL3Jpc2N2L2tlcm5lbC9pbWFnZS12YXJzLmgNCj4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYmQ4Yjc2NGYwYWQ5DQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2ltYWdlLXZhcnMuaA0KPiA+
IEBAIC0wLDAgKzEsNTMgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seSAqLw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjAgV2VzdGVybiBE
aWdpdGFsIENvcnBvcmF0aW9uIG9yIGl0cw0KPiA+IGFmZmlsaWF0ZXMuDQo+ID4gKyAqIExpbmtl
ciBzY3JpcHQgdmFyaWFibGVzIHRvIGJlIHNldCBhZnRlciBzZWN0aW9uIHJlc29sdXRpb24sIGFz
DQo+ID4gKyAqIGxkLmxsZCBkb2VzIG5vdCBsaWtlIHZhcmlhYmxlcyBhc3NpZ25lZCBiZWZvcmUg
U0VDVElPTlMgaXMNCj4gPiBwcm9jZXNzZWQuDQo+ID4gKyAqIEJhc2VkIG9uIGFyY2gvYXJtNjQv
a2VybmUvaW1hZ2UtdmFycy5oDQo+ID4gKyAqLw0KPiA+ICsjaWZuZGVmIF9fUklTQ1ZfS0VSTkVM
X0lNQUdFX1ZBUlNfSA0KPiA+ICsjZGVmaW5lIF9fUklTQ1ZfS0VSTkVMX0lNQUdFX1ZBUlNfSA0K
PiA+ICsNCj4gPiArI2lmbmRlZiBMSU5LRVJfU0NSSVBUDQo+ID4gKyNlcnJvciBUaGlzIGZpbGUg
c2hvdWxkIG9ubHkgYmUgaW5jbHVkZWQgaW4gdm1saW51eC5sZHMuUw0KPiA+ICsjZW5kaWYNCj4g
PiArDQo+ID4gKyNpZmRlZiBDT05GSUdfRUZJDQo+ID4gKw0KPiA+ICtfX2VmaXN0dWJfc3RleHRf
b2Zmc2V0ID0gX3N0YXJ0X2tlcm5lbCAtIF9zdGFydDsNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAq
IFRoZSBFRkkgc3R1YiBoYXMgaXRzIG93biBzeW1ib2wgbmFtZXNwYWNlIHByZWZpeGVkIGJ5DQo+
ID4gX19lZmlzdHViXywgdG8NCj4gPiArICogaXNvbGF0ZSBpdCBmcm9tIHRoZSBrZXJuZWwgcHJv
cGVyLiBUaGUgZm9sbG93aW5nIHN5bWJvbHMgYXJlDQo+ID4gbGVnYWxseQ0KPiA+ICsgKiBhY2Nl
c3NlZCBieSB0aGUgc3R1Yiwgc28gcHJvdmlkZSBzb21lIGFsaWFzZXMgdG8gbWFrZSB0aGVtDQo+
ID4gYWNjZXNzaWJsZS4NCj4gPiArICogT25seSBpbmNsdWRlIGRhdGEgc3ltYm9scyBoZXJlLCBv
ciB0ZXh0IHN5bWJvbHMgb2YgZnVuY3Rpb25zDQo+ID4gdGhhdCBhcmUNCj4gPiArICogZ3VhcmFu
dGVlZCB0byBiZSBzYWZlIHdoZW4gZXhlY3V0ZWQgYXQgYW5vdGhlciBvZmZzZXQgdGhhbiB0aGV5
DQo+ID4gd2VyZQ0KPiA+ICsgKiBsaW5rZWQgYXQuIFRoZSByb3V0aW5lcyBiZWxvdyBhcmUgYWxs
IGltcGxlbWVudGVkIGluIGFzc2VtYmxlcg0KPiA+IGluIGENCj4gPiArICogcG9zaXRpb24gaW5k
ZXBlbmRlbnQgbWFubmVyDQo+ID4gKyAqLw0KPiA+ICtfX2VmaXN0dWJfbWVtY21wCQk9IG1lbWNt
cDsNCj4gPiArX19lZmlzdHViX21lbWNocgkJPSBtZW1jaHI7DQo+ID4gK19fZWZpc3R1Yl9tZW1j
cHkJCT0gbWVtY3B5Ow0KPiA+ICtfX2VmaXN0dWJfbWVtbW92ZQkJPSBtZW1tb3ZlOw0KPiA+ICtf
X2VmaXN0dWJfbWVtc2V0CQk9IG1lbXNldDsNCj4gPiArX19lZmlzdHViX3N0cmxlbgkJPSBzdHJs
ZW47DQo+ID4gK19fZWZpc3R1Yl9zdHJubGVuCQk9IHN0cm5sZW47DQo+ID4gK19fZWZpc3R1Yl9z
dHJjbXAJCT0gc3RyY21wOw0KPiA+ICtfX2VmaXN0dWJfc3RybmNtcAkJPSBzdHJuY21wOw0KPiA+
ICtfX2VmaXN0dWJfc3RycmNocgkJPSBzdHJyY2hyOw0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJ
R19LQVNBTg0KPiA+ICtfX2VmaXN0dWJfX19tZW1jcHkJCT0gbWVtY3B5Ow0KPiA+ICtfX2VmaXN0
dWJfX19tZW1tb3ZlCQk9IG1lbW1vdmU7DQo+ID4gK19fZWZpc3R1Yl9fX21lbXNldAkJPSBtZW1z
ZXQ7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiArX19lZmlzdHViX19zdGFydAkJPSBfc3RhcnQ7
DQo+ID4gK19fZWZpc3R1Yl9fc3RhcnRfa2VybmVsCQk9IF9zdGFydF9rZXJuZWw7DQo+ID4gK19f
ZWZpc3R1Yl9fZW5kCQkJPSBfZW5kOw0KPiA+ICtfX2VmaXN0dWJfX2VkYXRhCQk9IF9lZGF0YTsN
Cj4gPiArX19lZmlzdHViX3NjcmVlbl9pbmZvCQk9IHNjcmVlbl9pbmZvOw0KPiA+ICsNCj4gPiAr
I2VuZGlmDQo+ID4gKw0KPiA+ICsjZW5kaWYgLyogX19SSVNDVl9LRVJORUxfSU1BR0VfVkFSU19I
ICovDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3ZtbGludXgubGRzLlMNCj4g
PiBiL2FyY2gvcmlzY3Yva2VybmVsL3ZtbGludXgubGRzLlMNCj4gPiBpbmRleCAwMzM5YjZiYmUx
MWEuLjIwZWJmN2U4YzIxNSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC92bWxp
bnV4Lmxkcy5TDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvdm1saW51eC5sZHMuUw0KPiA+
IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gICNpbmNsdWRlIDxhc20vY2FjaGUuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGFzbS90aHJlYWRfaW5mby5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL3NldF9tZW1vcnku
aD4NCj4gPiArI2luY2x1ZGUgImltYWdlLXZhcnMuaCINCj4gPiANCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L3NpemVzLmg+DQo+ID4gIE9VVFBVVF9BUkNIKHJpc2N2KQ0KPiA+IEBAIC0xNyw2ICsxOCwx
NCBAQCBFTlRSWShfc3RhcnQpDQo+ID4gDQo+ID4gIGppZmZpZXMgPSBqaWZmaWVzXzY0Ow0KPiA+
IA0KPiA+ICtQRUNPRkZfRklMRV9BTElHTk1FTlQgPSAweDIwMDsNCj4gPiArI2lmZGVmIENPTkZJ
R19FRkkNCj4gPiArI2RlZmluZSBQRUNPRkZfRURBVEFfUEFERElORwlcDQo+ID4gKwkucGVjb2Zm
X2VkYXRhX3BhZGRpbmcgOiB7IEJZVEUoMCk7IC4gPQ0KPiA+IEFMSUdOKFBFQ09GRl9GSUxFX0FM
SUdOTUVOVCk7IH0NCj4gPiArI2Vsc2UNCj4gPiArI2RlZmluZSBQRUNPRkZfRURBVEFfUEFERElO
Rw0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gIFNFQ1RJT05TDQo+ID4gIHsNCj4gPiAgCS8qIEJl
Z2lubmluZyBvZiBjb2RlIGFuZCB0ZXh0IHNlZ21lbnQgKi8NCj4gPiBAQCAtNjIsNiArNzEsOCBA
QCBTRUNUSU9OUw0KPiA+ICAJCV9ldGV4dCA9IC47DQo+ID4gIAl9DQo+ID4gDQo+ID4gKwlfX3Rl
eHRfZW5kID0gLjsNCj4gPiArDQo+ID4gIAkvKiBTdGFydCBvZiBkYXRhIHNlY3Rpb24gKi8NCj4g
PiAgCV9zZGF0YSA9IC47DQo+ID4gIAlST19EQVRBKFNFQ1RJT05fQUxJR04pDQo+ID4gQEAgLTc4
LDkgKzg5LDEyIEBAIFNFQ1RJT05TDQo+ID4gIAkuc2RhdGEgOiB7DQo+ID4gIAkJX19nbG9iYWxf
cG9pbnRlciQgPSAuICsgMHg4MDA7DQo+ID4gIAkJKiguc2RhdGEqKQ0KPiA+IC0JCS8qIEVuZCBv
ZiBkYXRhIHNlY3Rpb24gKi8NCj4gPiAtCQlfZWRhdGEgPSAuOw0KPiA+ICAJfQ0KPiA+ICsJUEVD
T0ZGX0VEQVRBX1BBRERJTkcNCj4gPiArCV9fZGF0YV9yYXdfc2l6ZSA9IEFCU09MVVRFKC4gLSBf
X3RleHRfZW5kKTsNCj4gPiArDQo+ID4gKwkvKiBFbmQgb2YgZGF0YSBzZWN0aW9uICovDQo+ID4g
KwlfZWRhdGEgPSAuOw0KPiA+IA0KPiA+ICAJQlNTX1NFQ1RJT04oUEFHRV9TSVpFLCBQQUdFX1NJ
WkUsIDApDQo+ID4gDQo+ID4gQEAgLTg4LDYgKzEwMiw4IEBAIFNFQ1RJT05TDQo+ID4gIAkJKigu
cmVsLmR5biopDQo+ID4gIAl9DQo+ID4gDQo+ID4gKwlfX2RhdGFfdmlydF9zaXplID0gQUJTT0xV
VEUoLiAtIF9fdGV4dF9lbmQpOw0KPiA+ICsNCj4gPiAgCV9lbmQgPSAuOw0KPiA+IA0KPiA+ICAJ
U1RBQlNfREVCVUcNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
