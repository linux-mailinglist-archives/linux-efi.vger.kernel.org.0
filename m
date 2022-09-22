Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFF5E5D6A
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIVI0g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIVI0f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 04:26:35 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73BA8CE1;
        Thu, 22 Sep 2022 01:26:34 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=hNL6k2TH9PVNZx8w5Pk7NiywlLSCKlJbS4W3lL8k179ygxN755zz4LPaDD7h2CfaTlU0WFzWk0Az0gyqrovx00AeXbqdNgJoO44NrNkEFtvDJ+zAlBxoaDkdox4sNmJJo1Hla3Slopjks3vCB8By2WUqjq6uwckskRt1xbiqDYPSkKxZVdY+3P93xH7Q9J73QQxNp6+c/CfAjrlKVAvefh5M4E6gnJxLzOUqW2KEW47pMMelQ6Nebn8AP5bUOgbpgEFnB9U51Swau/VKTnHCAYsp+DLdv8gZQvP8sS2epGsjYIVjKQE7mxKbM9t1MP3AErGGhnsgbJ6YQvCSH+yvJA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYjljGxe5w7zqswFeQjYocyrFhn3MKs/y9E/jBI++A8=;
 b=IPcEuc2fB9rvJNwqTksFacsOYBr2r1z3DOPkfF9+CeqPpZhaCvmMW4sYc5Om4AZ2W6AbwVMbLd6Y10BaParBhjgjXNL6vT15YmhpML2DGqRCPoiNfKyhq9CslQo+PStJYwxVnDEl5VvIECXUVCRZv0aO7m1p3YmiVPSuRkN0qqDsvzKgEp5vTweZ9IqS5l3x1sMjcjQ2FmnmqpuP7FuTspOidO8MhMRrTGBQgbLNfpgFmlpXz2nKIpeojCBH3TqUKwF4yjPCH9XuX5EepOpRw+s66ezzJ0B9DtpZa9vLc7xw+8A7KQStPfBuqyJ7fWuBQJT0BZPSHivK0jcGKpjovQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjljGxe5w7zqswFeQjYocyrFhn3MKs/y9E/jBI++A8=;
 b=m96GHv4OPPiFHr8XOjE21ocLPbKJBlPtCbZed3gjtnNOeFOEfFUJyZOneUEjdKcd6+nI1HwqA2KUNS1NzN+85HgUB9eU2FGGbzdL4AjJSmvpzPtuZvve1KwMC5S5flON7w8RP7nRitH3hFVfHtdtNT0h7Y5JLQpwdhkEhyIl6Ic=
Received: from DB9PR06CA0020.eurprd06.prod.outlook.com (2603:10a6:10:1db::25)
 by DBBPR08MB6201.eurprd08.prod.outlook.com (2603:10a6:10:20a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 08:26:30 +0000
Received: from DBAEUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::5) by DB9PR06CA0020.outlook.office365.com
 (2603:10a6:10:1db::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 08:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT031.mail.protection.outlook.com (100.127.142.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 08:26:30 +0000
Received: ("Tessian outbound e2c58cd9a6bb:v124"); Thu, 22 Sep 2022 08:26:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a8372869939ea9af
X-CR-MTA-TID: 64aa7808
Received: from 99038dbcb5ad.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D31DA0D1-C083-459E-869C-5CC9CF01F8DA.1;
        Thu, 22 Sep 2022 08:26:21 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 99038dbcb5ad.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Sep 2022 08:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtE5+PFwJgOzM+kUGqIg2hZn9rwEhFg5OSNuwDdCpxUkiwzBMRZWftx1H14mM1ZXBrCzz4AAM53ADoffogLdT1+ZDN833P4cPZVFcTVFFu7M1iIcjKHRR4ixphwCW/PdNKFdLlfRvnEQZ2EnKTNmd6C3jiFWUFbEY03K2TFPdg5n9zMv7q2tO2fPcdQ97nam/jHK9Xp8N64L+rrQSqSLqSGcfHMJFzIOj1kqfPmMXBG4Rj42f8pAe9OwBJoV9++rzMskxUZiiz1L9QjK5WJg4WRPyedrF51D32Jt7FabPC9B0tCsF9iw4BtpZYeXPtzLL3/75wBEbR0xMFw3tlkZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYjljGxe5w7zqswFeQjYocyrFhn3MKs/y9E/jBI++A8=;
 b=mlWfKdi77VaFrpPTFnQGfUYCc8Dwr/ahX3IBIhTOTIKtHYLdyoxEKdY214SynFz2CCr+decrcUqHpP9oX3YjVUu4coJA3VgvXOsllDPhWhYth3MYUNvxXvIi8Dh9LwGAHfVYj4D2lkhXbMPKXv9bua4htnVqPAw29NbLasu6/FptjLQzbU9qFp7q8hFq09xsX6yX+G25szR0QgluI3Gx4NP8pt9kLmnTeCRGHtvs5sBMF5r+THrXeyPTWmFiSGwRRd65fmCbqkH392WVMMuumgqRjwrOCXtda5uwz3c3fjyX4CSFnKoT8L2PwPjbXTdg8l8Hx2Gte2q9g8siJ+2L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjljGxe5w7zqswFeQjYocyrFhn3MKs/y9E/jBI++A8=;
 b=m96GHv4OPPiFHr8XOjE21ocLPbKJBlPtCbZed3gjtnNOeFOEfFUJyZOneUEjdKcd6+nI1HwqA2KUNS1NzN+85HgUB9eU2FGGbzdL4AjJSmvpzPtuZvve1KwMC5S5flON7w8RP7nRitH3hFVfHtdtNT0h7Y5JLQpwdhkEhyIl6Ic=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 08:26:16 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::21dc:6870:c152:e0]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::21dc:6870:c152:e0%4]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 08:26:16 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYxrXO8NBod7f3WkSwGy3XMHxsta3onamAgAKEmCA=
Date:   Thu, 22 Sep 2022 08:26:16 +0000
Message-ID: <DBBPR08MB4538F21BA01114A0D30485E0F74E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220912144005.212624-1-justin.he@arm.com>
 <20220912144005.212624-6-justin.he@arm.com> <Yyn2zYLP9So0heBW@zn.tnic>
In-Reply-To: <Yyn2zYLP9So0heBW@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|GV2PR08MB7929:EE_|DBAEUR03FT031:EE_|DBBPR08MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fd1bd1-f78c-4912-4d6f-08da9c742678
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qoVEUr0DD3syVlbccLWWA0NoOwGfR0ykmfAeCKrQYYmOAaC9K1/uMGmJMC8ybVX0I+SesbE1+9TfaNN7bbEBwHZVnFiG2C8x1OUpIkIblZc5waU73bTiHjUOce50omdbXRf50A0YGGtqraxWz4Nuxh+72gFSnAD99Qo4yKoTpSVdmU77k0asBEShJh1EYBEyqNjBm7dG/1arNzR2zVSNLNGlHwxmmQTXrTz6CAXb4AlS0Dd+uOdiE+crQxpdE2QRCFsAlffvzdLT8bdHcN8SpMfg+zlsZLuteMQ3FMhdgcUZ1x5FTIx2mxPvXqVORdjfoUeueR+dfCRvWG7AOfCmCpNOBKIl8c49kzBg4mTfSZGP0WLGBv3iezMfcT7yWZj+NFtAH1yU3bkXoFtHIeK/z3EhK5Mb0PxWtVAMVFv77r8k/JE97PKHb5Hf2xd/PvBwrLaJGGB7Qe1pDZ9XAg68xXX29+J2WlGmZiO7yw3J7ULxSI+YpDzT0LvPY57pGA5JyVAAuSSmgehxlIX2Hl5/jy6QfN13ddDI9HhIEM0iKh54CFTw2ch/lRd/JqkH0YbltZkqYVGbhsag1YWszo4R7/9ebQ6JpkG59xqSmk1hLyW7MFpZtFs3YUOnA7vAsGfbrwnv1e1QaTVFv9WY5edRL4keIpAjMp5ZSBMmNCcQVPGdl/LYidk3Nerfxyz0V2mpxcW09TodFFp0y/C1mTbphCU2UhEAUt2j85Lv3J18neppfGMq9YtMFtcV4U0hUF53n4f+2Mleahv77xOQBPRFaA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(38070700005)(71200400001)(5660300002)(38100700002)(53546011)(41300700001)(4326008)(76116006)(54906003)(6916009)(7696005)(8676002)(66556008)(66446008)(66476007)(64756008)(66946007)(26005)(122000001)(6506007)(8936002)(7416002)(55016003)(9686003)(2906002)(33656002)(316002)(186003)(86362001)(52536014)(83380400001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8cc43f8a-58bf-45a1-c1de-08da9c741e1d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXqumLy6wGpnxOECK7wNPqSvu6O8A2Y1yaeWSe+Y4avMlJyaJyZ4fEmviPRbKzpDFla2Qiv5imyqs212WZDPqKEdE2dPa+nUPdCTmDiTActxhiQNfLcvYiA/B22RpDFHE+qOtGF90SvLRH9XqkjyNt7RJSogQ4zjIEtPmYI3cbvbeEy7ZxssWp3oRZuNg7E5/WK7mlNp/eeAlunnOYyqnq1reAS+qVuQpfv/tOne8KWJ25I5h4GSMT5mwPwtuNgdkE3YEGj2wq94caFEQfBBYO+SfTL+dJXKb04UTBL/Q/NkpVgLMV76DMdBZ32g7s8TS7iMfIq2g3rSGPWnKljB/M/R8iTtLIWit+JtxzhZz5apg+hecK2czBsp1eQIiVcnmxVAL/rrUCmhLDzYcPOug4OVthAAbILTCgYdZxFpb8j07vRMP+TKk073ryz0e4+goaMCPYBTtg3aQfNweF/RMC301vUK4QaXUXPgKZwOsVdNsRt+PzLHafFFuVTbsPsS8rp9GQ3J3wx253BPh/mxxp+jEf5K1x6ZXVxYkTA7FFTGohwd0DN9zEgfKygX/moXdaRhyIuK/Y3iYtyD/Ct41aFGfjSfq0Mf4R7rPL0TVeRi2y5ULGblDgx18s/nmB9DI6gpskshVVLKtzr7JfH4pBOfkpnaWuY/qfg8IEHDRPnFfV4M4jbX0KYiDxfB0036JPTHDw3PEaf/2GXK2tExPmKjkuArFLJTG0y9nnLdY9W1uLhV66kp5MDCkp5NBhAVGNM/MDe1qFNTp9j7BY+CkA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(9686003)(83380400001)(336012)(186003)(82740400003)(47076005)(36860700001)(81166007)(2906002)(41300700001)(6862004)(8936002)(52536014)(82310400005)(55016003)(40460700003)(40480700001)(478600001)(6506007)(7696005)(4326008)(356005)(53546011)(26005)(5660300002)(8676002)(70206006)(316002)(54906003)(450100002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:26:30.1748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fd1bd1-f78c-4912-4d6f-08da9c742678
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6201
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
MjEsIDIwMjIgMToyMiBBTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4g
Q2M6IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNl
QGFybS5jb20+Ow0KPiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBNYXVybyBDYXJ2
YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmlj
QGtlcm5lbC5vcmc+OyBSb2JlcnQgTW9vcmUNCj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBR
aXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT47IFlhemVuDQo+IEdoYW5uYW0gPHlhemVu
LmdoYW5uYW1AYW1kLmNvbT47IEphbiBMdWViYmUgPGpsdUBwZW5ndXRyb25peC5kZT47DQo+IEto
dW9uZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEthbmkgVG9zaGkNCj4g
PHRvc2hpLmthbmlAaHBlLmNvbT47IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Ow0K
PiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7IFJhZmFl
bCBKIC4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+OyBTaHVhaSBYdWUgPHh1ZXNodWFp
QGxpbnV4LmFsaWJhYmEuY29tPjsgSmFya2tvDQo+IFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9y
Zz47IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7IG5kIDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2IDUvOF0gRURBQy9naGVzOiBNYWtlIGdoZXNfZWRhYyBhIHByb3BlciBt
b2R1bGUgdG8NCj4gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9uIGdoZXMNCj4gDQo+IE9uIE1vbiwg
U2VwIDEyLCAyMDIyIGF0IDAyOjQwOjAyUE0gKzAwMDAsIEppYSBIZSB3cm90ZToNCj4gPiBDb21t
aXQgZGM0ZThjMDdlOWUyICgiQUNQSTogQVBFSTogZXhwbGljaXQgaW5pdCBvZiBIRVNUIGFuZCBH
SEVTIGluDQo+ID4gYXBjaV9pbml0KCkiKSBpbnRyb2R1Y2VkIGEgYnVnIHRoYXQgZ2hlc19lZGFj
X3JlZ2lzdGVyKCkgd291bGQgYmUNCj4gPiBpbnZva2VkIGJlZm9yZSBlZGFjX2luaXQoKS4gQmVj
YXVzZSBhdCB0aGF0IHRpbWUsIHRoZSBidXMgImVkYWMiDQo+ID4gaGFkbid0IGJlZW4gZXZlbiBy
ZWdpc3RlcmVkLCB0aGlzIGNyZWF0ZWQgc3lzZnMgL2RldmljZXMvbWMwIGluc3RlYWQNCj4gPiBv
Zg0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAgb24gYW4gQW1wZXJlIGVNYWcg
c2VydmVyLg0KPiA+DQo+ID4gVG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9mIGdoZXNfZWRhYyBv
biBnaGVzLCBtYWtlIGl0IGEgcHJvcGVyDQo+ID4gbW9kdWxlLiBVc2UgYSBsaXN0IHRvIHNhdmUg
dGhlIHByb2JpbmcgZGV2aWNlcyBpbiBnaGVzX3Byb2JlKCksIGFuZA0KPiA+IGRlZmVyIHRoZQ0K
PiA+IGdoZXNfZWRhY19yZWdpc3RlcigpIHRvIG1vZHVsZV9pbml0KCkgb2YgdGhlIG5ldyBnaGVz
X2VkYWMgbW9kdWxlIGJ5DQo+ID4gaXRlcmF0aW5nIG92ZXIgdGhlIGRldmljZXMgbGlzdC4NCj4g
Pg0KPiA+IFRoZSBnaGVzX2VkYWNfZm9yY2VfZW5hYmxlIGNoZWNrIGlzIG5vdCBuZWVkZWQgaW4N
Cj4gPiBnaGVzX2VkYWNfdW5yZWdpc3RlcigpIHNpbmNlIGl0IGhhcyBiZWVuIGNoZWNrZWQgaW4g
Z2hlc19lZGFjX2luaXQoKS4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogQm9yaXNsYXYgUGV0
a292IDxicEBhbGllbjguZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNv
bT4NCj4gPiBGaXhlczogZGM0ZThjMDdlOWUyICgiQUNQSTogQVBFSTogZXhwbGljaXQgaW5pdCBv
ZiBIRVNUIGFuZCBHSEVTIGluDQo+ID4gYXBjaV9pbml0KCkiKQ0KPiA+IENjOiBTaHVhaSBYdWUg
PHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiA+IEFja2VkLWJ5OiBUb3NoaSBLYW5pIDx0
b3NoaS5rYW5pQGhwZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9hcGVpL2doZXMu
YyB8IDIyICsrKysrKysrKysrKystLQ0KPiA+ICBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAgfCAg
NCArLS0NCj4gPiAgZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIHwgNTkNCj4gKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2FjcGkvZ2hlcy5oICAg
ICAgfCAyNCArKysrLS0tLS0tLS0tLS0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0
aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pDQo+IA0KPiBTbyB0aG9zZSBsYXN0IHRocmVlIHBhdGNo
ZXMgbG9vayB1bm5lY2Vzc2FyaWx5IGNvbXBsZXguIFlvdSBkb24ndCBuZWVkIHRvDQo+IGV4cG9y
dCBnaGVzX2VkYWNfZm9yY2VfZW5hYmxlIGFuZCB5b3UgZG9uJ3QgbmVlZCB0aGF0DQo+IGdoZXNf
ZWRhY19wcmVmZXJyZWQoKSB0aGluZy4NCj4gDQo+IElPVywgSSdkIGxpa2UgdG8gc2VlIHRoZSBi
ZWxvdyBzcGxpdCBpbnRvIHR3byBwYXRjaGVzOg0KPiANCj4gMS4gQWRkIGdoZXNfZ2V0X2Rldmlj
ZXMoKSB0byBnaGVzLmMgYWxvbmcgd2l0aCBtb3ZpbmcgdGhlDQo+IGdoZXNfZWRhY19mb3JjZV9l
bmFibGUgcGFyYW0gdG8gZ2hlcy5jDQo+IA0KPiAyLiBBZGQgaW5pdCgpIGFuZCBleGl0KCkgbW9k
dWxlIGZ1bmN0aW9ucyBhbmQgZml4dXAgS2NvbmZpZw0KPiANCj4gVGhlcmUncyBubyBuZWVkIGZv
ciBnaGVzX3ByZXNlbnQgLSBnaGVzLmMgaGFzIGVpdGhlciByZWdpc3RlcmVkIGRldmljZXMgb3IN
Cj4gbm90Lg0KPiANCg0KSWYgdGhlcmUgaXMgbm8gZ2hlc19wcmVzZW50IGZsYWcuDQpXaGF0IGlm
IGdoZXMuZGlzYWJsZSBpcyBwYXNzZWQgdG8ga2VybmVsIGJvb3QgcGFyYW1ldGVyIGFuZCB0aGVu
IGdoZXNfZWRhYyBpcw0KbG9hZGVkIGJ5IG1vZHByb2JlPw0KVGh1cywgZ2hlc19lZGFjIGNhbiBi
ZSBsb2FkZWQgZXZlbiBpZiBnaGVzIGlzIGRpc2FibGVkLiAoZ2hlc19kZXYgbGlzdCBpcyBudWxs
KQ0KDQpUaGUgZ2hlc19wcmVzZW50IGlzIHRvIGF2b2lkIHRoaXMgY2FzZS4NCg0KV2hhdCBkbyB1
IHRoaW5rIG9mIGl0Pw0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQo=
