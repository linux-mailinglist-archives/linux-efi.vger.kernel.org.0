Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCA5BE390
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiITKmG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiITKln (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 06:41:43 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50043.outbound.protection.outlook.com [40.107.5.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7EA25C5
        for <linux-efi@vger.kernel.org>; Tue, 20 Sep 2022 03:40:59 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=AEeso36RXOYTvXKURjJq0EPiRYPv0HJZf+gRwXTdcCOfab8QiBzy46HugH6LRO2fKnwi0QrwNDPjLCbLq+S9Sxon7WRIZb8FZFzd41EKADbw1T8HBEF1As4gZPighzzD4KXyiNzxfvGn6WerjswI193CIHoFcIdH8OxNftNKw86YhZvALnmqujwzekyfn/ofavPvpBa9XYTzHymsIpJdd3e4JW6Jt+nw177tdn5u+Nb6vuUHVjWhpukgWrdGl0M09KLvl9vNKph0Y6CZhzlJwCriU3JdyOL+x1+n740x20nFnqbGM9doR4ZhTkva9/gBumACDSWg4sE+kMhc73yVnw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1VE4KHm5LKJpGcVCtOeOsiJCnSS6xSG0ULB8UARk1s=;
 b=Mhjwq5CDsQ3VYMXJO9vZzb48QSnu8/aCQoFzbysjiPS+ayug67eCgysB4rJTOTcs6vkYU5DpEjOEMqNCWDFASooAp/tws6DAypCkxWWT6qT6mq78/j7EGrXoSY/zQX9tQmgBTDY5Xuk0L19aoxF2PypNrRFlxDIBz8S/p8mCWyGADYK0ZgP0o61rEF7E0yZXdIzsuWVUTUexie7ZzJ4yV/gdSv5U2uk7w32WcUE8RZwYrdylu29U2azRxeJbazYYDF81041csuGU2KsW2p+GgWpLy26XKi8miARCYvC9telddC50iXAOxCokHtayE8wGeLQviKfeXfH1iX9TECFa2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1VE4KHm5LKJpGcVCtOeOsiJCnSS6xSG0ULB8UARk1s=;
 b=s+39pgOQkufgrbxX7fqC6l9xNxmCBQ307Twk9LPKNZZkL+jSA7PFiahDoLPSXtJ1NtipYuQw0whdQTXERf0O9t81jRFPwN9w0u3ed404eUbfHK3Lw0gox2hCSDfOGieiAZoHMGZVAVHusKZBSYZ2K/NLXV+84s27kRvkj5huTeE=
Received: from AM5PR0701CA0020.eurprd07.prod.outlook.com
 (2603:10a6:203:51::30) by AS8PR08MB7323.eurprd08.prod.outlook.com
 (2603:10a6:20b:442::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Tue, 20 Sep
 2022 10:40:56 +0000
Received: from AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::e1) by AM5PR0701CA0020.outlook.office365.com
 (2603:10a6:203:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 10:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT043.mail.protection.outlook.com (100.127.140.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 10:40:56 +0000
Received: ("Tessian outbound 0a0431bdcdb4:v124"); Tue, 20 Sep 2022 10:40:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8eb7809dc28f0dd0
X-CR-MTA-TID: 64aa7808
Received: from 5421c198e05f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EA07C578-4A8A-419F-BB66-D3D89975B302.1;
        Tue, 20 Sep 2022 10:40:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5421c198e05f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 20 Sep 2022 10:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSf+Ut58NyqB1ecm0I8PFsLnLZ6MwPoh05lhXtp6iHiUS9cxQ4TatiWuhaSDPnmsrI4vzSIjVzqBiC542jRP5wzahEKLlSygs6qPlelU/T79wJwhtq46G+s9mpsHAnL1nbx2icCGkuoncpYNMdjf/uBTpMma7iu3P81a82cR5FlcyoZWwtpiGcLRJaaemBYQIm7a6crRAO732jUF3gsxmZ4OaRfyURzanfpzds5wfdPTWf1py/T/d2/ZUKSbz7PMUzIigI4kp3OO23OSqIYCXAaf6CREgs9LibKV7iPOWlD1p4mAxGnjQusRKcbp0W9km2ngKiXn0h6mLj2JBHwXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1VE4KHm5LKJpGcVCtOeOsiJCnSS6xSG0ULB8UARk1s=;
 b=jEs3+j5rfpeTdxq1iajlCGH94y/7JgfjIqpvr1wFs+dWT3FVC/YgSkZpVgodl2k9MthppT8b9mMctPQkkBGPsEb9BCn6jUVXierkhJX4kjbWjv35fYpuLHF0cWVjDsr1DqVBk4+QvXRbGaCBR+od+YAYQVb/EQh6Jo9+blSo+Z5fB61qGqkhrsbYRHc3YJyuWje836Tla40+ZcoJJLuQsnB3QNXNlEY4+VheG3sf2L/XXhuAxF1v8CceQxgeBkLvCvCvZnlsoemsW8PNkVYA0fSgsitPaEN9hb8fJ67xS0SvTP4jF68jAMtIz0PeoNWg7oiBeO6SLwne+Sz/+H8RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1VE4KHm5LKJpGcVCtOeOsiJCnSS6xSG0ULB8UARk1s=;
 b=s+39pgOQkufgrbxX7fqC6l9xNxmCBQ307Twk9LPKNZZkL+jSA7PFiahDoLPSXtJ1NtipYuQw0whdQTXERf0O9t81jRFPwN9w0u3ed404eUbfHK3Lw0gox2hCSDfOGieiAZoHMGZVAVHusKZBSYZ2K/NLXV+84s27kRvkj5huTeE=
Received: from DB7PR05CA0063.eurprd05.prod.outlook.com (2603:10a6:10:2e::40)
 by GV1PR08MB7330.eurprd08.prod.outlook.com (2603:10a6:150:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 10:40:47 +0000
Received: from DBAEUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::87) by DB7PR05CA0063.outlook.office365.com
 (2603:10a6:10:2e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 10:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT048.mail.protection.outlook.com (100.127.142.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 10:40:47 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 20 Sep
 2022 10:40:47 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9 via Frontend
 Transport; Tue, 20 Sep 2022 10:40:46 +0000
Date:   Tue, 20 Sep 2022 11:40:45 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>, <nd@arm.com>
Subject: Re: [PATCH 09/12] efi: libstub: install boot-time memory map as
 config table
Message-ID: <20220920104045.GA18686@e124191.cambridge.arm.com>
References: <20220918213544.2176249-1-ardb@kernel.org>
 <20220918213544.2176249-10-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220918213544.2176249-10-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT048:EE_|GV1PR08MB7330:EE_|AM7EUR03FT043:EE_|AS8PR08MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d0adff-2bf6-49a9-778d-08da9af49988
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GlWaK+EOCB6kdqd835Ln9BOZh5hmcxl5KNkDXKKeWWYRyJJGHAvr2bCASHRbcxwC5ouUJpC6Q/zHMBb74xEKuPu68t4BY4Dl5wyYz/tvZp8UsGJKqJ5oGqvjVLKO+g6xmoj/lyQ8Y9oXmLdkcqSNvkZCbk6vIwdCmSA9swd6gjHoeEdoi1JCCSmFIimXLKO+lYEmSp2q2F6l4ROQaARbB0gwpSg1muJYlY6haeF8O4pkOpQhSl/NKPe5EhApwuu7W3uq+9C80I6viAeFaysDcOJ91CjWHYZ1e7BWBR1nSe/ApR3tJQ1o1l97+Z4EpiX6uftuBJiTXq1VrxCwy7eSINeJMzpy3zRPg/3ejptM7QFYUBbPmRuLhvDgWYiNyXTA1LHxifEXcyUloNQ+KMDkiSUR7syP6Qb/VtZ7TTa427/+JoIK5PtF3yR3AJ8I9TiK4OLCIG4JZ+ZFamc2NzWH9oqjxqyIwziuac/xu5eq6195W4fX92iBaUkH40zPqjXlTaoZ+FtKJlXvqtGOx7gSnFnh+cij3yaPzFkGK8iZi1W3872vwd2E9DdMDRr0ScxjNMBrIjBYP2rdiAupaZh2yNIvNUw3OGx2/dba5zkMZyiagUPbR58VGFmG0ZlqJ2VaA44jVryFdMCnnpem+lkerCJTR1PgY70CjpdTIjleDTKYHwvo+ncHBjS7DhkBrdPSx95mEHQCykz2kYHkT+/E4jYTZeN1DH8/91ZPGHQ5ttd9yDECR02kWEpt0mwN6Tt4Erue0pWH8IXNj0IGJQNLyuexX7LR7R62j8MEzaK14A4QOUJasci0UynU1MUOGYHx
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(6916009)(426003)(47076005)(336012)(54906003)(86362001)(83380400001)(356005)(40460700003)(36860700001)(82740400003)(7696005)(41300700001)(40480700001)(33656002)(81166007)(186003)(55016003)(26005)(478600001)(1076003)(316002)(44832011)(2906002)(5660300002)(70586007)(70206006)(8676002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7330
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0366152e-268a-4c05-a969-08da9af4943b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdwMVLcfB1yPokcidu0snsA5+mzH1jJrVKMN75Qa1QEvU9e/SNZX64SS7Matu5FGcjONJ70B3jFa8wZslUCTfOJx/oFEu08UrD9kysebU4BsbNDlmZhQXsWOp05/Y2dQe+ve/UCm/OI5SQzV2enKcqF5BUb0QbiF2xBM7hbQk4J3R3pDm5kONgPRC4SvYhdL5/j9Rr7lK5q0NpjUdLsmB6HGpECntc4BroHQ8awwOFZ8XRq1EAC90EmLrxYIwUKM42mbNssAy33tJ3oxiFTUoQxqzaYCXvTPya5+M3LFUR2bAG/Mjwb9yDXWapLOzALSvekqpS6NNwEGChM9034SmbP9n3j8ySqQtjWL4Iuf0bOc9+/IuPs1lO38qNnfDg5qDCtVThikVGL98mkPdLURGRIXid9VWHLl3Mrm/kpNXEFlJFndUji9PZHmBpShrHcxIzDi0lMfR0uTzwLyGhu+X403+MSU6RVQqCSSx1W4Me8MmMri1GR5ojHflrer3s2Wu06BDgqVfkYhD/LhE86uh5SJgK/ic+v7meeVQ6Tkzr+j21OtkJZkMTbXKWgHsuCWjYX07jZeMnKc4PZ/pOzYFEw8DNm/pXqwKh+yAZ3S6pmm7tSEPxrz71Tnpx60YyzWwqmTR163gUPoR458jjYoryIjB9M2h34+m1AC8GpTYIZ1Us65o61l7s6w+1sUbuj+F4Qh+wgocO3PrSUPrA+qGHdvOP+7foNuH+KEftX0iP9HH3rfgf07PJ12j3svovavPM0YFco1zbIZZSUphEogLQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(8936002)(6862004)(70206006)(82310400005)(8676002)(41300700001)(4326008)(70586007)(316002)(54906003)(5660300002)(2906002)(186003)(82740400003)(426003)(47076005)(7696005)(336012)(478600001)(86362001)(26005)(55016003)(1076003)(33656002)(40480700001)(83380400001)(81166007)(36860700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:40:56.4433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d0adff-2bf6-49a9-778d-08da9af49988
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7323
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Sun, Sep 18, 2022 at 11:35:41PM +0200, Ard Biesheuvel wrote:
> Expose the EFI boot time memory map to the kernel via a configuration
> table. This is arch agnostic and enables future changes that remove the
> dependency on DT on architectures that don't otherwise rely on it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
>  drivers/firmware/efi/libstub/efistub.h         |  3 ++-
>  drivers/firmware/efi/libstub/mem.c             | 26 ++++++++++++++++++--
>  drivers/firmware/efi/libstub/randomalloc.c     |  2 +-
>  drivers/firmware/efi/libstub/relocate.c        |  2 +-
>  include/linux/efi.h                            |  1 +
>  7 files changed, 31 insertions(+), 7 deletions(-)
> 
[..]
> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
> index 40721573e494..ed4c145afe11 100644
> --- a/drivers/firmware/efi/libstub/mem.c
> +++ b/drivers/firmware/efi/libstub/mem.c
> @@ -9,14 +9,20 @@
>   * efi_get_memory_map() - get memory map
>   * @map:		pointer to memory map pointer to which to assign the
>   *			newly allocated memory map
> + * @install_cfg_tbl:	whether or not to install the boot memory map as a
> + *			configuration table
>   *
>   * Retrieve the UEFI memory map. The allocated memory leaves room for
>   * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
>   *
>   * Return:	status code
>   */
> -efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
> +efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
> +				bool install_cfg_tbl)
>  {
> +	int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
> +				      : EFI_LOADER_DATA;
> +	efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
>  	struct efi_boot_memmap *m, tmp;
>  	efi_status_t status;
>  	unsigned long size;
> @@ -28,11 +34,23 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
>  		return EFI_LOAD_ERROR;
>  
>  	size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
> -	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(*m) + size,
> +	status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
>  			     (void **)&m);
>  	if (status != EFI_SUCCESS)
>  		return status;
>  
> +	if (install_cfg_tbl) {
> +		/*
> +		 * Installing a configuration table might allocate memory, and
> +		 * this may modify the memory map. This means we should install
> +		 * the configuration table first, and re-install or delete it
> +		 * as needed.
> +		 */
> +		status = efi_bs_call(install_configuration_table, &tbl_guid, m);
> +		if (status != EFI_SUCCESS)
> +			goto free_map;
> +	}
> +
>  	m->buff_size = m->map_size = size;
>  	status = efi_bs_call(get_memory_map, &m->map_size, m->map, &m->map_key,
>  			     &m->desc_size, &m->desc_ver);
> @@ -40,6 +58,10 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap **map)
>  	if (status == EFI_SUCCESS) {
>  		*map = m;
>  	} else {
> +		if (install_cfg_tbl)
> +			efi_bs_call(install_configuration_table, &tbl_guid,
> +				    NULL);
> +free_map:
>  		efi_bs_call(free_pool, m);
>  	}

You have another commit about removing goto kludges, so maybe write this like the following,
rather than a goto into an 'else' statement?

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index feef8d4be113..2f22ef7c5232 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -64,10 +64,12 @@ efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
                        *map->key_ptr = key;
                if (map->desc_ver)
                        *map->desc_ver = desc_version;
-       } else {
-               efi_bs_call(free_pool, m);
        }
 
+free_map:
+       if (status != EFI_SUCCESS)
+               efi_bs_call(free_pool, m);
+
 fail:
        *map->map = m;
        return status;

(This is a diff against next-20220920, not your branch, but you get the idea)

Thanks,
Joey
