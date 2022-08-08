Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7158CC22
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiHHQbN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Aug 2022 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiHHQbM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Aug 2022 12:31:12 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90089.outbound.protection.outlook.com [40.107.9.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4712AE58;
        Mon,  8 Aug 2022 09:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTFQrk9OcpLq7JgHbJ+YlcyKTbmclSdBNusJ34vgv8PgdxuucCdNhyW6wBurGQFJRnlKFpQWU3pmCMHK7FBPSF9viTAtvknSU9+fLBcWIGNcJCNy1HtNgC3kpVTvBC+DemUTuONvVFIvpn6mglTzPpP3invjwEUL1G8K6D5MiNhW4TYpne5GOwHv04QGcIa8/cyydPdznbl8PhzOKuDd6LMJQ0olxO8qimo5/VLtlk1lVKzLrxpgCP3CDCxjg0/vwDD1XsOBu3kl/QHSEUNQf9YEBVThL5mZ7gQt8xoQXTzJXmFrfW9f1C3U2cgyAogt8kVMG1tGisiFEt2dn/6LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBJyR8zqkKs6h0T2yD6gfxXVsaYF56EBNWFS80EUfc0=;
 b=cDlvRgQTBfKUtXNp7mVsFEOHYD9yPOiR2f9TvNZnR8Vpgspe8XRvylSSfS8r17e/FNzDqwvWXBV39YA6cqw0uSUM6i8QCe263Mu8Ty0cKrLTw8i8FeQ12WrL9o3Xlb8RQ8ZJhQbYd+tgtmPMSHswyMfbrjIyi/iNj0jlgfpjRlBr9dWfVWVZqVYKBjXF+IhLK+/Cftz7MbpNdFjchfwG/pHE3XErBKA0lBwv6Qva38L7aSmSy2aPDIdwRBjToQ7VOX+Y7/ktbHDkCKH9ASxMhFxyemKKleaa+wB7zzCV0GfLrDNhOjS6VXkwdZJP4iMc7ik5kvhEfaMTU1tDxO+x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBJyR8zqkKs6h0T2yD6gfxXVsaYF56EBNWFS80EUfc0=;
 b=mx5xoGQcfybJB/sTS0cuIGwPi3VG7xjmqRvi2fZKqRCSPVcc+FeZeNTPJmpsAb0bqM5EzG3xtxikZiCdJqWEkDFC/2Wmtb48ATpzN1MSdf85XFPpKqxOL9wd2oUzczqZcyw6MINU5pG9JtGb7rFf2P8vQEf9JYcAk9zcRTYRxkKM3dhMKRKps4nMmR1uM0poLZvdNtk94ziGzsQB/yEOiY4KjDSsboPfYxxhxvPnA+a853lz9hmjMoYEHTwK3iToxqJxJ1gSQCOZfTLO02vB3wlX7amzFe9J6fJ3/7R6ktW5kyw/JG9WSjGmOHY3O1jVMYWqe2PBvkVNJPwjZ19ZIg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2919.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 16:31:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 16:31:06 +0000
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
Subject: Re: [PATCH v3a 1/2] lib: generic accessor functions for arch keystore
Thread-Topic: [PATCH v3a 1/2] lib: generic accessor functions for arch
 keystore
Thread-Index: AQHYqz3yJhBjD9FjD0+/MjjK3/rNWK2lMgaA
Date:   Mon, 8 Aug 2022 16:31:06 +0000
Message-ID: <1d4338cc-d7ec-383f-b201-222140a813bd@csgroup.eu>
References: <20220808154345.11240-1-gjoyce@linux.vnet.ibm.com>
 <20220808154345.11240-2-gjoyce@linux.vnet.ibm.com>
In-Reply-To: <20220808154345.11240-2-gjoyce@linux.vnet.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d91d1d1-e798-4776-bd03-08da795b64f8
x-ms-traffictypediagnostic: PR0P264MB2919:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0UFheEmyj827Bv6CncCWAdscllve7OZ/QLBMvFaucJeDUyh5i/B7g4syaM2xRl7MJMRBeWIH+EX41BVbz4W8mjEQ9hKQSVwg/Zkm0sIivkJQ9iD0Bxzhh4r/+r/iF2uIrRQi839ih8KkwmaPEVfeilKPvUJTFPvbMOV1wLKfjwe+ckYIUaBBkiWPS6eY2uiP+Q4S/r2QFIjkjA6BiwqJMpVBazW2fkhxULgDP9QTZHdqMkPtRJlHaICnSHwpKowK1DKI25DtfR1lAPE9BAfrC3qDMIJ0LL9e2xIqaJzb+lpk4bGN8dj2Bz/zhihhMfSsKp1yNECz/BvbWE5AO/6i2Otj5qxcEUr5yDcmjXc6Pwabd6xdVmTEKKpBmxJr1inTfqAxDOcWomEorRf1MP+SS3FALunrBQ9hMdB5cIaWxIMfbqpxrGss7H2Kw6EMZWkIyDor+HcjIxgPe372tnoSTleYqOXb3FZ8z7t0GGnl57vXpfkkMri8xqiYPEB9idqEdoutF0vjtZSDYxpjlFrLQql4/IXUYl71tHStlgtipWhbA5mr68DGI3QQtoHt8B6ES8z/Man3jn+XQIHWCIumayVHNQKd+IEuPIdTymAo4iRuqRfVUgy7yMl15NCYGNlQZoY38KdtO0wiV+wAyMhGWkE0pqe1scOLHhLUdeWQFF0RroF0lB0QzdrWkPMG3waumU6f37nb6ujKxEZeFMdn3l/1Hb2C555RZ1dSpe4nDKlOwuVTndpOO5YvIxQVnzScYG1RluZQ35bAtwsyRdXWLMdXgC4es4GJak3R45l8ftt9G+wFtmHcKsbT1fSLsfOUmzM3zz1M3p5lDEokvGWw3aM7IiO+S5C27XQemt4F3iQpuhNaYyNNozlBLaDmM+y4D3X9LVvcR74EX05L1ZU3I7sTNcwHLYdzc8O2WyfBdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(39850400004)(346002)(366004)(396003)(136003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(8936002)(44832011)(5660300002)(7416002)(2906002)(38100700002)(38070700005)(122000001)(36756003)(86362001)(31696002)(478600001)(6486002)(6506007)(41300700001)(71200400001)(54906003)(110136005)(83380400001)(2616005)(26005)(6512007)(66574015)(186003)(31686004)(42413004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JvS2EzYXhHOHBGdXVmUXJJQ0lZWEFYU29NeHJKbkhmYjZTbDcvUnJxQ0Nk?=
 =?utf-8?B?YzQxVlU4ekkrcy9JYmNmc3hZV0Vtc1hCZnFwUWN0ditCTGJ0c0I4L2dkRDFK?=
 =?utf-8?B?WVVwL0wyUG12Q2xaTFVnODhCR0ZhcEhtUkVreHpDbmJnQVRkRXA2UllIdTlD?=
 =?utf-8?B?cldRVk9TOTBmaDRVSDAzeE1iTmlTaUhlYlR1VUU0WHlSWXJQQlFkM0diVVE4?=
 =?utf-8?B?b05hSGlFdFBlSlZlVjBJdjVTVHkzZmQwbFFkVzNYZVB1UVBLcUwzZ3BnZXNu?=
 =?utf-8?B?c1BQeUNxNVBhcXA0TjIrK0N2RElRTVowcnZ1eE8xcldBS1RrTGVpN1lsYTV2?=
 =?utf-8?B?WkVGWlIxaWtMQmt4UHFpVTY4a3NaVXUxLzNqVVpEdUF2bUs3NkwxbTJ2djNW?=
 =?utf-8?B?dFNrajBwaTZxVU5Nb2p1V01yMlJhbjZIc3dMSkVGQnFTV3EzTllrbHZoK2tD?=
 =?utf-8?B?SGFGU242UGU0Vnh6RXFCRStKSWZqNXpJbVlXRStXVyt3SklVYnE2U3ZlcXJ0?=
 =?utf-8?B?R3pUY2lyOHMzcVQ5WE1SZWNwdmJOSHc2dWVNaVdUa1R1SCt5MXppUWdUcitJ?=
 =?utf-8?B?emVVWUc3Q3F0MVM0L3Z5K25Md1h5N1BvYjhrbzBJT2dVbjJZbTRFVkl3UEJI?=
 =?utf-8?B?c0NJS3VkWllOdi9Nd1hMTEJmak9pcVVxVWZzT3puRE1mUE5nUEVVeURSR1BL?=
 =?utf-8?B?SGR1NXlzQlZ1MUJtaTFQR1I4VlFNRlRhY3ZxNlRUVXdpUzUxY2FwVXViVU1v?=
 =?utf-8?B?TVlQSlBsT2ptRWdZd3BMcnlUWTE1MWNuSk9lVGlZOXV5MDJlNG40TmlNNlFp?=
 =?utf-8?B?RjRlNUVTWGQ5SStnTldEWU1mWTNmUU05VDRFOS9Cc0Y1bzV3cTJyUEpIbUFB?=
 =?utf-8?B?V1Mxbno5REE3eEdDdjN2ZGtUSU1qSG9ta3FXdVg4MDFaTVhJLzlCSm5ZQU1x?=
 =?utf-8?B?UitOMFg3djJVdDhleWFoNzBPM0tUay85aEswUUpHOWd1R1h0Z2c0Q2h2dVVu?=
 =?utf-8?B?aXg3aW5vZ0xIN1hwQm5HelMrY3JOYmF3UU9TREZjc3YyNUZiaWdTTTlueGk1?=
 =?utf-8?B?MklDaWs3RUEyQTEvck5sT0VpTHN3SmIvWXU3QTR0eE51dDY1NzVRUjRsNmxV?=
 =?utf-8?B?OEJNSFpGaENNd0hYTVk0RkxNSEZEalBXZHEwemxGb1R0VFJud3VYRkhxRU5U?=
 =?utf-8?B?U1I5MjA4Z2pCWVR4MlhBU3FlS3JyV0s2UDJmallHVHV6UUFPVks2ZjIzRHlE?=
 =?utf-8?B?YkdyQ0tvM3ZaM0FMbzlmMkNycmltRDVZaWF1NS9BNTFPeENUQnZ5cmhTK1VT?=
 =?utf-8?B?TTFhelVmamRNZmtvR0pJejh0eFp6SjNZZFlzaHQ3SFB5aFpwcTlFOGUrNlJZ?=
 =?utf-8?B?RW54NGpoMnVTMXc1RjJZaitGNjg1SGJWQjhGdDc3aitjME9XS2wyOUJ2L2JU?=
 =?utf-8?B?NmxFNi8zZ0tROTJoOTc1ajVmNGJBZmhWTzI0ZDB2OVRYNnphTFhwd29Xcldr?=
 =?utf-8?B?Z0ZDODR5VVFWclgwZjBhQTRxY1ZQOGJUMGJpSlNiSjRCeldjZHdzaURSVHQ1?=
 =?utf-8?B?L0hYdHhWWUtlR05XZ0ZvMHRneWx5QlB1QTBUOVRtSmpjWVZSNkgzWHNHa2tJ?=
 =?utf-8?B?OWRYaUZwWmhGRTlTSHJwbXhrM0RWU2R1Ri90RU80NWVXYkhXVTQxVmlLaFRK?=
 =?utf-8?B?cW9BOStjTWxjMUFxZmhOOHRoOVlzUTdGbFV5MVl0UjFxNlRHUFZ1TFZiWjMr?=
 =?utf-8?B?enA2djNqbkQwRFgzdkRSczE2MXJLS0JPUEc4WGJka053V2J2ZU5MV2ZzOWNi?=
 =?utf-8?B?eHRuQjFVMjF6b1FOTlN0U285UHI3MWZaRXRRcm5uU2UrRkZsY3hsTlM0S0xi?=
 =?utf-8?B?MEpjcnFoU3FyZnVuNmVZeG1OZnBkTGNiZXF1QjNqMVRMckJISXk5cnVhK2Z0?=
 =?utf-8?B?QzhwZEhOdkN2bDVFNEgvN2xscytzR0pzS2ZxVFRRUXQ0QWlrU1ZqbEdjYVh6?=
 =?utf-8?B?Z0d5dXJ0a3EyNExhbnlENzRzd2tyNEZSWmdpQWpLMGh6L3FnMkhJWXYzeXlR?=
 =?utf-8?B?QzcvVjRvL3pZMm9sWEJPNzJGNnlVU2hRRk5mUTIwejJYT3ZjSEdQVHYxbmxj?=
 =?utf-8?B?bzFKU0xKUkdGdlNGcURaWEtEaEQzamJndTV4UUZDL3JJdU43NlJqNlJac2wr?=
 =?utf-8?Q?eJ+6ri/yhsvERscfNvj37P8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE5DD0DF644E924EB7F2265AA2E2176A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d91d1d1-e798-4776-bd03-08da795b64f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 16:31:06.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWK+vsLAoJnFEoX66we3LkaAZSMzrI+fyGHGQ3I3mJNhE2Z2stHEKLcFLd2SHitR38G19SmFoOjlD4w5ZC44rHOVH4uLUmsVi90PL1LyahU=
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
Cj4gDQo+IEdlbmVyaWMga2VybmVsIHN1YnN5c3RlbXMgbWF5IHJlbHkgb24gcGxhdGZvcm0gc3Bl
Y2lmaWMgcGVyc2lzdGVudA0KPiBLZXlTdG9yZSB0byBzdG9yZSBvYmplY3RzIGNvbnRhaW5pbmcg
c2Vuc2l0aXZlIGtleSBtYXRlcmlhbC4gSW4gc3VjaCBjYXNlLA0KPiB0aGV5IG5lZWQgdG8gYWNj
ZXNzIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBmdW5jdGlvbnMgdG8gcGVyZm9ybSByZWFkL3dyaXRl
DQo+IG9wZXJhdGlvbnMgb24gdGhlc2UgdmFyaWFibGVzLg0KPiANCj4gRGVmaW5lIHRoZSBnZW5l
cmljIHZhcmlhYmxlIHJlYWQvd3JpdGUgcHJvdG90eXBlcyB0byBiZSBpbXBsZW1lbnRlZCBieQ0K
PiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgdmVyc2lvbnMuIFRoZSBkZWZhdWx0KHdlYWspIGltcGxl
bWVudGF0aW9ucyBvZg0KPiB0aGVzZSBwcm90b3R5cGVzIHJldHVybiAtRU9QTk9UU1VQUCB1bmxl
c3Mgb3ZlcnJpZGRlbiBieSBhcmNoaXRlY3R1cmUNCj4gdmVyc2lvbnMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBHcmVnIEpveWNlIDxnam95Y2VAbGludXgudm5ldC5pYm0uY29tPg0KPiAtLS0NCj4g
ICBpbmNsdWRlL2xpbnV4L2FyY2hfdmFycy5oIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICBsaWIvTWFrZWZpbGUgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBsaWIvYXJjaF92YXJz
LmMgICAgICAgICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2xpbnV4L2FyY2hfdmFycy5oDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGxpYi9hcmNoX3ZhcnMuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYXJjaF92
YXJzLmggYi9pbmNsdWRlL2xpbnV4L2FyY2hfdmFycy5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWMyODBmZjk0MzJlDQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9hcmNoX3ZhcnMuaA0KPiBAQCAtMCwwICsxLDIzIEBADQo+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArLyoNCj4gKyAqIFBsYXRm
b3JtIHZhcmlhYmxlIG9wZWFyYXRpb25zLg0KDQpJcyBpdCBwbGF0Zm9ybSBzcGVjaWZpYyBvciBh
cmNoaXRlY3R1cmUgc3BlY2lmaWMgPw0KDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDIy
IElCTSBDb3Jwb3JhdGlvbg0KPiArICoNCj4gKyAqIFRoZXNlIGFyZSB0aGUgYWNjZXNzb3IgZnVu
Y3Rpb25zIChyZWFkL3dyaXRlKSBmb3IgYXJjaGl0ZWN0dXJlIHNwZWNpZmljDQo+ICsgKiB2YXJp
YWJsZXMuIFNwZWNpZmljIGFyY2hpdGVjdHVyZXMgY2FuIHByb3ZpZGUgb3ZlcnJpZGVzLg0KDQoi
dmFyaWFibGVzIiBpcyBhIHZlcnkgZ2VuZXJpYyB3b3JkIHdoaWNoIEkgdGhpbmsgZG9lc24ndCBt
YXRjaCB3aGF0IHlvdSANCndhbnQgdG8gZG8uDQoNCkZvciBtZSAidmFyaWFibGVzIiBhcmUgbG9j
YWwgdmFyaWFibGVzIGFuZCBnbG9iYWwgdmFyaWFibGVzIGluIGEgQyBmaWxlLiANCkhlcmUgaXQg
c2VlbXMgdG8gYmUgc29tZXRoaW5nIGNvbXBsZXRlbHkgZGlmZmVyZW50IGhlbmNlIHRoZSBuYW1l
IGlzIA0KcmVhbGx5IG1lYW5pbmdmdWxsIGFuZCBtaXNsZWFkaW5nLg0KDQo+ICsgKg0KPiArICov
DQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gKw0KPiArZW51bSBhcmNoX3Zh
cmlhYmxlX3R5cGUgew0KDQphcmNoX3ZhcmlhYmxlX3R5cGUgPyBXaGF0J3MgdGhhdCA/IHZhcmlh
YmxlIHR5cGVzIGFyZSBjaGFyLCBzaG9ydCwgbG9uZywgDQpsb25nIGxvbmcsIGV0YyAuLi4NCg0K
PiArCUFSQ0hfVkFSX09QQUxfS0VZICAgICAgPSAwLCAgICAgLyogU0VEIE9wYWwgQXV0aGVudGlj
YXRpb24gS2V5ICovDQo+ICsJQVJDSF9WQVJfT1RIRVIgICAgICAgICA9IDEsICAgICAvKiBPdGhl
ciB0eXBlIG9mIHZhcmlhYmxlICovDQo+ICsJQVJDSF9WQVJfTUFYICAgICAgICAgICA9IDEsICAg
ICAvKiBNYXhpbXVtIHR5cGUgdmFsdWUgKi8NCj4gK307DQoNCldoeSB0aGUgaGVsbCBkbyB5b3Ug
bmVlZCBhbiBlbnVtIGZvciB0d28gdmFsdWVzIG9ubHkgPw0KDQo+ICsNCj4gK2ludCBhcmNoX3Jl
YWRfdmFyaWFibGUoZW51bSBhcmNoX3ZhcmlhYmxlX3R5cGUgdHlwZSwgY2hhciAqdmFybmFtZSwN
Cj4gKwkJICAgICAgIHZvaWQgKnZhcmJ1ZiwgdV9pbnQgKnZhcmxlbik7DQo+ICtpbnQgYXJjaF93
cml0ZV92YXJpYWJsZShlbnVtIGFyY2hfdmFyaWFibGVfdHlwZSB0eXBlLCBjaGFyICp2YXJuYW1l
LA0KPiArCQkJdm9pZCAqdmFyYnVmLCB1X2ludCB2YXJsZW4pOw0KPiBkaWZmIC0tZ2l0IGEvbGli
L01ha2VmaWxlIGIvbGliL01ha2VmaWxlDQo+IGluZGV4IGY5OWJmNjFmOGJiYy4uYjkwYzRjYjBk
YmJiIDEwMDY0NA0KPiAtLS0gYS9saWIvTWFrZWZpbGUNCj4gKysrIGIvbGliL01ha2VmaWxlDQo+
IEBAIC00OCw3ICs0OCw3IEBAIG9iai15ICs9IGJjZC5vIHNvcnQubyBwYXJzZXIubyBkZWJ1Z19s
b2Nrcy5vIHJhbmRvbTMyLm8gXA0KPiAgIAkgYnNlYXJjaC5vIGZpbmRfYml0Lm8gbGxpc3QubyBt
ZW13ZWlnaHQubyBrZmlmby5vIFwNCj4gICAJIHBlcmNwdS1yZWZjb3VudC5vIHJoYXNodGFibGUu
byBcDQo+ICAgCSBvbmNlLm8gcmVmY291bnQubyB1c2VyY29weS5vIGVycnNlcS5vIGJ1Y2tldF9s
b2Nrcy5vIFwNCj4gLQkgZ2VuZXJpYy1yYWRpeC10cmVlLm8NCj4gKwkgZ2VuZXJpYy1yYWRpeC10
cmVlLm8gYXJjaF92YXJzLm8NCj4gICBvYmotJChDT05GSUdfU1RSSU5HX1NFTEZURVNUKSArPSB0
ZXN0X3N0cmluZy5vDQo+ICAgb2JqLXkgKz0gc3RyaW5nX2hlbHBlcnMubw0KPiAgIG9iai0kKENP
TkZJR19URVNUX1NUUklOR19IRUxQRVJTKSArPSB0ZXN0LXN0cmluZ19oZWxwZXJzLm8NCj4gZGlm
ZiAtLWdpdCBhL2xpYi9hcmNoX3ZhcnMuYyBiL2xpYi9hcmNoX3ZhcnMuYw0KPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmU2ZjE2ZDdkMDljMQ0KPiAtLS0gL2Rl
di9udWxsDQo+ICsrKyBiL2xpYi9hcmNoX3ZhcnMuYw0KDQpUaGUgbmFtZSBpcyBtZWFuaW5nbGVz
cywgdG9vIGdlbmVyaWMuDQoNCg0KPiBAQCAtMCwwICsxLDI1IEBADQo+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICsvKg0KPiArICogUGxhdGZvcm0gdmFyaWFi
bGUgb3BlcmF0aW9ucy4NCg0KcGxhdGZvcm0gdmVyc3VzIGFyY2hpdGVjdHVyZSA/DQoNCj4gKyAq
DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgSUJNIENvcnBvcmF0aW9uDQo+ICsgKg0KPiArICog
VGhlc2UgYXJlIHRoZSBhY2Nlc3NvciBmdW5jdGlvbnMgKHJlYWQvd3JpdGUpIGZvciBhcmNoaXRl
Y3R1cmUgc3BlY2lmaWMNCj4gKyAqIHZhcmlhYmxlcy4gU3BlY2lmaWMgYXJjaGl0ZWN0dXJlcyBj
YW4gcHJvdmlkZSBvdmVycmlkZXMuDQo+ICsgKg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9hcmNoX3ZhcnMuaD4NCj4gKw0KPiAr
aW50IF9fd2VhayBhcmNoX3JlYWRfdmFyaWFibGUoZW51bSBhcmNoX3ZhcmlhYmxlX3R5cGUgdHlw
ZSwgY2hhciAqdmFybmFtZSwNCj4gKwkJCSAgICAgIHZvaWQgKnZhcmJ1ZiwgdV9pbnQgKnZhcmxl
bikNCg0KU29ycnksIHRvIHJlYWQgYSB2YXJpYWJsZSwgSSB1c2UgUkVBRF9PTkNFIG9yIEkgcmVh
ZCBpdCBkaXJlY3RseS4NCg0KPiArew0KPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gK30NCj4g
Kw0KPiAraW50IF9fd2VhayBhcmNoX3dyaXRlX3ZhcmlhYmxlKGVudW0gYXJjaF92YXJpYWJsZV90
eXBlIHR5cGUsIGNoYXIgKnZhcm5hbWUsDQo+ICsJCQkgICAgICAgdm9pZCAqdmFyYnVmLCB1X2lu
dCB2YXJsZW4pDQo+ICt7DQo+ICsJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArfQ==
