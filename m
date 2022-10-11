Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21785FB49E
	for <lists+linux-efi@lfdr.de>; Tue, 11 Oct 2022 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKOdQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Oct 2022 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKOdO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Oct 2022 10:33:14 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4BF95E56;
        Tue, 11 Oct 2022 07:33:13 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mrMy8Dwsh9ayVJNzsWu4dfGQjVZaMBYVsPAlTEDIQb63d3RT9a6gHWeR5mTc1UJFX6lgz4kwvg74JB+PrMlJ+cf0H7qSc1LuzXNRNpkiBby5F39IN0SXSOL90VBFDfaqxbFCbrk7BSCJCeK3Opg0nuC7WjNFd9lPPW74mtIyFTx7rceqI5pqfsbRfXEKBULqxX41PW9QCtOfRChjMhAU8KfH0V612xMDRjHJgtTZpU98tl9UGvw8zDt0X5qY3gGWZPh6poOmArYtdBe7OCyOtWZOax3QTaDaUIkVCB//kHGuQbc4+z7FSC7tFtyS744/8E8RrUvKMBJrh5gAKTdXhg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gr+nFxgOPHeSFDf8OCk8fquC2JvbK/0YWCLzbaGLhU=;
 b=Tiry8fB0JkpbZi+fcY/OM+XRzGt5MT2gAPOgbda5bX/frBRJ6YCswUaG2I2o1el+i4g3IlFTREYABkuSh7jTbuKdIBwQRmSM57Yu7gAcCZfcuqucsbzowgZgep0PGJXpvkThr5VZpIbO+Qa7WqIZy1ZSt17/+++QL7Qowyms/TdDjv2hyQYE1B/OzBfQBUxyt8/vbf/37+XNVDM8INVvAA4PboaEGxMRc5IV4Lr13Dnd9dI0YY7oJRFWpwExQlW9VLJCA9R4sw7sGseNqTaSnchFyE/7Lii6xDzUJnjqRjmnjCdh2x6Rq8gLopcyPJdTtX4Sv30SyMDVmdds95WefA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gr+nFxgOPHeSFDf8OCk8fquC2JvbK/0YWCLzbaGLhU=;
 b=BCsXFs+GGh0lVUktHetXbTX/RXiIFsr2av95V+pBlP+1Iaeqrh+98mWglfW1lSS0RCcfRHK+KOWE6yhyvVxDK/VeFQP386VnFjv4yn2YBSXOYJTxczW7IwUpoCjnEZA0s8kZC9G0OTjEbQVe0Ron08wTFuuMdfJV9bt88ZJyAbs=
Received: from DB6PR0201CA0010.eurprd02.prod.outlook.com (2603:10a6:4:3f::20)
 by AS8PR08MB8224.eurprd08.prod.outlook.com (2603:10a6:20b:52b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Tue, 11 Oct
 2022 14:33:09 +0000
Received: from DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::8d) by DB6PR0201CA0010.outlook.office365.com
 (2603:10a6:4:3f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Tue, 11 Oct 2022 14:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT026.mail.protection.outlook.com (100.127.142.242) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 14:33:09 +0000
Received: ("Tessian outbound 7e4a920b87c0:v128"); Tue, 11 Oct 2022 14:33:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 41bd7b2b87916121
X-CR-MTA-TID: 64aa7808
Received: from 4e5805c78b16.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F824C020-D512-4F2D-B9D3-97F765857C76.1;
        Tue, 11 Oct 2022 14:32:58 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4e5805c78b16.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 11 Oct 2022 14:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui04jgX8PBmEPLMcC635DRoYJP2EyQWAAxJ13NCOQC5plFWA7lJmiKNLOm99JoFuocB5cADNScjWpsmlUMUoxlMCFZYt7nQFheMWOj2deHKZISQKQjen7XBaSZLxng8s/1ft5jEu6nr353hJsGKZMtR1YGL0XNYoh7hXPeVLrVB5tSpvWqpA1bk6U60iaGuFd1zxPuST73IbtS8Jmj4eSTsJ4FkeiLXWD1nHjdwebnjfEyP/f8C+cnngxXT0uKPuYyPlCHJEkEJwVAk97cHkb093NQTtNlRoRC5yuQ5ZbAOrOMQ412PjpxbInKrULrdaZ5DGQYekFpUHSnAass1Omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gr+nFxgOPHeSFDf8OCk8fquC2JvbK/0YWCLzbaGLhU=;
 b=oRJd7WaKoHyOdFst15ELcA3PMVReTtzli94/Qd5EHgN0fWd4yoNasp7OKRCrSpp725vW+wr2ni7dpHM3BMgVURbHA1sYXwph5B8tgyCZu8VthLrEU6d6ruLPPd9GNm93Fa9cf1pvBOC8V499LkRIOOpF++AfVwCCKVC8FbcdIshfM/oeRHkfyd/lkh1+wjX/yzVU98nMXBPt6C7MtodG99O/6ETvZRhiVuks632t8+juvh7WiOqfNF40KFnUnrQO42R1onjIhYG5g4v6Pet8JSSnj7GvDRueMd+k2YJTUCNYG8hFEPF5wFRABJlCKFPqkUMJ8g1SoOutXmIY4SiTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gr+nFxgOPHeSFDf8OCk8fquC2JvbK/0YWCLzbaGLhU=;
 b=BCsXFs+GGh0lVUktHetXbTX/RXiIFsr2av95V+pBlP+1Iaeqrh+98mWglfW1lSS0RCcfRHK+KOWE6yhyvVxDK/VeFQP386VnFjv4yn2YBSXOYJTxczW7IwUpoCjnEZA0s8kZC9G0OTjEbQVe0Ron08wTFuuMdfJV9bt88ZJyAbs=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DB9PR08MB7628.eurprd08.prod.outlook.com (2603:10a6:10:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Tue, 11 Oct
 2022 14:32:49 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 14:32:49 +0000
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
        nd <nd@arm.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/A=
Date:   Tue, 11 Oct 2022 14:32:48 +0000
Message-ID: <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com> <Y0VGkUxpqiIzIFzB@zn.tnic>
In-Reply-To: <Y0VGkUxpqiIzIFzB@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DB9PR08MB7628:EE_|DBAEUR03FT026:EE_|AS8PR08MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8850a32f-8c2e-44fe-9a43-08daab9584b6
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N4VsMn2HCVM0FXw3Xb0ig54yANDPnuXHXN5Np4bGqnemLhNRXYxmNZ5AHTEH+Zh5MnDzCL3SlchXq3zQcBPVsVlvWANX+DRULXmQE1/vzXmUI9MYi/WUAaIIXi2y0IFhuOiz6WdJ8xwT3LziEl0/ObkDxe/L8+Yo68MbJ/5bObTj9P3jiVX+DgCdj6IVO85/4SpLIYB+YP5fenfc9qm2uZ9KiM0D+mNSSEuZ8VVEJBDrHaJpNcVE/1IsFxngutrRFBAPc3vPW7ATEN3k9VecqMoS5NdJgiBFqsLGPpT7OnDbvtaWEP+ONFqHDNyJuRei3DwaBdoqv9Vh0jJo7deiYR1owlvVdY2swW2MJgLBnEqxsGEtnfUITQJD1pX25S6W2Aa9liiKbNc+5HGmmLkVarbQEfJrMqmFa9uMVAerugTtgumrJKJU8KQEcYAoe13b1yDic1ri/NQl9ZBA44PFD/EmC1FB3QY0XktzMwReLihuRF4AiY7r7rcfPA3g0MN/YU0EH4S385nSdZCVkL9OMiq9B4ks9zXKrAwECsMHxJUaw7we6lOgwSqL1WUMNq+1+XMZsnFEjjEd65elsJvcgQIk8GDLqhSoymgB95fN0ixE0no4DQV0wGBcNbeZHo4KU1ct8OpCA7W3LZnIDnhNFsGkwqQxfp/bCkbHWZNZqJ+8EZ/hM7FouvLoedMOUJ2CkzQvxB0KA6J2ly93OhYyUaAvWWBOl4yraqAuPSro5o3h0N1lCmIaNgrYISv00fvG0XtJAH4/+H78+uptRAa381f+9ViwJE3GRJsy0RRMhUtXqjINlByhghaK47Ll/Ha4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(52536014)(41300700001)(33656002)(7416002)(53546011)(478600001)(122000001)(7696005)(71200400001)(6506007)(5660300002)(86362001)(186003)(55016003)(8936002)(38100700002)(66446008)(66946007)(38070700005)(83380400001)(54906003)(64756008)(66476007)(76116006)(66556008)(316002)(26005)(9686003)(6916009)(8676002)(4326008)(2906002)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7628
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34703d1c-2bed-4242-1dd5-08daab95787a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2HEXeE/wuujfLBlhe1bwthyVAA+tUoSVM2FiRhE1LVDxMkTQ3i31Hc7BjMHeEAxwI3lun0HZ4Js/8OIK9ownLE6/CeOAniDAOp39uKFsLETAaV7RiEkMeaFkeUJC4txECKtf904HRMZ4kwNMW31G0ph8w7uoBGIg4/opKsNf3S62ipEwEc2qUKXz5mQO3YJpNK2RsEQnfFOVXnBZf4R/YjREhkFmdraOWgc2056Gq6hBE5qwH4WJcMcey+FMGvQeET2ZqPC8/QehEZyu0kYvjRSW23bNMIJ5wuyTrXd6RwRGPg3skdm163OPCnRTV1XIwFJOfFDfNmUbdOjdC74n3is163aByU5w0w2raXPWg0RHn7jTshpONrTxu3GEkBazePRZYyFdCMAyP3yVsgC3HYZpen5EPaLv4kCLI5dH8C432UImPLUW8t0Xrv2cV1QuHMj4GxlRp3/q3YQdic1C/EuGgGYFMj1yHlx7gqOigmhoUUqrgPIViRH0MnlK/1ZOAql7T8fSFecGD6ccJVAWfaAHY0tWr93jX0aEpMGwzKUeKIji3708gjhTlIPTIhUbguLcKaRWqaGuRDgrh8UB/F3jrVxBqTOoN7XK+ExZwPnsCgCT+99zsuGdmMtQi1FtzOoZFCLW/2nNHZcglkuCEh2g0zMfMNl/H/rxK9rqt5TTFDAX12BFTducWESRFf9TANnzX4Ztrtuvcy/Tb53/eEMTep4MTsZ4+8AVlUQnM0wrU4/n62a0E45kDLLwhELj7WUSyzl149Ehd7eUx9vHbucBFu7jd93V+WtUV6WTDyy+xJ6+a9bBVLRZDLkBXOP
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(70206006)(86362001)(53546011)(70586007)(40460700003)(450100002)(7696005)(8936002)(6862004)(107886003)(8676002)(47076005)(186003)(55016003)(336012)(6506007)(36860700001)(2906002)(41300700001)(26005)(83380400001)(4326008)(40480700001)(9686003)(52536014)(5660300002)(82310400005)(33656002)(81166007)(356005)(54906003)(82740400003)(478600001)(316002)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:33:09.1226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8850a32f-8c2e-44fe-9a43-08daab9584b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8224
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
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMSwg
MjAyMiA2OjM0IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzog
TGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VAYXJt
LmNvbT47DQo+IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IE1hdXJvIENhcnZhbGhv
IENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNAa2Vy
bmVsLm9yZz47IFJvYmVydCBNb29yZQ0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFFpdXh1
IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPjsgWWF6ZW4NCj4gR2hhbm5hbSA8eWF6ZW4uZ2hh
bm5hbUBhbWQuY29tPjsgSmFuIEx1ZWJiZSA8amx1QHBlbmd1dHJvbml4LmRlPjsNCj4gS2h1b25n
IERpbmggPGtodW9uZ0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsgS2FuaSBUb3NoaQ0KPiA8dG9z
aGkua2FuaUBocGUuY29tPjsgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz47DQo+IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgUmFmYWVsIEog
LiBXeXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IFNodWFpIFh1ZSA8eHVlc2h1YWlAbGlu
dXguYWxpYmFiYS5jb20+OyBKYXJra28NCj4gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsg
bGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsgbmQgPG5kQGFybS5jb20+Ow0KPiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCA2LzddIGFw
ZWkvZ2hlczogVXNlIHVucmN1X3BvaW50ZXIgZm9yIGNtcHhjaGcNCj4gDQo+IE9uIE1vbiwgT2N0
IDEwLCAyMDIyIGF0IDAyOjM1OjU4QU0gKzAwMDAsIEppYSBIZSB3cm90ZToNCj4gPiBnaGVzX2Vz
dGF0dXNfY2FjaGVzIHNob3VsZCBiZSBhZGQgcmN1IGFubm90YXRpb24gdG8gYXZvaWQgc3BhcnNl
IHdhcm5pbmdzLg0KPiA+ICAgIGRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo3MzM6MjU6IHNwYXJz
ZTogc3BhcnNlOiBpbmNvbXBhdGlibGUgdHlwZXMgaW4NCj4gY29tcGFyaXNvbiBleHByZXNzaW9u
IChkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMpOg0KPiA+ICAgIGRyaXZlcnMvYWNwaS9hcGVpL2do
ZXMuYzo3MzM6MjU6IHNwYXJzZTogICAgc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZQ0KPiBbbm9k
ZXJlZl0gX19yY3UgKg0KPiA+ICAgIGRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo3MzM6MjU6IHNw
YXJzZTogICAgc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSAqDQo+ID4gICAgZHJpdmVycy9hY3Bp
L2FwZWkvZ2hlcy5jOjgxMzoyNTogc3BhcnNlOiBzcGFyc2U6IGluY29tcGF0aWJsZSB0eXBlcyBp
bg0KPiBjb21wYXJpc29uIGV4cHJlc3Npb24gKGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcyk6DQo+
ID4gICAgZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jOjgxMzoyNTogc3BhcnNlOiAgICBzdHJ1Y3Qg
Z2hlc19lc3RhdHVzX2NhY2hlDQo+IFtub2RlcmVmXSBfX3JjdSAqDQo+ID4gICAgZHJpdmVycy9h
Y3BpL2FwZWkvZ2hlcy5jOjgxMzoyNTogc3BhcnNlOiAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2Nh
Y2hlICoNCj4gPg0KPiA+IHVucmN1X3BvaW50ZXIgaXMgdG8gc3RyaXAgdGhlIF9fcmN1IGluIGNt
cHhjaGcuDQo+IA0KPiBJcyB0aGlzIG9ubHkgdG8gc2h1dCB1cCBzcGFyc2Ugb3IgYWN0dWFsbHkg
Zml4aW5nIGFueXRoaW5nPw0KDQpNeSBvcmlnaW5hbCBwdXJwb3NlIGlzIHRvIG1ha2UgaXQgcGFz
cyB0aGUgc3BhcnNlIGNoZWNraW5nLiANCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0K
DQoNCg==
