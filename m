Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A388600E53
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJQL6V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 07:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQL6T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 07:58:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157F580A4;
        Mon, 17 Oct 2022 04:58:17 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=nH1f0WniL36S4K6UlwzhYZieettE3H7d2kQ3EmLX9TQxfdcromRehl8n/IJxjXLIHsCZeH8XmesF500bm49SZMfRnMneVppjLU3yzLItc+brRJKDb82jBzMOeZtJp2SszsD1kRDEZWMIeAM0g9X7+jola7fREilRxnilltw9KmSRg02Vr4qm84VM1S4em1UOk5vuTx191EYJYg8STdoJaCjfd9llSKtGK48bUjnzIoyfSTSgJhiYMbyPqrPvb+Q+jkiu9UEw1vsKqYrQeiryBxl+2DOaGaOqDwTahknIIOgiZkWYVoTj2xJlXBAr970eJHhOEkYfHkTHmNxL0w6rbg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7p0UosY66Y/eBZtGrWPafRIQl8bxwEVMw2NFXNGggw=;
 b=RHu0yaTjskISWXf/i+PKTO25BtZTN3NiObDTa0nWhx8bVCJ4xdQypcLQ83StcN6DOLA4gf+gjyiCHnVF0LiL7jFvrqGNj1V03y2capCMnYL0ZYw5XXpsOsYGlL0FPnJWZjTubHnfaL8Q0qU/jijinZbdZhb43X++7wisB4owRjS0VJe3mg23BOPGYRQQbMCFnmEAdihGr35Rnn4e4GFudZYUDUNS7gp+BcI2E4XEa5I7gdAnOgaXaChz8BM1iJdjR3uVRCUDq3Kui25o2YAqaz/kHOaFJdZ80WodKpmRX/ySUQvykXAw3R75HQebYTxFnXY7mO7nTPDOzN0qbaDt+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7p0UosY66Y/eBZtGrWPafRIQl8bxwEVMw2NFXNGggw=;
 b=bdJsXg4VjAHwfY3tdRRCwtMaTyhjncB1h2CabbL3dRSUP88RuKQ2rq5wd/CwaITVTHHMmO6CFM8RsSGKoKy4vWcrmFJr0P9k5/nEeGXyTYjG0Igz4IxOQYmpQGm5tAVh72I9eD9mhATOSbH8vn6gLkYJLmACxmJA7br9uI37u4s=
Received: from DB6PR07CA0168.eurprd07.prod.outlook.com (2603:10a6:6:43::22) by
 AS2PR08MB10153.eurprd08.prod.outlook.com (2603:10a6:20b:64c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 17 Oct
 2022 11:57:59 +0000
Received: from DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::b9) by DB6PR07CA0168.outlook.office365.com
 (2603:10a6:6:43::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Mon, 17 Oct 2022 11:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT028.mail.protection.outlook.com (100.127.142.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 11:57:59 +0000
Received: ("Tessian outbound 58faf9791229:v130"); Mon, 17 Oct 2022 11:57:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fdc8a27c23839432
X-CR-MTA-TID: 64aa7808
Received: from f747770702d0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 94995981-0B14-4794-B40A-9788B6802EDF.1;
        Mon, 17 Oct 2022 11:57:49 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f747770702d0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 17 Oct 2022 11:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhMf2lGU5j/hQINv/FM3Y1BIyMVa+i//wHGYHoJ/lvUoPl0fOvZpS47i1RrxaKu3wvOEbLHVCbSG8epjZkqDdOKbK9GglJc62jtoangMNFNCvzb3fasqxWkwQYuni8QaNZJ5jn4BlYm09O3uQyZGDGBgt455lb9e+V4eZoRXHeyYaCcJOjJhvDYs0r7mqjvWARBNRXyseTw10R7ULkVtECFi0h6SHYTRDJUfgmKGhQyX1XGot18aJPkJB6gIEnYGiWI8V4fLRG9t9ejr3AUK0CSN7IUUlPrmop8WpLXNbS+f+UFFxlMGR91v6r4O7zL7R4+ury80hJSl2XvpawMkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7p0UosY66Y/eBZtGrWPafRIQl8bxwEVMw2NFXNGggw=;
 b=lGSX+KfpTqEyCj1vy+rH+N4gRlm9QFtOSvdj7QVIYNgeaPXsPH3MdfzgQtTOgMMEcAtq/EI7KKo1JWjJYDreLP4y2fTzvQDOHbPx2wQV7eIdXEhfiSKm1aEqbyhHtQ8FN8hs+VE+ZYL0ZspNnV40BEhqBO0do29lUoOIrjDHbB1BEzN4wqdX5mRHtyZnxcMBUCji+LUPlUbQyCFR/qVMSIQSsIe+zjpJK0ERrIXiKlL5DzlESdYNniV298Egl89c3UlyOvoev1+uHiG/MFB9p9nUuv9W8mFVawDITI5fSCdV+TolK2s6eLt3MvydXUzk9dV5gJtQlJ/cuhMyjy1r3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7p0UosY66Y/eBZtGrWPafRIQl8bxwEVMw2NFXNGggw=;
 b=bdJsXg4VjAHwfY3tdRRCwtMaTyhjncB1h2CabbL3dRSUP88RuKQ2rq5wd/CwaITVTHHMmO6CFM8RsSGKoKy4vWcrmFJr0P9k5/nEeGXyTYjG0Igz4IxOQYmpQGm5tAVh72I9eD9mhATOSbH8vn6gLkYJLmACxmJA7br9uI37u4s=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GV1PR08MB7730.eurprd08.prod.outlook.com (2603:10a6:150:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 11:57:45 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 11:57:45 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, nd <nd@arm.com>
Subject: RE: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/CAAAkTAIABZGGQgAGtTgCAACJ6AIAA7qyggACQP4CAAAr+gIAAA6cAgARBVBCAABH+gIAAKSDw
Date:   Mon, 17 Oct 2022 11:57:43 +0000
Message-ID: <DBBPR08MB453820BB658D063293402C35F7299@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com> <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
 <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXHrP_P79ObKPFFgpN-X7gN+zaN1vKbsQZTJGvm=Uoav3g@mail.gmail.com>
 <Y0l8AeQCrMLYW6g3@hirez.programming.kicks-ass.net>
 <CAMj1kXENTJVZU27PYqwWGod4ESkTxgJ8+2vdqWjR5DVRSbNGDg@mail.gmail.com>
 <DBBPR08MB4538066E9C43FCF2983C8B60F7299@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFNEtGYBefwcSLvs8XokyiZXDypC9mCgZhCkbVkS09Jog@mail.gmail.com>
In-Reply-To: <CAMj1kXFNEtGYBefwcSLvs8XokyiZXDypC9mCgZhCkbVkS09Jog@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|GV1PR08MB7730:EE_|DBAEUR03FT028:EE_|AS2PR08MB10153:EE_
X-MS-Office365-Filtering-Correlation-Id: e1555e97-51ca-402b-31a9-08dab036d667
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1WuyOUUUIp6MbiuA46IUx6xHlsbeMidY8J4ajnKt1aJk+d0ouBQupKKqtfzqUtETnhRnROCnyarZiXzTPxJX9Y0CoWym9HLQfCqS5oQmGl2nqAhyWGw5Sqftn00hpHPl+92VXY+t3HHhXtg/PG/h4x+xZZ0Uwlj6eMSewWw36RtANhe5evReiIu0omtPEkQmAl1vbyj5rtzt0sLWxUvi5Y4rLLoKphyTiy/05XLvfwtTRITSTwCijCowHqcPzge1VWQjIrNDwGjk/CJL/3Tx0vnIeT/4P48BEZU7Z3nXK4Xkg3s9Qa/U5Tcj2q0aHbwyzqLLPugnT9qzNu9IfKKeBGsZmcCnUMPgXMf908Q1B761qkR8gnMuDmaeToGG6NYMJR7UKwqNpooocgAComhhiDOY4AdqLwXjEdqQ6x+qUjawUwi5kdEERpTBhysPVE+J+OsrlIp/rAoQRH+umXBZOC9GBzYJgm1FMMnyFd392X3g//gl5+N9cY4r8O6x2LpmaCVCMqyNM/qUrdL0BvkY1mciuV1U20AGcvztGw8/EVd4iWrRP4wqTM2JEafd2mT3z23ZgmsIdQI2hl4xote2BPnQlrEzYDYaCKqztw/3rhb9t+ZOJQHDCzJkcRn4bsCVoa4sAosZo3P0tOKbHxjAMcq/o9O7M3fOqiitByJNtiqGvA9yNmBwEUlBrXCNH8idbaC68S7gl4ZOejtFuOSFPRilwBnmrQ4sOPJNv+Q2XMPHvil+SM0uZC74f5Q7t4ykxcvCzpsq1KgXPoiAVC3UV6QPFrDnTfdmDpiYqgeABq2JGJ6cWxXVnf5JTHFydwiB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(86362001)(38100700002)(122000001)(478600001)(6916009)(316002)(54906003)(8936002)(55016003)(66556008)(66946007)(76116006)(8676002)(4326008)(66446008)(64756008)(66476007)(38070700005)(6506007)(7696005)(53546011)(5660300002)(41300700001)(26005)(9686003)(83380400001)(71200400001)(7416002)(52536014)(2906002)(33656002)(186003)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7730
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbfa0d6c-f9ac-4339-c9c7-08dab036cdba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au7iRJnCYCTepLuTeVJiXuEMp4rEjkIp4+Pw2ya9AF4rMHvq9XVjzFl0VhtKoTgO+9mZ2MNoQl2oh1za6o1VfSLVJ7Z2UwmJvpcP4Cqf2B0KAqgGERSmzconb6nBkICidWlG+hkaDAqSZriyOuA8CtEfspf7MtPE4SvWoLB/qqcSteEpwgqPqislI3OSgPiclnues2TJsa2MNjxfEBYP3eRMDRSDArLj3g+Qgxbw6ov2wj7mTcDjxKv/M3z07gvV3eDIKFGsW0mTOhDLzxZ4c5MToXyXOfdOsg2YeoEy7K2nTi/iQMNYmuqtSpt7UDQnS7AXKdEB9s+0A0OIlIcCKUokc4SPNHQyZOakHmZFdNa2LuAU8V4KAnQtTVZ0I19Kb6k6cond03laWDWJxLYmi5hfb+puDYpp1mBxbWbdo533+YWXA+3XFjkDgAgkJLJiHAH2QxZSBcDquZV56gA3bD5jaKZqASuc1opHrnBXDbsPdTPuCnczo3VEzuZEx+8FlJdVYrL2Xat2SR9F7lbntdIGgtntMhfeI/sPB2LgPfT8Sh1fklM3DkVBKmWneQWCu0wRA9Rux31WjcNGCfecEf5e00/j3xrk2yApuQPii74TwnHr0j5r5f1FZ7O6i3JxFuNCTbzgUV91DE0jMMCdafVVjXeBB2MCIlg/JZvBeyQC0hw6f1qVPbw9PO7otJ52k+yDR4VVYUGn36/8FmWwWLslghS58LGJen3bE9ri10yYHpCvQVmy+rtSr8Mh0moCLLa+Zkz1YadM2s9LpuzUFRZfuQsdN6UNVbLLp49giC3Ok9al85jm0jK5oRSUrL/l
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(336012)(82310400005)(83380400001)(82740400003)(81166007)(356005)(55016003)(40480700001)(40460700003)(33656002)(86362001)(36860700001)(478600001)(70206006)(70586007)(450100002)(316002)(54906003)(5660300002)(8936002)(6862004)(2906002)(52536014)(186003)(4326008)(8676002)(26005)(53546011)(41300700001)(9686003)(7696005)(6506007)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 11:57:59.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1555e97-51ca-402b-31a9-08dab036d667
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10153
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
ZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDE3LCAyMDIy
IDU6MjcgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBCb3Jp
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsg
SmFtZXMNCj4gTW9yc2UgPEphbWVzLk1vcnNlQGFybS5jb20+OyBUb255IEx1Y2sgPHRvbnkubHVj
a0BpbnRlbC5jb20+OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9y
Zz47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFJvYmVydCBSaWNo
dGVyIDxycmljQGtlcm5lbC5vcmc+OyBSb2JlcnQgTW9vcmUNCj4gPHJvYmVydC5tb29yZUBpbnRl
bC5jb20+OyBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT47IFlhemVuDQo+IEdoYW5u
YW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT47IEphbiBMdWViYmUgPGpsdUBwZW5ndXRyb25peC5k
ZT47DQo+IEtodW9uZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEthbmkg
VG9zaGkNCj4gPHRvc2hpLmthbmlAaHBlLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVs
Lm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsNCj4gUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2Vy
bmVsLm9yZz47IFNodWFpIFh1ZQ0KPiA8eHVlc2h1YWlAbGludXguYWxpYmFiYS5jb20+OyBKYXJr
a28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsNCj4gbGludXgtZWZpQHZnZXIua2VybmVs
Lm9yZzsga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjggNi83XSBhcGVpL2doZXM6IFVzZSB1bnJjdV9wb2ludGVyIGZvciBjbXB4Y2hnDQo+
IA0KPiBIaSBKdXN0aW4sDQo+IA0KPiBPbiBNb24sIDE3IE9jdCAyMDIyIGF0IDEwOjQ3LCBKdXN0
aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEFyZA0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCB2OCA2LzddIGFwZWkvZ2hlczogVXNlIHVucmN1X3BvaW50ZXIgZm9yIGNtcHhjaGcNCj4gPiA+
DQo+ID4gPiBPbiBGcmksIDE0IE9jdCAyMDIyIGF0IDE3OjExLCBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBGcmksIE9jdCAx
NCwgMjAyMiBhdCAwNDozMTozN1BNICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4gPiA+
ID4gPiArICAgICAgIGlmIChzbG90ICE9IC0xKSB7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
IC8qDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIFVzZSByZWxlYXNlIHNlbWFudGljcyB0
byBlbnN1cmUgdGhhdA0KPiA+ID4gZ2hlc19lc3RhdHVzX2NhY2hlZCgpDQo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAqIHJ1bm5pbmcgb24gYW5vdGhlciBDUFUgd2lsbCBzZWUgdGhlIHVwZGF0
ZWQNCj4gPiA+ID4gPiArIGNhY2hlDQo+ID4gPiBmaWVsZHMgaWYNCj4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICogaXQgY2FuIHNlZSB0aGUgbmV3IHZhbHVlIG9mIHRoZSBwb2ludGVyLg0KPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgdmlj
dGltID0geGNoZ19yZWxlYXNlKGdoZXNfZXN0YXR1c19jYWNoZXMgKw0KPiA+ID4gPiA+ICsgc2xv
dCwNCj4gPiA+ID4gPiArDQo+ID4gPiBSQ1VfSU5JVElBTElaRVIobmV3X2NhY2hlKSk7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAvKg0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgKiBBdCB0aGlzIHBvaW50LCB2aWN0aW0gbWF5IHBvaW50IHRvIGEgY2FjaGVkDQo+
ID4gPiA+ID4gKyBpdGVtDQo+ID4gPiBkaWZmZXJlbnQNCj4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICogZnJvbSB0aGUgb25lIGJhc2VkIG9uIHdoaWNoIHdlIHNlbGVjdGVkIHRoZSBzbG90Lg0K
PiA+ID4gSW5zdGVhZCBvZg0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBnb2luZyB0byB0
aGUgbG9vcCBhZ2FpbiB0byBwaWNrIGFub3RoZXIgc2xvdCwNCj4gPiA+ID4gPiArIGxldCdzDQo+
ID4gPiBqdXN0DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIGRyb3AgdGhlIG90aGVyIGl0
ZW0gYW55d2F5OiB0aGlzIG1heSBjYXVzZSBhDQo+ID4gPiA+ID4gKyBmYWxzZQ0KPiA+ID4gY2Fj
aGUNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICogbWlzcyBsYXRlciBvbiwgYnV0IHRoYXQg
d29uJ3QgY2F1c2UgYW55IHByb2JsZW1zLg0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgKi8N
Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKHZpY3RpbSkgew0KPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNhbGxfcmN1KCZyY3VfZGVyZWZlcmVuY2UodmljdGltKS0+cmN1
LA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdoZXNfZXN0YXR1
c19jYWNoZV9yY3VfZnJlZSk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+DQo+
ID4gPiA+IEkgdGhpbmsgeW91IGNhbiB1c2UgdW5yY3VfcG9pbnRlcigpIGhlcmUgaW5zdGVhZCwg
dGhlcmUgc2hvdWxkIG5vdA0KPiA+ID4gPiBiZSBhIGRhdGEgZGVwZW5kZW5jeSBzaW5jZSB0aGUg
LT5yY3UgbWVtYmVyIGl0c2VsZiBzaG91bGQgYmUNCj4gPiA+ID4gb3RoZXJ3aXNlIHVudXNlZCAo
YW5kIGlmIGl0IHdlcmUsIHdlIHdvdWxkbid0IGNhcmUgYWJvdXQgaXRzIHByZXZpb3VzDQo+IGNv
bnRlbnQgYW55d2F5KS4NCj4gPiA+ID4NCj4gPiA+ID4gQnV0IG9ubHkgQWxwaGEgY2FyZXMgYWJv
dXQgdGhhdCBkaXN0aW5jdGlvbiBhbnl3YXksIHNvICpzaHJ1ZyouDQo+ID4gPiA+DQo+ID4gPg0K
PiA+ID4gQWggeWVhaCBnb29kIHBvaW50IC0gYW5kIHdlIGFyZSBub3QgYWN0dWFsbHkgZGVyZWZl
cmVuY2luZyB0aGUNCj4gPiA+IHBvaW50ZXIgYXQgYWxsIGhlcmUsIGp1c3QgYWRkaW5nIGFuIG9m
ZnNldCB0byBnZXQgYXQgdGhlIGFkZHJlc3Mgb2YgdGhlIHJjdQ0KPiBtZW1iZXIuDQo+ID4gPg0K
PiA+ID4gU28gd2UgY2FuIHRha2UgdGhpcyBibG9jayBvdXQgb2YgdGhlIHJjdV9yZWFkX2xvY2so
KSBzZWN0aW9uIGFzIHdlbGwuDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gV2hpbGUgSSBtdWNoIGxp
a2UgdGhlIHhjaGcoKSB2YXJpYW50OyBJIHN0aWxsIGRvbid0IHJlYWxseSBmYW5jeQ0KPiA+ID4g
PiB0aGUgdmVyYmFnZSB0aGUgc3BhcnNlIG5vbnNlbnNlIG1ha2VzIHVzIGRvLg0KPiA+ID4gPg0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgdmljdGltID0geGNoZ19yZWxlYXNlKCZnaGVzX2VzdGF0
dXNfY2FjaGVzW3Nsb3RdLA0KPiA+ID4gbmV3X2NhY2hlKTsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIGlmICh2aWN0aW0pDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNhbGxfcmN1
KCZ2aWN0aW0tPnJjdSwNCj4gPiA+ID4gZ2hlc19lc3RhdHVzX2NhY2hlX3JjdV9mcmVlKTsNCj4g
PiA+ID4NCj4gPiA+ID4gaXMgbXVjaCBuaWNlciBjb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBPdmVy
IGFsbDsgSSdkIHNpbXBseSBpZ25vcmUgc3BhcnNlIChJIG9mdGVuIGRvKS4NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiBObyBkaXNhZ3JlZW1lbnQgdGhlcmUuDQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0
aGluayBvZiB0aGUgdXBkYXRlZCBwYXRjaDoNCj4gPg0KPiA+IGFwZWkvZ2hlczogVXNlIHhjaGco
KSBmb3IgdXBkYXRpbmcgbmV3IGNhY2hlIHNsb3QgaW5zdGVhZCBvZg0KPiA+ICBjbXB4Y2hnKCkN
Cj4gPg0KPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4NCj4g
PiBnaGVzX2VzdGF0dXNfY2FjaGVfYWRkKCkgc2VsZWN0cyBhIHNsb3QsIGFuZCBlaXRoZXIgc3Vj
Y2VlZHMgaW4NCj4gPiByZXBsYWNpbmcgaXRzIGNvbnRlbnRzIHdpdGggYSBwb2ludGVyIHRvIGEg
bmV3IGNhY2hlZCBpdGVtLCBvciBpdCBqdXN0DQo+ID4gZ2l2ZXMgdXAgYW5kIGZyZWVzIHRoZSBu
ZXcgaXRlbSBhZ2Fpbiwgd2l0aG91dCBhdHRlbXB0aW5nIHRvIHNlbGVjdA0KPiA+IGFub3RoZXIg
c2xvdCBldmVuIGlmIG9uZSBtaWdodCBiZSBhdmFpbGFibGUuDQo+ID4NCj4gPiBTaW5jZSBvbmx5
IGluc2VydGluZyBuZXcgaXRlbXMgaXMgbmVlZGVkLCB0aGUgcmFjZSBjYW4gb25seSBjYXVzZSBh
DQo+ID4gZmFpbHVyZSBpZiB0aGUgc2VsZWN0ZWQgc2xvdCB3YXMgdXBkYXRlZCB3aXRoIGFub3Ro
ZXIgbmV3IGl0ZW0NCj4gPiBjb25jdXJyZW50bHksIHdoaWNoIG1lYW5zIHRoYXQgaXQgaXMgYXJi
aXRyYXJ5IHdoaWNoIG9mIHRob3NlIHR3bw0KPiA+IGl0ZW1zIGdldHMgZHJvcHBlZC4gVGhpcyBt
ZWFucyB0aGUgY21weGNoZygpIGFuZCB0aGUgc3BlY2lhbCBjYXNlIGFyZQ0KPiA+IG5vdCBuZWNl
c3NhcnksIGFuZCBoZW5jZSBqdXN0IGRyb3AgdGhlIGV4aXN0aW5nIGl0ZW0gdW5jb25kaXRpb25h
bGx5Lg0KPiA+IE5vdGUgdGhhdCB0aGlzIGRvZXMgbm90IHJlc3VsdCBpbiBsb3NzIG9mIGVycm9y
IGV2ZW50cywgaXQgc2ltcGx5DQo+ID4gbWVhbnMgd2UgbWlnaHQgY2F1c2UgYSBmYWxzZSBjYWNo
ZSBtaXNzLCBhbmQgcmVwb3J0IHRoZSBzYW1lIGV2ZW50IG9uZQ0KPiA+IGFkZGl0aW9uYWwgdGlt
ZSBpbiBxdWljayBzdWNjZXNzaW9uIGV2ZW4gaWYgdGhlIGNhY2hlIHNob3VsZCBoYXZlIHByZXZl
bnRlZA0KPiB0aGF0Lg0KPiA+DQo+IA0KPiBQbGVhc2UgYWRkIGEgbGluZSBoZXJlDQo+IA0KPiBD
by1kZXZlbG9wZWQtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiBbSnVzdGluXTog
SSByZW1vdmVkIF9fcmN1IGFubm90YXRpb24gb2YgdmljdGltLCByZW1vdmVkIHRoZQ0KPiA+IFJD
VV9JTklUSUFMSVpFUiBjYXN0IGFuZCBhZGRlZCB0aGUgdW5wdHIgZm9yIHhjaGcuDQo+ID4NCj4g
PiBkcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYXBlaS9n
aGVzLmMgYi9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMgaW5kZXgNCj4gPiAyN2M3MmIxNzVlNGIu
LjVmYzhhMTM1NDUwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMNCj4gPiBAQCAtMTUwLDcgKzE1MCw3
IEBAIHN0cnVjdCBnaGVzX3ZlbmRvcl9yZWNvcmRfZW50cnkgeyAgc3RhdGljIHN0cnVjdA0KPiA+
IGdlbl9wb29sICpnaGVzX2VzdGF0dXNfcG9vbDsgIHN0YXRpYyB1bnNpZ25lZCBsb25nDQo+ID4g
Z2hlc19lc3RhdHVzX3Bvb2xfc2l6ZV9yZXF1ZXN0Ow0KPiA+DQo+ID4gLXN0YXRpYyBzdHJ1Y3Qg
Z2hlc19lc3RhdHVzX2NhY2hlDQo+ID4gKmdoZXNfZXN0YXR1c19jYWNoZXNbR0hFU19FU1RBVFVT
X0NBQ0hFU19TSVpFXTsNCj4gPiArc3RhdGljIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUgX19y
Y3UNCj4gPiArKmdoZXNfZXN0YXR1c19jYWNoZXNbR0hFU19FU1RBVFVTX0NBQ0hFU19TSVpFXTsN
Cj4gPiAgc3RhdGljIGF0b21pY190IGdoZXNfZXN0YXR1c19jYWNoZV9hbGxvY2VkOw0KPiA+DQo+
ID4gIHN0YXRpYyBpbnQgZ2hlc19wYW5pY190aW1lb3V0IF9fcmVhZF9tb3N0bHkgPSAzMDsgQEAg
LTc4NSwzMSArNzg1LDI2DQo+ID4gQEAgc3RhdGljIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUg
KmdoZXNfZXN0YXR1c19jYWNoZV9hbGxvYygNCj4gPiAgICAgICAgIHJldHVybiBjYWNoZTsNCj4g
PiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIGdoZXNfZXN0YXR1c19jYWNoZV9mcmVlKHN0cnVj
dCBnaGVzX2VzdGF0dXNfY2FjaGUgKmNhY2hlKQ0KPiA+ICtzdGF0aWMgdm9pZCBnaGVzX2VzdGF0
dXNfY2FjaGVfcmN1X2ZyZWUoc3RydWN0IHJjdV9oZWFkICpoZWFkKQ0KPiA+ICB7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICpjYWNoZTsNCj4gPiAgICAgICAgIHUzMiBs
ZW47DQo+ID4NCj4gPiArICAgICAgIGNhY2hlID0gY29udGFpbmVyX29mKGhlYWQsIHN0cnVjdCBn
aGVzX2VzdGF0dXNfY2FjaGUsIHJjdSk7DQo+ID4gICAgICAgICBsZW4gPSBjcGVyX2VzdGF0dXNf
bGVuKEdIRVNfRVNUQVRVU19GUk9NX0NBQ0hFKGNhY2hlKSk7DQo+ID4gICAgICAgICBsZW4gPSBH
SEVTX0VTVEFUVVNfQ0FDSEVfTEVOKGxlbik7DQo+ID4gICAgICAgICBnZW5fcG9vbF9mcmVlKGdo
ZXNfZXN0YXR1c19wb29sLCAodW5zaWduZWQgbG9uZyljYWNoZSwgbGVuKTsNCj4gPiAgICAgICAg
IGF0b21pY19kZWMoJmdoZXNfZXN0YXR1c19jYWNoZV9hbGxvY2VkKTsNCj4gPiAgfQ0KPiA+DQo+
ID4gLXN0YXRpYyB2b2lkIGdoZXNfZXN0YXR1c19jYWNoZV9yY3VfZnJlZShzdHJ1Y3QgcmN1X2hl
YWQgKmhlYWQpIC17DQo+ID4gLSAgICAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICpjYWNo
ZTsNCj4gPiAtDQo+ID4gLSAgICAgICBjYWNoZSA9IGNvbnRhaW5lcl9vZihoZWFkLCBzdHJ1Y3Qg
Z2hlc19lc3RhdHVzX2NhY2hlLCByY3UpOw0KPiA+IC0gICAgICAgZ2hlc19lc3RhdHVzX2NhY2hl
X2ZyZWUoY2FjaGUpOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgdm9pZCBnaGVzX2VzdGF0
dXNfY2FjaGVfYWRkKA0KPiA+ICAgICAgICAgc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljICpnZW5l
cmljLA0KPiA+ICAgICAgICAgc3RydWN0IGFjcGlfaGVzdF9nZW5lcmljX3N0YXR1cyAqZXN0YXR1
cykgIHsNCj4gPiAgICAgICAgIGludCBpLCBzbG90ID0gLTEsIGNvdW50Ow0KPiA+ICAgICAgICAg
dW5zaWduZWQgbG9uZyBsb25nIG5vdywgZHVyYXRpb24sIHBlcmlvZCwgbWF4X3BlcmlvZCA9IDA7
DQo+ID4gLSAgICAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICpjYWNoZSwgKnNsb3RfY2Fj
aGUgPSBOVUxMLA0KPiAqbmV3X2NhY2hlOw0KPiA+ICsgICAgICAgc3RydWN0IGdoZXNfZXN0YXR1
c19jYWNoZSAqY2FjaGUsICpuZXdfY2FjaGU7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZ2hlc19lc3Rh
dHVzX2NhY2hlICp2aWN0aW07DQo+ID4NCj4gPiAgICAgICAgIG5ld19jYWNoZSA9IGdoZXNfZXN0
YXR1c19jYWNoZV9hbGxvYyhnZW5lcmljLCBlc3RhdHVzKTsNCj4gPiAgICAgICAgIGlmIChuZXdf
Y2FjaGUgPT0gTlVMTCkNCj4gPiBAQCAtODIwLDEzICs4MTUsMTEgQEAgc3RhdGljIHZvaWQgZ2hl
c19lc3RhdHVzX2NhY2hlX2FkZCgNCj4gPiAgICAgICAgICAgICAgICAgY2FjaGUgPSByY3VfZGVy
ZWZlcmVuY2UoZ2hlc19lc3RhdHVzX2NhY2hlc1tpXSk7DQo+ID4gICAgICAgICAgICAgICAgIGlm
IChjYWNoZSA9PSBOVUxMKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc2xvdCA9IGk7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc2xvdF9jYWNoZSA9IE5VTEw7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAg
ICAgICAgICAgICAgICAgZHVyYXRpb24gPSBub3cgLSBjYWNoZS0+dGltZV9pbjsNCj4gPiAgICAg
ICAgICAgICAgICAgaWYgKGR1cmF0aW9uID49IEdIRVNfRVNUQVRVU19JTl9DQUNIRV9NQVhfTlNF
Qykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNsb3QgPSBpOw0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHNsb3RfY2FjaGUgPSBjYWNoZTsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAg
ICBjb3VudCA9IGF0b21pY19yZWFkKCZjYWNoZS0+Y291bnQpOyBAQCAtODM1LDE3DQo+ICs4Mjgs
MjQNCj4gPiBAQCBzdGF0aWMgdm9pZCBnaGVzX2VzdGF0dXNfY2FjaGVfYWRkKA0KPiA+ICAgICAg
ICAgICAgICAgICBpZiAocGVyaW9kID4gbWF4X3BlcmlvZCkgew0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIG1heF9wZXJpb2QgPSBwZXJpb2Q7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgc2xvdCA9IGk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc2xvdF9jYWNoZSA9IGNh
Y2hlOw0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9DQo+ID4gLSAgICAgICAv
KiBuZXdfY2FjaGUgbXVzdCBiZSBwdXQgaW50byBhcnJheSBhZnRlciBpdHMgY29udGVudHMgYXJl
IHdyaXR0ZW4NCj4gKi8NCj4gPiAtICAgICAgIHNtcF93bWIoKTsNCj4gPiAtICAgICAgIGlmIChz
bG90ICE9IC0xICYmIGNtcHhjaGcoZ2hlc19lc3RhdHVzX2NhY2hlcyArIHNsb3QsDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNsb3RfY2FjaGUsIG5ld19jYWNoZSkgPT0g
c2xvdF9jYWNoZSkNCj4gew0KPiA+IC0gICAgICAgICAgICAgICBpZiAoc2xvdF9jYWNoZSkNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBjYWxsX3JjdSgmc2xvdF9jYWNoZS0+cmN1LA0KPiBn
aGVzX2VzdGF0dXNfY2FjaGVfcmN1X2ZyZWUpOw0KPiA+IC0gICAgICAgfSBlbHNlDQo+ID4gLSAg
ICAgICAgICAgICAgIGdoZXNfZXN0YXR1c19jYWNoZV9mcmVlKG5ld19jYWNoZSk7DQo+ID4gKyAg
ICAgICBpZiAoc2xvdCAhPSAtMSkgew0KPiA+ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAg
ICAgICAgICAgICAgKiBVc2UgcmVsZWFzZSBzZW1hbnRpY3MgdG8gZW5zdXJlIHRoYXQNCj4gZ2hl
c19lc3RhdHVzX2NhY2hlZCgpDQo+ID4gKyAgICAgICAgICAgICAgICAqIHJ1bm5pbmcgb24gYW5v
dGhlciBDUFUgd2lsbCBzZWUgdGhlIHVwZGF0ZWQgY2FjaGUNCj4gZmllbGRzIGlmDQo+ID4gKyAg
ICAgICAgICAgICAgICAqIGl0IGNhbiBzZWUgdGhlIG5ldyB2YWx1ZSBvZiB0aGUgcG9pbnRlci4N
Cj4gDQo+IFBsZWFzZSBtb3ZlIHRoZSBjb21tZW50IGJhY2sgd2hlcmUgaXQgd2FzLiAnQXQgdGhp
cyBwb2ludCcgaXMgbm93IGFtYmlndW91cw0KPiBiZWNhdXNlIHZpY3RpbSBoYXMgbm90IGJlZW4g
YXNzaWduZWQgeWV0Lg0KPiANCj4gPiArICAgICAgICAgICAgICAgICogQXQgdGhpcyBwb2ludCwg
dmljdGltIG1heSBwb2ludCB0byBhIGNhY2hlZCBpdGVtDQo+IGRpZmZlcmVudA0KPiA+ICsgICAg
ICAgICAgICAgICAgKiBmcm9tIHRoZSBvbmUgYmFzZWQgb24gd2hpY2ggd2Ugc2VsZWN0ZWQgdGhl
IHNsb3QuDQo+IEluc3RlYWQgb2YNCj4gPiArICAgICAgICAgICAgICAgICogZ29pbmcgdG8gdGhl
IGxvb3AgYWdhaW4gdG8gcGljayBhbm90aGVyIHNsb3QsIGxldCdzIGp1c3QNCj4gPiArICAgICAg
ICAgICAgICAgICogZHJvcCB0aGUgb3RoZXIgaXRlbSBhbnl3YXk6IHRoaXMgbWF5IGNhdXNlIGEg
ZmFsc2UNCj4gY2FjaGUNCj4gPiArICAgICAgICAgICAgICAgICogbWlzcyBsYXRlciBvbiwgYnV0
IHRoYXQgd29uJ3QgY2F1c2UgYW55IHByb2JsZW1zLg0KPiA+ICsgICAgICAgICAgICAgICAgKi8N
Cj4gPiArICAgICAgICAgICAgICAgdmljdGltID0NCj4gdW5yY3VfcG9pbnRlcih4Y2hnX3JlbGVh
c2UoJmdoZXNfZXN0YXR1c19jYWNoZXNbc2xvdF0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5ld19jYWNoZSkpOw0KPiANCj4gRG9lc24ndCB0aGlzIHN0aWxs
IHRyaWdnZXIgdGhlIHNwYXJzZSB3YXJuaW5nIG9uIHg4Nj8NClllcywNCkkgd2lsbCBhZGQgdGhl
IFJDVV9JTklUSUFMSVpFUiBiYWNrIGlmIFBldGVyIGRvZXNuJ3Qgb2JqZWN0Lg0KDQoNCi0tDQpD
aGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
