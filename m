Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2168D1F3
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBGJDA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 04:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGJC7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 04:02:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9D360B3;
        Tue,  7 Feb 2023 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8FqjsPbt1IyTbDFZPzB5xPypEhB5VYj63sQFhjgJkE=;
 b=KVnxqngg+MvNDlaFsm42V7NSWwPsfROqOCrwOLJPM/hR4VOPfLe4M1XEx7Bt26lQcHUyQTPQTw0cF7xmdOEuF3vkcAmyNBUcX170x1U4M0R1jVx3Pjzs98UC84+W1vpWX5JktCcO4h/N+npeb+/CPbux/Wb0JavsqhvwpZkBhMA=
Received: from DB7PR05CA0042.eurprd05.prod.outlook.com (2603:10a6:10:2e::19)
 by AS2PR08MB9102.eurprd08.prod.outlook.com (2603:10a6:20b:5fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 09:02:55 +0000
Received: from DBAEUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::7f) by DB7PR05CA0042.outlook.office365.com
 (2603:10a6:10:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 09:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT035.mail.protection.outlook.com (100.127.142.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 09:02:55 +0000
Received: ("Tessian outbound 0d7b2ab0f13d:v132"); Tue, 07 Feb 2023 09:02:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0c248caabcc0d869
X-CR-MTA-TID: 64aa7808
Received: from 767134529af3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9912B216-99D4-4A89-B338-65F22DC6BBF7.1;
        Tue, 07 Feb 2023 09:02:49 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 767134529af3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Feb 2023 09:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKdEzxkm7+QYvdznK2UhVf1gTYRuIU20Zab13g90yKmMIY5LZi2q/mSgt40nYJZ6DNZP9USbhNQN76qo/Tlc6cOSuXTBD6+/KNBL41xTAm6EwND3etMgjaFV89OBlv6Sunznu62kXMxPayjFH2cIxzSoDvm2DZfWW89NqH+exFIgOOaQE1MEk+d9tE432FkCwwfwPPq0287+Ij9kFEFtv1tF6GDIPpn5qpEDoGRtc4hDfArqL98XFhM9Hrktl/7PBZsdll0QAiHqNcPNPiW+6NRzfkCB5JyJkv+/14VU1F4KD1kp6ZF7peTPkgym0krXeL19Mt0sSlQalFuludLuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8FqjsPbt1IyTbDFZPzB5xPypEhB5VYj63sQFhjgJkE=;
 b=fL/oweLQrQodIYWo5srgPyzldLL5Jil0k/aZvq+ZEfpJkqlYBFe/EHmI59BLJY7Cu244gCkAywl14CQE+nbkUaSiq4wQWT+RzmAlyE1q4Tz5e1yDKI5aOSq/yBc2qw+2Tt/iNZVVIo6vcb2ZTbqUTqmO2WgxYUIz57yrL6lChBIg2HCzhTwRQN56CCYL0nA/63KD6q0GFztJepgTEHI2WOxKRk0gND0gsmP7dW5NRhSEgE8uKvdxxy1L4XPbLQcEGRqPXt2cN1/wSpxwfXhzhYt0TVM6gOXQJdHkFW+KOah+lVlza+ST9mQEV5OCCFXgg2iBJrz7fDW/dyrum29ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8FqjsPbt1IyTbDFZPzB5xPypEhB5VYj63sQFhjgJkE=;
 b=KVnxqngg+MvNDlaFsm42V7NSWwPsfROqOCrwOLJPM/hR4VOPfLe4M1XEx7Bt26lQcHUyQTPQTw0cF7xmdOEuF3vkcAmyNBUcX170x1U4M0R1jVx3Pjzs98UC84+W1vpWX5JktCcO4h/N+npeb+/CPbux/Wb0JavsqhvwpZkBhMA=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AS8PR08MB10151.eurprd08.prod.outlook.com (2603:10a6:20b:628::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 09:02:47 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:02:46 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQgAmHX6CAAF7PgIAAAKCggAACLQCAAAEaAA==
Date:   Tue, 7 Feb 2023 09:02:46 +0000
Message-ID: <DBBPR08MB453816F6266D9686CDE61F24F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com>
 <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
 <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
In-Reply-To: <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AS8PR08MB10151:EE_|DBAEUR03FT035:EE_|AS2PR08MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b93a568-cded-4dbd-0895-08db08ea1a14
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7T/ry5RrcdBCK7/acH4aE5urWtQQOMFvjBk/LUPk+mTtBDTfvPHWr2hnD9Rahtv0RCfEPi54SSrk1kh8EoGNsaUFOjYFsd8te0TnExg4GO+dG9mEqAMzPI7Ouc++h+/uGCCQcBJnorUn0vOfN61h/d39XjARciUtEK0MBxt6i4UfyNvoZF4SxLY6iszEx3i8NCAzIGb7negvmKelch27qY9JbPVFhLJZiF1Mmjla2sRDYAsubjf5FBHvUrPeFqEW/jSE7OQls0BMIcap4MPBNvcGzRVmB1HU3pALVxO9zxMkNM9MdZ09bsrSTRLeaAOa5LKBCXba638qFap3FmBrvQ/kvQqI2PgwBUih0/akvnBYQSlgzcN6v39Lh/Yjh/f57ioce7kLV3+Soojzc6nCYWOruF3apTOulHbt/0Pv62dT7W0LCOKAW9TSupWdXoPHPFJGOaJ6Y1AWwxCel9FsAK5Nx0UjyVWmH+Ih7YXVn/afGcup3mj8ACMrAOJlTc4+7qXjOX1+1aPxy8VL6ixoSsLiWXZvVrgb0ZPeCf1FjokrjCYYOIerk8YBIyuN0D0jiMs+M+jqklhDWUztotL/9sNnc4btB6Fb2TzubyIikYqlRbQh6JBBTPSz0POJyY0hDHaAwtU3lHm2bz9r3TqeQwbD7fTstmj54fpNJBRLa4lkGaeCCVH2iiuhohejgxxF8NPpudgNvyd6elVNO3HLgWVeWSzz6FbCtYsCPmlL5hsqprBn+3MBJ6kszD7a5uZY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199018)(53546011)(26005)(186003)(9686003)(6506007)(66476007)(41300700001)(38100700002)(66446008)(76116006)(4326008)(66556008)(66946007)(6916009)(64756008)(38070700005)(8676002)(8936002)(122000001)(5660300002)(2906002)(966005)(478600001)(52536014)(71200400001)(7696005)(83380400001)(55016003)(86362001)(316002)(33656002)(54906003)(10126625003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10151
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 39000369-be1c-4d2f-cf50-08db08ea14db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlM008/QeeMWcKp3J7it7wm8SRHoYcWTBuIHmq4V5SLmENhdTaI4grRtWJW7b1oYZMUTVQl1FOPh6AMs8aXh+2qQDe/YSPco8Y/QDQF1UbvRhkp5Un/xcmkkz5c5yIZAsDGh+C/DK78yUq27PEvrGbq75eauLmR4u8LjzDtskfqKmNBwFDyyiU35qk3DoVY35pWbS931Vpz+T2wUQlQ4KU14PPwalRfR5S7O2Sq3UN68RF1kAPaX92ONivRerNGrjHLgtW7ZolkejA6yDnf7kGnlmOLCaNL2/zGrlDK4vPEauEQ3/AxyK9J8ztXH9ovv5MnqtMmdFXbqqtvDxpb41cDoD+BbuTEv7Efgk+j+Rx+5bPKIS5DdxIP+VkwTQuE9QXSbs4twxZE5gih+BOn0XMe9SD3j2Y+ImasiYSUbBB5w0+aLNAFCmaMMnBTizS1xiq3a8cYfoaPkVOgYKg3vrrTw1rFBAtA7/1vysVwsS3Yth0pqw8UfQZR6LzCZj6qMkfYOxOa/nZTPAL8Oyw3/gzxcyixsepimy4O4PuG8Z9E0pe+2zwvsSV1OEU29RwjJNdpsQEVuiuR4Vlc7WYUO7RGLjojramNHGGc6E2+dOIpRmunfMypIsdRQTx0aeOayfYf+RVmRWUb+jbhuJVubjyKNNyclVP8JHUzl1bkOJXwVKmHBc4rjOroTETzb/kYD36DW11HCB8eK0A+/xun3xJmS3Pwd2paXeCMcUclxL7sGucB8rYSMARPhY+Q4sWc26vkUhTZ5uwAw/87vU7weIA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(83380400001)(40460700003)(40480700001)(336012)(186003)(86362001)(47076005)(356005)(81166007)(36860700001)(55016003)(82740400003)(450100002)(70206006)(70586007)(54906003)(316002)(8936002)(6862004)(5660300002)(8676002)(52536014)(4326008)(41300700001)(6506007)(9686003)(53546011)(26005)(7696005)(478600001)(966005)(33656002)(10126625003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 09:02:55.5790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b93a568-cded-4dbd-0895-08db08ea1a14
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9102
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNo
ZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNywgMjAy
MyA0OjU0IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogSHVh
Y2FpIENoZW4gPGNoZW5odWFjYWlAa2VybmVsLm9yZz47IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkgPEFs
ZXhhbmRydS5FbGlzZWlAYXJtLmNvbT47DQo+IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25Aengy
YzQuY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBGaXgg
Ym9vdCBoYW5nIGlzc3VlIG9uIEFtcGVyZSBFbWFnIHNlcnZlcg0KPiANCj4gT24gVHVlLCA3IEZl
YiAyMDIzIGF0IDA5OjQ5LCBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gWy4uXQ0K
PiA+ID4gPiBUaGUgcm9vdCBjYXVzZSBvZiB0aGUgaHVuZyBJTU8gbWlnaHQgYmUgc2ltaWxhciB0
byBjb21taXQNCj4gPiA+ID4gNTUwYjMzY2ZkNDQ1Mjk2ODY4YTQ3OGU4NDEzZmZiMmU5NjNlZWQz
Mg0KPiA+ID4gPiBBdXRob3I6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4g
PiA+IERhdGU6ICAgVGh1IE5vdiAxMCAxMDozNjoyMCAyMDIyICswMTAwDQo+ID4gPiA+DQo+ID4g
PiA+ICAgICBhcm02NDogZWZpOiBGb3JjZSB0aGUgdXNlIG9mIFNldFZpcnR1YWxBZGRyZXNzTWFw
KCkgb24gQWx0cmENCj4gPiA+ID4gbWFjaGluZXMNCj4gPiA+ID4NCj4gPiA+ID4gRG8geW91IGFn
cmVlIHdpdGggdGhlIGlkZWEgaWYgSSBhZGQgQW1wZXJlIOKAnWVNQUfigJ0gbWFjaGluZSBpbnRv
IHRoZQ0KPiA+ID4gPiBsaXN0IG9mIFVzaW5nIFNldFZpcnR1YWxBZGRyZXNzTWFwKCkgZm9yY2li
bHk/DQo+ID4gPiA+DQo+ID4gPiA+IFBsZWFzZSBub3RlIHRoYXQgZXZlbiBpbiBwcmV2aW91cyBr
ZXJuZWwgcGF0Y2gsIHRoZSBlZmlib290bWdyIC10DQo+ID4gPiA+IDEwIHdpbGwgbWFrZSBrZXJu
ZWwgaHVuZyBpZiBJIHBhc3NlZCAiZWZpPW5vdmFtYXAiIHRvIHRoZSBib290DQo+IHBhcmFtZXRl
ci4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJbnRlcmVzdGluZy4gV2hhdCBkb2VzIGRtaWRlY29k
ZSByZXR1cm4gZm9yIHRoZSBmYW1pbHkgaW4gdGhlIHR5cGUgMQ0KPiByZWNvcmQ/DQo+ID4NCj4g
PiAjIGRtaWRlY29kZSB8Z3JlcCAtaSBmYW1pbHkNCj4gPiAgICAgICAgIEZhbWlseTogZU1BRw0K
PiA+ICAgICAgICAgRmFtaWx5OiBBUk12OA0KPiA+DQo+ID4gVGhlIGZ1bGwgZG1pZGVjb2RlIGxv
ZyBpcyBhdCBodHRwczovL3Bhc3RlYmluLmNvbS9NM01BSnRVRw0KPiA+DQo+IA0KPiBPSyBwbGVh
c2UgdHJ5IHRoaXM6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGli
c3R1Yi9hcm02NC5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC5jDQo+
IGluZGV4IGZmMmQxOGM0MmVlNzQ5NzkuLmZhZTkzMGRlYzgyYmU3YzYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQuYw0KPiArKysgYi9kcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL2FybTY0LmMNCj4gQEAgLTIyLDcgKzIyLDggQEAgc3RhdGljIGJv
b2wgc3lzdGVtX25lZWRzX3ZhbWFwKHZvaWQpDQo+ICAgICAgICAgICogQW1wZXJlIEFsdHJhIG1h
Y2hpbmVzIGNyYXNoIGluIFNldFRpbWUoKSBpZg0KPiBTZXRWaXJ0dWFsQWRkcmVzc01hcCgpDQo+
ICAgICAgICAgICogaGFzIG5vdCBiZWVuIGNhbGxlZCBwcmlvci4NCj4gICAgICAgICAgKi8NCj4g
LSAgICAgICBpZiAoIXR5cGUxX2ZhbWlseSB8fCBzdHJjbXAodHlwZTFfZmFtaWx5LCAiQWx0cmEi
KSkNCj4gKyAgICAgICBpZiAoIXR5cGUxX2ZhbWlseSB8fA0KPiArICAgICAgICAgICAoc3RyY21w
KHR5cGUxX2ZhbWlseSwgIkFsdHJhIikgJiYgc3RyY21wKHR5cGUxX2ZhbWlseSwNCj4gKyAiZU1B
RyIpKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+ICAgICAgICAgZWZp
X3dhcm4oIldvcmtpbmcgYXJvdW5kIGJyb2tlbiBTZXRWaXJ0dWFsQWRkcmVzc01hcCgpXG4iKTsN
Cg0KWWVzLCBpdCB3b3JrcyBvbiBteSBlTUFHIHNlcnZlcjogdGhlIGtlcm5lbCBib290cy4NCk90
aGVyIHRoYW4gZWZpYm9vdG1nciBmYWlsdXJlLiBCdXQgSSBub3RpY2VkIHRoaXMgZWZpYm9vdG1n
ciBmYWlsdXJlIGV2ZW4gYmVmb3JlDQpDb21taXQgZDM1NDlhOTM4YjcgKCJhdm9pZCBTZXRWaXJ0
dWFsQWRkcmVzc01hcCgpIHdoZW4gcG9zc2libGUgIikNCg0Kcm9vdEA6fi9saW51eCMgZWZpYm9v
dG1nciAtdCA5OyBlZmlib290bWdyIC10IDU7DQpDb3VsZCBub3Qgc2V0IFRpbWVvdXQ6IElucHV0
L291dHB1dCBlcnJvcg0KQ291bGQgbm90IHNldCBUaW1lb3V0OiBJbnB1dC9vdXRwdXQgZXJyb3IN
Cg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
