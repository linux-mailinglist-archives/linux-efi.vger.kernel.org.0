Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF15992D5
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 03:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbiHSB5m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 21:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHSB5l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 21:57:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19349DF087;
        Thu, 18 Aug 2022 18:57:40 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XtD5yamk8hNmw67ekKRmid1/fSzTe9YugJX1jQqkp50rYLzwJfO4ZqtSJZKGQxOxd2xQs91FPVT2h0md/Si6KyYizA6mg6eDBTjkw64u9ddqTW0aKRHNJRbGYp2pEQR8Z1FNz5PTJ/3XBNTpYwj8Ulxt6Eaxxtfn+hetan7NqnBuVTSDNPyVQRg+j5j0E4W3oH5Kwmwpsh5i/Q9kDFL2QwAX/A5qbGCy00F1oDNDGoAx9IdJFJhz9Gq+vMG6CDDan0vn1cOkglcbekZCHbvMYPVbSdAnaS5FQ9BfYlS3iXBcip+QovJPGBOf7UP6CHwjsE9nHIaTo2X6uPxxOPRsfw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+WIiTc3FB5eRpHqAvj0RJsKX/aBNuf9kYVhc6ZgL3A=;
 b=nHbGHAGP5nDTJ9ph6vxQbi1GZ0kwkUAw5Vzm1yijsN/DuXe4mLGDfPIGMney9Vl3mE1Zoq0SR7p3iv9/a4y7JLQAp33uGeus6z++SsSOvOtpLD61pk3jfBfey1JTIzkJFJrcUTNhrGjOxm53ALLrAvGO8sFkCmfleFhNj1FQPFIXB+4PqOPtGqc80kLftNFNE0F7LOZtxvbGd1IEbOH8dImzlo9Vpcws5PvIiLa0Lk8PlVqwPqOn6J5rujSUeQxAYGc9awhvs0Ri/unMMhz+4ORnju0y1+0OZ3Iw2USNJSONqB8qwcEP/a+ejNotgNVxeMz845ps3A1gXWzVA2N6ew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+WIiTc3FB5eRpHqAvj0RJsKX/aBNuf9kYVhc6ZgL3A=;
 b=K/UCML5RxzIeajU0Z9Ccbz1lpM0KjGONa0MuJ9s4a9Hn650CszOnbpks8QyqTrRMLayQngg8/+/VwEwhf9Km6hpn2OvNoqMBtbbqFZat9oQsskLtOJ7t0pVk0h/YEHXn50u0WpGIqooQHLRI0yn3LXGzrR+2kOQjxOZmQEInN5k=
Received: from AS9PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:20b:46a::27)
 by VI1PR08MB3549.eurprd08.prod.outlook.com (2603:10a6:803:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 01:57:35 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46a:cafe::c) by AS9PR04CA0048.outlook.office365.com
 (2603:10a6:20b:46a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17 via Frontend
 Transport; Fri, 19 Aug 2022 01:57:34 +0000
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
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 01:57:34 +0000
Received: ("Tessian outbound 2af316122c7a:v123"); Fri, 19 Aug 2022 01:57:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d01bee787fd9e7a8
X-CR-MTA-TID: 64aa7808
Received: from e0f8461ad780.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 73522C7C-BED6-4DF0-A90C-2E555D5C89D7.1;
        Fri, 19 Aug 2022 01:57:22 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e0f8461ad780.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 19 Aug 2022 01:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsTlCJ6Owvuun33YN5tyVFJ5gPYblAY2JHzf6Qr4hcKcVQ7zVMlXK3nwKd3q4W/OU3NZU/xvgwWC9VROxLzUM02InTv+VaZBApz9vPD6fOmSrrlrh6NAY1Vk0a3YaralbkIyeqeaEkPPEIcLW53BQjx0P113eQrwt6LZCNF9b1vBMh5rPCnr4r28pyZ5ni37vOVootutEUbwhavrv0/KKtu+zI84jy5e36BBTFDiddZiFJEFG1HF9LsijstzXgogjg9JtyD0GcuJtt5Z6zg6nDxNHLqof+6EOGtlnvbhiq9CjndRnqvIK6fkGdunPEW5XtOPRTK3LJX4qyJfa96l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+WIiTc3FB5eRpHqAvj0RJsKX/aBNuf9kYVhc6ZgL3A=;
 b=UfGE89mjXQI90fcZ9KOcjl6SMQZNHG1I9ax48dvEgIKFn8FVxFScsjZjdyXnS79FELQWpXlyCTYkHQ1vgCOq7ajNGnJ8jheeyrukHBTTrUIgyrs26sIkl1vOoBY7DOuPbyBcD9BxQopWUq44OQUueM8Jx8BiNNlxXfGqZIdK4RG7BMMAudJTJg4ohJOHkKF8KSxvF8RM6x825tfkr8w8MWtfGg25b70kt61sN2Z8UUW/znc/yr0TiYmild+pIPOgUrnwk3FUjLQPC61lsbJjGZfpgsmMy5LVT8FyAUcHO3/uuiblci7BhszocGa2nGsyVQWgLLhSD1TogzX7XIMkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+WIiTc3FB5eRpHqAvj0RJsKX/aBNuf9kYVhc6ZgL3A=;
 b=K/UCML5RxzIeajU0Z9Ccbz1lpM0KjGONa0MuJ9s4a9Hn650CszOnbpks8QyqTrRMLayQngg8/+/VwEwhf9Km6hpn2OvNoqMBtbbqFZat9oQsskLtOJ7t0pVk0h/YEHXn50u0WpGIqooQHLRI0yn3LXGzrR+2kOQjxOZmQEInN5k=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by VI1PR08MB2894.eurprd08.prod.outlook.com (2603:10a6:802:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 19 Aug
 2022 01:57:19 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 01:57:19 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selected
 only when ghes_edac is not enabled
Thread-Topic: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selected
 only when ghes_edac is not enabled
Thread-Index: AQHYskaqTVrkesfvDEmeunbadEp7d621V9AAgAAhJ7A=
Date:   Fri, 19 Aug 2022 01:57:19 +0000
Message-ID: <DBBPR08MB4538A7C2A7544B05D19495E7F76C9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-5-justin.he@arm.com>
 <DM4PR84MB18537B0FA6BF7B6BCB583C88826D9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB18537B0FA6BF7B6BCB583C88826D9@DM4PR84MB1853.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 80645ca5-8459-4229-9e74-08da81862f4f
x-ms-traffictypediagnostic: VI1PR08MB2894:EE_|VE1EUR03FT024:EE_|VI1PR08MB3549:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: F3G6pmK2b7LvvdZwnfUiS0aN4PwerLNyw8bQQAD+qYuqfXe5EXCr44iRSTr0bp5bpWkf9oRlDDOYlytQPZHDMg9qRNl92wmrzyje0zRr+i+VKxeVhlUJWmhJ2pd1A+CWD6FyYl0kZW3wv7tUuab10dMEhvFMhyq1PQYHt6a6LrNUX0jXQLW7eSA3+jRGrAVPwKk2uAzLaTqz9WaqKXe536j/WumbSbgtpSJcw/1n6acBQp9rLlsQwTG/S9I1iHwJngRaUiNPhjA/jaKdFwdWrhXLC9jF7Gk0B4wcSWpViKakqxe+LvhQ6Nq8MXt54Q/I2arP8sFNWYZXWcMn1oLfOmLc1natCE/iuropsWeCNUli1hMjB6KVsFLpWwdTL5PGxpt7xnKwn4keHQl6BwW7ZQ6/9pttpWpa1UQDA1wRYZVoA5jtaPu95uc+DXdTS3rJRDR6QCRV27cgRawzKgspwf82OoQXrlsCZv39FoR1t5zPT8S6iiUYbKTIg7PiD9hr1LsKoth/TA4Y6+S4tS5GE/SFDSuRZMmUn9qlUOZPR/t3XA4ys0JpsOpc92JkU89nXkEzG/0FZTyVcK9Jmbdp+B74tJvyp+UTzvSMVsH0QYLx7pTGNEClp2Rq7vpHqjKVapHSnhOWcwAvkpuWidEfrBhqWr6LjjnvRx2bikzsv0V/sNW2HXeqUT3ok9HuQ97R8Dj/S/Rgjm1n4Un7YoCT36wIH4rKDaVSXF0EkYZioZb5Li8bst78q+bpoT1CLgjjvouRO/GCVKl8oi3jCMXbvXtHlWta+oQR//JyUTmxRGM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(53546011)(7696005)(38070700005)(9686003)(296002)(921005)(41300700001)(110136005)(86362001)(316002)(71200400001)(186003)(83380400001)(54906003)(26005)(478600001)(64756008)(55016003)(66556008)(66476007)(5660300002)(33656002)(4326008)(8676002)(38100700002)(76116006)(52536014)(7416002)(66946007)(8936002)(6506007)(66446008)(122000001)(2906002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2894
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9500d98a-e0ce-40f0-95a9-08da81862631
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ruVHZvP68VItWnaNlvgAIhUNSgCdKAdJj4Yaru1OvvfiCiA7dA0w1X1BRvTEmurf8BPEMcZ0REljhyeEm4+ZQCKQa5S93BbKlyGEW/5eFXXBPiezfB4FLZJWmXLarAgEyrd/cqmUxidpE9Au2ILF4YT/YXCQN8RSjFTZPt5CeTSylsTBR3WuyhE60KRmGVsok8gMJ+kSifUjY8XhkF8X4ajW4RWNfn0GpE1fmP9bweJgdl9IV6/5qwGozc66IJEuc+HFNtzuRWFYahnA0dkHVgQoL8R0O1gVKE9yxswJkbXE8cm3VXDDBNinsSUKKyyeN+HIUa25EkZQA5lQmR39hntj9ZiCT28FIHRweJD9Ur3sl3HVwWs3h2HC3z5caRHYf5YDzuSJFBXCMcX+OOlxB+LoQYZ1L8Qyjss+XOnYunIeeOh8IY90JtJoBYnVJSan1VUQuPsd86yECCFFBwipehvPJAmyqZ7NIfrZRbeZ170xDRkNy1ZN+5KE/7cHkRB73bg9J8LspO6Da9XBpgphzUhJ5F5JX6zEXFsdN2zEV0K+qKXml8JS6aD1qJR12E6OhF8/7CGOOSxLtuuqtD9Wje6RLEYYqRM1HLKrC30HfSrz8gtZdRCR4U7Bu7pbAuNCoT43/+Uy3CkxIA3KQTLCn+a42sQ8nDIrHTL9efJbxoN1ESVRUgBuhKUsj894pOzwwNRU7el99otCqJGROh28iwDsTCkOEKYZeb8l0hHsutk8R/OL4YcmbqK90jNB7eBseGm9izAq2J83RFBPdzAkIrPaJge/Unu+U9Gzg231lk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(33656002)(9686003)(26005)(6506007)(53546011)(110136005)(54906003)(7696005)(41300700001)(8936002)(52536014)(478600001)(5660300002)(450100002)(186003)(86362001)(2906002)(82740400003)(81166007)(356005)(36860700001)(921005)(336012)(47076005)(83380400001)(40460700003)(316002)(70586007)(70206006)(4326008)(8676002)(82310400005)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 01:57:34.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80645ca5-8459-4229-9e74-08da81862f4f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3549
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
> Sent: Friday, August 19, 2022 7:57 AM
> To: Justin He <Justin.He@arm.com>; Ard Biesheuvel <ardb@kernel.org>; Len
> Brown <lenb@kernel.org>; James Morse <James.Morse@arm.com>; Tony Luck
> <tony.luck@intel.com>; Borislav Petkov <bp@alien8.de>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>; Robert
> Moore <robert.moore@intel.com>; Qiuxu Zhuo <qiuxu.zhuo@intel.com>;
> Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-edac@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki
> <rafael@kernel.org>; Shuai Xue <xueshuai@linux.alibaba.com>; Jarkko
> Sakkinen <jarkko@kernel.org>; linux-efi@vger.kernel.org; nd <nd@arm.com>
> Subject: RE: [PATCH v2 4/7] EDAC: Get chipset-specific edac drivers selec=
ted
> only when ghes_edac is not enabled
>=20
> On Wednesday, August 17, 2022 8:35 AM, Jia He wrote:
> > When ghes_edac is loaded, a regular edac driver for the CPU type /
> > platform still attempts to register itself and fails in its module_init=
 call.
> >
> > Suggested-by: Toshi Kani <toshi.kani@hpe.com>
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  drivers/edac/amd64_edac.c | 3 +++
> >  drivers/edac/pnd2_edac.c  | 3 +++
> >  drivers/edac/sb_edac.c    | 3 +++
> >  drivers/edac/skx_base.c   | 3 +++
> >  4 files changed, 12 insertions(+)
>=20
> Can you change i10nm_base.c and igen6_edac.c as well?
>=20
> They are listed in your list below.
>=20
Okay, will do. And will also include the ARM specific edac drivers just as=
=20
Borislav mentioned.


--
Cheers,
Justin (Jia He)


