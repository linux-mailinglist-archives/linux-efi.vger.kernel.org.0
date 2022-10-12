Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8905FC4FC
	for <lists+linux-efi@lfdr.de>; Wed, 12 Oct 2022 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLMHQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Oct 2022 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJLMHF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Oct 2022 08:07:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54E1ADB5;
        Wed, 12 Oct 2022 05:06:53 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=A0eoEvX+ae6AYmZ+8oNKiNsFf6XFWeLqunzMm0hkx9XDA/iP7Yp1/i4GNicJKIBGEcE9EinD032SRy4xlJ1R1rP7j174GEXPOWta3EMJ34xo1xywFBDAtikIKcE+0gq6K8uY6CxVfJyXsYa3NU5uzxstGJVUbIiNoTHFCDcMbyvjZX8fEYf4lnYKG5c9YuPgbTd7RMctgNds4UBfWKAdSDGJcButt9B51t5B68zXl5aVDgHxSYC3ejMo7B89s1zBMVWQ+iNRtJwnv7XEe2gehi0T8wQKgj2XOOr2E7j9BS5GZvHnLC20DZsFog6Uxr4vQNKA8nxTvNOJ6LLeFkzOCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS3nGkCEQdWUu14xVdTFKJLX/bxa2iDAmr3sRt7nAPY=;
 b=Z3bkWQhe0eZBeWo8XvG8sKDkZBS5zIrzymJ3iQz9l0ubCDWQf9YUpmxktJobyUWD/ju+QpqZaoIvhvcWIOmq6O2VUAGNnWI10xOtiurnXGfMrpi2qh5VbWboE4NNqQz//RWQksCQYXpieLjP4J5PV/9C1eJx9zI09o/VqBqhbcCIpXGdF3FdmyTdSHFkbmOqv/SNXsEaekrHeydCOdyP6oelfq3+n3KPgmMbVibQ3Axw4YBX+uagmGz5gnayRaJi7HmMA2BzRPW84uUkGJ4JCNC80ZA406ZOGxN09LdRaGlhO3undzyFWZNn+2IqaG25FAtpf4Y01gf0O4lcuA2UBg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS3nGkCEQdWUu14xVdTFKJLX/bxa2iDAmr3sRt7nAPY=;
 b=U5oweQH0o/vESJemu9lsjLIWge32AmK0gW15K/CJT1Esr01gPgWDI8yOjSwFdf0VMsgEyLxTmtjL8ZPwTbCEKAaz8+zeARsVEcEh4xI8t1me2LIfqnWMU+0YHwhFW82/ZCknogcP8xLEYRgxPc/NSiCU2OVA+Sro2eCovLl+hJw=
Received: from AS9PR06CA0182.eurprd06.prod.outlook.com (2603:10a6:20b:45d::16)
 by AS8PR08MB8328.eurprd08.prod.outlook.com (2603:10a6:20b:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 12 Oct
 2022 12:05:07 +0000
Received: from AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45d:cafe::92) by AS9PR06CA0182.outlook.office365.com
 (2603:10a6:20b:45d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Wed, 12 Oct 2022 12:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT058.mail.protection.outlook.com (100.127.140.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 12 Oct 2022 12:05:06 +0000
Received: ("Tessian outbound 99ee3885c6d5:v128"); Wed, 12 Oct 2022 12:05:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 87bc3f77c4308b73
X-CR-MTA-TID: 64aa7808
Received: from 5fcf26e0a8e6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3F6A06CD-DFB2-4AE2-A723-609DE5862D6F.1;
        Wed, 12 Oct 2022 12:05:00 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5fcf26e0a8e6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Oct 2022 12:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoetS0kJROXLlLpEQadYUVz3rU7RHx3wibir2qPmOXl3aDG7MsZ2Rg1RCcidXOQ4Tji02DD5TxAoYkOVq38kvasAeIPqjqMM4+iRjUWYMmBZYlMCIJd+GY0FX9Yrl2edql0rzjM+NK3NlHc7M8v/BB5S9ylIWjomlcD/kqzCD+WZ4l9hi7NawdThlZ835mY8X5nNE8Dslo8CiWi1U6OzS5xJPJaHszo/TakMjI0D31n8EkRJ/iCBLgnGY+LPtXlhV1BMY+qqhDG8HXEYX27OCZ+syWT/JxQ0XDX1LQI2Y2MV50CCeVWrCgyCR8ASVRsekpwI1OoKYhk7BroLWwE0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS3nGkCEQdWUu14xVdTFKJLX/bxa2iDAmr3sRt7nAPY=;
 b=b/d97sIOu44Ss332vAbl67Pf0eToWBYoQMi7ZdeJEUodMxZf57FcEHAsAQ07IBeAMr0a/kbRz7EEKxp3Fop/Gl5z6a1Y+kzV5ySFvQOI4HLHSdP0Yh+OVGRn08nO5ovnTbnu8oQ3GmsLGG+i+e7EpwNpVdBUK0R6FNr69zKhupDs4A+WZh9x0p+RhgDNphvjP4ZLQFVaWgXQ6P4CzpGrQKQIzU7zh/4sEfwBB/FKcCzgEcsiCpBchHWoIHRMWMTRV/Hoz72uHq1moins8TCnNLRHQ6o+Xvk2fLWh6Mvgt+qJiu5jj8wVxEij2ibkEgtRt5NgefxqrJPqCyIPidg/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS3nGkCEQdWUu14xVdTFKJLX/bxa2iDAmr3sRt7nAPY=;
 b=U5oweQH0o/vESJemu9lsjLIWge32AmK0gW15K/CJT1Esr01gPgWDI8yOjSwFdf0VMsgEyLxTmtjL8ZPwTbCEKAaz8+zeARsVEcEh4xI8t1me2LIfqnWMU+0YHwhFW82/ZCknogcP8xLEYRgxPc/NSiCU2OVA+Sro2eCovLl+hJw=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by AS8PR08MB8327.eurprd08.prod.outlook.com (2603:10a6:20b:56e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 12 Oct
 2022 12:04:57 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::d98f:f69a:a28c:fbfc%7]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 12:04:57 +0000
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
Thread-Index: AQHY3FE9MI2RuRcaLke0tv5UeBjXAK4JAUiAgAA9Q/CAAAkTAIABZGGQ
Date:   Wed, 12 Oct 2022 12:04:57 +0000
Message-ID: <DBBPR08MB4538D5A85F707632ACCB70A4F7229@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20221010023559.69655-1-justin.he@arm.com>
 <20221010023559.69655-7-justin.he@arm.com> <Y0VGkUxpqiIzIFzB@zn.tnic>
 <DBBPR08MB4538A9F831FA96545BA35D9FF7239@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y0WBklS1XpB5as+m@zn.tnic>
In-Reply-To: <Y0WBklS1XpB5as+m@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|AS8PR08MB8327:EE_|AM7EUR03FT058:EE_|AS8PR08MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 491c5e1c-b276-41f2-f02e-08daac4a0101
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cUnLYHaVNRnAkAxt0Lf1Z0ibNcB9gIQk1ls6sHYDnVXlZigxO2SGN/YlTs9wdGeYSoNHg7o7pdHhxU8j6Y5wS4M++E0afBXyc4W8h7ZjjdvvNVh1hS8Ipvaz3BUmjIIPBsie7T8IKPIEWUSwdkF09onUgu4iosOodqeuEaUbPksDOXU8H4EOhYlMTqnSgXYpqC06mQpKuxY4kaDIIXGqk7XYkXJpNhx65LK5Q4fBfA3AGMm6PRXx1VgdumA5B1Obmr0zkhDxlpklYLD4ofVPmsgIs4NziA3c8Vg2SN7aNuJy2PfaZBHNdWrrZehy3uZBZWJRRL90YAjT6nAU5hrWqXbDVkRLJ5bGAqZ28zDuSEglSwEMrK3GvO6N9d6PjIDNODnzemjACRS6jvmelDYl+nr9vNBhtBRMvyXrvzkJg39X8V9uPJ9eCf5uCBZL42DesOeDOYJDGkSqpIuQC/Upv6ai66TiXTRIptThVbgC5s9OfWQN9p8sMTUtriqlEeuvvOrStNEkwecMbv9+0HSVEhPky55PkOO6GyPVMdP+9hwj551812nUW0dnkB+F9gtXIF+QnN9AokQ/fuIPfyUMeL2AjlfiCTrfbaxjXrBTE+/7c1adRsq0rOBZ/Jc9BCZr9F6KgGZ93lnyG1BcVczJK5AWD9UAYG/K7XTE0rLbavX2tjf5atDQhnDxs8ulZDMQPYcMvH6KE0egeoLkGDbdbmtM2soBnn6GJUPFD17xk4rvQsI/YGNiB+CFdLEz9tL69vN/w+6+3vI2YNVyJd57oNzcQjrwoww5COnADiE19sX8BLQ1lL+Ze8aURNjKA4KN
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(7416002)(41300700001)(52536014)(8936002)(5660300002)(2906002)(7696005)(122000001)(478600001)(316002)(53546011)(76116006)(55016003)(64756008)(38100700002)(71200400001)(9686003)(54906003)(86362001)(66446008)(66476007)(8676002)(66556008)(6506007)(6916009)(4326008)(186003)(83380400001)(66946007)(26005)(33656002)(38070700005)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8327
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 55b6d1c3-d72f-4c50-3ea3-08daac49fb72
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUW496ciMekxjucS1igRMP/RpreA3H/P0yNfNZRKqWkMeOhyT+iZ4HaD/q/pPg/BGDpib42AWF2UM+VMnSau7Y4qHq6c2QLi/KlDMZzp4Lsa2hXMggLXYWssMrNNRdI7JQS4o/HIJxsQA+SgCdgVMlTSWFfYJW5iNijjWSXnwW8XNxR+joNvM+dFri5S/14pPls56sTwKX3d2DgSLD0wgRjPb5Au/U8M0UkGp+1A261TyuHI9TgBX3qJEHwBUDutiGV7AZimxPHkR2KddCh/fnjMt9DC69s3ZJP4rNPk/Z37dEm+vYx+mnBsUYGYjCxV01XbTaRUpeI4nJQuHm1hnM7YiCIg9YDQ2+PZBYj9KDvjWAPvS55HrMyXyj1+zN2kzUR5nf05OWczdc+mDudJlD8mNjfNYcU17ytgRIANdUlGw108dLK6l13aXCLNKUaEWLKh+uLNeXonBogAQwJVzLxSuKpH/WB2MJZsdCxnixJOINj9bjVoHZzCStlOb/FHH1WfH4tBhvyNwzeRnOT6rvGFJslrvG8SLo6s/e7g4XcS6zS612Vx7ndQZ3Cp7ZfN2gW5sTUEoY/RGuOrImhYgi4czR4e0yipugJAOXmpgkn/sM3PHkQ7bx0CVEN6BF61VFLewwLutmlyIl3B1zmxJQ7xACNDWyBI1P7pfBRJVFKFDMHmD9wo7WoJVXVOOSd1YxehbKEXme+AxlM0XLTmQA9WtQKKELinSxoApwnmHisauUEAWzq6ip2ULiYJUULFbHHMIWNktkUlErDcswFcQdaWR0Lb4mtayPAK5yT059KikQ+N5rAEfZznl/5afncL
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(450100002)(336012)(33656002)(6506007)(53546011)(316002)(186003)(8676002)(5660300002)(8936002)(47076005)(7696005)(107886003)(2906002)(356005)(70206006)(86362001)(40460700003)(40480700001)(81166007)(6862004)(41300700001)(52536014)(26005)(55016003)(4326008)(83380400001)(36860700001)(54906003)(9686003)(82740400003)(82310400005)(478600001)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 12:05:06.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491c5e1c-b276-41f2-f02e-08daac4a0101
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8328
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
MjAyMiAxMDo0NiBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6
IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNlQGFy
bS5jb20+Ow0KPiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBNYXVybyBDYXJ2YWxo
byBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtl
cm5lbC5vcmc+OyBSb2JlcnQgTW9vcmUNCj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBRaXV4
dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT47IFlhemVuDQo+IEdoYW5uYW0gPHlhemVuLmdo
YW5uYW1AYW1kLmNvbT47IEphbiBMdWViYmUgPGpsdUBwZW5ndXRyb25peC5kZT47DQo+IEtodW9u
ZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEthbmkgVG9zaGkNCj4gPHRv
c2hpLmthbmlAaHBlLmNvbT47IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Ow0KPiBs
aW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7IFJhZmFlbCBK
IC4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+OyBTaHVhaSBYdWUgPHh1ZXNodWFpQGxp
bnV4LmFsaWJhYmEuY29tPjsgSmFya2tvDQo+IFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz47
IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7IG5kIDxuZEBhcm0uY29tPjsNCj4ga2VybmVsIHRl
c3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNi83XSBh
cGVpL2doZXM6IFVzZSB1bnJjdV9wb2ludGVyIGZvciBjbXB4Y2hnDQo+IA0KPiBPbiBUdWUsIE9j
dCAxMSwgMjAyMiBhdCAwMjozMjo0OFBNICswMDAwLCBKdXN0aW4gSGUgd3JvdGU6DQo+ID4gTXkg
b3JpZ2luYWwgcHVycG9zZSBpcyB0byBtYWtlIGl0IHBhc3MgdGhlIHNwYXJzZSBjaGVja2luZy4N
Cj4gDQo+IFRoZW4gZG8gdGhpcyBwbHMuDQo+IA0KPiBUaGlzIGlzIGEgY29tYmluZWQgZGlmZiAt
IGRvIGEgc2Vjb25kIHBhdGNoIHdoaWNoIGRvZXMgb25seSByZW1vdmUgdGhlDQo+IHNtcF93bWIo
KS4gVGhlIHNtcF93bWIoKSB0aGVyZSBpcyBub3QgbmVlZGVkIGFzIHRoZSBjbXB4Y2hnKCkgYWxy
ZWFkeQ0KPiBpbXBsaWVzIGEgc21wX21iKCkgc28gdGhlcmUncyBubyBuZWVkIGZvciB0aGF0IHNl
cGFyYXRlLCBleHBsaWNpdCBvbmUuDQo+IA0KSSBoYXZlIGEgY29uY2VybiBhYm91dCB3aGF0IGlm
IGNtcHhjaGcgZmFpbGVkPyBEbyB3ZSBoYXZlIHRvIHN0aWxsIGd1YXJhbnRlZSB0aGUgb3JkZXJp
bmcgc2luY2UgY21weGNoZyB3aWxsIG5vdCBpbXBseSBhIHNtcF9tYiBpZiBpdCBmYWlsZWQuDQoN
CkJlc2lkZXMsIEkgZGlkbid0IGZpbmQgdGhlIHBhaXJlZCBzbXBfbWIgb3Igc21wX3JtYg0KZm9y
IHRoaXMgc21wX3dtYi4gRG8geW91IGhhdmUgYW55IGlkZWFzPw0KDQotLQ0KQ2hlZXJzLA0KSnVz
dGluIChKaWEgSGUpDQoNCg0KDQo=
