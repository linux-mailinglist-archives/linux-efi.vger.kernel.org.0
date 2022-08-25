Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43C5A0CDD
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiHYJm4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHYJmz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 05:42:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50041.outbound.protection.outlook.com [40.107.5.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD54101D6;
        Thu, 25 Aug 2022 02:42:54 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=OCTL+ggw6cYyNFqr/lgaYdmVwnUcfSYRTw6Gh1kGwtHobIEizSCX8S16PVgzxPjlX3pB3pvZ5rWJ3iI0xcMorMC79sSrQjYuTRP8mdjhYk+raU8iymgVSSeVc+1Y03PClm9ku+rW7UsQXciaCsTVVlqEwEXXMVa6Sssih62/dFTxYt5/HkJ5KofSCYkA58CgLetpbHoNny19PcgqUAbUYVQ/4J7fm9TQPuzZVVmNbr0qAF7Vy0q1AiLmVn1Sh9o0LUuCg5ocWWMwXwo7l6yK6IfucuXOcN23snuWcIaUpE0r0+o8L4baFgKf3Rzt0z7u44E871C4jaK4ROtmbPXYVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUGvufGdGmFhJkpPFI7tBr4SzCD+9Atb6gpmhhBzs/g=;
 b=YtJ5dsKXCfeK0Dl61CdFbW0KqLeoa1ZlA+GE6lSJkxwibn60lvuFNJYH6uS3/Boi+w5R/8PJBqL7SzfNrlcQTwBB0OE/3AkY4hZWQJAmvIJjlKz+me+oEEvw03t0IJWmFnQNUVmh1frVbH3iUlZFHrwLwEji58pDY1JvHDF/ixDn0joWQLgkq7Lrr2AYaHmv5FpZYVyZrsUw4L7xmhDt5GRhYIque7g8VufFjO8CIUXdywKP3P0oxg3S9J0XLO2DP91YQmHJYu86fMHr4wyV0xBIK4XLIsaUWKbSJAxTjKt6cLSwLSj2ybGz39R62/GfSZDM5dgza/stPMaxsOlYnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUGvufGdGmFhJkpPFI7tBr4SzCD+9Atb6gpmhhBzs/g=;
 b=1UoQN/FoSSKYUKfefUUrEf+WUVYolM6mQuE0099T99OblRR9W7faL5rAFtVjS3dPxCe5OJWRvq7YeSKCaGkaUnmzwRE+84DiEZSPI06xasLY5WGf4IMB6+yNyh05ppWKwu0BNgaRWAYr838bjfAb4Up23JMJXENs0kxdN5kYsGY=
Received: from AS8PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:20b:310::20)
 by AS8PR08MB8492.eurprd08.prod.outlook.com (2603:10a6:20b:565::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 09:42:51 +0000
Received: from AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::ba) by AS8PR04CA0015.outlook.office365.com
 (2603:10a6:20b:310::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 09:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT022.mail.protection.outlook.com (100.127.140.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 09:42:51 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 25 Aug 2022 09:42:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7c89cacc277b8201
X-CR-MTA-TID: 64aa7808
Received: from 63d257fa8d5e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7B407956-B5A7-459A-8A22-4B446CD5A254.1;
        Thu, 25 Aug 2022 09:42:50 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 63d257fa8d5e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 25 Aug 2022 09:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJYYWZuVKhO36FdJbxKtApbvGwF7WFskfh5RPFB81vNZ4jcqe3TepW6OoBnosOiA4ADrlfcbEa648rN/bpwyj+/gTEjIqkWmDiGUqgp9vzT0enJg+o87PvJ/Ke1oVdSncJph6fHjDCi0ZkyH2WT01JMSRl33om2jZ4bDPis3lhujaanKgK8x04jaVVIpkWqhyrE+yzScqsItAbU3vScPd4RAtcgv15xeAx9fon3oVHl8N74HwpE1rC8qbQWn1RRkh9AmCD1TMLPKxhLWS4dn2+EfCdQcmyoa5z1IW/5s0T3TsM+PXOegvvhZZS3qxOVc5doCowYmr7lKl6qutJvC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUGvufGdGmFhJkpPFI7tBr4SzCD+9Atb6gpmhhBzs/g=;
 b=hu4wP9Asfa6MAlI5D4qYCeEeN27p0gk7XlRg1LBKKWnH8chw8sqNsx2iHqfImhyw2Og6lDm5cAbzPko8fdk8YFoMD17sbHbi9kGfSdlEE0OjUKTRWz8SXRuyGsgg8sFWodyVciZ2n1mlwnXggPepOLHuYoEfQAR8YwCTx+MnmH8WCBKNTXCgV1qcbM0SLtbmPl7ZLRj936VXrr+d0lc49RMp5EM1kqbArMJN0zZzTotZkDhM4+MoQFspzffQCZ/MKXK7A4yeXm/6F1hM5jC9pWlAl9FOEpLODC1KEXPD1IoGmlhuReFuI50JdcAJqEYFXPHvI6xVVDWM1/M9Gr6jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUGvufGdGmFhJkpPFI7tBr4SzCD+9Atb6gpmhhBzs/g=;
 b=1UoQN/FoSSKYUKfefUUrEf+WUVYolM6mQuE0099T99OblRR9W7faL5rAFtVjS3dPxCe5OJWRvq7YeSKCaGkaUnmzwRE+84DiEZSPI06xasLY5WGf4IMB6+yNyh05ppWKwu0BNgaRWAYr838bjfAb4Up23JMJXENs0kxdN5kYsGY=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB9203.eurprd08.prod.outlook.com (2603:10a6:10:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:42:18 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 09:42:17 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RESEND PATCH v3 4/9] EDAC/ghes: Move ghes_edac.force_load to
 setup parameter
Thread-Topic: [RESEND PATCH v3 4/9] EDAC/ghes: Move ghes_edac.force_load to
 setup parameter
Thread-Index: AQHYtj3GzHVOUKz3/UmUjsOno++RI62+No2AgAEpSAA=
Date:   Thu, 25 Aug 2022 09:42:16 +0000
Message-ID: <DBBPR08MB4538490A4955EC7DDCC4ED07F7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-5-justin.he@arm.com> <YwZJP25sfKcfw9eT@zn.tnic>
In-Reply-To: <YwZJP25sfKcfw9eT@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 03cd7031-7393-4acf-52f5-08da867e2dd7
x-ms-traffictypediagnostic: DU0PR08MB9203:EE_|AM7EUR03FT022:EE_|AS8PR08MB8492:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: U29hvfbRhmsl4ZamtzDQckddSJCXMTIpKUlqBs9DuG9sBShzPhPZ4cJMIeGSknCJLDAgF93x9wMqlO3M0XgtNxZRaIBjQjSLJGfALh9gqoYqFkCgRRJkcA7ti/5aB6X8Yd7NIquxHh6cWQusDebl9BrP3JTrPVnAoVbcs0ajst4IIUoKbVK6QD8SbCdvIoVqFKJ8lLmVaI6yhfDjoxsHwbiVuNj4b5axryET4GhHq8wpKp8ERLwHgn5V8+tAzB0kOEQ6nC7MQjZKlILfiaUDpwI8tloVTF2ZRlLHs0ST3iKpsCK8zXuQ9gTq4z8U0SnO5oSlMbdNfPohSLhiD+NpQ0lrk/onu57IyO5QrX908KXOHVVILIUwqA98fBuXp1cPKSgH0gBBk4QuEBM/ARqHatPc8YA6u4nBW4JaFnvvhVc8YUfHsr4JXHaO0ouY0K/94MCQBzoM00qwAYT16kVhr58mS3+ubgxHxv0bN6lxRfqYAbAEJ0rXKQn7dCn4eO8AMGy5x3O638gPoBBkexIsyeDJuqP+rTKDhYLjTXE72TFMtia76hMhzVa58Ao+0kElx0Xg/DQFNE45Jp4OIoeUHygJHAwVvsOasQkMt7ATu4Qp3AjC6NLw7pgmRlbFPHcYByWH3V4DITU64SAKsXFJj8L8vMweX+oleSJQPR/ANfAJ9+CPtrquKudrkhIlTzJIne+TsO2hLjbH2aal1HpiHBCdLIcYuyVUwHlhv0Ktfni0nBdGbz/DQzLBUkgn+Pn5POMkuW3baKc7PswV+7t6Dg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(478600001)(71200400001)(5660300002)(7416002)(41300700001)(52536014)(6916009)(8936002)(54906003)(316002)(66446008)(64756008)(4326008)(66556008)(66476007)(66946007)(38070700005)(55016003)(86362001)(8676002)(76116006)(83380400001)(7696005)(6506007)(38100700002)(9686003)(26005)(186003)(33656002)(2906002)(122000001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9203
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 346f9fca-35f1-439e-4250-08da867e18a7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykhoBeyK4rGtNmNdibfZPjO7MERmL7Z2GYKChk2b6Nkb+fBhwxOkeyuqvTc5en+ukHFpbzY0sbZIZaOw76YcgT/DowVkPGaecQGF9Gci2a7FhFUabOQfYD2uPlKOlMayflJmKyr07QvJS3gzBBml+fAgsS77SIFRc2VBYELM6sOMgPvBcPnZOGIiQ0CZekpjurKg1mfwrn3dS+qwXmBnXwW8zBdKLb9oXD8PYB7ag4gLGpbdCa8RSGO8kt9Ho1604zHH8A8Se53rQh6b3STgZnNRmGOuZnWuTXz0arEJB64kv+UhAt77KrzhC43Oxgbb5WQBWe6EngZedE9ZhKNFlEN+2YOkKQba0AHwOIdVSBZlkXZQ5jQ9JQtfrVr5y9HgpvDboJSYk4ORByDQreb/btH6p4DeV+3aaSZKbdWl+SaTdhl5AVUdnVq+qtTg4qqzaW0WsOn4IAIBKCVXyv0w4CeimuxVzKhiMWHs9kRj8UaQhxc1v7veFrzB+c26fMS3Qe5Eg41r4hfpraliD7cqK2DHWyaioD0IQ29KpqBGWzzZ0N2rJHBAUIzRbb0Qi+LawJZN90Ygl9UXAaic+4DyirOl95O2a8pTQ7B/Ovt25jLatTCGywSkY67Qd3dPWu4yNVbpInlXyVF32gLj3B5k8s5KCKV+3eLaHJZdVdjja0TyfwTkbgl9N9L1jA2H020qhmCP4scP0yDJ0UKnMqWRaNfBfVk5A0MuDRbDegecATWDCkb5Lz59kkn+RZGU5zwQ+41nPDbIdJ/aVU2WD+Sp1Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(8676002)(70586007)(33656002)(8936002)(6506007)(450100002)(4326008)(336012)(36860700001)(52536014)(186003)(47076005)(6862004)(316002)(2906002)(5660300002)(54906003)(81166007)(40480700001)(41300700001)(55016003)(26005)(9686003)(86362001)(82310400005)(356005)(70206006)(7696005)(83380400001)(82740400003)(40460700003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 09:42:51.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd7031-7393-4acf-52f5-08da867e2dd7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8492
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NClsuLi5dDQo+ID4gK3N0YXRpYyBpbnQg
X19pbml0IHNldHVwX2doZXNfZWRhY19sb2FkKGNoYXIgKnN0cikgew0KPiA+ICsJaWYgKHN0cikN
Cj4gPiArCQlpZiAoIXN0cmNtcCgidHJ1ZSIsIHN0cikgfHwgIXN0cmNtcCgiMSIsIHN0cikpDQo+
ID4gKwkJCWdoZXNfZWRhY19mb3JjZSA9IHRydWU7DQo+ID4gKw0KPiA+ICsJaWYgKCFJU19FTkFC
TEVEKENPTkZJR19YODYpKQ0KPiA+ICsJCWdoZXNfZWRhY19mb3JjZSA9IHRydWU7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIDE7DQo+ID4gK30NCj4gPiArX19zZXR1cCgiZ2hlc19lZGFjX2ZvcmNlPSIs
IHNldHVwX2doZXNfZWRhY19sb2FkKTsNCj4gDQo+IFdoeSBhbGwgdGhhdD8NCj4gDQo+IElzbid0
IHNwZWNpZnlpbmcNCj4gDQo+IGdoZXMuZWRhY19mb3JjZV9sb2FkDQoNCk9rLCBJIHdpbGwgdXNl
IG1vZHVsZSBwYXJhbWV0ZXIgZ2hlcy5lZGFjX2ZvcmNlX2xvYWQuDQo+IA0KPiBvbiB0aGUga2Vy
bmVsIGNvbW1hbmQgbGluZSBlbm91Z2g/IEkuZS4sIHlvdSBkb24ndCBuZWVkIHRvIHBhcnNlIHRo
ZSBwYXNzZWQNCj4gaW4gb3B0aW9uIC0ganVzdCB0aGUgcHJlc2VuY2Ugb2YgdGhlIHBhcmFtZXRl
ciBpcyBlbm91Z2guDQo+IA0KPiA+ICsNCj4gPiAgc3RhdGljIEFUT01JQ19OT1RJRklFUl9IRUFE
KGdoZXNfcmVwb3J0X2NoYWluKTsNCj4gPg0KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgaXNfaGVz
dF90eXBlX2dlbmVyaWNfdjIoc3RydWN0IGdoZXMgKmdoZXMpIEBADQo+ID4gLTE1MTcsMTMgKzE1
MzcsMTMgQEAgc3RhdGljIHN0cnVjdCBhY3BpX3BsYXRmb3JtX2xpc3QgcGxhdF9saXN0W10gPSB7
DQo+ID4gIAl7IH0gLyogRW5kICovDQo+ID4gIH07DQo+ID4NCj4gPiAtc3RydWN0IGxpc3RfaGVh
ZCAqZ2hlc19nZXRfZGV2aWNlcyhib29sIGZvcmNlKQ0KPiA+ICtzdHJ1Y3QgbGlzdF9oZWFkICpn
aGVzX2dldF9kZXZpY2VzKHZvaWQpDQo+ID4gIHsNCj4gPiAgCWludCBpZHggPSAtMTsNCj4gPg0K
PiA+ICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4NikpIHsNCj4gPiAgCQlpZHggPSBhY3BpX21h
dGNoX3BsYXRmb3JtX2xpc3QocGxhdF9saXN0KTsNCj4gPiAtCQlpZiAoaWR4IDwgMCAmJiAhZm9y
Y2UpDQo+ID4gKwkJaWYgKGlkeCA8IDAgJiYgIWdoZXNfZWRhY19mb3JjZSkNCj4gPiAgCQkJcmV0
dXJuIE5VTEw7DQo+ID4gIAl9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jIGluZGV4DQo+ID4gYmIzZWE0MmJh
NzBiLi42YTJiNTRjYzcyNDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRh
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQo+ID4gQEAgLTU0LDEwICs1
NCw2IEBAIHN0YXRpYyBERUZJTkVfTVVURVgoZ2hlc19yZWdfbXV0ZXgpOw0KPiA+ICAgKi8NCj4g
PiAgc3RhdGljIERFRklORV9TUElOTE9DSyhnaGVzX2xvY2spOw0KPiA+DQo+ID4gLS8qICJnaGVz
X2VkYWMuZm9yY2VfbG9hZD0xIiBza2lwcyB0aGUgcGxhdGZvcm0gY2hlY2sgKi8gLXN0YXRpYyBi
b29sDQo+ID4gX19yZWFkX21vc3RseSBmb3JjZV9sb2FkOyAtbW9kdWxlX3BhcmFtKGZvcmNlX2xv
YWQsIGJvb2wsIDApOw0KPiA+IC0NCj4gPiAgc3RhdGljIGJvb2wgc3lzdGVtX3NjYW5uZWQ7DQo+
ID4NCj4gPiAgc3RhdGljIHN0cnVjdCBsaXN0X2hlYWQgKmdoZXNfZGV2czsNCj4gPiBAQCAtNDM3
LDIzICs0MzMsMTIgQEAgc3RhdGljIGludCBnaGVzX2VkYWNfcmVnaXN0ZXIoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiA+ICAJbWNpLT5jdGxfbmFtZSA9ICJnaGVzX2VkYWMiOw0KPiA+ICAJbWNpLT5k
ZXZfbmFtZSA9ICJnaGVzIjsNCj4gPg0KPiA+IC0JaWYgKGZha2UpIHsNCj4gPiAtCQlwcl9pbmZv
KCJUaGlzIHN5c3RlbSBoYXMgYSB2ZXJ5IGNyYXBweSBCSU9TOiBJdCBkb2Vzbid0IGV2ZW4gbGlz
dCB0aGUNCj4gRElNTVMuXG4iKTsNCj4gPiAtCQlwcl9pbmZvKCJJdHMgU01CSU9TIGluZm8gaXMg
d3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQgdGhlIGVycm9yIHJlcG9ydA0KPiB3b3VsZFxuIik7
DQo+ID4gLQkJcHJfaW5mbygid29yayBvbiBzdWNoIHN5c3RlbS4gVXNlIHRoaXMgZHJpdmVyIHdp
dGggY2F1dGlvblxuIik7DQo+ID4gLQl9IGVsc2UgaWYgKGZvcmNlX2xvYWQpIHsNCj4gPiAtCQlw
cl9pbmZvKCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBtZW1v
cnkgYW5kDQo+IGdldCBlcnJvciByZXBvcnRzLlxuIik7DQo+ID4gLQkJcHJfaW5mbygiVW5mb3J0
dW5hdGVseSwgbm90IGFsbCBCSU9TZXMgcmVmbGVjdCB0aGUgbWVtb3J5IGxheW91dA0KPiBjb3Jy
ZWN0bHkuXG4iKTsNCj4gPiAtCQlwcl9pbmZvKCJTbywgdGhlIGVuZCByZXN1bHQgb2YgdXNpbmcg
dGhpcyBkcml2ZXIgdmFyaWVzIGZyb20gdmVuZG9yIHRvDQo+IHZlbmRvci5cbiIpOw0KPiA+IC0J
CXByX2luZm8oIklmIHlvdSBmaW5kIGluY29ycmVjdCByZXBvcnRzLCBwbGVhc2UgY29udGFjdCB5
b3VyIGhhcmR3YXJlDQo+IHZlbmRvclxuIik7DQo+ID4gLQkJcHJfaW5mbygidG8gY29ycmVjdCBp
dHMgQklPUy5cbiIpOw0KPiA+IC0JCXByX2luZm8oIlRoaXMgc3lzdGVtIGhhcyAlZCBESU1NIHNv
Y2tldHMuXG4iLA0KPiBnaGVzX2h3Lm51bV9kaW1tcyk7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+ICAJ
aWYgKCFmYWtlKSB7DQo+ID4gIAkJc3RydWN0IGRpbW1faW5mbyAqc3JjLCAqZHN0Ow0KPiA+ICAJ
CWludCBpID0gMDsNCj4gPg0KPiA+ICsJCXByX2luZm8oIlRoaXMgc3lzdGVtIGhhcyAlZCBESU1N
IHNvY2tldHMuXG4iLA0KPiBnaGVzX2h3Lm51bV9kaW1tcyk7DQo+ID4gKw0KPiA+ICAJCW1jaV9m
b3JfZWFjaF9kaW1tKG1jaSwgZHN0KSB7DQo+ID4gIAkJCXNyYyA9ICZnaGVzX2h3LmRpbW1zW2ld
Ow0KPiA+DQo+IA0KPiBUaGlzIGh1bmsuLi4NCg0KU29ycnksIHNob3VsZCBtb3ZlIHByX2luZm8g
YWZ0ZXIgdGhpcyBsaW5lDQoNCj4gDQo+ID4gQEAgLTQ3OCw2ICs0NjMsMTcgQEAgc3RhdGljIGlu
dCBnaGVzX2VkYWNfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJfSBlbHNlIHsN
Cj4gPiAgCQlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tID0gZWRhY19nZXRfZGltbShtY2ksIDAsIDAs
IDApOw0KPiA+DQo+ID4gKwkJcHJfaW5mbygiVGhpcyBzeXN0ZW0gaGFzIGEgdmVyeSBjcmFwcHkg
QklPUzogSXQgZG9lc24ndCBldmVuIGxpc3QgdGhlDQo+IERJTU1TLlxuIik7DQo+ID4gKwkJcHJf
aW5mbygiSXRzIFNNQklPUyBpbmZvIGlzIHdyb25nLiBJdCBpcyBkb3VidGZ1bCB0aGF0IHRoZSBl
cnJvciByZXBvcnQNCj4gd291bGRcbiIpOw0KPiA+ICsJCXByX2luZm8oIndvcmsgb24gc3VjaCBz
eXN0ZW0uIFVzZSB0aGlzIGRyaXZlciB3aXRoIGNhdXRpb25cbiIpOw0KPiA+ICsNCj4gPiArCQlp
ZiAoZ2hlc19lZGFjX2ZvcmNlKSB7DQo+ID4gKwkJCXByX2luZm8oIlRoaXMgRURBQyBkcml2ZXIg
cmVsaWVzIG9uIEJJT1MgdG8gZW51bWVyYXRlIG1lbW9yeQ0KPiBhbmQgZ2V0XG4iKTsNCj4gPiAr
CQkJcHJfaW5mbygiZXJyb3IgcmVwb3J0cy4gVW5mb3J0dW5hdGVseSwgbm90IGFsbCBCSU9TZXMg
cmVmbGVjdA0KPiB0aGVcbiIpOw0KPiA+ICsJCQlwcl9pbmZvKCJtZW1vcnkgbGF5b3V0IGNvcnJl
Y3RseS4gSWYgeW91IGZpbmQgaW5jb3JyZWN0IHJlcG9ydHMsDQo+IHBsZWFzZVxuIik7DQo+ID4g
KwkJCXByX2luZm8oImNvbnRhY3QgeW91ciBoYXJkd2FyZSB2ZW5kb3IgZm9yIGl0cyBpbiBjb3Jy
ZWN0DQo+IEJJT1MuXG4iKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICAJCWRpbW0tPm5yX3BhZ2Vz
ID0gMTsNCj4gPiAgCQlkaW1tLT5ncmFpbiA9IDEyODsNCj4gPiAgCQlkaW1tLT5tdHlwZSA9IE1F
TV9VTktOT1dOOw0KPiANCj4gLi4uIGFuZCB0aGlzIGh1bmsgbG9vayB1bnJlbGF0ZWQgdG8gd2hh
dCB0aGlzIHBhdGNoIGlzIGRvaW5nLiBXaGF0IGFyZSB0aGV5IGZvcj8NCj4gDQpJIHRyaWVkIHRv
IGtlZXAgdGhlIHByZXZpb3VzIHNhbWUgbG9naWMuDQogaWYgKGZha2UpDQoJcHJpbnRfc29tZXRo
aW5nDQogLSAhZmFrZSAmJiBnaGVzIG5vdCBwcmVmZXJyZWQuDQoJcHJpbnRfb3RoZXJ0aGluZ3MN
Cg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQo=
