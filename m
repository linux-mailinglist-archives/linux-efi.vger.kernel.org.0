Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AE597AF9
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiHRBWs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiHRBWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 21:22:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF909F742;
        Wed, 17 Aug 2022 18:22:44 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=m2wEQfMew4mEsWqHkcxz36TsqT35+ElwL5XmzL80j9L7uV9wrei5UZ+pP/0wacNBWUNOcjI8Biln917rZIjyAspHzTaaXR7nwe1MdoW5Bso2dD6GlHvkP/z69DJQdWFpichXmuXHUDnrjdnHtJ0WExkUW4I5CRH648Aovr96Ci+VAvER+dWeIzOo1cZ98mRsQsciVG+rEDeur/GpScrSfCsNlLhg3wtO7DmG3Vck7jOymNRimOiQRLvRYSF3g78cCxkIAGCOKh8TiKxfOGD//+2jGxfjvKhwQOAMFmxR8UvhOBnhzjGenUFb8MBj2j5r2Ool1+JK91PIqsfcUiVeZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0msyn8lZsyb/6yVuYUdekU1xOz1ohgH6zILAYkNjE44=;
 b=K5xAO38y9GoxJNi9MIsOhZdkCBp3JAfYrVI1bk2lOHxq9K1ODiOeXt1RY8tGuXGIdlrfHa7VHp0dGYW06IVreYgZN8EyyHNq0NZ30+ElYHn0zUIlM8xtNivq5/ZopbGP4fK4X3zK0EOfOTeZJNrdmmtWL23eRU+paGGsttQkzcp5+ozMyFU8qNQYuYev6g8t9JkL+zEdEBBlvQHqNv4TvjDZpSlzfyeeAGqiFMDqJQxzKUqxpGBuc5PCk2HPrFWDT43OzA67P9n2TuWYTpA9UxhfmXd9jqDMt7G3mYCJDnZwtOJKwcWu+pWqLasMJ58xDmcj1w1AfPANyEnWKTbOoQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msyn8lZsyb/6yVuYUdekU1xOz1ohgH6zILAYkNjE44=;
 b=AIlJmGByYXyUldboxZU+WxIp9umyy/bQD+4qBoXBnlm7NTGOW9sc5o8YGPL6lXtALIXXRWyDPyRypP8Tx2bhhZ14w1Hfb2l8iEV148U35pRYdjR5yjw/nLTSyaqx4D3+kL1OzZedNuMgUghucG8ira0WZHIjxM9z/troW2J368Y=
Received: from AS9PR06CA0560.eurprd06.prod.outlook.com (2603:10a6:20b:485::10)
 by PR2PR08MB4713.eurprd08.prod.outlook.com (2603:10a6:101:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 01:22:41 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:485:cafe::c9) by AS9PR06CA0560.outlook.office365.com
 (2603:10a6:20b:485::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 18 Aug 2022 01:22:41 +0000
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
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 01:22:41 +0000
Received: ("Tessian outbound 73dd6a25223d:v123"); Thu, 18 Aug 2022 01:22:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9e61bd22ad4b23e6
X-CR-MTA-TID: 64aa7808
Received: from 9518400a5498.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BFDF9770-52DD-4BD1-A17D-4D7A31BFDAF7.1;
        Thu, 18 Aug 2022 01:22:34 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9518400a5498.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 18 Aug 2022 01:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIIl2GFD/ikSNDzGnQDI5irsImADqpny5D4YHzg2eyx67jggd/ysWfm2Wi+ruhz0PBitYNbaf9JMJtpVvIXQWG495+fL8vf+5X9QeWCXh+hz5UUTvmsbMpPAGBSfjBN82WzXpsy0tCtLHZxtv/NIFPngC229Bt/nsDkPFvXsZ20nHOBAZl6xLrWDHv8IW1EBFNGeYd9eugVif5kwFP925+BUAmDJSlTw78PczEfAszd/x08qj8ugqXxAk1TB4VDvrt/SUXQeG6MsALRVuv9IqneKPVwFN/YMQb24KjTVehtR5Byatm/H1fdlKV3SqBeVzBHQqL5dkubV2BVkx28uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0msyn8lZsyb/6yVuYUdekU1xOz1ohgH6zILAYkNjE44=;
 b=gWpFjttptmFz4HGw5cq9+6vF9c1UnsGWKtrM3+jc/EZXJtPihH8XreqFXJ74bxhMzw7yQ3vLKF5F/ybXUzVzZ3/0aADR+IZ83tI1Y7WEgbOl8egAnFTrDbG24gTOtEMHtMOoGFpKyJ3Qqsip+qzx/jgHm7MY7tJUEGlBjqrAnj1cCKXTOzs0egpAHWV3fAHTjAjHr3ZBl+LX7Us1ER8j7oP5oSf87WnMNOqe6LumK0ORPSydfc8AGbt3frPCgGipiITC7toVyYi4xhkh7006RUdB4bmql1EASS2u6yR3OkIXWyQHQl5Dw9ENv06uEBj/3I7/JZIiqkDVDdZAzb5F8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0msyn8lZsyb/6yVuYUdekU1xOz1ohgH6zILAYkNjE44=;
 b=AIlJmGByYXyUldboxZU+WxIp9umyy/bQD+4qBoXBnlm7NTGOW9sc5o8YGPL6lXtALIXXRWyDPyRypP8Tx2bhhZ14w1Hfb2l8iEV148U35pRYdjR5yjw/nLTSyaqx4D3+kL1OzZedNuMgUghucG8ira0WZHIjxM9z/troW2J368Y=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 01:22:32 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::9139:c501:db7f:6d6b%3]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 01:22:32 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
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
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>, nd <nd@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Topic: [PATCH v2 6/7] apei/ghes: Use unrcu_pointer for cmpxchg
Thread-Index: AQHYskayZm+YSgQqkEuBT2OFG7dk+62zOkOAgACi+FA=
Date:   Thu, 18 Aug 2022 01:22:32 +0000
Message-ID: <DBBPR08MB45381CF65F878EF9E97EE37EF76D9@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-7-justin.he@arm.com>
 <6ca673e869c44b4690b5b6653c28ae11@AcuMS.aculab.com>
In-Reply-To: <6ca673e869c44b4690b5b6653c28ae11@AcuMS.aculab.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: c2be0644-2624-4843-9076-08da80b82538
x-ms-traffictypediagnostic: DU0PR08MB8812:EE_|VE1EUR03FT063:EE_|PR2PR08MB4713:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LOYmwuh6kjWkDYyNzKkiR+q0KiHE52ibYK6dD/9ZE2+zCLTygL8xFwN0cAniyeGU23YKpCe0b1gfAIKvemD1PQraKBjSW9xWPCtVtOg86hClW2uaAGOuvfoFEN59ekmrvSu90+r1+bM2ZJhlb6+fYIvWTzHUo9+SJjrmoMhblzyIOBvhTmBPRz43Ho6TTm204lAoEa46Pf0tk94fNyBPIVbKF4HwA2iJEmhs7vyMUS04a6mv16PMVSt/d2uZXTFdR5a7EY8awlR/8NpHZNYJGP1KsVFwv/q4QMkM/Oet/XApOUDO+AAVLQQnnwlZuZ4QfzEHl9TWSSU4EJU+65UZr1VGf0mS/z+Sc+QzwhRELhgoFYrs3h8FCfdlJ2PBdIOyIo+jYeE5VOj5cjKNHgRgTThifcz0hhDYIwb5X8YoxM+2qcPnEk1e4Nub9kI5Vh1icSbPgKuUdowSJKv+oekin5xqE0sVz8KcDki4wfFAln0ag9aPRAek9RqGzlHd/T2N1L1/XBgVsgNb7PdXUme4rBrlwKxOg69qtbzbgVYq8Rvi8PlAH9UkAKAYNGKmQLhr4MsnXEuXp/lvZRSdObehkO0s5VfL/kmqGqDj48tCwKsxdOAG+t7BW21Om2u0ARep/6pg/Q2+nh5e3H+XIIMdYFm6zXkwM7/TctqhNG2mlMNyQIIMOB4w9QmzWnrHOOozbVtNMultRDfcZudfUnkIC/RHnUBQPqrOJe72dj/UwSlvS9x+2pA68aLbK+d7lLOpfGGsEK74t05URPfHbLJEBfa9s6mkcS5/oWFcusac0H0cPGsc/u1sPt9HEEeCpNP9FqZdNpC0doj4A2BqHLun3A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(5660300002)(478600001)(921005)(7416002)(55016003)(71200400001)(316002)(110136005)(54906003)(2906002)(52536014)(66946007)(64756008)(66556008)(76116006)(8936002)(66476007)(8676002)(66446008)(4326008)(41300700001)(26005)(38070700005)(53546011)(9686003)(186003)(33656002)(86362001)(7696005)(6506007)(122000001)(83380400001)(38100700002)(17423001)(156123004);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a5d0fa53-1300-4202-82a3-08da80b81fca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gS2cOnjJv/MNOZ3VlABWMMo5UnfSVoeeGnSBdrYuAILlblD9XsWx6Jplc//lklyA3P1uCAFkbXwsPaeEuJVyQa2ppFqMiMuPisLwXAfiQLcRp5xaHA6aO+TJAYNh0Y7VaWQ0htsSxqHrhDSiyskNI5TIlet60gkE2PuUGyPlfsyE4f4lwGROtVwDaiQUig0RL0L7zWgKifygmGtMGsoUhfGjSywJxG03P4rT8FY5IupbpqQR2HVT2A84WG1PGacRrkry6gGHL77EPBgjljxSpQa29x2rg51e4XI40jtwwC6bqqyh2TMhG9yl+9ly8q/BDdUMale3IUZ1f7XDk5uXEPyYrtglpllYPIdBHiUTP6tWddW4tF/66pSYmtgeCdbre9kgJ3tksCRg10UlXxJZ1LKr1hgzGWWi4v+Awe4XUm3i6ODAACIE86EwGTAV8FBQJluEFwzboQ03P228c1nCr1wW5t70jBXm/QhukfYjJS7slhvS4nlIpgR/0uo8o0TpqIb0cREBlB5jegDUSHppFbZoPS/6q4b+PatqDidvf85W55UUmmW9aHGiTZ9sOJEbzgs0GYu29YwsHyzzL0rOlm/2yIkkdi+5SYivtIrFJj8ZNFsgAIUbMeK6Bxb+1TkCcLofWw6fJihLZZkbGO7hJvliJ7YuNN0N1wR2V/jH6gF040+xK+hY2+Od1OHF66cN+rSc+0CtreZ53miTzCFzkCXIusAZnWbPxGFXoSMoiWuht2gwLALMF0l9Q1R84RVNIRK7eDH4RDRWNT0jyiwikkYEb4Ws4SriZlzuyDZxuXhG1TfhL+ZBCCGbUeXSCtWVz5HkLtjoyP7VmIL39c3yQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(356005)(81166007)(921005)(316002)(82740400003)(82310400005)(40480700001)(55016003)(70206006)(70586007)(450100002)(8676002)(4326008)(36860700001)(53546011)(107886003)(2906002)(186003)(40460700003)(336012)(26005)(33656002)(9686003)(7696005)(6506007)(83380400001)(41300700001)(47076005)(86362001)(54906003)(478600001)(110136005)(8936002)(5660300002)(52536014)(17423001)(156123004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 01:22:41.0557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2be0644-2624-4843-9076-08da80b82538
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4713
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTcsIDIw
MjIgMTE6MzkgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBBcmQgQmll
c2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgTGVuDQo+IEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNvbT47IFRvbnkNCj4gTHVjayA8dG9ueS5s
dWNrQGludGVsLmNvbT47IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgTWF1cm8NCj4g
Q2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+OyBSb2JlcnQgUmljaHRlciA8cnJp
Y0BrZXJuZWwub3JnPjsNCj4gUm9iZXJ0IE1vb3JlIDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsg
UWl1eHUgWmh1bw0KPiA8cWl1eHUuemh1b0BpbnRlbC5jb20+OyBZYXplbiBHaGFubmFtIDx5YXpl
bi5naGFubmFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7
IGRldmVsQGFjcGljYS5vcmc7IFJhZmFlbCBKIC4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5v
cmc+OyBTaHVhaSBYdWUgPHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPjsgSmFya2tvDQo+IFNh
a2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz47IGxpbnV4LWVmaUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IHRvc2hpLmthbmlAaHBlLmNvbTsgbmQgPG5kQGFybS5jb20+OyBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiA2LzddIGFwZWkvZ2hlczog
VXNlIHVucmN1X3BvaW50ZXIgZm9yIGNtcHhjaGcNCj4gDQo+IEZyb206IEppYSBIZQ0KPiA+IFNl
bnQ6IDE3IEF1Z3VzdCAyMDIyIDE1OjM1DQo+ID4NCj4gPiBnaGVzX2VzdGF0dXNfY2FjaGVzIHNo
b3VsZCBiZSBhZGQgcmN1IGFubm90YXRpb24gdG8gYXZvaWQgc3BhcnNlDQo+IHdhcm5pbmdzLg0K
PiA+ICAgIGRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo3MzM6MjU6IHNwYXJzZTogc3BhcnNlOiBp
bmNvbXBhdGlibGUgdHlwZXMNCj4gPiBpbiBjb21wYXJpc29uIGV4cHJlc3Npb24gKGRpZmZlcmVu
dCBhZGRyZXNzIHNwYWNlcyk6DQo+ID4gICAgZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jOjczMzoy
NTogc3BhcnNlOiAgICBzdHJ1Y3QNCj4gZ2hlc19lc3RhdHVzX2NhY2hlIFtub2RlcmVmXSBfX3Jj
dSAqDQo+ID4gICAgZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jOjczMzoyNTogc3BhcnNlOiAgICBz
dHJ1Y3QNCj4gZ2hlc19lc3RhdHVzX2NhY2hlICoNCj4gPiAgICBkcml2ZXJzL2FjcGkvYXBlaS9n
aGVzLmM6ODEzOjI1OiBzcGFyc2U6IHNwYXJzZTogaW5jb21wYXRpYmxlIHR5cGVzDQo+ID4gaW4g
Y29tcGFyaXNvbiBleHByZXNzaW9uIChkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMpOg0KPiA+ICAg
IGRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYzo4MTM6MjU6IHNwYXJzZTogICAgc3RydWN0DQo+IGdo
ZXNfZXN0YXR1c19jYWNoZSBbbm9kZXJlZl0gX19yY3UgKg0KPiA+ICAgIGRyaXZlcnMvYWNwaS9h
cGVpL2doZXMuYzo4MTM6MjU6IHNwYXJzZTogICAgc3RydWN0DQo+IGdoZXNfZXN0YXR1c19jYWNo
ZSAqDQo+ID4NCj4gPiB1bnJjdV9wb2ludGVyIGlzIHRvIHN0cmlwIHRoZSBfX3JjdSBpbiBjbXB4
Y2hnLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvYWNwaS9hcGVpL2doZXMuYyB8IDcgKysrKy0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9hcGVpL2doZXMuYyBiL2RyaXZlcnMvYWNwaS9hcGVpL2do
ZXMuYyBpbmRleA0KPiA+IDkyNzJkOTYzYjU3ZC4uOTJhZTU4ZjRmN2JiIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYWNwaS9hcGVpL2doZXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hcGVp
L2doZXMuYw0KPiA+IEBAIC0xNDQsNyArMTQ0LDcgQEAgc3RydWN0IGdoZXNfdmVuZG9yX3JlY29y
ZF9lbnRyeSB7ICBzdGF0aWMgc3RydWN0DQo+ID4gZ2VuX3Bvb2wgKmdoZXNfZXN0YXR1c19wb29s
OyAgc3RhdGljIHVuc2lnbmVkIGxvbmcNCj4gPiBnaGVzX2VzdGF0dXNfcG9vbF9zaXplX3JlcXVl
c3Q7DQo+ID4NCj4gPiAtc3RhdGljIHN0cnVjdCBnaGVzX2VzdGF0dXNfY2FjaGUNCj4gPiAqZ2hl
c19lc3RhdHVzX2NhY2hlc1tHSEVTX0VTVEFUVVNfQ0FDSEVTX1NJWkVdOw0KPiA+ICtzdGF0aWMg
c3RydWN0IGdoZXNfZXN0YXR1c19jYWNoZSBfX3JjdQ0KPiA+ICsqZ2hlc19lc3RhdHVzX2NhY2hl
c1tHSEVTX0VTVEFUVVNfQ0FDSEVTX1NJWkVdOw0KPiA+ICBzdGF0aWMgYXRvbWljX3QgZ2hlc19l
c3RhdHVzX2NhY2hlX2FsbG9jZWQ7DQo+ID4NCj4gPiAgc3RhdGljIGludCBnaGVzX3BhbmljX3Rp
bWVvdXQgX19yZWFkX21vc3RseSA9IDMwOyBAQCAtODM0LDggKzgzNCw5DQo+IEBADQo+ID4gc3Rh
dGljIHZvaWQgZ2hlc19lc3RhdHVzX2NhY2hlX2FkZCgNCj4gPiAgCX0NCj4gPiAgCS8qIG5ld19j
YWNoZSBtdXN0IGJlIHB1dCBpbnRvIGFycmF5IGFmdGVyIGl0cyBjb250ZW50cyBhcmUgd3JpdHRl
biAqLw0KPiA+ICAJc21wX3dtYigpOw0KPiA+IC0JaWYgKHNsb3QgIT0gLTEgJiYgY21weGNoZyhn
aGVzX2VzdGF0dXNfY2FjaGVzICsgc2xvdCwNCj4gPiAtCQkJCSAgc2xvdF9jYWNoZSwgbmV3X2Nh
Y2hlKSA9PSBzbG90X2NhY2hlKSB7DQo+ID4gKwlpZiAoc2xvdCAhPSAtMSAmJiB1bnJjdV9wb2lu
dGVyKGNtcHhjaGcoZ2hlc19lc3RhdHVzX2NhY2hlcyArIHNsb3QsDQo+ID4gKwkJCQlSQ1VfSU5J
VElBTElaRVIoc2xvdF9jYWNoZSksDQo+ID4gKwkJCQlSQ1VfSU5JVElBTElaRVIobmV3X2NhY2hl
KSkpKSB7DQo+IA0KPiBEaWQgeW91IHRlc3QgdGhpcz8NCj4gVGhlcmUgc2VlbXMgdG8gYmUgYW4g
PT0gbWlzc2luZy4NCg0KU29ycnkgYWJvdXQgaXQsIA0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4g
KEppYSBIZSkNCg0K
