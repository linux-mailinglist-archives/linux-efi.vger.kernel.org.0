Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49222630C4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIPmd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 11:42:33 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:65217
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730413AbgIIPlp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrH/6NKWIqWEQPwpPwuNSWlJbA+aKsUvES/mkmMYcA=;
 b=jByNQsxq3O/bDjARyYwOde1TJcjRu2SHRFDoNins5fVLDymORWy7iYOVO7x6WlHg/eVyh58KqnmkdmNi8m93vFX2eua85rcxqceuBdC8r70KCJDqUS/QRhiCea8qUyQ6CAecfaKaPAeH7uK6rrZXSTe3mbZ6ToQp+YvQ/OfpU5U=
Received: from DB6PR07CA0102.eurprd07.prod.outlook.com (2603:10a6:6:2c::16) by
 VE1PR08MB4750.eurprd08.prod.outlook.com (2603:10a6:802:a2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 9 Sep 2020 15:25:59 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::75) by DB6PR07CA0102.outlook.office365.com
 (2603:10a6:6:2c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Wed, 9 Sep 2020 15:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 15:25:59 +0000
Received: ("Tessian outbound 34b830c8a0ef:v64"); Wed, 09 Sep 2020 15:25:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a6bcfa01693a2049
X-CR-MTA-TID: 64aa7808
Received: from d5360866c24d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9015DB74-66C0-4351-A159-55DAD22CC4A4.1;
        Wed, 09 Sep 2020 15:25:43 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5360866c24d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Sep 2020 15:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fit//n6TztDj7vrJKSxPCCEdPu9e3LC+jbDGNhYb/CO5WOzteEq6ODCbPksVxZmHH01GqUOsY7rT8x8i37UAa16w50AlU6GOj7DLOZIoB+JtUwl5xfZwIi+Radszq2DxUTRamJCyPRFFtrRmgfp668/Fhb1WIPwEl8oCfnKIinO+ADFOjpLD1ggDbYUTgizIqskZ/pJWs/UuoF8o7iQKGFinIePgOpf3RK3z0T2txZClh5hvyFVHyHQH9wz59PKs2GwvcCnnmX3DhRcadA9zSdalX4YGvmSjnZWtt4/PS/5OeKYdJaIQuHkmRGRgKAMCxnKgV9kgZMs9c8HWNSVfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrH/6NKWIqWEQPwpPwuNSWlJbA+aKsUvES/mkmMYcA=;
 b=nrI394J902SR/avhW19MFz75uJwb1TsI+tB83ahgRDaGF/i1tBKZjy9x/dfVAqCFDkDZm4Gmg2/uweTCsj2KLDaQKldzB/BS+TdaqwF0GkFROoapJKR+iw/I6+p6jHMGCtOX9jlnbND/fjNOw1dlbdNb1/DYSx6aVBtSFy0/u4AjhE08PWZ5eWUg1GyFdH7ABqdSZlJluj+3ZqwR+OIIjv6ZyHufzszoVqTMzhI6AkTEKI1TqXWFaUFlGxdQ3zPNnmzuR77PAJs1kdRpG8p/4PC6qHFuTR6fIGVQLTJVO2IGw/8cP5LO013f7VWkcGUUU/ek3Csjaz+IiYjWx/b7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFrH/6NKWIqWEQPwpPwuNSWlJbA+aKsUvES/mkmMYcA=;
 b=jByNQsxq3O/bDjARyYwOde1TJcjRu2SHRFDoNins5fVLDymORWy7iYOVO7x6WlHg/eVyh58KqnmkdmNi8m93vFX2eua85rcxqceuBdC8r70KCJDqUS/QRhiCea8qUyQ6CAecfaKaPAeH7uK6rrZXSTe3mbZ6ToQp+YvQ/OfpU5U=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (2603:10a6:10:ab::15)
 by DB8PR08MB4986.eurprd08.prod.outlook.com (2603:10a6:10:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:25:40 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::2d77:cba8:3fc8:3d4f]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::2d77:cba8:3fc8:3d4f%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 15:25:40 +0000
Subject: Re: [PATCH RFC/RFT 0/3] efi/libstub: arm32: Remove dependency on
 dram_base
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>, nd <nd@arm.com>
References: <20200909151623.16153-1-ardb@kernel.org>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <5b4c9d0f-d0c1-4627-d000-3bdf093b252a@arm.com>
Date:   Wed, 9 Sep 2020 16:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200909151623.16153-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::21) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.178] (188.30.219.21) by LO2P265CA0201.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 15:25:38 +0000
X-Originating-IP: [188.30.219.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd4799af-5365-43d1-06d7-08d854d4a76f
X-MS-TrafficTypeDiagnostic: DB8PR08MB4986:|VE1PR08MB4750:
X-Microsoft-Antispam-PRVS: <VE1PR08MB47506A85E1BAFD7585F110B495260@VE1PR08MB4750.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1dxJQ0mc8mYhaPouiuLPMoeKsZpGXUyJBRnxdyH97E89PLdZhW9zK2uX15WLn7E5N5dhlvClaC1mfLiyREQfze7G50Qz+46zV1+XXOMAcv4VaskBvRCvT3RYTH2vw+q98cN3+Dkwm7FM2AUG14tCSDvuSVRo5FhdTJBiMbWw2FuhdlhKoBYAMHou8nQVa1KlQY7RsGIOYk7Mw1hHtq10VuLYXpVJunHYMRqx2kmJAE3PdyRwMj1Fix0wF6tcxSTDKJ+WLWSjTm2OFqg64dx8inDWAy2NHHxoJ89+Hogt2DQ/LN5gQ7jPKMgfipF7fTRCg1iCsret2uuoHTgBwopnBjvCtuIkdsEYQlpK4F3y7B/FVvzTY7t28CnZrvAygcRj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(316002)(2906002)(55236004)(44832011)(8676002)(52116002)(26005)(478600001)(6486002)(956004)(5660300002)(53546011)(83380400001)(31696002)(16576012)(2616005)(186003)(4326008)(54906003)(86362001)(8936002)(31686004)(36756003)(7416002)(66476007)(16526019)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9Aa5Xaj2Ldzk24jhgqx3srw2cMQAJGYqlhLdbiXEJW8w8JXzIgLKsXwDGbh6tEuBA6kU0B0uXhiD/uCG9Sw1BhIv/65aRS6kEMjEc6VJYCdcagILdDJ8zt7UGVq231N3EbiKHh8pq6xhiuaGJhcRoSUAW0P2/McWFGckEo0+p/xNOKVZMCfpx9Eh/8QIgIDlCBLil4JbLvn6ym0LnobWKCyayLEr+y4Zp5FUFhssvp30LVEGjtaqZYB8kqdcm3zdnBf3fR7cA5E9Hws1L/+0hUiPRUXMtxrM+iD2LDYM+eQx/KFM5/TbBIOWlPVPfK+OXhmVVa2pIsa2khMbuqEKfVHv8X1Qo8Gl1oP0heATevbwumwJnPgN0ZhVBjMwT3BXNL2G61Rym89VpO9DWQ/ji9YL+o/p/tEGBbuCHC7Vr3/7acz1NhkVUAkyXbYyvF5kITKqkAj1QdVd50oclqkbr1hSx90yPQlVZjMMmWnrU9dJAC/lIvvL3ZvQJ6FnXoW3oakrM9m7ke4/KnOndZFiww9xK0LIwNimsilBe140Vz5tqOn91mDlwFdpqGbAgTTIDpWb6jWgXA2XToNpMjSbPaHy556eXoUOAoiVR2KmVPrdXHRF2mmOOKGFBrNWrSm49/HKpx4E89sxUSuhO8Oyqg==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4986
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f4d31406-9afe-4ea4-cdfc-08d854d49c21
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5VJ5rkLhs8xwK9dxB9fcS46rdUz1aPR9H07R0tP/op5ScEfvkWWFag/ASO0FCdSmAfla1IzAUsgp0GQvrvplqVgZq3ovCj950SrDiGKQrwTiMQaNsLGGZiMGqGWRSJKA3RoDjXpK01tFxb+jo0fZoYtcIBmCBL4T9pNid7jnCET184YxBFgqSeY1UEz01GIg4FpEO2lDxbVNv0pXsdLjRuR7vJMITzi2wLyGRimVPrlaNquhB+N7qG/A9ZfZrA+RWcKbsOITY4SfZzwarZecvVRIRxRE2CTNlxrlBjDVuUVfg67tjppddLYhn6SXBHcW6CdfVblpjZM/xncYz8nbZ5Y8xll2in84nwTAVGL4JIbOp1s+BK6vtOTsapjWFBdtXF55Bw0H+DP2iUMTtssFPi4Y980AfE3+kdKXkUYQjLR8YhCohSfwJ3ApZ8TIW0N
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(26005)(4326008)(55236004)(6486002)(956004)(44832011)(2616005)(8936002)(47076004)(8676002)(2906002)(16576012)(36756003)(83380400001)(316002)(478600001)(16526019)(336012)(53546011)(82310400003)(82740400003)(186003)(54906003)(31686004)(70206006)(86362001)(31696002)(5660300002)(356005)(70586007)(81166007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:25:59.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4799af-5365-43d1-06d7-08d854d4a76f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4750
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 09/09/2020 16:16, Ard Biesheuvel wrote:
> Maxim reports boot failures on platforms that describe reserved memory
> regions in DT that are disjoint from system DRAM, and which are converted
> to EfiReservedMemory regions by the EFI subsystem in u-boot.
> 
> As it turns out, the whole notion of discovering the base of DRAM is
> problematic, and it would be better to simply rely on the EFI memory
> allocation routines instead, and derive the FDT and initrd allocation
> limits from the actual placement of the kernel (which is what defines
> the start of the linear region anyway)
> 
> Finally, we should be able to get rid of get_dram_base() entirely.
> However, as RISC-V only just started using it, we will need to address
> that at a later time.

Looks reasonable to me. Presumably all special cases (platform specific 
spin tables, etc) are covered as reserved in the UEFI memory map, correct?

g.

> 
> Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Francois Ozog <francois.ozog@linaro.org>
> Cc: Etienne CARRIERE <etienne.carriere@st.com>
> Cc: Takahiro Akashi <takahiro.akashi@linaro.org>
> Cc: Patrice CHOTARD <patrice.chotard@st.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Grant Likely <Grant.Likely@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Christophe Priouzeau <christophe.priouzeau@linaro.org>
> Cc: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Cc: Patrick DELAUNAY <patrick.delaunay@st.com>
> 
> Ard Biesheuvel (3):
>    efi/libstub: Export efi_low_alloc_above() to other units
>    efi/libstub: Use low allocation for the uncompressed kernel
>    efi/libstub: base FDT and initrd placement on image address not DRAM
>      base
> 
>   arch/arm/include/asm/efi.h                |   6 +-
>   arch/arm64/include/asm/efi.h              |   2 +-
>   drivers/firmware/efi/libstub/arm32-stub.c | 177 ++++----------------
>   drivers/firmware/efi/libstub/efi-stub.c   |   2 +-
>   drivers/firmware/efi/libstub/efistub.h    |   3 +
>   drivers/firmware/efi/libstub/relocate.c   |   4 +-
>   6 files changed, 47 insertions(+), 147 deletions(-)
> 
