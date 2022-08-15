Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44561592787
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 03:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiHOBdB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Aug 2022 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOBdA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Aug 2022 21:33:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D624D4D;
        Sun, 14 Aug 2022 18:32:58 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=K+oyPPmsC4YlGS0eXBk0YWPIMDNlW1OJw2iYl7a0xs+gl2oAToTxMGeWMtsIITc6XVSobNaMY1/QExG6cR9Ayjk+ODHldMofvUj1kK1zV9ZLHZ6K+c6IsyK5MyPX3omPqH9SgyAlfV1G0+zwEzIE1VHhAHHMtWb0S7zKtvS9mDymMO/G1OqVGV/Pa06snogtOfBjiA1GQBLmC2zt085vV476si6SrXigN6RU3+INymWYtJDR1AJjHlv9UYoqbe4PKuQpHj30wQQiC+znm+I7lcOribFkx/BVf3abr+40x0JVDDYP/zJIltxxX0BlIYRoF8H2ehCyIomQBjFPKdX8HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqp2xoOdvJobrtbkGy/rxQmGcfJd3iHkBWJXqfvchBY=;
 b=JQJN9WtICq+KJ6pvNi0PRW4cxYZnVxTt74MyKd18guUeUmdmqcPUnc2jknZNwA3SXJAGz7B+5E6qNhr4pI8unW8n/v85ROYEEGJBHOAPUrOFcYkuq2izNsAjIzOdaY52ICf4evB/mrrq2Pn/IDTo+JGvODbsEe8vGuX+iEJ1gpAtZJapkGMP9k/RLEP4uWS14/6D5cx+WZinEBJItYXyR/NFycd2VJK/0pxDgIycKI5GjgZVG+ie8BIO5RleAAl96/d6rs418LSDwHIA9SklGojt0/ov5tpe4RoICtCBX4Xwt+D3f+OXxxqLrI9lyn6854UDKFMzZZFvDd1Mca1FPw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqp2xoOdvJobrtbkGy/rxQmGcfJd3iHkBWJXqfvchBY=;
 b=shOIhe1knhZEfr29Mgi0v/TJJnOuqYj0fSIfumZ9iVRMkFcsfWn8GlD1m5nw8hCjd+DZeA2LMTyYxod+uxp/gO+24tfnvcwwZpOsSs3JH9ADHwhk9rq6APlyH4kJgTCVO8a8wEYa44s+J2NbCWPkd6RFqdqf5r547iYUOn6bwIE=
Received: from FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1f::22)
 by VI1PR08MB4125.eurprd08.prod.outlook.com (2603:10a6:803:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 01:32:54 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:1f:cafe::82) by FR3P281CA0085.outlook.office365.com
 (2603:10a6:d10:1f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14 via Frontend
 Transport; Mon, 15 Aug 2022 01:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 01:32:54 +0000
Received: ("Tessian outbound 2af316122c7a:v123"); Mon, 15 Aug 2022 01:32:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 373a33fce40d20ef
X-CR-MTA-TID: 64aa7808
Received: from d1fe8f5d5e07.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 730C4A79-2BEA-4BB0-9C89-87B798417B2D.1;
        Mon, 15 Aug 2022 01:32:44 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d1fe8f5d5e07.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Aug 2022 01:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdqOwpSH+6Gv5N1y5cQoMjkj7hW6gA0/B3pjujDwM7pKtkzzZ3pFNxPxvxroFI3rR7r8t5hf4lGaaoNjsZlb9llxCO9+xrW31i4s4HgXhKeHvsnnaMNKlxmg7cQaxe6K3IJEDvE4VNqprbUw+bO7sArx8s0zxc/sDlAoYJsA4tiGvPeLfUZeQkwsTdY2JAQG8LdPf4yt6zFZRdK8FhPh2kL0RoKI0LWhjmcHjR8JMdx7+qOwkzBiF81XRdCwHfqwoZE1cYImF8VOGLwXsp1jFgthwZl5bEMH4cyo8aOxHApSYnJ71/hi4b23JrQjTzRwo66RmAV+U4pi++sp4BSpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqp2xoOdvJobrtbkGy/rxQmGcfJd3iHkBWJXqfvchBY=;
 b=Dq1iSUsBkPbbEejbOLbdf5/r1kqKR1QGki64pVyQjaFGUP19bklgt6xIhRo+97ldBUttAHJEJoYbTpboSWuT3lFUNpPE/59YAFOjPjm5dHPZigDl3oTIXlM/veeSpllfk6LhHTafcU07ewmAIhkGueW+xCP5OObFOjZH1RQBR1uLm8F1EeXNmTBUSkTh11/P0xIz+lNqrFPNN+0dH74//g+ZO6xxZW0cBcknVWFuXmXaHfSyQHNrznPURIZwlrR/edTH5mOt5lr0ugDldS5fLBTzkyryJ6xTdBmEcSJvXsOwmlYzmdxf4sRCG8GBEg6w4GbNPuDpqB2Enc84GkwKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqp2xoOdvJobrtbkGy/rxQmGcfJd3iHkBWJXqfvchBY=;
 b=shOIhe1knhZEfr29Mgi0v/TJJnOuqYj0fSIfumZ9iVRMkFcsfWn8GlD1m5nw8hCjd+DZeA2LMTyYxod+uxp/gO+24tfnvcwwZpOsSs3JH9ADHwhk9rq6APlyH4kJgTCVO8a8wEYa44s+J2NbCWPkd6RFqdqf5r547iYUOn6bwIE=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PR3PR08MB5866.eurprd08.prod.outlook.com (2603:10a6:102:85::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 01:32:41 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.025; Mon, 15 Aug 2022
 01:32:41 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Topic: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to remove the
 dependency on ghes
Thread-Index: AQHYrWM9z4laCnaXtkSIa72TszXQIa2rWbmAgAPX8uA=
Date:   Mon, 15 Aug 2022 01:32:40 +0000
Message-ID: <DBBPR08MB45385132F6FC09B4941B5706F7689@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
In-Reply-To: <YvZnrTrXhRn8FV3I@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: cb43ea6f-f32e-407a-07fc-08da7e5e138f
x-ms-traffictypediagnostic: PR3PR08MB5866:EE_|VE1EUR03FT016:EE_|VI1PR08MB4125:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mVOwWZkclqCqESv9gVfFvf650osjXOmXrGCXao/N/bMvi52h211GNF49oNQ42kz94UiNOy2evsWELVgjAW6DSGfSNNIrw1S4Zsh55J0eTfDwYJ+nKq1j6uZLdPvKCfn/8C05zGhRSO+4X1CBl1ux8tZVrjLK2qOoZUnreBeLgxuFhqMLFkA6Api0zYg5N/zFffc/8g8Uzv/zxINiskxE8x6PzcFqhEFtDAb0fNb60ie60F9Dql0c3Ue97WryaGeV7BpQlDxP3vBFlJTCXxbX9qbB6JAyhJO5VRsM8j4rQw9DVJbVgTac2rYTPmbBVaf8taaSN6J0HeZTcRu7GjWf5Uty6B61cIlqlBCEsBXH+uL4210qcSqZKOA53pwZucmwZiVRtqYNuO/Mg8VWWQDHS/GEBegtfRQJ+ujFs+Ky1bvQkL2HUDmlX004GOsB6Q7glPxV25+SAMwJtd4tU/Axmi+hvO1ZgSZZTo9BJ0FjWgtCf4N0VqNTpc7Oi9ocVrSPTL1hFfOsE8X9otUUyuLIHgPGUAdyWOcUc3SWRKhTMvlDEM8r4Vgy3dpkcO+Oo2ryq6v5MNEo8RmagEhMADWjfj2YFhrdz7cJ1TsGxbIIwfbo9/YIqau1n3IxHhCs4V74XdRfynZDNw5XZm8JbMjV5WosdWcNXnMQ92i/bZxJBcGrFlISRniVGiWd+bQsnV5WNyPydzkosKK2hF7wAl0tvKNv91fNo/s1yVfZyVgBk2NUY5JMk0CBXIwan7XVe8Ci8qEfEoZM95sO+WTj3L1q0gNJrXTcnypVtbntmd6ULMHnhtAQXJ2o5ewUOyEP2+wz
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66556008)(4326008)(76116006)(66946007)(26005)(53546011)(316002)(83380400001)(64756008)(66476007)(66446008)(8676002)(9686003)(186003)(33656002)(5660300002)(2906002)(7416002)(86362001)(52536014)(55016003)(8936002)(71200400001)(478600001)(41300700001)(54906003)(110136005)(6506007)(7696005)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5866
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5b4aa76-1aa8-41f9-5b47-08da7e5e0b54
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy6zyhoRyq36RO2XacXwMP4U4E0L5eDtQH8GJTv4ep1caUxjduisyE97bpf1daPV+coQyrwzqPd/pAk2WyxQqZ+huCADJ802R7X0Mttxx9Zza8GB53kcpIC6qS+Pk+JpPjGFX2SbXG3PfT3mZCGTS5+B8a76QxReaZ05HeDkZBgQpqavnq4kSPBZ7Y1vxdoSuYYDk3R/swXIPjTcT9z7xik6F8HZIWYvg93QUyF9Bal7sap9Y2Wi4OfjJ12SO8ejFtd6Vc7hcZv0I1S7NUUoDeJAxtw2W34C0ZPW0iQWgKi0nptz707thY+uvT5DQz+2fx6Q5bUe6kfysBO+ZFogv5awoRroLIqDETSt5rnMg5/tN1BYKPRpQs3a1JrgPfpbvgndLpvENyvwi7NRamsBXcAQcj8NGZiNJccQL2L4mFsBPjxEExyXZOJsfno6KJqPpKSAyYCRxFkUIU0gyEOvMRNVfLdmV5c4HsSx5ZLcHRfUspKSG/1tavfGAhJueMfUmJA0+0nX2+YN1NtVm9Hr42YMS/8HsoQhhvD7mQ4nFCNwqRc/t/1QHitGEYiqJvH7eVyHTvl9H66+1kN6yD13JaaWLJ1kuiyQJvBXulL/KISIPBrYHp+1gRx6ORreTuJKARRHrCZBmI5riGfS0iZAv5k8Kf3ZbFEj5dUChaz3/xBSdKd6FDwYewgNNVdfTicJDbydii5iypjMnMkoBnYLlMOwJx4Ek9Gfdrnccjn0e3WPXVHTmgbF+aXvgu7IgSb3m+cRM0ymJafz/Wqu776IJQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(346002)(396003)(376002)(46966006)(36840700001)(33656002)(83380400001)(8676002)(26005)(47076005)(9686003)(478600001)(186003)(336012)(54906003)(110136005)(4326008)(70586007)(450100002)(70206006)(8936002)(40480700001)(55016003)(81166007)(36860700001)(5660300002)(316002)(82740400003)(82310400005)(52536014)(2906002)(41300700001)(7696005)(6506007)(86362001)(53546011)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:32:54.4013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb43ea6f-f32e-407a-07fc-08da7e5e138f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4125
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXMgYW5kIFRvc2hpDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDEyLCAyMDIyIDEwOjQ2IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0K
PiBDYzogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBr
ZXJuZWwub3JnPjsgSmFtZXMNCj4gTW9yc2UgPEphbWVzLk1vcnNlQGFybS5jb20+OyBUb255IEx1
Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVo
YWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+Ow0KPiBSb2Jl
cnQgTW9vcmUgPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7DQo+IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+OyBTaHVhaSBYdWUNCj4gPHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPjsg
SmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz47DQo+IGxpbnV4LWVmaUB2Z2VyLmtl
cm5lbC5vcmc7IG5kIDxuZEBhcm0uY29tPjsgdG9zaGkua2FuaUBocGUuY29tOw0KPiBzdGFibGVA
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gRURBQy9naGVzOiBNb2R1bGFy
aXplIGdoZXNfZWRhYyBkcml2ZXIgdG8gcmVtb3ZlDQo+IHRoZSBkZXBlbmRlbmN5IG9uIGdoZXMN
Cj4gDQo+IE9uIFRodSwgQXVnIDExLCAyMDIyIGF0IDA5OjE3OjEzQU0gKzAwMDAsIEppYSBIZSB3
cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jIGIvZHJpdmVy
cy9hY3BpL2FwZWkvZ2hlcy5jIGluZGV4DQo+ID4gZDkxYWQzNzhjMDBkLi5lZDY1MTlmM2Q0NWIg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+ID4gKysrIGIvZHJp
dmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+ID4gQEAgLTk0LDYgKzk0LDggQEANCj4gPiAgI2RlZmlu
ZSBGSVhfQVBFSV9HSEVTX1NERUlfQ1JJVElDQUwJX19lbmRfb2ZfZml4ZWRfYWRkcmVzc2VzDQo+
ID4gICNlbmRpZg0KPiA+DQo+ID4gK0FUT01JQ19OT1RJRklFUl9IRUFEKGdoZXNfcmVwb3J0X2No
YWluKTsNCj4gDQo+IHN0YXRpYy4gWW91IG5lZWQgZnVuY3Rpb24gd3JhcHBlcnMgd2hpY2ggY2Fs
bCB0aGUgbm90aWZpZXIgZnJvbSB0aGUgbW9kdWxlLg0KPiANCk9rDQoNCj4gQWxzbywgd2h5IGF0
b21pYz8geDg2X21jZV9kZWNvZGVyX2NoYWluIGlzIGEgYmxvY2tpbmcgb25lLg0KPiANCkJ1dCBp
cyBnaGVzX3Byb2NfaW5faXJxKCkgaW4gdGhlIGlycSBjb250ZXh0IHdoaWNoIGNhbiBpbnZva2Ug
dGhlIG5vdGlmaWVyPw0KSSBkZXNjcmliZWQgaXQgaW4gdGhlIGNvbW1pdCBsb2c6DQo+VG8gcmVz
b2x2ZSB0aGUgYnVpbGQgZGVwZW5kZW5jeSBvZiBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcigp
IGZvciBnaGVzLA0KPmludHJvZHVjZSBhIG5vdGlmaWVyIHdoaWNoIGlzIHJlZ2lzdGVyZWQgYnkg
Z2hlc19lZGFjIG1vZHVsZS4gYXRvbWljDQo+bm90aWZpZXIgaXMgdXNlZCBiZWNhdXNlIGdoZXNf
cHJvY19pbl9pcnEoKSBpcyBpbiB0aGUgaXJxIGNvbnRleHQuDQoNCj4gQWxzbywgdGhlIHdob2xl
IG5vdGlmaWVyIGFkZGluZyB0aGluZyBuZWVkcyB0byBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KT2ss
IEkgd2lsbCB0cnkgdG8gY2xlYW5seSBzcGxpdCBpdA0KDQo+IA0KPiA+IEBAIC0xNDk3LDMgKzE1
MDQsMzcgQEAgdm9pZCBfX2luaXQgYWNwaV9naGVzX2luaXQodm9pZCkNCj4gPiAgCWVsc2UNCj4g
PiAgCQlwcl9pbmZvKEdIRVNfUEZYICJGYWlsZWQgdG8gZW5hYmxlIEFQRUkgZmlybXdhcmUgZmly
c3QgbW9kZS5cbiIpOw0KPiA+IH0NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIEtub3duIHg4NiBz
eXN0ZW1zIHRoYXQgcHJlZmVyIEdIRVMgZXJyb3IgcmVwb3J0aW5nOg0KPiA+ICsgKi8NCj4gPiAr
c3RhdGljIHN0cnVjdCBhY3BpX3BsYXRmb3JtX2xpc3QgcGxhdF9saXN0W10gPSB7DQo+ID4gKwl7
IkhQRSAgICIsICJTZXJ2ZXIgICIsIDAsIEFDUElfU0lHX0ZBRFQsIGFsbF92ZXJzaW9uc30sDQo+
ID4gKwl7IH0gLyogRW5kICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbGlzdF9oZWFk
ICpnaGVzX2dldF9kZXZpY2VzKGJvb2wgZm9yY2UpIHsNCj4gPiArCWludCBpZHggPSAtMTsNCj4g
PiArDQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KPiA+ICsJCWlkeCA9IGFj
cGlfbWF0Y2hfcGxhdGZvcm1fbGlzdChwbGF0X2xpc3QpOw0KPiA+ICsJCWlmIChpZHggPCAwICYm
ICFmb3JjZSkNCj4gPiArCQkJcmV0dXJuIE5VTEw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0
dXJuICZnaGVzX2RldnM7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoZ2hlc19nZXRf
ZGV2aWNlcyk7DQo+IA0KPiBBbmQgeWVzLCBhcyBUb3NoaSBwb2ludHMgb3V0LCB0aGUgb3RoZXIg
RURBQyBkcml2ZXJzIC0gc2JfZWRhYywgc2t4X2VkYWMgYW5kDQo+IGFtZDY0X2VkYWMgLSBzaG91
bGQgY2FsbCB0aGlzIGZ1bmN0aW9uIGluIHRoZWlyIGluaXQgZnVuY3Rpb25zIHNvIHRoYXQgaXQg
Y2FuIGdldA0KPiBzZWxlY3RlZCB3aGljaCBkcml2ZXIgdG8gbG9hZCBvbiBIUEUgc2VydmVyIHBs
YXRmb3Jtcy4NCj4gDQo+IEFsc28gaW4gYSBzZXBhcmF0ZSBwYXRjaCBwbHMuDQo+IA0KT2ssIHRo
YW5rcw0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
