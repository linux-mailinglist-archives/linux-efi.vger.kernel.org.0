Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA45A58E0
	for <lists+linux-efi@lfdr.de>; Tue, 30 Aug 2022 03:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiH3BVe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 21:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH3BVd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 21:21:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACB67145;
        Mon, 29 Aug 2022 18:21:31 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=D7PbMqTbf8qMCleVDMNjATL73B275T6t58M0fb2Zm2C4harf1lKPppqfKLg1vCDfactsC6JzuZnsNTvA8ZFdAmgkZlj3a3Hjsk5dUU2LaKWReAijdk2WXWWV836UZbD8egPQR3cndpT3tCTPkmUBtkZyeKQUo4vSKIyutZYhXLDUbgkOmS/cIrDYNSJ2sLYRcxMS/c8XzOwHDMEN4wNsr7F3uHlt3VA7R8bsR8Nj0GBYboMfQ2RvkgNixG8vWow+WGLJ/RPgs2opMdJtf02S/7W9Dug4HE6YxHINWu92nzeS4nNTq3ehxyKbEe9xzPoQgd4XWv+dOaaHzPYFd24gjA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2xMgNC9AQmWYMCdV6VPSbQxnqyscL95dFB63fxSN/I=;
 b=W0DbpBQtCLrFPWY/hI6VubAxNTgh5DzTOF00TRABugWO5J2BDowWiJbslU3qxHNXM8o5bxGzSjoJrX429syqG1kl6GdeywwZPxT34muKjaM7wPPbZAMYNBgaP/iEJ1vmV61MRETKGPavJ/G877uC39sWK5v6nV8kGfcc0Z4EuqKyZcWQ72GCUMK46rETXQAoDn6C+VtDP/cTvkKGiJvMKBrNbts7e01iAyFGU7KjCm66XHLdDjVnxiUtXEgiBYa3CA/3h/twuWLrryk9GVKL1W3OLvH1hIdHzWMZbGJnkUnJEXC+0TxzlN/LMB9ZKLGXgJ8zLihGstCFPxvyecaSgQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2xMgNC9AQmWYMCdV6VPSbQxnqyscL95dFB63fxSN/I=;
 b=WcqH4AoDffbQISauloyAeaudpY6T9OslGQlp8VvzxTsivU4cbiYu3Li0A23ZvIPGdWYsjBCURrQxlvenLj3ebT/lw9cCVASq1199yEtGg0Ytw+kgQ1Qhbnzf0+Z5oLyE7T5NubfT12AgM9nfd6AUO20MSZpWE7cBCXwdmPbMyRE=
Received: from FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::18)
 by PA4PR08MB5982.eurprd08.prod.outlook.com (2603:10a6:102:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 01:21:29 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:49:cafe::ac) by FR0P281CA0065.outlook.office365.com
 (2603:10a6:d10:49::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 01:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 01:21:28 +0000
Received: ("Tessian outbound cc6a8ab50b6b:v123"); Tue, 30 Aug 2022 01:21:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 037582b719fce3bd
X-CR-MTA-TID: 64aa7808
Received: from a8b61a2e894e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 32B6A491-F67F-409B-9089-3C0ECABCC31E.1;
        Tue, 30 Aug 2022 01:21:21 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a8b61a2e894e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 30 Aug 2022 01:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPcno7cNISfz6l9kaSlkJTwuJ3JJW2SyCd5brR7pjMtvxfNcnrQE+RO77so4m3Q70XLxX9xUgXbvJaS37PXAdV7xbEtTwEOY6eqCF4POc0r4bhcWj3MpR/QpbW8guuXiDk0sqtxUK6gYMn9CD0K4tJmPFkS5RwNeZ6xVOHo3T3eBfIoJNQcDE0Cdwz3VJ+1e68yh4Xt4Mnw5ueb6ms5sbRSMFiHb6Oz5YjMfyUPnQQKFui9zAgJxsZYhNmfWesTe95dEIHGqrvedoP7iChZw8qZernyEWsgbrQUr6i6jCrbHw2uj5XR6j+GWqM4dWJpVJ/vzSRR/+gispr0q9gkKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2xMgNC9AQmWYMCdV6VPSbQxnqyscL95dFB63fxSN/I=;
 b=Cdypaq6Qb1xo0KwVtm0GWcp3dYOUFB2gAza9xjn9/nXzCyUgRnyZEsjgOmCAtg4Adjj1xOPnJOR/aD1b8uVv3TNy62QHHogPe9RTP4QmFjg99VPorKtyqf75l6GiF+Vying71QgFiw7QJbAWxPxSIz+yawH5InG0laQiYns00Rn8pM4K3nLjrrNiIfM0KMp2O1cXSHmsHC64SBjExF1Ce4ec6C5qKm5Vy8uXls9zP6dn4zvzPxnUQlMt0YaTv93mIuVrLD09OW2G4NbHUFlU4nCQ0/d+/uVkEoY32wjVgMem8xuc+DYbIC1M6sk4yKlTXXC3/BhJT2kh3chQaQdTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2xMgNC9AQmWYMCdV6VPSbQxnqyscL95dFB63fxSN/I=;
 b=WcqH4AoDffbQISauloyAeaudpY6T9OslGQlp8VvzxTsivU4cbiYu3Li0A23ZvIPGdWYsjBCURrQxlvenLj3ebT/lw9cCVASq1199yEtGg0Ytw+kgQ1Qhbnzf0+Z5oLyE7T5NubfT12AgM9nfd6AUO20MSZpWE7cBCXwdmPbMyRE=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PR3PR08MB5626.eurprd08.prod.outlook.com (2603:10a6:102:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 01:21:14 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 01:21:14 +0000
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
Thread-Index: AQHYtj3GzHVOUKz3/UmUjsOno++RI62+No2AgAh4r1A=
Date:   Tue, 30 Aug 2022 01:21:14 +0000
Message-ID: <DBBPR08MB45386BD1164AAAD8DE27FCDBF7799@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-5-justin.he@arm.com> <YwZJP25sfKcfw9eT@zn.tnic>
In-Reply-To: <YwZJP25sfKcfw9eT@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 1e8b4ca9-5941-40a8-c1e5-08da8a25f709
x-ms-traffictypediagnostic: PR3PR08MB5626:EE_|VE1EUR03FT045:EE_|PA4PR08MB5982:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: usgECXFguTRQpZsHJ6QZWgsjw2KUq+trAEl1ziClHxWGFuYs/Cb5xOPhqN0/KGEIGOdv0bVO04ROYK8s9fDglw21RLoe/Wr+f8AooydY/CKOilOaZAOY0v965BqN3lopi6j8qLMUAIA8hOlLL47EsZuqn6EVV3bWS0lPhoQXhDHiWm2cPyr0S99AJRNMhErcGMLhrr3RiAzco8SF4hsfKq4679oaQG+tFTDblCwV0PiWwLvx/Lepl/nVVU0tRwdRtPUTZScEf9V5Uvz1zJJEZX9W15RDcPB2EI0O6VdhNb5tUsP3LS8cp7ZGSiSOosWwzAgK66MXiWr8QIkWmrkDkeHyHw3+bNvEE4wW3HzFiq83e0QlcbvwssBc+fqjNlm+HJF5WZbAkRlbghzbWVjW0ZhMQJRRsqO+1Di+OxMs9E2DnGDZKdT/JZOSNGdwHWHmvEJv2e6JgwaQGjghoRfQ9xhh8TPME8X4SCt6LZB0+LNnMLPUUCvqJB3ARicxTvGpgwVSQ3AGAcSVmJSRXk+aNtpV60psf5frDbhXF83wol86claVvwaoModNe7XzCJaC5zQ6G5ul78MODVmBdp1zFGpbSBnFw+0TaUfMnZMHSTpzRRc2Md7InI+WQk0Uoo/ec3K3BLsORWkSi0R8nrNk1cSBET7TqWHsvrB8A/0wvcyIjov/lFBP0JWDGU+uaLyhK14oTrygJ9yAAZuULLw3YqlkJwxN2yaqOA5Cz2kVS5z1taIXPXqY0y6n4IJ9l4dewDSG3uq9Zzc9bvAc2GCWaA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(8936002)(6916009)(5660300002)(71200400001)(66946007)(7416002)(86362001)(2906002)(66476007)(66446008)(64756008)(76116006)(66556008)(316002)(38070700005)(4326008)(54906003)(122000001)(38100700002)(8676002)(52536014)(55016003)(33656002)(186003)(83380400001)(41300700001)(9686003)(26005)(6506007)(7696005)(478600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5626
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 966a43dd-ad8a-4b92-f3e3-08da8a25ee91
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rn1Ey8suSHOim8wpSU6BvacnBn1ppmHGz0Ivl3PWrql2dbKwegNwG/Lu+/YM6r749vK9rhsWVemrOBMj6ooESSkewFsa21ILZ2XQZz1X8sZGeTC9frb6nRqpx10z8f8UN98lWFiFQamIU+8Af3bpKU6I8uf0bH0GkmYCqLkrVt5QBxendAUug+CZRetrf9p+riR9STG//9EVyDRSbN/PaV+6cnbLyMyyVsgES4iEh8/rJEL2lPO4R38O1iIOYy5rH4jxTTcStSsBZLuMnXQbAIieWZ1ZtP/Jp8HwrmqlTXd0zV2LpUJUjJWkU1IyITLagU4ZIokyVRyCiSFyO1MG7yg9vSjR87Y/Kn/sJWLou6OAVbfYpBMs6AITYmBf0i6XL1sNrpyf/f/hcSa9MrW+xNGGCeWbDtP/6IMZJ/Wv/Ee3dghJBXyViFAVvXuA+iAZAfB15IwhzEphbsmFRZiJWQGKVGRy4wvjCMSUQAny3EJjCYb8XIYzIR4AwM0px4L8BopK0jkzowAUnZiRnk6cg3dM2QHbXUcZcNgBvO/FwbwnBlMU7QHfKnxPgwsvI+cQ67r5kOT6A/qz61SqxtEKhqVQV5tqLzDlZFie1cgjJSaiojK8aCtQfM9VHz7bjgjsRdZXrOBPTRRTWiGVfQ3MGXys8Vsk1a8hJW/PHczmNadn1jbFBweOo3F/Qnb4uDF2b3k3zGsoU7+zHsx7+KbWTtUd12MfY6/GXn2GgBXUCEiqrX84VG4YCoAgNCe/j2pfLZeAuPA1qSUYSVKZ0IRXyA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(9686003)(40480700001)(47076005)(55016003)(336012)(450100002)(83380400001)(70586007)(2906002)(8676002)(6506007)(70206006)(7696005)(54906003)(36860700001)(186003)(81166007)(82310400005)(356005)(316002)(52536014)(33656002)(26005)(41300700001)(478600001)(86362001)(4326008)(82740400003)(8936002)(6862004)(5660300002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 01:21:28.6568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b4ca9-5941-40a8-c1e5-08da8a25f709
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5982
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KWy4uLl0NCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0
ZXJzLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVy
cy50eHQNCj4gPiBpbmRleCBkN2YzMDkwMmZkYTAuLmE1ZjBlZTBkNzcyNyAxMDA2NDQNCj4gPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+
ID4gQEAgLTE1OTMsNiArMTU5MywxMSBAQA0KPiA+ICAJCQlXaGVuIHplcm8sIHByb2ZpbGluZyBk
YXRhIGlzIGRpc2NhcmRlZCBhbmQgYXNzb2NpYXRlZA0KPiA+ICAJCQlkZWJ1Z2ZzIGZpbGVzIGFy
ZSByZW1vdmVkIGF0IG1vZHVsZSB1bmxvYWQgdGltZS4NCj4gPg0KPiA+ICsJZ2hlc19lZGFjX2Zv
cmNlPSBbWDg2XSBTa2lwIHRoZSBwbGF0Zm9ybSBjaGVjayBhbmQgZm9yY2libHkgbG9hZCB0aGUN
Cj4gDQo+IFNvIHRoZXJlIGFscmVhZHkgaXMgZ2hlcy5kaXNhYmxlIHdoaWNoIGlzIHVzaW5nIHRo
ZSBtb2R1bGUgcGFyYW0gdGhpbmcuDQo+IFdoeSBkb24ndCB5b3UgZG8gdGhhdCB0b28/DQo+IA0K
PiA+ICsJCQlnaGVzX2VkYWMgbW9kdWxlcy4NCj4gDQo+ICJtb2R1bGUiIC0gc2luZ3VsYXIuDQo+
IA0KPiA+ICsJCQlGb3JtYXQ6IDxib29sPg0KPiA+ICsJCQlkZWZhdWx0OiBmYWxzZSAoMCkNCj4g
PiArDQo+ID4gIAlnb2xkZmlzaAlbWDg2XSBFbmFibGUgdGhlIGdvbGRmaXNoIGFuZHJvaWQgZW11
bGF0b3IgcGxhdGZvcm0uDQo+ID4gIAkJCURvbid0IHVzZSB0aGlzIHdoZW4geW91IGFyZSBub3Qg
cnVubmluZyBvbiB0aGUNCj4gPiAgCQkJYW5kcm9pZCBlbXVsYXRvcg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMgYi9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMgaW5k
ZXgNCj4gPiA5YzUyMTgzZTNhZDkuLmUxN2UwZWU4Zjg0MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2FjcGkvYXBlaS9naGVzLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMN
Cj4gPiBAQCAtOTQsNiArOTQsMjYgQEANCj4gPiAgI2RlZmluZSBGSVhfQVBFSV9HSEVTX1NERUlf
Q1JJVElDQUwJX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzDQo+ID4gICNlbmRpZg0KPiA+DQo+ID4g
Ky8qDQo+ID4gKyAqICJnaGVzX2VkYWNfZm9yY2U9MSIgZm9yY2libHkgbG9hZHMgZ2hlc19lZGFj
IGFuZCBza2lwcyB0aGUNCj4gPiArcGxhdGZvcm0NCj4gPiArICogY2hlY2suDQo+ID4gKyAqLw0K
PiA+ICtib29sIF9fcmVhZF9tb3N0bHkgZ2hlc19lZGFjX2ZvcmNlOw0KPiA+ICtFWFBPUlRfU1lN
Qk9MKGdoZXNfZWRhY19mb3JjZSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBzZXR1
cF9naGVzX2VkYWNfbG9hZChjaGFyICpzdHIpIHsNCj4gPiArCWlmIChzdHIpDQo+ID4gKwkJaWYg
KCFzdHJjbXAoInRydWUiLCBzdHIpIHx8ICFzdHJjbXAoIjEiLCBzdHIpKQ0KPiA+ICsJCQlnaGVz
X2VkYWNfZm9yY2UgPSB0cnVlOw0KPiA+ICsNCj4gPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdf
WDg2KSkNCj4gPiArCQlnaGVzX2VkYWNfZm9yY2UgPSB0cnVlOw0KPiA+ICsNCj4gPiArCXJldHVy
biAxOw0KPiA+ICt9DQo+ID4gK19fc2V0dXAoImdoZXNfZWRhY19mb3JjZT0iLCBzZXR1cF9naGVz
X2VkYWNfbG9hZCk7DQo+IA0KPiBXaHkgYWxsIHRoYXQ/DQo+IA0KPiBJc24ndCBzcGVjaWZ5aW5n
DQo+IA0KPiBnaGVzLmVkYWNfZm9yY2VfbG9hZA0KPiANCj4gb24gdGhlIGtlcm5lbCBjb21tYW5k
IGxpbmUgZW5vdWdoPyBJLmUuLCB5b3UgZG9uJ3QgbmVlZCB0byBwYXJzZSB0aGUgcGFzc2VkDQo+
IGluIG9wdGlvbiAtIGp1c3QgdGhlIHByZXNlbmNlIG9mIHRoZSBwYXJhbWV0ZXIgaXMgZW5vdWdo
Lg0KPiANCj4gPiArDQo+ID4gIHN0YXRpYyBBVE9NSUNfTk9USUZJRVJfSEVBRChnaGVzX3JlcG9y
dF9jaGFpbik7DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBib29sIGlzX2hlc3RfdHlwZV9nZW5l
cmljX3YyKHN0cnVjdCBnaGVzICpnaGVzKSBAQA0KPiA+IC0xNTE3LDEzICsxNTM3LDEzIEBAIHN0
YXRpYyBzdHJ1Y3QgYWNwaV9wbGF0Zm9ybV9saXN0IHBsYXRfbGlzdFtdID0gew0KPiA+ICAJeyB9
IC8qIEVuZCAqLw0KPiA+ICB9Ow0KPiA+DQo+ID4gLXN0cnVjdCBsaXN0X2hlYWQgKmdoZXNfZ2V0
X2RldmljZXMoYm9vbCBmb3JjZSkNCj4gPiArc3RydWN0IGxpc3RfaGVhZCAqZ2hlc19nZXRfZGV2
aWNlcyh2b2lkKQ0KPiA+ICB7DQo+ID4gIAlpbnQgaWR4ID0gLTE7DQo+ID4NCj4gPiAgCWlmIChJ
U19FTkFCTEVEKENPTkZJR19YODYpKSB7DQo+ID4gIAkJaWR4ID0gYWNwaV9tYXRjaF9wbGF0Zm9y
bV9saXN0KHBsYXRfbGlzdCk7DQo+ID4gLQkJaWYgKGlkeCA8IDAgJiYgIWZvcmNlKQ0KPiA+ICsJ
CWlmIChpZHggPCAwICYmICFnaGVzX2VkYWNfZm9yY2UpDQo+ID4gIAkJCXJldHVybiBOVUxMOw0K
PiA+ICAJfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBi
L2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBpbmRleA0KPiA+IGJiM2VhNDJiYTcwYi4uNmEyYjU0
Y2M3MjQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KPiA+IEBAIC01NCwxMCArNTQsNiBAQCBzdGF0
aWMgREVGSU5FX01VVEVYKGdoZXNfcmVnX211dGV4KTsNCj4gPiAgICovDQo+ID4gIHN0YXRpYyBE
RUZJTkVfU1BJTkxPQ0soZ2hlc19sb2NrKTsNCj4gPg0KPiA+IC0vKiAiZ2hlc19lZGFjLmZvcmNl
X2xvYWQ9MSIgc2tpcHMgdGhlIHBsYXRmb3JtIGNoZWNrICovIC1zdGF0aWMgYm9vbA0KPiA+IF9f
cmVhZF9tb3N0bHkgZm9yY2VfbG9hZDsgLW1vZHVsZV9wYXJhbShmb3JjZV9sb2FkLCBib29sLCAw
KTsNCj4gPiAtDQo+ID4gIHN0YXRpYyBib29sIHN5c3RlbV9zY2FubmVkOw0KPiA+DQo+ID4gIHN0
YXRpYyBzdHJ1Y3QgbGlzdF9oZWFkICpnaGVzX2RldnM7DQo+ID4gQEAgLTQzNywyMyArNDMzLDEy
IEBAIHN0YXRpYyBpbnQgZ2hlc19lZGFjX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
PiAgCW1jaS0+Y3RsX25hbWUgPSAiZ2hlc19lZGFjIjsNCj4gPiAgCW1jaS0+ZGV2X25hbWUgPSAi
Z2hlcyI7DQo+ID4NCj4gPiAtCWlmIChmYWtlKSB7DQo+ID4gLQkJcHJfaW5mbygiVGhpcyBzeXN0
ZW0gaGFzIGEgdmVyeSBjcmFwcHkgQklPUzogSXQgZG9lc24ndCBldmVuIGxpc3QgdGhlDQo+IERJ
TU1TLlxuIik7DQo+ID4gLQkJcHJfaW5mbygiSXRzIFNNQklPUyBpbmZvIGlzIHdyb25nLiBJdCBp
cyBkb3VidGZ1bCB0aGF0IHRoZSBlcnJvciByZXBvcnQNCj4gd291bGRcbiIpOw0KPiA+IC0JCXBy
X2luZm8oIndvcmsgb24gc3VjaCBzeXN0ZW0uIFVzZSB0aGlzIGRyaXZlciB3aXRoIGNhdXRpb25c
biIpOw0KPiA+IC0JfSBlbHNlIGlmIChmb3JjZV9sb2FkKSB7DQo+ID4gLQkJcHJfaW5mbygiVGhp
cyBFREFDIGRyaXZlciByZWxpZXMgb24gQklPUyB0byBlbnVtZXJhdGUgbWVtb3J5IGFuZA0KPiBn
ZXQgZXJyb3IgcmVwb3J0cy5cbiIpOw0KPiA+IC0JCXByX2luZm8oIlVuZm9ydHVuYXRlbHksIG5v
dCBhbGwgQklPU2VzIHJlZmxlY3QgdGhlIG1lbW9yeSBsYXlvdXQNCj4gY29ycmVjdGx5LlxuIik7
DQo+ID4gLQkJcHJfaW5mbygiU28sIHRoZSBlbmQgcmVzdWx0IG9mIHVzaW5nIHRoaXMgZHJpdmVy
IHZhcmllcyBmcm9tIHZlbmRvciB0bw0KPiB2ZW5kb3IuXG4iKTsNCj4gPiAtCQlwcl9pbmZvKCJJ
ZiB5b3UgZmluZCBpbmNvcnJlY3QgcmVwb3J0cywgcGxlYXNlIGNvbnRhY3QgeW91ciBoYXJkd2Fy
ZQ0KPiB2ZW5kb3JcbiIpOw0KPiA+IC0JCXByX2luZm8oInRvIGNvcnJlY3QgaXRzIEJJT1MuXG4i
KTsNCj4gPiAtCQlwcl9pbmZvKCJUaGlzIHN5c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxuIiwN
Cj4gZ2hlc19ody5udW1fZGltbXMpOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgCWlmICghZmFrZSkg
ew0KPiA+ICAJCXN0cnVjdCBkaW1tX2luZm8gKnNyYywgKmRzdDsNCj4gPiAgCQlpbnQgaSA9IDA7
DQo+ID4NCj4gPiArCQlwcl9pbmZvKCJUaGlzIHN5c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxu
IiwNCj4gZ2hlc19ody5udW1fZGltbXMpOw0KPiA+ICsNCj4gPiAgCQltY2lfZm9yX2VhY2hfZGlt
bShtY2ksIGRzdCkgew0KPiA+ICAJCQlzcmMgPSAmZ2hlc19ody5kaW1tc1tpXTsNCj4gPg0KPiAN
Cj4gVGhpcyBodW5rLi4uDQo+IA0KPiA+IEBAIC00NzgsNiArNDYzLDE3IEBAIHN0YXRpYyBpbnQg
Z2hlc19lZGFjX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCX0gZWxzZSB7DQo+
ID4gIAkJc3RydWN0IGRpbW1faW5mbyAqZGltbSA9IGVkYWNfZ2V0X2RpbW0obWNpLCAwLCAwLCAw
KTsNCj4gPg0KPiA+ICsJCXByX2luZm8oIlRoaXMgc3lzdGVtIGhhcyBhIHZlcnkgY3JhcHB5IEJJ
T1M6IEl0IGRvZXNuJ3QgZXZlbiBsaXN0IHRoZQ0KPiBESU1NUy5cbiIpOw0KPiA+ICsJCXByX2lu
Zm8oIkl0cyBTTUJJT1MgaW5mbyBpcyB3cm9uZy4gSXQgaXMgZG91YnRmdWwgdGhhdCB0aGUgZXJy
b3IgcmVwb3J0DQo+IHdvdWxkXG4iKTsNCj4gPiArCQlwcl9pbmZvKCJ3b3JrIG9uIHN1Y2ggc3lz
dGVtLiBVc2UgdGhpcyBkcml2ZXIgd2l0aCBjYXV0aW9uXG4iKTsNCj4gPiArDQo+ID4gKwkJaWYg
KGdoZXNfZWRhY19mb3JjZSkgew0KPiA+ICsJCQlwcl9pbmZvKCJUaGlzIEVEQUMgZHJpdmVyIHJl
bGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBtZW1vcnkNCj4gYW5kIGdldFxuIik7DQo+ID4gKwkJ
CXByX2luZm8oImVycm9yIHJlcG9ydHMuIFVuZm9ydHVuYXRlbHksIG5vdCBhbGwgQklPU2VzIHJl
ZmxlY3QNCj4gdGhlXG4iKTsNCj4gPiArCQkJcHJfaW5mbygibWVtb3J5IGxheW91dCBjb3JyZWN0
bHkuIElmIHlvdSBmaW5kIGluY29ycmVjdCByZXBvcnRzLA0KPiBwbGVhc2VcbiIpOw0KPiA+ICsJ
CQlwcl9pbmZvKCJjb250YWN0IHlvdXIgaGFyZHdhcmUgdmVuZG9yIGZvciBpdHMgaW4gY29ycmVj
dA0KPiBCSU9TLlxuIik7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiAgCQlkaW1tLT5ucl9wYWdlcyA9
IDE7DQo+ID4gIAkJZGltbS0+Z3JhaW4gPSAxMjg7DQo+ID4gIAkJZGltbS0+bXR5cGUgPSBNRU1f
VU5LTk9XTjsNCj4gDQo+IC4uLiBhbmQgdGhpcyBodW5rIGxvb2sgdW5yZWxhdGVkIHRvIHdoYXQg
dGhpcyBwYXRjaCBpcyBkb2luZy4gV2hhdCBhcmUgdGhleSBmb3I/DQo+IA0KQW5vdGhlciBwdXJw
b3NlIGZvciBhZGp1c3RpbmcgdGhlIHByX2luZm8gaHVuayBpcyB0byBzdXBwcmVzcyB0aGUgd2Fy
bmluZyBkbWVzZyBsb2cNCm9uIEFybSBzZXJ2ZXIuDQpPbiBBcm0sIHRoZSBnaGVzX2VkYWNfZm9y
Y2VfbG9hZCAobW9kdWxlIHBhcmFtZXRlciBpbiBnaGVzKSBzaG91bGQgYmUgdHJ1ZSB1bmNvbmRp
dGlvbmFsbHkuDQpTbyBJIG1vdmVkIHRoZSBmb2xsb3dpbmcgYmxvY2sgaW4gZmFrZT09dHJ1ZSBj
aGVjaywgaXMgdGhpcyByZWFzb25hYmxlPw0KK0lmICghZmFrZSkNCisuLi4NCitlbHNlDQorCQlp
ZiAoZ2hlc19lZGFjX2ZvcmNlKSB7DQorCQkJcHJfaW5mbygiVGhpcyBFREFDIGRyaXZlciByZWxp
ZXMgb24gQklPUyB0byBlbnVtZXJhdGUgbWVtb3J5IGFuZCBnZXRcbiIpOw0KKwkJCXByX2luZm8o
ImVycm9yIHJlcG9ydHMuIFVuZm9ydHVuYXRlbHksIG5vdCBhbGwgQklPU2VzIHJlZmxlY3QgdGhl
XG4iKTsNCisJCQlwcl9pbmZvKCJtZW1vcnkgbGF5b3V0IGNvcnJlY3RseS4gSWYgeW91IGZpbmQg
aW5jb3JyZWN0IHJlcG9ydHMsIHBsZWFzZVxuIik7DQorCQkJcHJfaW5mbygiY29udGFjdCB5b3Vy
IGhhcmR3YXJlIHZlbmRvciBmb3IgaXRzIGluIGNvcnJlY3QgQklPUy5cbiIpOw0KKwkJfQ0KDQpX
aGF0IGRvIHlvdSB0aGluayBvZiBpdD8gDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkN
Cg0K
