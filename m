Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A668318A
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjAaPbx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 10:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjAaPbw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 10:31:52 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C52515574;
        Tue, 31 Jan 2023 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV+1EjGuVEv67dccrEFJAz+8z85QRs7LXVNmI1I1W9E=;
 b=Xx5+SD+oiwYuip19RamCDR08SISspqCxyWjMrMdF4kNTiPJ9fq6syXsKwCObFkIkFnlTvUtsBSc80y0SbCod3fy3kYCbu4ZzMyno0hcCEKHgbR6sHXFHyO9ZrUExKXJViHh8Zept2YYn85Ab2lCJqH/5nxKcNkbqGd8ITi+bBXs=
Received: from AS9PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:20b:465::21)
 by AM0PR08MB5476.eurprd08.prod.outlook.com (2603:10a6:208:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Tue, 31 Jan
 2023 15:31:42 +0000
Received: from AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:465:cafe::55) by AS9PR06CA0103.outlook.office365.com
 (2603:10a6:20b:465::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 15:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT027.mail.protection.outlook.com (100.127.140.124) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 15:31:42 +0000
Received: ("Tessian outbound b1d3ffe56e73:v132"); Tue, 31 Jan 2023 15:31:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cb550c387e0e3f43
X-CR-MTA-TID: 64aa7808
Received: from 741063a79105.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EB8E71D6-84CD-42C3-BEFF-C84D9B5F8798.1;
        Tue, 31 Jan 2023 15:31:31 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 741063a79105.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 31 Jan 2023 15:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV6aC4pcvCW5BcREzNceUhX8Q6Ik69IYkfpF/KENhz+VMvsQSjgYUKnDVLXX3+LKrrZxQp12Ha20qAEXApvj/uk5IytRt4x2tk8ucwx16vjPZoHlJFmQB3Kj69nw72c5m9O5vAtOPbJVgpv+H9NzfWo2cwjY3cmnya1wHl40Ottvutp4663N/9MKRpU3SWcuAfH1U49xmqmlBZYkTuPjRWZHxbYUKGgRWOsh/vFdt3JZUXnalIbbS+0B5e1ydHlpguJItTofJx3q6RhRhPFrfsQ+mBonE2qvbLrkfnnIx8qSq/B8mI2qXWmnSEZEsZiYaPJWESR7fQrHXYEtrT9/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV+1EjGuVEv67dccrEFJAz+8z85QRs7LXVNmI1I1W9E=;
 b=JJ9kU+OSvOQ08exFrHByk7BXZXQ9+bo0EsVw6dwHO4/wBYxKHPzpfcwCO5j8zD5GfcEDELbSqpJaPkZUa8IuMddXrbmi3lt7+zvB90LtwviVIl4RGiSQmUx6gJokzTtMOKaGM53EncdVwVF0bVCRrXbdDJllTlim29E1XPpuZTVbAvZ3vcaoRTanYg0hDI6u6BsirGD+Ps+L0N5hnjRfK7e/YA99W+ud9HZXnsnSp7b7KapNCrtSkEx8ZQQm+/hEv0F4LYxGzocGD3b2E/KblBZG1Ei+BhT/FjUoXqDYsFAfmXkBIO8Qn/G6uxI7/ax7qtzr2Fd2Ngr3ELerleoYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV+1EjGuVEv67dccrEFJAz+8z85QRs7LXVNmI1I1W9E=;
 b=Xx5+SD+oiwYuip19RamCDR08SISspqCxyWjMrMdF4kNTiPJ9fq6syXsKwCObFkIkFnlTvUtsBSc80y0SbCod3fy3kYCbu4ZzMyno0hcCEKHgbR6sHXFHyO9ZrUExKXJViHh8Zept2YYn85Ab2lCJqH/5nxKcNkbqGd8ITi+bBXs=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DB9PR08MB8203.eurprd08.prod.outlook.com (2603:10a6:10:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Tue, 31 Jan
 2023 15:31:29 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 15:31:29 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAAAvQEA==
Date:   Tue, 31 Jan 2023 15:31:29 +0000
Message-ID: <DBBPR08MB45383A156195FE6F218DC019F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DB9PR08MB8203:EE_|AM7EUR03FT027:EE_|AM0PR08MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 42313312-a165-45ea-4865-08db03a04155
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DlHW2ICwyrVx6E1Mi3gGv602KcsKhguBhAbE29Bh7tPqh5fabOFKqilbXiFd5wWo2i/LArCSBqdq8pA7nBjBxJxZsGT/Nr8oBKUpx37WPAw9eaw9Px5CY8tEDjlOpf+Py33UaLojiqPCxcjPff9xSjK/c0vY20lzKYJYK2gKnez8eT9Ynkb6q2tUFkZU3YPKZ3kGZnVEziSVYri82X8+RhByDd3ERgdekaAsZXaKvuVHeT2bAwCljzOijiZtyTWrh6Pj+zNypH54wo5GkvUMmPxjZjrpmaz364npyT4Tq+/GY0uilfvkf1tzZABCYtfJhWrqYFOQTh3XYy50NWYbtNsXYu7FbCFW0i8HswCQJW1AZ+94LydL5dsJ3LI05qvuHbPEKZmxtzmZb69oy+YLdpifnQYIWnzgvUs6XL6YiQLksiv3tQgu+C90s4Zh0PXPK4pmNnLZ15XDBmS4RB4Xshp6+xHcWlb8Ba/6NAiMkads2H/NaoWrHMVFPgZ71tyfBoRdkuxitHQjCKS0HYiUza80AR8M2E9jTAn/Y3dgUnUMKAzI1HxFoJ0aNkBQxSrnY4DOgdxcDPkOsOo3Q8BX2d3IB723gZ1Qu2E3bDpdxR6j909E5I+jTsehwTrlNDHqbLYoSWatlziu7CrgAvWjfry+0kcoSXBCaNsvSnZk+Xo0a2iakVQBKeeKXJOQ98JK1VZEo2rRBDW40r15z0eDQOp1SIeiTZHbfrPkzqYk98jeI71STKRbo+8IUJeXmz0P
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(53546011)(186003)(6506007)(122000001)(38100700002)(9686003)(26005)(2940100002)(2906002)(38070700005)(966005)(71200400001)(478600001)(316002)(110136005)(7696005)(55016003)(8936002)(52536014)(41300700001)(5660300002)(86362001)(4326008)(66476007)(76116006)(8676002)(83380400001)(66556008)(66946007)(64756008)(66446008)(33656002)(54906003)(10126625003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8203
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 62e67efd-4844-4007-dc62-08db03a0397b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR90efTG+e8Nnvk3fnXom1bCZKgdrXjWuGkNgcBcK1xIWsDD9aEknVLPm6ls+AsUtut9EJ6zbnb65pZbmfeVEW73Kv6gzObg+M+4KA1Q1MEA8+ba112zDLP76efK6AKfXicJnYD/cYlUI3A9Xh5Wkkcr1mCRFykFUNN/53mEbpKCz+2M/CG5OY87krwZdcOU1h927I1wbjcvsGk0jrSitXJjDDNtaybszESIXYYa5BZCUv5ESRObqN4ffzXsxP7TgNjkhDdUtZA/QQTwxPqxjA+V90jKSbRla9/PP0ud2beb6xTrxGXOcrB8F1MLe6rTfyR+AMHc+zqM87KjoGabn9NSYUtvqDeLEzycZ6zQaeHC7QMDuiQX/vrgbVn4hmrGMVC9W2OFN5ZnKbKYUx1oqIAluRICjDnsEP8y3uK7lCIbpWXpDZ2HQIP03y14hzOkMhy4uV1g9IzpxLsbsO2m5qVRVQbS2lfsfhOQ6QWBx/QVWYKEU7F/tOJihxuTwnodovN2iVwDgzRszj+JNcz7N8E/XsFDZaGerd9U57efq3msIowfhmGSCEA3F6SHnQ5iAJNGqnzJju7YaDL2hT37rOLkRIZYSBLl3+Wacwg9rzTr7kBveiD0F2FQ4B3PuV20tr/AVriJx/9YzRNLPYOBuIOCWlkUqSVaD5PP+sJvwHIDUengzK3Mz4JvWF4Fv+JSAUJ+TJA/wm4t7khBUCzc5PYIbi2gnlt1s3JQwBh/XLGlx+L5u5ZYcrumUTAyaCgLUBlWMcaPCh9PTFJUP5dlnA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(53546011)(9686003)(7696005)(186003)(40460700003)(6506007)(41300700001)(478600001)(966005)(2940100002)(26005)(336012)(110136005)(47076005)(54906003)(316002)(450100002)(70206006)(83380400001)(70586007)(2906002)(4326008)(8676002)(356005)(82740400003)(55016003)(36860700001)(81166007)(86362001)(5660300002)(33656002)(82310400005)(52536014)(40480700001)(8936002)(10126625003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 15:31:42.7878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42313312-a165-45ea-4865-08db03a04155
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5476
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVzdGluIEhlDQo+IFNl
bnQ6IFR1ZXNkYXksIEphbnVhcnkgMzEsIDIwMjMgMTE6MjIgUE0NCj4gVG86IEFyZCBCaWVzaGV1
dmVsIDxhcmRiQGtlcm5lbC5vcmc+OyBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNv
bT4NCj4gQ2M6IEh1YWNhaSBDaGVuIDxjaGVuaHVhY2FpQGtlcm5lbC5vcmc+OyBsaW51eC1lZmlA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbGV4YW5k
cnUgRWxpc2VpIDxBbGV4YW5kcnUuRWxpc2VpQGFybS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggMC8yXSBGaXggYm9vdCBoYW5nIGlzc3VlIG9uIEFtcGVyZSBFbWFnIHNlcnZlcg0KPg0KPiBI
aSBBcmQsDQo+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBcmQg
Qmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkg
MzEsIDIwMjMgMzoxOSBQTQ0KPiA+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsg
SmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+ID4gQ2M6IEh1YWNhaSBDaGVu
IDxjaGVuaHVhY2FpQGtlcm5lbC5vcmc+OyBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnOw0KPiA+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkgPEFsZXhhbmRy
dS5FbGlzZWlAYXJtLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gRml4IGJvb3Qg
aGFuZyBpc3N1ZSBvbiBBbXBlcmUgRW1hZyBzZXJ2ZXINCj4gPg0KPiA+IChjYyBKYXNvbiBmb3Ig
YXdhcmVuZXNzKQ0KPiA+DQo+ID4gT24gVHVlLCAzMSBKYW4gMjAyMyBhdCAwNTowNCwgSmlhIEhl
IDxqdXN0aW4uaGVAYXJtLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSSBtZXQgYSBodW5nIHRh
c2sgd2FybmluZyBhbmQgdGhlbiBrZXJuZWwgd2FzIGh1bmcgZm9yZXZlciB3aXRoIGxhdGVzdA0K
PiA+ID4ga2VybmVsIG9uIGFuIEFtcGVyZSBFbWFnIHNlcnZlci4NCj4gPiA+DQo+ID4gPiBUaGUg
cm9vdCBjYXVzZSBpcyBrZXJuZWwgd2FzIGh1bmcgIHdoZW4gaW52b2tpbmcgYW4gZWZpIHJ0cyBj
YWxsIHRvDQo+ID4gPiBzZXQgdGhlIFJhbmRvbVNlZWQgdmFyaWFibGUgZHVyaW5nIHRoZSBib290
aW5nIHN0YWdlLiBUaGUNCj4gPiA+IGFyY2hfZWZpX2NhbGxfdmlydCBjYWxsIChzZXRfdmFyaWFi
bGUpIHdhcyBuZXZlciByZXR1cm5lZCBhbmQgdGhlbiBjYXVzZWQNCj4gdGhlDQo+ID4gaHVuZyB0
YXNrIGVycm9yLg0KPiA+ID4NCj4gPg0KPiA+IEdpdmVuIHRoYXQgRUZJIHZhcmlhYmxlcyB3b3Jr
IG9uIHRoaXMgcGxhdGZvcm0gKGFzIGZhciBhcyBJIGtub3cpLCB0aGUgcHJvYmxlbQ0KPiA+IG1h
eSBiZSB0aGF0IHdlIGFyZSBjYWxsaW5nIFNldFZhcmlhYmxlKCkgdG9vIGVhcmx5Lg0KPiA+DQo+
ID4gQ291bGQgeW91IGRvdWJsZSBjaGVjayB3aGV0aGVyIHNldHRpbmcgdmFyaWFibGVzIHdvcmtz
IGFzIGV4cGVjdGVkPw0KPiA+IFlvdSBjYW4gdXNlIGVmaWJvb3RtZ3IgLXQgMTAgYXMgcm9vdCAo
Zm9yIGV4YW1wbGUpIHRvIHNldCB0aGUgYm9vdCB0aW1lb3V0LA0KPiBhbmQNCj4gPiBjaGVjayB3
aGV0aGVyIHRoZSBuZXcgdmFsdWUgaXMgcmV0YWluZWQgYWZ0ZXIgYSByZWJvb3QgKGVmaWJvb3Rt
Z3Igd2lsbCBwcmludA0KPiA+IHRoZSBjdXJyZW50IHZhbHVlIGZvciB5b3UpDQo+ID4NCj4gPiBD
b3VsZCB5b3UgYWxzbyBwbGVhc2Ugc2hhcmUgdGhlIGtlcm5lbCBsb2cgdXAgdW50aWwgdGhlIHBv
aW50IHdoZXJlIGl0IGhhbmdzPw0KPiA+DQo+IFRoZSBzZXRfdmFyaWFibGUgc2VlbXMgdG8gYmUg
b2sgaW4gNS4xOSs6DQo+IHJvb3RAOn4jIGVmaWJvb3RtZ3IgLXQgMTANCj4gQm9vdEN1cnJlbnQ6
IDAwMDANCj4gVGltZW91dDogMTAgc2Vjb25kcw0KPiBCb290T3JkZXI6IDAwMDAsMDAwNCwwMDAz
LDAwMDIsMDAwMQ0KPiBCb290MDAwMCogdWJ1bnR1DQo+IEJvb3QwMDAxKiBncnViDQo+IEJvb3Qw
MDAyKiBVRUZJOiBCdWlsdC1pbiBFRkkgU2hlbGwNCj4gQm9vdDAwMDMqIFVFRkk6IFBYRSBib290
IG9uIE1BQzogNEM6Mzg6RDU6MDg6RjY6MDINCj4gQm9vdDAwMDQqIHVidW50dQ0KPiByb290QDp+
IyBlZmlib290bWdyIC10IDkNCj4gQm9vdEN1cnJlbnQ6IDAwMDANCj4gVGltZW91dDogOSBzZWNv
bmRzDQo+IEJvb3RPcmRlcjogMDAwMCwwMDA0LDAwMDMsMDAwMiwwMDAxDQo+IEJvb3QwMDAwKiB1
YnVudHUNCj4gQm9vdDAwMDEqIGdydWINCj4gQm9vdDAwMDIqIFVFRkk6IEJ1aWx0LWluIEVGSSBT
aGVsbA0KPiBCb290MDAwMyogVUVGSTogUFhFIGJvb3Qgb24gTUFDOiA0QzozODpENTowODpGNjow
Mg0KPiBCb290MDAwNCogdWJ1bnR1DQo+IHJvb3RAOn4jIHVuYW1lIC1hDQo+IExpbnV4ICRtYWNo
aW5lX25hbWUgNS4xOS4wKyAjMjI4IFNNUCBXZWQgQXVnIDE3IDEzOjIyOjI5IFVUQyAyMDIyDQo+
IGFhcmNoNjQgYWFyY2g2NCBhYXJjaDY0IEdOVS9MaW51eA0KPg0KPiBUaGUgZG1lc2cgbG9nIHVu
dGlsIHRoZSBodW5nKHNvbWUgaW5mb3JtYXRpb24gd2FzIHJlbW92ZWQsIGVnLCBob3N0bmFtZSk6
DQo+DQpTb3JyeSwgSSBub3RpY2VkIG15IHByZXZpb3VzIG1haWwgbWlnaHQgYmUgYm91bmNlZCBi
YWNrIGlmIHRoZSB0ZXh0IGlzIHRvbyBsb25nLg0KSSBwYXN0ZWQgaXQgdG8gb25saW5lIFBhc3Rl
YmluLmNvbQ0KaHR0cHM6Ly9wYXN0ZWJpbi5jb20vM3pReXJ5cDENCg0KSG9wZSBpdCBoZWxwcw0K
DQpDaGVlcnMsDQpKdXN0aW4NCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlz
IGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28g
YmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhl
IGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9y
IHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4N
Cg==
