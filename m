Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F5687ADA
	for <lists+linux-efi@lfdr.de>; Thu,  2 Feb 2023 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjBBKvs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Feb 2023 05:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjBBKvq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Feb 2023 05:51:46 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748587307A;
        Thu,  2 Feb 2023 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0zhGe5wfJdFMvbm6oznFHnl1KuIFtYUihyueknHCF4=;
 b=z8/VAt2xq6LUOIT3BTUUYnmWkG+CeDFkX3yEQstqAnyvQi9F+Pqi/YwcFLRokkuvNTmQG/X8XrR9HPRbgy4srm5qKbkPxlAi29jhnwOUbKY2szSs1SXhtMLmpeEQ/XMWwuUctwhQE9a1SoXhckMht0fnaE2vDzzTghsCIz37y2M=
Received: from AS9PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:20b:488::16)
 by AM8PR08MB6481.eurprd08.prod.outlook.com (2603:10a6:20b:364::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 10:50:28 +0000
Received: from AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:488:cafe::f1) by AS9PR05CA0022.outlook.office365.com
 (2603:10a6:20b:488::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22 via Frontend
 Transport; Thu, 2 Feb 2023 10:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT003.mail.protection.outlook.com (100.127.140.227) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 10:50:28 +0000
Received: ("Tessian outbound baf1b7a96f25:v132"); Thu, 02 Feb 2023 10:50:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9dd890ae9703f4fe
X-CR-MTA-TID: 64aa7808
Received: from 3f60a753f106.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0EDC258F-8353-4227-BA09-1E47A467068C.1;
        Thu, 02 Feb 2023 10:50:17 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3f60a753f106.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Feb 2023 10:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoAXDsc81dE0crKpfQIaMX/EezfcQH8wbYJirgMuxNkj4h5UnrUaZUm6RrQcroC+k1iGrRTrfmHf8N4kOXNPlyS2cLr1baxSXnAqnymDBF88TCOfza2OGnHqdrCxal/R7+xOzHX2UeKJPtZy+SrVZYyE/lluv2IlCfZburkJapuW4rC/F/uoK2LF+BzPelyaj/gsNFd/44PEc/z+7DY7dDJ3nrf2ZblN1LwJSMWkCE61a56QDs/J2dItZcyty00Y7aWUiZ9LrS6NbLzRPJeRyeU4OGt0QLY3jg5KaeIoCXxDHdCaQcfve3WZYsbOiiMoLODMsMjBkdzejGP3wGtIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0zhGe5wfJdFMvbm6oznFHnl1KuIFtYUihyueknHCF4=;
 b=N1PYcXXHHb030XO7YgMW8sAFBum+pg2aOVfOoyuguucbhb+dChNTM1hsVSKR3+zKxeEKeXrU761lotI2cwq4YKEstcBnkHH4D0jRublUOQCZc6E70fdIhTYkqJ2g+mmWg+3vMTVBdocG3E4YSLYFyh12Qa5QX0o5xkJrEO7LI6anK7aq+uL20j4qp/f64ZuPz7OxXpZ3POuXIyu/7Ah87TybAMsie8Oql5mGVgEdK+Ud7IBAocrVTKA5m3+uy2OKa7N1e4RFgvcEmrQYmqKlGGEA9FM1qsPZLD6i3eNloL5Nrk0TlDLUjNt57GawVrAVIBFVVVlA/NFYMVJRf9M9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0zhGe5wfJdFMvbm6oznFHnl1KuIFtYUihyueknHCF4=;
 b=z8/VAt2xq6LUOIT3BTUUYnmWkG+CeDFkX3yEQstqAnyvQi9F+Pqi/YwcFLRokkuvNTmQG/X8XrR9HPRbgy4srm5qKbkPxlAi29jhnwOUbKY2szSs1SXhtMLmpeEQ/XMWwuUctwhQE9a1SoXhckMht0fnaE2vDzzTghsCIz37y2M=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DB8PR08MB5322.eurprd08.prod.outlook.com (2603:10a6:10:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.37; Thu, 2 Feb
 2023 10:50:07 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6043.036; Thu, 2 Feb 2023
 10:50:07 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQ
Date:   Thu, 2 Feb 2023 10:50:07 +0000
Message-ID: <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com>
In-Reply-To: <Y9lchEgyNGLKu/4R@zx2c4.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DB8PR08MB5322:EE_|AM7EUR03FT003:EE_|AM8PR08MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 981b361f-7187-46b0-4b7d-08db050b4c3d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: i8u6Mpwdb99GrGXfSIijhEWXIThRj4iq7ConGXuAhBO3JPvpIzn0XhMh9qJvV7r+ABKOg80h4t9EYm0RuuT1JwEQLLpO5B+t1bDILz+Nu45OS6BNx6QoFR6qgo9veJCFXV3LUl6WQF583ZOooDAYijDXciCNxd1mgSYoLzFE2NwrX8wIXx7/SBqdUaDP3RHBa+5cx/Zl3T2iK+Ta3DBFGTL+8pzWdvFMFmRf8Vt2KEVwZOHe4X/NIlBMG6wcXI6iTBqp3/EfofnNG9P4JYEuaCDarFDFJDVQhr3svIzBENOSCJY3/8jRIuk3ISNE4Crk2PnRc22PHsjI79x83jEmobBh+pq/IFlRJIuPvqqHRvI0Sq0BqNJ39g5S7znmEX5cQelCeBfjs+0q0pl69jN6WgJA4B902QshlaymLdmvl5nlbgkDu1qDYj95o5UA/dSnoD3HnGnUqgJpdynkbCJtG1iNSnpOgxDGN157XVc7j/RLSUYosZOOQwdHxsa9+ub2Pt5B+pHTIMm64x0QPUp9zWTm4MWT/xS5mACqZui7rlnoytkw7S7rzbFHkCkH/vbb+RTQYl/jvoYflaPAdlELxtj9flM7ZMyTJGdmW5l9XV4p8jllvFc03Alez1bCf6p9AdBpoPZ78FOs/wILcYjNssa8PQy8Sruj1D7rnC2g+Y6eniCpssuFX03sCVaJkHRSOKkVSYuO27IYDx4hxjwmXA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(9686003)(71200400001)(53546011)(186003)(26005)(6506007)(316002)(66556008)(54906003)(8676002)(66446008)(64756008)(66476007)(6916009)(83380400001)(66946007)(4326008)(52536014)(2906002)(76116006)(41300700001)(478600001)(8936002)(5660300002)(38100700002)(122000001)(55016003)(38070700005)(7696005)(33656002)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5322
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ed5334a9-3f58-498d-741c-08db050b3fb1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uoz671UVCXbq2egaw3ROPDw0YlICO34Qn38R5KY4elgdKekU8yhUS50eLr6lTKhx2yb59zrDjnag5qmdtiA1XhzoGaqznrpyAWP6HnEARdvMuI9yTV5D/SLoiR3E16TG6gf+unIjkHqUdq19bzdcNqzmK8SS9EGivS/Hi/pitshS9W4yJSP5rysTCQ+BoESRkXn4+HLvr1V+JaRhUwuyrkZeWdM+Q1aPYsuRz9IHm9RQeEiJ9+hMmGFgT3rhRNPRg48Qvn6tn/5FGBgZTC5zOUo9YVYAL9TvkPyaKAS229w5v2UDKeXmrbnuTyNTeJiugltmeDin+DBfF/SjWvmQRsj/kmloATVPePc3z+sqVSNyymc0e390LmwvQKB87ljUYdfXOR0XVlALlX+HRrXR1RSQTNoM9PU51w7YFsCN28WddaAp7ZYu6N7Z7/c4pMnAuLE5dNQmOwxQAMwToqtJSlR//kPChFDleb3YJCJnD7Ld0CyTpcq7HQTul8cZDExcA3dn7DdTMEK2i+YsupFMO6DWNtAXRikBHfYE15L+BU0ki8FczsLJgDM5oBi6a6xEdTYOqICtHS0WZeFpVfQEh9w+tUvoBiXqPspnuYEoIKz2Rdz8NEUwcbef41Qq1Bhd7BOr/RMSUdN+V/QJUE2OaB93g5MpFdd34qLkN2k6ao3fQv7/DegGdXSM7lLK6V4xiyL7VJHjTMOJwEoH9ftjOQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(82310400005)(336012)(2906002)(7696005)(40460700003)(81166007)(36860700001)(33656002)(26005)(186003)(9686003)(8936002)(52536014)(53546011)(47076005)(5660300002)(82740400003)(6506007)(6862004)(86362001)(55016003)(316002)(40480700001)(54906003)(478600001)(41300700001)(4326008)(70586007)(70206006)(356005)(450100002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 10:50:28.3828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981b361f-7187-46b0-4b7d-08db050b4c3d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6481
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgSmFzb24NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBB
LiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFy
eSAxLCAyMDIzIDI6MjMgQU0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+
IENjOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgSHVhY2FpIENoZW4gPGNoZW5o
dWFjYWlAa2VybmVsLm9yZz47DQo+IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkNCj4gPEFsZXhhbmRydS5FbGlz
ZWlAYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIEZpeCBib290IGhhbmcgaXNz
dWUgb24gQW1wZXJlIEVtYWcgc2VydmVyDQo+DQo+IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDAz
OjIxOjM5UE0gKzAwMDAsIEp1c3RpbiBIZSB3cm90ZToNCj4gPiBIaSBBcmQsDQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8
YXJkYkBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMSwgMjAyMyAz
OjE5IFBNDQo+ID4gPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT47IEphc29uIEEu
IERvbmVuZmVsZA0KPiA+ID4gPEphc29uQHp4MmM0LmNvbT4NCj4gPiA+IENjOiBIdWFjYWkgQ2hl
biA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPjsgbGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsNCj4g
PiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkNCj4gPiA+
IDxBbGV4YW5kcnUuRWxpc2VpQGFybS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAv
Ml0gRml4IGJvb3QgaGFuZyBpc3N1ZSBvbiBBbXBlcmUgRW1hZyBzZXJ2ZXINCj4gPiA+DQo+ID4g
PiAoY2MgSmFzb24gZm9yIGF3YXJlbmVzcykNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDMxIEphbiAy
MDIzIGF0IDA1OjA0LCBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4gSSBtZXQgYSBodW5nIHRhc2sgd2FybmluZyBhbmQgdGhlbiBrZXJuZWwgd2FzIGh1
bmcgZm9yZXZlciB3aXRoDQo+ID4gPiA+IGxhdGVzdCBrZXJuZWwgb24gYW4gQW1wZXJlIEVtYWcg
c2VydmVyLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgcm9vdCBjYXVzZSBpcyBrZXJuZWwgd2FzIGh1
bmcgIHdoZW4gaW52b2tpbmcgYW4gZWZpIHJ0cyBjYWxsDQo+ID4gPiA+IHRvIHNldCB0aGUgUmFu
ZG9tU2VlZCB2YXJpYWJsZSBkdXJpbmcgdGhlIGJvb3Rpbmcgc3RhZ2UuIFRoZQ0KPiA+ID4gPiBh
cmNoX2VmaV9jYWxsX3ZpcnQgY2FsbCAoc2V0X3ZhcmlhYmxlKSB3YXMgbmV2ZXIgcmV0dXJuZWQg
YW5kIHRoZW4NCj4gPiA+ID4gY2F1c2VkIHRoZQ0KPiA+ID4gaHVuZyB0YXNrIGVycm9yLg0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IEdpdmVuIHRoYXQgRUZJIHZhcmlhYmxlcyB3b3JrIG9uIHRoaXMg
cGxhdGZvcm0gKGFzIGZhciBhcyBJIGtub3cpLA0KPiA+ID4gdGhlIHByb2JsZW0gbWF5IGJlIHRo
YXQgd2UgYXJlIGNhbGxpbmcgU2V0VmFyaWFibGUoKSB0b28gZWFybHkuDQo+ID4gPg0KPiA+ID4g
Q291bGQgeW91IGRvdWJsZSBjaGVjayB3aGV0aGVyIHNldHRpbmcgdmFyaWFibGVzIHdvcmtzIGFz
IGV4cGVjdGVkPw0KPiA+ID4gWW91IGNhbiB1c2UgZWZpYm9vdG1nciAtdCAxMCBhcyByb290IChm
b3IgZXhhbXBsZSkgdG8gc2V0IHRoZSBib290DQo+ID4gPiB0aW1lb3V0LCBhbmQgY2hlY2sgd2hl
dGhlciB0aGUgbmV3IHZhbHVlIGlzIHJldGFpbmVkIGFmdGVyIGEgcmVib290DQo+ID4gPiAoZWZp
Ym9vdG1nciB3aWxsIHByaW50IHRoZSBjdXJyZW50IHZhbHVlIGZvciB5b3UpDQo+ID4gPg0KPiA+
ID4gQ291bGQgeW91IGFsc28gcGxlYXNlIHNoYXJlIHRoZSBrZXJuZWwgbG9nIHVwIHVudGlsIHRo
ZSBwb2ludCB3aGVyZSBpdA0KPiBoYW5ncz8NCj4gPiA+DQo+ID4gVGhlIHNldF92YXJpYWJsZSBz
ZWVtcyB0byBiZSBvayBpbiA1LjE5KzoNCj4gPiByb290QDp+IyBlZmlib290bWdyIC10IDEwDQo+
ID4gQm9vdEN1cnJlbnQ6IDAwMDANCj4gPiBUaW1lb3V0OiAxMCBzZWNvbmRzDQo+DQo+IEkgdGhp
bmsgd2hhdCB3ZSB3YW50IHRvIGxlYXJuIGlzIHdoZXRoZXIgZWZpYm9vdG1nciAtdCAxMCB3b3Jr
cyBpbiB0aGUgbGF0ZXN0DQo+IFJDLiBJZiBub3QsIGl0IHdvdWxkIHN1Z2dlc3QgdGhlIGlzc3Vl
IGlzbid0IHdpdGggdGhlIHNlZWQgc2V0dGluZywgYnV0IHdpdGggc29tZQ0KPiBvdGhlciB1bnJl
bGF0ZWQgY2hhbmdlLg0KPg0KPiBDYW4geW91IHJ1biBlZmlib290bWdyIC10IDEwIChvciB3aGF0
ZXZlcikgYWdhaW4gb24gYSBrZXJuZWwgd2hlcmUgeW91J3ZlDQo+IGNvbW1lbnRlZCBvdXQgdGhl
c2UgbGluZXMgaW4gZWZpLmMgaW5zaWRlIG9mIGVmaXN1YnN5c19pbml0KCk6DQo+DQo+ICAgICBp
ZiAoZWZpX3J0X3NlcnZpY2VzX3N1cHBvcnRlZChFRklfUlRfU1VQUE9SVEVEX1NFVF9WQVJJQUJM
RSkpDQo+ICAgICAgICAgZXhlY3V0ZV93aXRoX2luaXRpYWxpemVkX3JuZygmcmVmcmVzaF9udl9y
bmdfc2VlZF9uYik7DQo+DQo+IC0tPg0KPg0KPiAgICAgLy8gaWYgKGVmaV9ydF9zZXJ2aWNlc19z
dXBwb3J0ZWQoRUZJX1JUX1NVUFBPUlRFRF9TRVRfVkFSSUFCTEUpKQ0KPiAgICAgLy8gICAgIGV4
ZWN1dGVfd2l0aF9pbml0aWFsaXplZF9ybmcoJnJlZnJlc2hfbnZfcm5nX3NlZWRfbmIpOw0KPg0K
QXMgeW91ciBzdWdnZXN0ZWQgKGNvbW1lbnQgYWJvdmUgZXhlY3V0ZV93aXRoX2luaXRpYWxpemVk
X3JuZyBpbiBsYXRlc3Qga2VybmVsKToNClRoZSBlZmlib290bWdyIC10IFggd2lsbCBiZSBodW5n
LiBMb29rcyBsaWtlIG9uZSBjZXJ0YWluIGNvbW1pdCBiZWZvcmUgeW91ciBwYXRjaA0KYnJva2Ug
dGhlIHNldF92YXJpYWJsZSBlZmkgY2FsbC4gSSB3aWxsIGRpZyBpbnRvIHRoZSBmdXJ0aGVyIGRl
YnVnIGFuZCB0ZWxsIHlvdSB0aGUgcmVzdWx0Lg0KDQotLS0NCkNoZWVycywNCkp1c3Rpbi4NCklN
UE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhl
ciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
