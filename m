Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9158CC3E
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiHHQjO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiHHQjJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 12:39:09 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90050.outbound.protection.outlook.com [40.107.9.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5878167E3;
        Mon,  8 Aug 2022 09:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd/0dxXa1QlkSXCt3Kl4bccfTpdrevADTX6uWDpvyIQ6347fBDav8cceDrfvYFUIsbbXT0MtvbpHB7kBWB+p0Cfl4Uv/MlniTWxfluVM96Y11DxPaIe1oguuHE8gQjMl1aPPxy+XVKlz6x5xKs0ZJCj7xhGyVJl2AN+LyV7zX3GIhulXeCiCuaHL0wuLhUKJ5JjCZdFe/zsqvdjeyP2H2DQbmm+iDXf0ttjUVd1tGQbZpPp4p7pAUlKcXDhmAXn5rJlhQdQ4qy9OcsBOxmQnAPaHlj6G3ix2lCElaSKGUOqBkoE4sukNZrL28PdWfpWSHPiUg5DeNTxIVQMqzvdEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ManeWd4WI+RqW9mxFYnGk62kDeQ62Idqlkwoah0lypM=;
 b=jSMkc/fXIkV9wEURR99B7bx+hZnkyao78hBWP7Hc7mJIKvP9aXYKAjjNfycJIUX4cMs7AS84NTQACt32SCJZ71dvk8ibhzaj8KAzAG1//um23pwfLrYd4p6JWPHTNwqrIc8sDdX+l3HTMBgA62fU5WxsfizKl0u3z2jBzaWjXetfS1sMsacKIjZp1YPhszZZqAPBavQmxMxQasm+JVt6Mxg4q0/o3ZJIH7lNUYFwrUvXI8IuGXbRwHtcev6//G7GFmAntQ0F1hdM66aanf0GLTDIbGWcJoKUGLjno06isEVtBbpOQOic7lVWfCZbjjhcwHlgocfVdPuOxwulr7Hrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ManeWd4WI+RqW9mxFYnGk62kDeQ62Idqlkwoah0lypM=;
 b=6iydvlmMx8u1238/c0I/LnYKEQR+YTIorKKHKUTX7UlDNEkb/zKSTAetAVp/XuEpiFpNabi1yayuZzWFaYPYO9FyJ74aXoo9zZ22yi6I3joOLDqqi7Kb6I5RlcvzbpwhlK+FZeOJsbbJA1Wj0AXeCwptPuO1XGnO3L2A3+vOS+bZvANSIa0JzICzV/es4IRhRHP+RM5unuQV0njySoMV0Wmx6PqbBOw1FSGDOoCXQjYFw4Ccb1D2u/6usz7KpZbtOMeN8QcgQDAuu7ApeOu4mybo+z4RAzZ1rry/8OWRWBD281LADVEhCmzuEnsJJYKjsCKqhBi/9AH0Yhtt7EQP/w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2919.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 16:39:05 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 16:39:04 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "gjoyce@linux.vnet.ibm.com" <gjoyce@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3a 2/2] powerpc/pseries: Override lib/arch_vars.c
 functions
Thread-Topic: [PATCH v3a 2/2] powerpc/pseries: Override lib/arch_vars.c
 functions
Thread-Index: AQHYqz3bxklUs3GVMU+6y5R2U+u/Yq2lND8A
Date:   Mon, 8 Aug 2022 16:39:04 +0000
Message-ID: <c3c462d1-beaf-a57c-b8bb-003b8800bf88@csgroup.eu>
References: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
 <20220808154345.11240-3-gjoyce@linux.vnet.ibm.com>
In-Reply-To: <20220808154345.11240-3-gjoyce@linux.vnet.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0342bc5-1c7f-4744-eb67-08da795c81e3
x-ms-traffictypediagnostic: PR0P264MB2919:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2wXokV7SEntLYTJh4RLiEI+KGPEPreXM+yAxAxJrZjF8DQaKx+T98u0CWi3JMbjEVzDUUvKg4Qq2TDecvt6nLIfNGfAVcR6IyuQRWSx9b883rQg3hFbAYd7GIog1HRdDb9hyYFZOuLDP8jyj3Ek5i/hX0KQzOte36wVf/LSL1JNequ2Fpj6uDhBtKI9+oBLV3HjeAbe4DA+A3iFhgjEVOyCAToqoHcoDvWxxPVRp0aqOopAVzIFusGOx2av2g75FvquBjZFuiVLoUDWJD0AQh1Qzhqc5owoDuJjD7dVUwrQCdu8GxSZaoPGxue95aj64QICtKi1vY3qaQVdP/9D1/Fg/pSdbaYXYlAg+AKe0aC1x9Gmj7qSL67oijR8+Mk9vaqg3d/1rtJYZBAkhpmivGhGrjUa+bwNvQyfMprebCE9mgUzAyFsug4d57C72Hi6ZcfOVLHVHagl7sNQyyMR/qcujwjuoKIiSTraPXHN5WGO76dEi94IVWihB/UQOmJ25a3prm056okgldv63VQB0reX6CC69AdrTeM79aOMEOOh/HKfwZ/CkDOdG0Pb9BmMhwjDM3giQIT2qKn9aLz5pd2xzPZhzWTRnBlIyD+1/VRmQUZF3nGBVStbTr5OAEbTjEsQzPOxcuucdNgHZpa8rNpfJtDKrGUz+qDXOU0+qJgfp1DvzsNQSK+zuW1DL6IoZMVQHLgvWjQRYUERV9HO3KInb3CPsOmJWEIDHu5WTAwP1AxOsPJahPrl32CU249q2mGAM3BWM5KOVKQFxMyWayoQQLWUwygBe+fyrlXd8x3VpScdXbhuqZlyeqYNwm/5Gv/CkXu8b+Z1HEnWF/zlwPXAGqcIg51ckOF/KhZN7G/dA6E+rI9DT5i64ZFoKjD6xL4bDH5BM4KpCHZOsEiEr0zCUJtT/zgdYBwEDp90LUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(39850400004)(346002)(366004)(396003)(136003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(8936002)(44832011)(5660300002)(7416002)(2906002)(38100700002)(38070700005)(122000001)(36756003)(86362001)(31696002)(478600001)(966005)(6486002)(6506007)(41300700001)(71200400001)(54906003)(110136005)(83380400001)(2616005)(26005)(6512007)(66574015)(186003)(31686004)(42413004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWZibHJ6NGRYU2owcnRvSnNXa2tOL0EyeFBMTjhhbW9FSitSUGZ4ckU2ZzBW?=
 =?utf-8?B?RTBCUExTLzJLcUtjRHZZRjZ5SGV4bGIyNklTL0pMQmhDMUtNTkhGTUxGZlBH?=
 =?utf-8?B?MXlYVUJ4SmtuNzdDb0ZOVGQvNVNyaXl0Q3NqSEhUODMrRWlja2h2YVRmQ2Ju?=
 =?utf-8?B?SlB4QjQ4bCswK1B1dTJoVlUvYjc0NTVVZGJBT0xhV0FlcVV4T1VwOXhraHZ3?=
 =?utf-8?B?Z2h1azVUcVpRdVBrYXpxQXhDcFZPdzN1RE1PYXlEQUZneitacUhKY3Z0OHBn?=
 =?utf-8?B?SjRDUURPNDdWVEwyanA4YWVJd2xhTTRaUXhxdlhVd3kyb28vRTVRelBpVnV4?=
 =?utf-8?B?Nk1EVzB1RVovU1RrTVRkVHBkdytkZnU4a3hBSGFPWDRwS3FZTlQrbCtQUWJP?=
 =?utf-8?B?aUthMVNYbzdMdDJXbTlZNzFiMXIyNm9qNmtLOStpV0JuTFJSQ0tTMXJHT1dy?=
 =?utf-8?B?SVZXUHJqYVFpRFJsblQ0eUZsSGhnamsyNWxlbnZENFdmZ1k2bG5Ib0VVM21t?=
 =?utf-8?B?VDBIQlVTTHhoOWZ1eVpJb0h4VndNNzVkcnFLU3JMeHRrdE82WUY4b0tIdUlk?=
 =?utf-8?B?R2MraXB6anNiN1U1RDNSd0U5bm01R3Z3QlYwaThOekl0Ynh4SHRlWU5hbStt?=
 =?utf-8?B?L3RiTWtvSHd1RWtQZ0FIYjJaS1hEV0lJMVdKZGhPd0FiamFma3kwSXE3ZVR5?=
 =?utf-8?B?UFJaVkRaVkxHMnQvNFZjR2dFVUR1ZURzN3YvK2p1WlZpK2ZiR281d29kV05K?=
 =?utf-8?B?UmJielgxYUZrN1FJNnR4SUh2cE8xcjNTSHVremxBbWE5MUZwR2NBMHg2ajJ2?=
 =?utf-8?B?K0MzakFQUGc2eGVxeGFkS3I4ZUtsQkhZOUZMZHVoMjNwcjV5YmdpMXNwampx?=
 =?utf-8?B?QVpvc2ttdUUvYVJHNloydE43MXgwU1dIZm5tNDF2L2tTYU1OZEtSbnd4TDM2?=
 =?utf-8?B?Z1J3MThBUDdJT2pMbEYyRU1vZ042eTJZWU9VRTZjUHhvT2FFQ3gyUkdhUkYr?=
 =?utf-8?B?YnJ2a3RJZWFzT3h0WkZvYkk1a2dZd05IS1VpbjBxTEFKcmlha3htejl2T0VG?=
 =?utf-8?B?T3JoWXRMRmNCRlpzY01xN3NHMDhpSjd4b0lCTEZPVEtDaThWZTdyblR3T2Jy?=
 =?utf-8?B?V3Q5WmozMWRqVGwvUTByeDZlZlhGV2xsRy9ac0lENDU3enFRUVdCSzJNVVRX?=
 =?utf-8?B?TGRWN2ZpRUQvS082Ni94Y25scEhla0w2UzNjSDhaRFdqeXYvYW1nYjcxblA3?=
 =?utf-8?B?WUNnS3crb0t4Rm56YW5DcXdkMVRZOEVjUlR3ODM0TWZWSzViZ0R1NW8vY3Zh?=
 =?utf-8?B?aFhET3ptOTJEK0VOMzJENVlOb3E3cHhDRVFLYlI2bC83RCt3T2dzYlE4SDRa?=
 =?utf-8?B?Y2IxaWpIaFRuM2RHNndCN0F0dmFCcGRqOEhLeDllNmVLYUZJZUN2aVB3Snk2?=
 =?utf-8?B?QUFTQ0g2dVhmb1Nsazd1K3NRQ2Yza1oxY1hKL0lzSHlPN25jcXI2c0NDN2tQ?=
 =?utf-8?B?d0JGUXBqY0h6UkNsQ2RHbXdpeXBSd2ZuTXIyYlNNN3FKM3ZwWCtrNjlsdmZC?=
 =?utf-8?B?SWx4TWtOL3luVWMvRmdNck1xQmFBQ0poTEV2WXpBcjJIU04yUXN6R3hBN1hj?=
 =?utf-8?B?TCtVTXB0aklEd08zVTdkeVp3eFY4RUVVWW5GeXNLaGxuQURocXFaUytaaklF?=
 =?utf-8?B?SCtHS0FkN3ZZYllucG9SRHJXNU95L2NiVXRnRkVpQmxua0xXRmRlcTJaVmJD?=
 =?utf-8?B?L0pST1NiZVNKTUM1ZU1Pa095dFVPMTM2SXU1azk0WTZ2bUFkc2N6bW9mT1I4?=
 =?utf-8?B?eUs3RWtmeG5ucnhtblUvNks1b0FIRGluKzJGVGFNdHlGMlN3NXlGWmd1NmVV?=
 =?utf-8?B?ZFZZenZISjg1dHBmN3EzaTFCaXlabVBjd3I3eXBDZHRDeXl5RlVOL2MxNC8v?=
 =?utf-8?B?NS9EN2hWb1BjYWdobjl0UUhsSlMrb21JaFgxTFE3clRPdGRVZzRMQ1g0bndD?=
 =?utf-8?B?NkJNZWV6ZzRzK3FBbzRFcVpTKzM3Vm5lTndzTlZVMW90dVQyMjl2TEpLbUZJ?=
 =?utf-8?B?N1RvRU9pS0FST0M5OEJhRTRTeE44MWtTeTl3dUpHSzRtd1o2K3lXc3dyRXNX?=
 =?utf-8?B?YmwxRGt3M25hYzRYWVhTaUlJa0I3WVgyQ3Y1Rk5sdVZJTXMxMm1XQUw5OWhZ?=
 =?utf-8?Q?8NUuHlhq3qth5pKmouUxNK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7EAB0A92AD4B04BB8C05F97E92281F3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0342bc5-1c7f-4744-eb67-08da795c81e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 16:39:04.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luMCNb7jO/8Jg9134hN88NcY4J7U+sEloI5bH3fuZyXAlruICFn+JMpfVjEmIGAFREsqZUbIliw9DT9VYc9s7pEJF5eX54tDs3NtuSihoOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCkxlIDA4LzA4LzIwMjIgw6AgMTc6NDMsIGdqb3ljZUBsaW51eC52bmV0LmlibS5jb20gYSDD
qWNyaXTCoDoNCj4gRnJvbTogR3JlZyBKb3ljZSA8Z2pveWNlQGxpbnV4LnZuZXQuaWJtLmNvbT4N
Cj4gDQo+IFNlbGYgRW5jcnlwdGluZyBEcml2ZXMoU0VEKSBtYWtlIHVzZSBvZiBQT1dFUiBMUEFS
IFBsYXRmb3JtIEtleVN0b3JlDQo+IGZvciBzdG9yaW5nIGl0cyB2YXJpYWJsZXMuIFRodXMgdGhl
IGJsb2NrIHN1YnN5c3RlbSBuZWVkcyB0byBhY2Nlc3MNCj4gUG93ZXJQQyBzcGVjaWZpYyBmdW5j
dGlvbnMgdG8gcmVhZC93cml0ZSBvYmplY3RzIGluIFBMUEtTLg0KPiANCj4gT3ZlcnJpZGUgdGhl
IGRlZmF1bHQgaW1wbGVtZW50YXRpb25zIGluIGxpYi9hcmNoX3ZhcnMuYyBmaWxlIHdpdGgNCj4g
UG93ZXJQQyBzcGVjaWZpYyB2ZXJzaW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgSm95
Y2UgPGdqb3ljZUBsaW51eC52bmV0LmlibS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcHNlcmllcy9NYWtlZmlsZSAgICAgICB8ICAgMSArDQo+ICAgLi4uL3BsYXRmb3Jt
cy9wc2VyaWVzL3BscGtzX2FyY2hfb3BzLmMgICAgICAgIHwgMTY3ICsrKysrKysrKysrKysrKysr
Kw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTY4IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzX2FyY2hfb3BzLmMN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvTWFrZWZp
bGUgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvTWFrZWZpbGUNCj4gaW5kZXggMTRl
MTQzYjk0NmEzLi4zYTU0NTQyMmVhZTUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9NYWtlZmlsZQ0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bz
ZXJpZXMvTWFrZWZpbGUNCj4gQEAgLTI5LDYgKzI5LDcgQEAgb2JqLSQoQ09ORklHX1BQQ19TUExQ
QVIpCSs9IHZwaG4ubw0KPiAgIG9iai0kKENPTkZJR19QUENfU1ZNKQkJKz0gc3ZtLm8NCj4gICBv
YmotJChDT05GSUdfRkFfRFVNUCkJCSs9IHJ0YXMtZmFkdW1wLm8NCj4gICBvYmotJChDT05GSUdf
UFNFUklFU19QTFBLUykgKz0gcGxwa3Mubw0KPiArb2JqLSQoQ09ORklHX1BTRVJJRVNfUExQS1Mp
ICs9IHBscGtzX2FyY2hfb3BzLm8NCj4gICANCj4gICBvYmotJChDT05GSUdfU1VTUEVORCkJCSs9
IHN1c3BlbmQubw0KPiAgIG9iai0kKENPTkZJR19QUENfVkFTKQkJKz0gdmFzLm8gdmFzLXN5c2Zz
Lm8NCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wbHBrc19h
cmNoX29wcy5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzX2FyY2hfb3Bz
LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mZGVhMzMy
MmY2OTYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bz
ZXJpZXMvcGxwa3NfYXJjaF9vcHMuYw0KPiBAQCAtMCwwICsxLDE2NyBAQA0KPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiArLyoNCj4gKyAqIFBPV0VSIFBsYXRm
b3JtIGFyY2ggc3BlY2lmaWMgY29kZSBmb3IgU0VEDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIg
SUJNIENvcnBvcmF0aW9uDQo+ICsgKg0KPiArICogRGVmaW5lIG9wZXJhdGlvbnMgZm9yIGdlbmVy
aWMga2VybmVsIHN1YnN5c3RlbXMgdG8gcmVhZC93cml0ZSBrZXlzDQo+ICsgKiBmcm9tIFBPV0VS
IExQQVIgUGxhdGZvcm0gS2V5U3RvcmUoUExQS1MpLg0KPiArICoNCj4gKyAqIExpc3Qgb2Ygc3Vi
c3lzdGVtcy91c2VjYXNlIHVzaW5nIFBMUEtTOg0KPiArICogLSBTZWxmIEVuY3J5cHRpbmcgRHJp
dmVzKFNFRCkNCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2lvY3RsLmg+DQo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC9zZWQtb3Bh
bC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NlZC1vcGFsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
YXJjaF92YXJzLmg+DQo+ICsjaW5jbHVkZSAicGxwa3MuaCINCj4gKw0KPiArLyoNCj4gKyAqIHZh
cmlhYmxlIHN0cnVjdHVyZSB0aGF0IGNvbnRhaW5zIGFsbCBTRUQgZGF0YQ0KPiArICovDQo+ICtz
dHJ1Y3QgcGxwa3Nfc2VkX29iamVjdF9kYXRhIHsNCj4gKwl1X2NoYXIgdmVyc2lvbjsNCj4gKwl1
X2NoYXIgcGFkMVs3XTsNCj4gKwl1X2xvbmcgYXV0aG9yaXR5Ow0KPiArCXVfbG9uZyByYW5nZTsN
Cj4gKwl1X2ludCAga2V5X2xlbjsNCj4gKwl1X2NoYXIga2V5WzMyXTsNCj4gK307DQo+ICsNCj4g
Ky8qDQo+ICsgKiBleHRfdHlwZSB2YWx1ZXMNCj4gKyAqICAgICAwMCAgICAgICAgbm8gZXh0ZW5z
aW9uIGV4aXN0cw0KPiArICogICAgIDAxLTFGICAgICBjb21tb24NCj4gKyAqICAgICAyMC0zRiAg
ICAgQUlYDQo+ICsgKiAgICAgNDAtNUYgICAgIExpbnV4DQo+ICsgKiAgICAgNjAtN0YgICAgIElC
TWkNCj4gKyAqLw0KPiArDQo+ICsvKg0KPiArICogVGhpcyBleHRlbnNpb24gaXMgb3B0aW9uYWwg
Zm9yIHZlcnNpb24gMSBzZWRfb2JqZWN0X2RhdGENCj4gKyAqLw0KPiArc3RydWN0IHNlZF9vYmpl
Y3RfZXh0ZW5zaW9uIHsNCj4gKwl1OCBleHRfdHlwZTsNCj4gKwl1OCByc3ZkWzNdOw0KPiArCXU4
IGV4dF9kYXRhWzY0XTsNCj4gK307DQo+ICsNCj4gKyNkZWZpbmUgUEtTX1NFRF9PQkpFQ1RfREFU
QV9WMSAgICAgICAgICAxDQo+ICsjZGVmaW5lIFBLU19TRURfTUFOR0xFRF9MQUJFTCAgICAgICAg
ICAgIi9kZWZhdWx0L3ByaSINCj4gKyNkZWZpbmUgUExQS1NfU0VEX0NPTVBPTkVOVCAgICAgICAg
ICAgICAic2VkLW9wYWwiDQo+ICsNCj4gKyNkZWZpbmUgUExQS1NfQVJDSFZBUl9QT0xJQ1kgICAg
ICAgICAgICBXT1JMRFJFQURBQkxFDQo+ICsjZGVmaW5lIFBMUEtTX0FSQ0hWQVJfT1NfQ09NTU9O
ICAgICAgICAgNA0KPiArDQo+ICsvKg0KPiArICogUmVhZCB0aGUgdmFyaWFibGUgZGF0YSBmcm9t
IFBLUyBnaXZlbiB0aGUgbGFiZWwNCj4gKyAqLw0KPiAraW50IGFyY2hfcmVhZF92YXJpYWJsZShl
bnVtIGFyY2hfdmFyaWFibGVfdHlwZSB0eXBlLCBjaGFyICp2YXJuYW1lLA0KPiArCQkgICAgICAg
dm9pZCAqdmFyYnVmLCB1X2ludCAqdmFybGVuKQ0KDQonZW51bSBhcmNoX3ZhcmlhYmxlX3R5cGUn
IGlzIHBvaW50bGVzc2x5IGxvbmcuIEFuZCBpdCBvbmx5IGhhcyB0d28gDQpwb3NzaWJsZSB2YWx1
ZXMsIHNvIHNob3VsZCBiZSBhICdib29sJw0KDQoNCj4gK3sNCj4gKwlzdHJ1Y3QgcGxwa3NfdmFy
IHZhcjsNCj4gKwlzdHJ1Y3QgcGxwa3Nfc2VkX29iamVjdF9kYXRhICpkYXRhOw0KPiArCXVfaW50
IG9mZnNldCA9IDA7DQoNCldvdWxkIGJlIGJldHRlciB0byBzZXQgaXQgdG8gMCBpbiB0aGUgY29k
ZSB0aGF0IGhhbmRsZXMgQVJDSF9WQVJfT1RIRVIgDQphbmQgbGVhdmUgaXQgdW5pdGlhbGlzZWQg
aGVyZS4NCg0KPiArCWNoYXIgKmJ1ZiA9IChjaGFyICopdmFyYnVmOw0KPiArCWludCByZXQ7DQo+
ICsNCj4gKwl2YXIubmFtZSA9IHZhcm5hbWU7DQo+ICsJdmFyLm5hbWVsZW4gPSBzdHJsZW4odmFy
bmFtZSk7DQo+ICsJdmFyLnBvbGljeSA9IFBMUEtTX0FSQ0hWQVJfUE9MSUNZOw0KPiArCXZhci5v
cyA9IFBMUEtTX0FSQ0hWQVJfT1NfQ09NTU9OOw0KPiArCXZhci5kYXRhID0gTlVMTDsNCj4gKwl2
YXIuZGF0YWxlbiA9IDA7DQo+ICsNCj4gKwlzd2l0Y2ggKHR5cGUpIHsNCg0KQSBzd2l0Y2ggZm9y
IGEgYm9vbGVhbiB2YWx1ZSBpcyBwb2ludGxlc3MuIEp1c3QgZG8gaWYvZWxzZSwgaXQgd2lsbCBi
ZSBhIA0KbG90IG1vcmUgcmVhZGFibGUuDQoNCj4gKwljYXNlIEFSQ0hfVkFSX09QQUxfS0VZOg0K
PiArCQl2YXIuY29tcG9uZW50ID0gUExQS1NfU0VEX0NPTVBPTkVOVDsNCj4gKyNpZmRlZiBPUEFM
X0FVVEhfS0VZDQoNCiNpZmRlZnMgaW4gQyBmaWxlcyBzaG91bGQgYmUgYXZvaWRlZCwgcmVmZXIg
DQpodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2NvZGluZy1zdHlsZS5odG1sI2NvbmRp
dGlvbmFsLWNvbXBpbGF0aW9uDQoNCj4gKwkJaWYgKHN0cmNtcChPUEFMX0FVVEhfS0VZLCB2YXJu
YW1lKSA9PSAwKSB7DQo+ICsJCQl2YXIubmFtZSA9IFBLU19TRURfTUFOR0xFRF9MQUJFTDsNCj4g
KwkJCXZhci5uYW1lbGVuID0gc3RybGVuKHZhcm5hbWUpOw0KPiArCQl9DQo+ICsjZW5kaWYNCj4g
KwkJb2Zmc2V0ID0gb2Zmc2V0b2Yoc3RydWN0IHBscGtzX3NlZF9vYmplY3RfZGF0YSwga2V5KTsN
Cj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBBUkNIX1ZBUl9PVEhFUjoNCj4gKwkJdmFyLmNvbXBvbmVu
dCA9ICIiOw0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBwbHBrc19yZWFkX29z
X3ZhcigmdmFyKTsNCj4gKwlpZiAocmV0ICE9IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwlpZiAob2Zmc2V0ID4gdmFyLmRhdGFsZW4pDQo+ICsJCW9mZnNldCA9IDA7DQo+ICsNCj4gKwlz
d2l0Y2ggKHR5cGUpIHsNCj4gKwljYXNlIEFSQ0hfVkFSX09QQUxfS0VZOg0KPiArCQlkYXRhID0g
KHN0cnVjdCBwbHBrc19zZWRfb2JqZWN0X2RhdGEgKil2YXIuZGF0YTsNCj4gKwkJKnZhcmxlbiA9
IGRhdGEtPmtleV9sZW47DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgQVJDSF9WQVJfT1RIRVI6DQo+
ICsJCSp2YXJsZW4gPSB2YXIuZGF0YWxlbjsNCj4gKwkJYnJlYWs7DQo+ICsJfQ0KPiArDQo+ICsJ
aWYgKHZhci5kYXRhKSB7DQo+ICsJCW1lbWNweSh2YXJidWYsIHZhci5kYXRhICsgb2Zmc2V0LCB2
YXIuZGF0YWxlbiAtIG9mZnNldCk7DQo+ICsJCWJ1ZlsqdmFybGVuXSA9ICdcMCc7DQo+ICsJCWtm
cmVlKHZhci5kYXRhKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAr
LyoNCj4gKyAqIFdyaXRlIHRoZSB2YXJpYWJsZSBkYXRhIHRvIFBLUyBnaXZlbiB0aGUgbGFiZWwN
Cj4gKyAqLw0KPiAraW50IGFyY2hfd3JpdGVfdmFyaWFibGUoZW51bSBhcmNoX3ZhcmlhYmxlX3R5
cGUgdHlwZSwgY2hhciAqdmFybmFtZSwNCj4gKwkJCXZvaWQgKnZhcmJ1ZiwgdV9pbnQgdmFybGVu
KQ0KPiArew0KPiArCXN0cnVjdCBwbHBrc192YXIgdmFyOw0KPiArCXN0cnVjdCBwbHBrc19zZWRf
b2JqZWN0X2RhdGEgZGF0YTsNCj4gKwlzdHJ1Y3QgcGxwa3NfdmFyX25hbWUgdm5hbWU7DQo+ICsN
Cj4gKwl2YXIubmFtZSA9IHZhcm5hbWU7DQo+ICsJdmFyLm5hbWVsZW4gPSBzdHJsZW4odmFybmFt
ZSk7DQo+ICsJdmFyLnBvbGljeSA9IFBMUEtTX0FSQ0hWQVJfUE9MSUNZOw0KPiArCXZhci5vcyA9
IFBMUEtTX0FSQ0hWQVJfT1NfQ09NTU9OOw0KPiArCXZhci5kYXRhbGVuID0gdmFybGVuOw0KPiAr
CXZhci5kYXRhID0gdmFyYnVmOw0KPiArDQo+ICsJc3dpdGNoICh0eXBlKSB7DQo+ICsJY2FzZSBB
UkNIX1ZBUl9PUEFMX0tFWToNCj4gKwkJdmFyLmNvbXBvbmVudCA9IFBMUEtTX1NFRF9DT01QT05F
TlQ7DQo+ICsjaWZkZWYgT1BBTF9BVVRIX0tFWQ0KPiArCQlpZiAoc3RyY21wKE9QQUxfQVVUSF9L
RVksIHZhcm5hbWUpID09IDApIHsNCj4gKwkJCXZhci5uYW1lID0gUEtTX1NFRF9NQU5HTEVEX0xB
QkVMOw0KPiArCQkJdmFyLm5hbWVsZW4gPSBzdHJsZW4odmFybmFtZSk7DQo+ICsJCX0NCj4gKyNl
bmRpZg0KPiArCQl2YXIuZGF0YWxlbiA9IHNpemVvZihzdHJ1Y3QgcGxwa3Nfc2VkX29iamVjdF9k
YXRhKTsNCj4gKwkJdmFyLmRhdGEgPSAodTggKikmZGF0YTsNCj4gKw0KPiArCQkvKiBpbml0aWFs
aXplIFNFRCBvYmplY3QgKi8NCj4gKwkJZGF0YS52ZXJzaW9uID0gUEtTX1NFRF9PQkpFQ1RfREFU
QV9WMTsNCj4gKwkJZGF0YS5hdXRob3JpdHkgPSAwOw0KPiArCQlkYXRhLnJhbmdlID0gMDsNCj4g
KwkJZGF0YS5rZXlfbGVuID0gdmFybGVuOw0KPiArCQltZW1jcHkoZGF0YS5rZXksIHZhcmJ1Ziwg
dmFybGVuKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBBUkNIX1ZBUl9PVEhFUjoNCj4gKwkJdmFy
LmNvbXBvbmVudCA9ICIiOw0KPiArCQlicmVhazsNCj4gKwl9DQoNClRoYXQgcGFydCBvZiBjb2Rl
IHNlZW0gdG8gaGF2ZSBhIGxvdCBpbiBjb21tb24gd2l0aCANCmFyY2hfcmVhZF92YXJpYWJsZSgp
LCBjYW4geW91IHJlZmFjdG9yID8NCg0KPiArDQo+ICsJLyogdmFyaWFibGUgdXBkYXRlIHJlcXVp
cmVzIGRlbGV0ZSBmaXJzdCAqLw0KPiArCXZuYW1lLm5hbWVsZW4gPSB2YXIubmFtZWxlbjsNCj4g
Kwl2bmFtZS5uYW1lID0gdmFyLm5hbWU7DQo+ICsJKHZvaWQpcGxwa3NfcmVtb3ZlX3Zhcih2YXIu
Y29tcG9uZW50LCB2YXIub3MsIHZuYW1lKTsNCg0KRG8geW91IHJlYWxseSBuZWVkIHRoYXQgY2Fz
dCB0byAodm9pZCkgPw0KDQo+ICsNCj4gKwlyZXR1cm4gcGxwa3Nfd3JpdGVfdmFyKHZhcik7DQo+
ICt9
