Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420FE5A0CF3
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiHYJqI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiHYJqH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 05:46:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446BAB192;
        Thu, 25 Aug 2022 02:46:05 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Q9cvPChol63pqW4bhb8Fep8lEP9mxjkWppA+4p7VTWnc7kv4tol+f69HjvxOC7k9NlePfktU3j2D510T/fPYr09YiaLrcO3nA0lbTBxuOnthYvKUCoeeOSnrys+7anKPBB+uKVOjf3+DE9KFc39KGouQtIfHplzeiV2xrHjo3uBXAue9t7VsvPzgF1pF8+dfKYur2beeAyMjBbOTr4fkxczG6t/gCCNfR0ItBkHg/8l+q7qjgVEyXPxbqbroqjISCju7WdW5dHNeXKx/Q6nAELoKCOK+HFqwounbegsd13IrqE/RyPWuDUDGZsH56GSRrIlk9jBq+bKM+cmtyO55IQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFK/67V86Ec8CVSpyCGHTZZEPhuVCBhNZ2A86ZS67r0=;
 b=ZzIUUzMV9uZbHDgeFIq/wyMUxg9d1Wt0A7ICuOPAHul0PL+RrrfxyNw9rd31NCkWmfrNOCKQYzNR9Y7bM1BynHt8LWoD6xTo61dX1n1vF+e0w/lrAPe6vt+JUxcr8E4tDiuukiNIWHB1tkDc4g73qdie+0lPLJQQ2VPzmKwgvZRBnZNMAiJfLDFtUwOo+UDPQdQPZq7cP4j1E/+6Mt+xQEvVZ/UbNMsPWIEeIjeH1Dc7iCQlUzIPiTDV7BlAM/+/tdTdr01ZQn23cDcLDO777z7A70cypjTo0O5srf9Oeo79BnrgtlmRkT+mV1SNM+Ob2Us+PccOr+iT8O9FVmrnUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFK/67V86Ec8CVSpyCGHTZZEPhuVCBhNZ2A86ZS67r0=;
 b=pCYHIs3SqdYpYpYawKq8v1h7+t3OKX7wfZgyHbbfcpMCzVeb1yiG60Jfi2z66ItgwNUZ6ymKzFP8gUYsYZCoxEC6g3JicJI91cAMk0sNsfEj9PNOii1Vp65Dckmer3fMAKcjUp9S49fjbT03QaD97lyS/Z77M97yJI8iVivG5l0=
Received: from AM6P195CA0051.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::28)
 by AM7PR08MB5477.eurprd08.prod.outlook.com (2603:10a6:20b:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:46:00 +0000
Received: from AM7EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::66) by AM6P195CA0051.outlook.office365.com
 (2603:10a6:209:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 09:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT051.mail.protection.outlook.com (100.127.140.64) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 09:46:00 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 25 Aug 2022 09:45:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e60c9a9157a8ccc0
X-CR-MTA-TID: 64aa7808
Received: from 99bccb321794.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F628CA97-8624-4987-8C4E-88B208A13D47.1;
        Thu, 25 Aug 2022 09:45:50 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 99bccb321794.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 25 Aug 2022 09:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV9d3yYO1jfslTguetXQkTjoHy9C15xff/5+yyUJkPWl3QojmKUp9+ZqvvurYrbPrVv+tJyUQnQYMFoO3V0cIEKKG3hOZjbtMbH9X8DVKFv7dRVHHKdLovmNmAHDvragNxMbQkFhwTlUneDoOW9Ea4i3i03Dd2r1zK7ywMzlSnLU2U0XeZrrDirmGsyUhl/hK5WfFnrMCCcm08td+ywjQ4YPPlYKMG5O8UmjszG5Zlkc/gT7xmO57sSAbNm5PRVZPnxkw/dPBESmNwKpcU27/68BsO/hgW003dOsdUYi7rCSL0WiHYMBx/gEiStjfdIgTXgrofUvKYUq8ewxG/aENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFK/67V86Ec8CVSpyCGHTZZEPhuVCBhNZ2A86ZS67r0=;
 b=E17OiCMreQ6gSwEPk8MjlRTjvJQDUYI9NGUQiLb1eyyia3HYsGJlH6kAIP1HGu/FtS58rY1z4R8c8Bw/osW3WviZMkgKTyU06GYXLOmtdBxeyV7gZJIUzfMQOg4S8YfdFKfLEcWi7pfSojEW6OpXaInsNWlT2qwStL89xhIy0awFyhYvWmHHLGqwB97f5+/aJVa1RRP1rADTOh1WY9TfmcAXQuzOeuqJox/c8onTe2ApJVW6CXKh/wcaQa2jU65N2zn3GCP7/LXt2U0uRv20iIuS6lwt0bqsesrVSsVfZ29LU+va/0ln+pML47LLLG2mhlZ/dCVauf5A7wdkwgW7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFK/67V86Ec8CVSpyCGHTZZEPhuVCBhNZ2A86ZS67r0=;
 b=pCYHIs3SqdYpYpYawKq8v1h7+t3OKX7wfZgyHbbfcpMCzVeb1yiG60Jfi2z66ItgwNUZ6ymKzFP8gUYsYZCoxEC6g3JicJI91cAMk0sNsfEj9PNOii1Vp65Dckmer3fMAKcjUp9S49fjbT03QaD97lyS/Z77M97yJI8iVivG5l0=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB9203.eurprd08.prod.outlook.com (2603:10a6:10:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:45:45 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 09:45:45 +0000
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
        Jonathan Corbet <corbet@lwn.net>,
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
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac
 drivers when ghes_edac is preferred
Thread-Topic: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac
 drivers when ghes_edac is preferred
Thread-Index: AQHYtj26/9nMMR+H0UmMm5YWXh0yUK2+rz0AgACyORA=
Date:   Thu, 25 Aug 2022 09:45:44 +0000
Message-ID: <DBBPR08MB453861C0EA7FB40AB3A13FCBF7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-6-justin.he@arm.com>
 <DM4PR84MB1853A76B1374A4BEAD8A1E3982739@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB1853A76B1374A4BEAD8A1E3982739@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 1e731f19-81ed-408e-97de-08da867e9e14
x-ms-traffictypediagnostic: DU0PR08MB9203:EE_|AM7EUR03FT051:EE_|AM7PR08MB5477:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tDkOMLiKCfbm1i30q4prcFmOLpDbs4q6VQBs6gbQDOOK/kJP5wWpMA6ORaa2O7zsEXI3jWT1vstpcHyf69AhXxZ+jJCmvMs2YyR1gFJXsHOBUJGussdjVBiJ/qH0p0pX7QQqAK9HfC6d0beqwSMcpi6SyL46jqshYJCmDsxoXAjX01+l7bVplTT7Q6Dgeevxc4GY/6EWnvE0uama/Ei3W0fbYBNgBiyj86J0bgxBhz3ZfcfcbmP6FQgx3nQVgoM/9ZDkvcNNNw5EmDRSNECEtVoLOc79rbm0hbwBaDhyKvFlgs0EtVhQsc0NWQ/gX+B/gg+5bcYMD4x6vWmAUthzKb3cI5EFOHO9kidQVUlq3BqlskEjVXUupmBvFotOBMXTh5CDbKMzkn+v3f3AlrzGmUpFwAclCUJAbKrOmZyWoUeUazkc68/wiac/XT6rB4kmuRP0QIgwDwmabZGSHx7rG1VD94rV9IGFgcZ5JZxoBsrr4BajZA0+5Yrf6IueDn6O3x6ktu58UWsEzxzmKL6Q2QpHWbJav9gJLwCoes7B9/LpfDlrKFpYS5+d7vIR5BYq5Cw4YuLbmlKdP+hlGan/FtehtOVDpKInbyGDfA3mohT8AKobt7BhxnxMiswQuC8RdGXisRAPuWoMO/3LMIsctNb2gKH/EVh7H2pkPRTOFTcLYefPxxTLkfLbQA5zdKCJ4F76t8DLqN/9OJVFYeeE1jj/3XEvXHf6v/h0rKsnkefiVdOli5yIZuUOv5DXohmZOSzNbnMgg1Tw53Koc6Nc+/Hmx3XQz9DvJY7eYyw2Zz4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(478600001)(921005)(71200400001)(5660300002)(7416002)(296002)(41300700001)(52536014)(8936002)(54906003)(110136005)(316002)(66446008)(64756008)(4326008)(66556008)(66476007)(66946007)(38070700005)(55016003)(86362001)(8676002)(76116006)(83380400001)(7696005)(6506007)(38100700002)(9686003)(53546011)(26005)(186003)(33656002)(2906002)(122000001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9203
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c80afc14-a95e-415c-505d-08da867e94f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClhS0+w3XM8yVBzhrVxhKX/94GA3kTpv5dEFKx1PpKLS3N+YKtPqnEq4qi5VQMR2pKamkUxlPqJ32GBXxUHW8XDZU39V8C65LXSZ/Rrn9gxw1mAsJ2oGaco9iFf3jT8M63G4UhfLKWjC2yHQh4EXXI62JFyG+6Y3UIOf1aGq69CiHbzl8VzaBfKmlqIAViwvK4157ba4tdr+M9fHWsK5PmbBybb/w1lHrJIm8M6+iXrUMqS0W5Wtpm48AsZSkmLj+sNB105XqsYwNKrzKXCfzkRIYThqF41DErYBuTyQ/k5XPTFy/l4/xJfyMd2b9tx74WswAPYH0CfzX+VhoCWGKxd3joQtsdhbxHp0pTnXinV7yfn4ta3Sry4HpDdLNV6aYAZ4RuK4vMjMPZRF5tu38S3161PpVIwoSN7g7huK1NQ0c/0WTtx1eu7qMWlUc4nRh4kWGlPfOVLwfFErQjr79+4JQ2IxCGrlwcyLOFRHv4g/rARMC+CVkj61zTlBV0ZkN4Mf+xp0SIHOMK3R1fjkMsH6TIrSsyUWsLqbRYDXZC0Y8zJBgcxt2sJXXRjAY2o3wLXqQacwJEJ925d3tlHJa7MOupXnwJFkJ7KOGlVgqLr3t7hmgJCDT7tpIg9uXasJNwoHqREFaZKWxka2k2vszArFswbmtUzCkAvHb8nToNhf3jICcvUXFwGdufhCMc+l1B0/BqAiDms7vjLgf95hw3h2A8EJ4Z04hMvjESVgtVa9TXOhanXDOxSQq2wAM92YV0KkXT+j0ORWEK/xFvrGGmzdzlbfuVDXTzKnGayD7qk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(52536014)(478600001)(6506007)(7696005)(2906002)(33656002)(26005)(53546011)(9686003)(40460700003)(41300700001)(86362001)(82740400003)(921005)(356005)(40480700001)(81166007)(55016003)(82310400005)(36860700001)(186003)(336012)(47076005)(83380400001)(70206006)(70586007)(4326008)(8676002)(54906003)(316002)(110136005)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 09:46:00.1247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e731f19-81ed-408e-97de-08da867e9e14
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: Kani, Toshi <toshi.kani@hpe.com>
> Sent: Thursday, August 25, 2022 7:04 AM
> To: Justin He <Justin.He@arm.com>; Len Brown <lenb@kernel.org>; James
> Morse <James.Morse@arm.com>; Tony Luck <tony.luck@intel.com>; Borislav
> Petkov <bp@alien8.de>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> Robert Richter <rric@kernel.org>; Robert Moore <robert.moore@intel.com>;
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>; Yazen Ghannam
> <yazen.ghannam@amd.com>; Jonathan Corbet <corbet@lwn.net>; Jan
> Luebbe <jlu@pengutronix.de>; Khuong Dinh
> <khuong@os.amperecomputing.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org; devel@acpica.or=
g;
> Rafael J . Wysocki <rafael@kernel.org>; Shuai Xue
> <xueshuai@linux.alibaba.com>; Jarkko Sakkinen <jarkko@kernel.org>;
> linux-efi@vger.kernel.org; nd <nd@arm.com>; Paul E. McKenney
> <paulmck@kernel.org>; Andrew Morton <akpm@linux-foundation.org>;
> Neeraj Upadhyay <quic_neeraju@quicinc.com>; Randy Dunlap
> <rdunlap@infradead.org>; Damien Le Moal
> <damien.lemoal@opensource.wdc.com>; Muchun Song
> <songmuchun@bytedance.com>; linux-doc@vger.kernel.org
> Subject: RE: [RESEND PATCH v3 5/9] EDAC: Don't load chipset-specific edac
> drivers when ghes_edac is preferred
>=20
> On Monday, August 22, 2022 9:41 AM, Jia He wrote:
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> > e17e0ee8f842..327386f3cf33 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1537,16 +1537,25 @@ static struct acpi_platform_list plat_list[] =
=3D {
> >  	{ } /* End */
> >  };
> >
> > -struct list_head *ghes_get_devices(void)
> > +bool ghes_edac_preferred(void)
> >  {
> >  	int idx =3D -1;
> >
> >  	if (IS_ENABLED(CONFIG_X86)) {
> >  		idx =3D acpi_match_platform_list(plat_list);
> >  		if (idx < 0 && !ghes_edac_force)
> > -			return NULL;
> > +			return false;
> >  	}
> >
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(ghes_edac_preferred);
> > +
> > +struct list_head *ghes_get_devices(void) {
> > +	if (!ghes_edac_preferred())
> > +		return NULL;
> > +
> >  	return &ghes_devs;
> >  }
>=20
> ghes_get_devices() changing multiple times in the series is
> confusing to me.   Can you simply introduce ghes_get_devices()
> and ghes_preferred() in the right state in a patch?  Perhaps, patch #2, #=
5, #6
> can collapse to introduce the two funcs?
>=20

My purpose was to make it easy for review. I am ok to merge these patches i=
nto one.

> The rest of patch #5 adding the call to ghes_edac_preferred() into other =
edac
> drivers can remain as a separate patch.

Okay, I assume you mean to merge all of the ghes_edac_preferred() checking =
for intel and
Arm edac drivers into 1 separate patch, am I understanding well?


--
Cheers,
Justin (Jia He)


