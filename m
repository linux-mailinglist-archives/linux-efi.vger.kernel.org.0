Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77DC597B05
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 03:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiHRBYy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHRBYx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 21:24:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8137A031B;
        Wed, 17 Aug 2022 18:24:51 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=TCxMH5wCrd9vo410fFyFam3uBqY9VHC1w+fSL0Q6XyInrLynfOnzwZUjWZCp3YPGbKHWjLHUvVlDb7N57fwIs+ZuA2718DU5RPH29Sf/ce5yJqe++uSwJYFGVlIDbERzTIYaw5JAMO6zlNBzL0LUVzwqqVbIpcxKUX6/AP686ond7vh3KgyeZK+B6PQM5UHHOLLZmLMFLe0NfyomInqojA9+slBy+E3gSZZPfOz1HAHt8BMfIwWHb78SoNYjqqK0NCMrGIMEDUoNl76R7KAZTyNEhtrgVNXGj6abCq4Yp4Em03liSWE2YG1tJY7JAdwbcNO7rR/UiX+B5n26XxJeVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Euql1jYtaIJyWYKKzUapBjZstfLdidCKJy8QBv1ZE3w=;
 b=NKvbStazguPLTw6l00RlKjHAXiMF5ZYIWuO+ul9iIiclx/Shmj2Fucl6LuCe/HLVOVVKEi2roYlwlnJnKguLH2ywbE2OtmT52nCp7PdvagzG22Mn6//bShOc6B8OMJhJeMmKlygQ3KW10XNAwmzPUOy3Toj1Nkt+os5gkJXyQ39JtJOC8vpqv9hlw//q6xWFixPO4ytZL54dZtEw9LKVVe0LkeFjRs+EjAvOiojW5a2MZQZln8fsZ44v/zEd0fblJsGdrNtr6QZ8UFvtkz9G182tpFIukMbQCHEM57Su+K8pqK1OYzgxlk9XiNXrVMFSsU2PD2oo9+oeXI91K+NGNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Euql1jYtaIJyWYKKzUapBjZstfLdidCKJy8QBv1ZE3w=;
 b=FslWQi/eW7G7Nb2J9LKVInzs5ow2giqy3H2jKDdJvxTQWLxcLpE+mmv9v1w4Js+bjgJkJTZ023Bm07xM5In+pJrIcSfFdMox2oxXuBt5fIDAFtKsWPQrmVTZZB4SMUyH4ubuyFOcmL4fpWT7UVpyTqzan81zxHWU+rYgpzlus54=
Received: from AM6P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::44)
 by VE1PR08MB4783.eurprd08.prod.outlook.com (2603:10a6:802:a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 01:24:46 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::45) by AM6P191CA0031.outlook.office365.com
 (2603:10a6:209:8b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 18 Aug 2022 01:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 01:24:46 +0000
Received: ("Tessian outbound 63c09d5d38ac:v123"); Thu, 18 Aug 2022 01:24:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bc801e11caa18d58
X-CR-MTA-TID: 64aa7808
Received: from 204ebf623a1b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9A0A7915-FBAA-4C14-8158-C138C6B3B8B4.1;
        Thu, 18 Aug 2022 01:24:35 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 204ebf623a1b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Aug 2022 01:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz47ycXetEpzis3g54/kYZBBN9CNNwlyQC3kYGONxBrsFpFK9M2viZMAo4f5xTI8DZIhodWrn0O+XE9zYSRcdtyP2L+puPeCz4AjpqHAmUUwuG8gqt3GnQi6McFpSsod8ORD8D+VJG6xhnOWq7VD0EgaKjLt++ghYBWozEoJZxiM4sT7I811BbSO28nYfHmvEqVmVYkXHPDGfHt927PkaxkSW2dHjrz1s+gxYFUSA3R/4RjfJtYt7PjFUlVi7OObOsD22VnwXI1APLei/+jVYVCJ6oHXtUHqVoQ1gyAg8A50skbKZVKSrhpVjQ86Q7VlRH1bdZjH5utBQMG1QeUtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Euql1jYtaIJyWYKKzUapBjZstfLdidCKJy8QBv1ZE3w=;
 b=MsW69WgJLFx0G4L2Rku4HsslH6tQpQITu6IsDZxMSCeXMwgjiUvdGOJAvXDaRCgOwgP5z0tyEcNY6Kpzqnw4FP/pslhfawtehGkYl8Oaty+1LZB8f95hupD8gtiqugTRK03hGJM5XVQqFSYRCCWcj8czCezeln3i8AaqmfrydLmCmIFyCLIrhdP6CemU+dV6PxNX034+gKkbtjmW9s7n9Ja4hS9zX1ank36HPQw+UoEXf3DDsDwTNjrOlSZcA8BRAgC2e+LZ+rNpF3wUn43XhKvlhyyIfOhXF7pYAqSvTlZid0IS2elfPPavQ0eR6CZkw+XcjXpHdgyd475X/JWuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Euql1jYtaIJyWYKKzUapBjZstfLdidCKJy8QBv1ZE3w=;
 b=FslWQi/eW7G7Nb2J9LKVInzs5ow2giqy3H2jKDdJvxTQWLxcLpE+mmv9v1w4Js+bjgJkJTZ023Bm07xM5In+pJrIcSfFdMox2oxXuBt5fIDAFtKsWPQrmVTZZB4SMUyH4ubuyFOcmL4fpWT7UVpyTqzan81zxHWU+rYgpzlus54=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 01:24:33 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 01:24:33 +0000
From:   Justin He <Justin.He@arm.com>
To:     Borislav Petkov <bp@alien8.de>, "Kani, Toshi" <toshi.kani@hpe.com>
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
Thread-Index: AQHYrWM9z4laCnaXtkSIa72TszXQIa2rWbmAgAV2I/CAAYnDAIAAeEUAgADBnQCAAAlZAIAAA7SAgAAHBQCAAD/okA==
Date:   Thu, 18 Aug 2022 01:24:33 +0000
Message-ID: <DBBPR08MB4538258B55E51ADD2E42C9E5F76D9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-3-justin.he@arm.com> <YvZnrTrXhRn8FV3I@zn.tnic>
 <DBBPR08MB45389A9DB098F1AC14C19074F76B9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <PH7PR84MB1838203B478319EA45167BB4826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvyruNX+BUi+O3Df@zn.tnic>
 <PH7PR84MB183888AC20B37A3D891C332D826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv1V+gWICIcuNXdE@zn.tnic>
 <PH7PR84MB1838B5AE91C939D3C9D872A2826A9@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <Yv1e+Hez9ejaiHav@zn.tnic>
In-Reply-To: <Yv1e+Hez9ejaiHav@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 7f07c7b6-4b01-4b63-a060-08da80b86fe2
x-ms-traffictypediagnostic: DU0PR08MB8812:EE_|AM7EUR03FT042:EE_|VE1PR08MB4783:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NEpVU4qIREkZv8X2MUFI/PXJbBh0ZuMPtC6h0IavR3V5nK45tz7y/YIecyu7xomEhGqkNrNr/roePda/naVMhJNWOq3ofRrrFnlp7nqW9irXXIiI8zGTaYQ6HNvlvcZUe8y6Z8P8gkOaIIyQuqA11ypDzM20YxIWdskYYexntrssfAqYDRu2lkkDbdlSkq51hXPKSz24eH/l3xe7WYBYuWc52rUeQqEPckCGtwbldn4QRFmP8QN0Asf9tU/8haF3T8cbVDmVoslYqpHYLddOv7Rbfd8B1hopi7u/fyuncOfoSPT7QwfsjSlnkYsbOWSsPMqPQbHmltMSeJ7FMP8LZdX/Rsb0cnqdHeZzwnCu9zM3kERBkqgmYILQSVeCrw1t3fUdAtMux53T0KVK8C9Drn0oc+96qbWOCedQ9gwV/4bEdgDvDFgnbwbuByyYhwVUaYQv1lpcduv1S9tRKqQFkbzS2jhzj/8fTouWE+yQEoBdAl9QT6BuHZDzdWak88syjgBC5TAaVOJsoO8i63oU6tCVzDn8qVvjM7VVc0eDuPhxt/ntFvoLQybx8oiyDVZqFQa5NU3djlBwA4G4i/c/TMOavq23w7oPhGMJfHmxzrj4M4crxYDEZcqOwBMYMvxkBD1WzqMkAP9VWyXlXGCdX4oyI2/BdCjGUQBbLY/mmT0vmlqRxg0NuHO6/rA+jR8tH30LjGCHBMkr+CZdHN7SwS7W3pxKlt3DpJcjkXwAattJN74ccmAjKLOiUHmPfXxEEhdNP0xML+C1Nd/XPnGqlQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(5660300002)(478600001)(7416002)(55016003)(71200400001)(316002)(110136005)(54906003)(2906002)(52536014)(66946007)(64756008)(66556008)(76116006)(8936002)(66476007)(8676002)(66446008)(4326008)(41300700001)(26005)(38070700005)(53546011)(9686003)(186003)(33656002)(86362001)(7696005)(6506007)(122000001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f078233-b7e9-4bb6-1cac-08da80b867f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TrxezPWY/mIR1EL6HrMVIPZAJ8I3Fo7noCimdxOTDfeOTM2LnYc9Wu9B/GJcr1rgIduWpgWaa5h25nycen2pwLO/FC81RDSLIWQgDfyAVSQMqzjXixsaCD47vtojDgJ+otGfZQrIQojP9yRmggacPwdDSZNjopZ2i/bRqc9bNczuvpe+Ou1HBgfZ6czJtc78lKy5SfgUyBHg3lNmj4KaGIt0bFtnZBPjjaA5XRwNMm1Rvd/wWuus7aX358vyXpyvqhkRGtDGhMDWfDzZUf5n0PWCMO95C5/yWEePqak6wQBPs70nFJYVeTxwlx126rtXvw/OdoknDGiq758V3lVigqotH1Rp/piUymJIUwlGH5aUSmSL6okHRkTEw6Ttp69hzFW6wCHc5mqPR/IqcFtuh+4y+BIgsTjubyq8GZAcf/Jw9aEsspGMha3Qv7zTBzS/UZDWtp21A6vPEYEKvWkZo4EmD+6AzMBg0x5RrcOHd+EOi+NI761Q8DIrbi59gwJ63C/m7znKFGJn4sCc6OOopuqC3yiJtvWg5u4sQk8WaGVWFPHFsjSuEu6YFWGmTyKCgnKiIXMxV5uWwWrHA+ZO24AcORjimyZo7WYhOo5xX17jC6JXLPVNsecG0l+XTfRjER6ZsY/XDiqBd1xkS+PN6ss2QP9/RackoecOPYE5ZLpUaIaI0mx18mb/nStEYNNisUM0zQ5Ncz44y7G1Edsr9QxWpMo5iOeuPgU3rVWrdnKkFc7aT0DD8QvoyL+94X9kbfAxGIAAEC7DTveQSSIlA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(40470700004)(36840700001)(336012)(83380400001)(186003)(81166007)(356005)(47076005)(82740400003)(36860700001)(450100002)(8676002)(70586007)(70206006)(4326008)(316002)(5660300002)(2906002)(52536014)(8936002)(54906003)(7696005)(6506007)(41300700001)(53546011)(26005)(9686003)(40460700003)(110136005)(478600001)(40480700001)(86362001)(55016003)(82310400005)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:24:46.4557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07c7b6-4b01-4b63-a060-08da80b86fe2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4783
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTgsIDIwMjIgNTozNSBB
TQ0KPiBUbzogS2FuaSwgVG9zaGkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4gQ2M6IEp1c3RpbiBI
ZSA8SnVzdGluLkhlQGFybS5jb20+OyBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsg
TGVuDQo+IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VA
YXJtLmNvbT47IFRvbnkNCj4gTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IE1hdXJvIENhcnZh
bGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNA
a2VybmVsLm9yZz47IFJvYmVydCBNb29yZQ0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAYWNwaWNhLm9yZzsNCj4gUmFmYWVs
IEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFNodWFpIFh1ZQ0KPiA8eHVlc2h1YWlA
bGludXguYWxpYmFiYS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPjsN
Cj4gbGludXgtZWZpQHZnZXIua2VybmVsLm9yZzsgbmQgPG5kQGFybS5jb20+OyBzdGFibGVAa2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gRURBQy9naGVzOiBNb2R1bGFyaXpl
IGdoZXNfZWRhYyBkcml2ZXIgdG8gcmVtb3ZlDQo+IHRoZSBkZXBlbmRlbmN5IG9uIGdoZXMNCj4g
DQo+IE9uIFdlZCwgQXVnIDE3LCAyMDIyIGF0IDA5OjA5OjQxUE0gKzAwMDAsIEthbmksIFRvc2hp
IHdyb3RlOg0KPiA+IFNpbmNlIHRoZW4sIHRoZSBjaGFuZ2UgYmVsb3cgZW5hYmxlZCBnaGVzX2Vk
YWMgb24gQXJtIHdpdGhvdXQgdGhpcw0KPiA+IGtub3duLWdvb2QgcGxhdGZvcm1zIGNoZWNrLg0K
PiA+DQo+ID4gY29tbWl0IGVhYTNhMWQ0NiAoIkVEQUMsIGdoZXM6IE1ha2UgcGxhdGZvcm0tYmFz
ZWQgd2hpdGVsaXN0aW5nDQo+ID4geDg2LW9ubHkiKQ0KPiANCj4gQmFoLCBJIGhhZCBmb3Jnb3R0
ZW4gYWJvdXQgdGhhdCBvbmUuLi4NCj4gDQo+IEluIGFueSBjYXNlLCBlZGFjX21jX2FkZF9tYyog
aXMgdG9vIGxhdGUgaW4gdGhlIGluaXQgcGF0aCAtIHRoYXQgY2hlY2sgc2hvdWxkDQo+IGhhcHBl
biBhcyB0aGUgdmVyeSBmaXJzdCB0aGluZyBpbiB0aGUgZHJpdmVyIGluaXQgZnVuY3Rpb24uDQo+
IA0KPiBBbmQgbG9va2luZyBhdCB0aGUgQVJNNjQgRURBQyBkcml2ZXJzLCB0aGV5J3JlIG9ubHkg
YSBjb3VwbGU6IHRodW5kZXJ4LA0KPiB4Z2VuZSwgYmx1ZWZpZWxkLCBkbWMtNTIwLi4uIEFuZCBJ
J2Qgc3RpbGwgcHJlZmVyIGlmIHRoZWlyIG1haW50YWluZXJzIGV4cGxpY2l0bHkNCj4gQUNLIHN1
Y2ggYSBjaGFuZ2UgdG8gY2FsbCBnaGVzX2dldF9kZXZpY2VzKCkgKGZvciBhIGxhY2sgb2YgYSBi
ZXR0ZXIgaWRlYSkgYW5kDQo+IG5vdCBlbmFibGUgZ2hlc19lZGFjIG9uIHRoZW0gYmxpbmRseS4N
Ck9rYXksIHdpbGwgaW5jbHVkZSBhYm92ZSBjaGFuZ2VzIGluIG5leHQgdmVyc2lvbiwgdGhhbmtz
IGZvciB0aGUgcmVtaW5kZXIuDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
