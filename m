Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D216D68D221
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBGJIs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 04:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGJIr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 04:08:47 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AD2685B;
        Tue,  7 Feb 2023 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDVbUozdX96CLWEOwfRH8EYnDenvv9SNqbexRcIfM2E=;
 b=dx7+fpIpdPYInI2Gifg8qOktviv7WM+qzDTl1oJ840kHjat4LAGjB+8byNeQ/ZvVZ9bw6Hz7Ambwdrut8ZXh8iwrcO10W4nEm17TUB6+xT4fo/pY0CBkOsjcawFbQcQ2g6vQfyeGdtj+Js0+e3GZ9+zWw8FpQUbZzPS90H+yEo0=
Received: from AS9PR04CA0126.eurprd04.prod.outlook.com (2603:10a6:20b:531::8)
 by DBAPR08MB5589.eurprd08.prod.outlook.com (2603:10a6:10:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 09:08:41 +0000
Received: from AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:531:cafe::b3) by AS9PR04CA0126.outlook.office365.com
 (2603:10a6:20b:531::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 09:08:41 +0000
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
 15.20.6064.32 via Frontend Transport; Tue, 7 Feb 2023 09:08:39 +0000
Received: ("Tessian outbound 3ad958cd7492:v132"); Tue, 07 Feb 2023 09:08:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cff19af2c321933d
X-CR-MTA-TID: 64aa7808
Received: from 054224a51df0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50939BA5-4578-428C-8C4C-EF1EF7695620.1;
        Tue, 07 Feb 2023 09:08:28 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 054224a51df0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Feb 2023 09:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoizmX4M+2UaI/qiMTH1iOr5pG9/9KoWzpXtFDaDnOVfsywi/33JXP2nmxpTRgQYQ5xJTpE82QM4fFMJitN1/wqfQaU1uvXmo4SO6mRV38v5NOcmKqOMqRaGRD8W2w3MRjXQxGNzjBDfRHzGf6ZFsc5QsxVjUmolRUhOX/ZI7xKL66DvI6nuT7ldZPbK5cmnSujpr1NPLq0A5oAvO1Bs5G8lDp295njT0YF0BWfkYdLF316DDYFEG+XMahAWAVu820PgArHCB97sVEaf/D0PXbtJ/YtK306DIgO/mD6/LdNZa3mWQ6Eq80lLGvaERENP5jhDb0s86OXbSVn6jwPr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDVbUozdX96CLWEOwfRH8EYnDenvv9SNqbexRcIfM2E=;
 b=knw255Oaxt2pl2cGH2Dgxao2tPzq22enXnaa9asA/98lhDgwavbujb7ijro8xtoK/zy0wgWnfJO1tIOL019vpb7XkVeD5HmOJFNlaWeBysd09Ys66DfKlhE2W0p1zhezsDiF1pxOSJrkMRwEdlbVvNR9YKmnk+b20/CyiOr3EMrhN8ECb5QFFLBCaXI6eeoXCpC12R03WvifOT9p/8iYAYWQCX/CfsMvQfrAR5MXuj1Tpbr2Y+olqq9GjjlBmckVAPF/+rp5td2ciGiXssjJcaKFY41UDqDwiG9miqPmh1xTBrkrYOytzsT4T5Ev7K7owoL+LVQkYW+rHA+MmhGO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDVbUozdX96CLWEOwfRH8EYnDenvv9SNqbexRcIfM2E=;
 b=dx7+fpIpdPYInI2Gifg8qOktviv7WM+qzDTl1oJ840kHjat4LAGjB+8byNeQ/ZvVZ9bw6Hz7Ambwdrut8ZXh8iwrcO10W4nEm17TUB6+xT4fo/pY0CBkOsjcawFbQcQ2g6vQfyeGdtj+Js0+e3GZ9+zWw8FpQUbZzPS90H+yEo0=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 09:08:26 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:08:26 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQgAmHX6CAAF7PgIAAAKCggAACLQCAAAEaAIAAAZ+AgAAAqRA=
Date:   Tue, 7 Feb 2023 09:08:26 +0000
Message-ID: <DBBPR08MB45383609E2B01955E5E0C81AF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
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
In-Reply-To: <CAMj1kXFwn9epkakWBd537seUK48EfmxQz0fNi=h3L2SDTW24Bw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AS8PR08MB7917:EE_|AM7EUR03FT003:EE_|DBAPR08MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dcca03-3e87-4f56-5129-08db08eae732
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PCjOBuNTD21CYyz8zYaS3yrsXg+VZgthBgdhKRcLxg8FH3gVc8bI3lnR27Mg46PDNj/V2Ugax11Hjb3SmdQiJfauZuHc5oGwGjI7DbzqOlm4hMt1kUc0rMbtB5DGaugbehV6+evhvUnsiZCrRgW/uNsEPE2j7fwbbJpMb0M6uSEUpPMRdIPFuXfOQfOi8+SgDV7Py7UCC6aYe6XVCQQqCuCOTTqNAGkoENc4WR+RP1bet9nDRpT6/YAgvhGJ11rz3azYgYlN/zCpEVUtxGSUKBLvKAcOGSWn3yKayxihlip63XtjaC+tZDixNezepC87XJLMBtGw4FI5Dbl7mWIMmy1kpOw9UIw5WLIYBk+XRjkexTuelWuiWp44M1L8Sx/eZpryW19pQEc7sp1Es5BaTtJFWKWfgmwYX9jbfiVmmlYD3VE+qVQIM+Y633+1hLT80k+6VvyCArrk3PslRkHv/KFverV3ijMSQXopXwf2E7wDDcG5GG8N7oSPUngFUsp5TajKTcIvVsTaWoAJqF94NmwQksgiFd8162fV/r6ARb3Y3dpwI6/UeAqT5mn3dpSMfX0Q/Ubi4OyUEzejCC+40FLpWfP2PiZhFj7uJ4UrJD6PeQ11FDZepwai6HzWlP2WR+jra6FBMptvaBSczRQKuTVw2PY6CJv6W+HsgUJ68315MfrCP39Rok74XxYbKH/MjDxZt6/9FCshMwDZaF/0NjoegBHmnuOO/AaeQyz+lEC30WBD2S04Ju1HzmHscr6o
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(38100700002)(122000001)(41300700001)(4326008)(5660300002)(33656002)(66476007)(66446008)(8676002)(478600001)(64756008)(52536014)(66556008)(6916009)(2906002)(9686003)(26005)(6506007)(53546011)(55016003)(38070700005)(186003)(66946007)(54906003)(966005)(86362001)(83380400001)(7696005)(76116006)(8936002)(316002)(71200400001)(10126625003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 62e045bf-b8f5-4a84-be2c-08db08eadf44
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4hNoJG7QlaoSWYwAoWf0Z+zWPtJ+w/bm2et0uAgOnwu7Hl0FB1qEMpoHPYx1y/i30qQK34z8k8lWjw/Rr3Kmc8hUXTqFYu8+vwwbgkxIaGj545l2nu+tJYzhIgWH+B+cm9XP3jEitiAmExbr0hTjZ/g8r+2yoLLywrWo7eRrWERbJXt19MOR4mUrT37QX+2XjWoT1nLbDTT0678yYquN40wLIEQCf7fNXy4Ub1cRt6q2gWbWlMeSg3jjFFoMm+QkGMUrLPwj3BjCjcxvgFWHtrkKXqCaExhHx/swBvGsoHPZg56ly5nw7MDtSXwWVnaATdvpvl1uxeGSyiG3l2DmTwn07B4Ahv1yjbFsefjNIgAeX5IO2oQP1k6CgoX17ODfDItkcfuqo4MROEJwwUggy3qbyvRKOV7yoogx0/rQM6vlqjoqQxVTDmA25TZD4ugmNCmULZdSRR47VTfLpveqp9+RyEi8jLVqvD8gDlBZEAxTyV5ON+o6hu65xmklhF1tVNjv++lMu75YKaTVy5jnVsYNAeOO+G7ugOrU/ye3fE/rDviRrqbDnWJt4Lxzp6De3dEQNhHTd152JFfLCthqwi5OW5Q6lo4poqfJpXWQ+xc6ieERtjkAkhIfCI7Vdxke6H3fA+nrJG14wkP6hZCcpWskiE1G9Up3mPXS6816/tLSqqbFn7p68Tj4IjNhgrtxFSZjl/f/jOfEFYB6viVqG4yRpHN9AzPjxf57I/rBgOyAp0+URp4C3bnMG5wINzryG1UlM8csRsqvgJgK6BDbQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(54906003)(316002)(450100002)(70586007)(41300700001)(8676002)(8936002)(6862004)(2906002)(86362001)(82740400003)(40460700003)(81166007)(356005)(33656002)(70206006)(36860700001)(53546011)(186003)(6506007)(26005)(9686003)(4326008)(966005)(5660300002)(478600001)(47076005)(40480700001)(82310400005)(55016003)(7696005)(336012)(83380400001)(52536014)(10126625003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 09:08:39.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dcca03-3e87-4f56-5129-08db08eae732
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5589
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwg
PGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNywgMjAyMyA1OjA0
IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogSHVhY2FpIENo
ZW4gPGNoZW5odWFjYWlAa2VybmVsLm9yZz47IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRydSBFbGlzZWkgPEFsZXhhbmRy
dS5FbGlzZWlAYXJtLmNvbT47DQo+IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29t
PjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBGaXggYm9vdCBo
YW5nIGlzc3VlIG9uIEFtcGVyZSBFbWFnIHNlcnZlcg0KPiANCj4gT24gVHVlLCA3IEZlYiAyMDIz
IGF0IDEwOjAzLCBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+
IEhpIEFyZA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXks
IEZlYnJ1YXJ5IDcsIDIwMjMgNDo1NCBQTQ0KPiA+ID4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhl
QGFybS5jb20+DQo+ID4gPiBDYzogSHVhY2FpIENoZW4gPGNoZW5odWFjYWlAa2VybmVsLm9yZz47
IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBBbGV4YW5kcnUgRWxpc2VpDQo+ID4gPiA8QWxleGFuZHJ1LkVsaXNlaUBhcm0uY29t
PjsgSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+OyBuZA0KPiA+ID4gPG5kQGFy
bS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gRml4IGJvb3QgaGFuZyBpc3N1
ZSBvbiBBbXBlcmUgRW1hZyBzZXJ2ZXINCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDcgRmViIDIwMjMg
YXQgMDk6NDksIEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+IHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+IFsuLl0NCj4gPiA+ID4gPiA+IFRoZSByb290IGNhdXNlIG9mIHRoZSBodW5nIElNTyBt
aWdodCBiZSBzaW1pbGFyIHRvIGNvbW1pdA0KPiA+ID4gPiA+ID4gNTUwYjMzY2ZkNDQ1Mjk2ODY4
YTQ3OGU4NDEzZmZiMmU5NjNlZWQzMg0KPiA+ID4gPiA+ID4gQXV0aG9yOiBBcmQgQmllc2hldXZl
bCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+ID4gPiA+ID4gRGF0ZTogICBUaHUgTm92IDEwIDEwOjM2
OjIwIDIwMjIgKzAxMDANCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgICAgYXJtNjQ6IGVmaTog
Rm9yY2UgdGhlIHVzZSBvZiBTZXRWaXJ0dWFsQWRkcmVzc01hcCgpIG9uDQo+ID4gPiA+ID4gPiBB
bHRyYSBtYWNoaW5lcw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IERvIHlvdSBhZ3JlZSB3aXRo
IHRoZSBpZGVhIGlmIEkgYWRkIEFtcGVyZSDigJ1lTUFH4oCdIG1hY2hpbmUgaW50bw0KPiA+ID4g
PiA+ID4gdGhlIGxpc3Qgb2YgVXNpbmcgU2V0VmlydHVhbEFkZHJlc3NNYXAoKSBmb3JjaWJseT8N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBQbGVhc2Ugbm90ZSB0aGF0IGV2ZW4gaW4gcHJldmlv
dXMga2VybmVsIHBhdGNoLCB0aGUgZWZpYm9vdG1ncg0KPiA+ID4gPiA+ID4gLXQNCj4gPiA+ID4g
PiA+IDEwIHdpbGwgbWFrZSBrZXJuZWwgaHVuZyBpZiBJIHBhc3NlZCAiZWZpPW5vdmFtYXAiIHRv
IHRoZSBib290DQo+ID4gPiBwYXJhbWV0ZXIuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSW50ZXJlc3RpbmcuIFdoYXQgZG9lcyBkbWlkZWNvZGUgcmV0dXJuIGZvciB0aGUgZmFt
aWx5IGluIHRoZQ0KPiA+ID4gPiA+IHR5cGUgMQ0KPiA+ID4gcmVjb3JkPw0KPiA+ID4gPg0KPiA+
ID4gPiAjIGRtaWRlY29kZSB8Z3JlcCAtaSBmYW1pbHkNCj4gPiA+ID4gICAgICAgICBGYW1pbHk6
IGVNQUcNCj4gPiA+ID4gICAgICAgICBGYW1pbHk6IEFSTXY4DQo+ID4gPiA+DQo+ID4gPiA+IFRo
ZSBmdWxsIGRtaWRlY29kZSBsb2cgaXMgYXQgaHR0cHM6Ly9wYXN0ZWJpbi5jb20vTTNNQUp0VUcN
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBPSyBwbGVhc2UgdHJ5IHRoaXM6DQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQuYw0KPiA+ID4g
Yi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LmMNCj4gPiA+IGluZGV4IGZmMmQx
OGM0MmVlNzQ5NzkuLmZhZTkzMGRlYzgyYmU3YzYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvYXJtNjQuYw0KPiA+ID4gQEAgLTIyLDcgKzIyLDggQEAgc3RhdGljIGJv
b2wgc3lzdGVtX25lZWRzX3ZhbWFwKHZvaWQpDQo+ID4gPiAgICAgICAgICAqIEFtcGVyZSBBbHRy
YSBtYWNoaW5lcyBjcmFzaCBpbiBTZXRUaW1lKCkgaWYNCj4gPiA+IFNldFZpcnR1YWxBZGRyZXNz
TWFwKCkNCj4gPiA+ICAgICAgICAgICogaGFzIG5vdCBiZWVuIGNhbGxlZCBwcmlvci4NCj4gPiA+
ICAgICAgICAgICovDQo+ID4gPiAtICAgICAgIGlmICghdHlwZTFfZmFtaWx5IHx8IHN0cmNtcCh0
eXBlMV9mYW1pbHksICJBbHRyYSIpKQ0KPiA+ID4gKyAgICAgICBpZiAoIXR5cGUxX2ZhbWlseSB8
fA0KPiA+ID4gKyAgICAgICAgICAgKHN0cmNtcCh0eXBlMV9mYW1pbHksICJBbHRyYSIpICYmIHN0
cmNtcCh0eXBlMV9mYW1pbHksDQo+ID4gPiArICJlTUFHIikpKQ0KPiA+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIGVmaV93YXJuKCJXb3JraW5n
IGFyb3VuZCBicm9rZW4gU2V0VmlydHVhbEFkZHJlc3NNYXAoKVxuIik7DQo+ID4NCj4gPiBZZXMs
IGl0IHdvcmtzIG9uIG15IGVNQUcgc2VydmVyOiB0aGUga2VybmVsIGJvb3RzLg0KPiA+IE90aGVy
IHRoYW4gZWZpYm9vdG1nciBmYWlsdXJlLiBCdXQgSSBub3RpY2VkIHRoaXMgZWZpYm9vdG1nciBm
YWlsdXJlDQo+ID4gZXZlbiBiZWZvcmUgQ29tbWl0IGQzNTQ5YTkzOGI3ICgiYXZvaWQgU2V0Vmly
dHVhbEFkZHJlc3NNYXAoKSB3aGVuDQo+ID4gcG9zc2libGUgIikNCj4gPg0KPiA+IHJvb3RAOn4v
bGludXgjIGVmaWJvb3RtZ3IgLXQgOTsgZWZpYm9vdG1nciAtdCA1OyBDb3VsZCBub3Qgc2V0DQo+
ID4gVGltZW91dDogSW5wdXQvb3V0cHV0IGVycm9yIENvdWxkIG5vdCBzZXQgVGltZW91dDogSW5w
dXQvb3V0cHV0IGVycm9yDQo+ID4NCj4gDQo+IERvIHlvdSBnZXQgYW55IFtGaXJtd2FyZSBCdWdd
IGxpbmVzIGluIHRoZSBrZXJuZWwgbG9nPw0KDQpObywgDQpJIGJ1aWx0IHRoZSBrZXJuZWwgYmFz
ZWQgb246DQpjb21taXQgZDJkMTFmMzQyYjE3OWYxODk0YTkwMWYxNDNlYzdjMDA4Y2FiYTQzZSAo
SEVBRCAtPiBtYXN0ZXIsIG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKQ0KQXV0aG9yOiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQpEYXRlOiAgIFN1biBG
ZWIgNSAxNzoxNzoxMCAyMDIzIC0wODAwDQoNCiAgICBNZXJnZSBicmFuY2ggJ2ZpeGVzJyBvZiBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmlyby92ZnMNCg0K
QXJlIHlvdSB3b3JyaWVkIGFib3V0IHlvdXIgc3luYyBleGNlcHRpb24gZml4dXAgcGF0Y2g/IEkg
dGhpbmsgaXQgaGFzIGJlZW4gaW5jbHVkZWQuDQoNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlh
IEhlKQ0KDQoNCg==
