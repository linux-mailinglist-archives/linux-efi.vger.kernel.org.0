Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFF101A4F
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfKSH2R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 02:28:17 -0500
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:45433
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfKSH2R (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 Nov 2019 02:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI85LatNGsnjd34rlqJ/tSHTysomF+qKHUfRah+sONM=;
 b=2pSIHm+BjGFQhO11kSnf1oylfmox+a4EvPBSKaze6CS3pReSOYzsH9yBu+IM5j7pDG62n3KjwnYSM9HeQVe/TRL1iqr/96rXqbEJpWSNpJkBP7BqqxIaWIKX7AEGvbYGsKPBDy/8c0zFeRG/HC0CEn9EWg2rGgbC6BlgM0Vru08=
Received: from VI1PR08CA0203.eurprd08.prod.outlook.com (2603:10a6:800:d2::33)
 by AM6PR08MB4659.eurprd08.prod.outlook.com (2603:10a6:20b:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Tue, 19 Nov
 2019 07:28:05 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR08CA0203.outlook.office365.com
 (2603:10a6:800:d2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27 via Frontend
 Transport; Tue, 19 Nov 2019 07:28:05 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 07:28:05 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 19 Nov 2019 07:28:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from 11d782298a8d.1 (cr-mta-lb-1.cr-mta-net [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F13063B1-44E8-4925-9E43-EADE558BA1A6.1;
        Tue, 19 Nov 2019 07:27:58 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 11d782298a8d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 19 Nov 2019 07:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B15B4wwoz5tfvtGlSpYgJFZIeMzN/DgYde0JrnDro31jeNnxuAV+v8iHlFdGUu3v1Lj3yRU6TCi86CM11NmSWh0y3yXcnv2k+nzuTBS21QF2ZcMha9pAKugGHg7BSKFjj97aaNK6wyYklobdDq80s9hocsU6zvlFHuidtQdxWTd2e7bnvxFDuBSQT/O4A+ip1dOy/g/g6CdNwPDzJnVtmBLwL8sXptar/LvFCclGb+zenG1LXOXBy1J0/nahLPgACiNmNaCUHuGUb8GIvJLITgmJ0ZdIxkB2PEGLdw275QhP4Nz1jOw+GoywlFF3YnPe1PfupIpEC/v8nUYSRCnghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcFmcCoTpSvT2IcKQgtIAnu7d6u2ZlFE6hmml6Oa7Ho=;
 b=PB1AjF6w6cyZoujM31ceGQ7BPMrewSP3N9q2s9WAOZZ9okI5Vfj018wY550QuyhuxdlRBKu2i7jaBk/M9YRrTNmKyXte7k/5oYRjErhw5mkoAY4GvMc1mJf5jZVUPkqE9evXV1UDLhHJUBu4tpB7EgeYY01/xrJAM62GrvFas/3IrjhJV47UiPfwEuWm3Y6oKt6TUzDb9A78P4kJJw9gUSfIUrH7oChomCekje/3WO6qlUhCBEOJjgl4VaBXGDbyMSNw8rAaklS8xeoweA0VUgRV+8DPcqQay+qpcEmI36iiWydM33BQAT4E63kPCN0xn/BWCKb8wh8UtNxSDKcQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcFmcCoTpSvT2IcKQgtIAnu7d6u2ZlFE6hmml6Oa7Ho=;
 b=cEK+yuk8FZCcEiydR6zqATj/1zQ3U6IsWjx7OK3WBE/BK5gK2RRL/hwovvEIffQJVvZXXeEWHT8c4CBPMNwFxwt+MAyK0eHKfp3wsY0BLqAx4qEwEK2FkpunTI2hyVJLPRLC2KL19dtBIYVA8AzXvvBQEMtkZH8hxH7TSuveBNA=
Received: from DBBPR08MB4678.eurprd08.prod.outlook.com (20.179.47.74) by
 DBBPR08MB4757.eurprd08.prod.outlook.com (10.255.78.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Tue, 19 Nov 2019 07:27:57 +0000
Received: from DBBPR08MB4678.eurprd08.prod.outlook.com
 ([fe80::1129:c6c:af7d:8fa4]) by DBBPR08MB4678.eurprd08.prod.outlook.com
 ([fe80::1129:c6c:af7d:8fa4%4]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 07:27:57 +0000
From:   Guillaume Gardet <Guillaume.Gardet@arm.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <Mark.Rutland@arm.com>
CC:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [PATCH 0/1] Temporary fix for data abort on armv6z EFI boot
Thread-Topic: [PATCH 0/1] Temporary fix for data abort on armv6z EFI boot
Thread-Index: AQHVnkgnFaRcustBe0Ke7DfBFs8mjaeR0qeAgABGD/A=
Date:   Tue, 19 Nov 2019 07:27:57 +0000
Message-ID: <DBBPR08MB4678DD16CF3A091670580EA4834C0@DBBPR08MB4678.eurprd08.prod.outlook.com>
References: <20191118174252.26758-1-cristian.ciocaltea@gmail.com>
 <20191118181020.GA17031@lakrids.cambridge.arm.com>
 <CAKv+Gu_Ob5T6FfDo7dHnC+eF09_89HW2uYZv2J9A6+7jn65w0w@mail.gmail.com>
 <20191118185116.GB17031@lakrids.cambridge.arm.com>
 <CAKv+Gu8KGQ_+sLL01yGhr5m4YbH2a7tDS9F33=oe=b_3Z5tyLQ@mail.gmail.com>
 <8a4237f7-6757-1fea-0f4a-b78e4b698799@gmx.de>
In-Reply-To: <8a4237f7-6757-1fea-0f4a-b78e4b698799@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5995094c-372b-4ced-8bf9-4bab70126be2.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Guillaume.Gardet@arm.com; 
x-originating-ip: [2a01:e0a:d7:1620:15e2:cc59:61c0:27cd]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e969b2d9-fb70-456b-2194-08d76cc204c6
X-MS-TrafficTypeDiagnostic: DBBPR08MB4757:|DBBPR08MB4757:|AM6PR08MB4659:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB465905F007F18D829FA35412834C0@AM6PR08MB4659.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 022649CC2C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(13464003)(66946007)(76116006)(305945005)(66556008)(74316002)(25786009)(53546011)(66476007)(64756008)(66446008)(71190400001)(6506007)(52536014)(71200400001)(2906002)(6116002)(14454004)(966005)(33656002)(229853002)(4326008)(6246003)(81156014)(8936002)(8676002)(81166006)(6436002)(9686003)(6306002)(86362001)(99286004)(76176011)(7736002)(7696005)(14444005)(256004)(11346002)(446003)(186003)(55016002)(102836004)(5660300002)(46003)(316002)(478600001)(54906003)(6636002)(110136005)(486006)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4757;H:DBBPR08MB4678.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: H/gh8O2ufsp8pSZQWMnfhGR+tJ27ywOOk/ntktBo4u2FVMCwWZ/5HuVKGB9yNypMwuhKWvU0secCnqiDW/eiO8h2390F3tkgKE2czulz7/xLmR7RBKPG5JspqaK0s9sEpsJZvnHrJKrZr6KOETjSJvSB30t2tLnXsTbiD2uJHk42cIxiry7pRIH1mBBk5asUwae+Z6pBVvygrtEZM072SEJWJqCrg8kF1OJnmzS5HWJMz2q/F2ekM35sYBUq0bzwoy/HaJ5pTF9PBI+JMgY8qQSSiRTdVCU/H3I2pVbsJsPqF5XdxoKJ/TxsjupgwHUjNZJq34aLljqnedKHyP7h6vIcmPiOHZ9k0/e4dcyKPnjOEtgDxnhsJahLfq3Ilus71d5/j9LXSATogAzfuvXKjaC1EP+8gwSXvOPAPOYMkm1av1iVV5mCiMXz40bvo8pN7zZuGiZEFPRyv8/FameTGYilrGvpjALyvJ79KPRwyT8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4757
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guillaume.Gardet@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(1110001)(339900001)(40434004)(189003)(199004)(13464003)(476003)(47776003)(229853002)(81156014)(54906003)(5024004)(14444005)(110136005)(99286004)(356004)(81166006)(126002)(2906002)(102836004)(7696005)(33656002)(76176011)(2486003)(23676004)(336012)(305945005)(186003)(6506007)(966005)(7736002)(26826003)(26005)(478600001)(86362001)(76130400001)(11346002)(6246003)(8676002)(14454004)(6636002)(4326008)(6116002)(70206006)(486006)(74316002)(53546011)(446003)(70586007)(436003)(5660300002)(50466002)(55016002)(52536014)(9686003)(25786009)(105606002)(22756006)(316002)(8936002)(36906005)(6306002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4659;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76574524-ecf3-4e13-b4c2-08d76cc1ffdb
X-Forefront-PRVS: 022649CC2C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itPYpaD2z9MPldv5Jwiv1bfiEFROSpaFyXhDE3a7rWQOnxdUkXCKSTPzB7nbXvI4B1t82qEFVqjrT6a4uept8FOiYci2nPC6EqjRVK6LoNKpomRjHmUDNQHE3prV6chcgVf9S92qHooJUH+P6oadJeYQSbmoRmvsnmccNaSnJfXbwf0nD3V4sgfgKqdEEXMAKJNX0piLD5yVfLd9UzV60cSNCYzlsAyzNQCXDMa7IX+zcxEq4FytKD2+pClAGDl+uFQ36qAeITkjoE71sp1DGl8GYVihApaneHRaIghzJ91O17qKbqcltlwb79nW7FPtCGJSc3NNWTk2qG5HEa3YaYOAEQ4uEPd2niAqZnSIpXcnUYfjL3tBwbqPjv7d0eoXVZA5p7224GY0yb4kng4YnSFSN8mRWgxXCu2IIHyiO2FS7m3cr+/Muabh41+lHiJR5IO4DQ+KK33VtOWg63PaHw5s+qL+IFUYydqXJa15Uk0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 07:28:05.4702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e969b2d9-fb70-456b-2194-08d76cc204c6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4659
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbnJpY2ggU2No
dWNoYXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBTZW50OiAxOSBOb3ZlbWJlciAyMDE5IDA0
OjE2DQo+IFRvOiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz47IE1h
cmsgUnV0bGFuZA0KPiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBHdWlsbGF1bWUgR2FyZGV0IDxH
dWlsbGF1bWUuR2FyZGV0QGFybS5jb20+DQo+IENjOiBDcmlzdGlhbiBDaW9jYWx0ZWEgPGNyaXN0
aWFuLmNpb2NhbHRlYUBnbWFpbC5jb20+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29Aa2VybmVsLm9y
Zz47IEthaXJ1aSBTb25nIDxrYXNvbmdAcmVkaGF0LmNvbT47IEhhbnMgZGUgR29lZGUNCj4gPGhk
ZWdvZWRlQHJlZGhhdC5jb20+OyBNYXR0aGV3IEdhcnJldHQgPG1hdHRoZXdnYXJyZXR0QGdvb2ds
ZS5jb20+Ow0KPiBsaW51eC1lZmkgPGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMC8xXSBUZW1wb3JhcnkgZml4IGZvciBkYXRhIGFib3J0IG9uIGFybXY2
eiBFRkkgYm9vdA0KPg0KPiBPbiAxMS8xOC8xOSA4OjQxIFBNLCBBcmQgQmllc2hldXZlbCB3cm90
ZToNCj4gPiAoYWRkaW5nIEhlaW5yaWNoIGFuZCBHdWlsbGF1bWUgYWdhaW4pDQo+ID4NCj4gPiBP
biBNb24sIDE4IE5vdiAyMDE5IGF0IDE5OjUxLCBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBh
cm0uY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gT24gTW9uLCBOb3YgMTgsIDIwMTkgYXQgMDc6MTU6
MDRQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4+PiBPbiBNb24sIDE4IE5vdiAy
MDE5IGF0IDE5OjEwLCBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiB3cm90
ZToNCj4gPj4+Pg0KPiA+Pj4+IE9uIE1vbiwgTm92IDE4LCAyMDE5IGF0IDA3OjQyOjUxUE0gKzAy
MDAsIENyaXN0aWFuIENpb2NhbHRlYSB3cm90ZToNCj4gPj4+Pj4gSSdtIHRyeWluZyB0byBib290
IHRoZSBMaW51eCBrZXJuZWwgb24gUmFzcGJlcnJ5UGkgWmVybyB2aWEgR1JVQjIsDQo+ID4+Pj4+
IHdoaWNoIGluIHR1cm4gaXMgZXhlY3V0ZWQgYnkgVS1Cb290IGFzIGFuIFVFRkkgYmluYXJ5Lg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBIb3dldmVyLCBJJ20gZmFjaW5nIGRhdGEgYWJvcnQgaXNzdWVzIGlu
IGVmaV9nZXRfbWVtb3J5X21hcCgpIHRoYXQNCj4gPj4+Pj4gc2VlbSB0byBiZSByZWxhdGVkIHRv
IHNvbWUgbGRyZCBpbnN0cnVjdGlvbnMgZ2VuZXJhdGVkIGJ5IHRoZQ0KPiA+Pj4+PiBjb21waWxl
ci4NCj4gPj4+Pj4NCj4gPj4+Pj4gVG8gc2ltcGxpZnkgdGhlIGludmVzdGlnYXRpb24sIEkgdGVt
cG9yYXJpbHkgZ2F2ZSB1cCBvbiBHUlVCMiBhbmQNCj4gPj4+Pj4gc3RhcnRlZCBkaXJlY3RseSB0
aGUgTGludXgga2VybmVsIHZpYSBVLUJvb3QgYm9vdGVmaSBjb21tYW5kLg0KPiA+Pj4+PiBUaGUg
cmVzdWx0IGlzIGFuIGltbWVkaWF0ZSBjcmFzaCBhdCBQQyAweDkyYzg6DQo+DQo+IEhlbGxvIENo
cmlzdGlhbiwNCj4NCj4gY291bGQgeW91LCBwbGVhc2UsIGNoZWNrIGlmIHRoaXMgcGF0Y2ggYXBw
bGllZCB0byBVLUJvb3QgdjIwMTkuMTAgcmVzb2x2ZXMgeW91cg0KPiBwcm9ibGVtOg0KPg0KPiBo
dHRwczovL2dpdGh1Yi5jb20veHlwcm9uL3UtYm9vdC1wYXRjaGVzL2Jsb2IvZWZpLW5leHQvMDAw
MS1hcm0tYXJtMTEtDQo+IGFsbG93LXVuYWxpZ25lZC1tZW1vcnktYWNjZXNzLnBhdGNoDQo+DQo+
IEN1cnJlbnRseSBJIGRvIG5vdCBoYXZlIGFuIEFSTXY2IGJvYXJkIGF2YWlsYWJsZSBmb3IgdGVz
dGluZy4gKEJ1dCBJIGp1c3Qgb3JkZXJlZA0KPiBvbmUuKQ0KDQpJIHRlc3RlZCB5b3VyIHBhdGNo
IG9uIHRvcCBvZiB1LWJvb3QgdjIwMTkuMTAgYW5kIGl0IGZpeGVzIHRoZSBhcm12NiBkYXRhIGFi
b3J0Lg0KDQpUaGFua3MgYSBsb3QhDQpHdWlsbGF1bWUNCg0KPg0KPiBCZXN0IHJlZ2FyZHMNCj4N
Cj4gSGVpbnJpY2ggU2NodWNoYXJkdA0KPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBkYXRhIGFib3J0DQo+
ID4+Pj4+IHBjIDogWzwxYzZiMTJjOD5dICAgICAgICAgIGxyIDogWzwxYzZiMTU1OD5dDQo+ID4+
Pj4+IHJlbG9jIHBjIDogWzxmZTc2YTJjOD5dICAgIGxyIDogWzxmZTc2YTU1OD5dDQo+ID4+Pj4+
IHNwIDogMWRiNDNiMzAgIGlwIDogMDAwMDAwMDAgICAgIGZwIDogMWRiNDNjYzANCj4gPj4+Pj4g
cjEwOiAyMDQ5NDI0OSAgcjkgOiBmZmZmZmZmZiAgICAgcjggOiAwMDAwMDAwMA0KPiA+Pj4+PiBy
NyA6IDFkYjQzYjNjICByNiA6IDAwMDAwMDAwICAgICByNSA6IDFkYjQzYmZhICByNCA6IDFkYjQz
YmIwDQo+ID4+Pj4+IHIzIDogMWRiNDNiOWMgIHIyIDogMDAwMDAwMjggICAgIHIxIDogMDAwMDAw
MDAgIHIwIDogMWRmNGY4MjgNCj4gPj4+Pj4gRmxhZ3M6IG5aQ3YgIElSUXMgb2ZmICBGSVFzIG9m
ZiAgTW9kZSBTVkNfMzINCj4gPj4+Pj4gQ29kZTogZTNhMDIwMjggZTNhMDEwMDAgZTUyNzEwMGMg
ZTU4MzIwMDAgKGUxYzQyMGQ0KSBVRUZJIGltYWdlDQo+ID4+Pj4+IFsweDFjNmE4MDAwOjB4MWNi
MmZmZmZdIHBjPTB4OTJjOCAnL2Jvb3RcekltYWdlJw0KPiA+Pj4+PiBSZXNldHRpbmcgQ1BVIC4u
Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGUgcmVsYXRlZCBkaXNhc3NlbWJsZWQgc2VjdGlvbiBzaG93
cyB0aGUgKmxkcmQqIGluc3RydWN0aW9uIGluDQo+ID4+Pj4+IHRoZSBjb250ZXh0IG9mIHRoZSBm
b2xsb3dpbmcgc3RhdGVtZW50Og0KPiA+Pj4+PiAqbWFwLT5tYXBfc2l6ZSA9ICAgICAgKm1hcC0+
ZGVzY19zaXplICogMzI7DQo+ID4+Pj4+DQo+ID4+Pj4+IGRyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpLXN0dWItaGVscGVyLmM6OTANCj4gPj4+Pj4gICAgICAgICptYXAtPmRlc2Nfc2l6
ZSA9ICAgICAgIHNpemVvZigqbSk7DQo+ID4+Pj4+ICAgICAgOTJhYzogICAgIGU1OTEzMDA4ICAg
ICAgICBsZHIgICAgIHIzLCBbcjEsICM4XQ0KPiA+Pj4+PiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9s
aWJzdHViL2VmaS1zdHViLWhlbHBlci5jOjg0DQo+ID4+Pj4+IHsNCj4gPj4+Pj4gICAgICA5MmIw
OiAgICAgZTFhMDQwMDEgICAgICAgIG1vdiAgICAgcjQsIHIxDQo+ID4+Pj4+IGRyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWItaGVscGVyLmM6ODUNCj4gPj4+Pj4gICAgICAgIGVm
aV9tZW1vcnlfZGVzY190ICptID0gTlVMTDsNCj4gPj4+Pj4gICAgICA5MmI0OiAgICAgZTI4ZDcw
MTggICAgICAgIGFkZCAgICAgcjcsIHNwLCAjMjQNCj4gPj4+Pj4gbGludXgvZHJpdmVycy9maXJt
d2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1Yi1oZWxwZXIuYzo5MA0KPiA+Pj4+PiAgICAgICAgKm1h
cC0+ZGVzY19zaXplID0gICAgICAgc2l6ZW9mKCptKTsNCj4gPj4+Pj4gICAgICA5MmI4OiAgICAg
ZTNhMDIwMjggICAgICAgIG1vdiAgICAgcjIsICM0MCA7IDB4MjgNCj4gPj4+Pj4gICAgICA5MmM0
OiAgICAgZTU4MzIwMDAgICAgICAgIHN0ciAgICAgcjIsIFtyM10NCj4gPj4+Pj4gbGludXgvZHJp
dmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1Yi1oZWxwZXIuYzo5MQ0KPiA+Pj4+PiAg
ICAgICAgKm1hcC0+bWFwX3NpemUgPSAgICAgICAgKm1hcC0+ZGVzY19zaXplICogMzI7DQo+ID4+
Pj4+ICAgICAgOTJjODogICAgIGUxYzQyMGQ0ICAgICAgICBsZHJkICAgIHIyLCBbcjQsICM0XQ0K
PiA+Pj4+DQo+ID4+Pj4gQXQgdGhpcyBwb2ludCwgcjQgaXMgMTYtYnl0ZSBhbGlnbmVkLCBzbyB0
aGF0J3MgYSBtaXNhbGlnbmVkIExEUkQuDQo+ID4+Pj4NCj4gPj4+PiBMb29raW5nIGF0IHZlcnNp
b24gMi44b2YgdGhlIFVFRkkgc3BlYywgaW4gc2VjdGlvbiAyLjMuNSAiQUFyY2gzMg0KPiA+Pj4+
IFBsYXRmb3JtcyIsIGl0IHN0YXRlcyB0aGF0IFNDVExSIHNob3VsZCBiZSBjb25maWd1cmVkOg0K
PiA+Pj4+DQo+ID4+Pj4gfCBBPTAsIFU9MSBvbiBBUk12NiBhbmQgQVJNdjcNCj4gPj4+Pg0KPiA+
Pj4+IC4uLiB3aGljaCBJSVVDIHNob3VsZCBwZXJtaXQgYSBtaXNhbGlnbmVkIExEUkQuIElzIFUt
Qm9vdA0KPiA+Pj4+IGRlZmluaXRlbHkgY29uZmlndXJpbmcgU0NUTFIgdGhhdCB3YXk/IE9yIGhh
cyBpdCBwZXJoYXBzIHNldCBBPTEsIFU9MD8NCj4gPj4+DQo+ID4+PiBMRFJEIHJlcXVpcmVzIHdv
cmQgYWxpZ25tZW50IG9ubHksIG5vPw0KPiA+Pg0KPiA+PiBMb29raW5nIGF0IHRoZSBBUk12NiBB
Uk0gQVJNLCBJIHNlZSBtZW50aW9uIG9mIG1vZHVsby04IGFsaWduZW1udA0KPiA+PiBjaGVja2lu
ZyAoc3BlY2lmaWNhbGx5IGZvciBMRFJEL1NUUkQpIHdoZW4gQT0xLCBVPTAuIFVubGVzcyBJJ3Zl
DQo+ID4+IG1pc3VuZGVyDQo+ID4+DQo+ID4+IFNlZSBBMi43LjMgIkVuZGlhbiBjb25maWd1cmF0
aW9uIGFuZCBjb250cm9sIiBpbiBBUk0gRERJIDAxMDBJLiBUYWJsZQ0KPiA+PiBBMi02IGFuZCBB
Mi04IGJvdGggc3VnZ2VzdCB0aGF0LCB3aXRoIEEyLTggc2F5aW5nIHRoYXQgYSBEYXRhIEFib3J0
DQo+ID4+IHdvdWxkIHJlc3VsdC4NCj4gPj4NCj4gPg0KPiA+IFlvdSBhcmUgcmlnaHQuDQo+ID4N
Cj4gPiBJIGhhdmUgYWRkZWQgSGVpbnJpY2ggdG8gY2MgW2FnYWluXSAtIHBlcmhhcHMgaGUga25v
d3Mgd2hldGhlciB1LWJvb3QNCj4gPiBhbHdheXMgYWRoZXJlcyB0byB0aGlzIFVFRkkgcmVxdWly
ZW1lbnQ/DQo+ID4NCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1h
aWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBw
cml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29u
dGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3Rv
cmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
