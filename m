Return-Path: <linux-efi+bounces-84-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920757F585C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 07:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B613D1C20C7D
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75187F9D5;
	Thu, 23 Nov 2023 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="ADTqe1Cw"
X-Original-To: linux-efi@vger.kernel.org
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2083.outbound.protection.outlook.com [40.107.9.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86D18E;
	Wed, 22 Nov 2023 22:37:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUr8rtOLqRI/jkcFP4uqOiRRu3AHjbDRFUnYfTVi7HKEt3Jc3niyDOjdhVUNAJQDqHGhYiVLLitUW81EKPNEM2/9oBbNX40H++A7AwY1zPJYRrmDfs4Asf4scPPirB3t7Pbjivu2udxD4/ROdvZxP3Xh6fe2yP1eCkB9HBD4b8bxmcdiQoE1/SdxQvCB0EFAfOGEDcvdxEtarGbOYmLRYCTUa/DH+rIIURpYQgWaGE+HV5Z9bpps7vOphnz5Mni4n9iUIjoM8G94Um/V6bjXEVdGtsOVjPvGJbKC+NAv71rzhPuY/Pkq3jetQD9vSxeYyl+14y6RKbiOgiwPw7kewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDS9IvaGMmja38sbWH3oTOmJ13dAU+VaWmyU1e1gjqQ=;
 b=nnVP12wTvXqomHKDsMyfMraFp2g+eI0kBZSUfB9NSymzHgTpi0oMvVGqojQ6Lw52+xyImPYnk2wGhmRmTgtezca3lcxQfS8giBYknG2zxz+LK3BmE5sIIjSRc5jSsDybHvsolQZID5FMG0rJWYp9kaHlEncwM3b0JfPx1gKJw6SOr4aA+c2sga8Y+2rmoszKejHj697wec8On189M4KgjmAPAGyz/yxmP5zLg/Jcr3XebLytJqmDEWK35nD/E8CFS6L/aWOu7v5CzFDGe4YGKqByJsy+9Fub/f38uRPNjpicw55dYQViELLl9u6hKqjQuhbS53gjoVF1Wu7rhxVGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDS9IvaGMmja38sbWH3oTOmJ13dAU+VaWmyU1e1gjqQ=;
 b=ADTqe1CwwnmLPs3zkebMDRTcnAHVfqpYQ5u2ieIVhcrx+peJ12497Snv2asMqD05FrxEWysIKEj147QWEsWEUPmO8ND2ZqJVoKasP1tbQNnVpy44NOFXfmQiNm+y+h0MH53bPVjjYweHEpjsjpDJ9pzAhnELo2FHO0ZwB2+zwMSIsQOtQXS+jTTXyzg+VliqZO6tn33jLwvJlTlYiMST8+2RDCsoFetw8yv0JT8N3YvjmQM2C+COVFK9upF6FGhBLfwIDqaxDWbUQCEKFU3+PudzxrZ3eQwhp8yFS2Ah53kXa5DbYLV9aaK6GLgUB6ovIJhQBlkhYNetIjrhLNNreA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3413.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.13; Thu, 23 Nov
 2023 06:37:35 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97%3]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 06:37:35 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>, Rob
 Herring <robh@kernel.org>, Daniel Gimpelevich
	<daniel@gimpelevich.san-francisco.ca.us>, Andrew Morton
	<akpm@linux-foundation.org>, Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>, Sean Anderson
	<sean.anderson@seco.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>, Ard
 Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic
 commandline
Thread-Topic: [PATCH 5/8] drivers: firmware: efi: libstub: enable generic
 commandline
Thread-Index: AQHaE3aeWi8KkkUdskeG8oAN5CskA7CHiCcA
Date: Thu, 23 Nov 2023 06:37:35 +0000
Message-ID: <e27b12bc-1d33-444f-938b-6cf0d27d8206@csgroup.eu>
References: <20231110013817.2378507-1-danielwa@cisco.com>
 <20231110013817.2378507-6-danielwa@cisco.com>
In-Reply-To: <20231110013817.2378507-6-danielwa@cisco.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3413:EE_
x-ms-office365-filtering-correlation-id: c59396dd-5b61-4139-6c25-08dbebeeada1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w0qMn05AKQjB8a+IazZ9HN0+fwVokQH7RvScyYB865NNrb1ozAgUyCyHpVylFgNqvjNT1lzkloL9XMdvFwqpclyX3+Zeo7AlD3UfdJjBCHamkXanoaFjNXtwOhq7RZc30YVZKEYKrWYUasBJADoJ48YBAN426RVP9c6YYmvmJI+k2GfKmqzegSMXdj3X5wksSpQysIfXi2uP237YeH9aIxMv2YPF1AYqlm/6uXWUWlJshy4nqR4VFDyYrAOJLcf9s0C5fHMxF+VhAdqnbl7DWwLF8FNTvhw9jW1LVpPMzVHCyQXHgXOJ6ff4b1Dn2Donm6cajD54BUTK7RG/xJWRjJyUA5mb3vMk5K44BP1+WF/JN/qQUvD3dnjAJgfV8KoUatyLwg0ilIKHzvS1G7QQWyzj1mlNhvKTvxmPkwtrqyt/kBmX+JBDOXkPOmRdfnXOS/vU9ZsTn7mqAEXIBUbqit98y6nLMpzzqp1A1UdvXhGWzhiNHnwwwux39k4+l2tkchlHrZurUvzL9DpH5v4/p27jXbqjiID2PPXMSs62/BNIq8+lZXzMqXpjdaaEXNfF2yIVC/S+dULnGA2fBa4g5dpocpNbAzZoxsJpdXZl/p8PHgds4qZLxfFXSQtj5CHBNOaGGX7Aoz19lqH1VqQ1EYZAh3dwHfz4AdXYLuqTURJk2P7wF3iFB9GqFzLXnthTgoqluXTd+qUtIqkp7s9TIYf9K0Em5EYmOutex/h0Et6WGNQqisLGWTO5PQ4uxNxfYQLkybEpFm/3EY6FHNu/bA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(66574015)(6512007)(71200400001)(6506007)(83380400001)(7416002)(5660300002)(2906002)(44832011)(41300700001)(76116006)(91956017)(110136005)(6486002)(478600001)(66946007)(4326008)(64756008)(8676002)(8936002)(54906003)(66446008)(66476007)(66556008)(316002)(122000001)(38100700002)(921008)(38070700009)(36756003)(31696002)(86362001)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uy9yRG5VRDhMdnVVQVE3clc1L2gxVjVWKy9ZdXM5Y09sc1lQbFNFOGhkS1NV?=
 =?utf-8?B?M2VNYmZnWFBmaWY2T1RkbkJqRTQ0MVk5MHpBK2xXYmFEY2wrTVprblk3ZFA5?=
 =?utf-8?B?K2tQcVlTWFJIZEgrOHY4bWtiWGVkd3ZGVHZTTnVYK2I4U3dKRXU3MnduUTY4?=
 =?utf-8?B?ZzNUSk1yRFFnVkVoNll4TEpLVDRsaHhJMy9aNFczRE9SYTRrbXVEQ3NCVTZk?=
 =?utf-8?B?SmgzMmd5VkcrNmI2UG1DNUFGR3hXdnQ0SjIxNURRU0Z5MjR5S3locnZTSTg4?=
 =?utf-8?B?RUlHajZ6TkR4TjdCd0FwQTZWcWREQmxkY1lLNGI1SkgzMjNPdWVSbzJWNllW?=
 =?utf-8?B?Tnk0aGx4N2h1SFplSDBUVHpzaCt6ajk1S3o0SGlxTWFlc1NPU0Q0YXBZNWti?=
 =?utf-8?B?RnFYTEtVM3R2M04rUXZBL21CSlN2QnRReTRoSC9oM0t3UTZuR3NxbnVJMTRZ?=
 =?utf-8?B?WCtKeVh2a0VvRVAxY041WFpsYVRvanhCYlFUaFlyQkNHKzFTMW5yZzlrQnZM?=
 =?utf-8?B?V0ZJT0gxVmIyd0RoS29UOFBETXFpOTc2bkk0MnVmWGU4eUhKN1dqejhNWi9M?=
 =?utf-8?B?VnVqekxuZnZveVAySm03R05RbkMvYzZncnk5RXd2V0l3UGFOK2lORFJHNGRw?=
 =?utf-8?B?KzlKM280UnZoT283T3lZcVNSSmZRbWlxUnFwRVAxK3d5eHFERzZHMWI3d2xD?=
 =?utf-8?B?d3pZV1pTRm10SmZtTmQxa24rM2VRZ2EvZmZuOVZPVENCNW1ZUi9PQU52WWRi?=
 =?utf-8?B?S2VyNmRrc2FpZWlOUGpMa21EaVpBUzVRKysyYWV2VjViTHZvV3NIOUNUdUxo?=
 =?utf-8?B?ZUVaQlFmQlZHeDVqbW1vMGhoTTJqa29MOThUR3JybTBtZmpwVUozKzhsNzNK?=
 =?utf-8?B?RmkxYnVndlV0aVg1NC93QkM5VDBYTk9nekE3WVdjN0RVRkkraXZiZW10S05k?=
 =?utf-8?B?SmpRaHNUZWpFRTNlQjFIc0FUMlVIdllwbHBjRG14aEVNbUJYbUovVGwvblZk?=
 =?utf-8?B?cXJQaTBsaSt5UXdwYzBCUnE5RGZTcEtqeG9SSktHVkJLSERJaXVaZVoxck16?=
 =?utf-8?B?ZVN4ZFlJWkwxUzVGQ09oeE5naGNXa2FGaFYyTHRUd0RPNE42QXZ0end4ME1p?=
 =?utf-8?B?dUxjeW5mTXRpeTlUVHV6L1BhRmV3WW9BRlM2Mzd0c0YxMEJUMm5lTDJlUEk3?=
 =?utf-8?B?YmdReWh0RlVRMFNFRWtYMTFxWHJCc21KZnZKZUMxSmx6Q3QzN1JBZThsL3VB?=
 =?utf-8?B?dnAzZnlrSFhwd0oxZ2pNanp3Nyt5TTdrUElGWlE1ZDByYzQ5UGhzVkhzaHFm?=
 =?utf-8?B?YmhhWlJkNUk2dWl4T0RaVTJSek9qV2M0Tm1jLy9zY203VVhEQnQ0WHg3MjV0?=
 =?utf-8?B?blRFWVJxQjZuK3I4TFBBU1oxRFNYcWpTcUxRZ241VFA2eCtsajhjSUF5dlBl?=
 =?utf-8?B?NFE0STM3V0xCN2dVQ2pNQlFWYUkwUGpzYlB3Q3c0Y0RvdFIvRERzb292YU9G?=
 =?utf-8?B?T001TW81T1YvbzRBZElSQkMrUlpjVWpHN2IvN3c0Y2prT3V1SktrTXg1bm8y?=
 =?utf-8?B?cHArMkdKcXZKcU9lYXpGUlh2OHVEZzhhR0ZSQWtteUgwcW9GcVYxRjVvaExK?=
 =?utf-8?B?SGc3bnBwWUp0NUV2MG52WWNRYXh5cVhTMCszdGtaVjNoUWNndDYyTWVKTDh3?=
 =?utf-8?B?emVVeUNhanAySVZkTGRVS0hqRlczV2xwa3RmblNyMEVVMmN0VkRhYlIrRjhK?=
 =?utf-8?B?ZytscHZ3bGE1ZUZYVHZ4cVlZTVlndmRnbDRBWnZrNms5eXN5UFdib0xTdFVF?=
 =?utf-8?B?WE9Nd1pHNk4rbDdXN2NnVzNaV0U1OSswNUZCZEZlZzV0Z2FaYTAvM2VZSzNV?=
 =?utf-8?B?bDdBRTJNQVhEbDFxZjlpbGtOLzcrLzFYQzcyd1RpS2t2WXBRZDM3RERXeHhl?=
 =?utf-8?B?SEZrWktoQXpVVjBnQU5FS0lXVTExWUo2RkFtaVFaeDltRGp4WlNCc3duRWwz?=
 =?utf-8?B?YU5KVHlqY3RZTkZZbWhNYTIvRVFjY05KVDNxa2c5TUx0SzdSMm83ZlMzcTh5?=
 =?utf-8?B?UDBhTDNBUWpRZ2ZBYWQxcGRvRjJqZkkxM1NLbGxGWWgwdmE5YkhLN0hWdXZN?=
 =?utf-8?Q?jYPIg7HHKRokFZ6VfjtFwWyux?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B0CCF1281CF9B4596EEAF7AB5471E08@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c59396dd-5b61-4139-6c25-08dbebeeada1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 06:37:35.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttOIH6ljuYJM+yLXNKkSi/h+PXinOa0gJ4yb8hfAvztfC1LVEgBfBriGAtVmOyPdgoAT5k7X8h/8YEmKxpzuQH5feuB6PuoHaSC4eD1eqgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3413

DQoNCkxlIDEwLzExLzIwMjMgw6AgMDI6MzgsIERhbmllbCBXYWxrZXIgYSDDqWNyaXTCoDoNCj4g
VGhpcyBhZGRzIGNvZGUgdG8gaGFuZGxlIHRoZSBnZW5lcmljIGNvbW1hbmQgbGluZSBjaGFuZ2Vz
Lg0KPiBUaGUgZWZpIGNvZGUgYXBwZWFycyB0aGF0IGl0IGRvZXNuJ3QgYmVuZWZpdCBhcyBtdWNo
IGZyb20gdGhpcyBkZXNpZ24NCj4gYXMgaXQgY291bGQuDQoNClNvIHdoYXQgY2FuIHdlIGRvIHRv
IGltcHJvdmUgdGhhdCA/DQoNCg0KPiANCj4gRm9yIGV4YW1wbGUsIGlmIHlvdSBoYWQgYSBwcmVw
ZW5kIGNvbW1hbmQgbGluZSB3aXRoICJub2thc2xyIiB0aGVuDQo+IHlvdSBtaWdodCBiZSBoZWxw
ZnVsIHRvIHJlLWVuYWJsZSBpdCBpbiB0aGUgYm9vdCBsb2FkZXIgb3IgZHRzLA0KDQpzL3lvdS9p
dA0KDQo+IGJ1dCB0aGVyZSBhcHBlYXJzIHRvIGJlIG5vIHdheSB0byByZS1lbmFibGUga2FzbHIg
b3Igc29tZSBvZiB0aGUNCj4gb3RoZXIgb3B0aW9ucy4NCj4gDQo+IFRoZSBlZmkgY29tbWFuZCBs
aW5lIGhhbmRsaW5nIGlzIGluY29ycmVjdC4geDg2IGFuZCBhcm0gaGF2ZSBhbiBhcHBlbmQNCj4g
c3lzdGVtIGhvd2V2ZXIgdGhlIGVmaSBjb2RlIHByZXBlbmRzIHRoZSBjb21tYW5kIGxpbmUuDQo+
IA0KPiBGb3IgZXhhbXBsZSwgeW91IGNvdWxkIGhhdmUgYSBub24tdXBncmFkYWJsZSBiaW9zIHdo
aWNoIHNlbmRzDQo+IA0KPiBlZmk9ZGlzYWJsZV9lYXJseV9wY2lfZG1hDQo+IA0KPiBUaGlzIGh5
cG90aGV0aWNhbGx5IGNvdWxkIGhhdmUgYmVlbiBzZXQgYmVjYXVzZSBlYXJseSBwY2kgZG1hIGNh
dXNlZA0KPiBpc3N1ZXMgb24gZWFybHkgdmVyc2lvbnMgb2YgdGhlIHByb2R1Y3QuDQo+IA0KPiBU
aGVuIGxhdGVyIHRoZSBlYXJseSBwY2kgZG1hIHdhcyBtYWRlIHRvIHdvcmsgYW5kIHRoZSBjb21w
YW55IGRlc2lyZWQNCj4gdG8gc3RhcnQgdXNpbmcgaXQuIFRvIG92ZXJyaWRlIHRoZSBiaW9zIHlv
dSBjb3VsZCBzZXQgdGhlIENPTkZJR19DTURMSU5FDQo+IHRvLA0KPiANCj4gZWZpPW5vX2Rpc2Fi
bGVfZWFybHlfcGNpX2RtYQ0KPiANCj4gdGhlbiBwYXJzaW5nIHdvdWxkIG5vcm1hbGx5IHN0YXJ0
IHdpdGggdGhlIGJpb3MgY29tbWFuZCBsaW5lLCB0aGVuIG1vdmUNCj4gdG8gdGhlIENPTkZJR19D
TURMSU5FIGFuZCB5b3Ugd291bGQgZW5kIHVwIHdpdGggZWFybHkgcGNpIGRtYSB0dXJuZWQgb24u
DQo+IA0KPiBob3dldmVyLCBjdXJyZW50IGVmaSBjb2RlIGtlZXBzIGVhcmx5IHBjaSBkbWEgb2Zm
IGJlY2F1c2UgdGhlIGJpb3MNCj4gYXJndW1lbnRzIGFsd2F5cyBvdmVycmlkZSB0aGUgYnVpbHQg
aW4uDQo+IA0KPiBQZXIgbXkgcmVhZGluZyB0aGlzIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBtYWlu
IGJvZHkgb2YgeDg2LCBhcm0sIGFuZA0KPiBhcm02NC4NCj4gDQo+IFRoZSBnZW5lcmljIGNvbW1h
bmQgbGluZSBwcm92aWRlcyBib3RoIGFwcGVuZCBhbmQgcHJlcGVuZCwgc28gaXQNCj4gYWxsZXZp
YXRlcyB0aGlzIGlzc3VlIGlmIGl0J3MgdXNlZC4gSG93ZXZlciBub3QgYWxsIGFyY2hpdGVjdHVy
ZXMgdXNlDQo+IGl0Lg0KPiANCj4gSXQgd291bGQgYmUgZGVzaXJhYmxlIHRvIGFsbG93IHRoZSBl
Zmkgc3R1YiB0byBoYXZlIGl0J3MgYnVpbHRpbiBjb21tYW5kDQo+IGxpbmUgdG8gYmUgbW9kaWZp
ZWQgYWZ0ZXIgY29tcGlsZSwgYnV0IEkgZG9uJ3Qgc2VlIGEgZmVhc2libGUgd2F5IHRvIGRvDQo+
IHRoYXQgY3VycmVudGx5Lg0KDQpXb3VsZCBiZSBkZXNpcmFibGUgb3IgaXMgZGVzaXJhYmxlID8g
WW91ciBleHBsYW5hdGlvbnMgYXJlIHVuY2xlYXIuDQoNCg0KPiANCj4gQ2M6IHhlLWxpbnV4LWV4
dGVybmFsQGNpc2NvLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2Fsa2VyIDxkYW5pZWx3
YUBjaXNjby5jb20+DQo+IC0tLQ0KPiAgIC4uLi9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1
Yi1oZWxwZXIuYyAgICB8IDI5ICsrKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL2Zpcm13
YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLmMgICAgICAgfCAgOSArKysrKysNCj4gICBkcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaXN0dWIuaCAgICAgICAgfCAgMSArDQo+ICAgZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jICAgICAgIHwgMTQgKysrKysrKy0tDQo+
ICAgNCBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItaGVs
cGVyLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLWhlbHBlci5jDQo+
IGluZGV4IGJmYTMwNjI1ZjVkMC4uOTUyZmEyY2RmZjUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1zdHViLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMv
ZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItaGVscGVyLmMNCj4gQEAgLTExLDYgKzExLDcg
QEANCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvZWZpLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2NtZGxpbmUuaD4NCj4gICAjaW5jbHVkZSA8
YXNtL2VmaS5oPg0KPiAgICNpbmNsdWRlIDxhc20vc2V0dXAuaD4NCj4gICANCj4gQEAgLTI5LDYg
KzMwLDM0IEBAIGJvb2wgX19wdXJlIF9fZWZpX3NvZnRfcmVzZXJ2ZV9lbmFibGVkKHZvaWQpDQo+
ICAgCXJldHVybiAhZWZpX25vc29mdHJlc2VydmU7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsg
KiBlZmlfaGFuZGxlX2NtZGxpbmUoKSAtIGhhbmRsZSBhZGRpbmcgaW4gYnVpbHQtaW4gcGFydHMg
b2YgdGhlIGNvbW1hbmQgbGluZQ0KPiArICogQGNtZGxpbmU6CWtlcm5lbCBjb21tYW5kIGxpbmUN
Cj4gKyAqDQo+ICsgKiBBZGQgaW4gdGhlIGdlbmVyaWMgcGFydHMgb2YgdGhlIGNvbW1hbmRsaW5l
IGFuZCBzdGFydCB0aGUgcGFyc2luZyBvZiB0aGUNCj4gKyAqIGNvbW1hbmQgbGluZS4NCj4gKyAq
DQo+ICsgKiBSZXR1cm46CXN0YXR1cyBjb2RlDQo+ICsgKi8NCj4gK2VmaV9zdGF0dXNfdCBlZmlf
aGFuZGxlX2J1aWx0aW5fY21kbGluZShjaGFyIGNvbnN0ICpjbWRsaW5lKQ0KPiArew0KPiArCWVm
aV9zdGF0dXNfdCBzdGF0dXMgPSBFRklfU1VDQ0VTUzsNCj4gKw0KPiArCWlmIChzaXplb2YoQ01E
TElORV9TVEFUSUNfUFJFUEVORCkgPiAxKQ0KPiArCQlzdGF0dXMgfD0gZWZpX3BhcnNlX29wdGlv
bnMoQ01ETElORV9TVEFUSUNfUFJFUEVORCk7DQo+ICsNCj4gKwlpZiAoIUlTX0VOQUJMRUQoQ09O
RklHX0NNRExJTkVfT1ZFUlJJREUpKQ0KPiArCQlzdGF0dXMgfD0gZWZpX3BhcnNlX29wdGlvbnMo
Y21kbGluZSk7DQo+ICsNCj4gKwlpZiAoc2l6ZW9mKENNRExJTkVfU1RBVElDX0FQUEVORCkgPiAx
KQ0KPiArCQlzdGF0dXMgfD0gZWZpX3BhcnNlX29wdGlvbnMoQ01ETElORV9TVEFUSUNfQVBQRU5E
KTsNCj4gKw0KPiArCWlmIChzdGF0dXMgIT0gRUZJX1NVQ0NFU1MpDQo+ICsJCWVmaV9lcnIoIkZh
aWxlZCB0byBwYXJzZSBvcHRpb25zXG4iKTsNCj4gKw0KPiArCXJldHVybiBzdGF0dXM7DQo+ICt9
DQo+ICsNCj4gICAvKioNCj4gICAgKiBlZmlfcGFyc2Vfb3B0aW9ucygpIC0gUGFyc2UgRUZJIGNv
bW1hbmQgbGluZSBvcHRpb25zDQo+ICAgICogQGNtZGxpbmU6CWtlcm5lbCBjb21tYW5kIGxpbmUN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWIuYyBi
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWIuYw0KPiBpbmRleCBmOWMxZThh
MmJkMWQuLjc3MGFiZTk1YzBlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi9lZmktc3R1Yi5jDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIv
ZWZpLXN0dWIuYw0KPiBAQCAtMTI3LDYgKzEyNywxNCBAQCBlZmlfc3RhdHVzX3QgZWZpX2hhbmRs
ZV9jbWRsaW5lKGVmaV9sb2FkZWRfaW1hZ2VfdCAqaW1hZ2UsIGNoYXIgKipjbWRsaW5lX3B0cikN
Cj4gICAJCXJldHVybiBFRklfT1VUX09GX1JFU09VUkNFUzsNCj4gICAJfQ0KPiAgIA0KPiArI2lm
ZGVmIENPTkZJR19HRU5FUklDX0NNRExJTkUNCj4gKwlzdGF0dXMgPSBlZmlfaGFuZGxlX2J1aWx0
aW5fY21kbGluZShjbWRsaW5lKTsNCj4gKwlpZiAoc3RhdHVzICE9IEVGSV9TVUNDRVNTKSB7DQo+
ICsJCWdvdG8gZmFpbF9mcmVlX2NtZGxpbmU7DQo+ICsJfQ0KPiArI2VuZGlmDQo+ICsNCj4gKyNp
ZmRlZiBDT05GSUdfQ01ETElORQ0KPiAgIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfQ01ETElORV9F
WFRFTkQpIHx8DQo+ICAgCSAgICBJU19FTkFCTEVEKENPTkZJR19DTURMSU5FX0ZPUkNFKSB8fA0K
PiAgIAkgICAgY21kbGluZV9zaXplID09IDApIHsNCj4gQEAgLTE0NCw2ICsxNTIsNyBAQCBlZmlf
c3RhdHVzX3QgZWZpX2hhbmRsZV9jbWRsaW5lKGVmaV9sb2FkZWRfaW1hZ2VfdCAqaW1hZ2UsIGNo
YXIgKipjbWRsaW5lX3B0cikNCj4gICAJCQlnb3RvIGZhaWxfZnJlZV9jbWRsaW5lOw0KPiAgIAkJ
fQ0KPiAgIAl9DQo+ICsjZW5kaWYNCj4gICANCj4gICAJKmNtZGxpbmVfcHRyID0gY21kbGluZTsN
Cj4gICAJcmV0dXJuIEVGSV9TVUNDRVNTOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvbGlic3R1Yi9lZmlzdHViLmggYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2Vm
aXN0dWIuaA0KPiBpbmRleCAyMTI2ODdjMzBkNzkuLjFhYzY2MzE5MDVjNSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmlzdHViLmgNCj4gKysrIGIvZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmlzdHViLmgNCj4gQEAgLTk5Niw2ICs5OTYsNyBAQCBl
Zmlfc3RhdHVzX3QgZWZpX3JlbG9jYXRlX2tlcm5lbCh1bnNpZ25lZCBsb25nICppbWFnZV9hZGRy
LA0KPiAgIAkJCQkgdW5zaWduZWQgbG9uZyBhbGlnbm1lbnQsDQo+ICAgCQkJCSB1bnNpZ25lZCBs
b25nIG1pbl9hZGRyKTsNCj4gICANCj4gK2VmaV9zdGF0dXNfdCBlZmlfaGFuZGxlX2J1aWx0aW5f
Y21kbGluZShjaGFyIGNvbnN0ICpjbWRsaW5lKTsNCj4gICBlZmlfc3RhdHVzX3QgZWZpX3BhcnNl
X29wdGlvbnMoY2hhciBjb25zdCAqY21kbGluZSk7DQo+ICAgDQo+ICAgdm9pZCBlZmlfcGFyc2Vf
b3B0aW9uX2dyYXBoaWNzKGNoYXIgKm9wdGlvbik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJz
dHViL3g4Ni1zdHViLmMNCj4gaW5kZXggOWQ1ZGY2ODNmODgyLi4yNzNhOGE5YzhiYmIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYw0KPiArKysg
Yi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMNCj4gQEAgLTg0Nyw2ICs4
NDcsOCBAQCB2b2lkIF9fbm9yZXR1cm4gZWZpX3N0dWJfZW50cnkoZWZpX2hhbmRsZV90IGhhbmRs
ZSwNCj4gICAJc3RydWN0IHNldHVwX2hlYWRlciAqaGRyID0gJmJvb3RfcGFyYW1zLT5oZHI7DQo+
ICAgCWNvbnN0IHN0cnVjdCBsaW51eF9lZmlfaW5pdHJkICppbml0cmQgPSBOVUxMOw0KPiAgIAl1
bnNpZ25lZCBsb25nIGtlcm5lbF9lbnRyeTsNCj4gKwl1bnNpZ25lZCBsb25nIGNtZGxpbmVfcGFk
ZHIgPSAoKHU2NCloZHItPmNtZF9saW5lX3B0ciB8DQo+ICsJCQkJICAgICAgICgodTY0KWJvb3Rf
cGFyYW1zLT5leHRfY21kX2xpbmVfcHRyIDw8IDMyKSk7DQo+ICAgCWVmaV9zdGF0dXNfdCBzdGF0
dXM7DQo+ICAgDQo+ICAgCWJvb3RfcGFyYW1zX3BvaW50ZXIgPSBib290X3BhcmFtczsNCj4gQEAg
LTg3Nyw2ICs4NzksMTQgQEAgdm9pZCBfX25vcmV0dXJuIGVmaV9zdHViX2VudHJ5KGVmaV9oYW5k
bGVfdCBoYW5kbGUsDQo+ICAgCQlnb3RvIGZhaWw7DQo+ICAgCX0NCj4gICANCj4gKyNpZmRlZiBD
T05GSUdfR0VORVJJQ19DTURMSU5FDQo+ICsJc3RhdHVzID0gZWZpX2hhbmRsZV9idWlsdGluX2Nt
ZGxpbmUoKGNoYXIgKiljbWRsaW5lX3BhZGRyKTsNCj4gKwlpZiAoc3RhdHVzICE9IEVGSV9TVUND
RVNTKSB7DQo+ICsJCWVmaV9lcnIoIkZhaWxlZCB0byBwYXJzZSBvcHRpb25zXG4iKTsNCj4gKwkJ
Z290byBmYWlsOw0KPiArCX0NCj4gKyNlbHNlIC8qIENPTkZJR19HRU5FUklDX0NNRExJTkUgKi8N
Cj4gKw0KPiAgICNpZmRlZiBDT05GSUdfQ01ETElORV9CT09MDQo+ICAgCXN0YXR1cyA9IGVmaV9w
YXJzZV9vcHRpb25zKENPTkZJR19DTURMSU5FKTsNCj4gICAJaWYgKHN0YXR1cyAhPSBFRklfU1VD
Q0VTUykgew0KPiBAQCAtODg1LDggKzg5NSw2IEBAIHZvaWQgX19ub3JldHVybiBlZmlfc3R1Yl9l
bnRyeShlZmlfaGFuZGxlX3QgaGFuZGxlLA0KPiAgIAl9DQo+ICAgI2VuZGlmDQo+ICAgCWlmICgh
SVNfRU5BQkxFRChDT05GSUdfQ01ETElORV9PVkVSUklERSkpIHsNCj4gLQkJdW5zaWduZWQgbG9u
ZyBjbWRsaW5lX3BhZGRyID0gKCh1NjQpaGRyLT5jbWRfbGluZV9wdHIgfA0KPiAtCQkJCQkgICAg
ICAgKCh1NjQpYm9vdF9wYXJhbXMtPmV4dF9jbWRfbGluZV9wdHIgPDwgMzIpKTsNCj4gICAJCXN0
YXR1cyA9IGVmaV9wYXJzZV9vcHRpb25zKChjaGFyICopY21kbGluZV9wYWRkcik7DQo+ICAgCQlp
ZiAoc3RhdHVzICE9IEVGSV9TVUNDRVNTKSB7DQo+ICAgCQkJZWZpX2VycigiRmFpbGVkIHRvIHBh
cnNlIG9wdGlvbnNcbiIpOw0KPiBAQCAtODk0LDYgKzkwMiw4IEBAIHZvaWQgX19ub3JldHVybiBl
Zmlfc3R1Yl9lbnRyeShlZmlfaGFuZGxlX3QgaGFuZGxlLA0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAg
DQo+ICsjZW5kaWYNCj4gKw0KPiAgIAlzdGF0dXMgPSBlZmlfZGVjb21wcmVzc19rZXJuZWwoJmtl
cm5lbF9lbnRyeSk7DQo+ICAgCWlmIChzdGF0dXMgIT0gRUZJX1NVQ0NFU1MpIHsNCj4gICAJCWVm
aV9lcnIoIkZhaWxlZCB0byBkZWNvbXByZXNzIGtlcm5lbFxuIik7DQo=

