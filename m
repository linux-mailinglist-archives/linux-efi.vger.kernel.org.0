Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677605FEDB9
	for <lists+linux-efi@lfdr.de>; Fri, 14 Oct 2022 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJNMAy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Oct 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJNMAw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Oct 2022 08:00:52 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4042CDDC;
        Fri, 14 Oct 2022 05:00:46 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=SRGWTkDhpo4Z9r8OK9kytU2e8De3HOajzKBCbkm3Lzu4kJ7XmoMFkGqBj8Vp/HsyEmTVi8fVFMGUpBPfzwh5crZv/PFZqiWwB6+4q6yPuC/zIS32ZxhpkTQQa75dp6zmEpgpqTbcVHOx0YVePVMry7uN/EeYtLKLXgHC+J1MRxht60Lf+gHOkONmUwAxsI3QmPWVek9gocw/HBn7J883sHdxhsp3NNEiMCMkMXm/h8mSOIMyfz1oXnJWGqKLdexZvv0Tfi9SOBf+1aPz1xv57ZXwy0taf8f5jbNv2rPbw4NHmXf7Y5Wd9Kos/uA89qQf1N7PLrK+yNYOdvADcS7E9A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIM4upB95BuBr22UmYU2USHAxVsoLDnVvxHoEKQHQUk=;
 b=nS4r4NQijRB5RNy3fciDac9J0JbjU3S2n/avmp0lMbeWaa56FUT5JH9AXPyuQRglBNpYek6jWvP46a1WcMcAoMgZGU25oYXy2vzhQoYV+FGPX6zVIHqO5fRkZ/wyzEZ9En77kc0MoDzzVvae8cSAm9B8nUgN0GjRzFeQhgFPUOziJWkAQWtRWZgtHuLsmkwbBq1z8vo2CfOQnRm6++OzGd48KSLttdlwpF3BwutIT0KiUMvJjXqcYdsVdIJtYr54B6oMYt3GBr0hwxwisMvVLISQ5fAun7Tmf9u2nW+7Z+csmuBrxOD2ZL0ND+sIheZZclwW9lLwNDCrsivaYGS2/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIM4upB95BuBr22UmYU2USHAxVsoLDnVvxHoEKQHQUk=;
 b=QNXSibr2UpzyESsNzpYHqdfFdHtzLEKkiHFEjjuvmLlqlaAioD9QsXRilS/xr5ccnqnZw43fl6LpixYZDBBPpGKA6Uy1t2B8ykrOj/yJHaUb/fqrYBOnCSaNvi7kb/BtxpM/HnsvleyYnQJhRiv5K6GT4Gc8+0E4XZWLt5ADaxM=
Received: from AM6PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:20b:c0::14)
 by DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 12:00:40 +0000
Received: from AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::49) by AM6PR08CA0026.outlook.office365.com
 (2603:10a6:20b:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Fri, 14 Oct 2022 12:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT039.mail.protection.outlook.com (100.127.140.224) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 14 Oct 2022 12:00:40 +0000
Received: ("Tessian outbound f394866f3f2b:v130"); Fri, 14 Oct 2022 12:00:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f09da03ae2d042c7
X-CR-MTA-TID: 64aa7808
Received: from b4a78fd10d01.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01D4C8E3-B9BB-4ACE-B62A-9576F7E42E20.1;
        Fri, 14 Oct 2022 12:00:30 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b4a78fd10d01.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Oct 2022 12:00:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub8u9Z1aKyAd5idMwRk18LRoJGxYF8YsYY2hl3JC5y8hb2yOrmko4exHp0HLykf3/Uze07dcyJYjovD7G2tf5IfZry/+8DYD1SqgOkcRglkJeX9Aft+hEoiwsguRE7XWZe4u1i5f7Ap71yY/HoP8JPDCXaqNGb/zNcRBvsiR3j7wEYpjH341CQvakLpz6OU48qpNvURjZv9qwTLM/u9NpdrL+CxSUmPr5d3ekZD1g/RLHrS6zzeM09Li/9lqXfOxxArT1SSrlMtMCuSjp3OKTQpY6Va8cuuoDBhvHixWvqadsjbqN5E7b8h7hzR4yQVbqeBv+XMAFnmmT2xm88eitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIM4upB95BuBr22UmYU2USHAxVsoLDnVvxHoEKQHQUk=;
 b=ZI/MNOj7DqJr/DVgBpHGyO4iLK4ygUzLEI16dorjhTpV7aaH00ozjF2oyof0Ast1iKs2GhU9wJ+GgNRM82Anl1ui6NvTBt8l2DkZYqYqkTSF29MflkfSgCZzPkTP+vnCNXYOUi8bfv/yUXZo1LpJOCFpwJULrM1ASfXSzUEMExgd0rsTIJ99q8/Bj6kdjcGLjYLyE8NxafSCEAKDmChu5RX5gC/w2UmqqjwxKA2+w7JKi8DsM6j4qLsZA8ZMEA/kkExH/LRSkcB1WM6kYf3JqTXuDb9u/+V2uRv26BWAkXvENZLzxtGoxWsygPlVfvaOE0kGDrOvnK9CY4jOhiEFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIM4upB95BuBr22UmYU2USHAxVsoLDnVvxHoEKQHQUk=;
 b=QNXSibr2UpzyESsNzpYHqdfFdHtzLEKkiHFEjjuvmLlqlaAioD9QsXRilS/xr5ccnqnZw43fl6LpixYZDBBPpGKA6Uy1t2B8ykrOj/yJHaUb/fqrYBOnCSaNvi7kb/BtxpM/HnsvleyYnQJhRiv5K6GT4Gc8+0E4XZWLt5ADaxM=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AM7PR08MB5318.eurprd08.prod.outlook.com (2603:10a6:20b:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 12:00:26 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 12:00:26 +0000
From:   Justin He <Justin.He@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
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
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/CAAAkTAIABZGGQgAGtTgCAACJ6AIAA7qyg
Date:   Fri, 14 Oct 2022 12:00:25 +0000
Message-ID: <DBBPR08MB453845A7A15596F6FE96DBC9F7249@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com> <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
 <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0gUpoaUBKw/jjaD@zn.tnic>
 <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
In-Reply-To: <CAMj1kXGtTRaKCKJnsJ9XcRus+H16mO3TGsz+TFJLraOyvfciCA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AM7PR08MB5318:EE_|AM7EUR03FT039:EE_|DB9PR08MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: f6676536-56f0-44a9-39f1-08daaddbb6c1
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MULavkqSpthOeTj7mHw+3Drdpc88LNljkNBDL8t4LOwxfLxehhh4/09oOQoF1clzPKQ4ztcjxEqyXQK6IPNEuYQSaJSaeYAEoBsG4pRmkFL/lSvxYS8ElgpLZ+KVZMJiUKxzGtn1p9eZyfqWbSMjIB5rzlxZNcoz42eRnZaP/D1nAR89Hf248IjCVIKqfYhbBU0R2wqYhPIpuUQLUh7bTWmOPTgaHalXnoL3R+42GKrssuchtq8J8vAKrg/yRhvq7LYeQ+ZMp5w9Lx9f+PASMk1+R0Ae+kOkn7LKDOkOcYf6jON3y3kbGUVHineCJ2qrirgeV01v6XVyQAZwiaZuQjfpC9YjmtTbOfkd597rp+okye/1uh3AOlAvrIujuYQHbXAcxMdngOdRBMcNfXnp1YHW7Jt5KS+D+FQxPp3EdUV7+e9/5+5JgnIlbCdCchOlgWI3UQIwyXtc8Vo0XL/GlYiCf6uCfPlTt3wwhTlMl4/FZiyL5Rg3Y9hDjJPCkeJA+qaQ22kMmjWifqSUD/Wc8jL0oHxTuoCJf74K+FMwn9XfDhfUrHCEXON34J6mX8dJJet9WDSDL7PzhkfZOH5ccuOJMeHJaPBVThsD55gCtSg+ZwLJF7n46xm9S3c3G/NgH1+FfrR2fWspW28EYEjr46M7PZ2ORl0A2Z62Zzq94U6QwENmPPiJGqhU17IDL/mx/q5EPOI0VX0nDBW5nNnrMigxP+Z1jbg5ORXusX2yIWBStYBF61VAYyJtwHAHK2Uaxl/ELyAX4q2AslR0BUW+0gGG3n656motMPvccnRVgXrkXeEmvqO1l/1jSPjzcJZ/
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(366004)(376002)(136003)(396003)(451199015)(33656002)(55016003)(53546011)(41300700001)(76116006)(26005)(7696005)(6506007)(9686003)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(66946007)(478600001)(38070700005)(38100700002)(86362001)(52536014)(7416002)(83380400001)(8936002)(186003)(5660300002)(110136005)(316002)(54906003)(122000001)(2906002)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5318
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6b6f5ffa-ca46-4727-8383-08daaddbae37
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTKK/0w6kWi6fXJmpi8mcXkv1i+MjHwLkfsnVLH0s3SS9tKf+q/fEiyMHGKZrDUnYwVG2BDdK1YON88MCE3IZaZ5Ph8JXzIl2PX3uCs4/RsqrAdyXI5s+dWsRdd6j4xyz7rtM5gu6LOeLxj+PdME9x8/QXTnb6mb518X8WKPkFNOeOXwpHiBaOEaBZJUejU7RfSgnK27HNEh8O6UP4gw3V9hSln1vM+V7nToiVnFax+fADaOy6D9TI7nDGAwbH3Fu4FmuXXxiCczRhztYVKfL6BSUvjUZHQ5EVk2tg1Zy1wrlTTJjOPmFaXRrMv3+QaYmvahS0R9Ckh9YqIXj3/38RRVwbUOU3nf6WgdZOAMCAXUI1k+3ynCSJZpsTz5A6eHYOescNjXynGn/4h3Fh4zvFByHPi0GkqTxQzyaGQDbIFfOczwLOEvewlBCAHL3WycHjSnzXk4oHA4GrSQmrQpp4GDvrVDEUJT1HSX/D87a4J0WXmEHmnyMmSwd3hYCtXojNk1Dijzc7trldx4e1jm8Ahdq/C9GyKYyg9G0UBXL7lSR7jFPq7SNr30SNPhAoLYcoNcy59bUbQG58SpxIQl4TfJZRwr4D9RFt2npWCUbUWFx2n6P5lN63njEG2Tf2CM6ia2hwTl0FWGPEAdnhgAnd2nRrzxKztTfUtl/x2pPV7KJyaAkiJTbNHaE/fTBFCS+jm0xOBYw8T6OoI7J0Nfy8UhOnzMtHTdwBL13/eqqHmPsbvwijRw1YxWuEBp4QQaUv7aXM3xXXEDg8njXMWoR8olc2Mm/oEC47xOXPPrZhPJeWiDFXa2Le6tSSfMjJgI
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(7696005)(336012)(47076005)(2906002)(356005)(6506007)(41300700001)(9686003)(8936002)(26005)(186003)(82310400005)(52536014)(40480700001)(53546011)(86362001)(40460700003)(55016003)(33656002)(36860700001)(82740400003)(83380400001)(478600001)(316002)(54906003)(110136005)(81166007)(70206006)(450100002)(4326008)(8676002)(70586007)(107886003)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:00:40.0343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6676536-56f0-44a9-39f1-08daaddbb6c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7584
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNo
ZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTMsIDIw
MjIgMTE6NDEgUE0NCj4gVG86IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDYzog
SnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3Jn
PjsgSmFtZXMNCj4gTW9yc2UgPEphbWVzLk1vcnNlQGFybS5jb20+OyBUb255IEx1Y2sgPHRvbnku
bHVja0BpbnRlbC5jb20+OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVs
Lm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+Ow0KPiBSb2JlcnQgTW9vcmUg
PHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBRaXV4dSBaaHVvDQo+IDxxaXV4dS56aHVvQGludGVs
LmNvbT47IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT47IEphbg0KPiBMdWVi
YmUgPGpsdUBwZW5ndXRyb25peC5kZT47IEtodW9uZyBEaW5oDQo+IDxraHVvbmdAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbT47IEthbmkgVG9zaGkgPHRvc2hpLmthbmlAaHBlLmNvbT47DQo+IGxpbnV4
LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsgUmFmYWVsIEogLiBX
eXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IFNodWFpIFh1ZSA8eHVlc2h1YWlAbGludXgu
YWxpYmFiYS5jb20+OyBKYXJra28NCj4gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsgbGlu
dXgtZWZpQHZnZXIua2VybmVsLm9yZzsgbmQgPG5kQGFybS5jb20+Ow0KPiBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCA2LzddIGFwZWkv
Z2hlczogVXNlIHVucmN1X3BvaW50ZXIgZm9yIGNtcHhjaGcNCj4gDQo+IE9uIFRodSwgMTMgT2N0
IDIwMjIgYXQgMTU6MzcsIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToNCj4g
Pg0KPiA+IE9uIFdlZCwgT2N0IDEyLCAyMDIyIGF0IDEyOjA0OjU3UE0gKzAwMDAsIEp1c3RpbiBI
ZSB3cm90ZToNCj4gPiA+IEkgaGF2ZSBhIGNvbmNlcm4gYWJvdXQgd2hhdCBpZiBjbXB4Y2hnIGZh
aWxlZD8gRG8gd2UgaGF2ZSB0byBzdGlsbA0KPiA+ID4gZ3VhcmFudGVlIHRoZSBvcmRlcmluZyBz
aW5jZSBjbXB4Y2hnIHdpbGwgbm90IGltcGx5IGEgc21wX21iIGlmIGl0DQo+ID4gPiBmYWlsZWQu
DQo+ID4NCj4gPiBPZiBjb3Vyc2UgaXQgd2lsbCBpbXBseSB0aGF0LiBBdCBsZWFzdCBvbiB4ODYg
aXQgZG9lcy4gc21wX3dtYigpIGlzIGENCj4gPiBjb21waWxlciBiYXJyaWVyIHRoZXJlIGFuZCBj
bXB4Y2hnKCkgYWxyZWFkeSBoYXMgdGhhdCBiYXJyaWVyDQo+ID4gc2VtYW50aWNzIGJ5IGNsb2Ji
ZXJpbmcgIm1lbW9yeSIuIEknbSBwcmV0dHkgc3VyZSB5b3Ugc2hvdWxkIGhhdmUgdGhlDQo+ID4g
c2FtZSB0aGluZyBvbiBBUk0uDQo+ID4NCj4gDQo+IE5vIGl0IGRlZmluaXRlbHkgZG9lcyBub3Qg
aW1wbHkgdGhhdC4gQSBtZW1vcnkgY2xvYmJlciBpcyBhIGNvZGVnZW4gY29uc3RydWN0LA0KPiBh
bmQgdGhlIGhhcmR3YXJlIGNvdWxkIHN0aWxsIGNvbXBsZXRlIHRoZSB3cml0ZXMgaW4gYSB3YXkg
dGhhdCBjb3VsZCByZXN1bHQgaW4NCj4gYW5vdGhlciBvYnNlcnZlciBzZWVpbmcgYSBtaXggb2Yg
b2xkIGFuZCBuZXcgdmFsdWVzIHRoYXQgaXMgaW5jb25zaXN0ZW50IHdpdGgNCj4gdGhlIG9yZGVy
aW5nIG9mIHRoZSBzdG9yZXMgYXMgaXNzdWVkIGJ5IHRoZSBjb21waWxlci4NCj4gDQo+ID4gc2F5
cywgIm5ld19jYWNoZSBtdXN0IGJlIHB1dCBpbnRvIGFycmF5IGFmdGVyIGl0cyBjb250ZW50cyBh
cmUgd3JpdHRlbiIuDQo+ID4NCj4gPiBBcmUgd2Ugd3JpdGluZyBhbnl0aGluZyBpbnRvIHRoZSBj
YWNoZSBpZiBjbXB4Y2hnIGZhaWxzPw0KPiA+DQo+IA0KPiBUaGUgY2FjaGUgZmllbGRzIGdldCB1
cGRhdGVkIGJ1dCB0aGUgcG9pbnRlciB0byB0aGUgc3RydWN0IGlzIG5ldmVyIHNoYXJlZA0KPiBn
bG9iYWxseSBpZiB0aGUgY21weGNoZygpIGZhaWxzIHNvIG5vdCBoYXZpbmcgdGhlIGJhcnJpZXIg
b24gZmFpbHVyZSBzaG91bGQgbm90IGJlDQo+IGFuIGlzc3VlIGhlcmUuDQo+IA0KPiA+ID4gQmVz
aWRlcywgSSBkaWRuJ3QgZmluZCB0aGUgcGFpcmVkIHNtcF9tYiBvciBzbXBfcm1iIGZvciB0aGlz
IHNtcF93bWIuDQo+ID4NCj4gPiBXaHkgd291bGQgdGhlcmUgYmUgcGFpcnM/IEkgZG9uJ3QgdW5k
ZXJzdGFuZCB0aGF0IHN0YXRlbWVudCBoZXJlLg0KPiA+DQo+IA0KPiBUeXBpY2FsbHksIHRoZSBv
dGhlciBvYnNlcnZlciBwYWlycyB0aGUgd3JpdGUgYmFycmllciB3aXRoIGEgcmVhZCBiYXJyaWVy
Lg0KPiANCj4gSW4gdGhpcyBjYXNlLCB0aGUgb3RoZXIgb2JzZXJ2ZXIgYXBwZWFycyB0byBiZSBn
aGVzX2VzdGF0dXNfY2FjaGVkKCksIGFuZCB0aGUNCj4gcmVhZHMgb2YgdGhlIGNhY2hlIHN0cnVj
dCBmaWVsZHMgbXVzdCBiZSBvcmRlcmVkIGFmdGVyIHRoZSByZWFkIG9mIHRoZSBjYWNoZQ0KPiBz
dHJ1Y3QncyBhZGRyZXNzLiBIb3dldmVyLCB0aGVyZSBpcyBhbiBpbXBsaWNpdCBvcmRlcmluZyB0
aGVyZSB0aHJvdWdoIGFuIGFkZHJlc3MNCj4gZGVwZW5kZW5jeSAoeW91IGNhbm5vdCBkZXJlZmVy
ZW5jZSBhIHN0cnVjdCB3aXRob3V0IGtub3dpbmcgaXRzIGFkZHJlc3MpIHNvDQo+IHRoZSBvcmRl
cmluZyBpcyBpbXBsaWVkIChhbmQNCj4gcmN1X2RlcmVmZXJlbmNlKCkgaGFzIGEgUkVBRF9PTkNF
KCkgaW5zaWRlIHNvIHdlIGFyZSBndWFyYW50ZWVkIHRvIGFsd2F5cw0KPiBkZXJlZmVyZW5jZSB0
aGUgc2FtZSBzdHJ1Y3QsIGV2ZW4gaWYgdGhlIGFycmF5IHNsb3QgZ2V0cyB1cGRhdGVkIGNvbmN1
cnJlbnRseS4pDQo+IA0KPiBJZiB5b3Ugd2FudCB0byBnZXQgcmlkIG9mIHRoZSBiYXJyaWVyLCB5
b3UgY291bGQgZHJvcCBpdCBhbmQgY2hhbmdlIHRoZSBjbXB4Y2hnKCkNCj4gdG8gY21weGNoZ19y
ZWxlYXNlKCkuDQo+IA0KPiBKdXN0aW46IHNvIHdoeSBhcmUgdGhlIFJDVV9JTklUSUFMSVpFUigp
cyBuZWVkZWQgaGVyZT8NCg0KSW4gbXkgdGhpcyBwYXRjaCwgSSBhZGQgdGhlICJfX3JjdSIgdG8g
dGhlIGRlZmluaXRpb24gb2YgZ2hlc19lc3RhdHVzX2NhY2hlcy4gSGVuY2UNClNwYXJzZSB3aWxs
IHN0aWxsIGhhdmUgdGhlIHdhcm5pbmcgb24gWDg2IHdpdGggdGhpcyBSQ1VfSU5JVElBTElaRVIg
Y2FzdC4NCmRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo4NDM6Mjc6IHNwYXJzZTogd2FybmluZzog
aW5jb3JyZWN0IHR5cGUgaW4gaW5pdGlhbGl6ZXIgKGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcykN
CmRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo4NDM6Mjc6IHNwYXJzZTogICAgZXhwZWN0ZWQgc3Ry
dWN0IGdoZXNfZXN0YXR1c19jYWNoZSBbbm9kZXJlZl0gX19yY3UgKl9fb2xkDQpkcml2ZXJzL2Fj
cGkvYXBlaS9naGVzLmM6ODQzOjI3OiBzcGFyc2U6ICAgIGdvdCBzdHJ1Y3QgZ2hlc19lc3RhdHVz
X2NhY2hlICpbYXNzaWduZWRdIHNsb3RfY2FjaGUNCmRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo4
NDM6Mjc6IHNwYXJzZTogd2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gaW5pdGlhbGl6ZXIgKGRp
ZmZlcmVudCBhZGRyZXNzIHNwYWNlcykNCmRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo4NDM6Mjc6
IHNwYXJzZTogICAgZXhwZWN0ZWQgc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSBbbm9kZXJlZl0g
X19yY3UgKl9fbmV3DQpkcml2ZXJzL2FjcGkvYXBlaS9naGVzLmM6ODQzOjI3OiBzcGFyc2U6ICAg
IGdvdCBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICpbYXNzaWduZWRdIG5ld19jYWNoZQ0KDQpP
biBBcm0sIElNTyB0aGUgbWFjcm8gY21weGNoZyBkb2Vzbid0IGNhcmUgYWJvdXQgaXQsIHRoYXQg
aXMsIHNwYXJzZSB3aWxsIG5vdCByZXBvcnQgd2FybmluZ3Mgd2l0aCBvcg0Kd2l0aG91dCBSQ1Vf
SU5JVElBTElaRVIgY2FzdC4NCg0KSSB0ZW5kIHRvIHJlbWFpbiB0aGlzIGNhc3QsIHdoYXQgZG8g
eW91IHRoaW5rIG9mIGl0Lg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
