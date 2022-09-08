Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CA5B11E8
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIHBMK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIHBMI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 21:12:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9202C6CDE;
        Wed,  7 Sep 2022 18:12:05 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=MSL2f4r7bLLhp5RA50ECGMiKNe3A/CPTTN6RiZKOJbolIbrBrW5cSrAX/EehVF5uPmTlThPEsno5AaDe27+dcuDzQz6IFhref3KNudbR9wJKLNJ40HDB0G/meyeeAywNzLyoCtdSI7POiMxAz6CGftgK7m8LUVl93u6VI+Hn1h9SdF1xkitFT0aql0Jic7ZECsdKzo4ARA/WIbJP/SPZZ1FM8Sbd57dSNUirIRDO06rfoUzD7uCI6+MgjpN4B/09Ls1t3+9TDGFUzyfoL278nXy5Qitg5ct30cCHjGR9k8+aQpfesreLAZ04KmPUohhmZClPLoCVY7noGF4q04uNeA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5k7oCjJeF2KrlJOww+T0lqpIYcoSNH5kH37hYcCeI=;
 b=HBb0HRPMHl6dlF16Hs209jIvq0Km1kjWCcHMNETlhnQjiQWCQSCglnw/txKcxvxDbkNTUSUA0YzEKprTl0w9k3I7DojJxGUNKvboeNpDdHKPmaYqkPUqhauXq84k2JgKe1wJOzFOV9zyNtFsQ2yhcM5Gkl5S4Y4v6y8jOIlmShMgJ3jUSio+SBjdiB5BjUpa9zIjEa+s2F+c9XSH+H3SUnDT1rsRNon+VtyjgjBdkL3bs/upRFnjUM2uXiY690alQc+TTA+P8OLvnNM4tOiTUKGgEImI9Nit0PtaboBThVMMTl4KPFKIDpN1GuZslinC2bq2RElWMk5BndCLdMT8eA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5k7oCjJeF2KrlJOww+T0lqpIYcoSNH5kH37hYcCeI=;
 b=WVjUNTbDIkJr5MforGoVa6kqdFlIjV2ZKfigW8iWE6M0Cp6a+X9aNxR8Y+/aGZXXfPrKWu1sG/5quf7PDfhDgqyAaixlA3BPfcZKVnsFNrD+/BGQUGI2vj1J0Zxx7OAKm8Ly2eu6Y2uhbBix7S8UmNH8eoGEuawk0n4qCNuzPPA=
Received: from AM6PR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::42) by PAVPR08MB9507.eurprd08.prod.outlook.com
 (2603:10a6:102:313::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 01:12:01 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::55) by AM6PR01CA0065.outlook.office365.com
 (2603:10a6:20b:e0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 01:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 01:12:00 +0000
Received: ("Tessian outbound 6a3290ff1310:v123"); Thu, 08 Sep 2022 01:12:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 164c0efe5ba70b0b
X-CR-MTA-TID: 64aa7808
Received: from b38283e6ff2a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F64BF6A4-04E2-41BF-968F-727A7B8C1D3A.1;
        Thu, 08 Sep 2022 01:11:54 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b38283e6ff2a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Sep 2022 01:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YncUWK6/rP/1aa9OUBy+fFZKFkMWJQWSF8NVjCTodBxRCcaMLx9T68cv//mCx3BtVJ9pmbTSzUhTOzjeEv5Eyc44jJuVEZZvSsPVzkuUgg7C+kGaD+/sQVYMTyzy4lmr8pdxPcMhgXfWP4Op+vFxh9CjWVNcfmigh79n1fpHh2ikdn0cVxipjefA6MQLKwQEDZBJ/kLZzo+fKOrX1jg+xTKx9UIa3CU2PiMqPyo8nBuGggrszFpMqcrSzAupYB1jk+0VO42b2U+f9ExYPSYKaG90fHNuFsyeshN5eFCaTUGUcj5RdNDtE15QOKqy5N0Cotf/fzhOnszvnlKONGpylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5k7oCjJeF2KrlJOww+T0lqpIYcoSNH5kH37hYcCeI=;
 b=ZxMNbqLriIGqZG1CAo7tjQ7yDTjd+htI5oQXYGVqLJwj9MTPXyozqMw0EzP+sWtOMCFLWfaoecFGs2U3JSDOzLyLRIok12dKB9cIV9lv5BEstzx3dDOOSG8SAsPtUI2O+P/CcONL1clnUPmRZ2k73h7nc0AC0qg4bN+tH3SxC5B98zO8+0OZWLYWGvb2D83FxaQJmd0DHzVju/F2oMDIr4RuSXXmDVfb3QbEudt+6Nt5S5HlZvxEO8x3HBuZ6CEO7zouYMJw+7T6WbdOkyAI1EDlFkx5THMAUZ4F51C7tewogAjHtfpJ258uk7JPS9FDxVwYlyHOFJkiJ6Q+63NK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5k7oCjJeF2KrlJOww+T0lqpIYcoSNH5kH37hYcCeI=;
 b=WVjUNTbDIkJr5MforGoVa6kqdFlIjV2ZKfigW8iWE6M0Cp6a+X9aNxR8Y+/aGZXXfPrKWu1sG/5quf7PDfhDgqyAaixlA3BPfcZKVnsFNrD+/BGQUGI2vj1J0Zxx7OAKm8Ly2eu6Y2uhbBix7S8UmNH8eoGEuawk0n4qCNuzPPA=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AM8PR08MB5667.eurprd08.prod.outlook.com (2603:10a6:20b:1d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 01:11:53 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%7]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 01:11:53 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v5 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v5 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYwTvHuK7oTkH+CUWEEqKBXV9tH63UsicAgAAKjyA=
Date:   Thu, 8 Sep 2022 01:11:52 +0000
Message-ID: <DBBPR08MB4538E77A2E291EB869A5A26CF7409@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220905152439.77770-1-justin.he@arm.com>
 <20220905152439.77770-6-justin.he@arm.com>
 <MW4PR84MB184996C9B94E6F5DA3EBB11E82409@MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB184996C9B94E6F5DA3EBB11E82409@MW4PR84MB1849.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 85aec2cf-1606-461d-436c-08da91372256
x-ms-traffictypediagnostic: AM8PR08MB5667:EE_|VE1EUR03FT024:EE_|PAVPR08MB9507:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N064rkQtffRifvQGwdPpplAuHllgVJgny7sEp13XSJZaWnGT09rU9wqhFL/+r94idlRcvihQUMB4iJEiX6goylM28oSts/f0kCTsDA+Arbrkm3lbbseU/y+ZxWTjNhoMFImQ8inD8iAHVyaROTafQjlrvLKsLoT+pq7b6xXGdvF1DCTBjB4TknxLdRydH4ldW9HIW54HVgLU+UpOM7uDos/B/KgiuQ+qE5YWsZBa0UStQ2BvDbG0Dif/5y2VMLRUZkSkZPZXhprU5ArdlkLOBaIHT1xTC+7Gv7Xyw5vteZzLr1VyDUXlCxJp90l5Rf445Q0FFW9ptRWKPTgHbYo71kEoW/DB3oroM7vdZbpoz79f2G0HLfiMvIxq9G7zyt7m8gdv6H/Xspqct5Uc6V+02h2piK+6VkeUFkQcAC8MgVyjpMsLrpUfQaVbcunr2bko/2RWMRNHGoJKNKp0pyPLGe74Ily/IrIYhpV6ieTSWXji3yTxQnM+cmslwzIY+PydMSu/LdtcpAYJYbnC6Je3ImwcCNLr1hafbK5Gbs1oC3O77IrerBCqk7wvDnYkkfY2WLtJFRSqPq6ec5MSDT7Mq92DVL2BT42Y9Ovo3r58YRr6M/J9OskzaGbErE9Ze/Kls+3gFGM9Um1V/niAY0qpQi1x9SxzP0CjSZCYMsvt/9Qw/+aWrmHPwnv/b14a+7Dj3y4mC5RGVBo+lDG1kLEsY2HSrojsNb+NBsD21BArR5bBEzqLO3C36EOGIw6ukGWsHm3FvhtFzV6jClU5ONfHxgMp52e9CpR14M4548GOySg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(38070700005)(921005)(76116006)(38100700002)(122000001)(4326008)(54906003)(66946007)(66556008)(66476007)(8676002)(296002)(64756008)(66446008)(316002)(2906002)(55016003)(5660300002)(8936002)(186003)(7416002)(110136005)(7696005)(9686003)(83380400001)(478600001)(71200400001)(6506007)(52536014)(41300700001)(53546011)(26005)(33656002)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5667
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1bede179-4c99-4487-89c0-08da91371d7b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVpE4OStKVuws9oI6ayFnPTSJRygNMU+Fk81vmNCdGrRRdAvOsxMCHdGQN7uTwNgj3xcCLtVZdE9i7s1QVssLxEqInICY5oO7W0z/KvDwWHNtYWqV0dOgtc/znMSnCpHuFpCkWAMyvTVLTIVKIYPBbIOq2yuU582xMw7NmXllBALrkUjMX/y7GtOto7BBApM3fxm2DNt/FjvWFL3GHY9+gL1T+jj386R1h3AMD03DIu35/jpytz+tgl4734CjvWA2TJ2c+/vwds5akCvi54r1HSxMcqJBah/EaMFbqRke7haw2nseSEnjpaAusNYpQR+NFdYNh3vQ95bEDP73flh4qgL/zITHOldxjwBuY51k+TLPy+oM1EAIifUsB2uiI5Z/ypW8G+7osWpvH8k2yPfQYAcp2EgzdOhWMV3yhGiXxSbTa/Gh/1X7XgvBeiXwVtnmWqVWB1/xEPhN6jqB9Cdk8gYJuQvThgmPpszA0rg3t3F4lGL0QPcJthhU4YNfP6pd3hkP08rG3o7NJefOl1tz0UPSb1pvU4HF77tFyZA47cNIf3UvQGJhxKol3i0ltARzYpgQ32gBmv7ir2Q/8JTKIZI08DLCCKeMK1dLKtBO6G0k1awD3sLqimymTpSw+b2dqGI8abGBKgIoDwzbqgyePcA247lI+BEvunQiVn6JgIilnkaZdVmO6XOtgspjoJ8lcNOBpIbXh0rx/vPlfiLcEuuODg5mFbx/2jy01h8qhokA4tvzUrUMSvQNoulFpwsl7kTDSpBKYOMncKjP5SkX5hQ+C0ZOxmZPCnJAHEd87U=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(46966006)(36840700001)(4326008)(8676002)(83380400001)(70206006)(54906003)(316002)(82310400005)(450100002)(110136005)(86362001)(26005)(70586007)(9686003)(47076005)(33656002)(186003)(336012)(55016003)(40480700001)(52536014)(2906002)(81166007)(356005)(921005)(8936002)(53546011)(7696005)(82740400003)(5660300002)(36860700001)(478600001)(6506007)(40460700003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:12:00.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aec2cf-1606-461d-436c-08da91372256
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9507
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgS2FuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthbmksIFRv
c2hpIDx0b3NoaS5rYW5pQGhwZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgOCwg
MjAyMiA4OjMxIEFNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgTGVuIEJy
b3duIDxsZW5iQGtlcm5lbC5vcmc+OyBKYW1lcw0KPiBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNv
bT47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IEJvcmlzbGF2DQo+IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+
Ow0KPiBSb2JlcnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3JnPjsgUm9iZXJ0IE1vb3JlIDxyb2Jl
cnQubW9vcmVAaW50ZWwuY29tPjsNCj4gUWl1eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+
OyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFtQGFtZC5jb20+OyBKYW4gTHVlYmJlIDxq
bHVAcGVuZ3V0cm9uaXguZGU+OyBLaHVvbmcNCj4gRGluaCA8a2h1b25nQG9zLmFtcGVyZWNvbXB1
dGluZy5jb20+DQo+IENjOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOw0KPiBSYWZhZWwgSiAu
IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgU2h1YWkgWHVlDQo+IDx4dWVzaHVhaUBsaW51
eC5hbGliYWJhLmNvbT47IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+Ow0KPiBs
aW51eC1lZmlAdmdlci5rZXJuZWwub3JnOyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2NSA1LzhdIEVEQUMvZ2hlczogTWFrZSBnaGVzX2VkYWMgYSBwcm9wZXIgbW9kdWxl
IHRvDQo+IHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvbiBnaGVzDQo+IA0KPiBPbiBNb25kYXksIFNl
cHRlbWJlciA1LCAyMDIyIDk6MjUgQU0sIEppYSBIZSB3cm90ZToNCj4gPiAtdm9pZCBnaGVzX2Vk
YWNfdW5yZWdpc3RlcihzdHJ1Y3QgZ2hlcyAqZ2hlcykNCj4gPiArc3RhdGljIHZvaWQgZ2hlc19l
ZGFjX3VucmVnaXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBt
ZW1fY3RsX2luZm8gKm1jaTsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4NCj4gPiAt
CWlmICghZ2hlc19lZGFjX2ZvcmNlX2VuYWJsZSkNCj4gPiAtCQlyZXR1cm47DQo+ID4gLQ0KPiAN
Cj4gSSBhbSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzIG9yaWdpbmFsIGNoZWNrLiAgQXNzdW1pbmcg
aXQgaXMgc2FmZSB0byBkZWxldGUgaXQgbm93DQo+IChhcyB5b3UgbWVudGlvbmVkIGluIG90aGVy
IGVtYWlsIHcvbyBkZXNjcmlwdGlvbiksIEkgc3VnZ2VzdCBhZGRpbmcgc29tZQ0KPiBkZXNjcmlw
dGlvbiB0byB0aGUgY29tbWl0IGxvZy4NCj4gDQpUaGFua3MsIHdpbGwgZG8NCkkndmUgdGVzdGVk
IHRoZSBpbnNtb2Qvcm1tb2QgbXVsdGlwbGUgdGltZXMgb24gQXJtIGhvc3QuDQoNCkkgd2lsbCB3
YWl0IGZvciBvdGhlcnMnIGNvbW1lbnRzIGZvciBhIHdoaWxlIGJlZm9yZSBzZW5kaW5nIHRoZSBu
ZXcgdmVyc2lvbi4NCj4gQXQgaGlnaC1sZXZlbCwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUu
DQo+IEFja2VkLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+DQoNClRoYW5rcyBh
IGxvdCBmb3IgdGhlIGhlbHAg8J+Yig0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQo=
