Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233C968D1BA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 09:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjBGItz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 03:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjBGItv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 03:49:51 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDC10AB2;
        Tue,  7 Feb 2023 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/hJAlBVyFq3Z1kGaAJRvRy36wA0bYPdW53nEKCEegs=;
 b=cx3IMHiTcUb7HG9ttrPpmCO3rt6BV87lQvNrBGmKj9aSGhoKOf2t6zPsRK+fAWfEUFDhwN4h6UrdkLtHPWhw9FDUo+uZhRMEPxJa8BIVi2kShQkfyaidbZWt91+NkX/wacTgSWi0JQjqvp1lr5tRMSQ+1SsUW+mnA2VSg+G/FK4=
Received: from AS9PR05CA0333.eurprd05.prod.outlook.com (2603:10a6:20b:490::19)
 by PAXPR08MB7551.eurprd08.prod.outlook.com (2603:10a6:102:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 08:49:43 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:490:cafe::56) by AS9PR05CA0333.outlook.office365.com
 (2603:10a6:20b:490::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 08:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 08:49:43 +0000
Received: ("Tessian outbound 3ad958cd7492:v132"); Tue, 07 Feb 2023 08:49:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 54db821c58d8520d
X-CR-MTA-TID: 64aa7808
Received: from d8b809bc33c6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 525DB6C2-5809-460E-8781-779EC236055C.1;
        Tue, 07 Feb 2023 08:49:35 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d8b809bc33c6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Feb 2023 08:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lh0eNZFJxEH4+y9Ouf95Pk2X72Sr0yRKMXQME1VxwwvSxGKX12lY6AcKu5HOQ9N32NupNJD29Sy5xbfQzS+GnzISKkYW5iGEEKVYBZuBDaD+IwPIrOlCjAILw2Dg6NKTyo9N1b5KWnRn6ldPZ7LUPnQ2CdH+xpS7i/bas8T26F5xH6ryoPgJeyyPsBxFf3S5Kk/6BWEaLH6EOOL8mR9gadq3jr6I6pFiU0SwkOCPFzFuOQCXRk2ZEWDRDRRTt63N7g8IPiOzH3adtMXSetNnvMbb8+9BfQ3qvNiT2WeXJzGEPu+Cq4JsOfuGXT2z6/+F6F52qXveH53r888PlZuwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/hJAlBVyFq3Z1kGaAJRvRy36wA0bYPdW53nEKCEegs=;
 b=YKHhW1fw4bEegY3qdwtnHlIduLHNqfXxwPvw8NUser49mGUzFnxKXEoyqc4arHLI6gbzI1Ilp7L/7Ja7VOFda0uAUaUiZWSd9hqJ5tuoZaSw8iFicx8RNP5mxBmTrZHEtvZNszm7n6a8fdF7/KcjCNGWXQIk86ug76KiEAxzIA7P1JtYyEvZxhMjtSb2nw1bttPot7JJdA4bsY4lRuTGNE68vSEuaHUIPkv0WhUn22k3PLNeJ9jpkoN0meGUiRNiHPDk+6/aKHBkL2n9mTY3dxn/amgqwZmmj/acKwAM7YbsNl/2AcciLrrDN969g+OWLo8Ii8yGQPUWmnJ3FpaTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/hJAlBVyFq3Z1kGaAJRvRy36wA0bYPdW53nEKCEegs=;
 b=cx3IMHiTcUb7HG9ttrPpmCO3rt6BV87lQvNrBGmKj9aSGhoKOf2t6zPsRK+fAWfEUFDhwN4h6UrdkLtHPWhw9FDUo+uZhRMEPxJa8BIVi2kShQkfyaidbZWt91+NkX/wacTgSWi0JQjqvp1lr5tRMSQ+1SsUW+mnA2VSg+G/FK4=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB8374.eurprd08.prod.outlook.com (2603:10a6:10:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 08:49:29 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::2d8:92a:3c7:2fcd%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 08:49:29 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Subject: RE: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Topic: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
Thread-Index: AQHZNSkUH16YCOHPgE6UMzICTTmIAK64HjSAgAB9BJCAADyOAIAAeGJQgAmHX6CAAF7PgIAAAKCg
Date:   Tue, 7 Feb 2023 08:49:29 +0000
Message-ID: <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230131040355.3116-1-justin.he@arm.com>
 <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com>
 <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
In-Reply-To: <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DU0PR08MB8374:EE_|AM7EUR03FT042:EE_|PAXPR08MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a75cba7-323a-40ed-bce3-08db08e841bb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hTmdp/9RpfUFJRIA8WAgyySoMZL7WP/m1A+4AvshLii1VVJturSbOA8EzRVAA9nNmLWDcfMInTB1EHj0hH05nTtGG85EFnP4wry+lb5JkWvc6u9HzpMSyQowKk6Npja/NFgfKWblO2jylvj4HsNli+DcEKDtwKJWpxo6+PEvbuE9Dkf9ncjmtIe4D4aoSkOSxh5W4kx4q3GiRnMtuYl5IfUe1pjUmYA0gyIhXpVIK5QUnYXVHfCxaOqK5VqvV9yieUXixGt1tcCZwJhkNaiGR7x/OwtdKiUPK9zC4Thv1RfnDIiU2f4SXK+F3o24oPejkcWeu0EPZ2aMtGmjutn794W3dTIlUNLUayFs069EJaapBFCfv2tamkhw9s7+luxi1XqT1TgRcjWEn26s3TlgV7XJ83J3zp6H2TvZ1O1Td04VWdzrEIIAlA52sc2qfxmxBA63+RhOOdehFB/h52al1TDVf48ovyTfnDhAT1nMRzYZ1w6rvt8BIAUFyrQRY0TPansH3a2XTY35sfMOmFLfqyroZ5zxcQtHRTZcPOkk023Km3YHsWONJJI2dP4aRa5fM24q8cs9o6nOePm4DxTAH3idL8hkZLnT6lyfvtEonCJNvo71eIku8gTteXqucj7sOmEE4xuXRhSmYUOgcpC3b4cHICFlfJ+xhlCNAXTbC8r6ec8ACFSSqnkrgApYOK7v30uHelQCQulrr+xni2jYOD9nutiJmQoAjeo+j8omFwh2LhpGBJxJU412IfH96JI1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(38070700005)(2906002)(33656002)(4326008)(66556008)(8676002)(83380400001)(71200400001)(86362001)(7696005)(55016003)(66946007)(186003)(6506007)(478600001)(9686003)(38100700002)(4744005)(26005)(966005)(8936002)(5660300002)(41300700001)(52536014)(54906003)(122000001)(66476007)(6916009)(64756008)(76116006)(66446008)(316002)(10126625003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8374
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 96212d5d-c2f1-4382-db81-08db08e8396b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUQnN5+eySbQ1roU5S8CQeNsyIHSI3Y+qjyfQuYlXkWN9Y7hMlzEqwcg5C6QgLcJzsq63HV9LtDLr/A0P4l7RaJTASJBSLOpBboUqqLQ1hRadV9qWiu2NbXFHr6d0Y2S5tJUzNzVOx4W3VRY0/k20o9HS/68PhTq8J0GxeAQ6qZZGnzpyMdN983HHx/j2teq9+pKqwDn1FWIbMSrYI16G+k28DKzvbG2KS9V1xZKfp2uzXijp2+jPPtpCpPn4Alif7c1D+yEf+6G9hgKzFGncrMrOvd5cv2SF3RQkGd5VTMgiuN9Vyx38E8DzVvq0YU1feOmlrAQZ5ZygfpiSEThwkbIIcoQrNOwdWu1bCqDKYN6+FpdVCzkoCxqxpagIcdRWUMTd8UjgLeY5o9Xv8k8obAhBPPNfoEI8qtiEbRMKRUmsXAFidTaEtmnkGTARveZGBGDC6YuvA6Kn6f2GhlV1GlLI4mtkzuDNUR7gziuL7BWrubZFt4zyM19Fx6a2iGWCEtKMHnRg0innAnIiJRm4qexiW0/pLLc2SitZSJcWz1+9NUEHfj8ydUCCzO4wnM/dmfzSA8HnMAyz6lCbwOniiiF8Upgo+KRaep/aFAG/0F7FvGB6K+We7AcWAtotj2ZEQEASohcy1sJf0LegJtVICrCY3czR3VnNwaVXHiZ3A7ieRTd1Q3F+lPWxgtQr8xbTJX70YGABLgwIxC6eS2kwyPi0fE2LRABEEWXxna0Pm1SfcPT9W6nDwGDSUm1R/ZhfT2o2qzxW5uW2NGYvqb2Gg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(336012)(47076005)(54906003)(83380400001)(316002)(186003)(2906002)(26005)(33656002)(81166007)(36860700001)(356005)(8676002)(4326008)(9686003)(8936002)(70206006)(6862004)(70586007)(41300700001)(6506007)(40460700003)(82740400003)(450100002)(7696005)(52536014)(86362001)(4744005)(55016003)(40480700001)(966005)(5660300002)(10126625003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 08:49:43.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a75cba7-323a-40ed-bce3-08db08e841bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7551
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NClsuLl0NCj4gPiBUaGUgcm9vdCBjYXVz
ZSBvZiB0aGUgaHVuZyBJTU8gbWlnaHQgYmUgc2ltaWxhciB0byBjb21taXQNCj4gPiA1NTBiMzNj
ZmQ0NDUyOTY4NjhhNDc4ZTg0MTNmZmIyZTk2M2VlZDMyDQo+ID4gQXV0aG9yOiBBcmQgQmllc2hl
dXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+IERhdGU6ICAgVGh1IE5vdiAxMCAxMDozNjoyMCAy
MDIyICswMTAwDQo+ID4NCj4gPiAgICAgYXJtNjQ6IGVmaTogRm9yY2UgdGhlIHVzZSBvZiBTZXRW
aXJ0dWFsQWRkcmVzc01hcCgpIG9uIEFsdHJhDQo+ID4gbWFjaGluZXMNCj4gPg0KPiA+IERvIHlv
dSBhZ3JlZSB3aXRoIHRoZSBpZGVhIGlmIEkgYWRkIEFtcGVyZSDigJ1lTUFH4oCdIG1hY2hpbmUg
aW50byB0aGUNCj4gPiBsaXN0IG9mIFVzaW5nIFNldFZpcnR1YWxBZGRyZXNzTWFwKCkgZm9yY2li
bHk/DQo+ID4NCj4gPiBQbGVhc2Ugbm90ZSB0aGF0IGV2ZW4gaW4gcHJldmlvdXMga2VybmVsIHBh
dGNoLCB0aGUgZWZpYm9vdG1nciAtdCAxMA0KPiA+IHdpbGwgbWFrZSBrZXJuZWwgaHVuZyBpZiBJ
IHBhc3NlZCAiZWZpPW5vdmFtYXAiIHRvIHRoZSBib290IHBhcmFtZXRlci4NCj4gPg0KPiANCj4g
SW50ZXJlc3RpbmcuIFdoYXQgZG9lcyBkbWlkZWNvZGUgcmV0dXJuIGZvciB0aGUgZmFtaWx5IGlu
IHRoZSB0eXBlIDEgcmVjb3JkPw0KDQojIGRtaWRlY29kZSB8Z3JlcCAtaSBmYW1pbHkNCiAgICAg
ICAgRmFtaWx5OiBlTUFHDQogICAgICAgIEZhbWlseTogQVJNdjgNCg0KVGhlIGZ1bGwgZG1pZGVj
b2RlIGxvZyBpcyBhdCBodHRwczovL3Bhc3RlYmluLmNvbS9NM01BSnRVRw0KDQoNCi0tDQpDaGVl
cnMsDQpKdXN0aW4gKEppYSBIZSkNCg==
