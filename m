Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB995A1043
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiHYMVp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiHYMVn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 08:21:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D0B14D7;
        Thu, 25 Aug 2022 05:21:41 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ny7REcNoyVT3o0hsVxtPd5X1vlEjVXOsVHvvMgmI7KLRMHLpqg3bV+sABez5Ne+JNd0WW+MVAHQ7MV5R+Kkxudi54ckN9F9pob42qoeiC9Hgbv6xopHihbDdGQcZC1Yk4ZyuHsV3L5K2CfqN3EdLIVY2uN19t0cIsLUYUT7VpayA5hj7G1nd8h34E4bfSUIv7s+R+SOXhhJW1Dn42DAaZu3FpQiy//bhhfgE2NnufP+QH6j285Yag3zMVby6PFfyi4o7hNXCq8393IkE+SMZwZHq6zqJV/Lp0cLBU/jfdzc6aB0WB3kG1nYpfhRSVhtMS3G8zqcCxUMJDa9xH37dlA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhdpOY8HTgP70CXGAFC1R90rBM1+tjusqN76029c15Q=;
 b=M84t3xfl2YMvJh5uNr3sjJjy+RkRt6uiUne9oRICbol33qYp/RoT/YClWjROGG95mUyKPpKT0uoCHVdDTmQrCf2pkWg90S5L1JLhL0z5mMB/4V02228J1lveXHw0yeMkNwoNLQOE+Z748UW7Se93pGUv781wItxx4TYPBX0s6ffkXCRbAIwDjojnOt0ZYRbHDSRzjdhWwDoAOGj61xRRINPst3+qaXmEZTsS7ntXp7/2a7uFJnUfZ0riUeDeLXcEUCelazD2yptZNeqGl/dnkqfxE9OHoKILY3HxRUPfAJhauUGhT8etquD/pebmV1nAZMzm86iUiQRB3CAKqXnYrA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhdpOY8HTgP70CXGAFC1R90rBM1+tjusqN76029c15Q=;
 b=ctEMKEuXbV85Fiepe2OcSbpaR6VhUHHNviJ5Axb79k+jucvu0OzWDfta4dV5FIhdCyRq8JYcF2RZT+t9UVuxzMNqFhHQ9n92zYOVM3G6Ymf4k8fx2bDXkOIPNsmddFlMqGjbGi/OA0GHpBlJSWiYIr590MGp58mmpoi0gqASDBQ=
Received: from AS8P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::20)
 by HE1PR08MB2652.eurprd08.prod.outlook.com (2603:10a6:7:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:21:36 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::6d) by AS8P189CA0018.outlook.office365.com
 (2603:10a6:20b:31f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 12:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 12:21:35 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 25 Aug 2022 12:21:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38aa30ae2a202219
X-CR-MTA-TID: 64aa7808
Received: from 16fcf21f4aeb.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AA3593DA-CCD2-46BA-9718-BA985EFDDF20.1;
        Thu, 25 Aug 2022 12:21:26 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16fcf21f4aeb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 25 Aug 2022 12:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5KLgBFf1G5dwJnwi/fS9ozKS87+5BXD34dtue4UhwTX8U6+DmNdzPNl3wx2AgupcusR1lBjm/WLaLFs/+mKOV9uUyhYa30vdqHdqPzTyvvSJmdcLyNhX10xfy0s2Q+EixJuuT/WjF78O9w1e3VdaWGQIZKPjCLuHijFoAioXp7gGcMXsbRt4vgOBir4GjzYNOef9+R+BVNdpeP8D1ljuZ55lf4nI/SVZLS7Bb0T1y/h2qxuG45ja3+3QviKcKp6CyD2eygkZTjjcczeMLsHgw6iEYHrDg4nt7L0eTR8BrRe0051lvamNrZHuFyyMTbdgbbD8Wqp+UnXkcWLefkGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhdpOY8HTgP70CXGAFC1R90rBM1+tjusqN76029c15Q=;
 b=Qi2ZLz/fqaYK5mWBa8Cqs+Fxf/GBHA9DhY3WcD2scRuzHV7DES8CiXLDzowB0lE2dvbTBhtDeOvU19mW2FGAh4Vkm2QVqrUYCXhHt3htmjGu+SCpDXFVc2SmL+GNF90mxIVhy4kBWstK+kxIhGvxu0l6FduT52I5FOnl+z0Vt+6yBGwZ+prQceWCBKjtrzxFN0lalgfjCcZQzn1ibyMF+c25D4917FfG7kEIP1A+AmmcNMBRAZ3lqzLy/QlmhRg2yT9fcdfJhT7zDvsBKX2XwwTA8N0kU2QhNvC5NQ1RlYo2WrPFMMLktfJ890dUnMuRpxSTSEDO3HInlF0D/+p+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhdpOY8HTgP70CXGAFC1R90rBM1+tjusqN76029c15Q=;
 b=ctEMKEuXbV85Fiepe2OcSbpaR6VhUHHNviJ5Axb79k+jucvu0OzWDfta4dV5FIhdCyRq8JYcF2RZT+t9UVuxzMNqFhHQ9n92zYOVM3G6Ymf4k8fx2bDXkOIPNsmddFlMqGjbGi/OA0GHpBlJSWiYIr590MGp58mmpoi0gqASDBQ=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DBBPR08MB5547.eurprd08.prod.outlook.com (2603:10a6:10:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 12:21:22 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::c426:e28d:64d9:9d0f%6]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 12:21:21 +0000
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Topic: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Thread-Index: AQHYtj2x+SWiJMmOD06VJWZ+NcmSs62+MkYAgAEwhMA=
Date:   Thu, 25 Aug 2022 12:21:21 +0000
Message-ID: <DBBPR08MB45384B8C447B9B4B29D07011F7729@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com> <YwZFqHvcEzVpAxzn@zn.tnic>
In-Reply-To: <YwZFqHvcEzVpAxzn@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 25cdd0e7-2e4a-4fc0-6247-08da86945a80
x-ms-traffictypediagnostic: DBBPR08MB5547:EE_|VE1EUR03FT063:EE_|HE1PR08MB2652:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dVX2x62IN+n1hFtu7Pw5fPKyo9iMGzh23Q22qKW/CC9QuVv3x8gtGcM7Pnos40Y/pUSh0qL8d63UcnkmEtS6qQMsb6OBuNN/DEg0O7LFZ0hsgTSTAqj58kCi4QavHEDxrwyz8ZgSJLcW1hGCNRcoMtLa6lH3rcTnyQ1tM4zGM8YH6DeOQ9Ei3G6fQldZTadk6EZxVmxvgpcqeoiZnqxH4kIrlYiguaBzwStgMZqk5dUzXhFhJ6ctu2qDv6pV9zz6QnPGr+skXH12sg63LjKSi/POrGt5NcEjd1BUZJR5/lcLgyhGCokgAiEhTmxI8rWGuFnqXqWzrZzUXEgjtdLzY6KLMDn27x96Fu0QY5VHVhmTGy1SHgV3iVhc5cq3qABTDvbfCG4c+Sb8Zwm/pIgAZW1uDCfUCrGYzBLSxBcK+7eNdeOBabH+AP4JRfuCICI9pQUrlnAjwWCt0UXGZqsxQYen7eOrsO+vtWUEJM9eTMeQ25FOEBzX3zCQyNvk1nnvTVtR6tpvx6axvbogXZHaHJSftU6KEBjbYLbYPNTiL+k8aOix9dbDO2RgghmQo8zBO6KL+vomYEQ05d5qKWe3+BXUzw8nljkESj6LO0aak+ijhiie0MmFdVIAFdtg96Bfc+Z/fRTZhyyZ+5QnhQvOcgyoJXDmJxk8H1NaSfl9+DXFfVFyMvfKtX7pBrAJQdkc3nJBSQpxpsAdpkJ8ASC/a1l6/SCDrkgK6G46IXwRHKLvQNMhzmYRZW5RqXY+YAChBTyjTrA911bFXd2FhWu10Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(33656002)(83380400001)(7696005)(26005)(6506007)(186003)(2906002)(38070700005)(86362001)(38100700002)(76116006)(122000001)(478600001)(66556008)(66946007)(66446008)(55016003)(316002)(71200400001)(4326008)(41300700001)(66476007)(54906003)(9686003)(64756008)(52536014)(5660300002)(7416002)(8676002)(6916009)(8936002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5547
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e17793f-cf69-4e24-ac07-08da8694521d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlCmLmHekCTDsqDuOjP+a4k/kJAu4en7YE8FdfZsQr/Gtd3j3JKJz6r0Ny3VoVYQl1+E+aZnlBsWWnObvOXz5BeoZ+k1/x2c6OcRDK/NfVsKp99hZHSctUP0b0GW6q0eUxHXUAIh5bailTq6j6cPz0izG8D08n36ZZgIRVEhIw1F7nE25Q06SFzjjIYBoRKLoNVbj/78R59bv+EXR2jfCMNlNSFdnRj0P1k+tngOh6TooUKhnxN0+WimTasSF308ZMKCuJVUbOGQ04s/ySfBEUU+xMmSluRoKNzKJkM0HdOLzHN0ojbkcAwMWMcF6BRpGYNVV67GZYSudkkMSQ/WhJaxs4T0zTPfkURlBhMEoGbJ2OgH5Xf+Dp0j9CYeuMVtNCe38AFAq5Ay1xrzIZ2rQTmKoKqdgLrniQC5uuZK43snir4cU9MdFQQSfK2uGP/5QTlTbBnJQIM44LwI7V//EwXboOZROV8hOP63sxlHcmFg+++p+jeEoZz0IbN1aQwiM6INTqZssH9m8MXo66MZEphaGImJ+nF50PsRYtTqo8dQG4jBTNQ+vtNRas1dUfWGkn2wlZkc0WLtzLI+l4Gdp6YxeaGxjmvZJNhk8TNcVx22qtOnJsdU00GyiSBSR+5PfOFPH9R8kY8D3KWdbUnZ78R3FcBjQBoJhsA7690FZTizELuYpceujnY4P/Dgq0A77g9mOXVylLQ5QfSXV/X2PnTDcNt9lYsAnU5ka0WZR3OZUkgsvVe6Mj1ZTCFVIGCCdVNNy6prdZ+XtflSBevgkQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(40470700004)(36840700001)(46966006)(82740400003)(33656002)(7696005)(26005)(36860700001)(82310400005)(6506007)(2906002)(316002)(450100002)(70206006)(52536014)(70586007)(5660300002)(6862004)(40460700003)(356005)(86362001)(478600001)(4326008)(8676002)(8936002)(41300700001)(47076005)(83380400001)(81166007)(336012)(186003)(40480700001)(54906003)(55016003)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 12:21:35.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cdd0e7-2e4a-4fc0-6247-08da86945a80
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2652
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQm9yaXNsYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBPbiBNb24sIEF1
ZyAyMiwgMjAyMiBhdCAwMzo0MDo0MlBNICswMDAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gQ29tbWl0
IGRjNGU4YzA3ZTllMiAoIkFDUEk6IEFQRUk6IGV4cGxpY2l0IGluaXQgb2YgSEVTVCBhbmQgR0hF
UyBpbg0KPiA+IGFwY2lfaW5pdCgpIikgaW50cm9kdWNlZCBhIGJ1ZyB0aGF0IGdoZXNfZWRhY19y
ZWdpc3RlcigpIHdvdWxkIGJlDQo+ID4gaW52b2tlZCBiZWZvcmUgZWRhY19pbml0KCkuIEJlY2F1
c2UgYXQgdGhhdCB0aW1lLCB0aGUgYnVzICJlZGFjIg0KPiA+IGhhZG4ndCBiZWVuIGV2ZW4gcmVn
aXN0ZXJlZCwgdGhpcyBjcmVhdGVkIHN5c2ZzIC9kZXZpY2VzL21jMCBpbnN0ZWFkDQo+ID4gb2YN
Cj4gPiAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMvbWMvbWMwIG9uIGFuIEFtcGVyZSBlTWFnIHNl
cnZlci4NCj4gPg0KPiA+IFRvIHJlbW92ZSB0aGUgZGVwZW5kZW5jeSBvZiBnaGVzX2VkYWMgb24g
Z2hlcywgbWFrZSBpdCBhIHByb3Blcg0KPiA+IG1vZHVsZS4gVXNlIGEgbGlzdCB0byBzYXZlIHRo
ZSBwcm9iaW5nIGRldmljZXMgaW4gZ2hlc19wcm9iZSgpLCBhbmQNCj4gPiBkZWZlciB0aGUNCj4g
PiBnaGVzX2VkYWNfcmVnaXN0ZXIoKSB0byBtb2R1bGVfaW5pdCgpIG9mIHRoZSBuZXcgZ2hlc19l
ZGFjIG1vZHVsZSBieQ0KPiA+IGl0ZXJhdGluZyBvdmVyIHRoZSBkZXZpY2VzIGxpc3QuDQo+ID4N
Cj4gPiBDby1kZXZlbG9wZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gRml4ZXM6IGRjNGU4YzA3
ZTllMiAoIkFDUEk6IEFQRUk6IGV4cGxpY2l0IGluaXQgb2YgSEVTVCBhbmQgR0hFUyBpbg0KPiA+
IGFwY2lfaW5pdCgpIikNCj4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gDQo+IFdoeSBpcyB0
aGlzIG1hcmtlZCBmb3Igc3RhYmxlPw0KPiANCj4gVGhlIHByZXJlcXVpc2l0ZSBwYXRjaGVzIGFy
ZSBuZWVkZWQgdG9vLiBJIGd1ZXNzIHRoaXMgbmVlZHMgdG8gYmUNCj4gY29tbXVuaWNhdGVkIHRv
IHN0YWJsZSBmb2xrcyBzb21laG93IGJ5IGRvaW5nDQo+IA0KPiBDYzogc3RhYmxlQGtlcm5lbC5v
cmcgIyBuZWVkcyBjb21taXRzIFgsIFksIC4uLg0KPiANCj4gYnV0IEkgZ3Vlc3MgdGhlIGNvbW1p
dHRlciBuZWVkcyB0byBkbyB0aGF0IGJlY2F1c2Ugb25seSBhdCBjb21taXQgdGltZSB3aWxsIFgN
Cj4gYW5kIFkgYmUga25vd24uLi4NCj4gDQo+IFNvLCBpcyB0aGVyZSBhbnkgcGFydGljdWxhciBy
ZWFzb24gd2h5IHRoaXMgc2hvdWxkIGJlIGluIHN0YWJsZT8NCg0KT2theSwgSSBhbSBmaW5lIHdp
dGggcmVtb3ZpbmcgdGhlIHN0YWJsZSBsaW5lIGlmIGRjNGU4YzA3ZTllMiB3aWxsIG5vdCBiZSBp
bmNsdWRlZCBpbg0KYW55IHN0YWJsZSB0cmVlIGJyYW5jaC4NCg0KPiANCj4gPiBAQCAtMTQ0Miw3
ICsxNDQ5LDkgQEAgc3RhdGljIGludCBnaGVzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ID4gKmdoZXNfZGV2KQ0KPiA+DQo+ID4gIAlnaGVzX2ZpbmkoZ2hlcyk7DQo+ID4NCj4gPiAt
CWdoZXNfZWRhY191bnJlZ2lzdGVyKGdoZXMpOw0KPiA+ICsJbXV0ZXhfbG9jaygmZ2hlc19kZXZz
X211dGV4KTsNCj4gPiArCWxpc3RfZGVsX3JjdSgmZ2hlcy0+ZWxpc3QpOw0KPiANCj4gSXMgdGhh
dCBsaXN0IFJDVS1wcm90ZWN0ZWQ/DQoNCk5vLCBJIHdpbGwgcmVtb3ZlIHRoZSAicmN1IiBzdWZm
aXggc2luY2UgSSB1c2UgbGlzdF9hZGRfdGFpbC4NCiANCj4gDQo+ID4gKwltdXRleF91bmxvY2so
JmdoZXNfZGV2c19tdXRleCk7DQo+ID4NCj4gPiAgCWtmcmVlKGdoZXMpOw0KPiANCj4gLi4uDQo+
IA0KPiA+IEBAIC01NjYsMyArNTQ5LDM1IEBAIHZvaWQgZ2hlc19lZGFjX3VucmVnaXN0ZXIoc3Ry
dWN0IGdoZXMgKmdoZXMpDQo+ID4gIHVubG9jazoNCj4gPiAgCW11dGV4X3VubG9jaygmZ2hlc19y
ZWdfbXV0ZXgpOw0KPiA+ICB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBnaGVzX2Vk
YWNfaW5pdCh2b2lkKSB7DQo+ID4gKwlzdHJ1Y3QgZ2hlcyAqZywgKmdfdG1wOw0KPiA+ICsNCj4g
PiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfWDg2KSkNCj4gPiArCQlmb3JjZV9sb2FkID0gdHJ1
ZTsNCj4gDQo+IE5vLCB0aGlzIGlzIG5vdCBob3cgdGhpcyB3b3Jrcy4NCj4gDQo+ID4gKwlnaGVz
X2RldnMgPSBnaGVzX2dldF9kZXZpY2VzKGZvcmNlX2xvYWQpOw0KPiA+ICsJaWYgKCFnaGVzX2Rl
dnMpDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBZb3Ugc2ltcGx5IG5lZWQgdG8gY2hl
Y2sgZm9yY2VfbG9hZCBoZXJlLg0KPiANCg0KT2theSwgaGVuY2Ugc2hvdWxkIEkgZXhwb3J0IHRo
ZSAqZ2hlc19kZXZzKiBpbiBnaGVzPw0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkN
Cg0KDQo=
