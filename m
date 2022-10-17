Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5D60090A
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJQIrh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQIrg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 04:47:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DB411172;
        Mon, 17 Oct 2022 01:47:34 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=kO2Q3A66KgqsdjNpAMDumdm7rlYWy+V7QVE528yvSIGG75VkXbHj/b2j6h85IJfBswpcyjIMA7Z4cWFreqJ1aWH5w8dmJqEIf8FWw4Yei9QM/j5Fa1gPIn6sq8GxFGwhU0vty20M7bfKHrFYHWR6jtk9NPfQCheW3xrZEBJVEdXMPCSr6X7y6iPdr6ENuSo2i43ujkbGnd/Pge3ER1kV5zXcMC4nTk+wgAGWf4VJ4ucai6syDMnPUC2pCQcqz/QOAv77pek810wEQhVMiPkxxalKuK9gT/bAQ742Gdvwh55+0YGznlJvGaGOlSiLv9f+QLMODbss5NebHg4zLIRktw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9LQJDHh1pj7b6zUTnXGy5fr15aZcaPQuAMacWqSizc=;
 b=QzQl2C/ELtWqHVTuUkiEaBk8vtFlDamqnWiziFj7H80UHinPlnAdHbbcZbIAyApaaagJT0D/XpOs1RS5hZ/Ijl24p2b2gDMvdO3XTP9ZOQBsHdEK/Jl3P9sz1frl0CRtVBNzX9VZA8gWKeSF0pTmSYEOt+r83pPH/yEAC+uGwi1isci+Z1rSlBXBpq8TW3jqu/NaVx9PmWrjRTNipgnTbC7jBJu2qWFvCullcHFcJTs5JoFeaJVwwCnYgO0uAYmeLlNS0ctfr9q95jHCd9+FmVszz73aUc9LP9XOJLMACfMScirinV+zc/KPhAW/eLP/a6jEUKxTq9zjrAXHYULP4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9LQJDHh1pj7b6zUTnXGy5fr15aZcaPQuAMacWqSizc=;
 b=YRHoZm5mh/6czpHbjZ6kbN/Lom0AIAe58yAM5y5p8Xc6zoK51w/po3gqd8osykc6ZusQ3IuLjHBPwob4SdAbhBCxCo4sg0QgCeciiVLSOBIclBTZrM+ZVh5UP2wJM+C0CpryBK+UWFv+wL+msK4eT57vKHieVESWlMz5XXDp7cI=
Received: from AS8PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:312::11)
 by AS2PR08MB9198.eurprd08.prod.outlook.com (2603:10a6:20b:579::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 08:47:31 +0000
Received: from VI1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::cd) by AS8PR04CA0036.outlook.office365.com
 (2603:10a6:20b:312::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Mon, 17 Oct 2022 08:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT010.mail.protection.outlook.com (100.127.144.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 08:47:31 +0000
Received: ("Tessian outbound aeae1c7b66fd:v130"); Mon, 17 Oct 2022 08:47:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 423504af6fd26507
X-CR-MTA-TID: 64aa7808
Received: from 5eb921e245dc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A16A522-891C-46C8-A58B-D16DE38B5C97.1;
        Mon, 17 Oct 2022 08:47:20 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5eb921e245dc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 17 Oct 2022 08:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG/KiOTofnQKudJSlQ3rrXNkRcq5OWPxjIzrfumSbwjtv4SDYl0dUzAvBqC/uUOaXK9tyEvHXx2V8BYLn/b6k9FuRx5mM7moLAE00Lp4y+CPbxlWevtDbJUas34Iq6pfV3cwkwe0nTfN52HmG2x0ko4TBopDYYh6VXNHK5d0BZdOWz5YOPMi4Jlwm4vtWhYP843z39bGQ25MpCeEuKKu962G9sPiE+gN98soWCbDA6YD2/TSk5H9d5aLnlU0jBDAdAqcW3YJEKLE0Z9jGg6B1WOfiFcPOvaOvvj7CWFke3OKJoXI7QPMW6SAJTQl3gxXpZ8UwK5BgIEGEprJvZKGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9LQJDHh1pj7b6zUTnXGy5fr15aZcaPQuAMacWqSizc=;
 b=RC0HYPQF0G5hYIal/mEzXPWP/5Fjm0pOYfs3k4TFxj2Fg/IFurOcCa0I0bOP7PtbftOGRgXx/bmkD8oWp3H69lW7WMEctCY6zEEoX6nCx83opdFlMRJxCc2iN4+XzGq2EzUOwTNxwErraN4ILJf69p53gWkqt6OR4sjk3W2q2XIDqxQgEmKqeXO6gUsV3Jqyd/ovM87P7KpNektN1Sq4CJhiWD1DarK0DXACIw2Bn5UCyboZAu2FN3lI00miI7hUpMRav6Ou11HQsLJBSewli/lfAoS1/LZ8nYPB+hkQVo/a4qaveiYYihQOEI89CIHOjDPFmkYk3xlc7b5YZNy0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9LQJDHh1pj7b6zUTnXGy5fr15aZcaPQuAMacWqSizc=;
 b=YRHoZm5mh/6czpHbjZ6kbN/Lom0AIAe58yAM5y5p8Xc6zoK51w/po3gqd8osykc6ZusQ3IuLjHBPwob4SdAbhBCxCo4sg0QgCeciiVLSOBIclBTZrM+ZVh5UP2wJM+C0CpryBK+UWFv+wL+msK4eT57vKHieVESWlMz5XXDp7cI=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAVPR08MB9697.eurprd08.prod.outlook.com (2603:10a6:102:31c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 08:47:17 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 08:47:16 +0000
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
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v8 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/CAAAkTAIABZGGQgAGtTgCAACJ6AIAA7qyggACQP4CAAAr+gIAAA6cAgARBVBA=
Date:   Mon, 17 Oct 2022 08:47:15 +0000
Message-ID: <DBBPR08MB4538066E9C43FCF2983C8B60F7299@DBBPR08MB4538.eurprd08.prod.outlook.com>
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
In-Reply-To: <CAMj1kXENTJVZU27PYqwWGod4ESkTxgJ8+2vdqWjR5DVRSbNGDg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAVPR08MB9697:EE_|VI1EUR03FT010:EE_|AS2PR08MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: c15cfe0d-f392-4f6e-b071-08dab01c3a98
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nyEpaGgh9SlkNtB6vc3eNPnQ3+D2fzaUgzylUU8I/xxBVl2QxeXnVGGNyY6Q9Gb1yiuRUqI+1ZLCGW3VfzIBtp3Hj25tF0D3rIKPhJIiHt9LEJrlz4J+MS/qQxGbD1cFf48rFMzAgNp6qfISSuBM8jk4dIsHwgvEX3zZCSQ2NeCqocHpqnYHKMACcv2eBVDWY3v6L/P4qm6QAlkYPu8rVwJ5O4L7TG301WsokhZLnPwq52MPW5uu4YHS26DhGKk+A3Zk8EFRGByYXp+xEP+vyVZ87VHH7rSvR3/jBkY213V521xFzxjuBkeGuE3iNhBJnmM5OylgMkouqDf1r56tFUdvJ9DOolOrfFcZ9zeEmbieugCm+qmQxfp4cbhYpUOnl3n38eCLYG/FscgQsEY4SpD0FlBhZkFXHHLcIgPkdhqd4VU5ZwMemYPP1J69Bv41XkESGgOM3rcpPrGoxEw8Flkup2cc5V3QpZvczvVwzfF1p3qziVzrrC97u5dYJfqtyKcyJsBkrHRbrJn/xcJTWCKUE+oxiIjy3GtmjOJkBEV7x3cD6rPv+Tfkw3TTi5dmutdscF8wMVvhg8ghQCS4Yta7Lr63W2zbx5h8ZirI82zUYleUQq6awC3TocUuyY/UEjEYzwZVIFKoYJVsMxN7nTIIKDgXmMudnihyfQnNiPVOwZ2gm3geu1B03RkjtIgvcFPymcKfFy7m2c88eVlDQFR2rW92x++fOE09NA4hsYrAhioA4TwO0cVOUob89IiSh/+vm4YIwm/zjqD6DrWQfX+N9ubTUGZBy9FMyNkiSur7BG90FE4gbyXYBwCbsI20
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(54906003)(6916009)(64756008)(66946007)(8676002)(66476007)(66446008)(76116006)(66556008)(316002)(6506007)(7696005)(41300700001)(4326008)(5660300002)(55016003)(26005)(9686003)(86362001)(52536014)(8936002)(7416002)(83380400001)(2906002)(38100700002)(186003)(33656002)(71200400001)(478600001)(38070700005)(122000001)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9697
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aabc6920-9f13-4d94-1feb-08dab01c30d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpJBpCkAGPN1aO81c8YsICHk1njJWl4oieYTyiC5aYsO0O9JTlSMVXWmI3egIPTx2cLSA4JmmE0x9iMlQ47Ezxcr58Dni90I7aD5Ri09C9t9dPAg9SfWlv+miuI8BSeh2AjAtp6bBNxq4HxZLN5LhUyRl7tI25b+hHM8qtqzmAMemuPCZVhWDsBvMkHPq6qF79DlL+1GimYfLJZc/7eF4oDMD+OPFmbY0b471GvQS824c4tst0t3HwpP6CTgnpypurJmexeajwd48JtEuPkoHAQ0BhtWaurqkvMfw31/7YS6519wvCPG7RzxuqlaX16pwi3IFBjiHADABx0tzSDUmyEU4GgDF/4GpJNnN3UB59qQeNwNmngq5gD2cjNXo1srIRNI2Jb53NgYaKiU11jTMVM7cQCfdrBRwHOR0CbW8sRCvvU65C9/Fqh2CZWecIBa4Bkc5d59oFHLGVKWVbK3tZd+NxdJ5VCYhjxGPkbuGWUmPp1YIgsPaOGxN4hw4MD7BTGrUPIxVplPWrsl4k4HNxkG186M4BVVKboA5VwTP13/FQB7/7yIullXIY2wrXRq3LdvvCcsLkKJ7q3QkcWcJq0ojvffmqmQFpFirsgHBrqOE5HwiMd7vyH2ABjYHajfSt41tEP1tTCO6Mcta545J2NqP1Z5jWPzLwt6dWOuSQFao9McDtRZ6UubpUvEsMocBU5QFOe0i3o4xzLlpPJjSNTJU5JahHN7fagA1wY+1uwMCRQ8Y6ELDL+s2+7E7DInsfxo/zwAwcC/4U0NgxA2WA562/JeLArW7On/x9htQzBsdpXDjotrKOuwg5od3sE3
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(81166007)(478600001)(356005)(82740400003)(82310400005)(40460700003)(186003)(33656002)(316002)(8676002)(4326008)(54906003)(107886003)(70586007)(450100002)(70206006)(6506007)(5660300002)(7696005)(36860700001)(26005)(41300700001)(52536014)(6862004)(8936002)(55016003)(86362001)(40480700001)(9686003)(2906002)(47076005)(83380400001)(336012)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:47:31.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15cfe0d-f392-4f6e-b071-08dab01c3a98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9198
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OCA2LzddIGFwZWkvZ2hlczogVXNlIHVucmN1X3BvaW50ZXIgZm9yIGNtcHhjaGcNCj4N
Cj4gT24gRnJpLCAxNCBPY3QgMjAyMiBhdCAxNzoxMSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgT2N0IDE0LCAyMDIyIGF0IDA0
OjMxOjM3UE0gKzAyMDAsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPiA+ID4gKyAgICAgICBpZiAo
c2xvdCAhPSAtMSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gPiArICAgICAgICAg
ICAgICAgICogVXNlIHJlbGVhc2Ugc2VtYW50aWNzIHRvIGVuc3VyZSB0aGF0DQo+IGdoZXNfZXN0
YXR1c19jYWNoZWQoKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAqIHJ1bm5pbmcgb24gYW5vdGhl
ciBDUFUgd2lsbCBzZWUgdGhlIHVwZGF0ZWQgY2FjaGUNCj4gZmllbGRzIGlmDQo+ID4gPiArICAg
ICAgICAgICAgICAgICogaXQgY2FuIHNlZSB0aGUgbmV3IHZhbHVlIG9mIHRoZSBwb2ludGVyLg0K
PiA+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgIHZpY3RpbSA9
IHhjaGdfcmVsZWFzZShnaGVzX2VzdGF0dXNfY2FjaGVzICsgc2xvdCwNCj4gPiA+ICsNCj4gUkNV
X0lOSVRJQUxJWkVSKG5ld19jYWNoZSkpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAg
IC8qDQo+ID4gPiArICAgICAgICAgICAgICAgICogQXQgdGhpcyBwb2ludCwgdmljdGltIG1heSBw
b2ludCB0byBhIGNhY2hlZCBpdGVtDQo+IGRpZmZlcmVudA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAqIGZyb20gdGhlIG9uZSBiYXNlZCBvbiB3aGljaCB3ZSBzZWxlY3RlZCB0aGUgc2xvdC4NCj4g
SW5zdGVhZCBvZg0KPiA+ID4gKyAgICAgICAgICAgICAgICAqIGdvaW5nIHRvIHRoZSBsb29wIGFn
YWluIHRvIHBpY2sgYW5vdGhlciBzbG90LCBsZXQncw0KPiBqdXN0DQo+ID4gPiArICAgICAgICAg
ICAgICAgICogZHJvcCB0aGUgb3RoZXIgaXRlbSBhbnl3YXk6IHRoaXMgbWF5IGNhdXNlIGEgZmFs
c2UNCj4gY2FjaGUNCj4gPiA+ICsgICAgICAgICAgICAgICAgKiBtaXNzIGxhdGVyIG9uLCBidXQg
dGhhdCB3b24ndCBjYXVzZSBhbnkgcHJvYmxlbXMuDQo+ID4gPiArICAgICAgICAgICAgICAgICov
DQo+ID4gPiArICAgICAgICAgICAgICAgaWYgKHZpY3RpbSkgew0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY2FsbF9yY3UoJnJjdV9kZXJlZmVyZW5jZSh2aWN0aW0pLT5yY3UsDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnaGVzX2VzdGF0dXNfY2FjaGVfcmN1
X2ZyZWUpOw0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBjYW4g
dXNlIHVucmN1X3BvaW50ZXIoKSBoZXJlIGluc3RlYWQsIHRoZXJlIHNob3VsZCBub3QgYmUNCj4g
PiBhIGRhdGEgZGVwZW5kZW5jeSBzaW5jZSB0aGUgLT5yY3UgbWVtYmVyIGl0c2VsZiBzaG91bGQg
YmUgb3RoZXJ3aXNlDQo+ID4gdW51c2VkIChhbmQgaWYgaXQgd2VyZSwgd2Ugd291bGRuJ3QgY2Fy
ZSBhYm91dCBpdHMgcHJldmlvdXMgY29udGVudCBhbnl3YXkpLg0KPiA+DQo+ID4gQnV0IG9ubHkg
QWxwaGEgY2FyZXMgYWJvdXQgdGhhdCBkaXN0aW5jdGlvbiBhbnl3YXksIHNvICpzaHJ1ZyouDQo+
ID4NCj4NCj4gQWggeWVhaCBnb29kIHBvaW50IC0gYW5kIHdlIGFyZSBub3QgYWN0dWFsbHkgZGVy
ZWZlcmVuY2luZyB0aGUgcG9pbnRlciBhdCBhbGwNCj4gaGVyZSwganVzdCBhZGRpbmcgYW4gb2Zm
c2V0IHRvIGdldCBhdCB0aGUgYWRkcmVzcyBvZiB0aGUgcmN1IG1lbWJlci4NCj4NCj4gU28gd2Ug
Y2FuIHRha2UgdGhpcyBibG9jayBvdXQgb2YgdGhlIHJjdV9yZWFkX2xvY2soKSBzZWN0aW9uIGFz
IHdlbGwuDQo+DQo+DQo+ID4gV2hpbGUgSSBtdWNoIGxpa2UgdGhlIHhjaGcoKSB2YXJpYW50OyBJ
IHN0aWxsIGRvbid0IHJlYWxseSBmYW5jeSB0aGUNCj4gPiB2ZXJiYWdlIHRoZSBzcGFyc2Ugbm9u
c2Vuc2UgbWFrZXMgdXMgZG8uDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgdmljdGltID0geGNo
Z19yZWxlYXNlKCZnaGVzX2VzdGF0dXNfY2FjaGVzW3Nsb3RdLA0KPiBuZXdfY2FjaGUpOw0KPiA+
ICAgICAgICAgICAgICAgICBpZiAodmljdGltKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNhbGxfcmN1KCZ2aWN0aW0tPnJjdSwNCj4gPiBnaGVzX2VzdGF0dXNfY2FjaGVfcmN1X2ZyZWUp
Ow0KPiA+DQo+ID4gaXMgbXVjaCBuaWNlciBjb2RlLg0KPiA+DQo+ID4gT3ZlciBhbGw7IEknZCBz
aW1wbHkgaWdub3JlIHNwYXJzZSAoSSBvZnRlbiBkbykuDQo+ID4NCj4NCj4gTm8gZGlzYWdyZWVt
ZW50IHRoZXJlLg0KDQpXaGF0IGRvIHlvdSB0aGluayBvZiB0aGUgdXBkYXRlZCBwYXRjaDoNCg0K
YXBlaS9naGVzOiBVc2UgeGNoZygpIGZvciB1cGRhdGluZyBuZXcgY2FjaGUgc2xvdCBpbnN0ZWFk
IG9mDQogY21weGNoZygpDQoNCkZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+
DQoNCmdoZXNfZXN0YXR1c19jYWNoZV9hZGQoKSBzZWxlY3RzIGEgc2xvdCwgYW5kIGVpdGhlciBz
dWNjZWVkcyBpbg0KcmVwbGFjaW5nIGl0cyBjb250ZW50cyB3aXRoIGEgcG9pbnRlciB0byBhIG5l
dyBjYWNoZWQgaXRlbSwgb3IgaXQganVzdA0KZ2l2ZXMgdXAgYW5kIGZyZWVzIHRoZSBuZXcgaXRl
bSBhZ2Fpbiwgd2l0aG91dCBhdHRlbXB0aW5nIHRvIHNlbGVjdA0KYW5vdGhlciBzbG90IGV2ZW4g
aWYgb25lIG1pZ2h0IGJlIGF2YWlsYWJsZS4NCg0KU2luY2Ugb25seSBpbnNlcnRpbmcgbmV3IGl0
ZW1zIGlzIG5lZWRlZCwgdGhlIHJhY2UgY2FuIG9ubHkgY2F1c2UgYSBmYWlsdXJlDQppZiB0aGUg
c2VsZWN0ZWQgc2xvdCB3YXMgdXBkYXRlZCB3aXRoIGFub3RoZXIgbmV3IGl0ZW0gY29uY3VycmVu
dGx5LA0Kd2hpY2ggbWVhbnMgdGhhdCBpdCBpcyBhcmJpdHJhcnkgd2hpY2ggb2YgdGhvc2UgdHdv
IGl0ZW1zIGdldHMNCmRyb3BwZWQuIFRoaXMgbWVhbnMgdGhlIGNtcHhjaGcoKSBhbmQgdGhlIHNw
ZWNpYWwgY2FzZSBhcmUgbm90IG5lY2Vzc2FyeSwNCmFuZCBoZW5jZSBqdXN0IGRyb3AgdGhlIGV4
aXN0aW5nIGl0ZW0gdW5jb25kaXRpb25hbGx5LiBOb3RlIHRoYXQgdGhpcw0KZG9lcyBub3QgcmVz
dWx0IGluIGxvc3Mgb2YgZXJyb3IgZXZlbnRzLCBpdCBzaW1wbHkgbWVhbnMgd2UgbWlnaHQNCmNh
dXNlIGEgZmFsc2UgY2FjaGUgbWlzcywgYW5kIHJlcG9ydCB0aGUgc2FtZSBldmVudCBvbmUgYWRk
aXRpb25hbA0KdGltZSBpbiBxdWljayBzdWNjZXNzaW9uIGV2ZW4gaWYgdGhlIGNhY2hlIHNob3Vs
ZCBoYXZlIHByZXZlbnRlZCB0aGF0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKaWEgSGUgPGp1c3Rpbi5o
ZUBhcm0uY29tPg0KU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4NCi0tLQ0KW0p1c3Rpbl06IEkgcmVtb3ZlZCBfX3JjdSBhbm5vdGF0aW9uIG9mIHZpY3RpbSwg
cmVtb3ZlZCB0aGUgUkNVX0lOSVRJQUxJWkVSDQpjYXN0IGFuZCBhZGRlZCB0aGUgdW5wdHIgZm9y
IHhjaGcuDQoNCmRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYyB8IDQ0ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KSwgMjIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYXBlaS9naGVz
LmMgYi9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMNCmluZGV4IDI3YzcyYjE3NWU0Yi4uNWZjOGEx
MzU0NTBiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQorKysgYi9kcml2
ZXJzL2FjcGkvYXBlaS9naGVzLmMNCkBAIC0xNTAsNyArMTUwLDcgQEAgc3RydWN0IGdoZXNfdmVu
ZG9yX3JlY29yZF9lbnRyeSB7DQogc3RhdGljIHN0cnVjdCBnZW5fcG9vbCAqZ2hlc19lc3RhdHVz
X3Bvb2w7DQogc3RhdGljIHVuc2lnbmVkIGxvbmcgZ2hlc19lc3RhdHVzX3Bvb2xfc2l6ZV9yZXF1
ZXN0Ow0KDQotc3RhdGljIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUgKmdoZXNfZXN0YXR1c19j
YWNoZXNbR0hFU19FU1RBVFVTX0NBQ0hFU19TSVpFXTsNCitzdGF0aWMgc3RydWN0IGdoZXNfZXN0
YXR1c19jYWNoZSBfX3JjdSAqZ2hlc19lc3RhdHVzX2NhY2hlc1tHSEVTX0VTVEFUVVNfQ0FDSEVT
X1NJWkVdOw0KIHN0YXRpYyBhdG9taWNfdCBnaGVzX2VzdGF0dXNfY2FjaGVfYWxsb2NlZDsNCg0K
IHN0YXRpYyBpbnQgZ2hlc19wYW5pY190aW1lb3V0IF9fcmVhZF9tb3N0bHkgPSAzMDsNCkBAIC03
ODUsMzEgKzc4NSwyNiBAQCBzdGF0aWMgc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSAqZ2hlc19l
c3RhdHVzX2NhY2hlX2FsbG9jKA0KICAgICAgICByZXR1cm4gY2FjaGU7DQogfQ0KDQotc3RhdGlj
IHZvaWQgZ2hlc19lc3RhdHVzX2NhY2hlX2ZyZWUoc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSAq
Y2FjaGUpDQorc3RhdGljIHZvaWQgZ2hlc19lc3RhdHVzX2NhY2hlX3JjdV9mcmVlKHN0cnVjdCBy
Y3VfaGVhZCAqaGVhZCkNCiB7DQorICAgICAgIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUgKmNh
Y2hlOw0KICAgICAgICB1MzIgbGVuOw0KDQorICAgICAgIGNhY2hlID0gY29udGFpbmVyX29mKGhl
YWQsIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUsIHJjdSk7DQogICAgICAgIGxlbiA9IGNwZXJf
ZXN0YXR1c19sZW4oR0hFU19FU1RBVFVTX0ZST01fQ0FDSEUoY2FjaGUpKTsNCiAgICAgICAgbGVu
ID0gR0hFU19FU1RBVFVTX0NBQ0hFX0xFTihsZW4pOw0KICAgICAgICBnZW5fcG9vbF9mcmVlKGdo
ZXNfZXN0YXR1c19wb29sLCAodW5zaWduZWQgbG9uZyljYWNoZSwgbGVuKTsNCiAgICAgICAgYXRv
bWljX2RlYygmZ2hlc19lc3RhdHVzX2NhY2hlX2FsbG9jZWQpOw0KIH0NCg0KLXN0YXRpYyB2b2lk
IGdoZXNfZXN0YXR1c19jYWNoZV9yY3VfZnJlZShzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQpDQotew0K
LSAgICAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICpjYWNoZTsNCi0NCi0gICAgICAgY2Fj
aGUgPSBjb250YWluZXJfb2YoaGVhZCwgc3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSwgcmN1KTsN
Ci0gICAgICAgZ2hlc19lc3RhdHVzX2NhY2hlX2ZyZWUoY2FjaGUpOw0KLX0NCi0NCiBzdGF0aWMg
dm9pZCBnaGVzX2VzdGF0dXNfY2FjaGVfYWRkKA0KICAgICAgICBzdHJ1Y3QgYWNwaV9oZXN0X2dl
bmVyaWMgKmdlbmVyaWMsDQogICAgICAgIHN0cnVjdCBhY3BpX2hlc3RfZ2VuZXJpY19zdGF0dXMg
KmVzdGF0dXMpDQogew0KICAgICAgICBpbnQgaSwgc2xvdCA9IC0xLCBjb3VudDsNCiAgICAgICAg
dW5zaWduZWQgbG9uZyBsb25nIG5vdywgZHVyYXRpb24sIHBlcmlvZCwgbWF4X3BlcmlvZCA9IDA7
DQotICAgICAgIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUgKmNhY2hlLCAqc2xvdF9jYWNoZSA9
IE5VTEwsICpuZXdfY2FjaGU7DQorICAgICAgIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUgKmNh
Y2hlLCAqbmV3X2NhY2hlOw0KKyAgICAgICBzdHJ1Y3QgZ2hlc19lc3RhdHVzX2NhY2hlICp2aWN0
aW07DQoNCiAgICAgICAgbmV3X2NhY2hlID0gZ2hlc19lc3RhdHVzX2NhY2hlX2FsbG9jKGdlbmVy
aWMsIGVzdGF0dXMpOw0KICAgICAgICBpZiAobmV3X2NhY2hlID09IE5VTEwpDQpAQCAtODIwLDEz
ICs4MTUsMTEgQEAgc3RhdGljIHZvaWQgZ2hlc19lc3RhdHVzX2NhY2hlX2FkZCgNCiAgICAgICAg
ICAgICAgICBjYWNoZSA9IHJjdV9kZXJlZmVyZW5jZShnaGVzX2VzdGF0dXNfY2FjaGVzW2ldKTsN
CiAgICAgICAgICAgICAgICBpZiAoY2FjaGUgPT0gTlVMTCkgew0KICAgICAgICAgICAgICAgICAg
ICAgICAgc2xvdCA9IGk7DQotICAgICAgICAgICAgICAgICAgICAgICBzbG90X2NhY2hlID0gTlVM
TDsNCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICAgICAgICAgIH0NCiAg
ICAgICAgICAgICAgICBkdXJhdGlvbiA9IG5vdyAtIGNhY2hlLT50aW1lX2luOw0KICAgICAgICAg
ICAgICAgIGlmIChkdXJhdGlvbiA+PSBHSEVTX0VTVEFUVVNfSU5fQ0FDSEVfTUFYX05TRUMpIHsN
CiAgICAgICAgICAgICAgICAgICAgICAgIHNsb3QgPSBpOw0KLSAgICAgICAgICAgICAgICAgICAg
ICAgc2xvdF9jYWNoZSA9IGNhY2hlOw0KICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQog
ICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIGNvdW50ID0gYXRvbWljX3JlYWQoJmNh
Y2hlLT5jb3VudCk7DQpAQCAtODM1LDE3ICs4MjgsMjQgQEAgc3RhdGljIHZvaWQgZ2hlc19lc3Rh
dHVzX2NhY2hlX2FkZCgNCiAgICAgICAgICAgICAgICBpZiAocGVyaW9kID4gbWF4X3BlcmlvZCkg
ew0KICAgICAgICAgICAgICAgICAgICAgICAgbWF4X3BlcmlvZCA9IHBlcmlvZDsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIHNsb3QgPSBpOw0KLSAgICAgICAgICAgICAgICAgICAgICAgc2xvdF9j
YWNoZSA9IGNhY2hlOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KLSAgICAgICAvKiBu
ZXdfY2FjaGUgbXVzdCBiZSBwdXQgaW50byBhcnJheSBhZnRlciBpdHMgY29udGVudHMgYXJlIHdy
aXR0ZW4gKi8NCi0gICAgICAgc21wX3dtYigpOw0KLSAgICAgICBpZiAoc2xvdCAhPSAtMSAmJiBj
bXB4Y2hnKGdoZXNfZXN0YXR1c19jYWNoZXMgKyBzbG90LA0KLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNsb3RfY2FjaGUsIG5ld19jYWNoZSkgPT0gc2xvdF9jYWNoZSkgew0KLSAg
ICAgICAgICAgICAgIGlmIChzbG90X2NhY2hlKQ0KLSAgICAgICAgICAgICAgICAgICAgICAgY2Fs
bF9yY3UoJnNsb3RfY2FjaGUtPnJjdSwgZ2hlc19lc3RhdHVzX2NhY2hlX3JjdV9mcmVlKTsNCi0g
ICAgICAgfSBlbHNlDQotICAgICAgICAgICAgICAgZ2hlc19lc3RhdHVzX2NhY2hlX2ZyZWUobmV3
X2NhY2hlKTsNCisgICAgICAgaWYgKHNsb3QgIT0gLTEpIHsNCisgICAgICAgICAgICAgICAvKg0K
KyAgICAgICAgICAgICAgICAqIFVzZSByZWxlYXNlIHNlbWFudGljcyB0byBlbnN1cmUgdGhhdCBn
aGVzX2VzdGF0dXNfY2FjaGVkKCkNCisgICAgICAgICAgICAgICAgKiBydW5uaW5nIG9uIGFub3Ro
ZXIgQ1BVIHdpbGwgc2VlIHRoZSB1cGRhdGVkIGNhY2hlIGZpZWxkcyBpZg0KKyAgICAgICAgICAg
ICAgICAqIGl0IGNhbiBzZWUgdGhlIG5ldyB2YWx1ZSBvZiB0aGUgcG9pbnRlci4NCisgICAgICAg
ICAgICAgICAgKiBBdCB0aGlzIHBvaW50LCB2aWN0aW0gbWF5IHBvaW50IHRvIGEgY2FjaGVkIGl0
ZW0gZGlmZmVyZW50DQorICAgICAgICAgICAgICAgICogZnJvbSB0aGUgb25lIGJhc2VkIG9uIHdo
aWNoIHdlIHNlbGVjdGVkIHRoZSBzbG90LiBJbnN0ZWFkIG9mDQorICAgICAgICAgICAgICAgICog
Z29pbmcgdG8gdGhlIGxvb3AgYWdhaW4gdG8gcGljayBhbm90aGVyIHNsb3QsIGxldCdzIGp1c3QN
CisgICAgICAgICAgICAgICAgKiBkcm9wIHRoZSBvdGhlciBpdGVtIGFueXdheTogdGhpcyBtYXkg
Y2F1c2UgYSBmYWxzZSBjYWNoZQ0KKyAgICAgICAgICAgICAgICAqIG1pc3MgbGF0ZXIgb24sIGJ1
dCB0aGF0IHdvbid0IGNhdXNlIGFueSBwcm9ibGVtcy4NCisgICAgICAgICAgICAgICAgKi8NCisg
ICAgICAgICAgICAgICB2aWN0aW0gPSB1bnJjdV9wb2ludGVyKHhjaGdfcmVsZWFzZSgmZ2hlc19l
c3RhdHVzX2NhY2hlc1tzbG90XSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBuZXdfY2FjaGUpKTsNCisgICAgICAgICAgICAgICBpZiAodmljdGltKQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgY2FsbF9yY3UoJnZpY3RpbS0+cmN1LCBnaGVzX2VzdGF0dXNfY2FjaGVf
cmN1X2ZyZWUpOw0KKyAgICAgICB9DQogICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KIH0NCg0K
SU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90
aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUg
aW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
