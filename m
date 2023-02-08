Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3E268E67B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 04:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBHDK5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 22:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHDK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 22:10:56 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF924C86;
        Tue,  7 Feb 2023 19:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z9RNc06KW6/orqescicRSWUv+ZHJBguR/HMy4aOHQs=;
 b=WyGtvQDkaSau2r7Kmzr5KaXsdRtd5mhgzLPvknYezSbGFHtXckeoyuPf/gmmOZlKbl+pc4VENxfID8sB2eCHrWlgzfpQYl7mbn5lOOItywhoa2PR4GjKbtqdRb+d57BMLpdRaSkeiqhOH/RlCrjY/nwnu5MbsJ1k1eW4JCYCVbo=
Received: from DU2PR04CA0160.eurprd04.prod.outlook.com (2603:10a6:10:2b0::15)
 by VE1PR08MB5725.eurprd08.prod.outlook.com (2603:10a6:800:1b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 03:10:45 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::aa) by DU2PR04CA0160.outlook.office365.com
 (2603:10a6:10:2b0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 03:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 03:10:45 +0000
Received: ("Tessian outbound baf1b7a96f25:v132"); Wed, 08 Feb 2023 03:10:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bccdc397a830e613
X-CR-MTA-TID: 64aa7808
Received: from 451f029d4e20.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E3F0EC4D-CBA8-4231-A927-6E0C50A9FF18.1;
        Wed, 08 Feb 2023 03:10:38 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 451f029d4e20.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Feb 2023 03:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaXu0ROJSInZZZzt25GkjIx9/U2UAbto++2ZT60Hno9hUFWArAMs++RyRrrtpgXj2CEEAE0MmIqCmun+gcrLYkkYkqJLAcPexkxvcgTh2XHc6pT+E43pFsjO/kCleOrLyYlQ6Q7/DOUvyGbZ9EtG/+3VbHgnpa+rxU35cXcO1zEGiMicYujuKpgoezhsSRcp/pN1+lY86LGXaObGHJK0+fTLqlREzskpnQi06U+H50LkgcAk5c6cm1OAumiTus9QW1WynEbeZj3q0x22eD76Zqa0+RC8AJMmCCdVglJDLs+4ruvVoRHSoNF7nXwe50oiHAxkkrRtK6qpW6eLkRHdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z9RNc06KW6/orqescicRSWUv+ZHJBguR/HMy4aOHQs=;
 b=ZjfMDhm4lYN9RYvfatDaoj4KSImABI6aRR6QRTKfAqLq8LQZ1XKnyAVYDs/EhuXcDCqctSV5WDRpEOE1N+cYwZsLdMs2Yc59694CjAZlLCwoOzRJeGZPDk1YXePCJCwrrULAbqRoFHkFHC4BuluVd+AMvNqCpwIi1Sb1nhV3rHq7krLm/nVYJx8WR0/ZbIPB/BaLMXKgOv3HnygsYFqTmni3M9xBalHarz+DpXyw9+0nxg1lHW0+7bOK1m7eVXZtaUDg1tcLZVSd06viLdOS1Yjy2HZtKE+bfKQgYT7Y1qxLjthMxuQ5gUidiVbU2GAOgDtRLjP6Wg9mrFsXIxk3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z9RNc06KW6/orqescicRSWUv+ZHJBguR/HMy4aOHQs=;
 b=WyGtvQDkaSau2r7Kmzr5KaXsdRtd5mhgzLPvknYezSbGFHtXckeoyuPf/gmmOZlKbl+pc4VENxfID8sB2eCHrWlgzfpQYl7mbn5lOOItywhoa2PR4GjKbtqdRb+d57BMLpdRaSkeiqhOH/RlCrjY/nwnu5MbsJ1k1eW4JCYCVbo=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AS8PR08MB5989.eurprd08.prod.outlook.com (2603:10a6:20b:297::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 03:10:28 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 03:10:27 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQgAmHX6CAAF7PgIAAAKCggAACLQCAAAEaAIAAAZ+AgAAAqRCAAADogIABK7bw
Date:   Wed, 8 Feb 2023 03:10:26 +0000
Message-ID: <DBBPR08MB4538A93FD989ACB7B32D6A1AF7D89@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com>
 <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
 <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
 <DBBPR08MB453816F6266D9686CDE61F24F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFwn9epkakWBd537seUK48EfmxQz0fNi=h3L2SDTW24Bw@mail.gmail.com>
 <DBBPR08MB45383609E2B01955E5E0C81AF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXHQsbuEZbtH9XOp64BxwOroppockkEp7KhbKkWbdpExKw@mail.gmail.com>
In-Reply-To: <CAMj1kXHQsbuEZbtH9XOp64BxwOroppockkEp7KhbKkWbdpExKw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AS8PR08MB5989:EE_|DBAEUR03FT051:EE_|VE1PR08MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d40b78-71e1-4ec6-6aef-08db09821205
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: s9/EvD2sXVd40C+He2L+IlYIpD+cXu5cnWIHu7S4w1xfjXYrkyx0CO2n6aF/bJjn7hpHLhXkoOI5eGTUE+RGoNvqwsGX2nRTnRK/n8Yftvf6Y8slfxkuwjKrgB9ktDbAy81Zwu2AadUfR3PIfz5gQbFvMpegdroALBiFxGATibQs7G5dUpREK+UJ1hzgdPxo8XrGAosr8BuTgAMbgAZb/jLUyxIuV9j6E6gYBYcEoDPOjTOjTj3PdyOX/rthYWtXi4xSItI/wF9g3mFdXK5N+0JCsXbaPaDDCo/LiGRb4A6uvFBa7iL3o+jncjDiDyFNAswLjvlExfNqWu5htIGN5UtDAUg1mfIwDVBpewlUDoBzExEX5IwbTVt9amMPc7PNTiRRq7bF9mBdvBqdg4ucziELJwAH3v+VsyD4j5sl4m4l7bhwD4+G4nUTzfi8HLIDB9sSFWO6r7qAjVPVOB1QPWtuBIDtPGpgnLzuaa5hhlrkPVJRecNCHv5rMHHg7vVeN0tGkiUZN5L7unRXOmDS0CzmLVuTA4MvjyJgIgpv3TWNPmQCKqmXex0IYFqaVITzi2bVTk6Ns9vRG4Ujxe4WZ0ERKHePXXZfvGcex0kDTlOjnIWiif2oxHUFnt67mllio8nIP29PfmNuE7mo0/XIN1nLJOm7HMR0kKI9cmRLQgAagVI/BkVLFGr+TPaSnJSmq6Uz+eOoxETLTy3corORXSec4TMNc4TSIxwZRLaK0aMK7SAjqPgB86955kFbePpN6RJ2PRRj1Ce83oH+3lsUpG8LGYXyI5nc0G5vu5NhEyE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(53546011)(6506007)(966005)(26005)(478600001)(186003)(9686003)(71200400001)(7696005)(83380400001)(54906003)(316002)(76116006)(66946007)(66446008)(66556008)(66476007)(38100700002)(122000001)(6916009)(4326008)(8676002)(64756008)(52536014)(8936002)(2906002)(55016003)(38070700005)(86362001)(5660300002)(41300700001)(33656002)(10126625003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5989
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 88301af9-0822-4cbe-d2eb-08db098206ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15uVPzHGxctlY6r6rx73T06nLkrYtZ9wLsYxKuZBe4k8fEl9FGiX7oOMJYKEzITaDdlGDoRTxlc/+f2ixe7cLMPhLyUpkrkeklAZn8HedxHc8RjiNppq0GZJMmlGwrqgGvpaevK1E/ZCdBTpG2T0/nTC8KNsbNqkVX20tiEt7+tRTtjUP0VzRGj9+AaxtzJ7+S/+ocWSNRNgsg9TW8rQEfYNwPDRLtC7gefTreWcGgO0NY0XFwO6TY+GNPJWvA4k93TqwUGwdv2RDWEyf0U1zcYB2wF/xBhjNP6N2zSj+VlhFZQwQG3/JlutqZ0aK5LlZeqD8oFXhIWhlgF2Uk/XRv9TAKEZ+jKQyYn22hi0SuGQKHv3D9Gyjc+oAZRTm/Gv70WBnM8EaSxyVPBNn7PeoywcfkT4YTTDLgJ94m7biZklG+X9U+KcKsZgA++lkXaBoava+XyQtsBOwSrQlmwydLrbWj3xMIKuoGU/mLQUXunxjarEi2WDkt1bgadqMxltbzh7oQXoW0GUQzxXsxJXxc3qHSjkK6rDuqxLM96bl3xkZaTj8Hg3uDh/eD5nOgaL8esaZGVb/HVPbigR7l1dCAQG+bb57KY3macBG4BMKeXt8JIUpyQOs6LjjVeJUiRz9bH5Ahtw3sNFKJMxZwyzYD2DD9gdSDPhW8WUIu3p58uQVYXXQRImdG/jDaVPGrNCpAv9UAaLKqT0vnZpbh9ITypkHRMdTazbuRPzp3PKJ/iimvb66LTxqhlpUEyJ6VtqOP4E9F54Tj4ayTtA+/nORTQFgnbQgwkJhVHB2c/RdE0=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(41300700001)(2906002)(54906003)(70206006)(316002)(8936002)(52536014)(6862004)(8676002)(7696005)(966005)(478600001)(6506007)(53546011)(9686003)(186003)(26005)(82310400005)(33656002)(55016003)(40480700001)(336012)(356005)(86362001)(83380400001)(40460700003)(47076005)(82740400003)(70586007)(450100002)(4326008)(36860700001)(81166007)(10126625003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 03:10:45.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d40b78-71e1-4ec6-6aef-08db09821205
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5725
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
MyA1OjA5IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogSHVh
Y2FpIENoZW4gPGNoZW5odWFjYWlAa2VybmVsLm9yZz47IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkgPEFs
ZXhhbmRydS5FbGlzZWlAYXJtLmNvbT47DQo+IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25Aengy
YzQuY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBGaXgg
Ym9vdCBoYW5nIGlzc3VlIG9uIEFtcGVyZSBFbWFnIHNlcnZlcg0KPiANCj4gT24gVHVlLCA3IEZl
YiAyMDIzIGF0IDEwOjA4LCBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgNywgMjAyMyA1OjA0IFBNDQo+ID4gPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVA
YXJtLmNvbT4NCj4gPiA+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPjsg
bGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEFsZXhhbmRydSBFbGlzZWkNCj4gPiA+IDxBbGV4YW5kcnUuRWxpc2VpQGFybS5jb20+
OyBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT47IG5kDQo+ID4gPiA8bmRAYXJt
LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBGaXggYm9vdCBoYW5nIGlzc3Vl
IG9uIEFtcGVyZSBFbWFnIHNlcnZlcg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgNyBGZWIgMjAyMyBh
dCAxMDowMywgSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IEhpIEFyZA0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiA+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4g
PiA+ID4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA3LCAyMDIzIDQ6NTQgUE0NCj4gPiA+ID4g
PiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gPiA+ID4gPiBDYzogSHVhY2Fp
IENoZW4gPGNoZW5odWFjYWlAa2VybmVsLm9yZz47DQo+ID4gPiA+ID4gbGludXgtZWZpQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiBBbGV4
YW5kcnUgRWxpc2VpIDxBbGV4YW5kcnUuRWxpc2VpQGFybS5jb20+OyBKYXNvbiBBLiBEb25lbmZl
bGQNCj4gPiA+ID4gPiA8SmFzb25AengyYzQuY29tPjsgbmQgPG5kQGFybS5jb20+DQo+ID4gPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIEZpeCBib290IGhhbmcgaXNzdWUgb24gQW1wZXJl
IEVtYWcNCj4gPiA+ID4gPiBzZXJ2ZXINCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFR1ZSwgNyBG
ZWIgMjAyMyBhdCAwOTo0OSwgSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBbLi5dDQo+ID4gPiA+ID4gPiA+ID4g
VGhlIHJvb3QgY2F1c2Ugb2YgdGhlIGh1bmcgSU1PIG1pZ2h0IGJlIHNpbWlsYXIgdG8gY29tbWl0
DQo+ID4gPiA+ID4gPiA+ID4gNTUwYjMzY2ZkNDQ1Mjk2ODY4YTQ3OGU4NDEzZmZiMmU5NjNlZWQz
Mg0KPiA+ID4gPiA+ID4gPiA+IEF1dGhvcjogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4NCj4gPiA+ID4gPiA+ID4gPiBEYXRlOiAgIFRodSBOb3YgMTAgMTA6MzY6MjAgMjAyMiArMDEw
MA0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gICAgIGFybTY0OiBlZmk6IEZvcmNl
IHRoZSB1c2Ugb2YgU2V0VmlydHVhbEFkZHJlc3NNYXAoKSBvbg0KPiA+ID4gPiA+ID4gPiA+IEFs
dHJhIG1hY2hpbmVzDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBEbyB5b3UgYWdy
ZWUgd2l0aCB0aGUgaWRlYSBpZiBJIGFkZCBBbXBlcmUg4oCdZU1BR+KAnSBtYWNoaW5lDQo+ID4g
PiA+ID4gPiA+ID4gaW50byB0aGUgbGlzdCBvZiBVc2luZyBTZXRWaXJ0dWFsQWRkcmVzc01hcCgp
IGZvcmNpYmx5Pw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gUGxlYXNlIG5vdGUg
dGhhdCBldmVuIGluIHByZXZpb3VzIGtlcm5lbCBwYXRjaCwgdGhlDQo+ID4gPiA+ID4gPiA+ID4g
ZWZpYm9vdG1nciAtdA0KPiA+ID4gPiA+ID4gPiA+IDEwIHdpbGwgbWFrZSBrZXJuZWwgaHVuZyBp
ZiBJIHBhc3NlZCAiZWZpPW5vdmFtYXAiIHRvIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGJvb3QNCj4g
PiA+ID4gPiBwYXJhbWV0ZXIuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gSW50ZXJlc3RpbmcuIFdoYXQgZG9lcyBkbWlkZWNvZGUgcmV0dXJuIGZvciB0aGUg
ZmFtaWx5IGluDQo+ID4gPiA+ID4gPiA+IHRoZSB0eXBlIDENCj4gPiA+ID4gPiByZWNvcmQ/DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIyBkbWlkZWNvZGUgfGdyZXAgLWkgZmFtaWx5DQo+ID4g
PiA+ID4gPiAgICAgICAgIEZhbWlseTogZU1BRw0KPiA+ID4gPiA+ID4gICAgICAgICBGYW1pbHk6
IEFSTXY4DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIGZ1bGwgZG1pZGVjb2RlIGxvZyBp
cyBhdCBodHRwczovL3Bhc3RlYmluLmNvbS9NM01BSnRVRw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IE9LIHBsZWFzZSB0cnkgdGhpczoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LmMNCj4gPiA+ID4g
PiBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQuYw0KPiA+ID4gPiA+IGluZGV4
IGZmMmQxOGM0MmVlNzQ5NzkuLmZhZTkzMGRlYzgyYmU3YzYgMTAwNjQ0DQo+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC5jDQo+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC5jDQo+ID4gPiA+ID4gQEAgLTIyLDcg
KzIyLDggQEAgc3RhdGljIGJvb2wgc3lzdGVtX25lZWRzX3ZhbWFwKHZvaWQpDQo+ID4gPiA+ID4g
ICAgICAgICAgKiBBbXBlcmUgQWx0cmEgbWFjaGluZXMgY3Jhc2ggaW4gU2V0VGltZSgpIGlmDQo+
ID4gPiA+ID4gU2V0VmlydHVhbEFkZHJlc3NNYXAoKQ0KPiA+ID4gPiA+ICAgICAgICAgICogaGFz
IG5vdCBiZWVuIGNhbGxlZCBwcmlvci4NCj4gPiA+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gPiA+
IC0gICAgICAgaWYgKCF0eXBlMV9mYW1pbHkgfHwgc3RyY21wKHR5cGUxX2ZhbWlseSwgIkFsdHJh
IikpDQo+ID4gPiA+ID4gKyAgICAgICBpZiAoIXR5cGUxX2ZhbWlseSB8fA0KPiA+ID4gPiA+ICsg
ICAgICAgICAgIChzdHJjbXAodHlwZTFfZmFtaWx5LCAiQWx0cmEiKSAmJg0KPiA+ID4gPiA+ICsg
c3RyY21wKHR5cGUxX2ZhbWlseSwNCj4gPiA+ID4gPiArICJlTUFHIikpKQ0KPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAg
IGVmaV93YXJuKCJXb3JraW5nIGFyb3VuZCBicm9rZW4NCj4gPiA+ID4gPiBTZXRWaXJ0dWFsQWRk
cmVzc01hcCgpXG4iKTsNCj4gPiA+ID4NCj4gPiA+ID4gWWVzLCBpdCB3b3JrcyBvbiBteSBlTUFH
IHNlcnZlcjogdGhlIGtlcm5lbCBib290cy4NCj4gPiA+ID4gT3RoZXIgdGhhbiBlZmlib290bWdy
IGZhaWx1cmUuIEJ1dCBJIG5vdGljZWQgdGhpcyBlZmlib290bWdyDQo+ID4gPiA+IGZhaWx1cmUg
ZXZlbiBiZWZvcmUgQ29tbWl0IGQzNTQ5YTkzOGI3ICgiYXZvaWQNCj4gPiA+ID4gU2V0VmlydHVh
bEFkZHJlc3NNYXAoKSB3aGVuIHBvc3NpYmxlICIpDQo+ID4gPiA+DQo+ID4gPiA+IHJvb3RAOn4v
bGludXgjIGVmaWJvb3RtZ3IgLXQgOTsgZWZpYm9vdG1nciAtdCA1OyBDb3VsZCBub3Qgc2V0DQo+
ID4gPiA+IFRpbWVvdXQ6IElucHV0L291dHB1dCBlcnJvciBDb3VsZCBub3Qgc2V0IFRpbWVvdXQ6
IElucHV0L291dHB1dA0KPiA+ID4gPiBlcnJvcg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IERvIHlv
dSBnZXQgYW55IFtGaXJtd2FyZSBCdWddIGxpbmVzIGluIHRoZSBrZXJuZWwgbG9nPw0KPiA+DQo+
ID4gTm8sDQo+ID4gSSBidWlsdCB0aGUga2VybmVsIGJhc2VkIG9uOg0KPiA+IGNvbW1pdCBkMmQx
MWYzNDJiMTc5ZjE4OTRhOTAxZjE0M2VjN2MwMDhjYWJhNDNlIChIRUFEIC0+IG1hc3RlciwNCj4g
PiBvcmlnaW4vbWFzdGVyLCBvcmlnaW4vSEVBRCkNCj4gPiBBdXRob3I6IExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBEYXRlOiAgIFN1biBGZWIgNSAx
NzoxNzoxMCAyMDIzIC0wODAwDQo+ID4NCj4gPiAgICAgTWVyZ2UgYnJhbmNoICdmaXhlcycgb2YN
Cj4gPiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmlyby92
ZnMNCj4gPg0KPiA+IEFyZSB5b3Ugd29ycmllZCBhYm91dCB5b3VyIHN5bmMgZXhjZXB0aW9uIGZp
eHVwIHBhdGNoPyBJIHRoaW5rIGl0IGhhcyBiZWVuDQo+IGluY2x1ZGVkLg0KPiA+DQo+IA0KPiAN
Cj4gSSB3b3VsZCBqdXN0IGxpa2UgdG8gdW5kZXJzdGFuZCB3aHkgc2V0dmFyaWFibGUgaXMgc3Rp
bGwgYnJva2VuIGZvciB5b3UuDQoNCk9uIGFuIEFtcGVyZSAqQWx0cmEqIHNlcnZlciwgdGhlIGZh
bWlseSBuYW1lIHNlZW1zIHRvIG5vdCBmb2xsb3cgeW91ciBwdXJwb3NlIG9mIGludm9raW5nIGVm
aV9nZXRfc21iaW9zX3N0cmluZygxLCBmYW1pbHkpLg0KDQpkbWlkZWNvZGUgfGdyZXAgLWkgZmFt
aWx5IC1DIDEwDQoNCkhhbmRsZSAweDAwMDEsIERNSSB0eXBlIDEsIDI3IGJ5dGVzDQpTeXN0ZW0g
SW5mb3JtYXRpb24NCiAgICAgICAgTWFudWZhY3R1cmVyOiBHSUdBQllURQ0KICAgICAgICBQcm9k
dWN0IE5hbWU6IFIyNzItUDMwLTAwDQogICAgICAgIFZlcnNpb246IDAxMDANCiAgICAgICAgU2Vy
aWFsIE51bWJlcjogVFMyMDM1ODEyQTAwMjINCiAgICAgICAgVVVJRDogMDAwMDAwMDAtMDAwMC00
MDAwLTgwMDAtQjQyRTk5QUZFRjYyDQogICAgICAgIFdha2UtdXAgVHlwZTogUG93ZXIgU3dpdGNo
DQogICAgICAgIFNLVSBOdW1iZXI6IDAxMjM0NTY3ODkwMTIzNDU2Nzg5QUINCiAgICAgICAgRmFt
aWx5OiBTZXJ2ZXINCg0KVGhlIGZ1bGwgZG1pZGVjb2RlIGluZm8gb2YgQWx0cmEgaXMgYXQNCmh0
dHBzOi8vcGFzdGViaW4uY29tL0hRTEUxeVl2DQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBI
ZSkNCg==
