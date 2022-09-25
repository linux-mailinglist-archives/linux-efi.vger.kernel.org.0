Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC835E93D4
	for <lists+linux-efi@lfdr.de>; Sun, 25 Sep 2022 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIYPHg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Sep 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIYPHe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Sep 2022 11:07:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA32315D;
        Sun, 25 Sep 2022 08:07:31 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dH6BpxaJnB1vCoeDe1OWwvBqpYkAu+mh8x/zS/Ne8IZGUWbuBVqVkXv2ArSMzbCR3YQdryzRKC68VKlgmDvGhNLT7LwwV5SJRUUWUlH46lB6D0nhOiyrdgIvjWc0A4/EElu5NwNFYdneYEcmiJtkmnrFUNL1T64swgx+16UC20fEnFZPkWGa1QpC8eYRWVXVpt8i+V+yWRdstkCPSSLI5G6lMx1oUdbJxUd8BxCMxIZM67n/4TzA7ILHV4wB089rZGwbJDRzcF3LnV8dDK1Sq219RQVzPr0ZEtUEJlfenMvfdiKE3wJYFLfOBz/ZLXBj+sb+Byj9dm/ONqzQgSXWew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+LZ9ssXPa3bqMmseLK3LlgrAB1ciaVXYhjda+CUZcA=;
 b=T4c7MCj4a3NEdWEr7L9jU8Ht7S6Mn8G8WxXXCIf/EpeLqg2sd/FF3jEBF9B6sJ0PsJ8iYiUEu2jXF2e5y1RsCKHruWZzNPR0suN+ibtDtd8I+64Fgh5EXy9JUZyDx7jw4kbeeM7WUyTw5vZPEOOffFRC3WlmbSmJXQelmbvuNwitGAsatFcEz+F6ap6E0WiLR+enC2Sv9zq116MWYA1FdLLySVNbYMJKY5baeRsk0QQsYtlOIlLocTlut9UX9J4MS9MCUJqLJZ70Ke74o5WO//wTwW+7maU2RiQFPbzpl7x8nmvSqSpLDa9TB1MfHZK39ow5SCGuAXl1WycP/M3VaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+LZ9ssXPa3bqMmseLK3LlgrAB1ciaVXYhjda+CUZcA=;
 b=4o/RTmmFPgs0afE55m/s13wOeyzy5oUJmYs389oGfSFkboUj+6GNgmVJqUgDXksdBy+MnYu5njRAJlFmRNSDQoiaeu1/r8gkiPk6YuaTbOe5zEi9Wh18X+ZKthnaA4B9BHbVC5usRgzxYeMuEfqfNStK2p0hT+xSIfeeGsmxmbw=
Received: from AS9PR04CA0153.eurprd04.prod.outlook.com (2603:10a6:20b:48a::27)
 by PAVPR08MB9698.eurprd08.prod.outlook.com (2603:10a6:102:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 15:07:27 +0000
Received: from AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:48a:cafe::a9) by AS9PR04CA0153.outlook.office365.com
 (2603:10a6:20b:48a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Sun, 25 Sep 2022 15:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT023.mail.protection.outlook.com (100.127.140.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Sun, 25 Sep 2022 15:07:27 +0000
Received: ("Tessian outbound 0a0431bdcdb4:v124"); Sun, 25 Sep 2022 15:07:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e23982d3044a459e
X-CR-MTA-TID: 64aa7808
Received: from a9b49519f6a5.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CA557B12-EF89-4065-AC06-285D96B25B99.1;
        Sun, 25 Sep 2022 15:07:16 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a9b49519f6a5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 25 Sep 2022 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKAMSMvBJ1GJsZBrpbfqCQD18xBZJ4pc50LZAI7OiySIUUS4tlPUMctuUg7gPblgPgv7TZENWFYfaT2QEmMMbIKUBjvVcREN5bSq/Xi2KpTUDlS3Q22KpSscePsz4ue+Yk3ZvfEfKBobkrwNwppt8CK1yEV6RSDaJU6uWmn5yOohBsUsgdkgWTlVCtEwLi7/SMZYglge04hzIvPOxnpLBvM9/mAYbuSEbjli9ksmXuMgvj6hWs+LLvh+/jX+ggqKepfVYgIDwVPlY3DUlJ1lodhWHqDW++PolqKmo0c5oUHlWkasOfdytHHYz28fFEBeslDpArgyTnuptbMAnxFGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+LZ9ssXPa3bqMmseLK3LlgrAB1ciaVXYhjda+CUZcA=;
 b=WFdtxhi7QfUPwIdqaiubTIs82pm7ed5nL5vcNS8g5t2Wwo0WXN6MSvV6/o84OvD+d2MDTdr6eCW4dl6h3DlkvguEuhm14kQWraIVl+89ODAMJ+MV/+Dp9xSA9SumQDecPdHyT8F6PxDLQv3fo6l7lqgGpf8f9+QjA3NiIinDsGmr8qC/ztWyHj4jnBO8gGuI8NwnKbciTxVDGzLiCBsuuM/sYPrEaIqu3sf7p1ECJ43m1jp61Z/F8lrNon8NtI5GC7AAI8E4zBn1zxpsR/AvoxNgpB1z08MAxwUWmOvl7+xyFXodo/JtqSFOG/uAifFXMQrRCCnTrizlo9Hv1g5TRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+LZ9ssXPa3bqMmseLK3LlgrAB1ciaVXYhjda+CUZcA=;
 b=4o/RTmmFPgs0afE55m/s13wOeyzy5oUJmYs389oGfSFkboUj+6GNgmVJqUgDXksdBy+MnYu5njRAJlFmRNSDQoiaeu1/r8gkiPk6YuaTbOe5zEi9Wh18X+ZKthnaA4B9BHbVC5usRgzxYeMuEfqfNStK2p0hT+xSIfeeGsmxmbw=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GV1PR08MB8180.eurprd08.prod.outlook.com (2603:10a6:150:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 15:07:13 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::21dc:6870:c152:e0]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::21dc:6870:c152:e0%4]) with mapi id 15.20.5654.017; Sun, 25 Sep 2022
 15:07:13 +0000
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
        nd <nd@arm.com>
Subject: RE: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Topic: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Thread-Index: AQHYxrXO8NBod7f3WkSwGy3XMHxsta3onamAgAKEmCCAAha/AIADGSxw
Date:   Sun, 25 Sep 2022 15:07:12 +0000
Message-ID: <DBBPR08MB45383B270676A17CEEC36E75F7539@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220912144005.212624-1-justin.he@arm.com>
 <20220912144005.212624-6-justin.he@arm.com> <Yyn2zYLP9So0heBW@zn.tnic>
 <DBBPR08MB4538F21BA01114A0D30485E0F74E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Yy3UGgW3RWXcxr4w@zn.tnic>
In-Reply-To: <Yy3UGgW3RWXcxr4w@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|GV1PR08MB8180:EE_|AM7EUR03FT023:EE_|PAVPR08MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 141b6df2-0ea2-4d0c-036f-08da9f07a8cf
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: H3m+Rr30OVevfNRhS/fnzwKCptOglFH4HS3UoagZpaeFtLdZRS67DKjtkfR2CFjlmc6LAGysTcV/96YfDJxuwkHK1Pop1CCdPNVs4nRrx7gXXNVMKUeSXBcu26Xom1yvmpNEFkmlhs+oxnJrH7H7/x/mLHRFANWKwoJ0wfEAE0hkZu1jDQJq7niPgjE/p3Q6abPQP70DlYQFdRVWWd9rzGA7eYTdWSylpEdfcNDjOPvuVv2w3dsptpfA/XDwyMcGuuF3AStzl2o5G5gtxrCrFe8HKBSYcYM7tGb7Ox9oVHeNXhIm8agEDJznwUcVFQ/CWZ2dbg3e+SuO8jLe6mXjO5ofo3fBBPptKYW0hY4xx98Q/lEh/PT9bMeU06gD1YUExPRGfXL9z8gKpk2+pf+vhQ2/yu5FIrpp2W+M1E5DXfq7ajaCHGRs/BIlXXskU0qxsNAM0jgFU0K7o64OzBFAbSYD+FNhoSUzmjmDsprj4Dr3P2Q55PXX2SpmTm6zoFQ7COKLLCqi7vd/WtOSQM5MeR6wB4XkEnWBFpw+PVfJXof0ohyJk/x7TafvTb28AwCOZ0hWef+/KHQ4a+jsRKZTXbAkZjyGMnFog+VcFKf7OWna1o6GN+ppvhaiaiXQYJAXuu9qM6yh+uTk7173MM2I+BB5rYpvLLlcEPtZWMASKlLyRGE//3BcIqhkbCJcOx5jEqBkwIL7VsaYvsrr172KFbT7ubT0B89A+RNgrCiXprz9laloj5JU7CDzmXf01YQfdxe/Y5M4T1yCg33Ew2ZzZA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(26005)(53546011)(9686003)(316002)(6506007)(7696005)(86362001)(83380400001)(76116006)(7416002)(66446008)(186003)(66556008)(64756008)(8676002)(4326008)(66476007)(8936002)(5660300002)(52536014)(66946007)(38100700002)(38070700005)(2906002)(478600001)(122000001)(71200400001)(54906003)(6916009)(41300700001)(33656002)(55016003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8180
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1d1e3fad-c6ab-4f5c-f576-08da9f07a050
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItrxFKdrvwBi1XrsQi3uzZobnYXzmQ1xL5eZTD6sTEatKDsrc+a0xZmQcbp9MkORQomh6tdqv5tYA2Q1VyCYxe8FG2GB6qi8ukzscMK9IskaZLVvJJZKSMRmmtbb+NY6UE4ouj3wZ4HGYwMcniJZexeTCiZq/tqP4N9bWz6RdErof76lXBbeWtKCEiUE+VYWPT4IxC7sNyP3yDwYc3fNdEACsTeVzIxjJeNAHp+EJxAku/1a63yM6nQEfVecfWdMNvyOise5d43qQiP8Vntq8zxwcZonWAmsNIyfJDYI+aDkfJ/cJ264b3OjZIJeJbD8yFYBflKJQZddDPQK99C10KLcZSWFhr5QgEHi14h6nE5Jp59PfW1Pee5wJEn/DE30wfYKu6PodnFgZl2j6Gc0CzAJj9NyJGPCuyQSZPa07K9kEkcA3ydPSCjZK25n8Q67ZLkuFwW6Y8+NFjtzKCcGBfEU+zUaUaTuPjzH7xIQuXzbCmgNeSRgURP9n51XwojESlFoaMyUy5Owv193JmHf/zgXkTU1wyGNsMLNl+QOWy5yHcANqvtyBMosgH1kwUtYFoWh5GRaL7V8ADMbx16FJY3jB+hl3h2mi3cTNZwpde3ZMRdvoqmDqP8L6eYTIuG2c+i8cE4/hFACIDogffr3hzGOwRlECfhBloZ/gui8NNZoZ3jk3d6QiH5W840gmy2+4URmhisHtn0p6RkOXThSyr+i/XV5ndgPa22oqmYEdsOZknJOHT7F/x6lwW5rZ2wV
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(47076005)(82310400005)(478600001)(356005)(81166007)(82740400003)(55016003)(40480700001)(2906002)(5660300002)(53546011)(316002)(83380400001)(54906003)(336012)(70586007)(7696005)(6506007)(36860700001)(70206006)(52536014)(86362001)(33656002)(8936002)(6862004)(9686003)(4326008)(186003)(8676002)(41300700001)(450100002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 15:07:27.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141b6df2-0ea2-4d0c-036f-08da9f07a8cf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9698
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjMs
IDIwMjIgMTE6NDMgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENj
OiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBh
cm0uY29tPjsNCj4gVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgTWF1cm8gQ2FydmFs
aG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2JlcnQgUmljaHRlciA8cnJpY0Br
ZXJuZWwub3JnPjsgUm9iZXJ0IE1vb3JlDQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgUWl1
eHUgWmh1byA8cWl1eHUuemh1b0BpbnRlbC5jb20+OyBZYXplbg0KPiBHaGFubmFtIDx5YXplbi5n
aGFubmFtQGFtZC5jb20+OyBKYW4gTHVlYmJlIDxqbHVAcGVuZ3V0cm9uaXguZGU+Ow0KPiBLaHVv
bmcgRGluaCA8a2h1b25nQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBLYW5pIFRvc2hpDQo+IDx0
b3NoaS5rYW5pQGhwZS5jb20+OyBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsNCj4g
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBSYWZhZWwg
SiAuIFd5c29ja2kNCj4gPHJhZmFlbEBrZXJuZWwub3JnPjsgU2h1YWkgWHVlIDx4dWVzaHVhaUBs
aW51eC5hbGliYWJhLmNvbT47IEphcmtrbw0KPiBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+
OyBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnOyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NiA1LzhdIEVEQUMvZ2hlczogTWFrZSBnaGVzX2VkYWMgYSBwcm9wZXIgbW9k
dWxlIHRvDQo+IHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvbiBnaGVzDQo+IA0KPiBPbiBUaHUsIFNl
cCAyMiwgMjAyMiBhdCAwODoyNjoxNkFNICswMDAwLCBKdXN0aW4gSGUgd3JvdGU6DQo+ID4gSWYg
dGhlcmUgaXMgbm8gZ2hlc19wcmVzZW50IGZsYWcuDQo+ID4gV2hhdCBpZiBnaGVzLmRpc2FibGUg
aXMgcGFzc2VkIHRvIGtlcm5lbCBib290IHBhcmFtZXRlciBhbmQgdGhlbg0KPiA+IGdoZXNfZWRh
YyBpcyBsb2FkZWQgYnkgbW9kcHJvYmU/DQo+ID4gVGh1cywgZ2hlc19lZGFjIGNhbiBiZSBsb2Fk
ZWQgZXZlbiBpZiBnaGVzIGlzIGRpc2FibGVkLiAoZ2hlc19kZXYgbGlzdA0KPiA+IGlzIG51bGwp
DQo+IA0KPiBZZXMsIGFuZCB3aGF0IGhhcHBlbnMgaWYgZ2hlc19kZXYgaXMgTlVMTD8NCj4gDQpP
a2F5LCBJIGFtIGZpbmUgaWYgaXQgaXMgYWxsb3dlZCB0byByZWdpc3RlciBnaGVzX2RldiB3aXRo
DQo+IFRoZSBvdGhlciBkcml2ZXJzIHdvdWxkIGRvIGluIHRoZWlyIGluaXQgZnVuY3Rpb246DQo+
IA0KPiAJc3RydWN0IGxpc3RfaGVhZCAqZ2hlc19kZXZzOw0KPiANCj4gCWdoZXNfZGV2cyA9IGdo
ZXNfZ2V0X2RldmljZXMoKTsNCj4gCWlmIChnaGVzX2RldnMpDQo+IAkJcmV0dXJuIC1FTk9ERVY7
DQo+IA0KPiAJLyogQ29udGludWUgaW5pdCAqLw0KPiANCj4gYW5kIHRoZW4gbG9hZCBpbiB0aGF0
IGNhc2UgYmVjYXVzZSB1c2VyIGhhcyBkaXNhYmxlZCBHSEVTIGFuZCB0aHVzIG5vDQo+IGdoZXNf
ZWRhYyBlaXRoZXIuIFNvIHRoZSBwbGF0Zm9ybS1zcGVjaWZpYyBvbmUgbG9hZHMuDQoNCk9rYXks
IEkgYW0gZmluZSB3aXRoIHJlbW92aW5nIGdoZXNfcHJlc2VudCBhbmQgZ2hlc19lZGFjX3ByZWZl
cnJlZCBpZg0KSXQgaXMgb2sgdG8gcmVnaXN0ZXIgZW1wdHkgZ2hlc19kZXYgbGlzdCB3aXRob3V0
IHByb21wdGluZyBhbiBlcnJvciANCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoN
Cg0K
